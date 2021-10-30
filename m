Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613B9440AFE
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJ3Sa7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhJ3Sa6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tVvWAEyocSYIBR9AcGsLALyZb02ytJh04fxwsOMZ8rM=;
        b=dZRzDV9N+NIKxwDBXl2e3Q/tan7Ppy4ux9aw38+Qxn3XSeiLuKUk5lkDs+OMXP+3yMCYzd
        FWPtt/omSZUCxSv1DuwUVcW9ZJxkVBtOpnIdmVMReVqkEdwIfz4YJ7V772uc5RMKXNZ9pu
        qIAHSLt8BgoF66z4gFT8iRra7h5saKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-bnSJrRByMw68x3MMRsWsFw-1; Sat, 30 Oct 2021 14:28:19 -0400
X-MC-Unique: bnSJrRByMw68x3MMRsWsFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1DCD1808319;
        Sat, 30 Oct 2021 18:28:17 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D26425F4E9;
        Sat, 30 Oct 2021 18:28:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH 00/13] power-suppy/i2c/extcon: Add support for cht-wc PMIC without USB-PD support
Date:   Sat, 30 Oct 2021 20:28:00 +0200
Message-Id: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On many X86 devices with a Cherry Trail SoC the PMIC / battery charger
support is not fully handled by ACPI. Instead we need to load native
drivers for the PMIC and various chips surrounding the PMIC like the
charger IC. So far we mostly support the AXP288 PMIC this way, as well
as the Intel Whiskey Cove PMIC with a FUSB302 Type-C controller + other
ICs for a USB-PD, USB-3 (superspeed) and DP-altmode capable Type-C
connector, as found on the GPD win and GPD pocket mini laptops.

On the Xiaomi Mi Pad 2 tablet the Whiskey Cove PMIC is used in
a different setup then on the GPD devices, supporting only USB-2 with
BC1.2 spec charger detection on its USB connector.

This series adds support for the charger IC in this setup and for having
the extcon-intel-cht-wc code control the 5V Vbus boost converter and
the USB role-switch, which is done by the FUSB302 Type-C controller driver
in the GPD case.

This fixes the tablet not charging under Linux, host-mode only working
when booted in host-mode, as well as device-mode not working. Note
device-mode still does not work when plugged into a CDP port. I have
identified the cause for this and I plan to submit a fix later.

This series consists of the following parts:

Patch 1 + 2: Add a "intel,cht-wc-setup" device property to the Whiskey Cove
i2c-client so that various WC drivers can use this to identify which setup
they are dealing with.

Patch 3 + 4: bq25890 psy driver bug-fixes

Patch 5 - 8: bq25890 psy support for non-devicetree devices

Patch 9 + 10: bq25890 psy support for registering the builtin Vbus boost
converter as a regulator

Patch 11: Add support to the i2c-cht-wc I2C-controller driver to
instantiate an i2c-client for the attached bq25890 charger

Patch 12 + 13: extcon-intel-cht-wc add support for the USB-2 only with
BC1.2 charger detection setup

Assuming everybody is ok with this series, we need to talk about how
to merge this.

Patch 1 makes some very small changes (just a rename) to
drivers/firmware/efi code, I would like to merging this + patch 2 through
the pdx86 tree (where the real changes are). Ard, can I have your ack
for this please ?

Patch 11 depends on a header file added by patch 10, since the
i2c-cht-wc.c code otherwise sees very little changes I believe it makes
sense for patch 11 to be merged into linux-power-supply.git/for-next
together with patches 3-10. Wolfram can we have you ack for this?

Patch 12 + 13 can be merged through the extcon tree, these have no
(compile time) dependencies on the other patches.

This is all 5.17 material, and I will make sure the pdx86 patches
adding the new property will land in 5.17-rc1, hopefully the rest
will land then too, but if other bits land later that is fine too,
as long as the new property is there behavior won't change on the
GPD win/pocket and we won't get any regressions.

Regards,

Hans

p.s.

Patch 3 and 4 are pure bq25890 bugfixes and should probably be picked up
right away independent of the rest of the series.


Hans de Goede (13):
  platform/x86: Rename touchscreen_dmi to dmi_device_properties
  platform/x86: dmi_device_properties: Add setup info for boards with a
    CHT Whiskey Cove PMIC
  power: supply: bq25890: Fix race causing oops at boot
  power: supply: bq25890: Fix initial setting of the F_CONV_RATE field
  power: supply: bq25890: Add a bq25890_rw_init_data() helper
  power: supply: bq25890: Add support for skipping initialization
  power: supply: bq25890: Enable charging on boards where we skip reset
  power: supply: bq25890: Drop dev->platform_data == NULL check
  power: supply: bq25890: Add bq25890_set_otg_cfg() helper
  power: supply: bq25890: Add support for registering the Vbus boost
    converter as a regulator
  i2c: cht-wc: Add support for devices using a bq25890 charger
  extcon: intel-cht-wc: Check new "intel,cht-wc-setup" device-property
  extcon: intel-cht-wc: Add support for devices with an USB-micro-B
    connector

 MAINTAINERS                                   |   2 +-
 drivers/extcon/extcon-intel-cht-wc.c          | 119 ++++++++--
 drivers/firmware/efi/embedded-firmware.c      |   4 +-
 drivers/i2c/busses/i2c-cht-wc.c               |  77 ++++--
 drivers/platform/x86/Kconfig                  |  20 +-
 drivers/platform/x86/Makefile                 |   2 +-
 ...chscreen_dmi.c => dmi_device_properties.c} |  54 ++++-
 drivers/power/supply/bq25890_charger.c        | 223 ++++++++++++------
 include/linux/efi_embedded_fw.h               |   2 +-
 include/linux/power/bq25890_charger.h         |  15 ++
 10 files changed, 400 insertions(+), 118 deletions(-)
 rename drivers/platform/x86/{touchscreen_dmi.c => dmi_device_properties.c} (96%)
 create mode 100644 include/linux/power/bq25890_charger.h

-- 
2.31.1

