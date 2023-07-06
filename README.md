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

Create a new section in the Traefik `docker-compose.yml` file:

```
TODO: Code
```

The environment variable `PROXY_NAME`, `PROXY_LOCATION`, `PROXY_SUPPORT_MAIL` and `PROXY_SUPPORT_MESSAGE` are required and will be inserted into the template.

| Variable                | Description                                      |
| ----------------------- | ------------------------------------------------ |
| `PROXY_NAME`            | Name of the proxy.                               |
| `PROXY_LOCATION`        | Location of the proxy.                           |
| `PROXY_SUPPORT_MAIL`    | Support email address displayed to the customer. |
| `PROXY_SUPPORT_MESSAGE` | Support message displayed to the customer.       |

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

## Trace

The page has a trace string, which contains the following information as a Base64 string:

| Variable   | Description        |
| ---------- | ------------------ |
| `Router`   | Name of the proxy. |
| `Status`   | HTTP Status code.  |
| `Location` | Website address.   |

> Info: These values are created in the browser on the client side and should only give a short overview.

## Create your own page

To create your own page from scratch, [here](https://github.com/patbec/pages-base) you can find a tutorial with basic examples.

## Licence

This project is licensed under MIT - See the [LICENSE](LICENSE) file for more information.

---

&uarr; [Back to top](#)