Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701ED624641
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 16:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKJPqY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 10:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKJPqY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 10:46:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C022B14;
        Thu, 10 Nov 2022 07:46:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ABFCB82224;
        Thu, 10 Nov 2022 15:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6857AC433C1;
        Thu, 10 Nov 2022 15:46:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c5sSVGv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668095176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ps8DyLnWUFEOMzV5Hl0ko397uOHYl+uddPYlp1wLApA=;
        b=c5sSVGv6D3cV3lHNPMTzl8p/lxxtl99+WBdwq8MiWaQvqdWmiWnsbgwBDBGUEM4HhVm0C2
        GhC8wkz5IEFE0gm1h3tCP1+av16pMxsvH//4bYbufxRTzdJtM+bg65b1365iXrl19AZJoq
        ME2zkmPmdY0Zoxg5O0T4TcXBcNuhOGk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd02204a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Nov 2022 15:46:16 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH] efi: vars: allow passing fmode= and dmode= when mounting
Date:   Thu, 10 Nov 2022 16:45:47 +0100
Message-Id: <20221110154547.472519-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The default wide-open permissions of efivarfs make the prospect of
storing secrets there a bit sketchy. Currently systemd does this, and
then pid 1 takes care of chmodding particular nodes. But this is limited
and error-prone. Rather, allow passing an explicit dmode for directories
and fmode for files.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>
Suggested-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/efivarfs/internal.h |  5 ++++
 fs/efivarfs/super.c    | 60 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 8ebf3a6a8aa2..ea1ca322d247 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -24,6 +24,11 @@ struct efivar_entry {
 	struct kobject kobj;
 };
 
+struct efivarfs_sb_info {
+	umode_t dmode;
+	umode_t fmode;
+};
+
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head);
 
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 6780fc81cc11..45edbb1550e9 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -8,6 +8,7 @@
 #include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/ucs2_string.h>
@@ -107,6 +108,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 			     unsigned long name_size, void *data)
 {
 	struct super_block *sb = (struct super_block *)data;
+	struct efivarfs_sb_info *sbi = sb->s_fs_info;
 	struct efivar_entry *entry;
 	struct inode *inode = NULL;
 	struct dentry *dentry, *root = sb->s_root;
@@ -144,7 +146,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
 	strreplace(name, '/', '!');
 
-	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
+	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | sbi->fmode, 0,
 				   is_removable);
 	if (!inode)
 		goto fail_name;
@@ -187,6 +189,7 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 
 static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct efivarfs_sb_info *sbi = sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct dentry *root;
 	int err;
@@ -202,7 +205,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!efivar_supports_writes())
 		sb->s_flags |= SB_RDONLY;
 
-	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
+	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | sbi->dmode, 0, true);
 	if (!inode)
 		return -ENOMEM;
 	inode->i_op = &efivarfs_dir_inode_operations;
@@ -226,12 +229,58 @@ static int efivarfs_get_tree(struct fs_context *fc)
 	return get_tree_single(fc, efivarfs_fill_super);
 }
 
+enum {
+	Opt_dmode,
+	Opt_fmode,
+};
+
+static const struct fs_parameter_spec efivarfs_parameters[] = {
+	fsparam_u32oct("dmode",			Opt_dmode),
+	fsparam_u32oct("fmode",			Opt_fmode),
+	{}
+};
+
+static int efivarfs_parse_param(struct fs_context *fc,
+				struct fs_parameter *param)
+{
+	struct efivarfs_sb_info *sbi = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, efivarfs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_dmode:
+		sbi->dmode = result.uint_32;
+		break;
+	case Opt_fmode:
+		sbi->fmode = result.uint_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
+	.parse_param	= efivarfs_parse_param,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
 {
+	struct efivarfs_sb_info *sbi;
+
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sbi->dmode = 0755;
+	sbi->fmode = 0644;
+	fc->s_fs_info = sbi;
+
 	fc->ops = &efivarfs_context_ops;
 	return 0;
 }
@@ -245,10 +294,11 @@ static void efivarfs_kill_sb(struct super_block *sb)
 }
 
 static struct file_system_type efivarfs_type = {
-	.owner   = THIS_MODULE,
-	.name    = "efivarfs",
+	.owner   	 = THIS_MODULE,
+	.name    	 = "efivarfs",
 	.init_fs_context = efivarfs_init_fs_context,
-	.kill_sb = efivarfs_kill_sb,
+	.parameters	 = efivarfs_parameters,
+	.kill_sb 	 = efivarfs_kill_sb,
 };
 
 static __init int efivarfs_init(void)
-- 
2.38.1

