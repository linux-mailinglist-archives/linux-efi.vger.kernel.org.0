Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240863DCA6
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 19:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiK3SGA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 13:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiK3SFo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 13:05:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D366774CFE
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 10:05:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A159B81C96
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 18:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DBC433C1;
        Wed, 30 Nov 2022 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669831540;
        bh=oYXheTibB3OfU1ObSUKtKc++WJUiAlDnFDDSyJHqN/4=;
        h=From:To:Cc:Subject:Date:From;
        b=Cfmz4f2a2NMLBjYR1qjaeDAZvhOc+xFaWR/w/JK8Bd2OygCmQxBbXpAAiYmT19+0L
         plg9KgEShaDnbUkgpJGv8zrytUQpcG6Fy/9BRgL3mz7x3/D7aiYcIYj0Qf4zb3gVtR
         33hAwPKmkGRcGtdffKo6Ab647uktN9U4DfXvclVaKuwPVR6eHFePCaW3/Bj0wNlLsr
         TqtX5jMVdUXTikDZybdfP3efS3xgo8EUn8pzbfSVdzqOo05GG/O1ndDo70oueMS69V
         +YKqJmiB5MWEN8dEfHPDCPV3J+DBB9pjBtZtWuA0EUzUCYr9SjZqBBhdsAGL9Cr+oh
         a6rou350sqW+Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] arm64: efi: Move runtime services asm wrapper out of .text
Date:   Wed, 30 Nov 2022 19:05:35 +0100
Message-Id: <20221130180535.2667887-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5788; i=ardb@kernel.org; h=from:subject; bh=oYXheTibB3OfU1ObSUKtKc++WJUiAlDnFDDSyJHqN/4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjh5tuj/RBz6vRN27V6YC7m9Bk4w5bLv6H+v9DmDXo uOCo++uJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY4ebbgAKCRDDTyI5ktmPJB+yC/ 9yYeyiRhU+GsO6h7acgdlQo4HHUQFJv59zRbNf6ixdLso+lroy/4BhFWurCIrdD8o+lDdlcX0q9jXC OVjn1vpvnrg2LuJFW55GfqTeCKBwRI4Kn8wuYvRvOUjrM+yE1wEy+fc1gsh5v99PFFMmtKyd9JGQiA DgSrCmVjbj3TMhys+vZib3CndA1or8WyI8BYkUCahsfFa9fS3wib/gB0VUHOKMjIg31bL+iBPgI/7p H51ggBKnL/w+r+JvgD54WpINd1op18v7NsQY40QRYM0JMJMQwhy5GXIR3HYg7SYSoDHYn0KiRHSMIM qO82dnJDF6EfH4VNZP70YyPjrQ6Fu5x/rCvHSrBmLOMFQEZEfgYpoib24CCMY89w9730Xl9hIEFgys qux45sTKOB83yKAmCiZQc96djV83eLz9ncbmZWXybAcu5jA8ApQk4FpcZIT3UN7wUIxunEvif7kUen Cjrje/GMBey+mUsB8cZpe8ds9ib4A4CsJ8wEd0Cmk0s5A=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI runtime services wrapper code checks whether register X18 was
corrupted by firmware code, and prints a diagnostic message to the
kernel log if this was the case, as this violates the EFI spec, and may
interfere with the OS's use of this register as a platform register (as
the AAPCS calls it). This functionality was added in commit 7e611e7dbb23
("efi/arm64: Check whether x18 is preserved by runtime services calls"),
at which time X18 was not used in such a special role, so we did not
bother to restore it, and only moaned about it.

