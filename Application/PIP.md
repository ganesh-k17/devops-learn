# PIP (Python package manager)

Versions : PIP2, PIP3

to use PIP2 => pip2 -V or pip -V
to use PIP3 => pip3 -V

Commands:

```python
$ pip install flask  # to install a package (eg: flask)
$ pip show flask     # to show the package details (eg: flask) like where it has been installed, version used, etc
$ python2 -c "import sys; print(sys.path)"  # list of paths python looks for packages
```


Can install more than one packages in one commands

for eg: to install flask, jinja2, markupsafe in a single command,

```python
pip install flask jinja2 markupsafe
```

Another method to install many package in single attempt, we can use requirements.txt

```python
requirements.txt

Flask
Jinja2
MarkupSafe
Werkzeug
requests
gunicorn
```

```python
pip install -r requirements.txt  # will install all the packages available in requirements.txt
```

We can mention versions for the packages to install as below.  If the versions are not mentioned python will always donwload and install latest packages

```python
requirements.txt

Flask==0.10.1
Jinja2==2.7.3
MarkupSafe==0.23
Werkzeug==0.9.6
requests==2.3.0
gunicorn==18.0
```

``` python
$ pip install flask --upgrade # to upgrade flask package
$ pip uninstall flask  # to unistall flask package
```

Other package managers:

* easy_install  (easy_install install app)
* wheels  (pip install app.whl)