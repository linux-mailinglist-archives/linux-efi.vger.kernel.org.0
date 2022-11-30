Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728E63E3C8
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 23:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiK3W44 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 17:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiK3W4s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 17:56:48 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9892A0A
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 14:56:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0W0J-0005PW-NA; Wed, 30 Nov 2022 23:56:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, heiko@sntech.de,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 03/14] RISC-V: detach funct-values from their offset
Date:   Wed, 30 Nov 2022 23:56:03 +0100
Message-Id: <20221130225614.1594256-4-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130225614.1594256-1-heiko@sntech.de>
References: <20221130225614.1594256-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Rather than defining funct3, funct4, etc values pre-shifted to their
target-position in an instruction, define the values themselves and
only shift them where needed.

This allows using these funct-values in other places as well, for example
when decoding functions.

At the same time also reduces the use of magic numbers, one would need
a spec manual to understand.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/parse_asm.h | 100 +++++++++++++++++------------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
index ea51542e0c65..e3f87da108f4 100644
--- a/arch/riscv/include/asm/parse_asm.h
+++ b/arch/riscv/include/asm/parse_asm.h
@@ -5,6 +5,15 @@
 
 #include <linux/bits.h>
 
+#define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
+#define RV_INSN_FUNCT3_OPOFF	12
+#define RV_INSN_OPCODE_MASK	GENMASK(6, 0)
+#define RV_INSN_OPCODE_OPOFF	0
+#define RV_INSN_FUNCT12_OPOFF	20
+
+#define RV_ENCODE_FUNCT3(f_)	(RVG_FUNCT3_##f_ << RV_INSN_FUNCT3_OPOFF)
+#define RV_ENCODE_FUNCT12(f_)	(RVG_FUNCT12_##f_ << RV_INSN_FUNCT12_OPOFF)
+
 /* The bit field of immediate value in I-type instruction */
 #define RV_I_IMM_SIGN_OPOFF	31
 #define RV_I_IMM_11_0_OPOFF	20
@@ -84,6 +93,15 @@
 #define RVC_B_IMM_2_1_MASK	GENMASK(1, 0)
 #define RVC_B_IMM_5_MASK	GENMASK(0, 0)
 
+#define RVC_INSN_FUNCT4_MASK	GENMASK(15, 12)
+#define RVC_INSN_FUNCT4_OPOFF	12
+#define RVC_INSN_FUNCT3_MASK	GENMASK(15, 13)
+#define RVC_INSN_FUNCT3_OPOFF	13
+#define RVC_INSN_J_RS2_MASK	GENMASK(6, 2)
+#define RVC_INSN_OPCODE_MASK	GENMASK(1, 0)
+#define RVC_ENCODE_FUNCT3(f_)	(RVC_FUNCT3_##f_ << RVC_INSN_FUNCT3_OPOFF)
+#define RVC_ENCODE_FUNCT4(f_)	(RVC_FUNCT4_##f_ << RVC_INSN_FUNCT4_OPOFF)
+
 /* The register offset in RVC op=C0 instruction */
 #define RVC_C0_RS1_OPOFF	7
 #define RVC_C0_RS2_OPOFF	2
@@ -113,52 +131,52 @@
 /* parts of funct3 code for I, M, A extension*/
 #define RVG_FUNCT3_JALR		0x0
 #define RVG_FUNCT3_BEQ		0x0
-#define RVG_FUNCT3_BNE		0x1000
-#define RVG_FUNCT3_BLT		0x4000
-#define RVG_FUNCT3_BGE		0x5000
-#define RVG_FUNCT3_BLTU		0x6000
-#define RVG_FUNCT3_BGEU		0x7000
+#define RVG_FUNCT3_BNE		0x1
+#define RVG_FUNCT3_BLT		0x4
+#define RVG_FUNCT3_BGE		0x5
+#define RVG_FUNCT3_BLTU		0x6
+#define RVG_FUNCT3_BGEU		0x7
 
 /* parts of funct3 code for C extension*/
-#define RVC_FUNCT3_C_BEQZ	0xc000
-#define RVC_FUNCT3_C_BNEZ	0xe000
-#define RVC_FUNCT3_C_J		0xa000
-#define RVC_FUNCT3_C_JAL	0x2000
-#define RVC_FUNCT4_C_JR		0x8000
-#define RVC_FUNCT4_C_JALR	0x9000
+#define RVC_FUNCT3_C_BEQZ	0x6
+#define RVC_FUNCT3_C_BNEZ	0x7
+#define RVC_FUNCT3_C_J		0x5
+#define RVC_FUNCT3_C_JAL	0x1
+#define RVC_FUNCT4_C_JR		0x8
+#define RVC_FUNCT4_C_JALR	0x9
 
-#define RVG_FUNCT12_SRET	0x10200000
+#define RVG_FUNCT12_SRET	0x102
 
-#define RVG_MATCH_JALR		(RVG_FUNCT3_JALR | RVG_OPCODE_JALR)
+#define RVG_MATCH_JALR		(RV_ENCODE_FUNCT3(JALR) | RVG_OPCODE_JALR)
 #define RVG_MATCH_JAL		(RVG_OPCODE_JAL)
