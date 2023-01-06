Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC14B6605E7
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jan 2023 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjAFRrq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Jan 2023 12:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjAFRre (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Jan 2023 12:47:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D82765BA
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 09:47:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2A2CB81E43
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 17:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A69C43396;
        Fri,  6 Jan 2023 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027250;
        bh=BseEePZnqnWaZL4ayqR2kOwTtRp2TnxAyINkH5Yjn8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4XzZ8UzLec9KIhNtHgnQK3dx3ixV+aBcrCqAz0bIeVGF740ZKLBQYE8cbRAkd/CY
         FAcemDbVxzP9OJa/DoWMaj0t5kBFPfY7N3x1jnlUfXR52ZW7ki515kI9hM0bFpvPx4
         dzUHVglVDkNk15S2pdsaOJjlVKzFtknKOdlle0VuauurwRg5tjLUxBYZ9TGnBOfCFU
         ozJzzs1m3azojdQrrTxsbZaw+p9Wzv9uztFdvRBzIbG1IdFlYIoNkZ5t/TCDpdmzUf
         v1gc7BUkxJipYYUfadaNSj2hlsXdta6D3lB8HmcQHMBHg8Cdt95DrLjk7D7faw5mgq
         o6W7m2xOb7Q+A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee@kernel.org>
Subject: [PATCH v3 1/2] arm64: efi: Avoid workqueue to check whether EFI runtime is live
Date:   Fri,  6 Jan 2023 18:47:02 +0100
Message-Id: <20230106174703.1883495-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106174703.1883495-1-ardb@kernel.org>
References: <20230106174703.1883495-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=ardb@kernel.org; h=from:subject; bh=BseEePZnqnWaZL4ayqR2kOwTtRp2TnxAyINkH5Yjn8g=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjuF6V8rda77TfbpvagjLK6TQra2+V4zTrZXhVO9Nx mw2rT6qJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY7helQAKCRDDTyI5ktmPJKHEDA CcMsgAcS8y6z7ZbnxUSJlieeI4pM+JMUodo7n+9GkaZBltKeY/EOwzQNcujAgDLelhiLiJ19zh2ggP +WF7oNBRhoXd33YBsC0XM0/nTcnCeT/FIOfbfLiAeAhOAeZKfdWDe7TBRfqAJntiI8Q6K5fy6I45n3 JUh0ZlUiEhEeL76cjCL4ts3WHtgCV2RPlDJIY+1nHVQh02mRaynPc7SCaBAfnPTXi4R8BQBiFnOgO0 sJeC/AgbZqj6rAx/0BmdXIFGrIp/b/4dMmgU4o5UtBpr5ErcMZXDJjSJuD5aaI9dP6mL77VKjsyTA0 7n6NNScF4RhG/LD7zVr1W+KRnl54ZXgrDKD7EMZ2eQaJvst6V7QzYqeymMAj1LCyvajDj4PsV6m5Hg v8nAJ2RQE+8Y8Kl9NdZCQLOg80KcR0ElwkmksB8eEpUEe2drh3TdgKXoX/8caZeGmyW4cj3hCvukKb eO88+fiwg/EHmu9hSwVsXz6v1uCkX4TCmJeQHhwegpd1c=
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

Comparing current_work() against efi_rts_work.work is sufficient to
decide whether current is currently running EFI runtime services code at
any level in its call stack.

However, there are other potential users of the EFI runtime stack, such
as the ACPI subsystem, which may invoke efi_call_virt_pointer()
directly, and so any sync exceptions occurring in firmware during those
calls are currently misidentified.

So instead, let's check whether 'current' has preemption disabled, and
whether the stashed value of the thread stack pointer points into
current's thread stack. This can only be the case if current was
interrupted while running EFI runtime code. This implies that we should
clear the stashed value after switching back, to avoid false positives.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h       | 9 +++++++++
 arch/arm64/kernel/efi-rt-wrapper.S | 6 ++++++
 arch/arm64/kernel/efi.c            | 3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 31d13a6001df49c4..f68d13c3a44e7bb2 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -48,8 +48,17 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 })
 
 extern spinlock_t efi_rt_lock;
+extern u64 *efi_rt_stack_top;
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
+/*
+ * efi_rt_stack_top[-1] contains the value the stack pointer had before
+ * switching to the EFI runtime stack.
+ */
+#define current_in_efi()						\
+	(!preemptible() &&						\
+	 on_task_stack(current, READ_ONCE(efi_rt_stack_top[-1]), 1))
+
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
 /*
diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index a00886410537d6a6..11f3ec9f09e86de6 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -45,7 +45,10 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	mov	x4, x6
 	blr	x8
 
+	mov	x16, sp
 	mov	sp, x29
+	str	xzr, [x16, #8]			// clear recorded task SP value
+
 	ldp	x1, x2, [sp, #16]
 	cmp	x2, x18
 	ldp	x29, x30, [sp], #112
@@ -70,6 +73,9 @@ SYM_FUNC_END(__efi_rt_asm_wrapper)
 SYM_CODE_START(__efi_rt_asm_recover)
 	mov	sp, x30
 
+	ldr_l	x16, efi_rt_stack_top		// clear recorded task SP value
+	str	xzr, [x16, #-8]
+
 	ldp	x19, x20, [sp, #32]
 	ldp	x21, x22, [sp, #48]
 	ldp	x23, x24, [sp, #64]
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fab05de2e12dd5d8..b273900f45668587 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 
 #include <asm/efi.h>
+#include <asm/stacktrace.h>
 
 static bool region_is_misaligned(const efi_memory_desc_t *md)
 {
@@ -154,7 +155,7 @@ asmlinkage efi_status_t __efi_rt_asm_recover(void);
 bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
 {
 	 /* Check whether the exception occurred while running the firmware */
-	if (current_work() != &efi_rts_work.work || regs->pc >= TASK_SIZE_64)
+	if (!current_in_efi() || regs->pc >= TASK_SIZE_64)
 		return false;
 
 	pr_err(FW_BUG "Unable to handle %s in EFI runtime service\n", msg);
-- 
2.39.0

