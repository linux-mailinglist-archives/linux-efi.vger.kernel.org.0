Return-Path: <linux-efi+bounces-3059-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2CA6C2A6
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 19:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926963BBDA2
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7D22F389;
	Fri, 21 Mar 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="ikyDawYk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E61EB9E1
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582450; cv=none; b=QHayl0B521DhcoV2yMU/mkvYd1cY6R2oAUt29IU5R5GBBxgYpDnmVYa70vFcYtCh/okXjiO1eL7evtwg6HejWkqqtDSKr4M0WaAqRejfdPXVpDgkQWxaXxqg/hsirmBSvYB2uU4zQ/0iNjd9WdKoqAPm1bh6Q/asMruoSbOdiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582450; c=relaxed/simple;
	bh=RcRiL01nJNn8jL/MfIZbJZbJpnLteETpwfU/AMcqA9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnFg8gb7L9Zvc0204L1Azm9JbjTRrh5oPimPHBbfCtY9A3HOF2RQL54g8cS1a1Z3sNlz503NGfdIOVUSVrNNxCHotWGHWuQQ4hZSpyT+eRCH9WR3JZhqaqXO82B6AROkWQPjao5MUTdoyCM4U/qXSQK3YFBFF5buPWHn1Up46S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=ikyDawYk; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 6C90B1C16F4
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 21:40:39 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1742582436; x=
	1743446437; bh=RcRiL01nJNn8jL/MfIZbJZbJpnLteETpwfU/AMcqA9Q=; b=i
	kyDawYkXr042023anweuly2B8fR0CFOCahh0lle6xexy3dL4Ua2Zt/r+tTEjXET9
	/mwYrseM2U97q4/hrONUW9B+Zah7xCJR3gTm4x8AJomArUB2M/jnp2NzSWQpvea1
	6z49D+1GmdM00tVeGFoT+GgdPxummlXfLB/Q9lEQ8s=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uvg-oWi0Br9I for <linux-efi@vger.kernel.org>;
	Fri, 21 Mar 2025 21:40:36 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id A46DD1C0628;
	Fri, 21 Mar 2025 21:40:36 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Jeremy Kerr <jk@ozlabs.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com,
	syzbot+246ea4feed277471958a@syzkaller.appspotmail.com
Subject: [PATCH 6.1] efivarfs: Move efivarfs list into superblock s_fs_info
Date: Fri, 21 Mar 2025 18:40:20 +0000
Message-ID: <20250321184028.1797879-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
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
 fs/efivarfs/internal.h |  9 ++++++---
 fs/efivarfs/super.c    | 26 +++++++++++++++++---------
 fs/efivarfs/vars.c     |  5 +++--
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index b3dc7ff42400..a999351e6615 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -73,6 +73,7 @@ static bool efivarfs_valid_name(const char *str, int len)
 static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, bool excl)
 {
+	struct efivarfs_fs_info *info = dir->i_sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct efivar_entry *var;
 	int namelen, i = 0, err = 0;
@@ -110,7 +111,7 @@ static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_private = var;
 	kmemleak_ignore(var);
 
-	err = efivar_entry_add(var, &efivarfs_list);
+	err = efivar_entry_add(var, &info->efivarfs_list);
 	if (err)
 		goto out;
 
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index dcb973d8736c..1745be16ff65 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -9,6 +9,10 @@
 #include <linux/list.h>
 #include <linux/efi.h>
 
+struct efivarfs_fs_info {
+	struct list_head efivarfs_list;
+};
+
 struct efi_variable {
 	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
 	efi_guid_t    VendorGuid;
@@ -24,7 +28,8 @@ struct efivar_entry {
 	struct kobject kobj;
 };
 
-int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
+int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
+			    struct list_head *),
 		void *data, bool duplicates, struct list_head *head);
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
@@ -54,6 +59,4 @@ extern struct inode *efivarfs_get_inode(struct super_block *sb,
 			const struct inode *dir, int mode, dev_t dev,
 			bool is_removable);
 
-extern struct list_head efivarfs_list;
-
 #endif /* EFIVAR_FS_INTERNAL_H */
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index b8c4641ed152..a2c13af6c090 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -17,8 +17,6 @@
 
 #include "internal.h"
 
-LIST_HEAD(efivarfs_list);
-
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
@@ -102,7 +100,8 @@ static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
 }
 
 static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
-			     unsigned long name_size, void *data)
+			     unsigned long name_size, void *data,
+			     struct list_head *list)
 {
 	struct super_block *sb = (struct super_block *)data;
 	struct efivar_entry *entry;
@@ -154,7 +153,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	}
 
 	__efivar_entry_get(entry, NULL, &size, NULL);
-	__efivar_entry_add(entry, &efivarfs_list);
+	__efivar_entry_add(entry, list);
 
 	/* copied by the above to local storage in the dentry. */
 	kfree(name);
@@ -185,6 +184,7 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 
 static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct efivarfs_fs_info *sfi = sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct dentry *root;
 	int err;
@@ -210,11 +210,10 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -241,6 +240,15 @@ static const struct fs_context_operations efivarfs_context_ops = {
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
 {
+	struct efivarfs_fs_info *sfi;
+
+	sfi = kzalloc(sizeof(*sfi), GFP_KERNEL);
+	if (!sfi)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&sfi->efivarfs_list);
+
+	fc->s_fs_info = sfi;
 	fc->ops = &efivarfs_context_ops;
 	return 0;
 }
@@ -252,7 +260,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
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


