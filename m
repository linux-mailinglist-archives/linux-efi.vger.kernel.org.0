Return-Path: <linux-efi+bounces-3064-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5021A6C37A
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A573B90C7
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9000422FDE8;
	Fri, 21 Mar 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="rb1KorFi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74B22F3BD
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586181; cv=none; b=hVfKAUps/QiWMQLgl9sneI+VhNoDikrI86oGOSNmVtxheDlX+Dye4/tmp2O2Rvr7H6m2bB8F1mhmhbaMDlUANZfRtOkX58P+EkRZWYobWCqbc/Y64wh1+qmwzZ4m44yo/JFml1WNr4VZh4uyPliTIWyiBwsLYUjMhXhWvCxPA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586181; c=relaxed/simple;
	bh=IXQN5BTQ19593M6co8XOYDcmJETVcL3hfZgdPxFtgsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHZFr2L0p566XAFPmA8h1JecPbFG5UNM/3KkYYjH2Jvc04bveVXv8xvsj5aS22xaHDCw28ahZCJevVUbqZ8yHa0KBWxWJhJUw2rWl4Gu8eTQNXOULF2x0O+LvsZHtIIDPbJZw31AIl/RdbQwutkYrnn9TdxjdxVW5B+4x4ET5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=rb1KorFi; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 284EE1C17AF
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 22:42:56 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1742586175; x=1743450176; bh=IXQN5BTQ19593M6co8XOYDcmJET
	VcL3hfZgdPxFtgsc=; b=rb1KorFiUrlsky8uVOB4xxcHwjfkYjNQzaY2UTrifmD
	L58U5/he+wgdXZy7EvqDinIgketwswt63OnctEykSTP+udsCTWYoTTKn1dgkvoe1
	lKsPf1ZhZf7TOOQwc4PdEVeHuIUfSqXupnoGmvJdU4RJche5My0RSIn/eKuvqLXY
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r5CDphd9N2gN for <linux-efi@vger.kernel.org>;
	Fri, 21 Mar 2025 22:42:55 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 1F4821C0604;
	Fri, 21 Mar 2025 22:42:55 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Jeremy Kerr <jk@ozlabs.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com,
	syzbot+246ea4feed277471958a@syzkaller.appspotmail.com
Subject: [PATCH 6.1 v2 2/2] efivarfs: Move efivarfs list into superblock s_fs_info
Date: Fri, 21 Mar 2025 19:42:27 +0000
Message-ID: <20250321194230.1928571-2-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321194230.1928571-1-sdl@nppct.ru>
References: <20250321194230.1928571-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

commit cdb46a8aefbf7fd36772bb206aaaf7e45d7cf8f6 upstream.

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
Reported-by: syzbot+246ea4feed277471958a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=246ea4feed277471958a
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 fs/efivarfs/inode.c    |  3 ++-
 fs/efivarfs/internal.h |  6 +++---
 fs/efivarfs/super.c    | 19 ++++++++++---------
 fs/efivarfs/vars.c     |  5 +++--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index e93f2afd6741..3b5b956dbf44 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -77,6 +77,7 @@ static bool efivarfs_valid_name(const char *str, int len)
 static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct efivarfs_fs_info *info = dir->i_sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct efivar_entry *var;
 	int namelen, i = 0, err = 0;
@@ -114,7 +115,7 @@ static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_private = var;
 	kmemleak_ignore(var);
 
-	err = efivar_entry_add(var, &efivarfs_list);
+	err = efivar_entry_add(var, &info->efivarfs_list);
 	if (err)
 		goto out;
 
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 0762c0a1d207..0abf4bf2bb73 100644
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
@@ -63,6 +65,4 @@ extern struct inode *efivarfs_get_inode(struct super_block *sb,
 			const struct inode *dir, int mode, dev_t dev,
 			bool is_removable);
 
-extern struct list_head efivarfs_list;
-
 #endif /* EFIVAR_FS_INTERNAL_H */
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index b4f1c46ea06f..71d850bdedfa 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -18,8 +18,6 @@
 
 #include "internal.h"
 
-LIST_HEAD(efivarfs_list);
-
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
@@ -119,7 +117,8 @@ static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
 }
 
 static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
-			     unsigned long name_size, void *data)
+			     unsigned long name_size, void *data,
+			     struct list_head *list)
 {
 	struct super_block *sb = (struct super_block *)data;
 	struct efivar_entry *entry;
@@ -171,7 +170,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	}
 
 	__efivar_entry_get(entry, NULL, &size, NULL);
-	__efivar_entry_add(entry, &efivarfs_list);
+	__efivar_entry_add(entry, list);
 
 	/* copied by the above to local storage in the dentry. */
 	kfree(name);
@@ -241,6 +240,7 @@ static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *para
 
 static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct efivarfs_fs_info *sfi = sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct dentry *root;
 	int err;
@@ -266,11 +266,10 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&efivarfs_list);
-
-	err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
+	err = efivar_init(efivarfs_callback, (void *)sb, true,
+			  &sfi->efivarfs_list);
 	if (err)
-		efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
+		efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
 
 	return err;
 }
@@ -304,6 +303,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	if (!sfi)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&sfi->efivarfs_list);
+
 	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
 	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
 
@@ -319,7 +320,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	kill_litter_super(sb);
 
 	/* Remove all entries and destroy */
-	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
+	efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
 	kfree(sfi);
 }
 
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 13bc60698955..2ad377818d0f 100644
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
 	unsigned long variable_name_size = 512;
@@ -421,7 +422,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 				status = EFI_NOT_FOUND;
 			} else {
 				err = func(variable_name, vendor_guid,
-					   variable_name_size, data);
+					   variable_name_size, data, head);
 				if (err)
 					status = EFI_NOT_FOUND;
 			}
-- 
2.43.0


