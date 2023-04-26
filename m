Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BCD6EFB69
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 21:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjDZT7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjDZT7K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 15:59:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD5D2;
        Wed, 26 Apr 2023 12:59:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A8CD73200935;
        Wed, 26 Apr 2023 15:59:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Apr 2023 15:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1682539147; x=1682625547; bh=+dM23Sbs2y
        Ywhw7ZQN+S1+KilA+WqOVJpT49zdDKWHk=; b=YNDWsyZ/Hw8roX6n/sADtUMRsV
        7bOz4+7t2k29yB3lHczJzK4PmHvYlHot1eZO9PeU0JsItDfVINkozr/kiGjMU2IE
        sOyNg9LKvYgYdonmJw6k8x9u2Yqm1FAt67o6+jFwx6ycgPp2LW5zkPFjP9nDGbtW
        VAiSgNAObFF21GdHhmJSdbxJl1am4QrQ31pVKKu9Wu9ZGSjHXFagV/PXDmbBUcpT
        usDtPpAGsWJt+mOGFIL+9QX4PRrPiv0LO3bjX06eBkg+1EZVxeSnAhUrHsEjnkV8
        jJv7S87otJvveFC2yPgEOa0iYkD1n2d7aOpHpMpWvvftX610ISjVC1sMVdcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682539147; x=1682625547; bh=+dM23Sbs2yYwh
        w7ZQN+S1+KilA+WqOVJpT49zdDKWHk=; b=Xkj3o6g5TYSLEM92tuOJXKICLKuNI
        gglmM1y4Z5D5jm7ye6esp4yXTkS9YxvraFrCw864n9ByUZ7QvzOLew5+2N7Z2Gtq
        rJHB4L7ouMqFkraS41Hyjagg0Iutuvcu7iIqRNDxuZIJPwRLZ7QlHbBazYjMaq5h
        WBMK3FcXawYMksgwrUgyDzNswObOb1ewnTp+8OFMObigMO42SwJ1IT+Wqr6V0IBK
        5nNPXhm7oxkSyyzZShE7fQMT16QYFeNGYBoA7hDUlWyoW9kthwFEhPV9bzB1QzFe
        RH+PHfRndcfvwAQEJYWvIH6I7w1qBeIV7Jw/BVDZsPJKpf6r7JsTpiyZg==
X-ME-Sender: <xms:iYJJZFe5POSvo8MZkS6OCJsAIXGoYqXrdo1XnrbxY3451fm7_FcA2g>
    <xme:iYJJZDMwiVKg_6CYxDjiFf7y2LnYaRui_5wIs24EaXJvV3ZHobQ536m-AibFM5hlH
    S1z2S17BrEjP62yy1c>
X-ME-Received: <xmr:iYJJZOivGwaNHoJpEJDef92DSFNgIgvK96gwcSnvzXy4KUwjzzCjScZLrr7Vn5KATSBDPKmYaueLslYKpFJrb6y-7YBe-UZWhxZ99iTHlBgT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhhishhs
    vgcutehsthhivghruceorghnihhsshgvsegrshhtihgvrhdrvghuqeenucggtffrrghtth
    gvrhhnpedtfffhleekhefhheeftedthfejgfffvddtleehffdtjefftdehkeetfeefieel
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    hishhsvgesrghsthhivghrrdgvuh
X-ME-Proxy: <xmx:iYJJZO_Blxj3AF6jFUL_oUR3wZQcVSOBfwUhpy8ltE1tt9YSYaCmIA>
    <xmx:iYJJZBsRchc3S77ZAjEhlFD__h-UraUy3WrO6DdWpZUZ99FeC8GLSA>
    <xmx:iYJJZNEmuiYM4bNKvVb2zIPvPOjzYvvni1gAG8V1QlL8dO13Gyj9Wg>
    <xmx:i4JJZBH9mrVn-7jz-P1zIY-MPK8vaZ2Cet6rtJAhzmjfc74l7w3N1g>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Apr 2023 15:59:03 -0400 (EDT)
From:   Anisse Astier <anisse@astier.eu>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jeremy Kerr <jk@ozlabs.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anisse Astier <anisse@astier.eu>,
        Anisse Astier <an.astier@criteo.com>
Subject: [PATCH] efivarfs: expose used and total size
Date:   Wed, 26 Apr 2023 21:58:53 +0200
Message-Id: <20230426195853.633233-1-anisse@astier.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Anisse Astier <an.astier@criteo.com>

When writing variables, one might get errors with no other message on
why it fails.

Being able to see how much is used by EFI variables helps analyzing such
issues.

Since this is not a conventionnal filesystem, block size is
intentionnally set to 1 instead of PAGE_SIZE.

