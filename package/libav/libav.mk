################################################################################
#
# ffmpeg
#
################################################################################

LIBAV_VERSION = 9.10
LIBAV_SOURCE = libav-$(LIBAV_VERSION).tar.gz
LIBAV_SITE = https://libav.org/releases
LIBAV_INSTALL_STAGING = YES

LIBAV_LICENSE = LGPLv2.1+, libjpeg license
LIBAV_LICENSE_FILES = LICENSE COPYING.LGPLv2.1
ifeq ($(BR2_PACKAGE_LIBAV_GPL),y)
LIBAV_LICENSE += and GPLv2+
LIBAV_LICENSE_FILES += COPYING.GPLv2
endif

LIBAV_CONF_OPT = \
	--prefix=/usr		\
	--disable-avfilter	\
	$(if $(BR2_HAVE_DOCUMENTATION),,--disable-doc)

ifeq ($(BR2_PACKAGE_LIBAV_GPL),y)
LIBAV_CONF_OPT += --enable-gpl
else
LIBAV_CONF_OPT += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_LIBAV_NONFREE),y)
LIBAV_CONF_OPT += --enable-nonfree
else
LIBAV_CONF_OPT += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVCONV),y)
LIBAV_CONF_OPT += --enable-avconv
else
LIBAV_CONF_OPT += --disable-avconv
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVLAY),y)
LIBAV_DEPENDENCIES += sdl
LIBAV_CONF_OPT += --enable-avplay
LIBAV_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config
else
LIBAV_CONF_OPT += --disable-avplay
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVSERVER),y)
LIBAV_CONF_OPT += --enable-avserver
else
LIBAV_CONF_OPT += --disable-avserver
endif

ifeq ($(BR2_PACKAGE_LIBAV_SWSCALE),y)
LIBAV_CONF_OPT += --enable-swscale
else
LIBAV_CONF_OPT += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_ENCODERS)),all)
LIBAV_CONF_OPT += --disable-encoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_DECODERS)),all)
LIBAV_CONF_OPT += --disable-decoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_MUXERS)),all)
LIBAV_CONF_OPT += --disable-muxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_DEMUXERS)),all)
LIBAV_CONF_OPT += --disable-demuxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_PARSERS)),all)
LIBAV_CONF_OPT += --disable-parsers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_BSFS)),all)
LIBAV_CONF_OPT += --disable-bsfs \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_BSFS)),--enable-bsf=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_PROTOCOLS)),all)
LIBAV_CONF_OPT += --disable-protocols \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_FILTERS)),all)
LIBAV_CONF_OPT += --disable-filters \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_LIBAV_INDEVS),y)
LIBAV_CONF_OPT += --enable-indevs
else
LIBAV_CONF_OPT += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_LIBAV_OUTDEVS),y)
LIBAV_CONF_OPT += --enable-outdevs
else
LIBAV_CONF_OPT += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBAV_CONF_OPT += --enable-pthreads
else
LIBAV_CONF_OPT += --disable-pthreads
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBAV_CONF_OPT += --enable-zlib
LIBAV_DEPENDENCIES += zlib
else
LIBAV_CONF_OPT += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_X264),y)
LIBAV_CONF_OPT += --enable-libx264
LIBAV_DEPENDENCIES += x264
endif

ifeq ($(BR2_i386)$(BR2_x86_64),y)
# MMX on is default for x86, disable it for lowly x86-type processors
ifeq ($(BR2_x86_i386)$(BR2_x86_i486)$(BR2_x86_i586)$(BR2_x86_i686)$(BR2_x86_pentiumpro)$(BR2_x86_geode),y)
LIBAV_CONF_OPT += --disable-mmx
else
# If it is enabled, nasm is required
LIBAV_DEPENDENCIES += host-nasm
endif
endif

# Explicitly disable everything that doesn't match for ARM
# LIBAV "autodetects" by compiling an extended instruction via AS
# This works on compilers that aren't built for generic by default
ifeq ($(BR2_arm7tdmi)$(BR2_arm720t)$(BR2_arm920t)$(BR2_arm922t)$(BR2_strongarm)$(BR2_fa526),y)
LIBAV_CONF_OPT += --disable-armv5te
endif
ifeq ($(BR2_arm1136jf_s)$(BR2_arm1176jz_s)$(BR2_arm1176jzf_s),y)
LIBAV_CONF_OPT += --enable-armv6
else
LIBAV_CONF_OPT += --disable-armv6 --disable-armv6t2
endif
ifeq ($(BR2_arm10)$(BR2_arm1136jf_s)$(BR2_arm1176jz_s)$(BR2_arm1176jzf_s)$(BR2_cortex_a5)$(BR2_cortex_a8)$(BR2_cortex_a9)$(BR2_cortex_a15),y)
else
LIBAV_CONF_OPT += --disable-vfp
endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),n)
LIBAV_CONF_OPT += --disable-neon
endif

# Set powerpc altivec appropriately
ifeq ($(BR2_powerpc),y)
ifeq ($(BR2_powerpc_7400)$(BR2_powerpc_7450)$(BR2_powerpc_970),y)
LIBAV_CONF_OPT += --enable-altivec
else
LIBAV_CONF_OPT += --disable-altivec
endif
endif

LIBAV_CONF_OPT += $(call qstrip,$(BR2_PACKAGE_LIBAV_EXTRACONF))

# Override LIBAV_CONFIGURE_CMDS: FFmpeg does not support --target and others
define LIBAV_CONFIGURE_CMDS
	(cd $(LIBAV_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(LIBAV_CONF_ENV) \
	./configure \
		--enable-cross-compile	\
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os=linux \
		--extra-cflags=-fPIC \
		$(SHARED_STATIC_LIBS_OPTS) \
		$(LIBAV_CONF_OPT) \
	)
endef

$(eval $(autotools-package))
