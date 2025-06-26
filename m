Return-Path: <linux-efi+bounces-4025-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF8AEA961
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 00:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A1464401B
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B792609F5;
	Thu, 26 Jun 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oCRkkHgQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8C23B634;
	Thu, 26 Jun 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975982; cv=none; b=QZ4OrqXblkxFv2oh2KGAJI1EuHzSIW4OfPHNmDDooLtNfENwCUcyyU2AGNOdjLUyzhJAe/zXbIxOY5P1szoKY+ZE13s1VnlTrkZmp5lJ1G5Hm05Fz5Hc1udVKsstcb4P+OCjH6S2e006+yNDG1970dnDhNecSG7Yoqcq34rJ5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975982; c=relaxed/simple;
	bh=fyRBtgsoCHCOCtc2qoRnJHcUHh5c+cq4eDblHwxfPOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lJRL1TrtSBZ4XVZfNVxEGXie0E8HDN0Yl1+1BB/2FXUMGuKoMHeV+WNypavDYXx0VnclQgVzRCs73nyXyTpPGdqmloYXosg8NFFHBKmhW5z3+xsvRAtMwCGiP/Mi+9yt3YeN2M+PT1bR/hvUO5lvqkWp7Woyw2hyuNiCp6BL944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oCRkkHgQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 7F8EF21176F8; Thu, 26 Jun 2025 15:12:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F8EF21176F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750975974;
	bh=gBB0C/nJUwH10ifIhkG/m/bBdR8TqoQ9jnE1BRZnpyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCRkkHgQO2+hARBAoKKKuUWLeeke/zQTjfE/+5VjSYx9A3Q2+zAL+z0EqX/Y9S1Zl
	 AmQXsk1zh3PnI+qLr9707xAnOE2U5hSI6rpNMiCeFMs9wA8U8gS5J1E7RthySDxxxq
	 PMauYw1pJljt8/Eg9LhtJYbNf+HT8Z8XiF4VP6sU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 2/2] efi: introduce EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
Date: Thu, 26 Jun 2025 15:10:39 -0700
Message-Id: <1750975839-32463-3-git-send-email-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Add a kernel configuration option to lock down the kernel, to restrict
userspace's ability to modify the running kernel when Secure Boot is
enabled.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/firmware/efi/Kconfig | 10 ++++++++++
 drivers/firmware/efi/efi.c   |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 5fe61b9ab5f9..4e827354e919 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -248,6 +248,16 @@ config EFI_DISABLE_RUNTIME
 
 	  This default can be overridden by using the efi=runtime option.
 
+config EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
+	bool "Lock down the kernel in EFI Secure Boot mode"
+	default n
+	depends on EFI
+	depends on SECURITY_LOCKDOWN_LSM
+	select SECURITY_LOCKDOWN_LSM_EARLY
+	help
+	  Enabling this option results in kernel lockdown being
+	  set in integrity mode if EFI Secure Boot is enabled.
+
 config EFI_COCO_SECRET
 	bool "EFI Confidential Computing Secret Area Support"
 	help
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7309394b8fc9..b7a5fc79b065 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -427,6 +427,15 @@ static int __init efisubsys_init(void)
 		}
 	}
 
+#ifdef CONFIG_EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		if (efi_get_secureboot_mode(efi.get_variable) ==
+		    efi_secureboot_mode_enabled)
+			security_lock_kernel_down("EFI Secure Boot",
+						  LOCKDOWN_INTEGRITY_MAX);
+	}
+#endif
+
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
 		platform_device_register_simple("rtc-efi", 0, NULL, 0);
 
-- 
2.49.0


