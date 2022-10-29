
# Web Security

* The state of being proteected or safe from harm
* Things done to make people or places safe
* Measures taken to guard against espionage or sabotage, crime, attack, or escape
* Awareness + Adequate Protection = Security
* Security designed into a website from the bottom up.  Following best practices is far more important that any labels or third-party opinions about a website.

## Consequences of Website Insecurity

* Monetary theft
* identity theft
* Data theft
* Spying
* Spam
* Embarrassment
* Loss of access
* Loss of control

## Threat models

prioritize list of security threats and risks on an organisation to strengthen the security.

* Find the weekest link first to secure
* Reevaluate security model often
* * Security is not one time proecess.

## Zero-Day vulnerabilities

* A software flaw or exploit which exposes a vulnerability but does not yet have a fix or patch available.  That hasm't been detected or worked on by those developed the system.

## General security Principles:

### Least Privilege

* Limit the access (Users or Features only to required users)
* ``` Every program and every privileged user of the system should operate using the least amount of privilege necessary to complete the job```
* eg: Users on customer portal should not be given access to the admin portal, human resouce portal, etc.
* Least privilege hsould be applied to all the applications,
  * APIs
  * System resources
  * DB acess
  * Software version controls
  * Web pages
  * Source code's communication with other modules (in source code)
* Benefits:
  * Control access to systems and resources
  * Grant as little access as possible
  * Expire access as soon as it's no longer needed
  * Limits vulnerability, reduces damages

### Simple is more secure

* Simple or small application is easy to maintain and more secure,  Large application is more vulnerable to maintain
* Increase Security by code
  * Use clearly named functions and variables 
  * Write code comments
  * Prefer built-in functions
  * Remove cruft from the code
  * Cleaner code is easy to understand and less vulnerable
  * Disable unused features
  * Breakup long sections of code into smaller
  * Don't repeat the code (duplications)
  * Remove unnecessary complexity

### Never trust users

* Every users can be a hacker
* Verify and validate users identity properly
* People change and their mindset
* Reconsider previleges often
* Users can be tricked by someone (eg: hackers)

### Always expect the unexpect

* Whatever happen at anytime.
* Should be cautious
* Edge cases
  * All the edge cases shold be properly validated.
  * Challenge the assumption

### Defense in depth

* It is too risky to have a single point of failure.
* Always should have a backup plan (if any security fails)
* It would increase the complexity of an attack
* Defensive Controls
  * Physical (Protect servers and other computer h/ws)
  * Technical (Hardware, software and n/w protections (Firewall, Intrusion detection, Antivirus, Event logging, Data backups) )
  * Administrative (Policies and procedures to protect the system)
  
### Security through obscurity

* ```Loose lips might sink ships```
* Less information should be given (in browser headers, etc.)
* Website link should not have language extension (eg: www.xxx.com/index.php), The attacker can easily identify the programming language used to develop the application.
* Security through obscurity is not security at all.  But obscurity is a good defense but it works better with other security. (Keeping money behind the photo frame is more security than having in centre of the open room)

### Deny list and allow lists

* 

### Map exposure points and data passageways
* Understanding of how users are accessing the applications, how data flow via application we can control our web security
* Mapping Data Input
  * URLs
  * Forms
  * Cookies
  * Session Data
  * Database reads
  * APIs
* Mapping Data in Transition
  * Internet
  * Wireless communications
  * Network hardware
  * Network software
* Mapping  Data in Storage
  * Databases
  * hard drives
  * The cloud
  * Portable media (flash drives, CDs)
  * Backup files
* Mapping Data outpu
  * HTML, CSS, JavaScript
  * JSON, XML, CSV
  * Cookies
  * Session Data
  * Database writes
  * APIs
  * Log files
* Web security is by data security also
* Data security goals are Confidentiality, Integrity and Availability (CIA)
  * Confidentiality - data os pm;u available to priviledged users
  * Integrity - data is correct and can be trusted
  * Availablity - data is available when needed
  
## Filter Input and Control Output
* Desiging check points (Defense in depth)
* We have to stop threats early (good data can be allowed and bad data should be kept out)

### Regulate requests
* Http requests should be regulated which requets should be allowed. (Get, Post are sample request types)
* Request and response formates should be defined (html or json, etc for accept or content-type for the request)
* Ip address, urls, query parameter, user-agent string, size also should be regulated to keep web seurity.
 
### Validate input
* Data validation confirms whether the input is proper acceptable data
* Presence/length validation
* Validate type of data
* Validate by regular expression like validating mail address format
* Validating by uniqueness (already exists)

### Sanitize data
* typecasting data before use (eg: int to string or string int)
* When data is passed to API to sql we have to do SQl sanitization on data and vise-versa.
* Data should be properly formated and validated before passing through a communication channel.
* Add escape characters before powerful characters ("")
* Replace powerful characters with harmless equivalents
* Use proper encoding and escaping on data 
* Data should be properly sanitize before storing to sql or other database.

### Label variables

* Use proper variable names to identify whether the data is sanitized so that the developer confirm that the data 
has been sanitized (for eg. if we have a variable urlParam then after sanitizing (eg: pass the url params to sanitize() method to
sanitize the data) we can assign the sanitized result to clean-urlParam variable)

### Keep code private

* Control visiblity for the code by private variables as much as possible.
* If possible have a seperate folders for public and private codes (means public folder can be 
accessed by web and private code only accessible via code.)
* Public scope code should be minimal as much as possible.

### Keep credentials private

* Avoid hardcoding credentials
* Seperate configuration file from code
* All files with credentials should be excluded from version control
* dont save credentials in database as plain text (encrypt it before storing the credentials)
* SSH can be used to encrypt credentials and may disable password logins completely to connect to remote server
* Poor handling of credentials can be a weak link on security

### keep error messages vague

* Dont provide information on error message for hackers to guess the error (Can give login error message as 
'login failed' instead of username incorrect)
* Browser error reporting of detail error message is fine in developement but when in production it should be switched off.

### Smart logging 

* We need to be smart on what should be logged
* We should log sensitive actions and suspicious activity
* What to log:
  * Date and time (this is critical to establishing a timeline of events!)
  * Source (IP, user)
  * ACtion and target (target mab be admin page or database to steal data)
  * URL, parameters, cookies (which can be used to identify any of the details already has been compromised!)
  * Backtrace
* Be aware on not logging any sensitive data
* User log rotate

## The most common attacks
### Types of credential attacks

* Bruteforce attack
* Dictionary attack

### Strong passwords

* Use long passwords (12 characters minimum)
* Use character variety (A-Z, a-z, 0-9. symbols)
* Avoid patterns and dictionary words
* Never reuse passowrds
* Use good software manager
* SSH keys is good alternative to passwords
* Use multifactor authentication
* Password hashing
* Can use login throttling (it may avoid bruteforce attack )

### URL manipulation and insecure direct object reference(IDOR)
### SQL injection
### Cross site scripting (XSS)
### Cross site request forgery (CSRF)
### Cross site request protections
### Cookie visiility and theft
### Session hijacking
### Session fixation
### Remote code execution
### File upload abuse
### Denial of service
