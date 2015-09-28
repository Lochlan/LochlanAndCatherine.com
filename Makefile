VENV_DIRECTORY=venv
VENV_ACTIVATE=$(VENV_DIRECTORY)/bin/activate

all: venv build

build:

clean:

distclean: clean
	rm -rfv\
		$(shell find . -type f -name '*.pyc')\
		$(VENV_DIRECTORY)\

migrate: venv
	. $(VENV_ACTIVATE); python manage.py migrate

runserver: venv migrate build
    # --insecure option forces serving of static files if DEBUG=False
	. $(VENV_ACTIVATE); python manage.py runserver 0.0.0.0:8000 --insecure

venv: $(VENV_ACTIVATE)

# file rules

$(VENV_ACTIVATE): requirements.txt
	test -d $(VENV_DIRECTORY) || virtualenv --no-site-packages --python=$(shell which python3) $(VENV_DIRECTORY)
	. $@; pip install --requirement requirements.txt --upgrade
	touch $@
