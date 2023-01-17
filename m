Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF466DDFD
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 13:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbjAQMqP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 07:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbjAQMqC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 07:46:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95707BB86;
        Tue, 17 Jan 2023 04:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B3BE6130E;
        Tue, 17 Jan 2023 12:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87980C433D2;
        Tue, 17 Jan 2023 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673959559;
        bh=nfaUQ9f/qaL/KRjoDGEKTPz6nI6/U2ME9FXRoaJ2ljE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s33xb2oj34xuXbqCthHoT3wFRhsIC/zlVgWFXku7b5BS855uVKD/knDzdGTfLIqsa
         pysxNMosSNqykDag6j662+HcUI38mXOwcjj0QCWCCvOCCqn1IJBG+16mAp97W+bB90
         0WRkiJmq/MU3Po6+WYd2XSOBpfZAycR4hvRJRUYDmMjeMp9PPgSCK1bKvSzMrqY/9M
         QYATjO5tTqFGBpgV8KVT/7MoaS9/tAiR5nBvRIUr+6RUeOi/5/W/GPdSZJYkoIPGhQ
         lNS8dzDwETK3tK9YSom04joN++cWhTE/f21uWzqgSZPzoqtGeBgEJMyRhVBqrq2oy9
         1qwd7YtNAdsBQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHlM5-0004Mn-GG; Tue, 17 Jan 2023 13:46:21 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] efi: efivars: drop kobject from efivars_register()
Date:   Tue, 17 Jan 2023 13:43:09 +0100
Message-Id: <20230117124310.16594-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230117124310.16594-1-johan+linaro@kernel.org>
References: <20230117124310.16594-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since commit 0f5b2c69a4cb ("efi: vars: Remove deprecated 'efivars' sysfs
interface") and the removal of the sysfs interface there are no users of
the efivars kobject.

Drop the kobject argument from efivars_register() and add a new
efivar_is_available() helper in favour of the old efivars_kobject().

Note that the new helper uses the prefix 'efivar' (i.e. without an 's')
for consistency with efivar_supports_writes() and the rest of the
interface (except the registration functions).

For the benefit of drivers with optional EFI support, also provide a
dummy implementation of efivar_is_available().

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/efi/efi.c     |  2 +-
 drivers/firmware/efi/vars.c    | 19 ++++++-------------
 drivers/firmware/google/gsmi.c |  2 +-
 fs/efivarfs/super.c            |  2 +-
 include/linux/efi.h            | 11 +++++++----
 5 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5aa8cd510bc0..a7f1a32537f1 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -197,7 +197,7 @@ static int generic_ops_register(void)
 		generic_ops.set_variable = efi.set_variable;
 		generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
 	}
-	return efivars_register(&generic_efivars, &generic_ops, efi_kobj);
+	return efivars_register(&generic_efivars, &generic_ops);
 }
 
 static void generic_ops_unregister(void)
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 0ba9f18312f5..d6b2c4f9a575 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -40,37 +40,30 @@ static efi_status_t check_var_size(bool nonblocking, u32 attributes,
 }
 
 /**
- * efivars_kobject - get the kobject for the registered efivars
+ * efivar_is_available - check if efivars is available
  *
- * If efivars_register() has not been called we return NULL,
- * otherwise return the kobject used at registration time.
+ * @return true iff evivars is currently registered
  */
-struct kobject *efivars_kobject(void)
+bool efivar_is_available(void)
 {
-	if (!__efivars)
-		return NULL;
-
-	return __efivars->kobject;
+	return __efivars != NULL;
 }
-EXPORT_SYMBOL_GPL(efivars_kobject);
+EXPORT_SYMBOL_GPL(efivar_is_available);
 
 /**
  * efivars_register - register an efivars
  * @efivars: efivars to register
  * @ops: efivars operations
- * @kobject: @efivars-specific kobject
  *
  * Only a single efivars can be registered at any time.
  */
 int efivars_register(struct efivars *efivars,
-		     const struct efivar_operations *ops,
-		     struct kobject *kobject)
+		     const struct efivar_operations *ops)
 {
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
 
 	efivars->ops = ops;
-	efivars->kobject = kobject;
 
 	__efivars = efivars;
 
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 4e2575dfeb90..60054a5d5de7 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -1029,7 +1029,7 @@ static __init int gsmi_init(void)
 	}
 
 #ifdef CONFIG_EFI
-	ret = efivars_register(&efivars, &efivar_ops, gsmi_kobj);
+	ret = efivars_register(&efivars, &efivar_ops);
 	if (ret) {
 		printk(KERN_INFO "gsmi: Failed to register efivars\n");
 		sysfs_remove_files(gsmi_kobj, gsmi_attrs);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 07e82e246666..f72c529c8ec3 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -256,7 +256,7 @@ static struct file_system_type efivarfs_type = {
 
 static __init int efivarfs_init(void)
 {
-	if (!efivars_kobject())
+	if (!efivar_is_available())
 		return -ENODEV;
 
 	return register_filesystem(&efivarfs_type);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4b27519143f5..2124e55c02d6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1039,7 +1039,6 @@ struct efivar_operations {
 
 struct efivars {
 	struct kset *kset;
-	struct kobject *kobject;
 	const struct efivar_operations *ops;
 };
 
@@ -1053,10 +1052,14 @@ struct efivars {
 #define EFI_VAR_NAME_LEN	1024
 
 int efivars_register(struct efivars *efivars,
-		     const struct efivar_operations *ops,
-		     struct kobject *kobject);
+		     const struct efivar_operations *ops);
 int efivars_unregister(struct efivars *efivars);
-struct kobject *efivars_kobject(void);
+
+#ifdef CONFIG_EFI
+bool efivar_is_available(void);
+#else
+static inline bool efivar_is_available(void) { return false; }
+#endif
 
 int efivar_supports_writes(void);
 
-- 
2.38.2

