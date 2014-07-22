################################################################################
#
# gstreamer1
#
################################################################################

GSTREAMER1_VERSION = 1.5.0
GSTREAMER1_SOURCE = gstreamer-$(GSTREAMER1_VERSION).tar.gz
GSTREAMER1_SITE = /home/randy/workspace/exynos4412/sysapps/gstreamer
GSTREAMER1_SITE_METHOD = file
GSTREAMER1_INSTALL_STAGING = YES
GSTREAMER1_LICENSE_FILES = COPYING
GSTREAMER1_LICENSE = LGPLv2+ LGPLv2.1+
GSTREAMER1_INSTALL_STAGING = YES

# Checking if unaligned memory access works correctly cannot be done when cross
# compiling. For the following architectures there is no information available
# in the configure script.
ifeq ($(BR2_avr32)$(BR2_xtensa)$(BR2_microblaze),y)
GSTREAMER1_CONF_ENV = as_cv_unaligned_access=no
endif
ifeq ($(BR2_aarch64),y)
GSTREAMER1_CONF_ENV = as_cv_unaligned_access=yes
endif

GSTREAMER1_CONF_OPT = \
	--disable-examples \
	--disable-tests \
	--disable-failing-tests \
	--disable-benchmarks \
	--disable-check \
	$(if $(BR2_PACKAGE_GSTREAMER1_TRACE),,--disable-trace) \
	$(if $(BR2_PACKAGE_GSTREAMER1_PARSE),,--disable-parse) \
	$(if $(BR2_PACKAGE_GSTREAMER1_GST_DEBUG),,--disable-gst-debug --disable-debug --disable-valgrind) \
	$(if $(BR2_PACKAGE_GSTREAMER1_PLUGIN_REGISTRY),,--disable-registry) \
	$(if $(BR2_PACKAGE_GSTREAMER1_INSTALL_TOOLS),,--disable-tools)

GSTREAMER1_DEPENDENCIES = libglib2 host-pkgconf host-bison host-flex

$(eval $(autotools-package))
