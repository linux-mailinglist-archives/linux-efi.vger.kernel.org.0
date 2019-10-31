Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81811EAF48
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 12:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfJaLzi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 07:55:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55510 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfJaLzi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 07:55:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ933-0003Ac-Ho; Thu, 31 Oct 2019 12:55:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C84BF1C03AD;
        Thu, 31 Oct 2019 12:55:13 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:13 -0000
From:   "tip-bot2 for Javier Martinez Canillas" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/efi_test: Lock down /dev/efi_test and require
 CAP_SYS_ADMIN
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191029173755.27149-7-ardb@kernel.org>
References: <20191029173755.27149-7-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157252291350.29376.13774937345623386555.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     359efcc2c910117d2faf704ce154e91fc976d37f
Gitweb:        https://git.kernel.org/tip/359efcc2c910117d2faf704ce154e91fc976d37f
Author:        Javier Martinez Canillas <javierm@redhat.com>
AuthorDate:    Tue, 29 Oct 2019 18:37:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Oct 2019 09:40:21 +01:00

efi/efi_test: Lock down /dev/efi_test and require CAP_SYS_ADMIN

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191029173755.27149-7-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/test/efi_test.c | 8 ++++++++
 include/linux/security.h             | 1 +
 security/lockdown/lockdown.c         | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 877745c..7baf48c 100644
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
index a8d59d6..9df7547 100644
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
index 8a10b43..40b7905 100644
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
