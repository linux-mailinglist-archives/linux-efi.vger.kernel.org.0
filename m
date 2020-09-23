Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFB275D1B
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIWQPL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgIWQPD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:03 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D20CA208E4;
        Wed, 23 Sep 2020 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877702;
        bh=zH8OvFJ+fXzumd6pJoYf17znejCcgokbBvxOXA2Qu6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJs2SHH2GjcCxCBHHBwNf4JfP7EA6WiHfspmHY5goymDdEmNvF3dP+ckTa8LwWtTo
         +EloX/RvBlwx+5glhDKHTl24r5yfq3o15eJoqWnuDlGDrl6bOMeYlEZDDauV5c4+p7
         PXyyRFOLxTNBCi7g/7YF2vyesYxma3T7kZ+3pd5U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 3/7] efi: efivars: un-export efivars_sysfs_init()
Date:   Wed, 23 Sep 2020 18:14:00 +0200
Message-Id: <20200923161404.17811-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923161404.17811-1-ardb@kernel.org>
References: <20200923161404.17811-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efivars_sysfs_init() is only used locally in the source file that
defines it, so make it static and unexport it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efivars.c | 3 +--
 include/linux/efi.h            | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index f39321dbc29f..a76f50e15e6d 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -638,7 +638,7 @@ static void efivars_sysfs_exit(void)
 	kset_unregister(efivars_kset);
 }
 
-int efivars_sysfs_init(void)
+static int efivars_sysfs_init(void)
 {
 	struct kobject *parent_kobj = efivars_kobject();
 	int error = 0;
@@ -666,7 +666,6 @@ int efivars_sysfs_init(void)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(efivars_sysfs_init);
 
 module_init(efivars_sysfs_init);
 module_exit(efivars_sysfs_exit);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8ae64c2a384b..7defdc456dc0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1035,10 +1035,6 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
-#if defined(CONFIG_EFI_VARS) || defined(CONFIG_EFI_VARS_MODULE)
-int efivars_sysfs_init(void);
-
-#endif /* CONFIG_EFI_VARS */
 extern bool efi_capsule_pending(int *reset_type);
 
 extern int efi_capsule_supported(efi_guid_t guid, u32 flags,
-- 
2.17.1

