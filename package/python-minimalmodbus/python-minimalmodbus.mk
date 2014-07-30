################################################################################
#
# python-MinimalModbus
#
################################################################################

PYTHON_MINIMALMODBUS_VERSION = 0.6
PYTHON_MINIMALMODBUS_SOURCE  = MinimalModbus-$(PYTHON_MINIMALMODBUS_VERSION).tar.gz
PYTHON_MINIMALMODBUS_SITE    = https://pypi.python.org/packages/source/M/MinimalModbus/
PYTHON_MINIMALMODBUS_LICENSE = Python Software Foundation License
PYTHON_MINIMALMODBUS_LICENSE_FILES = LICENSE.txt
PYTHON_MINIMALMODBUS_SETUP_TYPE = distutils

$(eval $(python-package))
