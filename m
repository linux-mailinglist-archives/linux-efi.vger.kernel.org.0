Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101D64355E
	for <lists+linux-efi@lfdr.de>; Mon,  5 Dec 2022 21:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiLEUM0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Dec 2022 15:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiLEUMY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Dec 2022 15:12:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9883F275E8
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 12:12:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50D60B81212
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 20:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4C4C433D7;
        Mon,  5 Dec 2022 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670271141;
        bh=YmexWb2wA2VRGsLRvQxNTHg2UZC1lXNmFZOrLUB5d4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dd50h/1iawL+iuPA6ZwAzWdr/7HqiDAWWwRuDCtUq3+XmupQJQchpExGHgtd9qRcA
         517T5kzcgGEu+h8vuaR7m5IdXxbWmfFhpKk/b6dSClEEvksq1FUxGxeyCawW1oV84y
         HrMv6EuXL7otNd2Gr7q9Wx6W9ScEdZxl0dC0YraglkLBjvRwlD+EOFFVR0WPPz4GLv
         18yfNtFZi4bmVNL6zGg6E/UpmcaZMwiOvGii3PnwATJdRB9qMNEniq6BKMm1Wo0kXi
         36NESD9h6LYxlY4NIB80mNt/xsIdSb1bD38KemYv/a6xHgR4XxTSqOYVwwRxFQQo6a
         8v5DsBF0WvkCA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/2] arm64: efi: Execute runtime services from a dedicated stack
Date:   Mon,  5 Dec 2022 21:12:09 +0100
Message-Id: <20221205201210.463781-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221205201210.463781-1-ardb@kernel.org>
References: <20221205201210.463781-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4194; i=ardb@kernel.org; h=from:subject; bh=YmexWb2wA2VRGsLRvQxNTHg2UZC1lXNmFZOrLUB5d4E=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjjlCY1HWUzLnlv1k1WgzcWLtByrBOxwVGaGSKc3jy YHObtZGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY45QmAAKCRDDTyI5ktmPJItwC/ 9zrnYKpLdJRUJ2wAfoKuizXY17XfFCrE+7N2OpM4xp60KHwK0mYEXHX8cMfZtbyKfuonoRsaQjTbDf gpwop6siIzgdl5/k/w3KcCiQvaTlFLPSkZjq67UgP1JPi2bUhU2cUVO34NaQlX0TNKarkqazfG9yWS g9DHjeLbL4ELm58g+VbLmZmc+eK1uHGrqSRxCr6KqSVHRF44yVU0EpUgueKHJjT+XRjmLlCst9958f Zup4SWlK/4+ybaLMvzIGeM1iNTZQjgutDyslF6CvCFPlxhib3oj5KGzi2UE1Daf/nh2P3d4pXtbm8p HPcNESya6K7+9E7hpf3v1TkirtcgzcK7MEnmHRelXC0l999qfIuSPb5H07jzSYK9M7E4DtYqDfOh0I iAnCwfXFALtESRq5yvoqmUC4LM3P3bIfm6kDUvN3p8eBKp1pJtCURISg7tsKkC9+yKg2zOxGYPcxaT dTLEt2vQRmEAmcIQHbmcLtcUx1Y1TNbrsmj845tPJC6+A=
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

With the introduction of PRMT in the ACPI subsystem, the EFI rts
workqueue is no longer the only caller of efi_call_virt_pointer() in the
kernel. This means the EFI runtime services lock is no longer sufficient
to manage concurrent calls into firmware, but also that firmware calls
may occur that are not marshalled via the workqueue mechanism, but
originate directly from the caller context.

For added robustness, and to ensure that the runtime services have 8 KiB
of stack space available as per the EFI spec, introduce a spinlock
protected EFI runtime stack of 8 KiB, where the spinlock also ensures
serialization between the EFI rts workqueue (which itself serializes EFI
runtime calls) and other callers of efi_call_virt_pointer().

While at it, use the stack pivot to avoid reloading the shadow call
stack pointer from the ordinary stack, as doing so could produce a
gadget to defeat it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h       |  3 +++
 arch/arm64/kernel/efi-rt-wrapper.S | 13 +++++++++-
 arch/arm64/kernel/efi.c            | 25 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7c12e01c2b312e7b..1c408ec3c8b3a883 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -25,6 +25,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 ({									\
 	efi_virtmap_load();						\
 	__efi_fpsimd_begin();						\
+	spin_lock(&efi_rt_lock);					\
 })
 
 #undef arch_efi_call_virt
@@ -33,10 +34,12 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
+	spin_unlock(&efi_rt_lock);					\
 	__efi_fpsimd_end();						\
 	efi_virtmap_unload();						\
 })
 
+extern spinlock_t efi_rt_lock;
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 75691a2641c1c0f8..b2786b968fee68dd 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -16,6 +16,12 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	 */
 	stp	x1, x18, [sp, #16]
 
+	ldr_l	x16, efi_rt_stack_top
+	mov	sp, x16
+#ifdef CONFIG_SHADOW_CALL_STACK
+	str	x18, [sp, #-16]!
+#endif
+
 	/*
 	 * We are lucky enough that no EFI runtime services take more than
 	 * 5 arguments, so all are passed in registers rather than via the
@@ -29,6 +35,7 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	mov	x4, x6
 	blr	x8
 
+	mov	sp, x29
 	ldp	x1, x2, [sp, #16]
 	cmp	x2, x18
 	ldp	x29, x30, [sp], #32
@@ -42,6 +49,10 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	 * called with preemption disabled and a separate shadow stack is used
 	 * for interrupts.
 	 */
-	mov	x18, x2
+#ifdef CONFIG_SHADOW_CALL_STACK
+	ldr_l	x18, efi_rt_stack_top
+	ldr	x18, [x18, #-16]
+#endif
+
 	b	efi_handle_corrupted_x18	// tail call
 SYM_FUNC_END(__efi_rt_asm_wrapper)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index a908a37f03678b6b..8cb2e005f8aca589 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -144,3 +144,28 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	pr_err_ratelimited(FW_BUG "register x18 corrupted by EFI %s\n", f);
 	return s;
 }
+
+DEFINE_SPINLOCK(efi_rt_lock);
+
+asmlinkage u64 *efi_rt_stack_top __ro_after_init;
+
+/* required by the EFI spec */
+static_assert(THREAD_SIZE >= SZ_8K);
+
+int __init arm64_efi_rt_init(void)
+{
+	void *p = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
+				       VMALLOC_START, VMALLOC_END, GFP_KERNEL,
+				       PAGE_KERNEL, 0, NUMA_NO_NODE,
+				       __builtin_return_address(0));
+
+	if (!p) {
+		pr_warn("Failed to allocate EFI runtime stack\n");
+		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+		return -ENOMEM;
+	}
+
+	efi_rt_stack_top = p + THREAD_SIZE;
+	return 0;
+}
+core_initcall(arm64_efi_rt_init);
-- 
2.35.1

