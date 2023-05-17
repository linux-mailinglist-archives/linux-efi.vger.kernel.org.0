Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D332706D02
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjEQPiv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEQPiu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 11:38:50 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EF2E42;
        Wed, 17 May 2023 08:38:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BAD683200979;
        Wed, 17 May 2023 11:38:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 17 May 2023 11:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1684337926; x=1684424326; bh=8tUkqu4Snx
        JslSlwewBUm38PcMeP/YT6yZUNpdaIIDU=; b=DyYZzMJMGFjD7wnpL6j6isdox4
        aOFJUSvvkY5rs7ZKwt2JtSGtImbrII0Ah+DPSe2KvIsJwC9cPniQ3kjbDsYe9pXf
        PSVIc276h2rJ0WzgkyTmpfguxiiBhWckxx7/j4RDpkWfsC4w74NI0FWSkuT/k62P
        Jm4tLvIqDYiicyqSFjE3hio5ymWlnn/mN8WnGqg5RCoflFLe7X4nbQbE0lGn7aAV
        7B7iFeMZUv3+8jC1iIf3XvdRPtn0zJBH2UR2KWH53aYnXPoqKFIrZraXdqz/C4nm
        /HJSBBBEPh1KOZIWvaQlrvQSacSH+xldDJDTzE/STppeB1a2koy/agnAeO3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684337926; x=1684424326; bh=8tUkqu4SnxJsl
        SlwewBUm38PcMeP/YT6yZUNpdaIIDU=; b=TENbR30rVUVF4k3ujylMj5bzlx+pZ
        ZZ+bc0+YgT9EEdAZFktuvKjL7mhOAt+HtPspZIdAkVatid9M6UGkp7TrzjAtYS4N
        Yc+mWZ/6GTZmVQq2iEWpETW/EF5ff0GRC6vIU0yYM8V60O9fwNNsI1RzfqQx6SzB
        sNcyYTDVISYX5cIV4ax/DCHjbIhbIcCnJu0+YGLLtYL7/AlGI8QByTss8vfddWF0
        XWr+sUo7Ni5eVTTrpW7FA6GYm9N/WGLVFyp8r+gRdvdePGb7oB+C5jooTTlPyn/F
        VcURvFsjFSpQqofwjiu7TiWCaURfzp2pYYjnU1bDYbiFvErksMTyE31iw==
X-ME-Sender: <xms:BfVkZIehF5y55-piwtquWCZPkImNXgRvgcNWQZgoze_CsZmFdsGaFg>
    <xme:BfVkZKMsmfNYEFA_iAfRmgRvfHQ_iwibvCcklJn5Qn6W_2eDgysCAanMJ4Wu62NMp
    ZCvDs1EbXxqqLtAfmU>
X-ME-Received: <xmr:BfVkZJjL9s28rAB-13cPtYLrKxcgiuC_lDkGh35aF5TBMci5nKVkO9zie1e_ioUssUuhynT3thCzdHHWCyuwG2dTMEWmSbivSO5Vwd3Bb3xL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehnihhsshgv
    ucetshhtihgvrhcuoegrnhhishhsvgesrghsthhivghrrdgvuheqnecuggftrfgrthhtvg
    hrnheptdffhfelkeehhfehfeettdfhjefgffdvtdelhefftdejffdtheekteeffeeileek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnih
    hsshgvsegrshhtihgvrhdrvghu
X-ME-Proxy: <xmx:BfVkZN-rAjLqVn3RKYAcQ0owthRHK3y1q7KPPHiwGgK5J-w-AHyhYw>
    <xmx:BfVkZEtMZcEoKYZ0RYDCbzNjuzxpm-nfjn0LeiQlB0e3G_jOk67O1w>
    <xmx:BfVkZEF6tzreWaP2VieF_ihIHFDF0l8-hCCf8hW0Yc6AlXg5mZbdjA>
    <xmx:BvVkZFOk0Ykz4lJXKa8uH2ChXnoL6dZTqPUDc0FJ1p6bvU4oYDNlsQ>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 11:38:42 -0400 (EDT)
From:   Anisse Astier <anisse@astier.eu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jeremy Kerr <jk@ozlabs.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anisse Astier <an.astier@criteo.com>, lennart@poettering.net,
        Richard Hughes <hughsient@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2] efivarfs: expose used and total size
Date:   Wed, 17 May 2023 17:38:12 +0200
Message-Id: <20230517153812.2010174-1-anisse@astier.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Anisse Astier <an.astier@criteo.com>

When writing EFI variables, one might get errors with no other message
on why it fails. Being able to see how much is used by EFI variables
helps analyzing such issues.

Since this is not a conventionnal filesystem, block size is
intentionnally set to 1 instead of PAGE_SIZE.

x86 quirks of reserved size are taken into account; so that available
and free size can be different, further helping debugging space issues.

With this patch, one can see the remaining space in EFI variable storage
via efivarfs, like this:

   $ df -h /sys/firmware/efi/efivars/
   Filesystem      Size  Used Avail Use% Mounted on
   efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars

Signed-off-by: Anisse Astier <an.astier@criteo.com>
---
Notes:

Patch isn't split per subsystem intentionally, for better understanding
of intent; I don't think it's necessary, but split could be trivial in
an another version.

Changes since v1:
 - update commit message to show how it can be used in userspace
 - add comments to explain the values put in f_bsize, f_blocks, f_bfree
   and f_bavail
 - rebase on top v6.4-rc2

Thanks to Christan Brauner for the review.

Regards,

Anisse

---
 arch/x86/platform/efi/quirks.c |  8 ++++++++
 drivers/firmware/efi/efi.c     |  1 +
 drivers/firmware/efi/vars.c    | 12 ++++++++++++
 fs/efivarfs/super.c            | 36 +++++++++++++++++++++++++++++++++-
 include/linux/efi.h            | 10 ++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)

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
index bfc5fa6aa47b..e9dc7116daf1 100644
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
index 482d612b716b..c27de959cb5b 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -13,6 +13,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/slab.h>
 #include <linux/magic.h>
+#include <linux/statfs.h>
 
 #include "internal.h"
 
@@ -23,8 +24,41 @@ static void efivarfs_evict_inode(struct inode *inode)
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
+	/*
+	 * This is not a normal filesystem, so no point in pretending it has a block
+	 * size; we declare f_bsize to 1, so that we can then report the exact value
+	 * sent by EFI QueryVariableInfo in f_blocks and f_bfree
+	 */
+	buf->f_bsize = 1;
+	buf->f_namelen = NAME_MAX;
+
+	status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
+					    &max_variable_size);
+	if (status != EFI_SUCCESS)
+		return efi_status_to_err(status);
+	buf->f_blocks = storage_space;
+	buf->f_bfree = remaining_space;
+	/*
+	 * In f_bavail we declare the free space that the kernel will allow writing
+	 * when the storage_paranoia x86 quirk is active. To use more, users
+	 * should boot the kernel with efi_no_storage_paranoia.
+	 */
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

