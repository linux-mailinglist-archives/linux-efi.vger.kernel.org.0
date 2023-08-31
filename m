Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04678F058
	for <lists+linux-efi@lfdr.de>; Thu, 31 Aug 2023 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbjHaPbS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Aug 2023 11:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHaPbS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Aug 2023 11:31:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02205E4F
        for <linux-efi@vger.kernel.org>; Thu, 31 Aug 2023 08:31:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59504967e00so13019957b3.2
        for <linux-efi@vger.kernel.org>; Thu, 31 Aug 2023 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693495874; x=1694100674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYGG+XzZagKaNgC6mCifv/7D9GeC0jOA4/MyNnHVbhA=;
        b=v7ZoRswLLJHq4g26c6qRoNEwLsfNBEtBuBpc0PFXhWDZ44RewrHh6mZZiqFB4pd+8L
         TsSTtbxhSBUdYYNu6yCqDKMIK0oEWdXJ81rgX6oDFoWTYPxuAt3Av32AtRC6CITOZvEZ
         AuBgpQOx8x9GtLpt+PPf2kQBB4LUPcwl5KipDXE6MJ9yY+hXPpjYeA3Sx0izAed8GEW4
         zxY9e9leGwcWBl5cwKDXNCoc45YfGWCTu8ggqHOLHMeRqQAIdfPFw219M45JrDKJnGlk
         lNevUM0x2j9C7w9jhTif/PO/eZqLw0J7toNvLZVBppBTLIh15CbVrfk3ba8iO0SF+v7y
         VFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495874; x=1694100674;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYGG+XzZagKaNgC6mCifv/7D9GeC0jOA4/MyNnHVbhA=;
        b=TGmsEIsZIlhfUkyhCR6ai5HJo3P3Q3VY7qJ88U6aazlLmFJEPCJQBueYZti52rFpca
         T2tABGIrTTIci9muSTFz9anhFvX4vXLZZoViFmYFn7DuCdXvIbvBIV6MU/dQH2o+I6Dw
         RVS1jB3gO7m6SkR5fZDKIAvkTKUq6WYLrUeyW4jf0nfnD22TUIljbGBKTFIAt/vVg9sa
         8lPDgI3oESM88Yk7lD+m/IAzwYrzMYMw2/n195T9QyZyLij4lKlWaEZMXm7ox7i/vpwQ
         4Gx17DeirtGYCN6k0QMhlxwdGo1RaHJSEeHdDAckjdFSD6bhlT6qNBMX1m1p5ItqKT2E
         SaSQ==
X-Gm-Message-State: AOJu0YyuV6nzt4r9CCGoCsYwlDtAgyMshmJUCV90OvTdUfq06ABQPvp2
        dFyI7SXpcayM+aD1JzCYSOwY+lZ11bh3yw==
X-Google-Smtp-Source: AGHT+IEIHYQdIhGB2Ji1oeSVhSO+5aRlsotSLt3BwRj5CHDEB8OxnCqh7cVIonfM7celv0tWBDGKSJWtWjG97A==
X-Received: from jiao.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:10f3])
 (user=jiaozhou job=sendgmr) by 2002:a05:6902:11c9:b0:d20:7752:e384 with SMTP
 id n9-20020a05690211c900b00d207752e384mr560ybu.3.1693495874213; Thu, 31 Aug
 2023 08:31:14 -0700 (PDT)
Date:   Thu, 31 Aug 2023 15:31:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831153108.2021554-1-jiaozhou@google.com>
Subject: [PATCH] kernel: Add Mount Option For Efivarfs
From:   Jiao Zhou <jiaozhou@google.com>
To:     Linux FS Development <linux-fsdevel@vger.kernel.org>
Cc:     Jiao Zhou <jiaozhou@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add uid and gid in efivarfs's mount option, so that
we can mount the file system with ownership. This approach
 is used by a number of other filesystems that don't have
native support for ownership.

TEST=FEATURES=test emerge-reven chromeos-kernel-5_15

Signed-off-by: Jiao Zhou <jiaozhou@google.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308291443.ea96ac66-oliver.sang@intel.com
---
 fs/efivarfs/inode.c    |  4 +++
 fs/efivarfs/internal.h |  9 ++++++
 fs/efivarfs/super.c    | 65 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 939e5e242b98..de57fb6c28e1 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -20,9 +20,13 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 				const struct inode *dir, int mode,
 				dev_t dev, bool is_removable)
 {
+	struct efivarfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = new_inode(sb);
+	struct efivarfs_mount_opts *opts = &fsi->mount_opts;
 
 	if (inode) {
+		inode->i_uid = opts->uid;
+		inode->i_gid = opts->gid;
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 30ae44cb7453..57deaf56d8e2 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -8,6 +8,15 @@
 
 #include <linux/list.h>
 
+struct efivarfs_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
+};
+
+struct efivarfs_fs_info {
+	struct efivarfs_mount_opts mount_opts;
+};
+
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
 extern bool efivarfs_valid_name(const char *str, int len);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 15880a68faad..d67b0d157ff5 100644
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
@@ -23,10 +24,27 @@ static void efivarfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct super_block *sb = root->d_sb;
+	struct efivarfs_fs_info *sbi = sb->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+
+	/* Show partition info */
+	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+				from_kuid_munged(&init_user_ns, opts->uid));
+	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+				from_kgid_munged(&init_user_ns, opts->gid));
+	return 0;
+}
+
 static const struct super_operations efivarfs_ops = {
 	.statfs = simple_statfs,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = efivarfs_evict_inode,
+	.show_options	= efivarfs_show_options,
 };
 
 /*
@@ -190,6 +208,41 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 	return 0;
 }
 
+enum {
+	Opt_uid, Opt_gid,
+};
+
+static const struct fs_parameter_spec efivarfs_parameters[] = {
+	fsparam_u32("uid",			Opt_uid),
+	fsparam_u32("gid",			Opt_gid),
+	{},
+};
+
+static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct efivarfs_fs_info *sbi = fc->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, efivarfs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		opts->uid = make_kuid(current_user_ns(), result.uint_32);
+		break;
+	case Opt_gid:
+		opts->gid = make_kgid(current_user_ns(), result.uint_32);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode = NULL;
@@ -233,10 +286,21 @@ static int efivarfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
+	.parse_param	= efivarfs_parse_param,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
 {
+	struct efivarfs_fs_info *sfi;
+
+	sfi = kzalloc(sizeof(struct efivarfs_fs_info), GFP_KERNEL);
+	if (!sfi)
+		return -ENOMEM;
+
+	sfi->mount_opts.uid = current_uid();
+	sfi->mount_opts.gid = current_gid();
+
+	fc->s_fs_info = sfi;
 	fc->ops = &efivarfs_context_ops;
 	return 0;
 }
@@ -254,6 +318,7 @@ static struct file_system_type efivarfs_type = {
 	.name    = "efivarfs",
 	.init_fs_context = efivarfs_init_fs_context,
 	.kill_sb = efivarfs_kill_sb,
+	.parameters		= efivarfs_parameters,
 };
 
 static __init int efivarfs_init(void)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

