Return-Path: <linux-efi+bounces-150-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD5580A968
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A88CB20B24
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B74A38DF1;
	Fri,  8 Dec 2023 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E00zCjDf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D786919A4
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 08:39:40 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-3333aaf02b0so2102192f8f.1
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 08:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702053579; x=1702658379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngnrv+Hn06IHdKOg0steXN944/uQIq0hGYATaMFuKDU=;
        b=E00zCjDfr/l0lQ7BKO3JOcJbxu09Zk6nFw4MXZLXFUmGiEIVy13BmXVRrrJoM7Ha3p
         FjeeAIIyrWAe9DBgkXE639znrExDCq7vmEpYn7XfnvIsIWXrnN+o0ZftqqiD4S5KY9UZ
         Yrc8BngcAeYT7uT/1g0SU2A1tcelJWl4MSfWywu2DXs0Ryw94cHnzLErosXxsItFnYRi
         +XnLc38rXxs44Yzmn2o+TyIYQTMo0A1y6CaztJmAZn0VPqwT09EcGXeApARwP3TZz7DX
         n0F90a4tV0UTlOSuzzTKVNc2tJ9Je/7CP3jX+S/i5/PMQ9y88jdAgeJG5LKVpab6+YNS
         5Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053579; x=1702658379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngnrv+Hn06IHdKOg0steXN944/uQIq0hGYATaMFuKDU=;
        b=px0c+jNo1uruSBwhqENNgNKUsHscym7dvidiP9FN+Zy1KWRNUkMTGW/xL0bDoeMQOi
         +xrD0sRqlXq8ETWxvqT6Ld16kdIvo4pZo8rp+w6sAriZZEV/IN3Lwdf6v5x/0ZWJxZvA
         n/A3O+En8BV6MbY9gVvqJiocG5AVso2bfZ34w2q6yidt0SGdNJwGBGAPEJhDfrML2xtV
         egwiaqSYOok5g7omQp6ztrmZslRyMOM4iL1fvDCROravSywbE7x4wZ33F71zeKJMDE/K
         jTW0h/mslTYIhTm+c/L+AEsjPS4+BZxdTULh6w9HLior1WAcqYsw98H7cyawW9QhUewI
         N1lg==
X-Gm-Message-State: AOJu0YwaLlQkIrfUNFCL/Yxtdb3QkO6yjp88OJAjQGxdWMZiTkknygP4
	iqdDnWNFw4VYuYPv9ICHxXu4n6e6Iq+CafRP0g+BaqeiCapsIKOXaQZTFBNAYWsBZ3AuvBBYYT8
	JF3sCMQd9qRrooZexRCBdGroUtxSsam0OhByqE7PMuce7NhWIBduFeCMqACRA
X-Google-Smtp-Source: AGHT+IGtzvisY01CU+1NaWSSMk8Mt1zqFvi8Y4qfMHLyd4GXmlbOuYnqMR6S6+SSLehj7nsWDi+Qj3Ow
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1886:b0:333:31b8:18ee with SMTP id
 a6-20020a056000188600b0033331b818eemr1720wri.12.1702053578921; Fri, 08 Dec
 2023 08:39:38 -0800 (PST)
Date: Fri,  8 Dec 2023 17:39:29 +0100
In-Reply-To: <20231208163925.3225018-5-ardb@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208163925.3225018-5-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6350; i=ardb@kernel.org;
 h=from:subject; bh=XtkCD4WVnS3MsE67SFrPHn1+x8SuUQjZ0njq1wbm44k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIbXY7cDcH2yXJ7CoHDp1REtALqdwUeGp69ur0/qmvHldx
 nqzcnZyRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI7QNGhn7LeQfb/vDqXF3l
 vcpf4Fva7sd3UzMdlNdxHZAM3SB7rpXhf/YT8Wn6LwyiPUtPTnpgy7df3PENq8oCvaX+SixrY1Y l8AAA
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208163925.3225018-8-ardb@google.com>
Subject: [PATCH 3/3] efivarfs: Move efivarfs list into superblock s_fs_info
From: Ard Biesheuvel <ardb@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Jiao Zhou <jiaozhou@google.com>, syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

