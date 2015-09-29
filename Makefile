# functions

# $(call filter-partials,file-list)
# Removes underscore-prefixed files from file-list
define filter-partials
	$(foreach file,\
		$1,\
		$(eval FILE=$(notdir $(file)))\
			$(if $(FILE:_%=),$(file)))
endef

# settings

SRC_SCSS_PATH=static/src/scss
SRC_SCSS=$(shell find $(SRC_SCSS_PATH) -type f -name '*.scss')
BUILD_CSS_PATH=static/css
BUILD_CSS=$(call filter-partials,\
	$(subst $(SRC_SCSS_PATH),$(BUILD_CSS_PATH),$(SRC_SCSS:.scss=.css)))

VENV_DIRECTORY=venv
VENV_ACTIVATE=$(VENV_DIRECTORY)/bin/activate

# targets

all: venv migrate build

build: css

clean:
	rm -rfv\
		$(BUILD_CSS)\

css: $(BUILD_CSS)

distclean: clean
	rm -rfv\
		$(shell find . -type f -name '*.pyc')\
		$(VENV_DIRECTORY)\
		db.sqlite3\
		node_modules\

migrate: venv
	. $(VENV_ACTIVATE); python manage.py migrate

migrations: venv
	. $(VENV_ACTIVATE); python manage.py makemigrations

runserver: venv migrate build
    # --insecure option forces serving of static files if DEBUG=False
	. $(VENV_ACTIVATE); python manage.py runserver 0.0.0.0:8000 --insecure

venv: $(VENV_ACTIVATE)

# file rules

SASS=node_modules/.bin/node-sass
SASS_FLAGS = --style compressed --load-path $(SRC_SCSS_PATH) --sourcemap=none
$(BUILD_CSS_PATH)/%.css: $(SRC_SCSS_PATH)/%.scss $(SRC_SCSS) node_modules
	mkdir -p "$(@D)"
	$(SASS) $(SASS_FLAGS) $< $@

$(VENV_ACTIVATE): requirements.txt
	test -d $(VENV_DIRECTORY) || virtualenv --no-site-packages --python=$(shell which python3) $(VENV_DIRECTORY)
	. $@; pip install --requirement requirements.txt --upgrade
	touch $@

node_modules: package.json
	npm install
	touch $@
