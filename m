Return-Path: <linux-efi+bounces-2998-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFBCA64928
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 11:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D551895DE6
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757B23716C;
	Mon, 17 Mar 2025 10:13:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4F2356DF;
	Mon, 17 Mar 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206439; cv=none; b=hE2jOi+2GFgb3HJHpitOYhlLo28YtS2NXI+guWFzxvXahpXKAcG6+IdOVEl7fg7qlyxXLwRFvQNwpCLNdU7CgExBGpgImzzOo6h74y/U8/KBBzvHjvfyxbjlAb6KlaH7ONEJThndKOLLgS1le9jQ49/s3S0pqDTlGvjCVfpyZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206439; c=relaxed/simple;
	bh=8+Snn7+zAHJ8zARLouJiCc2WV16JKNpnlg5grt9kebU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJVAVn2V9o3ZWRDJrtg32JyGN6C86gVWSOjh2Ht9AYzTbM6gFPe1JyIo7pGelBMR0JQtySqd20BVJaEtcDNZMn1s8kV7PteZWFFIpV61BtIHLOmDk4yp/E5YaNvTzPttphDy0K+RaWXqfq7VvxyZNUnvQLgxlFCt0SBrTGJGpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349AA2573;
	Mon, 17 Mar 2025 03:14:06 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8063F673;
	Mon, 17 Mar 2025 03:13:55 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:16 +0000
Subject: [PATCH 4/9] rtc: efi: Transition to the faux device interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-4-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=8+Snn7+zAHJ8zARLouJiCc2WV16JKNpnlg5grt9kebU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/XbWKka2eLGn0AP84f7vbJzDApSPEweWIXpC
 dS+fIQgsEKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12wAKCRAAQbq8MX7i
 mO3dEACvzO7b+JVHI/fiE0cRm+TCy2p/QMeIQsv1qkebgzoF+oQDVwE+SYoUpP9Ak9t1g+eTtLp
 VhaKNJNEWVoqhHNQMzh7YEvdDZ5EQu1lx9O/HzD1QhZQfncraXmaVYcm+7nZxWvVwJC8NdGwlpP
 5fSwTL6J0+NLaqDtmowAieW20iINeQe+Y2Xb9SdIz3jSVafmS901t9p6P29jhiU32tPPKIfw0ME
 fDyRmR42G+PdCIRh1Pu2JjpQ+K9dns+4FNqqqbtDiPfSofVdf5ONaKNmeFO/X+V0OwJUF+Jlytm
 ipDbQbtnffrWoDl1GBpwfm5qssISe1/8KM+IpIdi5p6S4WFkyWgI5imA/RuuBHjPOdfm4L86T3+
 3DmuX/Vpp7VNwAhbS/4d+7baJDyco/qzSrP/XnM4xYkU8VsIAhRdZKLjmUmzy1wSrChHobMwhkp
 7VFP8aBU9NpgtZNDDUzblhJxUogeiK8iaC9pkKFT9Fn0JO+W/vcfN3TogXypR2KpqCq4Xq6AkWF
 TK/c+6edL5l4ViBE8jZ9VN2JoL2CgA3a1n83VsTcGxfijbiZrozA4yTbYb1dI18pSWKNYK0dtQk
 6kplRF84wGuo6XWGtZQfiA7yFblCjKU9CbxUhyFvHOQoXsm4D9RDSI80oRaZYrjIzbVQ2lkbEf1
 MSBnA4QOyWhKa7w==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The EFI RTC driver does not require the creation of a platform device.
Originally, this approach was chosen for simplicity when the driver was
first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate the driver to utilize the
faux bus, given that the platform device it previously created was not
a real one anyway. This will simplify the code, reducing its footprint
while maintaining functionality.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/efi/efi.c |  3 ---
 drivers/rtc/rtc-efi.c      | 31 ++++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index eec173cb1f398d3b4f28b42c917e50e1728dc277..18deb2d212ce6944927f5e3a9a40bb6754e7ffa9 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -427,9 +427,6 @@ static int __init efisubsys_init(void)
 		}
 	}
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
-		platform_device_register_simple("rtc-efi", 0, NULL, 0);
-
 	/* We register the efi directory at /sys/firmware/efi */
 	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
 	if (!efi_kobj) {
diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index fa8bf82df9488e7d1c23c058b4a3032dde74bc6e..3d21a470e8ff9777c5eeb991f3aa9170f6351930 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/stringify.h>
 #include <linux/time.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/rtc.h>
 #include <linux/efi.h>
 
@@ -254,7 +254,7 @@ static const struct rtc_class_ops efi_rtc_ops = {
 	.proc		= efi_procfs,
 };
 
-static int __init efi_rtc_probe(struct platform_device *dev)
+static int __init efi_rtc_probe(struct faux_device *dev)
 {
 	struct rtc_device *rtc;
 	efi_time_t eft;
@@ -268,7 +268,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
-	platform_set_drvdata(dev, rtc);
+	faux_device_set_drvdata(dev, rtc);
 
 	rtc->ops = &efi_rtc_ops;
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
@@ -282,15 +282,28 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	return devm_rtc_register_device(rtc);
 }
 
-static struct platform_driver efi_rtc_driver = {
-	.driver = {
-		.name = "rtc-efi",
-	},
+static struct faux_device_ops efi_rtc_fdev_ops = {
+	.probe = efi_rtc_probe,
 };
 
-module_platform_driver_probe(efi_rtc_driver, efi_rtc_probe);
+static int __init rtc_efi_init(void)
+{
+	struct faux_device *fdev;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
+		return 0;
+
+	fdev = faux_device_create("rtc-efi", NULL, &efi_rtc_fdev_ops);
+	if (!fdev) {
+		pr_err("rtc-efi: could not create the device\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+device_initcall(rtc_efi_init);
 
 MODULE_AUTHOR("dann frazier <dannf@dannf.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("EFI RTC driver");
-MODULE_ALIAS("platform:rtc-efi");
+MODULE_ALIAS("faux:rtc-efi");

-- 
2.34.1


