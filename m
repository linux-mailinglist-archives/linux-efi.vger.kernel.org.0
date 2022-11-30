Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A763E3C4
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 23:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK3W4y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 17:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiK3W4s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 17:56:48 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37B94567
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 14:56:45 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0W0M-0005PW-FA; Wed, 30 Nov 2022 23:56:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, heiko@sntech.de,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 09/14] RISC-V: add U-type imm parsing to insn.h header
Date:   Wed, 30 Nov 2022 23:56:09 +0100
Message-Id: <20221130225614.1594256-10-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130225614.1594256-1-heiko@sntech.de>
References: <20221130225614.1594256-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Similar to other existing types, allow extracting the immediate
for a U-type instruction.

U-type immediates are special in that regard, that the value
in the instruction in bits [31:12] already represents the same
bits of the immediate, so no shifting is required.

U-type immediates are for example used in the auipc instruction,
so these constants make it easier to parse such instructions.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/insn.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 50c899cf4de5..21ec817abec1 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -34,6 +34,15 @@
 #define RV_J_IMM_11_MASK	GENMASK(0, 0)
 #define RV_J_IMM_19_12_MASK	GENMASK(7, 0)
 
+/*
+ * U-type IMMs contain the upper 20bits [31:20] of an immediate with
+ * the rest filled in by zeros, so no shifting required. Similarly,
+ * bit31 contains the signed state, so no sign extension necessary.
+ */
+#define RV_U_IMM_SIGN_OPOFF	31
+#define RV_U_IMM_31_12_OPOFF	0
+#define RV_U_IMM_31_12_MASK	GENMASK(31, 12)
+
 /* The bit field of immediate value in B-type instruction */
 #define RV_B_IMM_SIGN_OPOFF	31
 #define RV_B_IMM_10_5_OPOFF	25
@@ -235,6 +244,10 @@ static __always_inline bool riscv_insn_is_branch(u32 code)
 #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
 #define RVC_X(X, s, mask) RV_X(X, s, mask)
 
+#define RV_EXTRACT_UTYPE_IMM(x) \
+	({typeof(x) x_ = (x); \
+	(RV_X(x_, RV_U_IMM_31_12_OPOFF, RV_U_IMM_31_12_MASK)); })
+
 #define RV_EXTRACT_JTYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
 	(RV_X(x_, RV_J_IMM_10_1_OPOFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OFF) | \
-- 
2.35.1

