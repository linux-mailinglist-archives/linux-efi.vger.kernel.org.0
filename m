Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3D2184B0
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGHKJy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 06:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGHKJx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jul 2020 06:09:53 -0400
Received: from e123331-lin.nice.arm.com (adsl-70.109.242.21.tellas.gr [109.242.21.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E0B204EC;
        Wed,  8 Jul 2020 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594202993;
        bh=3HPDilKqKFvfgsyDKY4U8Rmdl+pQHgRTapsfmcu1U64=;
        h=From:To:Cc:Subject:Date:From;
        b=YLHb6EhcvcSjbdA3EMvOU4ZCMtW07+FyLskA8GUwiUy4rnf8v6AbSmSBnooJUpRNa
         4SAo0QFkhuHQwTVtliAlq8mSuUlaJXBVEpwEnf/HytKwVZvhGpCFUkF/hFz/SSBHIa
         2b3D3Jx4NNjVrO/A0ve5VTI22VRJXSrbtkogESZc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xypron.glpk@gmx.de, Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] fs/efivarfs: Permit read-only access on platforms that lack SetVariable
Date:   Wed,  8 Jul 2020 13:09:44 +0300
Message-Id: <20200708100944.7213-1-ardb@kernel.org>
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

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Fixes: bf67fad19e493b ("efi: Use more granular check for availability for variable services")
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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

