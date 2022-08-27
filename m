Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB22E5A3890
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiH0P7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH0P7K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81CF29CBD
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61A4AB8095C
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541A5C433C1;
        Sat, 27 Aug 2022 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615947;
        bh=EELVaB3ZR/jpo4zRd3Ymjq9znWczOd8+mFr1T7WKKt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LECZGd37FjsRjHykiiYP+EFHoP4NcJ6GJICN/vLo5GH256/NMgYVccbJjvPAc//g7
         LOX3TrJjdeUnyyJOVC9y4fKD3reZ4w7rSVNfeyQTiNbn2P+t8ctck7oNTEnBXbIzOs
         chIDobQdZAjYFaIJAiF/wp8hJujBIGHzpodndNlO6sRgyKFj+UthgyM1HAZ4PhLQPR
         Dqo6r34++KL6NoMeh0Dd1Kt4UL7O+x/pVm+F67ILd2tAZp5QBxr8etBn4R9GPRvMqt
         PcygDu/jjpSPj2rTFCqxw1Z0ZAKHepaxN0F7BMX+c5L2FvNzZUnIQf3miscXTYeXcE
         khc4jHGVqD6Xw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 2/7] arm64: kernel: move ID map out of .text mapping
Date:   Sat, 27 Aug 2022 17:58:47 +0200
Message-Id: <20220827155852.3338551-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827155852.3338551-1-ardb@kernel.org>
References: <20220827155852.3338551-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=ardb@kernel.org; h=from:subject; bh=EELVaB3ZR/jpo4zRd3Ymjq9znWczOd8+mFr1T7WKKt0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj8ykRuUlmyplpxxrhzH1nHa6o9t8ko1i1s9Uzgd Q2h+opOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/MgAKCRDDTyI5ktmPJP1DDA CaZSf8/Y4ae6WIzGW6lHxuxLH4RWWJkUfzMoxcY1HI3xxjvPSfqiIha4Z/nl5SmHFRBe/E8iyVJ8xk XnIHxjU9JX7QQoTLRCqhO5eNIa94/B+7NHmLnYM3XsWYIiUqamA34KFq1ugg9Dbkr4PHlleeHv8m55 4+mdRns6bExG73HTqJDTlnfSLpE3NYNj5oA5UE8sUmI3VC6+4llEBnG687pRGcfjQTgL21ODR3yMeO 3xZWvZIjV5S9toODsK0zl9G56OktFGJ4IBhPJeIUhTo3cN0Xs6RRbd50O6tD9c3RZeAatHIh2kKX86 Jg4FXX8a4UlAflLx+x5e7L3mAuwS4JSa+zAKiEypkUBHhTuarAGpbxlesHLwPJQVeK27ZXexw/kfd8 Iy9lANVx20ekLbsg0CilQ+SpyOV8yFEFxB92JryA9b/nXf9agUhKWKVCoPKmef7uiX+Xk1DDftCu/+ CCZn86rWOJ+Jj7C/rGN8GHnzeveb0tK+XAoytHnA4maV4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reorganize the ID map slightly so that only code that is executed via
the 1:1 mapping remains. This allows us to move the ID map out of the
.text segment, as it will no longer need executable permissions via the
kernel mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 5 ++++-
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 arch/arm64/mm/proc.S            | 2 --
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index bd7c04f1f993..cfc7ba25bf87 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -474,7 +474,7 @@ SYM_FUNC_END(__primary_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".idmap.text","awx"
+	.text
 
 /*
  * Starting from EL2 or EL1, configure the CPU to execute at the highest
@@ -554,6 +554,7 @@ SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
 	ret
 SYM_FUNC_END(set_cpu_boot_mode_flag)
 
+	.section ".idmap.text","awx"
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
@@ -598,6 +599,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	br	x8
 SYM_FUNC_END(secondary_startup)
 
+	.text
 SYM_FUNC_START_LOCAL(__secondary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
@@ -657,6 +659,7 @@ SYM_FUNC_END(__secondary_too_slow)
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
  */
+	.section ".idmap.text","awx"
 SYM_FUNC_START(__enable_mmu)
 	mrs	x3, ID_AA64MMFR0_EL1
 	ubfx	x3, x3, #ID_AA64MMFR0_TGRAN_SHIFT, 4
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
index 7837a69524c5..113a4fedf5b8 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -107,7 +107,6 @@ SYM_FUNC_END(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "awx"
 SYM_FUNC_START(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -163,7 +162,6 @@ alternative_else_nop_endif
 	isb
 	ret
 SYM_FUNC_END(cpu_do_resume)
-	.popsection
 #endif
 
 	.pushsection ".idmap.text", "awx"
-- 
2.35.1

