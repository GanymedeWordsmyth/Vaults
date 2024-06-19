# HTTP Fundamentals
## HyperText Transfer Protocol (HTTP)
[HTTP](https://tools.ietf.org/html/rfc2616) is an application-level protocol used to access the World Wide Web resources. The term `hypertext` stands for text containing links to other resources and text that the readers can easily interpret.

http communication consists of a client and a server, where the client requests the server for a resource, the server the processes the request, and finally returns the requested resource to the client. The default port for http communication is port `80`, though this can be changed to any other port, depending on the web server configuration. The same requests are utilized when we use the internet to visit different websites. We enter a `Fully Qualified Domain Name` (`FQDN`) as a `Uniform Resource Locator` (`URL`) to reach the desired website.

### URL
Resources over http are accessed via a `url`, which offers many more specifications than simply specifying a website we want to visit. The full structure of a url is as follows:
![[url_structure.webp]]
Here is what each component stands for:

| Component    | Example             | Description                                                                                                                                                             |
| ------------ | ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Scheme       | http://<br>https:// | This is used to identify the protocol being accessed by the client, and ends with a colon and a double slash (`://`)                                                    |
| User Info    | admin:password@     | This is an optional component that contains the credentials (separated by a colon) used to authenticate to the host, and is separated from the host with an at sign     |
| Host         | inlanefreight.com   | The host signifies the resource location. This can be a hostname or an IP address                                                                                       |
| Port         | :80                 | The `Port` is separated from the `Host` by a colon. If no port is specified, `http` schemes default to port 80 and `https` to `443`                                     |
| Path         | /dashboard.php      | This points to the resource being accessed, which can be a file or a folder. If there is no path specified, the server returns the default index (e.g. `index.html`)    |
| Query String | ?Login=true         | The query string starts with a question mark, and consists of a parameter (e.g. `login`) and a value (e.g.`true`). Multiple parameters can be separated by an ampersand |
| Fragments    | #status             | Fragments are processed by the browsers on the client-side to locate sections within the primary resource (e.g. a header or section on the page)                        |
Not all components are require to access a resource. The main mandatory fields are the scheme and the host, without which the request would have no resource to request.

### HTTP Flow
![[HTTP_Flow.webp]]
This diagram present the anatomy of an http request at a very high level. The first time a user enters the url (inlanefreight.com) into the browser, it sends a request to a `Domain Name Resolution` (`DNS`) server to resolve the domain and get its IP. The `DNS` server looks up the IP address for `inlanefreight.com` and returns it All domain names need to be resolved this way, as a server can't communicate without an IP address.

>[!Note:]
>Our browsers usually first look up records in the local `'/etc/hosts/'` file, and if the requested domain does not exist within it, then they would other DNS servers. We can use the `'/etc/hosts'` to manually add records to for DNS resolution, by adding the IP followed by the domain name.

Once the browser gets the IP address linked to the requested domain, it sends a GET request to the default http port (e.g. `80`), asking for the root `/` path. Then, the web server receives the request and processes it. By default, server are configured to return an index file when a request for `/` is received.

In this case, the contents of `index.html` are read and returned by the web server as an http response. The response also contains the status code (e.g. `200 OK`), which indicates that the request was successfully processed. The web browser then renders the `index.html` contents and presents it to the user.

>[!Note:]
>This module is mainly focused on http web requests. For more on HTML and web applications, refer to the [Introduction to Web Applications](https://academy.hackthebox.com/module/details/75) Module
### cURL
This module will show how to send web requests through two of the most important tools for any web pentester: a Web Browser, and the `cURL` cmd line tool.

[cURL](https://curl.haxx.se/) (client URL) is a cmd-line tool and library that primarily supports HTTP along w many other protocols. This makes it a good candidate for scripts as well as automation, making it essential for sending various types of web requests from the cmd line, which is necessary for many types of web pentests.

The `$ curl <website>` cmd is used to send a basic HTTP request to any URL by using it as an arg for cURL. cURL does not render the HTML/JS/CSS code, unlike a web browser, but prints it in its raw format. However, pentesters are mainly interested in the request and response context, which usually becomes much faster and more convenient than a web browser.

cURL can also be used to download a page or a file and output the content into a file using the `-O` flag. To specify the name of the output file, use the `-o` flag. W/o a specified name, cURL will use whatever the website called the file that is being downloaded. To silence the status that displays while downloading the desired file, use the `-s` flag. Finally, use the `-h` flag to see what other options are avail when using cURL, `--help all` to display a more detailed help menu, or `--help <category>` or `-h <category>` (e.g. `-h http`) to print a more detailed help menu of a specific flag. And of course, `man curl` can be used to view the full cURL manual page.

The upcoming sections will cover most of the above flags and how to use each of them.
## HyperText Transfer Protocol Secure (HTTPS)
A significant drawback of HTTP is that all data is transferred in clear-text, meaning that anyone b/w the source and dest can perform a Man-in-the-Middle (MitM) atk to view the transferred data.

To counter this issue, the [HTTPS (HTTP Secure) protocol](https://tools.ietf.org/html/rfc2660) was created, in which all comms are transferred in an enc format, so even if a third party does intercept the request, they would not be able to extract the data out of it. For this reason, HTTPS has become the mainstream scheme for websites on the internet, and HTTP is being phased out, and soon most web browsers will not allow visiting HTTP websites.
### HTTPS Overview
Examining an HTTP request, note that the effect of not enforcing secure comms b/w a web browser and a web app. As an example, the following is the conent of an HTTP login request:![[Pasted image 20240606141559.png]]The login creds can be viewed in clear-text, making it easy for someone on the same network (such as a publlic wireless network) to capture the request and reuse the creds for malicious purposes.

In contrast, when someone intercepts and analyzes traff from an HTTPS request, they would see something like the following:![[Pasted image 20240606141740.png]]The data, in this case, is transferred as a single enc stream, making it v diff for anyone to capture info such as creds or any other sensitive data.

Websites that enforce HTTPS can be ID'd through the `https://` in the URL, as opposed to `http://`, and by the lock icon in the addr bar of the web browser to the left of the URL:![[Pasted image 20240606141939.png]]So, visiting a website that utilizes HTTPS, all traff would be encrypted.
> [!Note]
> Although the data transferred through the HTTPS protocol may be enc, the request may still reveal the visited URL if it contacted a clear-text DNS server. For this reason, it is recommended to utilize enc DNS servers (e.g. 8.8.8.8 or 1.1.1.1), or a VPN service to ensure all traff is properly enc.
### HTTPS Flow
This followinng image demonstrates how HTTPS operates at a high level:![[Pasted image 20240606142311.png]]Typing in `http://` instead of `https://` to visit a website that enforces HTTPS, the browser attempts to resolve the domain and redirects the user to the webserver hosting the target website. A request is sent to port `80` first, which is the unenc HTTP protocol. The server detects this and redirects the client to secure HTTPS port `443` instead. This is down via the `301 Moved Permanently` response code (which will be discussed in later sections).

Next, the client (web browser) sends a "client hello" packet, giving info about itself and the server replies w "server hello." This is followed by a [key exchange](https://en.wikipedia.org/wiki/Key_exchange) to exchange SSL certs. The client verifies the key/cert and sends one of its own. After this, an enc [handshake](https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake) is initiated to confirm whether the enc and transfer are working correctly.

Once the handshake completes successfully, normal HTTP comms is continued, which is enc after that. This is a very high-level overview of the key exchange, which is beyond this module's scope.
>[!Note]
>Depending on the circumstances, an atkr may be able to perform an HTTP downgrade atk, which downgrades HTTPS comms to HTTP, making the data transfer in clear-text. This is done by setting up a Man-in-the-Middle proxy to transfer all traff through the ark's host w/o the user's knowledge. However, most modern browsers, servers, and web apps protect against this atk.
### cURL for HTTPS
cURL should automatically handle all HTTPS comms stds and perform a secure handshake and then enc and decrypt data automatically. However, if a website w either an invalid SSL cert or an outdated one is contacted, then cURL by default would not process w the comms to protect against the earlier mentioned MitM atks:
```shell
$ curl https://inlanefreight.com

curl: (60) SSL certificate problem: Invalid certificate chain
More details here: https://curl.haxx.se/docs/sslcerts.html
...SNIP...
```
Modern web browsers would do the same, warning the user against visiting a website w an invalid SSL cert. In the event that it is still desirable to cURL a website like this, use the `-k` flag to skip the cert check.
## HTTP Requests and Responses
HTTP comms mainly consist of an HTTP request and an HTTP response. An HTTP request is made by the client (e.g. cURL/browser), and is proc'd by the server (e.g. web server). The requests contain all of the details req'd from the server, including the resource (e.g. URL, path, parameters), any request data, specified headers or options, and many other options that will be discussed throughout this module.

Once the server recv the HTTP request, it proc's it and responds by sending the HTTP response, which contains the responds code, as discussed in a later section, and may contain the resource data if the requester has access to it.
### HTTP Request
The following demonstrates an example of an HTTP request:![[Pasted image 20240607184242.png]]The image shows an HTTP GET request to the URL:
- `http://inlanefreight.com/users/login.html`
The first line of any HTTP request contains three main fields `separated by spaces`:

|**Field**|**Example**|**Description**|
|---|---|---|
|`Method`|`GET`|The HTTP method or verb, which specifies the type of action to perform.|
|`Path`|`/users/login.html`|The path to the resource being accessed. This field can also be suffixed with a query string (e.g. `?username=user`).|
|`Version`|`HTTP/1.1`|The third and final field is used to denote the HTTP version.|
The next set of lines contain HTTP header value pairs, like `Host`, `User-Agent`, `Cookie`, and many other possible headers. These headers are used to specify various attributes of a request. The headers are terminated w a new line, which is necessary for the server to validate the request. Finally, a request may end w the request body and data.
> [!Note]
> HTTP v1.x sends requests as clear-text, and uses a new-line char to separate diff fields and diff requests. HTTP v2.x, on the other hand, sends requests as bin data in a dict form.

### HTTP Response
Once the server proc's the request, it sends its response. The following is an example HTTP response:![[Pasted image 20240607185817.png]]The first line of an HTTP response contains two fields separated by spaces. The first being the `HTTP version` (e.g. `HTTP/1.1`), and the second denotes the `HTTP response code` (e.g. `200 OK`).

Response codes are used to determine the request's status, as will be discussed in a later section. After the first line, the response lists its headers, similar to an HTTP request. Both the request and response headers are discussed in the next section.

Finally, the response may end w a response body, which is separated by a new line after the headers. The response body is usually def'd as `HTML` code. However, it can also respond w other code types, such as `JSON`, wesite resources, such as images, style sheets or scripts, or even a doc, such as a PDF doc hosted on the webserver.
### cURL
Earlier examples w cURL only specified the URL and got the response body in return. However, cURL also allows users to preview the full HTTP request and the full HTTP response, which can become v handy when performing web pentests or writing exploits. Use the `-v` flag to perform the cmd verbosely and view the full HTTP request and response:
```shell
$ curl inlanefreight.com -v

*   Trying SERVER_IP:80...
* TCP_NODELAY set
* Connected to inlanefreight.com (SERVER_IP) port 80 (#0)
> GET / HTTP/1.1
> Host: inlanefreight.com
> User-Agent: curl/7.65.3
> Accept: */*
> Connection: close
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 401 Unauthorized
< Date: Tue, 21 Jul 2020 05:20:15 GMT
< Server: Apache/X.Y.ZZ (Ubuntu)
< WWW-Authenticate: Basic realm="Restricted Content"
< Content-Length: 464
< Content-Type: text/html; charset=iso-8859-1
< 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>

...SNIP...
```
Notice this time, cURL outputs the full HTTP request and response. The request simply sent a `GET / HTTP/1.1` along w the `Host`, `User-Agent`, and `Accept` headers. In return, the HTTP response contained the `HTTP/1.1 401 Unauthorized`, which indicated that access is denied o/ the requested resource, as will be discussed later. Similar to the request, the response also contained several headers sent by the server, including `Date`, `Content-Length`, and `Content-Type`. Finally, the response contained the response body in HTML, which is the same one recv'd earlier when using cURL w/o the `-v` flag.
>[!Exercise:]
>The `-vvv` flag shows an even more detailed verbose output. Try to use this flag to see what extra request and response details get displayed w it.
### Browser DevTools
Most modern web browsers come w built-in dev tools (`DevTools`), which are mainly intended for devs to test their web apps. However, as web pentesters, these tools can be a vital asset in any web assessment, as a browser (and its DevTools) is among the assets most likely to be present in every web assessment exercise. This module will also discuss how to util some of the basic browser devtools to assess and monitor diff types of web requests.

Whenever any website is visited or any web app is accessed, the browser sends multiple web requests and handles multiple HTTP responses to render the final view that is seen in the browser window. Use either [`CTRL+SHIFT+I`] or [`F12`] to open the browser devtools in either Chrome or Firefox, which contain multiple tabs, each of which has its own use. This module will mostly be focusing on the `Network` tab, as it is responsible for web requests, which would look similar to the following:![[Pasted image 20240608141547.png]]This image demonstrates how the devtools shows at a glance the response status (i.e. response code), the response method used (`GET`), the requested resource (i.e. URL/domain), alond w the requested path. Furthermore, `Filter URLs` can be used to search for a specific request, in case the website loads too many to go through.
>[!Exercise:]
>Try clicking on any of the requests to view their details. You can then click on the `Response` tab to view the response body, and then click on the `Raw` button to view the raw (unrendered) source code of the response body.
## HTTP Headers
HTTP headers pass info b/w the client and the server. Some headers are only used w either requests or responses, while some other general headers are common to both.

Headers can have one or multiple vals, appended after the header name and separated by a colon. These headers can be divided into the following categories:
- `General Headers`
- `Entity Headers`
- `Request Headers`
- `Response Headers`
- `Security Headers`
### General Headers
[General Headers](https://www.w3.org/Protocols/rfc2616/rfc2616-sec4.html) are used in both HTTP requests and responses. They are contextual and are used to `describe the msg rather than its contents`.

| **Header**   | **Example**                           | **Description**                                                                                                                                                                                                                                                                                                                                                                        |
| ------------ | ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Date`       | `Date: Wed, 16 Feb 2022 10:38:44 GMT` | Holds the date and time at which the msg originated. It's preferred to convert the time to the std [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) time zone.                                                                                                                                                                                                          |
| `Connection` | `Connection: close`                   | Dictates if the current network connection should stay alive after the request finishes. Two commonly used vals for this header are `close` and `keep-alive`. The `close` val from either the client or the server means that they would like to terminate the connection, while the `keep-alive` header indicates that the connection should remain open to recv more data and input. |
### Entity Headers
Similar to general headers, [Entity Headers](https://www.w3.org/Protocols/rfc2616/rfc2616-sec7.html) can be `common to both the request and the response`. These headers are used to `describe the content` (entity) transferred by a msg. They are usually found in responses and `POST` or `PUT` requests.

| **Header**         | **Example**                   | **Description**                                                                                                                                                                                                                                        |
| ------------------ | ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Content-Type`     | `Content-Type: text/html`     | Used to desc the type of resource being transferred. The val is auto-added by the browsers on the client-side and returned in the server response. The `charset` field denotes the encoding std, such as [UTF-8](https://en.wikipedia.org/wiki/UTF-8). |
| `Media-Type`       | `Media-Type: application/pdf` | The `Media-Type` is similar to `Content-Type`, and desc's the data being transferred. This header can play a crucial role in making the server interpret client input. The `charset` field may also be used w the header.                              |
| `Boundary`         | `boundary="b4e4fbd93540"`     | Acts as a marker to separate content when there is more than one in the same msg. e.g. this boundary gets used as `"--b4e4fbd93540"` to separate diff parts of the form                                                                                |
| `Content-Length`   | `Content-Length: 385`         | Holds the size of the entity being passed. This header is necessary as the server uses it the read data from the msg body, and is auto-gen'd by the browser and tools like cURL                                                                        |
| `Content-Encoding` | `Content-Encoding: gzip`      | Data can undergo multiple transformations before being passed e.g. large amts of data can be compressed to reduce the msg size. The type of encoding being used should be specified using the `Content-Encoding` header.                               |
### Request Headers
The client sends [Request Headers](https://tools.ietf.org/html/rfc2616) in an HTTP transaction. These headers are `used in an HTTP request and do not relate to the content` of the msg. The following headers are commonly seen in HTTP requests:

| **Header**      | **Example**                              | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| --------------- | ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Host`          | `Host: www.inlanefreight.com`            | Used to specify the host being queried for the resource. This can be a domain name or an IP addr. HTTP servers can be conf'd to host diff websites, which are revealed based on the hostname. This makes the host header an important enum target, as it can indicate the existence of other hosts on the target server                                                                                                                                        |
| `User-Agent`    | `User-Agent: curl/7.77.0`                | The `User-Agent` header is used to desc the client requesting resources. This heads can reveal a lot about the client, such as the browser, its v, and the OS.                                                                                                                                                                                                                                                                                                 |
| `Referer`       | `Referer: http://www.inlanefreight.com/` | Denotes where the current request is coming from e.g. clicking a link from Google search results would make `https://google.com` the referer. Trusting this header can be dangerous as it can be easily manipulated, leading to unintended consequences.                                                                                                                                                                                                       |
| `Accept`        | `Accept: */*`                            | The `Accept` header desc's which media types the client can understand. It can contain multiple media types separated by commas. The `*/*` val signifies that all media types are accepted                                                                                                                                                                                                                                                                     |
| `Cookie`        | `Cookie: PHPSESSID=b4e4fbd93540`         | Contains cookie-val pairs in the format `name=value`. A [cookie](https://en.wikipedia.org/wiki/HTTP_cookie) is a piece of data stored on the client-side and on the server, which acts as an identifier. These are passed to the server per request, thus maintaining the client's access. Cookies can also server other purposes, such as saving user pref's or session tracking. There can be multiple cookies in a single header separated by a semi-colon. |
| `Authorization` | `Authorization: BASIC cGFzc3dvcmQK`      | Another method for the server to ID clients. After successful auth, the server returns a token unique to the client. Unlike cookies, tokens are stored only on the client-side and retrieved by the server per request. There are multiple types of auth type based on the webserver and app type used.                                                                                                                                                        |

A complete list of request headers and their usage can be found [here](https://tools.ietf.org/html/rfc7231#section-5).
### Response Headers
[Response Headers](https://tools.ietf.org/html/rfc7231#section-6) can be `used in an HTTP response and do not relate to the content`. Certain response headers such as `Age`, `Location`, and `Server` are used to provide more context about the response. The following headers are commonly seen in HTTP responses:

| **Header**         | **Example**                                  | **Description**                                                                                                                                                               |
| ------------------ | -------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Server`           | `Server: Apache/2.2.14 (Win32)`              | Contains info about the HTTP server, which proc'd the request. It can be used to gain info about the server, such as its version, and enum it further.                        |
| `Set-Cookie`       | `Set-Cookie: PHPSESSID=b4e4fbd93540`         | Contains the cookies needed for client ID. Browsers parse the cookies and store them for future requests. This header follows the same format as the `Cookie` request header. |
| `WWW-Authenticate` | `WWW-Authenticatie: BASIC realm="localhost"` | Notifies the client about the type of auth req'd to access the requested resource.                                                                                            |
### Security Headers
And finally, w the inc in the variety of browsers and web-based atks, it was necessary to def [Security Headers](https://owasp.org/www-project-secure-headers/) to enhance sec. HTTP Security Headers are a `class of response headers used to specify certain rules and policies` to be followed by the browser while accessing the website:

| **Header**                  | **Example**                                   | **Description**                                                                                                                                                                                                                                                                                                            |
| --------------------------- | --------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Content-Security-Policy`   | `Content-Security-Policy: script-src 'self'`  | Dictates the website's policy towards externally inj resources. This could be JS code as well as script resources. This header instructs the browser to accept resources only from certain trusted domains, hence preventing atks such as [Cross-site scripting (XSS)](https://en.wikipedia.org/wiki/Cross-site_scripting) |
| `Strict-Transport-Security` | `Strict-Transport-Security: max age=31536000` | Prevents the browser from accessing the website o/ the plaintext HTTP protocol, and forces all comms to be carried o/ the secure HTTPS protocol. This prevents atkrs from sniffing web traff and accessing prot'd info such as passwds or other sensitive data.                                                            |
| `Referrer-Policy`           | `Referrer-Policy: origin`                     | Dictates whether the browser should include the val specified via the `Referrer` header. It can help in avoiding disclosing sensitive URLs and info while browsing the website.                                                                                                                                            |
>[!Note]
>This section only mentions a small subset of commonly seen HTTP headers. There are many other contextual headers that can be used in HTTP comms. It's also possible for apps to def custom headers based on their requirements. A complete list of std HTTP headers can be found [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers).
### cURL
The previous section demonstrated how using the `-v` flag w cURL shows full details of the HTTP request and response. Building on that, the `-I` flag tells cURL to send a `HEAD` request and only display the response headers and the `-i` flag displays both the headers and the response body (i.e. HTML code). The diff b/w the two is that `-I` sends a `HEAD` request while `-i` sense any request that is specified and prints the headers as well.

The following cmd shows an example output of using the `-I` flag:
```shell
$ curl -I https://www.inlanefreight.com

Host: www.inlanefreight.com
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/605.1.15 (KHTML, like Gecko)
Cookie: cookie1=298zf09hf012fh2; cookie2=u32t4o3tb3gg4
Accept: text/plain
Referer: https://www.inlanefreight.com/
Authorization: BASIC cGFzc3dvcmQK

Date: Sun, 06 Aug 2020 08:49:37 GMT
Connection: keep-alive
Content-Length: 26012
Content-Type: text/html; charset=ISO-8859-4
Content-Encoding: gzip
Server: Apache/2.2.14 (Win32)
Set-Cookie: name1=value1,name2=value2; Expires=Wed, 09 Jun 2021 10:18:14 GMT
WWW-Authenticate: BASIC realm="localhost"
Content-Security-Policy: script-src 'self'
Strict-Transport-Security: max-age=31536000
Referrer-Policy: origin
```
*Exercise: Go through and identify each header of the above output and recall the usage for each of them.*
In addition to viewing headers, cURL allows users to set request headers w the `-H` flag. Some headers, like the `User-Agent` or `Cookie` headers, have their own flags. For example, the `-A` flag tells cURL to set the `User-Agent`.
### Browser DevTools
To preview the HTTP headers using the browser devtools, click on the `Network` tab, just as in the previous section, and view diff requests made by the page. Click on any of these requests to view its details.![[Pasted image 20240610134308.png]]The first `Headers` tab shows both the HTTP request and HTTP response headers. The devtools auto arranges the headers into sections, but clicking on the `Raw` button displays their details in their raw format. 
# HTTP Methods
## HTTP Methods and Codes
HTTP supports multiple methods for accessing a resource. In the HTTP protocol, several request methods allow the browser to sent info, forms, or files to the server. These methods are used, among other things, to tell the server how to proc the request the is sent and how to reply.

W cURL, using the `-v` to preview the full request, the first line contains the HTTP method (e.g. `GET / HTTP/1.1`), while w browser devtools, the HTTP method is shown in the `Method` column. Furthermore, the response headers also contain the HTTP response code, which states the status of proc'ing the HTTP request.
### Request Methods
The following are some of the commonly user methods:

| **Method** | **Description**                                                                                                                                                                                                                                                                                                     |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Get`      | Requests a specific resource. Additionaly data can be passed to the server via query str's in the URL (e.g. `?param=value`)                                                                                                                                                                                         |
| `POST`     | Sends data to the server. It can handle mutliple types of input, such as text, PDFs, and other forms of bin data. This data is appended in the request body present after the headers. The POST method is commonly used when sending info (e.g. forms/logins) or uploading data to a website, such as imgs or docs. |
| `HEAD`     | Requests the headers that would be returned if a GET request was made to the server. It doesn't return the request body and is usually made to check the response length before downloading resources.                                                                                                              |
| `PUT`      | Creates new resources on the server. Allowing this method w/o proper ctrls can lead to uploading malicious resources.                                                                                                                                                                                               |
| `DELETE`   | Deletes an existing resource on the webserver. If not properly sec'd, can lead to Denial of Service (DoS) by deleting crit files on the webserver.                                                                                                                                                                  |
| `OPTIONS`  | Returns info about the server, such as the methods accepted by it.                                                                                                                                                                                                                                                  |
| `PATCH`    | Applies partial mods to the resource at the specified location                                                                                                                                                                                                                                                      |
This list only highlights a few of the most commonly used HTTP methods. The avail of a particular method depends on the server as well as the app conf. A full list of HTTP methods can be viewed [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods).
>[!Note]
>Most modern web apps mainly rely on the `GET` and `POST` methods. However, any web app that util's `REST APIs` also rely on `PUT` and `DELETE`, which are used to update and delete data on the API endpoint, respectively. Refer to the [[Intro to Web Apps]] module for more details.
## Response Codes
HTTP status codes are used to tell the client the status of their request. An HTTP server can return five types of response codes:

| **Type** | **Description**                                                                                                         |
| -------- | ----------------------------------------------------------------------------------------------------------------------- |
| `1xx`    | Provides info and does not affect the proc'ing of the request                                                           |
| `2xx`    | Returned when a request secceeds                                                                                        |
| `3xx`    | Returned when the server redirects the client                                                                           |
| `4xx`    | Signifies improper requests `from the client`, e.g. requesting a resource that doesn't exist or requesting a bad format |
| `5xx`    | Returned when there is some problem `with the HTTP server` itself.                                                      |
The following are some of the commonly seen examples from each of the above HTTP method types:

| **Code**                    | **Description**                                                                                                                                          |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `200 OK`                    | Returned on a successful request, and the response body usually contains the requested resource                                                          |
| `302 Found`                 | Redirects the client to another URL, e.g. redirecting the user to their dashboard after a successful login                                               |
| `400 Bad Request`           | Returned on encountering malformed requests such as requests w missing line terminators                                                                  |
| `403 Forbidden`             | Signifies that the client doesn't have appropriate access to the resource. It can also be returned when the server detects malicious input from the user |
| `404 Not Found`             | Returned when the client requests a resource that doesn't exist on the server                                                                            |
| `500 Internal Server Error` | Returned when the server cannot proc the request                                                                                                         |
A full list of std HTTP response codes can be viewed [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status). Apart from the std HTTP codes, various servers and providers such as [Cloudflare](https://support.cloudflare.com/hc/en-us/articles/115003014432-HTTP-Status-Codes) or [AWS](https://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/APIError.html) implement their own codes.
## GET
When visiting any URL, a browser defaults to a GET request to obtain the remote resources hosted at the URL. Once the browser recv's the initial page it is requesting, it may send other requests using various HTTP methods. This can be observed through the Network tab in the browser devtools.
>[!Exercise]
>Pick any website of your choosing, and monitor the Network tab in the browser devtools as you visit it to understand what the page is performing. This technique can be used to thoroughly understand how a web app interacts w its backend, which can be an essential exercise for any web app assessment or bug hunting exercise.
## HTTP Basic Auth
When visiting the exercise at the end of this section, it prompts you to enter a username and a passwd. Unlike the usual login forms, which until HTTP params to validate the user creds (e.g. POST request), this type of auth util's a `basic HTTP authentication`, which is handled directly by the webserver to prot a specific pg/dir, w/o directly interacting w the web app.

To access the pg, enter a valid pair of creds, which in this case is `admin:admin`:![[Pasted image 20240610143403.png]]Once the creds are entered, it redirects to this pg:![[Pasted image 20240610143435.png]]This can also be accomplished using cURL:
```shell
$ curl -i http://<SERVER_IP>:<PORT>/
HTTP/1.1 401 Authorization Required
Date: Mon, 21 Feb 2022 13:11:46 GMT
Server: Apache/2.4.41 (Ubuntu)
Cache-Control: no-cache, must-revalidate, max-age=0
WWW-Authenticate: Basic realm="Access denied"
Content-Length: 13
Content-Type: text/html; charset=UTF-8

Access denied
```
Note that accessing the pg w/o any cURL args returns `Access denied` in the response body, as well as `Basic realm="Access denied"` in the `WWW-Authenticate` header, which confirms that this pg indeed uses `basic HTTP auth`. Use the `-u` flag to provide the creds through cURL, as follows:
```shell
$ curl -u admin:admin http://<SERVER_IP>:<PORT>/

<!DOCTYPE html>
<html lang="en">

<head>
...SNIP...
```
This time, cURL returns the pg in the response. Another method that can be used to provide the `basic HTTP auth` creds is to pass the args directly through the URL as `username:password@URL`, as follows:
```shell
$ curl http://admin:admin@<SERVER_IP>:<PORT>/

<!DOCTYPE html>
<html lang="en">

<head>
...SNIP...
```
This method also works when typing the URL into a browser.
>[!Excerise]
>View the response headers by adding `-i` to the above request and note how an auth response differs from an unauth one.
### HTTP Authorization Header
Adding a `-v` flag to either of the earlier cURL cmds would output the following:
```shell
$ curl -v http://admin:admin@<SERVER_IP>:<PORT>/

*   Trying <SERVER_IP>:<PORT>...
* Connected to <SERVER_IP> (<SERVER_IP>) port PORT (#0)
* Server auth using Basic with user 'admin'
> GET / HTTP/1.1
> Host: <SERVER_IP>
> Authorization: Basic YWRtaW46YWRtaW4=
> User-Agent: curl/7.77.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Mon, 21 Feb 2022 13:19:57 GMT
< Server: Apache/2.4.41 (Ubuntu)
< Cache-Control: no-store, no-cache, must-revalidate
< Expires: Thu, 19 Nov 1981 08:52:00 GMT
< Pragma: no-cache
< Vary: Accept-Encoding
< Content-Length: 1453
< Content-Type: text/html; charset=UTF-8
< 

<!DOCTYPE html>
<html lang="en">

<head>
...SNIP...
```
Since `basic HTTP auth` is being used, the HTTP request sets the `Authorization` header to `Basic YWRtaW46YWRtaW4=`, which is the Base64 encoded val of `admin:admin`. When using a modern method of auth (e.g. `JWT`), the `Authorization` would be of type `Bearer` and would contain a long enc'd token.

The `-H` flag can be passed through cURL to manually set the `Authorization`, w/o supplying the creds, to test whether it allows access to the pg. The `-H` flag can also be set multiple times to specify multiple headers:
```shell
$ curl -H 'Authorization: Basic YWRtaW46YWRtaW4=' http://<SERVER_IP>:<PORT>/

<!DOCTYPE html
<html lang="en">

<head>
...SNIP...
```
Notice that this also gives access to the pg. There are a few methods that can be used to auth the pg. Most modern web apps use login forms built w the back-end scripting lang (e.g. PHP), which util HTTP POST requests to auth the users and then return a cookie to maintain their auth.
### GET Parameters
Once authenticated, the pg gives access to a `City Search` fc, in which can be entered a search term and get a list of matching cities:![[Pasted image 20240610145204.png]]As the pg returns the results, it may be contacting a remote resource to obtain the info, and then display them on the pg. To verify this, open the browser devtools and got to the `Network` tab, or use the shortcut `Ctrl+Shift+E` to get to the same tab. Before entering the search term and view the request, click on the `trash` icon on the top left, to ensure any previous request is cleared and only newer requests are monitored.![[Pasted image 20240610145429.png]]After that, enter any search term and hit enter and immediately a new request is sent to the backend:![[Pasted image 20240610145512.png]]Clicking on the request sends it to search.php w the GET param `search=le` used in the URL. This helps the understand that the search fc requests another pg for the results.

Now, send the same request directly to `search.php` to get the full search results, though it will probably return them in a specific format (e.g. `JSON`) w/o having the HTML layout shown in the above screenshot.

To send a GET request w cURL, use the exact same URL seen in the above screenshots since GET requests place their params in the URL. However, browser devtools provide a more convenient method of obtaining the cURL cmd. Right-click on the request and select `Copy>Cop as cURL`. Then, paste the copied cmd in the terminal and exec it, which should return the exact same response:
```shell
$ curl 'http://<SERVER_IP>:<PORT>/search.php?search=le' -H 'Authorization: Basic YWRtaW46YWRtaW4='

Leeds (UK)
Leicester (UK)
```
>[!Note]
>The copied cmd will contain all headers used in the HTTP request. However, it is possible to remove most of them and only keep necessary auth headers, like the `Authorization` header.

This can also be repeated w/i the browser devtools, by selecting `Copy>Copy as Fetch`, which will copy the same HTTP request using the JS Fetch library. Then, click to the JS console tab, or use the `Ctrl+Shift+K` shortcut, and paste in the Fetch cmd and hit enter to send the request:![[Pasted image 20240610150427.png]]The browser will send the request, and the returned response can be seen after it. Clicking the response will show its details, which can be read from there.
## POST
Whenever web apps need to transfer files or move the user params from the URL, they util `POST` requests.

Unlike HTTP `GET`, which places user params w/i the URL, HTTP `POST` places user params w/i the HTTP Request body, which has three main benefits:
- `Lack of Logging`: As POST requests may transfer large files (e.g. file upload), it would not be efficient for the server to log all uploaded files as part of the requested URL, as would be the case w a file uploaded through a GET request.
- `Less Encoding Req's`: URLs are designed to be shared, which means they need to conform to chars that can be converted to letters. The POST request places data in the body which can accept bin data. The only chars that need to be encoded are those that are used to separate params.
- `More data can be sent`: The max URL Length varies b/w browsers (Chrome/Firefox/IE), web servers (IIS, Apache, nginx), Content Delivery Networks (Fastly, Cloudflare, Cloudfront), and even URL shorteners (bit.ly, amzn.to). Generally speaking, a URL's length should be kept to below 2,000 chars, and so they cannot handle a lot of data.
The following sections demonstrate some examples of how POST requests work, and how diff tools, like cURL and browser devtools, can be leveraged to read and send POST requests.
### Login Forms
This exercise at the end of this section is similar to the example seen in the GET section with the diff that this web app util's a PHP login instead of HTTP basic auth:![[Pasted image 20240610152605.png]]Logging in with `admin:admin` again returns a similar search fc to the one seen in the GET section:![[Pasted image 20240610152656.png]]Clearing the Network tab in the browser devtools and logging in again shows many requests being sent, which can be filtered by server IP, so it would only show requests going to the web app's web server (i.e. filter out external requests), and notice the following POST request being sent:![[Pasted image 20240610152847.png]]Click on the request, then the `Request` tab (which shows the request body), and then the `Raw` button to show the raw request data. This will return that the following data is being sent as the POST request data:
```bash
username=admin&password=admin
```
This can also be attempted w cURL, to see whether this would allow login. Furthermore, as was demonstrated in the previous section, right-click the request and select `Copy>Copy as cURL`. However, it is important to be able to craft POST requests manually, as shown below.

The `-X POST` flag sends a `POST` request. Then, to add the POST data, use the `-d` flag and add the above data after it, as follows:
```shell
$ curl -X POST -d 'username=admin&password=admin' http://<SERVER_IP>:<PORT>/

...SNIP...
        <em>Type a city name and hit <strong>Enter</strong></em>
...SNIP...
```
Examining the HTML code, there is no login form code, but the search fc code is still shown, indicating that auth was granted.
>[!Tip]
>Many login forms would redirect to a diff pg once auth'd (e.g. /dashboard.php). Use the `-L` flag to follow the redirection w cURL.
### Authentication Cookies
A cookie should be recv'd upon successful auth so the browser can persist this auth, i.e. the website doesn't prompt login every time it is accessed. The `-v` or `-i` flags can be passed to view the response, which should contain the `Set-Cookie` header w the auth cookie:
```shell
$ curl -X POST -d 'username=admin&password=admin' http://<SERVER_IP>:<PORT>/ -i

HTTP/1.1 200 OK
Date: 
Server: Apache/2.4.41 (Ubuntu)
Set-Cookie: PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1; path=/

...SNIP...
        <em>Type a city name and hit <strong>Enter</strong></em>
...SNIP...
```
W the auth cookie, you should now be able to interact w the web app w/o needing to provide you creds every time. To test this, use the `-b` flag in cURL to set the above cookie as follows:
```shell
$ curl -b 'PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1' http://<SERVER_IP>:<PORT>/

...SNIP...
        <em>Type a city name and hit <strong>Enter</strong></em>
...SNIP...
```
This confirms that you are auth and got to the search fc. It is also possible to specify the cookie as a header: `curl -H 'Cookie: PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1' http://<SERVER_IP>:<PORT>/`

The same thing can be used in the browser. First, logout to get back to the login pg. Then, go to the `Storage` tab in the devtools w `Shift-F9`, and click on the `Cookies` in the left pane and select the website to view the current cookies, if there are any. While logged out, the PHP cookie should not be auth, which is why the login form is displayed instead of the search fc:![[Pasted image 20240610154723.png]]To test the earlier auth cookie, simply replace the cookie val w the one recv'd earlier. Right-click on the cookie and select `Delete All`, then click on the `+` icon to add a new cookie. After that, enter the cookie name, which is the part before the `=` (`PHPSESSID`), and then the cookie val, which is the part after the `=` (`c1nsa6op7vtk7kdis7bcnbadf1`). Finally, refresh the pg, and the pg should load to the search fc:![[Pasted image 20240610160956.png]]This demonstrates that having a valid cookie may be enoug hto get auth into many web apps, which can be an essential part of some web atks, like Cross-Site Scripting (XSS).
### JSON Data
Finally, to see what requests are recv'd when interacting w the `City Search` fc, go to the Network tab in the browser devtools, and then click on the trash icon to clear all requests. Then, make any search query to see what requests get sent:![[Pasted image 20240610161340.png]]In this example, the search form sends a POST request to `search.php`, w the following data:
```json
{"search":"london"}
```
The POST data appears to be in JSON format, so the request must have specified the `Content-Type` header to be `application/json`, which can be confirmed by right-clicking on the request, and selecting `Copy>Copy Request Headers`:
```bash
POST /search.php HTTP/1.1
Host: server_ip
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:97.0) Gecko/20100101 Firefox/97.0
Accept: */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://server_ip/index.php
Content-Type: application/json
Origin: http://server_ip
Content-Length: 19
DNT: 1
Connection: keep-alive
Cookie: PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1
```
Indeed, there is a `Content-Tye: application/json`. Now to replicate this request w cURL, while including both the cookie and content-type headers, and send the request to `search.php`:
```shell
$ curl -X POST -d '{"search":"london"}' -b 'PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1' -H 'Content-Type: application/json' http://<SERVER_IP>:<PORT>/search.php
["London (UK)"]
```
This confirms that direct search fc interaction is possible w/o needing to login or interact w the web app front-end. This can be an essential skill when performing web app assessments or bug hunting exercises, as it is much faster to text web apps in this way.
>[!Exercise]
>Try to repeat to above request w/o adding the cookie or content-type headers, and see how the web app would act differently.

Finally, repeat the same above request by using `Fetch`. Right-click on the request and select `Copy>Copy as Fetch`, and then go to the `Console` tab and exec the code there:![[Pasted image 20240610162522.png]]The request successfully returns the same data recv'd w cURL. `Try to search for diff cities by directly interacting w the search.php through Fetch or cURL.`
## CRUD API
This section demonstrates how to leverage APIs to perform what has been discussed in the HTTP Methods chapter of this module by directly interacting the the API endpoint.
### APIs
There are several types of APIs. Many APIs are used to interact w a db, such that it is common to be able to specify the requested table and the requested row w/i the API query, and then use an HTTP method to perform the op needed e.g. for the `api.php` endpoint, to update the `city` table in the db, and the row that will be updated has the city name of `london`, then the URL would look something like this: `$ curl -X PUT http://<SERVER_IP>:<PORT>/api.php/city/london ...SNIP...`
### CRUD
As demonstrated, it's easy to specify the table and the row to perform an op on through such APIs. Then, leverage diff HTTP methods to perform diff ops on that row. In general, APIs perform 4 main ops on the requested db entity:

| **Operation** | **HTTP Method** | **Description**                              |
| ------------- | --------------- | -------------------------------------------- |
| `Create`      | `POST`          | Adds the specific data to the db table       |
| `Read`        | `Get`           | Reads the specified entity from the db table |
| `Update`      | `PUT`           | Updates the data of the specified db table   |
| `Delete`      | `DELETE`        | Removes the specified row from the db table  |
These four ops are mainly linked to the commonly known CRUD APIs, but the same principle is also used in REST APIs and several other APIs. Of course, not all APIs work in the same way, and the user access ctrl will limit what actions can be performed and what results can be seen during an assessment. The [[Intro to Web Apps]] module further explains these concepts, so feel free to refer to it for more details about APIs and their usage.
### Create
To add a new entry, use and HTTP POST request, which is quite similar to what was demonstrated in the previous section. Simply POST the JSON data, and it will be added to the table. As this API is using JSON data, set the `Content-Type` header to JSON, as follows:
`$ curl -X POST http://<SERVER_IP>:<PORT>/api.php/city/ -d '{"city_name":"HTB_City", "country_name":"HTB"}' -H 'Content-Type: application/json'`
Now to read the content of the city that was added (`HTB_City`), to see if it was successfully added:
```shell
$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/HTB_City | jq

[
  {
    "city_name": "HTB_City",
    "country_name": "HTB"
  }
]
```
This confirms that a new city was created, which did not exist before.
>[!Exercise]
>Try adding a new city through the browser devtools, by using one of the Fetch POST requests used in the previous section.
## Read
The first thing to do when interacting w an API is reading data. As mentioned earlier, simply specify the tbl name after the API (e.g. `/city`) and then specify the search term (e.g. `/london`), as follows:
```shell
$ curl http://<SERVER_IP>:<PORT>/api.php/city/london

[{"city_name":"London","country_name":"(UK)"}]
```
Note that the result is sent as a JSON str. To have it properly formatted in JSON format, pipe the output to the `jq` util, which will format it properly. In this instance, use the `-s` flag to silence any unneeded cURL output, as follows:
```shell
$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/london | jq

[
  {
    "city_name": "London",
    "country_name": "(UK)"
  }
]
```
Note that the output was recv'd in a nicely formatted output. Search terms can also be provided to get all matching results:
```shell
$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/le | jq

[
  {
    "city_name": "Leeds",
    "country_name": "(UK)"
  },
  {
    "city_name": "Dudley",
    "country_name": "(UK)"
  },
  {
    "city_name": "Leicester",
    "country_name": "(UK)"
  },
  ...SNIP...
]
```
Finally, passing an empty str will retrieve all entries in the tbl:
```shell
$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/ | jq

[
  {
    "city_name": "London",
    "country_name": "(UK)"
  },
  {
    "city_name": "Birmingham",
    "country_name": "(UK)"
  },
  {
    "city_name": "Leeds",
    "country_name": "(UK)"
  },
  ...SNIP...
]
```
>[!Exercise]
>Try visiting any of the above links using your browser, to see how the result is rendered.
### Update
After reviewing how to read and write entries through APIs, it is time to discuss the other two HTTP methods: `PUT` and `DELETE`. As mentioned at the beginning of the section, `PUT` is used to update API entries and mod their details, while `DELETE` is used to rm a specific entity.
>[!Note]
>The HTTP `PATCH` method may also be used to update API entries instead of `PUT`. To be precise, `PATCH` is used to partially update an entry (i.e. mod some of its data, e.g. only city_name), while `PUT` is used to update the entire entry. The HTTP `OPTIONS` method can also be used to see which of the two is accepted by the server, and then use the appropriate method accordingly. This section will focus on the `PUT` method, though their usage is quite similar.

Using `PUT` is similar to `POST` in this case, w the only diff being that the name of the entity to be edited has to be specified in the URL, otherwise the API will not know which entity to edit. So, just specify the `city` name in the URL, change the request method to `PUT`, and provide the JSON data like in the `POST` cmd, as follows:
`$ curl -X PUT http://<SERVER_IP>:<PORT>/api.php/city/london -d '{"city_name":"New_HTB_City", "country_name":"HTB"}' -H 'Content-Type: application/json'`
This example shows the first step was to specify the city as `/city/london`, and passed a JSON str that contained `"city_name":"New_HTB_City"` in the request data. So, now the `london` city should no longer exist, and a new city w the name `New_HTB_City` should exist, instead. Use the following cmd to confirm:
```shell
$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/london | jq
```
```shell
$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/New_HTB_City | jq

[
  {
    "city_name": "New_HTB_City",
    "country_name": "HTB"
  }
]
```
Indeed, the first cmd returns nothing, and the second shows that the old city name was successfully replaced w the new city.
>[!Note]
>In some APIs, the `Update` op may be used to create new entries as well. Basically, when sending data, if it does not exist, `Update` would create it e.g. in the above example, even if an entry w a `london` city did not exist, it would create a new entry w the details passed. In the above example, this is not the case. Try to `Update` a non-existing city and see what you would get.
### DELETE
Finally, deleting a city is as easy as reading one. Simply specify the city name for the API and use the HTTP `DELETE` method, and it would delete the entry, as in the following cmd:
`$ curl -X DELETE http://<SERVER_IP>:<PORT>/api.php/city/New_HTB_City`
Then, use the cmd learned earlier to confirm it was deleted:
```shell
$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/New_HTB_City | jq
[]
```
This time, the cmd outputed an empty array when trying to read `New_HTB_City`, meaning it no longer exists.
>[!Exercise]
>Delete any of the cities you added earlier through POST requests, and then read all entries to confirm that they were successfully deleted.

In a real web app, such actions may not be allowed for all users, or it would be considered a vuln if anyone can mod or del any entry. Each user would have certain privs on what they can `read` or `write`, where `write` refers to adding, modding, or del'ing data. To auth a user to use the API, you'd need to pass a cookie or an auth header (e.g. `JWT`), as was seen in an earlier section. Other than that, the ops are similar to what was practiced in this section.