Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25DC6E37E5
	for <lists+linux-efi@lfdr.de>; Sun, 16 Apr 2023 14:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDPMIX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Apr 2023 08:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDPMIM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 16 Apr 2023 08:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8E4C0F;
        Sun, 16 Apr 2023 05:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE2861365;
        Sun, 16 Apr 2023 12:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19063C433D2;
        Sun, 16 Apr 2023 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681646888;
        bh=06PSEkpwNBLhUVGwmELjtXXINIi/t/xKb7+PwqjgazA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FttnNmY69tXh3Mi4g57fhgHdU+fN5uUQVWdl/Pe32ipnW+/C9noAtrFCDANd66VEb
         oxLF2yszcYf9PWxReh6uHGEJzEdUkX9unVCMPgebyXCWmccOASrDNq0euyGd932xhe
         jd1annFh6yunxE5bkvplAdS1jmE7SLfq1Q17dgkyvEW7x6LleTgpuxn/DwPVLbb/JB
         JOpMuGXg6qtTSmBTUM+bOTB9Y5WCPbWRykQuDM3ExPj1pXyPI+nezoPoQlxnDt0QuR
         QUj6cBes4+AzQ1YwskIDiv35xZA/H5Em3hd4F5nKbEbIjx55LxzgN9bcWOJayII96q
         iPcIGKQna1gFQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 3/3] efi/zboot: x86: Clear NX restrictions on populated code regions
Date:   Sun, 16 Apr 2023 14:07:29 +0200
Message-Id: <20230416120729.2470762-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416120729.2470762-1-ardb@kernel.org>
References: <20230416120729.2470762-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3939; i=ardb@kernel.org; h=from:subject; bh=06PSEkpwNBLhUVGwmELjtXXINIi/t/xKb7+PwqjgazA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcX6KeOEJ0cntPbpySZ3Pn890bH39HkbA92ULQcZqla53 utdZdzTUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSf5mRYW97cb7o5dszzZgV 7Q48Lo50u3X6vv/jS4GcvBc2/lvIeZDhf9XOy7HZTB4ulQqLQ25d+vA72ftJ34lI/aag3Ysv11s 4sAIA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Future EFI firmware will require the PE/COFF NX_COMPAT header flag to be
set in order to retain access to all system facilities while features
such as UEFI secure boot or TCG measured boot are enabled.

The consequence of setting this flag is that the EFI firmware image
loader may configure the page allocator to set the NX attribute on all
allocations requested by the image. This means we should clear this
attribute on all regions we allocate and expect to be able to execute
from.

In the x86 EFI zboot case, the only code we execute under EFI's 1:1
mapping that was not loaded by the image loader itself is the trampoline
that effectuates the switch between 4 and 5 level paging, and the part
of the loaded kernel image that runs before switching to its own page
tables.  So let's use the EFI memory attributes protocol to clear the NX
attribute on these regions.

Whether or not setting the read-only attribute first is required is
unclear at this point. Given that the kernel startup code uses two
different executable sections before switching to its own page tables
(normal text and inittext, with a writable data section in between),
this would require some minor reorganization of the kernel memory map.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S                |  4 +++
 drivers/firmware/efi/libstub/x86-zboot.c | 27 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4ae067852fb28663..38897ac51f13bb55 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -74,6 +74,10 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 */
 	.org	startup_64 + 0x10 - 3, BYTES_NOP1
 	nopl	(_end - startup_64)(%rax)
+
+	/* put the size of the initial executable mapping at offset 0x20 */
+	.org	startup_64 + 0x20 - 3, BYTES_NOP1
+	nopl	(_einittext - startup_64)(%rax)
 #endif
 	leaq	_text(%rip), %rdi
 
diff --git a/drivers/firmware/efi/libstub/x86-zboot.c b/drivers/firmware/efi/libstub/x86-zboot.c
index 16e8b315892dedda..70668104804fb050 100644
--- a/drivers/firmware/efi/libstub/x86-zboot.c
+++ b/drivers/firmware/efi/libstub/x86-zboot.c
@@ -60,10 +60,33 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 	return status;
 }
 
+static void efi_remap_exec(unsigned long base, unsigned long size)
+{
+	static efi_memory_attribute_protocol_t *memattr = (void *)ULONG_MAX;
+	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
+	efi_status_t status;
+
+	if (memattr == (void *)ULONG_MAX) {
+		memattr = NULL;
+		status = efi_bs_call(locate_protocol, &guid, NULL,
+				     (void **)&memattr);
+		if (status != EFI_SUCCESS)
+			return;
+	} else if (!memattr) {
+		return;
+	}
+
+	status = memattr->clear_memory_attributes(memattr, base, size,
+						  EFI_MEMORY_XP);
+	if (status != EFI_SUCCESS)
+		efi_warn("Failed to clear NX attribute on code region\n");
+}
+
 void efi_cache_sync_image(unsigned long image_base, unsigned long alloc_size)
 {
 	const u32 payload_size = *(u32 *)(_gzdata_end - 4);
 	const u32 image_size = *(u32 *)(image_base + 0x10);
+	const u32 code_size = *(u32 *)(image_base + 0x20);
 	const s32 *reloc = (s32 *)(image_base + payload_size);
 	u64 va_offset = __START_KERNEL - image_base;
 	u64 range, delta;
@@ -107,6 +130,8 @@ void efi_cache_sync_image(unsigned long image_base, unsigned long alloc_size)
 		*(u64 *)((s64)*reloc - va_offset) += delta;
 
 	efi_free(alloc_size - image_size, image_base + image_size);
+
+	efi_remap_exec(image_base, PAGE_ALIGN(code_size));
 }
 
 static void __naked tmpl_toggle(void *cr3, void *gdt)
@@ -197,6 +222,8 @@ static efi_status_t efi_setup_5level_paging(void)
 	 */
 	*(u32 *)&la57_code[tmpl_size - 6] += (u64)la57_code;
 
+	efi_remap_exec((unsigned long)la57_code, PAGE_SIZE);
+
 	return EFI_SUCCESS;
 }
 
-- 
2.39.2

