# A custom makefile for the list-content utility
# Copyright (C) 2022, 2026 Jaromir Hradilek

# MIT License
#
# Permission  is hereby granted,  free of charge,  to any person  obtaining
# a copy of  this software  and associated documentation files  (the "Soft-
# ware"),  to deal in the Software  without restriction,  including without
# limitation the rights to use,  copy, modify, merge,  publish, distribute,
# sublicense, and/or sell copies of the Software,  and to permit persons to
# whom the Software is furnished to do so,  subject to the following condi-
# tions:
#
# The above copyright notice  and this permission notice  shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS",  WITHOUT WARRANTY OF ANY KIND,  EXPRESS
# OR IMPLIED,  INCLUDING BUT NOT LIMITED TO  THE WARRANTIES OF MERCHANTABI-
# LITY,  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
# SHALL THE AUTHORS OR COPYRIGHT HOLDERS  BE LIABLE FOR ANY CLAIM,  DAMAGES
# OR OTHER LIABILITY,  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM,  OUT OF OR IN CONNECTION WITH  THE SOFTWARE  OR  THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

# General information about the utility:
NAME    = list-content
VERSION = 0.1.2

# General settings:
SHELL   = /bin/sh
INSTALL = /usr/bin/install -c
SRCS    = list-content.rb
DOCS    = AUTHORS COPYING README.adoc TODO

# Target directories:
prefix  = /usr/local
bindir  = $(prefix)/bin
docdir  = $(prefix)/share/doc/$(NAME)-$(VERSION)

# The following are the make rules. Do not edit the rules unless you really
# know what you are doing:
.PHONY: install
install: $(SRCS) $(DOCS)
	@echo "Creating target directories:"
	$(INSTALL) -d $(bindir)
	$(INSTALL) -d $(docdir)
	@echo "Installing utilities:"
	$(INSTALL) -m 755 list-content.rb $(bindir)/list-content
	@echo "Installing documentation files:"
	$(INSTALL) -m 644 AUTHORS $(docdir)
	$(INSTALL) -m 644 COPYING $(docdir)
	$(INSTALL) -m 644 README.adoc $(docdir)
	$(INSTALL) -m 644 TODO $(docdir)
	-$(INSTALL) -m 644 ChangeLog $(docdir)
	@echo "Done."

.PHONY: uninstall
uninstall:
	@echo "Removing utilities:"
	-rm -f $(bindir)/list-content
	@echo "Removing documentation files:"
	-rm -f $(docdir)/AUTHORS
	-rm -f $(docdir)/COPYING
	-rm -f $(docdir)/README.adoc
	-rm -f $(docdir)/TODO
	-rm -f $(docdir)/ChangeLog
	@echo "Removing empty directories:"
	-rmdir $(bindir)
	-rmdir $(docdir)
	@echo "Done."
