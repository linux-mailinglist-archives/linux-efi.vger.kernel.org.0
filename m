Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7D164BBA
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSRTo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRTo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:44 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D30B24672;
        Wed, 19 Feb 2020 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132783;
        bh=3UF3ZqpkynaO6Ip8hQWd7SB5UbR3xruI+k9FQzuTYMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KN1wiq1byoNz5SGoBc+33mTG4Unljvum+ji6UJaKIiC7LGC++s+l5fIRXaZnIPl3h
         gzq3QkARE/h8ebdi7P4u2RY9AZqG/x1jOWMPel/VYZI3o11GI/jYRZBiNLQAkpyFut
         Xg5qoGmq7aZIPqzQnMW2bZaTq2jRudtz9isCu23M=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH 4/9] efi: register EFI rtc platform device only when available
Date:   Wed, 19 Feb 2020 18:19:02 +0100
Message-Id: <20200219171907.11894-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Drop the separate driver that registers the EFI rtc on all EFI
systems that have runtime services available, and instead, move
the registration into the core EFI code, and make it conditional
on whether the actual time related services are available.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c     |  3 ++
 drivers/rtc/Makefile           |  4 ---
 drivers/rtc/rtc-efi-platform.c | 35 --------------------
 3 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index abf4c02e0201..69a585106d30 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -321,6 +321,9 @@ static int __init efisubsys_init(void)
 		}
 	}
 
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
+		platform_device_register_simple("rtc-efi", 0, NULL, 0);
+
 	/* We register the efi directory at /sys/firmware/efi */
 	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
 	if (!efi_kobj) {
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 4ac8f19fb631..24c7dfa1bd7d 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -12,10 +12,6 @@ obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 obj-$(CONFIG_RTC_MC146818_LIB)	+= rtc-mc146818-lib.o
 rtc-core-y			:= class.o interface.o
 
-ifdef CONFIG_RTC_DRV_EFI
-rtc-core-y			+= rtc-efi-platform.o
-endif
-
 rtc-core-$(CONFIG_RTC_NVMEM)		+= nvmem.o
 rtc-core-$(CONFIG_RTC_INTF_DEV)		+= dev.o
 rtc-core-$(CONFIG_RTC_INTF_PROC)	+= proc.o
diff --git a/drivers/rtc/rtc-efi-platform.c b/drivers/rtc/rtc-efi-platform.c
deleted file mode 100644
index 6c037dc4e3dc..000000000000
--- a/drivers/rtc/rtc-efi-platform.c
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Moved from arch/ia64/kernel/time.c
- *
- * Copyright (C) 1998-2003 Hewlett-Packard Co
- *	Stephane Eranian <eranian@hpl.hp.com>
- *	David Mosberger <davidm@hpl.hp.com>
- * Copyright (C) 1999 Don Dugger <don.dugger@intel.com>
- * Copyright (C) 1999-2000 VA Linux Systems
- * Copyright (C) 1999-2000 Walt Drummond <drummond@valinux.com>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/efi.h>
-#include <linux/platform_device.h>
-
-static struct platform_device rtc_efi_dev = {
-	.name = "rtc-efi",
-	.id = -1,
-};
-
-static int __init rtc_init(void)
-{
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
-		if (platform_device_register(&rtc_efi_dev) < 0)
-			pr_err("unable to register rtc device...\n");
-
-	/* not necessarily an error */
-	return 0;
-}
-module_init(rtc_init);
-- 
2.17.1

