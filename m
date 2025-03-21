Return-Path: <linux-efi+bounces-3058-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F19A6C24F
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F947AA72B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229322FF4D;
	Fri, 21 Mar 2025 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="gjhOQg7+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83C22D7B8
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581321; cv=none; b=LfH7wlsKNU3c4LSEyIilrqgzOz/huZpxnAKzfN1DNKe5dB+0lM80eOtDE/dp9eOBGn8NCoGogFJ7oH3JqaWZZ+nZtYDViWBigAyiEWwNVrvM6l1pffPh9+wjQHALImFxfamrflgtfTaRfbfMmTs8kIPPdhakMOHiRMudz1p23oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581321; c=relaxed/simple;
	bh=GlgWYN9/cnYfBQ3q33i/hcaHJ7knAqnJ5VcqkWXrObU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFDwjOKKuN3ZNe4vyQM1kMFCPWyep+MLLqKlkoVNCwmlYYWTaGTOQt14A7+5ZysTXdAB+zUAv86SRXNmhaJn8jObiF/AdOpeuiZMqOFTE4t9v1cr66l9Vm7KvAzktTJr2CbVXARWqQ2K/cvI/VNyy7kUwBORokQU0vDT9KJaM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=gjhOQg7+; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 6CC881C1794
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 21:21:46 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1742581301; x=
	1743445302; bh=GlgWYN9/cnYfBQ3q33i/hcaHJ7knAqnJ5VcqkWXrObU=; b=g
	jhOQg7+jitcmKcBcJuzUFEnNXQHsRe84lxVuOs3eZz5sFDVxYj+M8xspuQ8sQbGg
	2MVv9PjrD873/7ZVNPAjQwkkz+JJlDn0/Ue3VOXHVbjNP16SH51icn8uYsXEecmk
	mYU0BUwHAiQzvYzPSD5iI1BRYJ86CdxM+3MgsIkE0Y=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bCscVHUkiQlc for <linux-efi@vger.kernel.org>;
	Fri, 21 Mar 2025 21:21:41 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 721371C0628;
	Fri, 21 Mar 2025 21:21:35 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Jeremy Kerr <jk@ozlabs.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 1/2] efi: vars: Use locking version to iterate over efivars linked lists
Date: Fri, 21 Mar 2025 18:21:24 +0000
Message-ID: <20250321182126.1716111-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

commit 3a75f9f2f9ad19bb9a0f566373ae91d8f09db85e upstream.

Both efivars and efivarfs uses __efivar_entry_iter() to go over the
linked list that shadows the list of EFI variables held by the firmware,
but fail to call the begin/end helpers that are documented as a
prerequisite.

So switch to the proper version, which is efivar_entry_iter(). Given
that in both cases, efivar_entry_remove() is invoked with the lock held
already, don't take the lock there anymore.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/firmware/efi/efivars.c | 8 ++------
 drivers/firmware/efi/vars.c    | 9 +--------
 fs/efivarfs/super.c            | 9 +++------
 include/linux/efi.h            | 3 ++-
 4 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index e6b16b3a17a8..b925571ee593 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -608,10 +608,7 @@ static int efivars_sysfs_callback(efi_char16_t *name, efi_guid_t vendor,
 
 static int efivar_sysfs_destroy(struct efivar_entry *entry, void *data)
 {
-	int err = efivar_entry_remove(entry);
-
-	if (err)
-		return err;
+	efivar_entry_remove(entry);
 	efivar_unregister(entry);
 	return 0;
 }
@@ -621,8 +618,7 @@ static void efivars_sysfs_exit(void)
 	/* Remove all entries and destroy */
 	int err;
 
-	err = __efivar_entry_iter(efivar_sysfs_destroy, &efivar_sysfs_list,
-				  NULL, NULL);
+	err = efivar_entry_iter(efivar_sysfs_destroy, &efivar_sysfs_list, NULL);
 	if (err) {
 		pr_err("efivars: Failed to destroy sysfs entries\n");
 		return;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index eaed1ddcc803..010febd2ab6b 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -534,17 +534,10 @@ EXPORT_SYMBOL_GPL(efivar_entry_add);
 /**
  * efivar_entry_remove - remove entry from variable list
  * @entry: entry to remove from list
- *
- * Returns 0 on success, or a kernel error code on failure.
  */
-int efivar_entry_remove(struct efivar_entry *entry)
+void efivar_entry_remove(struct efivar_entry *entry)
 {
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
 	list_del(&entry->list);
-	up(&efivars_lock);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(efivar_entry_remove);
 
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 99d002438008..24a0c5ef4169 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -180,10 +180,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 
 static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 {
-	int err = efivar_entry_remove(entry);
-
-	if (err)
-		return err;
+	efivar_entry_remove(entry);
 	kfree(entry);
 	return 0;
 }
@@ -219,7 +216,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
 	if (err)
-		__efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL, NULL);
+		efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
 
 	return err;
 }
@@ -255,7 +252,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	kill_litter_super(sb);
 
 	/* Remove all entries and destroy */
-	__efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL, NULL);
+	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
 }
 
 static struct file_system_type efivarfs_type = {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 5554d26f91d8..7c5beec4287a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -994,7 +994,8 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head);
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-int efivar_entry_remove(struct efivar_entry *entry);
+void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
+void efivar_entry_remove(struct efivar_entry *entry);
 
 int __efivar_entry_delete(struct efivar_entry *entry);
 int efivar_entry_delete(struct efivar_entry *entry);
-- 
2.43.0


