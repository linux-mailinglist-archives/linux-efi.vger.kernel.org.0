Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16BA67BA04
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 19:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjAYS70 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 13:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbjAYS7Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 13:59:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C21460AF
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 10:59:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36BB6B81B8C
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 18:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C974C433EF;
        Wed, 25 Jan 2023 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674673158;
        bh=ueFC/V+pxLmu68eahKpJMmP6ds3ut2jQwyCQb0jUMtM=;
        h=From:To:Cc:Subject:Date:From;
        b=a3Z2h/AXEe8HtWhHyTb4UH95jXqaLrkhzO0b0F9ICpFUWdVeD2PsNxxG0TdPGkeb/
         rgRPNZrbrXBToMezIbkMKvIFIJJoZKQuiJ2KD/27Hm3Y1L8alPT77JkNYz60ycmEz4
         SAsDp5dn1C1yl3Hz6Qr5t8OObjQyL3w2YQnbH6dj4cjaCMtigf5ideeOJ4stfWjilE
         mx+eLpAp0cA/9vnc+DyLky9RFW3zSWdfbJsHi9tzOPgvi7wZs5Mf2H+OYH1QqDnSCw
         J9i99Rqp1KlzW2fxY3ISwxLjZg09cCJ9bSZcnLt2Ls4aE/bCSWSQRIJbi6HkHzuU+5
         sh7hJiDF/rosQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] arm64: head: Switch endianness before populating the ID map
Date:   Wed, 25 Jan 2023 19:59:10 +0100
Message-Id: <20230125185910.962733-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; i=ardb@kernel.org; h=from:subject; bh=ueFC/V+pxLmu68eahKpJMmP6ds3ut2jQwyCQb0jUMtM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj0Xv9y03eRpbdlGKDuh1KexiL35wbvGsplVtC+Gft niTyBYaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY9F7/QAKCRDDTyI5ktmPJPAMC/ 45FDwZcli+aPoeETAb/fGmcCXiTS7dPjRYog5slkMFEeHS5PqiGm0Vl5Y4KjR49BK+L1Ib/4NQ7y1q 6uBsPvkdb4qDVMivpqsNV03vkLAjAeednFGO1VFERFuK6Gf323IUWhIjGkUwSIO30255MQx66Hz0/c sEys/vBqAa4NJVkoS63HFNswWQ7L51FGdgf2T9dizQcKS9Pct5NEAqtfT/fYvZ0VTCloGfPgOzZMWa mG/2sCjUEX16QVS7JBbYuMLVIxf47HxfyAbOpWRc8ExZfsmCoy11f5sRz07u30G1mV4y6G92+W0sCr CW2BvlYob4QDrk+BstsjFmUdjGlgfbn+5mEKEHpjHAPngEzhFPnRIUk2+Gsy9MqSvZC68/iatILQ5X EydxeZrwbc3Um4zT6l00Fx6WgruDE3WllCZ9N+XZ7ixM8ZEtndaH06du36E8TS/x1M/ZVI/Uv3l3SX GDLQAyArpU74HiJ5J+9fmx6LpubOKhXo5JTcJZnNTs0+s=
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

Ensure that the endianness used for populating the ID map matches the
endianness that the running kernel will be using, as this is no longer
guaranteed now that create_idmap() is invoked before init_kernel_el().

Note that doing so is only safe if the MMU is off, as switching the
endianness with the MMU on results in the active ID map to become
invalid. So also clear the C and M bits when toggling the EE bit in
SCTLR, and mark the MMU as disabled at boot.

Note that the same issue has resulted in preserve_boot_args() recording
the contents of registers X0 ... X3 in the wrong byte order, although
this is arguably a very minor concern.

Fixes: 32b135a7fafe ("arm64: head: avoid cache invalidation when entering with the MMU on")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/sysreg.h |  3 ++-
 arch/arm64/kernel/head.S        | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1312fb48f18b5a51..2facd7933948677a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -575,6 +575,7 @@
 #define SCTLR_ELx_DSSBS	(BIT(44))
 #define SCTLR_ELx_ATA	(BIT(43))
 
+#define SCTLR_ELx_EE_SHIFT	25
 #define SCTLR_ELx_ENIA_SHIFT	31
 
 #define SCTLR_ELx_ITFSB	 (BIT(37))
@@ -583,7 +584,7 @@
 #define SCTLR_ELx_LSMAOE (BIT(29))
 #define SCTLR_ELx_nTLSMD (BIT(28))
 #define SCTLR_ELx_ENDA	 (BIT(27))
-#define SCTLR_ELx_EE     (BIT(25))
+#define SCTLR_ELx_EE     (BIT(SCTLR_ELx_EE_SHIFT))
 #define SCTLR_ELx_EIS	 (BIT(22))
 #define SCTLR_ELx_IESB	 (BIT(21))
 #define SCTLR_ELx_TSCXT	 (BIT(20))
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index dc56e1d8f36eb387..107a2b87577c9b0e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -129,10 +129,31 @@ SYM_CODE_START_LOCAL(record_mmu_state)
 	mrs	x19, sctlr_el1
 	b.ne	0f
 	mrs	x19, sctlr_el2
-0:	tst	x19, #SCTLR_ELx_C		// Z := (C == 0)
+0:
+CPU_LE( tbnz	x19, #SCTLR_ELx_EE_SHIFT, 1f	)
+CPU_BE( tbz	x19, #SCTLR_ELx_EE_SHIFT, 1f	)
+	tst	x19, #SCTLR_ELx_C		// Z := (C == 0)
 	and	x19, x19, #SCTLR_ELx_M		// isolate M bit
 	csel	x19, xzr, x19, eq		// clear x19 if Z
 	ret
+
+	/*
+	 * Set the correct endianness early so all memory accesses issued
+	 * before init_kernel_el() occur in the correct byte order. Note that
+	 * this means the MMU must be disabled, or the active ID map will end
+	 * up getting interpreted with the wrong byte order.
+	 */
+1:	eor	x19, x19, #SCTLR_ELx_EE
+	bic	x19, x19, #SCTLR_ELx_M
+	b.ne	2f
+	pre_disable_mmu_workaround
+	msr	sctlr_el2, x19
+	b	3f
+	pre_disable_mmu_workaround
+2:	msr	sctlr_el1, x19
+3:	isb
+	mov	x19, xzr
+	ret
 SYM_CODE_END(record_mmu_state)
 
 /*
-- 
2.39.0

