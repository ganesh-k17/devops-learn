
Python Web Frameworks:

* Django
* Flask

# Sample code for Flask:

```python

# Importing flask module in the project is mandatory
# An object of Flask class is our WSGI application.
from flask import Flask
 
# Flask constructor takes the name of
# current module (__name__) as argument.
app = Flask(__name__)
 
# The route() function of the Flask class is a decorator,
# which tells the application which URL should call
# the associated function.
@app.route('/')
# ‘/’ URL is bound with hello_world() function.
def hello_world():
    return 'Hello World'
 
# main driver function
if __name__ == '__main__':
 
    # run() method of Flask class runs the application
    # on the local development server.
    app.run(host="0.0.0.0", port=8080)
```

```bash
pip install -r requirements.txt
python main.py
```

## Tools used for prduction to deploy Flask:

* Gunicorn
* uWSGI
* Gevent
* Twisted Web

Commands to deploy by Gunicorn:

```bash
gunicor main:app # gunicorn filename:appname
gunicorn main:app -w 2  # for two workers
```


Others:

```bash
sudo sed -i 's/8080/5000/g' app.py; python app.py  # to change the port in flask app from 8080 to 5000
```


Lab:

```bash
sudo pip install gunicorn --upgrade  # install gunicorn
gunicorn app:app  #to run app using gunicorn
gunicorn app:app -w 3  # run the app using
ps -ef | grep gunicorn | grep -v grep  # to find how many number gunicorn is running currently
```
