################################################################################
#
# python-yaml
#
################################################################################

PYTHON_YAML_VERSION = 3.11
PYTHON_YAML_SOURCE  = PyYAML-$(PYTHON_YAML_VERSION).tar.gz
PYTHON_YAML_SITE    = http://pyyaml.org/download/pyyaml
PYTHON_YAML_LICENSE = Python Software Foundation License
PYTHON_YAML_LICENSE_FILES = LICENSE.txt
PYTHON_YAML_SETUP_TYPE = distutils

$(eval $(python-package))
