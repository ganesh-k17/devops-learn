```bash
# Start HTTPD service:

Service httpd start 

or 

Service start httpd

Stop HTTPD Service:

systemctl stop httpd

# Check HTTPD service Status

systemctl status httpd

# Configure HTTPD to start at startup

systemctl enable httpd

#Configure HTTPD to not start at startup

systemctl disable httpd

configuring a program as service:

cd /etc/systemd/system

my_app.service =>

[Service]
ExecStart=/user/bin/python3 /opt/code/my_app.py

commands:

systemctl daemon-reload
systemctl start my_app
systemctl stop my_app

systemctl status my_app

configuring a service to run automatically when the system bootup

my_app.service =>

[Service]
ExecStart=/user/bin/python3 /opt/code/my_app.py

[Install]
WantedBy=multi-user.target

command:

systemctl enable my_app

myapp.service

[unit]
Description=My python web application


Sample unit service file:
cd /etc/systemd/system

my_app.service =>

[Unit]
Description=My python web application

[Service]
ExecStart=/usr/bin/python3 /opt/code/my_app.py
ExecStartPre=/opt/code/configure_db.sh
ExecStartPost=/opt/code/email_status.sh
Restart=always

[Install]
WantedBy=multi-user-target
```