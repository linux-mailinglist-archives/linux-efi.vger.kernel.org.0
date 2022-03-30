Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8D4EC89E
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348356AbiC3PoX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348358AbiC3PoU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1785834644
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E1276171D
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0731C34110;
        Wed, 30 Mar 2022 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654953;
        bh=xZEdYTbXCe7JfKTWqI5SD0j4aITkdy54wHudB8ZRqoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqPjDKiVvC/q9jrWWAragOI3tdS90fir5S014dwlWqlG8VJABNRI8KL5fy+nn0hgx
         MCoNH2IptPoLXDlkB77oplr7NUMOwD7IWH+yQsh95AzuXF1Q0K/PeTRg5N3wfqa99e
         +/jUx6ru7pWrJmEQjP6v4rE9bo0ICaGmykeUx/peBy24gyeoTYntpv2scMDbIV4Gq0
         M4sykywYpAY7RNd4TnrhRpT+/t4OPb3pUmxsHSX0rx33bOk/QcYtqlR4r78QRk2Bdj
         j/v68AWVsQUzgE71dib7O6lqYWV9me0DLFWbUSAYkYzagH2f+kcXF6FG98GXGXuNcu
         UwhG0bthgd9hA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 11/18] arm64: mm: make vabits_actual a build time constant if possible
Date:   Wed, 30 Mar 2022 17:41:58 +0200
Message-Id: <20220330154205.2483167-12-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; h=from:subject; bh=xZEdYTbXCe7JfKTWqI5SD0j4aITkdy54wHudB8ZRqoQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpA9D1NAzcsAwAeK2EcEXC9/Ejp2XtNMHroPqRu zaDYGsOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6QAAKCRDDTyI5ktmPJLi2C/ 4gIjV/TkGE0WFbGB/dko/5oilOKU7Tau+yxXGclk607mrcLQnhsBsZNWwFdxuuW4KUxteHZgV52X63 jdANoEcM/L+WjuwgRE9nzG3FACaDU7waFNAVLTrUcoYfGX8AikV4xymSJtuEjZTlqtgECQSbsbgL2o cJhx1J9xXY/IYAGm48rdUi+9uA7RX0DExKJHOOoT0VsHzO0VDmwd0VXcJpK61N13cQuAjZqc+x3UMy IXw7rmqmRwIV+sbDiL1aRnmMhFnDOh8+MhIHxh/2ohPh652V5OLLkhkZfDiUr55cOWIODlCFtQ+5cN uxkYc++qqsCduZvSEP2T61AeM6GNbSFJOpFiy3wYZWvNuPBZ+W5UVTizskngjA3KyBiQpnEKbkYr/c GnDYoiiyeCT9/nCivettCvAQMIvWL+MIJ/LvIn6ICxtXKqBlvNMzoJDVptjMOxH7122YyaW6nbPxgU /Kd6r+KpQ4oNKtSuxnC6pi1CAyG1As7pcwZ9lRaO9mdrg=
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

Currently, we only support 52-bit virtual addressing on 64k pages
configurations, and in all other cases, vabits_actual is guaranteed to
equal VA_BITS (== VA_BITS_MIN). So get rid of the variable entirely in
that case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h | 4 ++++
 arch/arm64/kernel/head.S        | 7 +++----
 arch/arm64/mm/mmu.c             | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 2f1a48be11cf..c989f6bf5426 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -174,7 +174,11 @@
 #include <linux/types.h>
 #include <asm/bug.h>
 
+#if VA_BITS > 48
 extern u64			vabits_actual;
+#else
+#define vabits_actual		VA_BITS
+#endif
 
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 44e2e39046a9..836237289ffb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -283,19 +283,18 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x0, idmap_pg_dir
 	adrp	x3, _text			// __pa(_text)
 
-#ifdef CONFIG_ARM64_VA_BITS_52
+#if (VA_BITS > 48)
 	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
 	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
 	mov	x5, #52
 	cbnz	x6, 1f
-#endif
 	mov	x5, #VA_BITS_MIN
 1:
 	adr_l	x6, vabits_actual
 	str	x5, [x6]
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
-
+#endif
 	/*
 	 * VA_BITS may be too small to allow for an ID mapping to be created
 	 * that covers system RAM if that is located sufficiently high in the
@@ -725,7 +724,7 @@ SYM_FUNC_START(__enable_mmu)
 SYM_FUNC_END(__enable_mmu)
 
 SYM_FUNC_START(__cpu_secondary_check52bitva)
-#ifdef CONFIG_ARM64_VA_BITS_52
+#if (VA_BITS > 48)
 	ldr_l	x0, vabits_actual
 	cmp	x0, #52
 	b.ne	2f
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 20dd95a750bc..8933d4f72427 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,8 +45,10 @@
 
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
 
+#if (VA_BITS > 48)
 u64 __section(".mmuoff.data.write") vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
+#endif
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
-- 
2.30.2

