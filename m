Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC6396E4C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhFAH4H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 03:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233298AbhFAH4G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Jun 2021 03:56:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFFA4613AE;
        Tue,  1 Jun 2021 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622534065;
        bh=8pOHQuX9shbYaSu39+eSzNBxK3wlZmUbTgp8MVFeuaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pt3SF4ZHivPLeok0lewf4GQWZRtuGzoQap+VqSbnSNXumFdEQ1JE7j3ycJ9O3pbqZ
         hn1Pl408tbW0iszQCnsrOD0k0UzPYwE26dIYueRcZ9x55/jIr1n3stcewkHo5bRgcT
         tOl1XLaAbwCinR1K4a5k/S+aO0Ph2+RNqiLQ/cTt2nKVSlPfp2A5epaa07RdhpAaqS
         QiLwLPtDWEDOxfhbsqXMqaTLdWYD7j1t2SW7+5wkRxF3kG0jA0HHzIUrAkejrdI/AU
         axqsiEvUS3q8zFZIl9UxtAVSftqs46zG0ULA1oxM4X6mXz7BYMRc3NNLlq/vz0CbqO
         H7hCiHMuYMszw==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/3] x86/setup: remove CONFIG_X86_RESERVE_LOW and reservelow options
Date:   Tue,  1 Jun 2021 10:53:53 +0300
Message-Id: <20210601075354.5149-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210601075354.5149-1-rppt@kernel.org>
References: <20210601075354.5149-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The CONFIG_X86_RESERVE_LOW build time and reservelow command line option
allowed to control the amount of memory under 1M that would be reserved at
boot to avoid using memory that can be potentially clobbered by BIOS.

Since the entire range under 1M is always reserved there is no need for
these options and they can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ----
 arch/x86/Kconfig                              | 29 -------------------
 arch/x86/kernel/setup.c                       | 24 ---------------
 3 files changed, 58 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..d7d813032c51 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4775,11 +4775,6 @@
 			Reserves a hole at the top of the kernel virtual
 			address space.
 
-	reservelow=	[X86]
-			Format: nn[K]
-			Set the amount of memory to reserve for BIOS at
-			the bottom of the address space.
-
 	reset_devices	[KNL] Force drivers to reset the underlying device
 			during initialization.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..86dae426798b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1693,35 +1693,6 @@ config X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK
 	  Set whether the default state of memory_corruption_check is
 	  on or off.
 
-config X86_RESERVE_LOW
-	int "Amount of low memory, in kilobytes, to reserve for the BIOS"
-	default 64
-	range 4 640
-	help
-	  Specify the amount of low memory to reserve for the BIOS.
-
-	  The first page contains BIOS data structures that the kernel
-	  must not use, so that page must always be reserved.
-
-	  By default we reserve the first 64K of physical RAM, as a
-	  number of BIOSes are known to corrupt that memory range
-	  during events such as suspend/resume or monitor cable
-	  insertion, so it must not be used by the kernel.
-
-	  You can set this to 4 if you are absolutely sure that you
-	  trust the BIOS to get all its memory reservations and usages
-	  right.  If you know your BIOS have problems beyond the
-	  default 64K area, you can set this to 640 to avoid using the
-	  entire low memory range.
-
-	  If you have doubts about the BIOS (e.g. suspend/resume does
-	  not work or there's kernel crashes after certain hardware
-	  hotplug events) then you might want to enable
-	  X86_CHECK_BIOS_CORRUPTION=y to allow the kernel to check
-	  typical corruption patterns.
-
-	  Leave this to the default value of 64 if you are unsure.
-
 config MATH_EMULATION
 	bool
 	depends on MODIFY_LDT_SYSCALL
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 22e9a17d6ac3..9cf24b648c73 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -694,30 +694,6 @@ static void __init e820_add_kernel_range(void)
 	e820__range_add(start, size, E820_TYPE_RAM);
 }
 
-static unsigned reserve_low = CONFIG_X86_RESERVE_LOW << 10;
-
-static int __init parse_reservelow(char *p)
-{
-	unsigned long long size;
-
-	if (!p)
-		return -EINVAL;
-
-	size = memparse(p, &p);
-
-	if (size < 4096)
-		size = 4096;
-
-	if (size > 640*1024)
-		size = 640*1024;
-
-	reserve_low = size;
-
-	return 0;
-}
-
-early_param("reservelow", parse_reservelow);
-
 static void __init early_reserve_memory(void)
 {
 	/*
-- 
2.28.0

