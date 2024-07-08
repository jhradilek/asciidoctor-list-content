# A custom makefile for the list-content utility
# Copyright (C) 2022 Jaromir Hradilek

# This program is  free software:  you can redistribute it and/or modify it
# under  the terms  of the  GNU General Public License  as published by the
# Free Software Foundation, version 3 of the License.
#
# This program  is  distributed  in the hope  that it will  be useful,  but
# WITHOUT  ANY WARRANTY;  without  even the implied  warranty of MERCHANTA-
# BILITY  or  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the  GNU General Public License  along
# with this program. If not, see <http://www.gnu.org/licenses/>.

# General information about the utility:
NAME    = list-content
VERSION = 0.1.1

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
