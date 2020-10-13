Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1786E28CA06
	for <lists+linux-efi@lfdr.de>; Tue, 13 Oct 2020 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbgJMIS2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Oct 2020 04:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387718AbgJMIS0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 13 Oct 2020 04:18:26 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B6F2078A;
        Tue, 13 Oct 2020 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602577105;
        bh=7aBU9lDEUXen8HeupJi7723iiG7XIrGp0iNfq6lCotc=;
        h=From:To:Cc:Subject:Date:From;
        b=y5YduaJR3w30ue1Jdje2lFT7jcXhOBW1N4BBMZdso9n5ms/gzhMEm7740YkTRHwXH
         EE0h1N4V3EJQSVJFHiQlhEhlNKgoiqpvt2NSl5q1JK+G6ud+ydgXY9JQ33cL/Gzogj
         oCojvnCna9JGKJFEiZbqJKHb3/lrWe8OrldYKabk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, Chester Lin <clin@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA init time
Date:   Tue, 13 Oct 2020 10:18:04 +0200
Message-Id: <20201013081804.17332-1-ardb@kernel.org>
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
v2: rebase onto series 'integrity: improve user feedback for invalid bootparams'

 include/linux/ima.h                   |  6 ++++++
 security/integrity/ima/ima_appraise.c | 16 ++++++++++------
 security/integrity/ima/ima_main.c     |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

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
index 3dd8c2e4314e..dfe08489faea 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -16,12 +16,19 @@
 
 #include "ima.h"
 
-static int __init default_appraise_setup(char *str)
-{
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
+static char *ima_appraise_cmdline_default __initdata;
+core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
+
+void __init ima_appraise_parse_cmdline(void)
+{
+	const char *str = ima_appraise_cmdline_default;
 	bool sb_state = arch_ima_get_secureboot();
 	int appraisal_state = ima_appraise;
 
+	if (!str)
+		return;
+
 	if (strncmp(str, "off", 3) == 0)
 		appraisal_state = 0;
 	else if (strncmp(str, "log", 3) == 0)
@@ -42,11 +49,8 @@ static int __init default_appraise_setup(char *str)
 	} else {
 		ima_appraise = appraisal_state;
 	}
-#endif
-	return 1;
 }
-
-__setup("ima_appraise=", default_appraise_setup);
+#endif
 
 /*
  * is_ima_appraise_enabled - return appraise status
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a5a2ae36a36d..2497412b1ad2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -865,6 +865,7 @@ static int __init init_ima(void)
 {
 	int error;
 
+	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
 	error = ima_init();
-- 
2.17.1