-#define RVG_MATCH_BEQ		(RVG_FUNCT3_BEQ | RVG_OPCODE_BRANCH)
-#define RVG_MATCH_BNE		(RVG_FUNCT3_BNE | RVG_OPCODE_BRANCH)
-#define RVG_MATCH_BLT		(RVG_FUNCT3_BLT | RVG_OPCODE_BRANCH)
-#define RVG_MATCH_BGE		(RVG_FUNCT3_BGE | RVG_OPCODE_BRANCH)
-#define RVG_MATCH_BLTU		(RVG_FUNCT3_BLTU | RVG_OPCODE_BRANCH)
-#define RVG_MATCH_BGEU		(RVG_FUNCT3_BGEU | RVG_OPCODE_BRANCH)
-#define RVG_MATCH_SRET		(RVG_FUNCT12_SRET | RVG_OPCODE_SYSTEM)
-#define RVC_MATCH_C_BEQZ	(RVC_FUNCT3_C_BEQZ | RVC_OPCODE_C1)
-#define RVC_MATCH_C_BNEZ	(RVC_FUNCT3_C_BNEZ | RVC_OPCODE_C1)
-#define RVC_MATCH_C_J		(RVC_FUNCT3_C_J | RVC_OPCODE_C1)
-#define RVC_MATCH_C_JAL		(RVC_FUNCT3_C_JAL | RVC_OPCODE_C1)
-#define RVC_MATCH_C_JR		(RVC_FUNCT4_C_JR | RVC_OPCODE_C2)
-#define RVC_MATCH_C_JALR	(RVC_FUNCT4_C_JALR | RVC_OPCODE_C2)
-
-#define RVG_MASK_JALR		0x707f
-#define RVG_MASK_JAL		0x7f
-#define RVC_MASK_C_JALR		0xf07f
-#define RVC_MASK_C_JR		0xf07f
-#define RVC_MASK_C_JAL		0xe003
-#define RVC_MASK_C_J		0xe003
-#define RVG_MASK_BEQ		0x707f
-#define RVG_MASK_BNE		0x707f
-#define RVG_MASK_BLT		0x707f
-#define RVG_MASK_BGE		0x707f
-#define RVG_MASK_BLTU		0x707f
-#define RVG_MASK_BGEU		0x707f
-#define RVC_MASK_C_BEQZ		0xe003
-#define RVC_MASK_C_BNEZ		0xe003
+#define RVG_MATCH_BEQ		(RV_ENCODE_FUNCT3(BEQ) | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BNE		(RV_ENCODE_FUNCT3(BNE) | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BLT		(RV_ENCODE_FUNCT3(BLT) | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BGE		(RV_ENCODE_FUNCT3(BGE) | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BLTU		(RV_ENCODE_FUNCT3(BLTU) | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BGEU		(RV_ENCODE_FUNCT3(BGEU) | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_SRET		(RV_ENCODE_FUNCT12(SRET) | RVG_OPCODE_SYSTEM)
+#define RVC_MATCH_C_BEQZ	(RVC_ENCODE_FUNCT3(C_BEQZ) | RVC_OPCODE_C1)
+#define RVC_MATCH_C_BNEZ	(RVC_ENCODE_FUNCT3(C_BNEZ) | RVC_OPCODE_C1)
+#define RVC_MATCH_C_J		(RVC_ENCODE_FUNCT3(C_J) | RVC_OPCODE_C1)
+#define RVC_MATCH_C_JAL		(RVC_ENCODE_FUNCT3(C_JAL) | RVC_OPCODE_C1)
+#define RVC_MATCH_C_JR		(RVC_ENCODE_FUNCT4(C_JR) | RVC_OPCODE_C2)
+#define RVC_MATCH_C_JALR	(RVC_ENCODE_FUNCT4(C_JALR) | RVC_OPCODE_C2)
+
+#define RVG_MASK_JALR		(RV_INSN_FUNCT3_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_JAL		(RV_INSN_OPCODE_MASK)
+#define RVC_MASK_C_JALR		(RVC_INSN_FUNCT4_MASK | RVC_INSN_J_RS2_MASK | RVC_INSN_OPCODE_MASK)
+#define RVC_MASK_C_JR		(RVC_INSN_FUNCT4_MASK | RVC_INSN_J_RS2_MASK | RVC_INSN_OPCODE_MASK)
+#define RVC_MASK_C_JAL		(RVC_INSN_FUNCT3_MASK | RVC_INSN_OPCODE_MASK)
+#define RVC_MASK_C_J		(RVC_INSN_FUNCT3_MASK | RVC_INSN_OPCODE_MASK)
+#define RVG_MASK_BEQ		(RV_INSN_FUNCT3_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_BNE		(RV_INSN_FUNCT3_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_BLT		(RV_INSN_FUNCT3_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_BGE		(RV_INSN_FUNCT3_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_BLTU		(RV_INSN_FUNCT3_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_BGEU		(RV_INSN_FUNCT3_MASK | RV_INSN_OPCODE_MASK)
+#define RVC_MASK_C_BEQZ		(RVC_INSN_FUNCT3_MASK | RVC_INSN_OPCODE_MASK)
+#define RVC_MASK_C_BNEZ		(RVC_INSN_FUNCT3_MASK | RVC_INSN_OPCODE_MASK)
 #define RVG_MASK_SRET		0xffffffff
 
 #define __INSN_LENGTH_MASK	_UL(0x3)
-- 
2.35.1