x86 quirks of reserved size are taken into account and available and
free size can be different, further helping debugging space issues.

Signed-off-by: Anisse Astier <an.astier@criteo.com>
---
Notes:
Patch isn't split per subsystem intentionally, for better understanding
of intent; split could be trivial in a later version.

I'm not sure whether statfs(2) should return an error if the efi request
fails; I think it could be ignored with maybe a WARN_ONCE; which would
be close to the current behaviour.

Regards,

Anisse

---
 arch/x86/platform/efi/quirks.c |  8 ++++++++
 drivers/firmware/efi/efi.c     |  1 +
 drivers/firmware/efi/vars.c    | 12 ++++++++++++
 fs/efivarfs/super.c            | 26 +++++++++++++++++++++++++-
 include/linux/efi.h            | 10 ++++++++++
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b0b848d6933a..587fa51230e2 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -114,6 +114,14 @@ void efi_delete_dummy_variable(void)
 				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
 }
 
+u64 efi_reserved_space(void)
+{
+	if (efi_no_storage_paranoia)
+		return 0;
+	return EFI_MIN_RESERVE;
+}
+EXPORT_SYMBOL_GPL(efi_reserved_space);
+
 /*
  * In the nonblocking case we do not attempt to perform garbage
  * collection if we do not have enough free space. Rather, we do the
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index abeff7dc0b58..d0dfa007bffc 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -211,6 +211,7 @@ static int generic_ops_register(void)
 	generic_ops.get_variable = efi.get_variable;
 	generic_ops.get_next_variable = efi.get_next_variable;
 	generic_ops.query_variable_store = efi_query_variable_store;
+	generic_ops.query_variable_info = efi.query_variable_info;
 
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
 		generic_ops.set_variable = efi.set_variable;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index bd75b87f5fc1..c5382d5c3073 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -245,3 +245,15 @@ efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	return status;
 }
 EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
+
+efi_status_t efivar_query_variable_info(u32 attr,
+					u64 *storage_space,
+					u64 *remaining_space,
+					u64 *max_variable_size)
+{
+	if (!__efivars->ops->query_variable_info)
+		return EFI_UNSUPPORTED;
+	return __efivars->ops->query_variable_info(attr, storage_space,
+			remaining_space, max_variable_size);
+}
+EXPORT_SYMBOL_NS_GPL(efivar_query_variable_info, EFIVAR);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 482d612b716b..064bfc0243c9 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -13,6 +13,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/slab.h>
 #include <linux/magic.h>
+#include <linux/statfs.h>
 
 #include "internal.h"
 
@@ -23,8 +24,31 @@ static void efivarfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	u64 storage_space, remaining_space, max_variable_size;
+	efi_status_t status;
+	const u32 attr = (EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
+	 EFI_VARIABLE_RUNTIME_ACCESS);
+
+	buf->f_type = dentry->d_sb->s_magic;
+	buf->f_bsize = 1;
+	buf->f_namelen = NAME_MAX;
+
+	status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
+					    &max_variable_size);
+	if (status != EFI_SUCCESS)
+		return efi_status_to_err(status);
+	buf->f_blocks = storage_space;
+	buf->f_bfree = remaining_space;
+	if (remaining_space > efi_reserved_space())
+		buf->f_bavail = remaining_space - efi_reserved_space();
+	else
+		buf->f_bavail = 0;
+	return 0;
+}
 static const struct super_operations efivarfs_ops = {
-	.statfs = simple_statfs,
+	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = efivarfs_evict_inode,
 };
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7aa62c92185f..d2b686191870 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -703,6 +703,7 @@ static inline void efi_enter_virtual_mode (void) {}
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
 					     bool nonblocking);
+extern u64 efi_reserved_space(void);
 #else
 
 static inline efi_status_t efi_query_variable_store(u32 attributes,
@@ -711,6 +712,10 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 {
 	return EFI_SUCCESS;
 }
+static inline u64 efi_reserved_space(void)
+{
+	return 0;
+}
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
@@ -1042,6 +1047,7 @@ struct efivar_operations {
 	efi_set_variable_t *set_variable;
 	efi_set_variable_t *set_variable_nonblocking;
 	efi_query_variable_store_t *query_variable_store;
+	efi_query_variable_info_t *query_variable_info;
 };
 
 struct efivars {
@@ -1087,6 +1093,10 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
 efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 				 u32 attr, unsigned long data_size, void *data);
 
+efi_status_t efivar_query_variable_info(u32 attr, u64 *storage_space,
+					u64 *remaining_space,
+					u64 *max_variable_size);
+
 #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
 extern bool efi_capsule_pending(int *reset_type);
 
-- 
2.34.1

