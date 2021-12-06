Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69E46926D
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 10:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbhLFJhD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 04:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240803AbhLFJhC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 04:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638783213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=csNrM9LDewJv8RaF0ODXZ0/ivj87fhSIg5R6xLZbBoA=;
        b=S8Yxwl6cqHUIIQavxlPY0C2vxd5+ziGYqbv6vEbgYB8yQWnxMoLMhXEfkGCg0OUYEe7Jcp
        s+Jtn4N59ZfmYDnlUCiXyuIgIVGHGZyKsjWuiii3pOhS+Nsf/zVQm7BQW6GM+LQRxDR442
        y9cDCSR3T3HacFlD7RKEFCQz4A52gII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-ltYEhJpKPzaMNxJGYdX-SA-1; Mon, 06 Dec 2021 04:33:28 -0500
X-MC-Unique: ltYEhJpKPzaMNxJGYdX-SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A1712F23;
        Mon,  6 Dec 2021 09:33:24 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A8F05DAA5;
        Mon,  6 Dec 2021 09:33:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v4 00/20] power-suppy/i2c/extcon: Fix charger setup on Xiaomi Mi Pad 2 and Lenovo Yogabook
Date:   Mon,  6 Dec 2021 10:32:58 +0100
Message-Id: <20211206093318.45214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Here is v4 of my patch series to fix the charger setup on Xiaomi Mi Pad 2
and Lenovo Yogabook devices, as well as fix host/device mode switching.

Changes in v4:
 - Rebased on top of "power: bq25890: add POWER_SUPPLY_PROP_TEMP"
 - Add Lee to the "To" address-list for this series
 - Addressed a few small comments from Lee on the
   "mfd: intel_soc_pmic_chtwc: Add cht_wc_model data to struct intel_soc_pmic" patch

I believe that this is ready for merging now.

Since some of the later patches depend on some of the power_supply changes;
and since the Whiskey Cove MFD and cell drivers generally do not see much
changes I believe that it would be best to merge the entire series through
Sebastian's linux-power-supply tree. Wolfram has already given his ack
for merging the i2c-cht-wc patch through another tree.

Lee and Chanwoo, may we please have your Ack for merging this
entire series through Sebastian's linux-power-supply tree?

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
 drivers/power/supply/bq24190_charger.c   |  10 +-
 drivers/power/supply/bq25890_charger.c   | 396 ++++++++++++++++++-----
 drivers/power/supply/power_supply_core.c |  57 ++--
 include/linux/mfd/intel_soc_pmic.h       |   8 +
 include/linux/power/bq25890_charger.h    |  15 +
 include/linux/power_supply.h             |   5 +-
 10 files changed, 742 insertions(+), 151 deletions(-)
 create mode 100644 include/linux/power/bq25890_charger.h

-- 
2.33.1

