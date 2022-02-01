Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824FF4A5CD5
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiBANHr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:07:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238362AbiBANHq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oWlhB4x+XjLX1LmA7f8ij3o4BcAO8F5q0C5T/ifno7Y=;
        b=cdO7j97gPw/ob1PmPJceS3rtN3lz+9VfiMjTnoPP4vIL+ai3XjPXmniAbCiMeXapf+E8GR
        gu8B3GgAfUy4BviHFQl/3CXBkN7TT3naiJglIXzg4DoaKwCFCKrZMJrZ1nksoZrQXsbbBL
        Ui8Lq4Edcl5QuRY9kKdzgajVr6mR7a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-B6U_Id-kPGuFXi33aoCmYQ-1; Tue, 01 Feb 2022 08:07:38 -0500
X-MC-Unique: B6U_Id-kPGuFXi33aoCmYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50BCA1006AC5;
        Tue,  1 Feb 2022 13:07:35 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 286657DE26;
        Tue,  1 Feb 2022 13:07:06 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v5 00/20] power-suppy/i2c/extcon: Fix charger setup on Xiaomi Mi Pad 2 and Lenovo Yogabook
Date:   Tue,  1 Feb 2022 14:06:46 +0100
Message-Id: <20220201130706.46685-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Sebastian,

Here is v5 of my patch series to fix the charger setup on Xiaomi Mi Pad 2
and Lenovo Yogabook devices, as well as fix host/device mode switching.

v5 contains a few small tweaks suggested by Andy + adds his Reviewed-by
to a bunch of patches, otherwise this is completely unchanged from v4.

I believe that this series is ready for merging now.

Since patches 14-20 rely on the power-supply changes from patch 1-13 and
since they all touch files which generally do not see much changes, the
intention is for this entire series to be merged through your (Sebastian's)
linux-power-supply tree. Patches 14-20 all have acks from the relevant
subsystem maintainers for merging them through the linux-power-supply tree.

###

For more details on this series, here is some info from the v2
cover-letter:

So far almost all the kernel code surrounding the Cherry Trail Whiskey Cove
PMIC has been developed on the GPD win / pocket devices and it has various
assumption based on that. In the mean time I've learned (and gotten access
to) about 2 more designs and none of the 3 now known designs use a single
standard setup for the charger, fuel-gauge and other chips surrounding the
PMIC / charging+data USB port:

1. The GPD Win and GPD Pocket mini-laptops, these are really 2 models
but the Pocket re-uses the GPD Win's design in a different housing:

The WC PMIC is connected to a TI BQ24292i charger, paired with
a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
a PI3USB30532 USB switch, for a fully functional Type-C port.

2. The Xiaomi Mi Pad 2:

The WC PMIC is connected to a TI BQ25890 charger, paired with
a TI BQ27520 fuelgauge, using the TI BQ25890 for BC1.2 charger type
detection, for a USB-2 only Type-C port without PD.

3. The Lenovo Yoga Book YB1-X90 / Lenovo Yoga Book YB1-X91 series:

The WC PMIC is connected to a TI BQ25892 charger, paired with
a TI BQ27542 fuelgauge, using the WC PMIC for BC1.2 charger type
detection and using the BQ25892's Mediatek Pump Express+ (1.0)


Unlike what is normal on X86 this diversity in designs is not handled /
abstracted away by the ACPI tables.

This series takes care of making sure that charging and device/host mode
switching also works on the Xiaomi Mi Pad 2 and the Lenovo Yogabook.

Patches  1-13: Prepare the bq25890 power_supply driver to fully support
               the Mi Pad 2 and the Yogabook. Note this includes a new
               version of 2 bq25890 patches send earlier by Yauhen Kharuzhy
Patch 14:      Adds the intel_cht_wc_get_model() helper
Patch 15:      Uses this intel_cht_wc_get_model() value to instantiate an
               i2c-client with the right type and properties for the charger
               IC used on the board (instead of harcoding the GPD values)
Patches 16-20: Modify the extcon code to provide charger-detection results
               to the charger driver and to take care of the Vbus boost
               regulator control (for host-mode) and device/host mode
               switching

I've tried to keep the power_supply patches as generic as possible while
focussing some of the special handling these boards need in the
WC PMIC MFD and cell drivers, which will only get loaded on these boards.

Regards,

Hans

p.s.

Sebastian, I also have another power-supply series pending
for merging into -next:
https://lore.kernel.org/linux-pm/20220106110608.66231-1-hdegoede@redhat.com/


Hans de Goede (17):
  power: supply: core: Refactor
    power_supply_set_input_current_limit_from_supplier()
  power: supply: bq25890: Add a bq25890_rw_init_data() helper
  power: supply: bq25890: Add support to skip reset at probe() /
    remove()
  power: supply: bq25890: Add support to read back the settings from the
    chip
  power: supply: bq25890: Enable charging on boards where we skip reset
  power: supply: bq25890: Drop dev->platform_data == NULL check
  power: supply: bq25890: Add bq25890_set_otg_cfg() helper
  power: supply: bq25890: Add support for registering the Vbus boost
    converter as a regulator
  power: supply: bq25890: On the bq25892 set the IINLIM based on
    external charger detection
  power: supply: bq25890: Use the devm_regmap_field_bulk_alloc() helper
  mfd: intel_soc_pmic_chtwc: Add cht_wc_model data to struct
    intel_soc_pmic
  i2c: cht-wc: Make charger i2c-client instantiation board/device-model
    specific
  extcon: intel-cht-wc: Use new cht_wc_model intel_soc_pmic field
  extcon: intel-cht-wc: Support devs with Micro-B / USB-2 only Type-C
    connectors
  extcon: intel-cht-wc: Refactor cht_wc_extcon_get_charger()
  extcon: intel-cht-wc: Add support for registering a power_supply
    class-device
  extcon: intel-cht-wc: Report RID_A for ACA adapters

Yauhen Kharuzhy (3):
  power: supply: bq25890: Rename IILIM field to IINLIM
  power: supply: bq25890: Reduce reported CONSTANT_CHARGE_CURRENT_MAX
    for low temperatures
  power: supply: bq25890: Support higher charging voltages through Pump
    Express+ protocol

 drivers/extcon/Kconfig                   |   2 +
 drivers/extcon/extcon-intel-cht-wc.c     | 240 ++++++++++++--
 drivers/i2c/busses/i2c-cht-wc.c          | 120 +++++--
 drivers/mfd/intel_soc_pmic_chtwc.c       |  40 +++
 drivers/power/supply/bq24190_charger.c   |  12 +-
 drivers/power/supply/bq25890_charger.c   | 396 ++++++++++++++++++-----
 drivers/power/supply/power_supply_core.c |  57 ++--
 include/linux/mfd/intel_soc_pmic.h       |   8 +
 include/linux/power/bq25890_charger.h    |  15 +
 include/linux/power_supply.h             |   5 +-
 10 files changed, 744 insertions(+), 151 deletions(-)
 create mode 100644 include/linux/power/bq25890_charger.h

-- 
2.33.1

