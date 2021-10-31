Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A7440F5D
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 17:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhJaQ1g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 12:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhJaQ1U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Oct 2021 12:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635697488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnwM/VxBeSUArrlRw7RqLce8E045sD/TjiPL5pXvtrU=;
        b=cC+vVA0oUJnvlxDPpxnhWq6PoDGChQq9D+kwZAOy77enzoqn9HUPhewbUD3+h/SGxFu/X/
        kY0CPA+zy1Umk9zhFqhrSwULc1fdsK8xjD8juFgBe/5dD+1PuevAPBVBZVqZYtW69zOcRZ
        VQtNkHuF9+tiLcKcdAW6OuWZVJLmWDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-tPQqVU_6PMyu-Uijlapnhg-1; Sun, 31 Oct 2021 12:24:43 -0400
X-MC-Unique: tPQqVU_6PMyu-Uijlapnhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3DA910A8E00;
        Sun, 31 Oct 2021 16:24:40 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D6510190A7;
        Sun, 31 Oct 2021 16:24:37 +0000 (UTC)
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
Subject: [RFC 2/5] gpiolib: acpi: Make acpi_gpio_in_ignore_list() more generic
Date:   Sun, 31 Oct 2021 17:24:25 +0100
Message-Id: <20211031162428.22368-3-hdegoede@redhat.com>
In-Reply-To: <20211031162428.22368-1-hdegoede@redhat.com>
References: <20211031162428.22368-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Pass the ignore list to parse into acpi_gpio_in_ignore_list() instead
of hardcoding it to the ignore_wake module-param.

This is a preparation patch for adding support to fully ignore some
_AEI entries.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 47712b6903b5..342219a58a32 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -320,13 +320,15 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	return desc;
 }
 
-static bool acpi_gpio_in_ignore_list(const char *controller_in, int pin_in)
+static bool acpi_gpio_in_ignore_list(const char *ignore_list,
+				     const char *controller_in,
+				     int pin_in)
 {
 	const char *controller, *pin_str;
 	int len, pin;
 	char *endp;
 
-	controller = ignore_wake;
+	controller = ignore_list;
 	while (controller) {
 		pin_str = strchr(controller, '@');
 		if (!pin_str)
@@ -350,8 +352,8 @@ static bool acpi_gpio_in_ignore_list(const char *controller_in, int pin_in)
 
 	return false;
 err:
-	pr_err_once("Error invalid value for gpiolib_acpi.ignore_wake: %s\n",
-		    ignore_wake);
+	pr_err_once("Error invalid value for gpiolib_acpi.ignore_xxx: %s\n",
+		    ignore_list);
 	return false;
 }
 
@@ -363,7 +365,7 @@ static bool acpi_gpio_irq_is_wake(struct device *parent,
 	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
 		return false;
 
-	if (acpi_gpio_in_ignore_list(dev_name(parent), pin)) {
+	if (acpi_gpio_in_ignore_list(ignore_wake, dev_name(parent), pin)) {
 		dev_info(parent, "Ignoring wakeup on pin %d\n", pin);
 		return false;
 	}
-- 
2.31.1

