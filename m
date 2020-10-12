Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA628B057
	for <lists+linux-efi@lfdr.de>; Mon, 12 Oct 2020 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgJLIgo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Oct 2020 04:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLIgn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Oct 2020 04:36:43 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A12B20714;
        Mon, 12 Oct 2020 08:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602491803;
        bh=xGcSgxMYQFxatWCkytqqmruYRAdLAQg4c++Ihzfeilk=;
        h=From:To:Cc:Subject:Date:From;
        b=bPmPBhsiqQe/SZalLiOr6kMou1sPqsknAquA/3ICQz/fvbGe+NAiqnOKRNyekagSF
         7wtZRPFd6l0AOUH5qxtDcsAi4pbXb+AT6Fr010MvyvLoKBmzZtnmAKV3t/4yrzodUw
         kX7eT2VZ/6i2icJJWPo90BGu4reJThTOWQZLl/w8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, Chester Lin <clin@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] ima: defer arch_ima_get_secureboot() call to IMA init time
Date:   Mon, 12 Oct 2020 10:36:31 +0200
Message-Id: <20201012083631.12724-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Chester reports that it is necessary to introduce a new way to pass
the EFI secure boot status between the EFI stub and the core kernel
on ARM systems. The usual way of obtaining this information is by
checking the SecureBoot and SetupMode EFI variables, but this can
only be done after the EFI variable workqueue is created, which
occurs in a subsys_initcall(), whereas arch_ima_get_secureboot()
is called much earlier by the IMA framework.

However, the IMA framework itself is started as a late_initcall,
and the only reason the call to arch_ima_get_secureboot() occurs
so early is because it happens in the context of a __setup()
callback that parses the ima_appraise= command line parameter.

So let's refactor this code a little bit, by using a core_param()
callback to capture the command line argument, and deferring any
reasoning based on its contents to the IMA init routine.

Cc: Chester Lin <clin@suse.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Link: https://lore.kernel.org/linux-arm-kernel/20200904072905.25332-2-clin@suse.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/ima.h                   |  6 +++++
 security/integrity/ima/ima_appraise.c | 24 +++++++++++---------
 security/integrity/ima/ima_main.c     |  1 +
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index d15100de6cdd..8aefee9c36ab 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -27,6 +27,12 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 
+#ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
+extern void ima_appraise_parse_cmdline(void);
+#else
+static inline void ima_appraise_parse_cmdline(void) {}
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index b8848f53c8cc..a0135dbf2a64 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -16,26 +16,28 @@
 
 #include "ima.h"
 
-static int __init default_appraise_setup(char *str)
-{
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
+static char *ima_appraise_cmdline_default __initdata;
+core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
+
+void __init ima_appraise_parse_cmdline(void)
+{
+	if (!ima_appraise_cmdline_default)
+		return;
 	if (arch_ima_get_secureboot()) {
 		pr_info("Secure boot enabled: ignoring ima_appraise=%s boot parameter option",
-			str);
-		return 1;
+			ima_appraise_cmdline_default);
+		return;
 	}
 
-	if (strncmp(str, "off", 3) == 0)
+	if (strncmp(ima_appraise_cmdline_default, "off", 3) == 0)
 		ima_appraise = 0;
-	else if (strncmp(str, "log", 3) == 0)
+	else if (strncmp(ima_appraise_cmdline_default, "log", 3) == 0)
 		ima_appraise = IMA_APPRAISE_LOG;
-	else if (strncmp(str, "fix", 3) == 0)
+	else if (strncmp(ima_appraise_cmdline_default, "fix", 3) == 0)
 		ima_appraise = IMA_APPRAISE_FIX;
-#endif
-	return 1;
 }
-
-__setup("ima_appraise=", default_appraise_setup);
+#endif
 
 /*
  * is_ima_appraise_enabled - return appraise status
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..31d72cf04768 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -850,6 +850,7 @@ static int __init init_ima(void)
 {
 	int error;
 
+	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
 	error = ima_init();
-- 
2.17.1

