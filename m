Return-Path: <linux-efi+bounces-3063-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF6A6C377
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 20:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3789F48257F
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327F22D781;
	Fri, 21 Mar 2025 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="FyXF57qu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76918FC75
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586180; cv=none; b=At0x8FavwCR2g4HvJsCF1vNiigmM+WpS1SDIlzHps56GZsTdaG87YDWgTqXWQHmUNjgeZNbDy20tXInJ5viB+FRx4Zm1hF7pT5adeoRRCsrBt4eC00sxsBujsJLx9/y5I+sxaeKvCLmhHCg9oc9mGTvZDT1ttF3gCXKNbX0O1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586180; c=relaxed/simple;
	bh=r+9rFxKYels7aSBQsUwzD3uvlUggPtmt0su+Trdw/gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOp75CbXjWOrnyH9jRyDXZtr+weImdTh8sYcp9jVjeigNj7MrpPXieP9JBCe5rA1o8jRDLzM94wk+OY0wq6dzN5VlPvDzQFZAOCFQwqks1otEE+NgjtGqTF3AYUc2Z1Gea+W5tyG3leyxp89XZR/tHx3zGkeNhc6B+rSumgyUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=FyXF57qu; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 483051C1652
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 22:42:54 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1742586168; x=
	1743450169; bh=r+9rFxKYels7aSBQsUwzD3uvlUggPtmt0su+Trdw/gM=; b=F
	yXF57qu+nVE4I3OzfK9arvEeOkfdLBPTTT0nJUQdJ4mHovh4+LQgqysnOLcPCVPy
	0yrjLoCpRbJzhbDadDtBnpqbG9e1xz8Iza/g1URx304iUdgQWELNKJyEy2pRdpiK
	cbzmoetkog7Yn9noM2nI0Qr/W4rbO/lAgK19Ttbe9w=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X65EQhCEjpAN for <linux-efi@vger.kernel.org>;
	Fri, 21 Mar 2025 22:42:48 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 45B8E1C0604;
	Fri, 21 Mar 2025 22:42:35 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Jeremy Kerr <jk@ozlabs.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jiao Zhou <jiaozhou@google.com>,
	Matthew Garrett <mgarrett@aurora.tech>
Subject: [PATCH 6.1 v2 1/2] efivarfs: Add uid/gid mount options
Date: Fri, 21 Mar 2025 19:42:26 +0000
Message-ID: <20250321194230.1928571-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiao Zhou <jiaozhou@google.com>

commit 5329aa5101f73c451bcd48deaf3f296685849d9c upstream.

Allow UEFI variables to be modified by non-root processes in order to
run sandboxed code. This doesn't change the behavior of mounting
efivarfs unless uid/gid are specified; by default both are set to root.

Signed-off-by: Jiao Zhou <jiaozhou@google.com>
Acked-by: Matthew Garrett <mgarrett@aurora.tech>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 fs/efivarfs/inode.c    |  4 +++
 fs/efivarfs/internal.h |  9 ++++++
 fs/efivarfs/super.c    | 68 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index b3dc7ff42400..e93f2afd6741 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -21,8 +21,12 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 				dev_t dev, bool is_removable)
 {
 	struct inode *inode = new_inode(sb);
+	struct efivarfs_fs_info *fsi = sb->s_fs_info;
+	struct efivarfs_mount_opts *opts = &fsi->mount_opts;
 
 	if (inode) {
+		inode->i_uid = opts->uid;
+		inode->i_gid = opts->gid;
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index dcb973d8736c..0762c0a1d207 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -9,6 +9,15 @@
 #include <linux/list.h>
 #include <linux/efi.h>
 
+struct efivarfs_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
+};
+
+struct efivarfs_fs_info {
+	struct efivarfs_mount_opts mount_opts;
+};
+
 struct efi_variable {
 	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
 	efi_guid_t    VendorGuid;
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index b8c4641ed152..b4f1c46ea06f 100644
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
@@ -24,10 +25,26 @@ static void efivarfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct super_block *sb = root->d_sb;
+	struct efivarfs_fs_info *sbi = sb->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+
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
+	.show_options = efivarfs_show_options,
 };
 
 /*
@@ -183,6 +200,45 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 	return 0;
 }
 
+enum {
+	Opt_uid, Opt_gid,
+};
+
+static const struct fs_parameter_spec efivarfs_parameters[] = {
+	fsparam_u32("uid", Opt_uid),
+	fsparam_u32("gid", Opt_gid),
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
+		if (!uid_valid(opts->uid))
+			return -EINVAL;
+		break;
+	case Opt_gid:
+		opts->gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(opts->gid))
+			return -EINVAL;
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
@@ -236,11 +292,22 @@ static int efivarfs_reconfigure(struct fs_context *fc)
 
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
+	.parse_param	= efivarfs_parse_param,
 	.reconfigure	= efivarfs_reconfigure,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
 {
+	struct efivarfs_fs_info *sfi;
+
+	sfi = kzalloc(sizeof(*sfi), GFP_KERNEL);
+	if (!sfi)
+		return -ENOMEM;
+
+	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
+	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
+
+	fc->s_fs_info = sfi;
 	fc->ops = &efivarfs_context_ops;
 	return 0;
 }
@@ -261,6 +328,7 @@ static struct file_system_type efivarfs_type = {
 	.name    = "efivarfs",
 	.init_fs_context = efivarfs_init_fs_context,
 	.kill_sb = efivarfs_kill_sb,
+	.parameters = efivarfs_parameters,
 };
 
 static __init int efivarfs_init(void)
-- 
2.43.0


