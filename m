Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC16ED2FD
	for <lists+linux-efi@lfdr.de>; Mon, 24 Apr 2023 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjDXQ6J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Apr 2023 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjDXQ6A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Apr 2023 12:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC2A257;
        Mon, 24 Apr 2023 09:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56A0362209;
        Mon, 24 Apr 2023 16:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A960C4339E;
        Mon, 24 Apr 2023 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682355472;
        bh=x0BOo1C921LZfjOOg4Hj+pr1OqgyQhQHCvsWmPOfruY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQ8P9uCtM7OuU48FixAiNcryK170nO5pGY/V56KSvsnYaCSYtRTxf/eOLBvWu6k0b
         LEiwfUxes8TxLN5115QmjVna2eitx4qSvPInknO3Xl9lxahp9v9n534t1R9TxqUSkq
         1uzHoM7tg9s0BFUAylCAowMfquG9wnnLq8zn4cg3pNrnmkIN+YIdiKDTYVLQNm7FPD
         FXilJMaUjJGJeRqXlDvsPoDBk/7wy9H7t2wDd4lQbGoOc58qsAb2acAFu5TeFvoQq0
         sM6OuYVB3V07rJ9EqGwnr4ady6nBJYxxqsBg90K7qtE9vY6RwvZauT935QqXg/w68o
         C1g+zoYML2OPQ==
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
Subject: [PATCH 4/6] x86: efistub: Perform 4/5 level paging switch from the stub
Date:   Mon, 24 Apr 2023 18:57:24 +0200
Message-Id: <20230424165726.2245548-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6959; i=ardb@kernel.org; h=from:subject; bh=x0BOo1C921LZfjOOg4Hj+pr1OqgyQhQHCvsWmPOfruY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVty6e2k5f29c2Y9a/Q0OYlx3XH10tkXjVz+rmV7/jHu 1Fi4WOvjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRHQsZGXaopp26uFQvLGmj 00G/W9ItLBxeB6/bdbMtuqvjm/19xkmGfwrTFj7YcCT0wMJwrap7XEef1yW67dY9IRX5yGX2ig2 dCewA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for updating the EFI stub boot flow to avoid the bare
metal decompressor code altogether, implement the support code for
switching between 4 and 5 levels of paging before jumping to the kernel
proper.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
 drivers/firmware/efi/libstub/x86-stub.c        | 145 ++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1e0203d74691ffcc..fc5f3b4c45e91401 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -16,6 +16,8 @@
 
 #include "efistub.h"
 
