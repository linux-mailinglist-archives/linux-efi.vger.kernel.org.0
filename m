Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB4E8E52
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2019 18:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfJ2RjR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Oct 2019 13:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbfJ2RjQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:16 -0400
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578C420856;
        Tue, 29 Oct 2019 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572370755;
        bh=X3ehY7Q4jyB/cxVp+V5vhcNdWc86hx666eHOj+aMPs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHsD6GNjn3gq7fC84d0L1YkvHnHVJTr8UWLlntuqwtL/NrTJzWaGRFxu3XX0Xi8ML
         vZ4KGGeHIvPk6DgsrejOKcEcX91oC5uu/XJL3G1HzgqrCkNFeE+DvMu7Xi50xJ7EQ4
         pY2/C/6xr6PM5bt0NWfftzV8QhSOQ+D9dH9HFvkU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN
Date:   Tue, 29 Oct 2019 18:37:55 +0100
Message-Id: <20191029173755.27149-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029173755.27149-1-ardb@kernel.org>
References: <20191029173755.27149-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Javier Martinez Canillas <javierm@redhat.com>

The driver exposes EFI runtime services to user-space through an IOCTL
interface, calling the EFI services function pointers directly without
using the efivar API.

Disallow access to the /dev/efi_test character device when the kernel is
locked down to prevent arbitrary user-space to call EFI runtime services.

Also require CAP_SYS_ADMIN to open the chardev to prevent unprivileged
users to call the EFI runtime services, instead of just relying on the
chardev file mode bits for this.

The main user of this driver is the fwts [0] tool that already checks if
the effective user ID is 0 and fails otherwise. So this change shouldn't
cause any regression to this tool.

[0]: https://wiki.ubuntu.com/FirmwareTestSuite/Reference/uefivarinfo

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/test/efi_test.c | 8 ++++++++
 include/linux/security.h             | 1 +
 security/lockdown/lockdown.c         | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 877745c3aaf2..7baf48c01e72 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -717,6 +718,13 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
 
 static int efi_test_open(struct inode *inode, struct file *file)
 {
+	int ret = security_locked_down(LOCKDOWN_EFI_TEST);
+
+	if (ret)
+		return ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 	/*
 	 * nothing special to do here
 	 * We do accept multiple open files at the same time as we
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..9df7547afc0c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -105,6 +105,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_EFI_TEST,
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8a10b43daf74..40b790536def 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
-- 
2.17.1

