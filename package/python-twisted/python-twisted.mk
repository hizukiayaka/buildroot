################################################################################
#
# python-serial
#
################################################################################

PYTHON_TWISTED_VERSION = 14.0.0
PYTHON_TWISTED_SOURCE  = Twisted-$(PYTHON_TWISTED_VERSION).tar.bz2
PYTHON_TWISTED_SITE    = http://pypi.python.org/packages/source/T/Twisted
PYTHON_TWISTED_SETUP_TYPE = distutils

$(eval $(python-package))
