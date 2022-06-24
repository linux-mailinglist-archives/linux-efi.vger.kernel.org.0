Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739525595B1
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiFXIuN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiFXIuC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D8766A5;
        Fri, 24 Jun 2022 01:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A89D62033;
        Fri, 24 Jun 2022 08:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FD2C341CC;
        Fri, 24 Jun 2022 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060592;
        bh=4Rb29Z1aVzlLhWQRMeSQlmJDimXz9N6C1pQVV5PMA2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYt2ehf6zPsyTI0dBSY83/Nm6lE4FRixID0oHOkc7muaiVCtQd47BmpYI0dX9CXad
         5Au63kZiRi02ohWj1d6ySyuXOfaRCTbPkJitDC3siOd2+xj0HyYuULx6P7aKHzJm0x
         kYZeeYGYnh7qK/LgdldpJEFKsj8/tnI7qhVMDGdEO/msyqB/FUduc+k8bTQdZnpMpZ
         nWPhODgrT8DHZqStGkWdS0hhRB1gXzY3Jy7m4BvQChQVvleVWK+KusA0TdUGrQ5BNS
         YBXyVMd0YKlUYzBY1qGGYa4rrRE2Z+zRI1DV5H7Y+YgTJmxOEYSrFtcC9SongEwl6X
         0ZHvGCnWeTFIg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 5/9] efi: vars: Use locking version to iterate over efivars linked lists
Date:   Fri, 24 Jun 2022 10:49:21 +0200
Message-Id: <20220624084925.724516-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624084925.724516-1-ardb@kernel.org>
References: <20220624084925.724516-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4084; h=from:subject; bh=4Rb29Z1aVzlLhWQRMeSQlmJDimXz9N6C1pQVV5PMA2M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqNTEDyWClHWF38GkRuxb+Vstxxuh/fdnFY7bsT C3mGRbaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6jQAKCRDDTyI5ktmPJKtKC/ 0cLp4vst0qbIpkpr5hbJ1Ru3VjiXyRbVSoE7JGN8L/ZbAm4npKeMCG+Q31IBGG/CiAOJSCQK9ExU+J BbHPV82/vaLifLxLUkdRIpm2nFY1QbRG2JoNNU1/s8Fcbv5Nl24hrTrFIFB5Kv9rGS/d2TNNc9szV8 C4mYQ1LrKG5LnrTdm4WwnBeOohYlCeq7J36YKd6L+6XEHa0Gb24gBkRi0RSD0FdUKcGJDzjhYnZvIL dGQLi3eFZi5QUwoMH6uL07NfAyhLPLwLuxX/hAbtG04ey71IhJfiv1VaRvnvHzHVw5DbErFkf2Uzxc oVChBYa1M8MXEcRQBvUig7KM2Uz+Wwe1Fk+CAZRvivUPccUtm3juCcqDH4y0O2Jdg3TYhxQWxC9DYC PcRjTzKXZfiS8GPCx7tUYVCabB3pzcbsKkHWoYdLoSdQB+5D0rZTB4UG6hhLvjRuMaRSmDZIFyjWjR Knl6kUxFtfrIa48jV/bRni0tROGHG62kapHor1xu8V2NY=
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

