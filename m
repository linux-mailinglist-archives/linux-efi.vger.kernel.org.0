Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2606029D0
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJRLFG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJRLFB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF1027B23
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCEB0614AB
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751DBC4347C;
        Tue, 18 Oct 2022 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666091095;
        bh=l+Ib5JlcWADbO+SzTyZ0TnTZ/81bpJ2Jk1D2qiqFglo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQ/jw6CZYv+s+QnYSrhQoA0DNCqJ+AaP/d14+Sxt1WAvkjSRU5JyJkWG0XylcPDw4
         Qk6chAYst49OVVV5kTHeuoWGi8gqjZUE15E/5gqeOPZGB54BWo71XffMxJSBUAo2bJ
         1rW05umb8xy5VEM2GYEcrmOIbltThOgFWbJ0SUqU44VFzTIRpr1mhWGHi/pC638wN0
         19UNMewgHfAMyR9ysROLAL1P+a7cKcqpN5RMYXFO034NP7AIQ/iAiOe3tgzUcLjpet
         86D/qJS5IoR/U8N2WzxWJLrEhx2+ag1HWW5wQ9opAiRutLK2PCsHYbXJ6eOfE9lb56
         1WlWpBYcEiKIQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 2/6] arm64: kernel: move identity map out of .text mapping
Date:   Tue, 18 Oct 2022 13:04:37 +0200
Message-Id: <20221018110441.3855148-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018110441.3855148-1-ardb@kernel.org>
References: <20221018110441.3855148-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3452; i=ardb@kernel.org; h=from:subject; bh=l+Ib5JlcWADbO+SzTyZ0TnTZ/81bpJ2Jk1D2qiqFglo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTohCAxt1u0J8PSJyJC+4Lo0AnHH1KMjtFWBjsIF5 fS3LieCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY06IQgAKCRDDTyI5ktmPJDF4DA CP/5Lod03+XvYrymRfDaR+IKb3ht94JXA3lDWb9aiVZYRaOd3RAyw22ezpOGsZxNKWcgqavJ0MRxb1 h8u+YuqRL3eIE+h6IVWf+lZpEOtH2GUIYC0uDw12P7EQKP/tp45oNFDPXhvd3ynAkeg3Z9lKGTKvxJ WhOqSKiTjE1PkHvA7vJmJOT292assjIZtJMLA2uMnQ48iW8Amunhaq14M24JXqwfpiyGTDTftmi7KQ x3dkPa4nMWbvA+c5jAyp1RI1CfFz5nL1PObg8mFuDCr9LzwgTRtRKYTpiBSqhlIjkyRLLNLWH4rtZf T5BiYvpTSR1hF9sID5FA+KtWocxK3PV42rkOiVRWLsNL93iYysp0BHD6Rfye07rwnTL54HYsGl3ilc NT8D6POJOxSVHCkE1PpDHa6unuJ1hr42KGBCZ+NtDlSS+CF8lYR6K+/YnFkrdlvjaHICeOUOSZmFKq Az2g02DRPKN8Lr1LpQFmGtBQ0OI/d3VK02mNkZTl+qpws=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reorganize the ID map slightly so that only code that is executed with
the MMU off or via the 1:1 mapping remains. This allows us to move the
identity map out of the .text segment, as it will no longer need
executable permissions via the kernel mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 28 +++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 arch/arm64/mm/proc.S            |  2 --
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index f168e3309704..25a84ce1700c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -543,19 +543,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	eret
 SYM_FUNC_END(init_kernel_el)
 
-/*
- * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
- * in w0. See arch/arm64/include/asm/virt.h for more info.
- */
-SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
-	adr_l	x1, __boot_cpu_mode
-	cmp	w0, #BOOT_CPU_MODE_EL2
-	b.ne	1f
-	add	x1, x1, #4
-1:	str	w0, [x1]			// Save CPU boot mode
-	ret
-SYM_FUNC_END(set_cpu_boot_mode_flag)
-
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
@@ -600,6 +587,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	br	x8
 SYM_FUNC_END(secondary_startup)
 
+	.text
 SYM_FUNC_START_LOCAL(__secondary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
@@ -628,6 +616,19 @@ SYM_FUNC_START_LOCAL(__secondary_too_slow)
 	b	__secondary_too_slow
 SYM_FUNC_END(__secondary_too_slow)
 
+/*
+ * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
+ * in w0. See arch/arm64/include/asm/virt.h for more info.
+ */
+SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
+	adr_l	x1, __boot_cpu_mode
+	cmp	w0, #BOOT_CPU_MODE_EL2
+	b.ne	1f
+	add	x1, x1, #4
+1:	str	w0, [x1]			// Save CPU boot mode
+	ret
+SYM_FUNC_END(set_cpu_boot_mode_flag)
+
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
  * with MMU turned off.
@@ -659,6 +660,7 @@ SYM_FUNC_END(__secondary_too_slow)
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
  */
+	.section ".idmap.text","awx"
 SYM_FUNC_START(__enable_mmu)
 	mrs	x3, ID_AA64MMFR0_EL1
 	ubfx	x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0efccdf52be2..5002d869fa7f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -168,7 +168,6 @@ SECTIONS
 			LOCK_TEXT
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
-			IDMAP_TEXT
 			*(.gnu.warning)
 		. = ALIGN(16);
 		*(.got)			/* Global offset table		*/
@@ -195,6 +194,7 @@ SECTIONS
 		TRAMP_TEXT
 		HIBERNATE_TEXT
 		KEXEC_TEXT
+		IDMAP_TEXT
 		. = ALIGN(PAGE_SIZE);
 	}
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b9ecbbae1e1a..d7ca6f23fb0d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -110,7 +110,6 @@ SYM_FUNC_END(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "awx"
 SYM_FUNC_START(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -166,7 +165,6 @@ alternative_else_nop_endif
 	isb
 	ret
 SYM_FUNC_END(cpu_do_resume)
-	.popsection
 #endif
 
 	.pushsection ".idmap.text", "awx"
-- 
2.35.1