syzbot reports issues with concurrent fsopen()/fsconfig() invocations on
efivarfs, which are the result of the fact that the efivarfs list (which
caches the names and GUIDs of existing EFI variables) is a global
structure. In normal use, these issues are unlikely to trigger, even in
the presence of multiple mounts of efivarfs, but the execution pattern
used by the syzkaller reproducer may result in multiple instances of the
superblock that share the global efivarfs list, and this causes list
corruption when the list is reinitialized by one user while another is
traversing it.

So let's move the list head into the superblock s_fs_info field, so that
it will never be shared between distinct instances of the superblock. In
the common case, there will still be a single instance of this list, but
in the artificial syzkaller case, no list corruption can occur any
longer.

Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/inode.c    |  3 ++-
 fs/efivarfs/internal.h |  6 +++---
 fs/efivarfs/super.c    | 19 ++++++++++---------
 fs/efivarfs/vars.c     |  5 +++--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 91290fe4a70b..586446e02ef7 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -77,6 +77,7 @@ bool efivarfs_valid_name(const char *str, int len)
 static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct efivarfs_fs_info *info = dir->i_sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct efivar_entry *var;
 	int namelen, i = 0, err = 0;
@@ -118,7 +119,7 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	inode->i_private = var;
 	kmemleak_ignore(var);
 
-	err = efivar_entry_add(var, &efivarfs_list);
+	err = efivar_entry_add(var, &info->efivarfs_list);
 	if (err)
 		goto out;
 
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index c66647f5c0bd..1dc0ccce3cc3 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -16,6 +16,7 @@ struct efivarfs_mount_opts {
 
 struct efivarfs_fs_info {
 	struct efivarfs_mount_opts mount_opts;
+	struct list_head efivarfs_list;
 };
 
 struct efi_variable {
@@ -33,7 +34,8 @@ struct efivar_entry {
 	struct kobject kobj;
 };
 
-int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
+int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
+			    struct list_head *),
 		void *data, bool duplicates, struct list_head *head);
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
@@ -64,6 +66,4 @@ extern struct inode *efivarfs_get_inode(struct super_block *sb,
 			const struct inode *dir, int mode, dev_t dev,
 			bool is_removable);
 
-extern struct list_head efivarfs_list;
-
 #endif /* EFIVAR_FS_INTERNAL_H */
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 891acf7b0903..d7d9a3e189a0 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -18,8 +18,6 @@
 
 #include "internal.h"
 
-LIST_HEAD(efivarfs_list);
-
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
@@ -166,7 +164,8 @@ static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
 }
 
 static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
-			     unsigned long name_size, void *data)
+			     unsigned long name_size, void *data,
+			     struct list_head *list)
 {
 	struct super_block *sb = (struct super_block *)data;
 	struct efivar_entry *entry;
@@ -221,7 +220,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	}
 
 	__efivar_entry_get(entry, NULL, &size, NULL);
-	__efivar_entry_add(entry, &efivarfs_list);
+	__efivar_entry_add(entry, list);
 
 	/* copied by the above to local storage in the dentry. */
 	kfree(name);
@@ -291,6 +290,7 @@ static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *para
 
 static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct efivarfs_fs_info *info = sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct dentry *root;
 	int err;
@@ -316,11 +316,10 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&efivarfs_list);
-
-	err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
+	err = efivar_init(efivarfs_callback, (void *)sb, true,
+			  &info->efivarfs_list);
 	if (err)
-		efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
+		efivar_entry_iter(efivarfs_destroy, &info->efivarfs_list, NULL);
 
 	return err;
 }
@@ -346,6 +345,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	if (!sfi)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&sfi->efivarfs_list);
+
 	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
 	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
 
@@ -361,7 +362,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	kill_litter_super(sb);
 
 	/* Remove all entries and destroy */
-	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
+	efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
 	kfree(sfi);
 }
 
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 9e4f47808bd5..114ff0fd4e55 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -369,7 +369,8 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
  *
  * Returns 0 on success, or a kernel error code on failure.
  */
-int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
+int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
+			    struct list_head *),
 		void *data, bool duplicates, struct list_head *head)
 {
 	unsigned long variable_name_size = 1024;
@@ -420,7 +421,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 				status = EFI_NOT_FOUND;
 			} else {
 				err = func(variable_name, vendor_guid,
-					   variable_name_size, data);
+					   variable_name_size, data, head);
 				if (err)
 					status = EFI_NOT_FOUND;
 			}
-- 
2.43.0.472.g3155946c3a-goog


