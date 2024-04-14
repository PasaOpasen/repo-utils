
HELP_FUN = \
    %help; while(<>){push@{$$help{$$2//'options'}},[$$1,$$3] \
    if/^([\w-_]+)\s*:.*\#\#(?:@(\w+))?\s(.*)$$/}; \
    print"$$_:\n", map"  $$_->[0]".(" "x(20-length($$_->[0])))."$$_->[1]\n",\
    @{$$help{$$_}},"\n" for keys %help; \

help: ##@Miscellaneous Show this help
	@echo -e "Usage: make [target] ...\n"
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)


wheel:        ##@PyPI build local wheel
	bash wheel.sh

wheel-push:   ##@PyPI push local wheel
	bash wheel-push.sh

pypi-package: wheel wheel-push  ##@PyPI wheel build + push

tag:          ##@Repo create and push tag from version.txt
	bash tag-version.sh

commit-v:     ##@Repo commit the current state according to version.txt file
	bash commit-version.sh

pypi-release: commit-v pypi-package tag ##@Repo perform several actions for PyPI package release and repo update
	 
incr-version:  ##@Repo increases the minor version in version.txt file
	bash increase-version.sh