+extern bool efi_no5lvl;
+
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_novamap;
@@ -73,6 +75,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
+		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
+			efi_no5lvl = true;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e136c94037dda8d3..7b8717cbb96a1246 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -760,6 +760,139 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
+#ifdef CONFIG_X86_64
+bool efi_no5lvl;
+
+static const struct desc_struct gdt[] = {
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]   = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
+};
+
+static void (*la57_toggle)(void *cr3, void *gdt);
+
+static void __naked tmpl_toggle(void *cr3, void *gdt)
+{
+	/*
+	 * This is template code that will be copied into a 32-bit addressable
+	 * buffer, allowing us to drop to 32-bit mode with paging disabled,
+	 * which is required to be able to toggle the CR4.LA57 bit.
+	 *
+	 * The first MOVB instruction is only there to capture the size of the
+	 * sequence, and implicitly, the offset to the LJMP's immediate, which
+	 * will be populated with the correct absolute address after copying.
+	 */
+	asm("0:	movb	$(4f - .), %%al		\n\t"
+	    "	lgdt	(%%rsi)			\n\t"
+	    "	movw	%[ds], %%ax		\n\t"
+	    "	movw	%%ax, %%ds		\n\t"
+	    "	movw	%%ax, %%ss		\n\t"
+	    "	leaq	2f(%%rip), %%rax	\n\t"
+	    "	pushq	%[cs32]			\n\t"
+	    "	pushq	%%rax			\n\t"
+	    "	lretq				\n\t"
+	    "1:	retq				\n\t"
+	    "	.code32				\n\t"
+	    "2: movl	%%cr0, %%eax		\n\t"
+	    "	btrl	%[pg], %%eax		\n\t"
+	    "	movl	%%eax, %%cr0		\n\t"
+	    "	jmp	3f			\n\t"
+	    "3: movl	%%cr4, %%ecx		\n\t"
+	    "	btcl	%[la57], %%ecx		\n\t"
+	    "	movl	%%ecx, %%cr4		\n\t"
+	    "	movl	%%edi, %%cr3		\n\t"
+	    "	btsl	%[pg], %%eax		\n\t"
+	    "	movl	%%eax, %%cr0		\n\t"
+	    "	ljmpl	%[cs], $(1b - 0b)	\n\t"
+	    "4:	.code64"
+	    :
+	    : [cs32]	"i"(__KERNEL32_CS),
+	      [cs]	"i"(__KERNEL_CS),
+	      [ds]	"i"(__KERNEL_DS),
+	      [pg]	"i"(X86_CR0_PG_BIT),
+	      [la57]	"i"(X86_CR4_LA57_BIT));
+}
+
+/*
+ * Enabling (or disabling) 5 level paging is tricky, because it can only be
+ * done from 32-bit mode with paging disabled. This means not only that the
+ * code itself must be running from 32-bit addressable physical memory, but
+ * also that the root page table must be 32-bit addressable, as we cannot
+ * program a 64-bit value into CR3 when running in 32-bit mode.
+ */
+static efi_status_t efi_setup_5level_paging(void)
+{
+	const u8 tmpl_size = ((u8 *)tmpl_toggle)[1];
+	efi_status_t status;
+	u8 *la57_code;
+
+	if (!efi_is_64bit())
+		return EFI_SUCCESS;
+
+	/* check for 5 level paging support */
+	if (native_cpuid_eax(0) < 7 ||
+	    !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		return EFI_SUCCESS;
+
+	/* allocate some 32-bit addressable memory for code and a page table */
+	status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
+				    U32_MAX);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	la57_toggle = memcpy(la57_code, tmpl_toggle, tmpl_size);
+	memset(la57_code + tmpl_size, 0x90, PAGE_SIZE - tmpl_size);
+
+	/*
+	 * To avoid having to allocate a 32-bit addressable stack, we use a
+	 * ljmp to switch back to long mode. However, this takes an absolute
+	 * address, so we have to poke it in at runtime. The dummy MOVB
+	 * instruction at the beginning can be used to locate the immediate.
+	 */
+	*(u32 *)&la57_code[tmpl_size - 6] += (unsigned long)la57_code;
+
+	adjust_memory_range_protection((unsigned long)la57_code, PAGE_SIZE);
+
+	return EFI_SUCCESS;
+}
+
+static void efi_5level_switch(void)
+{
+	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
+	bool need_toggle = want_la57 ^ have_la57;
+	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
+	u64 *cr3 = (u64 *)__native_read_cr3();
+	struct desc_ptr desc;
+	u64 *new_cr3;
+
+	if (!la57_toggle || !need_toggle)
+		return;
+
+	if (!have_la57) {
+		/*
+		 * We are going to enable 5 level paging, so we need to
+		 * allocate a root level page from the 32-bit addressable
+		 * physical region, and plug the existing hierarchy into it.
+		 */
+		new_cr3 = memset(pgt, 0, PAGE_SIZE);
+		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
+	} else {
+		// take the new root table pointer from the current entry #0
+		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+
+		// copy the new root level table if it is not 32-bit addressable
+		if ((u64)new_cr3 > U32_MAX)
+			new_cr3 = memcpy(pgt, new_cr3, PAGE_SIZE);
+	}
+
+	desc.size       = sizeof(gdt) - 1;
+	desc.address    = (u64)gdt;
+
+	la57_toggle(new_cr3, &desc);
+}
+#endif
+
 /*
  * On success, we return the address of startup_32, which has potentially been
  * relocated by efi_relocate_kernel.
@@ -792,6 +925,14 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 				(get_efi_config_table(ACPI_20_TABLE_GUID) ?:
 				 get_efi_config_table(ACPI_TABLE_GUID));
 
+#ifdef CONFIG_X86_64
+	status = efi_setup_5level_paging();
+	if (status != EFI_SUCCESS) {
+		efi_err("efi_setup_5level_paging() failed!\n");
+		goto fail;
+	}
+#endif
+
 	/*
 	 * If the kernel isn't already loaded at a suitable address,
 	 * relocate it.
@@ -910,6 +1051,10 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
+#ifdef CONFIG_X86_64
+	efi_5level_switch();
+#endif
+
 	return bzimage_addr;
 fail:
 	efi_err("efi_main() failed!\n");
-- 
2.39.2

