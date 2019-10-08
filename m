Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A8CF78F
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 12:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfJHKzS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 06:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbfJHKzR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Oct 2019 06:55:17 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E76E42A09B0
        for <linux-efi@vger.kernel.org>; Tue,  8 Oct 2019 10:55:16 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id y18so6812836wrw.8
        for <linux-efi@vger.kernel.org>; Tue, 08 Oct 2019 03:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jr4VyvH8+nrlZUaxZqpcfLSaXw2hE019wUytfSWb3rI=;
        b=Z18iGDIM9V0L+7bOBEvJoUcOrshdH81xADW+JvuUF1mY/EkvnNr9a09OVUp/D+EZQw
         w4SZEQqWuy+xxJTH9bQJBfff8XQ9V7aEXIFSJnEz1ptWV4Qu6vo6buDnaZKv6r6XnU5R
         kvsm5msmFlQBC5+l5Z2q/H3IYlLAn8zSerPQX22e2iD4ex5zHSpFUYl6LNpF5bBi6s+O
         Q6bp28b5xaIrV6E3dwk8Jo9fzZ6pCcwuF5nFTRvvBZk2Ho3Xiqfb8DBVbAd8CmC9118S
         vyJhJMc4Rv7VOcrwTuqphUFNSEe5c2i0+L/4Zm9HlHJFlP3jbIlCP8OftQqeb5k/L+9v
         pmFw==
X-Gm-Message-State: APjAAAUQlJjeDQ7XW21F6a40R041lmzZ6E5sT9wwI2LNGLjhYAEO9l4f
        oIy6sM+TdXkZoyZHM0wSYeQ1cHPtbHo1ZXcyErTuINXDU2fNAOzepVaquA28GYS/TQDsyYzpCrb
        kuH4V/DE5rx240EI1Tsko
X-Received: by 2002:a05:600c:2107:: with SMTP id u7mr3475168wml.86.1570532115641;
        Tue, 08 Oct 2019 03:55:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGrNSa6gwRjEcpPPQ0ut0maTS6ToIdDTt4FYqN4se+LW3SVXdX7p8JCpIZiHgUMmIRnNeuGQ==
X-Received: by 2002:a05:600c:2107:: with SMTP id u7mr3475154wml.86.1570532115396;
        Tue, 08 Oct 2019 03:55:15 -0700 (PDT)
Received: from minerva.home ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id c132sm3877095wme.27.2019.10.08.03.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 03:55:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Hu <ivan.hu@canonical.com>, Laszlo Ersek <lersek@redhat.com>,
        linux-efi@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Micah Morton <mortonm@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Garrett <matthewgarrett@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v2] efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN
Date:   Tue,  8 Oct 2019 12:55:10 +0200
Message-Id: <20191008105510.6975-1-javierm@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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

---

Changes in v2:
- Also disable /dev/efi_test access when the kernel is locked down as
  suggested by Matthew Garrett.
- Add Acked-by tag from Laszlo Ersek.

 drivers/firmware/efi/test/efi_test.c | 8 ++++++++
 include/linux/security.h             | 1 +
 security/lockdown/lockdown.c         | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 877745c3aaf..7baf48c01e7 100644
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
index a8d59d612d2..9df7547afc0 100644
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
index 8a10b43daf7..40b790536de 100644
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
2.21.0

