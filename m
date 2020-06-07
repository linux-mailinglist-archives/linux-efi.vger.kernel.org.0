Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351EC1F0B8E
	for <lists+linux-efi@lfdr.de>; Sun,  7 Jun 2020 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgFGN6t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Jun 2020 09:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgFGN6s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 7 Jun 2020 09:58:48 -0400
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC85D20723;
        Sun,  7 Jun 2020 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591538327;
        bh=1uYwfpxT3Azd8kSnfp0VKbMgutEcoJC6q+mEDBLy3z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfyFy5RSNdiFfuihy406Sh1Ua7anaiS6zFDyWwaTdzrhWrf/qgrnpgRkPyuazIYl/
         fz2mtligGgZdbbUlOaaPpzlF2OG67ChZhd+eSH8WDZVya9Z6VGyKAK0jWQ+J8GrXJE
         P2jPyQ8dKWSXNlSEW6zuSSmFOXylEYn0AgrAYO9o=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux@armlinux.org.uk, xypron.glpk@gmx.de,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot gracefully
Date:   Sun,  7 Jun 2020 15:58:33 +0200
Message-Id: <20200607135834.898294-2-ardb@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607135834.898294-1-ardb@kernel.org>
References: <20200607135834.898294-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI on ARM only supports short descriptors, and given that it mandates
that the MMU and caches are on, it is implied that booting in HYP mode
is not supported.

However, implementations of EFI exist (i.e., U-Boot) that ignore this
requirement, which is not entirely unreasonable, given that it makes
HYP mode inaccessible to the operating system.

So let's make sure that we can deal with this condition gracefully.
We already tolerate booting the EFI stub with the caches off (even
though this violates the EFI spec as well), and so we should deal
with HYP mode boot with MMU and caches either on or off.

- When the MMU and caches are on, we can ignore the HYP stub altogether,
  since we can carry on executing at HYP. We do need to ensure that we
  disable the MMU at HYP before entering the kernel proper.

- When the MMU and caches are off, we have to drop to SVC mode so that
  we can set up the page tables using short descriptors. In this case,
  we need to install the HYP stub as usual, so that we can return to HYP
  mode before handing over to the kernel proper.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index c79db44ba128..3476e85c31e7 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1410,7 +1410,11 @@ memdump:	mov	r12, r0
 __hyp_reentry_vectors:
 		W(b)	.			@ reset
 		W(b)	.			@ undef
+#ifdef CONFIG_EFI_STUB
+		W(b)	__enter_kernel_from_hyp	@ hvc from HYP
+#else
 		W(b)	.			@ svc
+#endif
 		W(b)	.			@ pabort
 		W(b)	.			@ dabort
 		W(b)	__enter_kernel		@ hyp
@@ -1429,14 +1433,71 @@ __enter_kernel:
 reloc_code_end:
 
 #ifdef CONFIG_EFI_STUB
+__enter_kernel_from_hyp:
+		mrc	p15, 4, r0, c1, c0, 0	@ read HSCTLR
+		bic	r0, r0, #0x5		@ disable MMU and caches
+		mcr	p15, 4, r0, c1, c0, 0	@ write HSCTLR
+		isb
+		b	__enter_kernel
+
 ENTRY(efi_enter_kernel)
 		mov	r4, r0			@ preserve image base
 		mov	r8, r1			@ preserve DT pointer
 
+ ARM(		adrl	r0, call_cache_fn	)
+ THUMB(		adr	r0, call_cache_fn	)
+		adr	r1, 0f			@ clean the region of code we
+		bl	cache_clean_flush	@ may run with the MMU off
+
+#ifdef CONFIG_ARM_VIRT_EXT
+		@
+		@ The EFI spec does not support booting on ARM in HYP mode,
+		@ since it mandates that the MMU and caches are on, with all
+		@ 32-bit addressable DRAM mapped 1:1 using short descriptors.
+		@
+		@ While the EDK2 reference implementation adheres to this,
+		@ U-Boot might decide to enter the EFI stub in HYP mode
+		@ anyway, with the MMU and caches either on or off.
+		@
+		mrs	r0, cpsr		@ get the current mode
+		msr	spsr_cxsf, r0		@ record boot mode
+		and	r0, r0, #MODE_MASK	@ are we running in HYP mode?
+		cmp	r0, #HYP_MODE
+		bne	.Lefi_svc
+
+		mrc	p15, 4, r1, c1, c0, 0	@ read HSCTLR
+		tst	r1, #0x1		@ MMU enabled at HYP?
+		beq	1f
+
+		@
+		@ When running in HYP mode with the caches on, we're better
+		@ off just carrying on using the cached 1:1 mapping that the
+		@ firmware provided. Set up the HYP vectors so HVC instructions
+		@ issued from HYP mode take us to the correct handler code. We
+		@ will disable the MMU before jumping to the kernel proper.
+		@
+		adr	r0, __hyp_reentry_vectors
+		mcr	p15, 4, r0, c12, c0, 0	@ set HYP vector base (HVBAR)
+		isb
+		b	.Lefi_hyp
+
+		@
+		@ When running in HYP mode with the caches off, we need to drop
+		@ into SVC mode now, and let the decompressor set up its cached
+		@ 1:1 mapping as usual.
+		@
+1:		mov	r9, r4			@ preserve image base
+		bl	__hyp_stub_install	@ install HYP stub vectors
+		safe_svcmode_maskall	r1	@ drop to SVC mode
+		orr	r4, r9, #1		@ restore image base and set LSB
+		b	.Lefi_hyp
+.Lefi_svc:
+#endif
 		mrc	p15, 0, r0, c1, c0, 0	@ read SCTLR
 		tst	r0, #0x1		@ MMU enabled?
 		orreq	r4, r4, #1		@ set LSB if not
 
+.Lefi_hyp:
 		mov	r0, r8			@ DT start
 		add	r1, r8, r2		@ DT end
 		bl	cache_clean_flush
-- 
2.26.2

