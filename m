Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D068BD48
	for <lists+linux-efi@lfdr.de>; Mon,  6 Feb 2023 13:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBFMt5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Feb 2023 07:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBFMt4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Feb 2023 07:49:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0205611161
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 04:49:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA68B81011
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 12:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAE7C4339B;
        Mon,  6 Feb 2023 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675687792;
        bh=IAL+pyfoXhXmgoxqxIVL+RHhIgd+a/xg78zxfOh6js8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHgObYG1983YEkn2WpX9MLJNsVgoBr1huXTcgOb60NyNNZPeagzOi+fToiYBobdf5
         QB0U9VOdFZ7kzP9uzUkbgwnwbr5lV7Z9wADlMrPtS+SxI5oryykriXACt1y/r7P3XR
         MqiwRd4YHxcLWlchfagdlgqKxbtCvbkN1RIl1t0EwYKjeVjD+ReY08w7sgpDDqLg4c
         AXExiANxIVV1sC/VVIACWbilcdrsallfgqxw53yh3nn0lWlnHGi40KK3T2YupUxQyV
         eXVr9fyAMzK3VcV+v14qVk9kpxlExFmU7Qobl0Q+esjmZGgdt0vhKr+rgRVMpJpIN3
         N1rT5/QFAWz+A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 2/3] efi: arm64: Wire up BTI annotation in memory attributes table
Date:   Mon,  6 Feb 2023 13:49:37 +0100
Message-Id: <20230206124938.272988-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206124938.272988-1-ardb@kernel.org>
References: <20230206124938.272988-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=ardb@kernel.org; h=from:subject; bh=IAL+pyfoXhXmgoxqxIVL+RHhIgd+a/xg78zxfOh6js8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj4PdgBcM69q4ZgV9oBMnKOIQvX9UQ3M+1JdiBQ BJDjWLmv5WJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+D3YAAKCRDDTyI5ktmP JEKAC/wLQYTaKY56agma250TeBbtIzcObQl0Lz5neU2J38P/NY9AQ/dMKjxx29L44HQdBRT5hpJ inmju3b/pFpSxXE1AwEUcGOpkOq5Jdgfq+CWuMPZUqh2XGQyht8HgqliKgs76vVqyoCFpBUmMq5 KmZi5H0pOaAT8beaTCXTaXEBKHVMVhtKHH2Z/30YPBHfr/lJl5ViF1xKkRNh5tG9iCd3HSis8Rw ohFwcLSZS2wHB71j4CMQlHabse+6z3Q5R86uHQ+vETM+XYN8+bSbEqGxDqvMzNx+8HvUAmZIkZx 3og5mQDIvz6eXxx772p6+Mc/KZx6kY2cbqwyp8eXI5UfJOirebyyib51va3vlrVaWqlA6k/+Vmr IQs3UyzmYDPP0b3vkBPyb0eUStPjbemQtE0wjXx452uN7NM06zj5c/9F7zuzCuC4u8f3bgK9FBw R5pie/mKThyv6dN6kc60HJ8T0t0SU7G8YZWKbv27Ell5xczOICcmjqJmRyLm569rfwYNc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI v2.10 extends the EFI memory attributes table with a flag that
indicates whether or not all RuntimeServicesCode regions were
constructed with BTI landing pads, permitting the OS to map these
regions with BTI restrictions enabled.

So let's take this into account on arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/efi.c   | 14 ++++++++++++--
 arch/arm64/kernel/traps.c |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 78ffd5aaddcbbaee..99971cd349f36310 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -96,15 +96,23 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 	return 0;
 }
 
+struct set_perm_data {
+	const efi_memory_desc_t	*md;
+	bool			has_bti;
+};
+
 static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
-	efi_memory_desc_t *md = data;
+	struct set_perm_data *spd = data;
+	const efi_memory_desc_t *md = spd->md;
 	pte_t pte = READ_ONCE(*ptep);
 
 	if (md->attribute & EFI_MEMORY_RO)
 		pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
 	if (md->attribute & EFI_MEMORY_XP)
 		pte = set_pte_bit(pte, __pgprot(PTE_PXN));
+	else if (system_supports_bti() && spd->has_bti)
+		pte = set_pte_bit(pte, __pgprot(PTE_GP));
 	set_pte(ptep, pte);
 	return 0;
 }
@@ -113,6 +121,8 @@ int __init efi_set_mapping_permissions(struct mm_struct *mm,
 				       efi_memory_desc_t *md,
 				       bool has_bti)
 {
+	struct set_perm_data data = { md, has_bti };
+
 	BUG_ON(md->type != EFI_RUNTIME_SERVICES_CODE &&
 	       md->type != EFI_RUNTIME_SERVICES_DATA);
 
@@ -128,7 +138,7 @@ int __init efi_set_mapping_permissions(struct mm_struct *mm,
 	 */
 	return apply_to_page_range(mm, md->virt_addr,
 				   md->num_pages << EFI_PAGE_SHIFT,
-				   set_permissions, md);
+				   set_permissions, &data);
 }
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4c0caa589e12de2a..1f366b94ea8e233a 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
@@ -33,6 +34,7 @@
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
+#include <asm/efi.h>
 #include <asm/esr.h>
 #include <asm/exception.h>
 #include <asm/extable.h>
@@ -492,6 +494,10 @@ void do_el0_bti(struct pt_regs *regs)
 
 void do_el1_bti(struct pt_regs *regs, unsigned long esr)
 {
+	if (efi_runtime_fixup_exception(regs, "BTI violation")) {
+		regs->pstate &= ~PSR_BTYPE_MASK;
+		return;
+	}
 	die("Oops - BTI", regs, esr);
 }
 
-- 
2.39.1