Only when shadow call stack support was added, we started using X18 in a
special role, to carry the shadow call stack pointer. This meant that,
when X18 does get corrupted, we need to restore it from a known good
value before proceeding, as C code built with shadow call stacks enabled
cannot function without one. And given that we already preserved the old
value in order to determine whether EFI corrupted it or not, we could
restore it just as easily, as we did in commit e73f02c6eb15 ("arm64:
efi: Restore register x18 if it was corrupted")

However, restoring the shadow call stack pointer from the stack is a bad
idea, as the whole point of the shadow call stack is that the ordinary
stack cannot be trusted with return addresses. And having a snippet of
code in the executable mapping of the kernel text that does this is
asking for problems.

So let's move this code out of there, and only map it executable in the
EFI page tables, which are only ever active while a runtime service call
is in progress, and only on the CPU that makes the call.

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h       |  4 +-
 arch/arm64/kernel/efi-rt-wrapper.S |  9 ++++-
 arch/arm64/kernel/efi.c            | 39 ++++++++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 439e2bc5d5d8b652..29e593cb8fe51155 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -29,7 +29,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #undef arch_efi_call_virt
 #define arch_efi_call_virt(p, f, args...)				\
-	__efi_rt_asm_wrapper((p)->f, #f, args)
+	efi_rt_asm_wrapper((p)->f, #f, args)
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
@@ -37,7 +37,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 	efi_virtmap_unload();						\
 })
 
-efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
+extern efi_status_t (* efi_rt_asm_wrapper)(void *, const char *, ...);
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 75691a2641c1c0f8..e9517b8446c7416a 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -5,6 +5,12 @@
 
 #include <linux/linkage.h>
 
+// The code below (until the end of the file) is mapped into the EFI page
+// tables by the efi_map_rt_wrapper() routine, which assumes that it takes up
+// at most a page, and that it refers to external symbols using absolute
+// addressing only.
+
+	.section ".rodata", "a", %progbits
 SYM_FUNC_START(__efi_rt_asm_wrapper)
 	stp	x29, x30, [sp, #-32]!
 	mov	x29, sp
@@ -43,5 +49,6 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	 * for interrupts.
 	 */
 	mov	x18, x2
-	b	efi_handle_corrupted_x18	// tail call
+	ldr	x16, =efi_handle_corrupted_x18	// tail call
+	br	x16
 SYM_FUNC_END(__efi_rt_asm_wrapper)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e1be6c429810d0d5..ec7d862528d7c154 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -53,6 +53,37 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 	return pgprot_val(PAGE_KERNEL_EXEC);
 }
 
+static u64 __initdata max_virt_addr;
+
+efi_status_t (* efi_rt_asm_wrapper)(void *, const char *, ...) __ro_after_init;
+
+static int __init efi_map_rt_wrapper(void)
+{
+	extern const __le32 __efi_rt_asm_wrapper[];
+
+	u64 phys_base = __pa_symbol(__efi_rt_asm_wrapper) & PAGE_MASK;
+	u64 virt_base = max_virt_addr ?: phys_base;
+	u64 offset = virt_base - phys_base;
+	pgprot_t prot = PAGE_KERNEL_ROX;
+
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		return 0;
+
+	/*
+	 * Map the EFI runtime call wrapper routine into the EFI page tables at
+	 * a virtual address that is known to be available: either 1:1 if that
+	 * is what EFI is doing as well, or at the lowest unused VA above the
+	 * existing runtime services mappings otherwise.
+	 */
+	pgprot_val(prot) |= PTE_MAYBE_GP;
+	create_pgd_mapping(&efi_mm, phys_base, virt_base, 2 * PAGE_SIZE, prot,
+			   false);
+
+	efi_rt_asm_wrapper = (void *)__pa_symbol(__efi_rt_asm_wrapper) + offset;
+	return 0;
+}
+core_initcall(efi_map_rt_wrapper);
+
 /* we will fill this structure from the stub, so don't put it in .bss */
 struct screen_info screen_info __section(".data");
 EXPORT_SYMBOL(screen_info);
@@ -80,6 +111,14 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 	create_pgd_mapping(mm, md->phys_addr, md->virt_addr,
 			   md->num_pages << EFI_PAGE_SHIFT,
 			   __pgprot(prot_val | PTE_NG), page_mappings_only);
+
+	// capture the top of the occupied VA space if not using a 1:1 mapping
+	if (md->virt_addr != md->phys_addr) {
+		u64 top = PAGE_ALIGN(md->virt_addr +
+				     (md->num_pages << EFI_PAGE_SHIFT));
+
+		max_virt_addr = max(max_virt_addr, top);
+	}
 	return 0;
 }
 
-- 
2.35.1

