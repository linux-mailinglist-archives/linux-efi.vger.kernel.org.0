Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684E9553636
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbiFUPgw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352188AbiFUPgs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138D2A734;
        Tue, 21 Jun 2022 08:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08D94B81A3C;
        Tue, 21 Jun 2022 15:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F93C341C4;
        Tue, 21 Jun 2022 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825804;
        bh=4Rb29Z1aVzlLhWQRMeSQlmJDimXz9N6C1pQVV5PMA2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aB+xc6nCg3hHNw+fcdnCexKfhYW6mBG5rIZNFYtsDZar/2mulvKv3Imlvy4vzYMIH
         TSMdjlBOHaTukUXoB4KrKE5mDMQ7KgmcEybxlxsLNMMcq3Ogk4XZuLVUh4cU+Ca4Jf
         Wx0yAWcR+6kxsshpyZpliOuZDEvQWr9XgkuW2HexlZyOJ7D7ZR7BoQ139T95kEFLlR
         mv7Sx1BDcvc5XRsfKm4bYlb4fHb/ZRSx231erb6m2u1mNd/GhY9D3I0aTRL09ielh5
         JVIfEe61zxxOb4Tmgy4rkrLOFi7tp1yZrdVOWofxMV3C3ND6ePHMZ9ZqBvIe8857re
         xsiIFT01G7iCQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 5/9] efi: vars: Use locking version to iterate over efivars linked lists
Date:   Tue, 21 Jun 2022 17:36:19 +0200
Message-Id: <20220621153623.3786960-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4084; h=from:subject; bh=4Rb29Z1aVzlLhWQRMeSQlmJDimXz9N6C1pQVV5PMA2M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseVvTEDyWClHWF38GkRuxb+Vstxxuh/fdnFY7bsT C3mGRbaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHlbwAKCRDDTyI5ktmPJJS/C/ 4vnOr+w1LqRP0Zi3XU6yR3Qz5vOYcEiWobgvrdsvkeYxeaWrCUWeb5/r+sfVIjpeN1KKK1vQVGYRDG DYK8N0+Z/7x1ZFe4LQnI+UOfqFfvSIUTt1I3PmdAy1doev2cmpJTJRr/lotYQVa9PvLhW81cwYPVb+ w36Z2fkO3Ih6EDweEw1NivnMmgdIHOszoBcTEId9o6uXOqddzUK7+5OipyrEKyl5o5E4n0POsKAcyN zY16O/gR+GUPUoyL5FtGnkMXWtDf3sf6b+QU805Zw2sv1s5+Q4AtMQrOOhulHcEymcHGA+WlahpTvX svIelQeebj6f5bp6PzLy+KtnAL+a8J5vVZRhvwIAnBDunE5tGW+TC15jM0lufYv+60fSOqZYMvmOA4 f4HVsuJFAubQDlD7O3dkCn8oob7Rn7lPkgzgBu9SWylZ5OCSPR3Z2gr0SAFs3oNKA54kiRpfIKVYlb YcYoM2OyBExTxHvZy2wt2OE6koIdDcPLmM0eg+M/Fk66E=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Both efivars and efivarfs uses __efivar_entry_iter() to go over the
linked list that shadows the list of EFI variables held by the firmware,
but fail to call the begin/end helpers that are documented as a
prerequisite.

So switch to the proper version, which is efivar_entry_iter(). Given
that in both cases, efivar_entry_remove() is invoked with the lock held
already, don't take the lock there anymore.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efivars.c | 8 ++------
 drivers/firmware/efi/vars.c    | 9 +--------
 fs/efivarfs/super.c            | 9 +++------
 include/linux/efi.h            | 2 +-
 4 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 8341fb15f62e..801a65582172 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -602,10 +602,7 @@ static int efivars_sysfs_callback(efi_char16_t *name, efi_guid_t vendor,
 
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
@@ -615,8 +612,7 @@ static void efivars_sysfs_exit(void)
 	/* Remove all entries and destroy */
 	int err;
 
-	err = __efivar_entry_iter(efivar_sysfs_destroy, &efivar_sysfs_list,
-				  NULL, NULL);
+	err = efivar_entry_iter(efivar_sysfs_destroy, &efivar_sysfs_list, NULL);
 	if (err) {
 		pr_err("efivars: Failed to destroy sysfs entries\n");
 		return;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 5640ffa81544..29540013b358 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -523,17 +523,10 @@ EXPORT_SYMBOL_GPL(__efivar_entry_add);
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
index 09dfa8362f50..6780fc81cc11 100644
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
@@ -244,7 +241,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	kill_litter_super(sb);
 
 	/* Remove all entries and destroy */
-	__efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL, NULL);
+	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
 }
 
 static struct file_system_type efivarfs_type = {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 08bc6215e3b4..54ca2d6b6c78 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1063,7 +1063,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-int efivar_entry_remove(struct efivar_entry *entry);
+void efivar_entry_remove(struct efivar_entry *entry);
 
 int __efivar_entry_delete(struct efivar_entry *entry);
 int efivar_entry_delete(struct efivar_entry *entry);
-- 
2.35.1

