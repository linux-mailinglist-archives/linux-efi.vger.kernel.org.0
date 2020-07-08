Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE29218989
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGHNvm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 09:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgGHNvm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jul 2020 09:51:42 -0400
Received: from e123331-lin.nice.arm.com (adsl-70.109.242.21.tellas.gr [109.242.21.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DE6206E2;
        Wed,  8 Jul 2020 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594216301;
        bh=Fwt5Rp/zrxSRl2UwXuusY3rhdYoew/kfxO8pUURsyYE=;
        h=From:To:Cc:Subject:Date:From;
        b=C6O+pA8H4U3atv9ZVozgmumdAJHIJoGIvhtGgRbkUJ4G6qTjh5x8tENjYaexVzqrR
         ninxo5C1cPvasA7mYM15HGvEmLjqJtN+xxQGf3UsPye9sOpSIfL+KNLLa4oWfRBZft
         m8ZcPg7McKJ/PvPpPMavX1UHhoanP4u2irS6IJ4M=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xypron.glpk@gmx.de, Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3] efi/efivars: Expose RT service availability via efivars abstraction
Date:   Wed,  8 Jul 2020 16:51:35 +0300
Message-Id: <20200708135135.11163-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  bf67fad19e493b ("efi: Use more granular check for availability for variable services")

introduced a check into the efivarfs, efi-pstore and other drivers that
aborts loading of the module if not all three variable runtime services
(GetVariable, SetVariable and GetNextVariable) are supported. However, this
results in efivarfs being unavailable entirely if only SetVariable support
is missing, which is only needed if you want to make any modifications.
Also, efi-pstore and the sysfs EFI variable interface could be backed by
another implementation of the 'efivars' abstraction, in which case it is
completely irrelevant which services are supported by the EFI firmware.

So make the generic 'efivars' abstraction dependent on the availibility of
the GetVariable and GetNextVariable EFI runtime services, and add a helper
to find out whether the current 'efivars' abstraction supports writes (and
wire it up to the availability of SetVariable for the generic one)

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Fixes: bf67fad19e493b ("efi: Use more granular check for availability for variable services")
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v3 of [0], which fixed things at the wrong layer - efivarfs does not care
about EFI firmware, it only talks to the lower 'efivars' layer, which can be
implemented in various different ways.

[0] https://lore.kernel.org/linux-efi/20200708111938.20948-1-ardb@kernel.org/

 drivers/firmware/efi/efi-pstore.c |  5 +----
 drivers/firmware/efi/efi.c        | 12 ++++++++----
 drivers/firmware/efi/efivars.c    |  5 +----
 drivers/firmware/efi/vars.c       |  6 ++++++
 fs/efivarfs/super.c               |  6 +++---
 include/linux/efi.h               |  1 +
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index c2f1d4e6630b..feb7fe6f2da7 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -356,10 +356,7 @@ static struct pstore_info efi_pstore_info = {
 
 static __init int efivars_pstore_init(void)
 {
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return 0;
-
-	if (!efivars_kobject())
+	if (!efivars_kobject() || !efivar_supports_writes())
 		return 0;
 
 	if (efivars_pstore_disable)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5114cae4ec97..fdd1db025dbf 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -176,11 +176,13 @@ static struct efivar_operations generic_ops;
 static int generic_ops_register(void)
 {
 	generic_ops.get_variable = efi.get_variable;
-	generic_ops.set_variable = efi.set_variable;
-	generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
 	generic_ops.get_next_variable = efi.get_next_variable;
 	generic_ops.query_variable_store = efi_query_variable_store;
 
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
+		generic_ops.set_variable = efi.set_variable;
+		generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
+	}
 	return efivars_register(&generic_efivars, &generic_ops, efi_kobj);
 }
 
@@ -382,7 +384,8 @@ static int __init efisubsys_init(void)
 		return -ENOMEM;
 	}
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES)) {
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
 		efivar_ssdt_load();
 		error = generic_ops_register();
 		if (error)
@@ -416,7 +419,8 @@ static int __init efisubsys_init(void)
 err_remove_group:
 	sysfs_remove_group(efi_kobj, &efi_subsys_attr_group);
 err_unregister:
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME))
 		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 26528a46d99e..dcea137142b3 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -680,11 +680,8 @@ int efivars_sysfs_init(void)
 	struct kobject *parent_kobj = efivars_kobject();
 	int error = 0;
 
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return -ENODEV;
-
 	/* No efivars has been registered yet */
-	if (!parent_kobj)
+	if (!parent_kobj || !efivar_supports_writes())
 		return 0;
 
 	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 5f2a4d162795..973eef234b36 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1229,3 +1229,9 @@ int efivars_unregister(struct efivars *efivars)
 	return rv;
 }
 EXPORT_SYMBOL_GPL(efivars_unregister);
+
+int efivar_supports_writes(void)
+{
+	return __efivars && __efivars->ops->set_variable;
+}
+EXPORT_SYMBOL_GPL(efivar_supports_writes);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 12c66f5d92dd..28bb5689333a 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -201,6 +201,9 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op		= &efivarfs_d_ops;
 	sb->s_time_gran         = 1;
 
+	if (!efivar_supports_writes())
+		sb->s_flags |= SB_RDONLY;
+
 	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
 	if (!inode)
 		return -ENOMEM;
@@ -252,9 +255,6 @@ static struct file_system_type efivarfs_type = {
 
 static __init int efivarfs_init(void)
 {
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return -ENODEV;
-
 	if (!efivars_kobject())
 		return -ENODEV;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bb35f3305e55..05c47f857383 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -994,6 +994,7 @@ int efivars_register(struct efivars *efivars,
 int efivars_unregister(struct efivars *efivars);
 struct kobject *efivars_kobject(void);
 
+int efivar_supports_writes(void);
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head);
 
-- 
2.17.1

