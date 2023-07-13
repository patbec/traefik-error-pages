# Custom error pages for Traefik

This project contains customizable error pages for the Traefik reverse proxy.

![Screenshot of a 404 error page](docs/screenshot-light.png#gh-light-mode-only)
![Screenshot of a 404 error page](docs/screenshot-dark.png#gh-dark-mode-only)

## Features

A short list of what features the front-end offers.

<b>Supported device classes:</b><br>
✅ Smartphones<br>
✅ Tablets<br>
✅ Laptops<br>
✅ Desktops<br>
❌ Foldable devices<br>
❌ Handhelds<br>

<b>Supported views:</b><br>
✅ Night view<br>
✅ Day view<br>
✅ High contrast view <sup>(1)</sup>

<b>High-DPI support:</b><br>
✅ Yes - SVGs are used<br>

<b>Multilanguage:</b><br>
❌ No - English only<br>

<br>

<sup>(1)</sup>
High contrast view is for people with low vision. Activate the `forced-colors` scheme under `More Tools -> Rendering` in Chrome Dev Tools to get a preview.<br>
The colors used are determined by the browser, see at W3C CSS Color Module Level 4 - [6.2. System Colors](https://www.w3.org/TR/css-color-4/#css-system-colors).

## Usage

Here is a short tutorial on how to enable error pages for Traefik. After inserting the code section, the flow should look like this:

![Traefik errorpages flow](docs/traefik-routing-light.png#gh-light-mode-only)
![Traefik errorpages flow](docs/traefik-routing-dark.png#gh-dark-mode-only)
<p align="right">
<a href="https://doc.traefik.io/traefik/middlewares/http/errorpages/">Read the documentation on traefik.io</a>
</p>

Create a new section in the Traefik `docker-compose.yml` file:
```yaml
  error-pages:
    image: "ghcr.io/patbec/traefik-error-pages:latest"
    environment:
      PROXY_NAME: traefik
      PROXY_LOCATION: Placeholder
      PROXY_SUPPORT_MESSAGE: Placeholder
      PROXY_SUPPORT_MAIL: Placeholder
    labels:
      traefik.http.services.error-pages-service.loadbalancer.server.port: 8090

      traefik.http.middlewares.error-pages-middleware.errors.status: 400-599
      traefik.http.middlewares.error-pages-middleware.errors.service: error-pages-service
      traefik.http.middlewares.error-pages-middleware.errors.query: /{status}.html

      traefik.http.routers.error-pages-routers.rule: HostRegexp(`{host:.+}`)
      traefik.http.routers.error-pages-routers.priority: 1
      traefik.http.routers.error-pages-routers.entrypoints: web
```

In this section there are 2 types of error handling:
  - The **Middleware** handle service errors, if a web server returns an http error, the corresponding error page is displayed.
  - The **Router** handle errors that occur at a higher level, such as a subdomain was not found.

Assign the middleware to your service:
```yaml
  nginx:
    image: "nginx"
    labels:
      traefik.enable: true
      traefik.http.routers.nginx.rule: Host(`web.localhost`)
      traefik.http.routers.nginx.entrypoints: web
      traefik.http.routers.nginx.middlewares: error-pages-middleware
```

The router does not need any assignment.

Raise both types of errors:
- Request the non-existent `http://web.localhost/sample` page to display an service error.
- Request the unknown subdomain `http://sample.localhost` to get an router error.

## Example

You can find two complete examples in the `docs` folder.

The file [docker-compose.yml](docs/docker-compose.yml) contains the source from the screenshot:
```shell
cd docs
docker compose -f docker-compose.yml up
```

The file [docker-compose.dev.yml](docs/docker-compose.dev.yml) rebuilds the container and includes local changes from the template or configuration file:
```shell
cd docs
docker compose -f docker-compose.dev.yml up --build
```

## Configuration

The following environment variables are required and will be inserted into the template. Define these in your `docker-compose.yml` file.

| Variable                | Description                                      |
| ----------------------- | ------------------------------------------------ |
| `PROXY_NAME`            | Name of the proxy.                               |
| `PROXY_LOCATION`        | Location of the proxy.                           |
| `PROXY_SUPPORT_MAIL`    | Support email address displayed to the customer. |
| `PROXY_SUPPORT_MESSAGE` | Support message displayed to the customer.       |

[Here you can find a preview](https://patbec.github.io/traefik-error-pages/) of the HTML template without inserted variables.

## Pages

The following error pages are supported:

| Status code | Description                     |
| ----------- | ------------------------------- |
| `400`       | Bad Request                     |
| `401`       | Unauthorized                    |
| `403`       | Forbidden                       |
| `404`       | Not Found                       |
| `405`       | Method Not Allowed              |
| `406`       | Not Acceptable                  |
| `407`       | Proxy Authentication Required   |
| `408`       | Request Timeout                 |
| `409`       | Conflict                        |
| `410`       | Gone                            |
| `411`       | Length Required                 |
| `412`       | Precondition Failed             |
| `413`       | Payload Too Large               |
| `414`       | URI Too Long                    |
| `415`       | Unsupported Media Type          |
| `416`       | Range Not Satisfiable           |
| `417`       | Expectation Failed              |
| `418`       | I'm a teapot                    |
| `421`       | Misdirected Request             |
| `422`       | Unprocessable Entity            |
| `423`       | Locked                          |
| `424`       | Failed Dependency               |
| `425`       | Too Early                       |
| `426`       | Upgrade Required                |
| `428`       | Precondition Required           |
| `429`       | Too Many Requests               |
| `431`       | Request Header Fields Too Large |
| `451`       | Unavailable For Legal Reasons   |
| `500`       | Internal Server Error           |
| `501`       | Not Implemented                 |
| `502`       | Bad Gateway                     |
| `503`       | Service Unavailable             |
| `504`       | Gateway Timeout                 |
| `505`       | HTTP Version Not Supported      |
| `506`       | Variant Also Negotiates         |
| `507`       | Insufficient Storage            |
| `508`       | Loop Detected                   |
| `510`       | Not Extended                    |
| `511`       | Network Authentication Required |

> There are 2 different `404` error pages included, the first one is sent back when a service returns an HTTP error, the other when the reverse proxy cannot find a route.

## Trace

The page has a trace string, which contains the following information as a Base64 string:

| Variable   | Description        |
| ---------- | ------------------ |
| `Router`   | Name of the proxy. |
| `Status`   | HTTP Status code.  |
| `Location` | Website address.   |

> Note: These values are created in the browser on the client side and should only give a short overview.

## Create your own page

To create your own page from scratch, [here](https://github.com/patbec/pages-base) you can find a tutorial with basic examples.

## Licence

This project is licensed under MIT - See the [LICENSE](LICENSE) file for more information.

---

&uarr; [Back to top](#)