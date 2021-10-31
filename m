Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D50440F51
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhJaQ1T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 12:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhJaQ1N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 12:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635697481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u5C+Qf6IU8slVoGKJPdCjLHtDa3yJhcLurHHBUByHR0=;
        b=IVUXgTQemQ6t/eZpMPIRYwP4FN9CeqN6ocAuxeXk8gEXjkP+bofrbpdR0XziHX5J+l10xr
        AbBVP6bP3SRS63y4jvuWWMd3w6XRiSTvlwfBgJ0NCa7F6WFqtkntz46ZM6Ja7ohu61CrGg
        3o6s3N1lNqWhUdYErGtMV56uYAMiqM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-FPctjynDNqW61vfpULqtww-1; Sun, 31 Oct 2021 12:24:36 -0400
X-MC-Unique: FPctjynDNqW61vfpULqtww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59476362F9;
        Sun, 31 Oct 2021 16:24:33 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4A0B100763D;
        Sun, 31 Oct 2021 16:24:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [RFC 0/5] ACPI/power-suppy add fuel-gauge support on cht-wc PMIC without USB-PD support devs
Date:   Sun, 31 Oct 2021 17:24:23 +0100
Message-Id: <20211031162428.22368-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Together with my earlier series to hookup the charger, Vbus boost converter
and USB role-switching:
https://lore.kernel.org/platform-driver-x86/20211030182813.116672-1-hdegoede@redhat.com/T/#t

This series also adds battery-monitoring support on the Xiaomi Mi Pad 2
and the generic parts of it should also be usable on other devices with
the same PMIC setup.

I've marked this series as a RFC because I'm not happy about the amount of
DMI quirks this series requires. The 3 separate quirks in
drivers/acpi/x86/utils.c are a bit much, but esp. when combined with also
the changes needed in drivers/gpio/gpiolib-acpi.c it all becomes a bit too
much special casing for just a single device.

So I've been thinking about alternatives for this and I've come up with
3 ways to deal with this:

1. This patch set.

2. Instead of the quirks in drivers/acpi/x86/utils.c, write an old-fashioned
"board" .c file/module which autoloads based on a DMI match and manually
instantiates i2c-clients for the BQ27520 fuel-gauge and the KTD20260 LED ctrlr.
Combined with not giving an IRQ to the fuel-gauge i2c-client (i), this allows
completely dropping the gpiolib-acpi.c changes and only requires 1 quirk for
the 2nd PWM controller in drivers/acpi/x86/utils.c. As an added bonus this
approach will also removes the need to add ACPI enumeration support to the
bq27xxx_battery code.

3. While working on this I noticed that the Mi Pad 2 DSDT actually has
full ac and battery ACPI code in its DSDT, which Linux was not trying to
use because of the Whiskey Cove PMIC ACPI HID in acpi_ac_blacklist[] in
drivers/apci/ac.c, resp. a missing _DEP for the ACPI battery.

With the native drivers disabled (the default in 5.15-rc7 without patches),
both those things fixed and a fix to intel_pmic_regs_handler() in
drivers/acpi/pmic/intel_pmic.c, battery monitoring actually starts working
somwhat!

I say somewhat because changes are not detected until userspace polls
the power_supply and switching from charge/device to host mode and
back does not work at all. This is due to the AML code for this relying
on _AEI ACPI events on virtual GPIOs on the PMIC :|  This means that we
would need to reverse engineer which events these virtual GPIO interrupts
represent; and then somehow rework the whole MFD + child driver setup
to deliver, e.g. extcon/pwrsrc events to a to-be-written GPIO driver
which supports these virtual GPIOs, while at the same time also keeping
normal native driver support since boards which USB-PD support need the
native drivers...  So OTOH this option has the promise of solving this
in a generic way which may work on more boards, OTOH it is a big mess
and we lack documentation for it.  Interestingly enough the ACPI
battery/ac code also takes ownership of the notification LED, downgrading
it from a full RGB led to a green charging LED, which is both a pre
and a con at the same time (since we would loose full RGB function).

###

Although I started out with implementing option 1, I now think I
Would personally prefer option 2. This isolates most of the code
needed to support some of these special boards into a single
(per board) file which can be build as a module which can be
autoloaded, rather then growing vmlinuz by adding quirks there.

The downside would be this sorta re-introduces the old ARM model
of one board file per (special-case) board, but there are only
1 or 2 more x86 tablets (ii) that I know about which may also
need such a board file. Which I think is managable and should
not run into the original objections against the original ARM
approach where there were way too many board files in the end.

Option 3 IMHO is a no go unless someone at Intel manages to
come up with documentation on all the virtual GPIOs which the
Windows PMIC drivers implement as method of communicating
between the PMIC driver and the AML code in the DSDT.

I'm a bit in dubio about how to progress with this, so I would
love to hear what others think about this. I would esp. appreciate
Rafael's and Mika's input on this since most of the added ugliness
in this RFC is in the ACPI code.

Regards,

Hans


i) This means that the _AEI ACPI handler for the fuel-gauge will run on
FG interrupts. This is fine it does a single I2C read and a couple of
ACPI notifies which will get ignored. Note the interrupts are "something
changed" pulses which don't need IRQ clearing.

ii) There are not that many CHT boards with a Whiskey Cove PMIC, other
then the GPD win/pocket with full USB-PD support and the Xiaomi Mi Pad 2
I'm only aware of one other, the Lenovo Yoga Book YB1-X91L/F . Since this
whole saga has gotten me quite curious and I already have the other
2 devices I've decided to spend some money on this and bought a 2nd hand
Lenovo Yoga Book YB1-X91L, whose setup is similar to the Mi Pad 2.
I should have this in about a week. I'll post a reply to this thread
with info no how the DSDT looks on the Lenovo Yoga Book and if e.g.
using the standard ACPI battery interface seems to be an option there.

iii) Note the "power: supply: bq27xxx: Add dev helper variable to
bq27xxx_battery_i2c_probe()" patch applies on top of the
"power: supply: bq27xxx: Fix kernel crash on IRQ handler register error"
bug-fix which I send out earlier.


Hans de Goede (5):
  ACPI / x86: Add 3 devices on the Xiaomi Mi Pad 2 to the always_present
    list
  gpiolib: acpi: Make acpi_gpio_in_ignore_list() more generic
  gpiolib: acpi: Add a new "ignore" module option
  power: supply: bq27xxx: Add dev helper variable to
    bq27xxx_battery_i2c_probe()
  power: supply: bq27xxx: Add support for ACPI enumeration

 drivers/acpi/x86/utils.c                   | 27 +++++++++++-
 drivers/gpio/gpiolib-acpi.c                | 40 +++++++++++++++---
 drivers/power/supply/bq27xxx_battery_i2c.c | 48 +++++++++++++++++-----
 3 files changed, 97 insertions(+), 18 deletions(-)

-- 
2.31.1

