Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375065DB6C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjADRou (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 12:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjADRot (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 12:44:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F961B1DB
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 09:44:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E34A8B81898
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 17:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B519C43392;
        Wed,  4 Jan 2023 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854285;
        bh=RVLeuAkGJfKugExBOTAaGVn7MhDxBZ6OszcRfikiIro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSdvXAAnY0thUFsfEFE3i6d7TySSnCTea2lnKMr1SPPDZMr9ugTFebaOzyQuh+l9a
         5BzEDkXbieHARhpxTShMS+wrUwBZIIq1HO1+87oVxeL7TeDCH/vwlbUJ/GzMmej8G/
         auKTy3K5ekouLtSgu/htyp76fvdBdcI1UhQO58guFz5sSfeyfFEK9vJpjqtqD5Sd8x
         nmQU22Fm001K85zFU27fVT8+2glFw38YaGRKydZPplrlxoZcxSqbgcYnEzcLGNc3ZJ
         I9mU4ez+Y8Buh0eBsyNTESSTU7Qx50v2U1KvMTosZNanuHH1VB8z8auP/mIwH/Gimg
         /i8ClM3b499Bw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/2] arm64: efi: Avoid workqueue to check whether EFI runtime is live
Date:   Wed,  4 Jan 2023 18:44:32 +0100
Message-Id: <20230104174433.1259428-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104174433.1259428-1-ardb@kernel.org>
References: <20230104174433.1259428-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=ardb@kernel.org; h=from:subject; bh=RVLeuAkGJfKugExBOTAaGVn7MhDxBZ6OszcRfikiIro=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjtbr+QOODKPbw4hN1P+ENAtcWsFVB38vpvhOozwm/ jnXFxlOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY7W6/gAKCRDDTyI5ktmPJGadDA CVh1U+IQ/212TL9laa6eRsl6tdRloJ4Cn8L6yheLZWah7jbBqdN9VSBuEn3vXBvvIZrmuYjqXleS4u Cb8teqn+WP1TJEiTst3LBi0/LkZFpOnNAJ6IvIO3csHDFEBe3hZvDeaoWEb/ytSNU9p5yGB1ER6NJP +YuiHav8vipnmORCTJeqcylHOM6lim4f0W3Yx1MZVeBz8/b6aHdxz1lXXWEcCb5WSr9OT6MDm2eghK JEjr30IgY5q3RMT1JDXSo+Ki5QbL7mLwf+szutC0wvg0PdpUjr0bAyjP4tkI7NtVnD5bsqRfnCCbgy PgJi4eaME6N25fUMu/WNU/L+h8XMm+G8Cu1whWWPiSbGqIeFj2/z86GgG8c/ZrDF7/xJl6A1sSwH5n /bPNWM/1M3dmwlrotUFJuY2riwI2rtbEpvSjUxUm/m9EPj5kGcrTBQ7emKVVU7rdQtcS3J4WWSLyYT GVNFsFguURec36NLAnENB1dpNCQzGMNuxmqX7Lw1YLhbI=
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

So instead, let's check whether the spinlock is locked, and whether the
stashed value of the thread stack pointer points into current's thread
stack. This can only be the case if current was interrupted while
running EFI runtime code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h | 10 ++++++++++
 arch/arm64/kernel/efi.c      |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 31d13a6001df49c4..aca6dcaa33efbac4 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -42,14 +42,24 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
+	efi_rt_stack_top[-1] = 0;					\
 	spin_unlock(&efi_rt_lock);					\
 	__efi_fpsimd_end();						\
 	efi_virtmap_unload();						\
 })
 
 extern spinlock_t efi_rt_lock;
+extern u64 *efi_rt_stack_top;
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
+/*
+ * efi_rt_stack_top[-1] contains the value the stack pointer had before
+ * switching to the EFI runtime stack.
+ */
+#define current_in_efi()						\
+	(!preemptible() && spin_is_locked(&efi_rt_lock) &&		\
+	 on_task_stack(current, efi_rt_stack_top[-1], 1))
+
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
 /*
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

