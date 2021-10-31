Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5043440F60
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 17:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhJaQ1i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 12:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhJaQ1W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 12:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635697490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rErM9mU4rrqY2HhIkpXGYB44QeGVz2mXY7yCgAHfu74=;
        b=GE01BB9Iri/DhWQJP6LsdgFgdnKN5bLnwJ1E723dS4kIULz6k4U1PakfOTWnkX9/tJKumi
        aIJbuoR3y8eumYj8KHYgB8LXWhl2H3pmD8JzqvzsH0Rej9Pvm2jzfFLwLYEcYhiU10Xq7o
        Ou9hbXE3FTnTHpiPMcRCLBdAh58F8wY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-SYnxvPuaMduoLH7jKyRtvw-1; Sun, 31 Oct 2021 12:24:46 -0400
X-MC-Unique: SYnxvPuaMduoLH7jKyRtvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 570D41006AA3;
        Sun, 31 Oct 2021 16:24:44 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 053DC100763D;
        Sun, 31 Oct 2021 16:24:40 +0000 (UTC)
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
Subject: [RFC 3/5] gpiolib: acpi: Add a new "ignore" module option
Date:   Sun, 31 Oct 2021 17:24:26 +0100
Message-Id: <20211031162428.22368-4-hdegoede@redhat.com>
In-Reply-To: <20211031162428.22368-1-hdegoede@redhat.com>
References: <20211031162428.22368-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new "ignore" module option to completely ignore controller@pin combos
from _AEI lists.

And add a DMI quirk to ignore the interrupt of the BQ27520 fuel-gauge IC
on the Xiaomi Mi Pad 2. On this device we use native charger + fuel-gauge
drivers because of issues with the ACPI battery implementation. The _AEI
listing of the fuel-gauge IRQ is intended for use with the unused ACPI
battery implementation and is blocking the bq27xxx fuel-gauge driver
from binding.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 342219a58a32..2d08f33a22a6 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -32,9 +32,16 @@ MODULE_PARM_DESC(ignore_wake,
 		 "controller@pin combos on which to ignore the ACPI wake flag "
 		 "ignore_wake=controller@pin[,controller@pin[,...]]");
 
+static char *ignore;
+module_param(ignore, charp, 0444);
+MODULE_PARM_DESC(ignore,
+		 "controller@pin combos which are to be ignored from _AEI lists "
+		 "ignore=controller@pin[,controller@pin[,...]]");
+
 struct acpi_gpiolib_dmi_quirk {
 	bool no_edge_events_on_boot;
 	char *ignore_wake;
+	char *ignore;
 };
 
 /**
@@ -407,6 +414,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	if (!handler)
 		return AE_OK;
 
+	if (acpi_gpio_in_ignore_list(ignore, dev_name(chip->parent), pin)) {
+		dev_info(chip->parent, "Ignoring _AEI entry for pin %d\n", pin);
+		return AE_OK;
+	}
+
 	desc = acpi_request_own_gpiod(chip, agpio, 0, "ACPI:Event");
 	if (IS_ERR(desc)) {
 		dev_err(chip->parent,
@@ -1565,6 +1577,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "INT33FF:01@0",
 		},
 	},
+	{
+		/*
+		 * On the Xiaomi Mi Pad 2 we use native battery drivers, disable
+		 * the _AEI entry for the fuel-gauge IRQ.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore = "INT33FF:03@52",
+		},
+	},
 	{} /* Terminating entry */
 };
 
@@ -1587,6 +1612,9 @@ static int __init acpi_gpio_setup_params(void)
 	if (ignore_wake == NULL && quirk && quirk->ignore_wake)
 		ignore_wake = quirk->ignore_wake;
 
+	if (ignore == NULL && quirk && quirk->ignore)
+		ignore = quirk->ignore;
+
 	return 0;
 }
 
-- 
2.31.1

