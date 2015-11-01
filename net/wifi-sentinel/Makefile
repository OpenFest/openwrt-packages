#
# Copyright (C) 2015 OpenFest
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wifi-sentinel
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/wifi-sentinel
  SECTION:=net
  CATEGORY:=Network
  URL:=https://openfest.org
  TITLE:=Upstream connection monitor
  MAINTAINER:=Petko Bordjukov <bordjukov@gmail.com>
endef

define Package/wifi-sentinel/description
A small tool to monitor upstream connectivity and kill the wifi if it dies
endef

define Build/Compile/Default
endef
Build/Compile = $(Build/Compile/Default)

define Package/wifi-sentinel/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/wifi-sentinel.config $(1)/etc/config/wifi-sentinel
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/wifi-sentinel.sh $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/wifi-sentinel.init $(1)/etc/init.d/wifi-sentinel
endef

$(eval $(call BuildPackage,wifi-sentinel))
