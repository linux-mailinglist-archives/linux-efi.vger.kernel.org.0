Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A02185F0
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgGHLTp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 07:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbgGHLTp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jul 2020 07:19:45 -0400
Received: from e123331-lin.nice.arm.com (adsl-70.109.242.21.tellas.gr [109.242.21.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA24220772;
        Wed,  8 Jul 2020 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594207184;
        bh=TQ4/v9He5PisiAykRGAtO5Ofn/lM8Ly5hwiFNMZhJTs=;
        h=From:To:Cc:Subject:Date:From;
        b=GdWelWsCN/xrkakLLru25GJBOSfYL9SC7J3+UfFiS2qJBRpzvt9VN8NJls/p7oR/K
         HujYxTxxJlWOeiequAQY5F2apRngLJC/Hy6bqah4b2UDxmub0t7ApKzLOrrs10JZXM
         Ygrj0Jn/XWpb/i9/r4BLW7xG8nPmooY5MKhGenFM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xypron.glpk@gmx.de, Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] fs/efivarfs: Permit read-only access on platforms that lack SetVariable
Date:   Wed,  8 Jul 2020 14:19:38 +0300
Message-Id: <20200708111938.20948-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  bf67fad19e493b ("efi: Use more granular check for availability for variable services")

introduced a check into the efivarfs init code that aborts loading of the
module if not all three variable runtime services (GetVariable, SetVariable
and GetNextVariable) are supported. However, this results in efivarfs being
unavailable entirely if only SetVariable support is missing, which is only
needed if you want to make any modifications.

So let's relax this restriction, and only require the GetVariable services,
but force efivarfs to be mounted read-only if SetVariable is unsupported.

Since efivarfs relies on the internal 'efivars' abstraction, we should
enable that as well for platforms that lack SetVariable support. However,
such SetVariable() calls will simply return EFI_UNSUPPORTED when issued,
and the efi-pstore and efivars sysfs driver perform their own checks for
supported services anyway.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Fixes: bf67fad19e493b ("efi: Use more granular check for availability for variable services")
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: change efivars check as well

 drivers/firmware/efi/efi.c | 6 ++++--
 fs/efivarfs/super.c        | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5114cae4ec97..7b75efca0819 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -382,7 +382,8 @@ static int __init efisubsys_init(void)
 		return -ENOMEM;
 	}
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES)) {
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
 		efivar_ssdt_load();
 		error = generic_ops_register();
 		if (error)
@@ -416,7 +417,8 @@ static int __init efisubsys_init(void)
 err_remove_group:
 	sysfs_remove_group(efi_kobj, &efi_subsys_attr_group);
 err_unregister:
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME))
 		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 12c66f5d92dd..c12608f0dcd9 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -201,6 +201,9 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op		= &efivarfs_d_ops;
 	sb->s_time_gran         = 1;
 
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
+		sb->s_flags |= SB_RDONLY;
+
 	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
 	if (!inode)
 		return -ENOMEM;
@@ -252,7 +255,8 @@ static struct file_system_type efivarfs_type = {
 
 static __init int efivarfs_init(void)
 {
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				       EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME))
 		return -ENODEV;
 
 	if (!efivars_kobject())
-- 
2.17.1

