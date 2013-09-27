#
# Copyright (c) 2006 rPath, Inc.
#
# All Rights Reserved
#

NAME=cernvm-config

all: build

PYTHON = $(shell [ -x /usr/bin/python2.4 ] && echo /usr/bin/python2.4 || echo /usr/lib/conary/python/bin/python2.4)
PYVERSION = $(shell $(PYTHON) -c 'import os, sys; print sys.version[:3]')
PYINCLUDE = $(shell $(PYTHON) -c 'import os, sys; print os.sep.join((sys.prefix, "include", "python" + sys.version[:3]))')

export DESTDIR=
export prefix = /usr

super_kid_files = $(shell find . -name "*.kid")

dist:   
	find . -name "*~" -exec rm {} \;      
	tar zcf ../$(NAME).tar.gz --exclude .svn etc

build:

install: build
	for f in $$(find etc -maxdepth 1 -type f); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 644 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(ls  etc/dhclient-* ); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/ssh -type f) ; do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 600 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/squid -type f) ; do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 644 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/cernvm/keys -type f) ; do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 600 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/cernvm/*.d -type f -name *.sh); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/cernvm  -type f -name *.py ); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/cernvm  -type f -name *.sh ); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/init.d -type f); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/sysconfig -type f); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc/profile.d -type f); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc -name *.c*f*); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 644 $$f $(DESTDIR)/$$f; \
	done
	for f in $$(find etc -name config.guess -o -name proxy -o -name config); do \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		install -m 755 $$f $(DESTDIR)/$$f; \
	done
doc:

clean:
	rm -rf *~
	find . -name '*.pyc' | xargs -r rm
