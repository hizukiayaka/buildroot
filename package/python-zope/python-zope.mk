################################################################################
#
# python-zope
#
################################################################################

PYTHON_ZOPE_VERSION = 4.1.1
PYTHON_ZOPE_SOURCE = zope.interface-$(PYTHON_ZOPE_VERSION).tar.gz
PYTHON_ZOPE_SITE = http://pypi.python.org/packages/source/z/zope.interface
PYTHON_ZOPE_LICENSE = Python Software Foundation License
PYTHON_ZOPE_LICENSE_FILES = LICENSE.txt
PYTHON_ZOPE_SETUP_TYPE = setuptools

$(eval $(python-package))
