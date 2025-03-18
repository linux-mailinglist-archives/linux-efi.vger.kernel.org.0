Return-Path: <linux-efi+bounces-3023-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88778A67A42
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330E9189DF00
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0F212D63;
	Tue, 18 Mar 2025 17:02:38 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F01C84B3;
	Tue, 18 Mar 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317357; cv=none; b=j9L8zbRgFhWZHnu9b7JMPeQnpSFnM2easckT0e4lXqO/tL0pmrapU7pMYeup3Q8ppHLLI6dJDvMm9ydq0E4JwPmTk+BgxqIVcLMpR59ey+T7IvFrQNhknncNw5ABciseay524TwbeVty214s1/VeNLYRD0RSDoQx5hCAJ/NbU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317357; c=relaxed/simple;
	bh=NxGa/BYNzmW9bOjmp9UiIR5gFv8/hjmQZjBr2tY5hTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7ukxEhHg/NWkfec0zd6q8V+355N2wikENEY7iZe6rYtS5n7jWM/P27jz4FCSOxcr19B9UaAIV5ZtBzeu1NOLEqC9qiGaXy0zLuCDns+6E25ZosjxhxzekgKYeVGhvtwOZalK3w9bPHml9cr30cx8Fx2SxYQYTmcmmGs7Vs+FwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 306561BB2;
	Tue, 18 Mar 2025 10:02:44 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CAF43F673;
	Tue, 18 Mar 2025 10:02:34 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 18 Mar 2025 17:01:42 +0000
Subject: [PATCH v2 4/8] rtc: efi: Transition to the faux device interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-plat2faux_dev-v2-4-e6cc73f78478@arm.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3019; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=NxGa/BYNzmW9bOjmp9UiIR5gFv8/hjmQZjBr2tY5hTo=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2aciebbTzQhRmgg/xlGI0w8PqOp31fwsjXo+Z
 VYP7+JPVHyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIgAKCRAAQbq8MX7i
 mOhaD/9vLdO8FgtbCKPTY7or2IRU0owZ2m7r3H583ZV3uKqgaoK41ui4StiX0NpkkGINjAItgd/
 UxRr9EbKLD30OIo+8FFRZ6Dhg48nYj8mkxleLPhnbqMW1yVmlLKhb5S+JjV9ynqETuk/USSPeoQ
 xRh5fJiIHH4O/E64SkLxwR+UGC45sy9w9MT6lh7o52d6vq5Nbu6agZkjpyOHrdSfThMrtBmpOPJ
 d2ExuvwvXSvFYs6LG03vRra/RF5RtpFBn8oXChDSNE6W9w9eCMxdAxIUo0wJUsWk99mfC4plJvA
 CI4b1a7SQM95Jn+0ANbRGas3eXOSU7/O/3i82sepeKHh1UaC4RQJ8RUFAe/Jr3eKK1WaexSLy+5
 dx6SbEazaAAwRis+75ZOrLrXFPVsYs0/j8NDAPMXZjm/kvxnlyxH/yj2Lbvr+yqjkuUqB0IGLKF
 +IW9mo1UNVPJgF58xl8ZcuGg/VptP353q3pnt6X5d+0gAMo6BKDPmXEmL9UYqBNg9DydhBaoCL3
 zRALszABPuyUwkRvpwNS1NnHdmlv/XOBbRvVzHlm8dqT9/j0/E3I6B642oGQ5DoJ3rZwWfRNod8
 9B0PoHX9I82VLmog4AnH8ERM8xrRNC31TJj171k4Mn0x3yTJBEGA5UuTDVPOa9p0GZmWqfG7UIE
 vHTr43UocxIsIMg==
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
 drivers/rtc/rtc-efi.c      | 16 +++++-----------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7309394b8fc98cf7a3424af209b752f0251c8c89..8aebc747c65bc1b63d514a50fe6f35a9e3c1af0a 100644
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
index fa8bf82df9488e7d1c23c058b4a3032dde74bc6e..681d917d541e51b37f2d59b0567caf6aa8bf05f4 100644
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
@@ -282,15 +282,9 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	return devm_rtc_register_device(rtc);
 }
 
-static struct platform_driver efi_rtc_driver = {
-	.driver = {
-		.name = "rtc-efi",
-	},
-};
-
-module_platform_driver_probe(efi_rtc_driver, efi_rtc_probe);
+module_faux_driver(rtc_efi, efi_rtc_probe, NULL,
+		   efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES));
 
 MODULE_AUTHOR("dann frazier <dannf@dannf.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("EFI RTC driver");
-MODULE_ALIAS("platform:rtc-efi");

-- 
2.34.1


