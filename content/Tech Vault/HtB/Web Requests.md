# HyperText Transfer Protocol (HTTP)
[HTTP](https://tools.ietf.org/html/rfc2616) is an application-level protocol used to access the World Wide Web resources. The term `hypertext` stands for text containing links to other resources and text that the readers can easily interpret.

http communication consists of a client and a server, where the client requests the server for a resource, the server the processes the request, and finally returns the requested resource to the client. The default port for http communication is port `80`, though this can be changed to any other port, depending on the web server configuration. The same requests are utilized when we use the internet to visit different websites. We enter a `Fully Qualified Domain Name` (`FQDN`) as a `Uniform Resource Locator` (`URL`) to reach the desired website.

## URL
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

## HTTP Flow
![[HTTP_Flow.webp]]
This diagram present the anatomy of an http request at a very high level. The first time a user enters the url (inlanefreight.com) into the browser, it sends a request to a `Domain Name Resolution` (`DNS`) server to resolve the domain and get its IP. The `DNS` server looks up the IP address for `inlanefreight.com` and returns it All domain names need to be resolved this way, as a server can't communicate without an IP address.

>[!Note:]
>Our browsers usually first look up records in the local `'/etc/hosts/'` file, and if the requested domain does not exist within it, then they would other DNS servers. We can use the `'/etc/hosts'` to manually add records to for DNS resolution, by adding the IP followed by the domain name.

Once the browser gets the IP address linked to the requested domain, it sends a GET request to the default http port (e.g. `80`), asking for the root `/` path. Then, the web server receives the request and processes it. By default, server are configured to return an index file when a request for `/` is received.

In this case, the contents of `index.html` are read and returned by the web server as an http response. The response also contains the status code (e.g. `200 OK`), which indicates that the request was successfully processed. The web browser then renders the `index.html` contents and presents it to the user.

>[!Note:]
>This module is mainly focused on http web requests. For more on HTML and web applications, refer to the [Introduction to Web Applications](https://academy.hackthebox.com/module/details/75) Module

