# The Basics — What is Poetry?

Poetry is a Python packaging and dependency management tool.

## What it does?

* Manages project dependencies

* Creates isolated virtual environments

* Builds and publishes Python packages

## Key files:

pyproject.toml → your main config file

poetry.lock → exact version pins

## Installation

```sh
$ curl -sSL https://install.python-poetry.org | python3 -
$ poetry --version
```

we can use brew also to install Poetry

## How to work with Poetry

### Create new project

``` sh
poetry new my_project
cd my_project
```
it creates,

my_project/
├── pyproject.toml
├── my_project/
│   └── __init__.py
└── tests/
    └── __init__.py


### Install dependencies

to install requests package,

```sh
poetry add requests
```
### using env

```sh
poetry env info # to check the python info
poetry env use # uses available python or you can use # poetry env use python3.x
poetry env activate
```

```sh
(my-project-1-py3.13) ganeshkumaresan@GANESH-KUMARESAN my_project_1 % poetry env i
nfo

Virtualenv
Python:         3.13.4
Implementation: CPython
Path:           /Users/ganeshkumaresan/Library/Caches/pypoetry/virtualenvs/my-project-1-ksQogSCE-py3.13
Executable:     /Users/ganeshkumaresan/Library/Caches/pypoetry/virtualenvs/my-project-1-ksQogSCE-py3.13/bin/python
Valid:          True

Base
Platform:   darwin
OS:         posix
Python:     3.13.4
Path:       /opt/homebrew/opt/python@3.13/Frameworks/Python.framework/Versions/3.13
Executable: /opt/homebrew/opt/python@3.13/Frameworks/Python.framework/Versions/3.13/bin/python3.13
```

### to activate a new environement (like venv)

```sh
ganeshkumaresan@GANESH-KUMARESAN my_project_1 % poetry env activate

source /Users/ganeshkumaresan/Library/Caches/pypoetry/virtualenvs/my-project-1-ksQogSCE-py3.13/bin/activate

ganeshkumaresan@GANESH-KUMARESAN my_project_1 % source /Users/ganeshkumaresan/Library/Caches/pypoetry/virtualenvs/my-project-1-ksQogSCE-py3.13/bin/activate

(my-project-1-py3.13) ganeshkumaresan@GANESH-KUMARESAN my_project_1 %  ## activated

```

### Pinning Dev Dependencies

```sh
poetry add --dev black pytest
```

### show dependency tree

```sh
poetry show --tree
```

### update a package

```sh
poetry update requests
```

### lock manually

```sh
poetry lock
```
it creates a poetry.lock file.  (Recreates the poetry.lock file if already exists (after editing pyproject.toml manually).)

### build our own package

```sh
poetry build
```

It generates:

.tar.gz (source distribution)

.whl (wheel distribution)

### publish to PyPI

```sh
poetry publish --username __token__ --password <pypi-token>
```

First run poetry config pypi-token.pypi your-token to store it securely.

### customize pyproject.toml

.toml file

```sh 
[tool.poetry.scripts]
mycli = "my_project.cli:main"
```

now we can run ```poetry run mycli``` to run the package

## Handling multiple Python versions

.toml file

```sh
[tool.poetry.dependencies]
python = "^3.10"
```

Poetry will refuse to install if your system Python doesn’t match.

## testing with poetry

```sh
poetry run pytest
```

## debug environement issue

```sh
poetry env info          # venv info
poetry debug:info 
```

## docker with poetry

docker file,

```sh
FROM python:3.10
RUN pip install poetry
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-dev
```

## Summary

| What                         | Command                                                |
| ---------------------------- | ------------------------------------------------------ |
| Add package                  | `poetry add requests`                                  |
| Add dev package              | `poetry add --dev black`                               |
| Run code                     | `poetry run python`                                    |
| Activate shell               | `poetry shell`                                         |
| Export to `requirements.txt` | `poetry export -f requirements.txt > requirements.txt` |
| Create venv manually         | `poetry env use python3.11`                            |
