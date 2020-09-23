Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7651B275D12
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIWQPB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgIWQPB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:01 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9794821D92;
        Wed, 23 Sep 2020 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877700;
        bh=pvomOZI+DqS2lkxlDq3yzrt3uNktrNtGh4dihmOpNGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaM+/IP4ZN53YLA586kC2Gra3lO1fuyqM8W2e9ydfhlZYT/QGbNeXM8GVrSX91Ja8
         vxqo1dbxzzcbh6Bm49koO1fKvCEYLPjDEy+Q5ixKAcrxo6dMfbyTPj5kX90AB4DkrX
         RU+wJx4ZNPWkaeuVbSRwk9AmraooxCUsf6No+aaA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 2/7] efi: pstore: move workqueue handling out of efivars
Date:   Wed, 23 Sep 2020 18:13:59 +0200
Message-Id: <20200923161404.17811-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923161404.17811-1-ardb@kernel.org>
References: <20200923161404.17811-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The worker thread that gets kicked off to sync the state of the
EFI variable list is only used by the EFI pstore implementation,
and is defined in its source file. So let's move its scheduling
there as well. Since our efivar_init() scan will bail on duplicate
entries, there is no need to disable the workqueue like we did
before, so we can run it unconditionally.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c |  7 +++++--
 drivers/firmware/efi/vars.c       | 21 --------------------
 include/linux/efi.h               |  3 ---
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 785f5e6b3a41..0ef086e43090 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -21,6 +21,7 @@ module_param_named(pstore_disable, efivars_pstore_disable, bool, 0644);
 	 EFI_VARIABLE_RUNTIME_ACCESS)
 
 static LIST_HEAD(efi_pstore_list);
+static DECLARE_WORK(efivar_work, NULL);
 
 static int efi_pstore_open(struct pstore_info *psi)
 {
@@ -267,8 +268,9 @@ static int efi_pstore_write(struct pstore_record *record)
 	ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
 			      preemptible(), record->size, record->psi->buf);
 
-	if (record->reason == KMSG_DUMP_OOPS)
-		efivar_run_worker();
+	if (record->reason == KMSG_DUMP_OOPS && try_module_get(THIS_MODULE))
+		if (!schedule_work(&efivar_work))
+			module_put(THIS_MODULE);
 
 	return ret;
 };
@@ -412,6 +414,7 @@ static void efi_pstore_update_entries(struct work_struct *work)
 	}
 
 	kfree(entry);
+	module_put(THIS_MODULE);
 }
 
 static __init int efivars_pstore_init(void)
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 973eef234b36..ffb12f6efc97 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -32,10 +32,6 @@ static struct efivars *__efivars;
  */
 static DEFINE_SEMAPHORE(efivars_lock);
 
-static bool efivar_wq_enabled = true;
-DECLARE_WORK(efivar_work, NULL);
-EXPORT_SYMBOL_GPL(efivar_work);
-
 static bool
 validate_device_path(efi_char16_t *var_name, int match, u8 *buffer,
 		     unsigned long len)
@@ -391,13 +387,6 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
 	size_t i, len8 = len16 / sizeof(efi_char16_t);
 	char *str8;
 
-	/*
-	 * Disable the workqueue since the algorithm it uses for
-	 * detecting new variables won't work with this buggy
-	 * implementation of GetNextVariableName().
-	 */
-	efivar_wq_enabled = false;
-
 	str8 = kzalloc(len8, GFP_KERNEL);
 	if (!str8)
 		return;
@@ -1157,16 +1146,6 @@ struct kobject *efivars_kobject(void)
 }
 EXPORT_SYMBOL_GPL(efivars_kobject);
 
-/**
- * efivar_run_worker - schedule the efivar worker thread
- */
-void efivar_run_worker(void)
-{
-	if (efivar_wq_enabled)
-		schedule_work(&efivar_work);
-}
-EXPORT_SYMBOL_GPL(efivar_run_worker);
-
 /**
  * efivars_register - register an efivars
  * @efivars: efivars to register
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a470256f5ee3..8ae64c2a384b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1035,9 +1035,6 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
-extern struct work_struct efivar_work;
-void efivar_run_worker(void);
-
 #if defined(CONFIG_EFI_VARS) || defined(CONFIG_EFI_VARS_MODULE)
 int efivars_sysfs_init(void);
 
-- 
2.17.1

