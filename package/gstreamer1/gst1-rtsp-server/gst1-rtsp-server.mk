################################################################################
#
# gst1-libav
#
################################################################################

GST1_RTSP_SERVER_VERSION = 1.5.0
GST1_RTSP_SERVER_SOURCE = gst-rtsp-server-$(GST1_RTSP_SERVER_VERSION).tar.gz
GST1_RTSP_SERVER_SITE = /home/randy/workspace/exynos4412/sysapps/gstreamer
GST1_RTSP_SERVER_SITE_METHOD =  file
GST1_RTSP_SERVER_INSTALL_STAGING = YES

GST1_RTSP_SERVER_DEPENDENCIES = host-pkgconf gstreamer1 gst1-plugins-base

GST1_RTSP_SERVER_CONF_EXTRA_OPT = \
	--cross-prefix=$(TARGET_CROSS) \
	--target-os=linux \
	$(if $(BR2_ENABLE_DEBUG),--enable-debug,--disable-debug)

$(eval $(autotools-package))
