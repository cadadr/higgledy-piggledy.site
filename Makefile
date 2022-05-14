# Makefile

# Copyright (C) 2022 İ. Göktuğ Kayaalp <self at gkayaalp dot com> This
# file is part of “The Higgledy-Piggledy Website”.
#
# “The Higgledy-Piggledy Website” is non-violent software: you can use,
# redistribute, and/or modify it under the terms of the CNPLv6+ as found
# in the LICENCE_CNPLv6.txt file in the source code root directory or at
# <https://git.pixie.town/thufie/CNPL>.
#
# “The Higgledy-Piggledy Website” comes with ABSOLUTELY NO WARRANTY, to
# the extent permitted by applicable law.  See the CNPL for details.


OUTDIR=out
PAGES:=$(wildcard pages/*.markdown)
PAGES:=$(PAGES:%.markdown=%.html)
PAGES:=$(PAGES:pages/%=out/%)
SRCS=$(wildcard partials/_*.html)

help:
	@echo Targets:
	@echo "	all	compile"
	@echo "	clean	remove generated files"
	@echo "	help	show this help message"
	@echo "	watch	automatic build"

all: _outdirs $(PAGES) $(SRCS) .gitignore
	cp -r static/* out/

_outdirs:
	[ -d $(OUTDIR) ] || mkdir -p $(OUTDIR)

watch:
	git ls-files | grep -Ev '^./(out|.git)' | entr make all

out/%.html: pages/%.markdown $(SRCS)
	./transform.sh $< > $@

clean:
	rm -r $(OUTDIR)

.PHONY: all clean watch outdirs
