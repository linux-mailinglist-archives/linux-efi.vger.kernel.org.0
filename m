Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB763E3C3
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 23:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiK3W4y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 17:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiK3W4t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 17:56:49 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF392A0F
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 14:56:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0W0J-0005PW-7Y; Wed, 30 Nov 2022 23:56:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, heiko@sntech.de,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 02/14] RISC-V: add prefix to all constants/macros in parse_asm.h
Date:   Wed, 30 Nov 2022 23:56:02 +0100
Message-Id: <20221130225614.1594256-3-heiko@sntech.de>
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

Some of the constants and macros already have suitable RV_, RVG_ or
RVC_ prefixes.

Extend this to the rest of the file as well, as we want to use these
things in a broader scope soon.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/parse_asm.h | 194 ++++++++++++++---------------
 arch/riscv/kernel/kgdb.c           |  40 +++---
 2 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
index 7fee806805c1..ea51542e0c65 100644
--- a/arch/riscv/include/asm/parse_asm.h
+++ b/arch/riscv/include/asm/parse_asm.h
@@ -6,37 +6,37 @@
 #include <linux/bits.h>
 
 /* The bit field of immediate value in I-type instruction */
-#define I_IMM_SIGN_OPOFF	31
-#define I_IMM_11_0_OPOFF	20
-#define I_IMM_SIGN_OFF		12
-#define I_IMM_11_0_OFF		0
-#define I_IMM_11_0_MASK		GENMASK(11, 0)
+#define RV_I_IMM_SIGN_OPOFF	31
+#define RV_I_IMM_11_0_OPOFF	20
+#define RV_I_IMM_SIGN_OFF	12
+#define RV_I_IMM_11_0_OFF	0
+#define RV_I_IMM_11_0_MASK	GENMASK(11, 0)
 
 /* The bit field of immediate value in J-type instruction */
-#define J_IMM_SIGN_OPOFF	31
-#define J_IMM_10_1_OPOFF	21
-#define J_IMM_11_OPOFF		20
-#define J_IMM_19_12_OPOFF	12
-#define J_IMM_SIGN_OFF		20
-#define J_IMM_10_1_OFF		1
-#define J_IMM_11_OFF		11
-#define J_IMM_19_12_OFF		12
-#define J_IMM_10_1_MASK		GENMASK(9, 0)
-#define J_IMM_11_MASK		GENMASK(0, 0)
-#define J_IMM_19_12_MASK	GENMASK(7, 0)
+#define RV_J_IMM_SIGN_OPOFF	31
+#define RV_J_IMM_10_1_OPOFF	21
+#define RV_J_IMM_11_OPOFF	20
+#define RV_J_IMM_19_12_OPOFF	12
+#define RV_J_IMM_SIGN_OFF	20
+#define RV_J_IMM_10_1_OFF	1
+#define RV_J_IMM_11_OFF		11
+#define RV_J_IMM_19_12_OFF	12
+#define RV_J_IMM_10_1_MASK	GENMASK(9, 0)
+#define RV_J_IMM_11_MASK	GENMASK(0, 0)
+#define RV_J_IMM_19_12_MASK	GENMASK(7, 0)
 
 /* The bit field of immediate value in B-type instruction */
-#define B_IMM_SIGN_OPOFF	31
-#define B_IMM_10_5_OPOFF	25
-#define B_IMM_4_1_OPOFF		8
-#define B_IMM_11_OPOFF		7
-#define B_IMM_SIGN_OFF		12
-#define B_IMM_10_5_OFF		5
-#define B_IMM_4_1_OFF		1
-#define B_IMM_11_OFF		11
-#define B_IMM_10_5_MASK		GENMASK(5, 0)
-#define B_IMM_4_1_MASK		GENMASK(3, 0)
-#define B_IMM_11_MASK		GENMASK(0, 0)
+#define RV_B_IMM_SIGN_OPOFF	31
+#define RV_B_IMM_10_5_OPOFF	25
+#define RV_B_IMM_4_1_OPOFF	8
+#define RV_B_IMM_11_OPOFF	7
+#define RV_B_IMM_SIGN_OFF	12
+#define RV_B_IMM_10_5_OFF	5
+#define RV_B_IMM_4_1_OFF	1
+#define RV_B_IMM_11_OFF		11
+#define RV_B_IMM_10_5_MASK	GENMASK(5, 0)
+#define RV_B_IMM_4_1_MASK	GENMASK(3, 0)
+#define RV_B_IMM_11_MASK	GENMASK(0, 0)
 
 /* The register offset in RVG instruction */
 #define RVG_RS1_OPOFF		15
@@ -100,71 +100,71 @@
 #define RVC_C2_RD_OPOFF		7
 
 /* parts of opcode for RVG*/
-#define OPCODE_BRANCH		0x63
-#define OPCODE_JALR		0x67
-#define OPCODE_JAL		0x6f
-#define OPCODE_SYSTEM		0x73
+#define RVG_OPCODE_BRANCH	0x63
+#define RVG_OPCODE_JALR		0x67
+#define RVG_OPCODE_JAL		0x6f
+#define RVG_OPCODE_SYSTEM	0x73
 
 /* parts of opcode for RVC*/
-#define OPCODE_C_0		0x0
-#define OPCODE_C_1		0x1
-#define OPCODE_C_2		0x2
+#define RVC_OPCODE_C0		0x0
+#define RVC_OPCODE_C1		0x1
+#define RVC_OPCODE_C2		0x2
 
 /* parts of funct3 code for I, M, A extension*/
-#define FUNCT3_JALR		0x0
-#define FUNCT3_BEQ		0x0
-#define FUNCT3_BNE		0x1000
-#define FUNCT3_BLT		0x4000
-#define FUNCT3_BGE		0x5000
-#define FUNCT3_BLTU		0x6000
-#define FUNCT3_BGEU		0x7000
+#define RVG_FUNCT3_JALR		0x0
+#define RVG_FUNCT3_BEQ		0x0
+#define RVG_FUNCT3_BNE		0x1000
+#define RVG_FUNCT3_BLT		0x4000
+#define RVG_FUNCT3_BGE		0x5000
+#define RVG_FUNCT3_BLTU		0x6000
+#define RVG_FUNCT3_BGEU		0x7000
 
 /* parts of funct3 code for C extension*/
-#define FUNCT3_C_BEQZ		0xc000
-#define FUNCT3_C_BNEZ		0xe000
-#define FUNCT3_C_J		0xa000
-#define FUNCT3_C_JAL		0x2000
-#define FUNCT4_C_JR		0x8000
-#define FUNCT4_C_JALR		0x9000
-
-#define FUNCT12_SRET		0x10200000
-
-#define MATCH_JALR		(FUNCT3_JALR | OPCODE_JALR)
-#define MATCH_JAL		(OPCODE_JAL)
-#define MATCH_BEQ		(FUNCT3_BEQ | OPCODE_BRANCH)
-#define MATCH_BNE		(FUNCT3_BNE | OPCODE_BRANCH)
-#define MATCH_BLT		(FUNCT3_BLT | OPCODE_BRANCH)
-#define MATCH_BGE		(FUNCT3_BGE | OPCODE_BRANCH)
-#define MATCH_BLTU		(FUNCT3_BLTU | OPCODE_BRANCH)
-#define MATCH_BGEU		(FUNCT3_BGEU | OPCODE_BRANCH)
-#define MATCH_SRET		(FUNCT12_SRET | OPCODE_SYSTEM)
-#define MATCH_C_BEQZ		(FUNCT3_C_BEQZ | OPCODE_C_1)
-#define MATCH_C_BNEZ		(FUNCT3_C_BNEZ | OPCODE_C_1)
-#define MATCH_C_J		(FUNCT3_C_J | OPCODE_C_1)
-#define MATCH_C_JAL		(FUNCT3_C_JAL | OPCODE_C_1)
-#define MATCH_C_JR		(FUNCT4_C_JR | OPCODE_C_2)
-#define MATCH_C_JALR		(FUNCT4_C_JALR | OPCODE_C_2)
-
-#define MASK_JALR		0x707f
-#define MASK_JAL		0x7f
-#define MASK_C_JALR		0xf07f
-#define MASK_C_JR		0xf07f
-#define MASK_C_JAL		0xe003
-#define MASK_C_J		0xe003
-#define MASK_BEQ		0x707f
-#define MASK_BNE		0x707f
-#define MASK_BLT		0x707f
-#define MASK_BGE		0x707f
-#define MASK_BLTU		0x707f
-#define MASK_BGEU		0x707f
-#define MASK_C_BEQZ		0xe003
-#define MASK_C_BNEZ		0xe003
-#define MASK_SRET		0xffffffff
+#define RVC_FUNCT3_C_BEQZ	0xc000
+#define RVC_FUNCT3_C_BNEZ	0xe000
+#define RVC_FUNCT3_C_J		0xa000
+#define RVC_FUNCT3_C_JAL	0x2000
+#define RVC_FUNCT4_C_JR		0x8000
+#define RVC_FUNCT4_C_JALR	0x9000
+
+#define RVG_FUNCT12_SRET	0x10200000
+
+#define RVG_MATCH_JALR		(RVG_FUNCT3_JALR | RVG_OPCODE_JALR)
+#define RVG_MATCH_JAL		(RVG_OPCODE_JAL)
+#define RVG_MATCH_BEQ		(RVG_FUNCT3_BEQ | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BNE		(RVG_FUNCT3_BNE | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BLT		(RVG_FUNCT3_BLT | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BGE		(RVG_FUNCT3_BGE | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BLTU		(RVG_FUNCT3_BLTU | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_BGEU		(RVG_FUNCT3_BGEU | RVG_OPCODE_BRANCH)
+#define RVG_MATCH_SRET		(RVG_FUNCT12_SRET | RVG_OPCODE_SYSTEM)
+#define RVC_MATCH_C_BEQZ	(RVC_FUNCT3_C_BEQZ | RVC_OPCODE_C1)
+#define RVC_MATCH_C_BNEZ	(RVC_FUNCT3_C_BNEZ | RVC_OPCODE_C1)
+#define RVC_MATCH_C_J		(RVC_FUNCT3_C_J | RVC_OPCODE_C1)
+#define RVC_MATCH_C_JAL		(RVC_FUNCT3_C_JAL | RVC_OPCODE_C1)
+#define RVC_MATCH_C_JR		(RVC_FUNCT4_C_JR | RVC_OPCODE_C2)
+#define RVC_MATCH_C_JALR	(RVC_FUNCT4_C_JALR | RVC_OPCODE_C2)
+
+#define RVG_MASK_JALR		0x707f
+#define RVG_MASK_JAL		0x7f
+#define RVC_MASK_C_JALR		0xf07f
+#define RVC_MASK_C_JR		0xf07f
+#define RVC_MASK_C_JAL		0xe003
+#define RVC_MASK_C_J		0xe003
+#define RVG_MASK_BEQ		0x707f
+#define RVG_MASK_BNE		0x707f
+#define RVG_MASK_BLT		0x707f
+#define RVG_MASK_BGE		0x707f
+#define RVG_MASK_BLTU		0x707f
+#define RVG_MASK_BGEU		0x707f
+#define RVC_MASK_C_BEQZ		0xe003
+#define RVC_MASK_C_BNEZ		0xe003
+#define RVG_MASK_SRET		0xffffffff
 
 #define __INSN_LENGTH_MASK	_UL(0x3)
 #define __INSN_LENGTH_GE_32	_UL(0x3)
 #define __INSN_OPCODE_MASK	_UL(0x7F)
-#define __INSN_BRANCH_OPCODE	_UL(OPCODE_BRANCH)
+#define __INSN_BRANCH_OPCODE	_UL(RVG_OPCODE_BRANCH)
 
 /* Define a series of is_XXX_insn functions to check if the value INSN
  * is an instance of instruction XXX.
@@ -180,26 +180,26 @@ static inline bool is_ ## INSN_NAME ## _insn(long insn) \
 #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
 #define RVC_X(X, s, mask) RV_X(X, s, mask)
 
-#define EXTRACT_JTYPE_IMM(x) \
+#define RV_EXTRACT_JTYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
-	(RV_X(x_, J_IMM_10_1_OPOFF, J_IMM_10_1_MASK) << J_IMM_10_1_OFF) | \
-	(RV_X(x_, J_IMM_11_OPOFF, J_IMM_11_MASK) << J_IMM_11_OFF) | \
-	(RV_X(x_, J_IMM_19_12_OPOFF, J_IMM_19_12_MASK) << J_IMM_19_12_OFF) | \
-	(RV_IMM_SIGN(x_) << J_IMM_SIGN_OFF); })
+	(RV_X(x_, RV_J_IMM_10_1_OPOFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OFF) | \
+	(RV_X(x_, RV_J_IMM_11_OPOFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OFF) | \
+	(RV_X(x_, RV_J_IMM_19_12_OPOFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OFF) | \
+	(RV_IMM_SIGN(x_) << RV_J_IMM_SIGN_OFF); })
 
-#define EXTRACT_ITYPE_IMM(x) \
+#define RV_EXTRACT_ITYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
-	(RV_X(x_, I_IMM_11_0_OPOFF, I_IMM_11_0_MASK)) | \
-	(RV_IMM_SIGN(x_) << I_IMM_SIGN_OFF); })
+	(RV_X(x_, RV_I_IMM_11_0_OPOFF, RV_I_IMM_11_0_MASK)) | \
+	(RV_IMM_SIGN(x_) << RV_I_IMM_SIGN_OFF); })
 
-#define EXTRACT_BTYPE_IMM(x) \
+#define RV_EXTRACT_BTYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
-	(RV_X(x_, B_IMM_4_1_OPOFF, B_IMM_4_1_MASK) << B_IMM_4_1_OFF) | \
-	(RV_X(x_, B_IMM_10_5_OPOFF, B_IMM_10_5_MASK) << B_IMM_10_5_OFF) | \
-	(RV_X(x_, B_IMM_11_OPOFF, B_IMM_11_MASK) << B_IMM_11_OFF) | \
-	(RV_IMM_SIGN(x_) << B_IMM_SIGN_OFF); })
+	(RV_X(x_, RV_B_IMM_4_1_OPOFF, RV_B_IMM_4_1_MASK) << RV_B_IMM_4_1_OFF) | \
+	(RV_X(x_, RV_B_IMM_10_5_OPOFF, RV_B_IMM_10_5_MASK) << RV_B_IMM_10_5_OFF) | \
+	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
+	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
 
-#define EXTRACT_RVC_J_IMM(x) \
+#define RVC_EXTRACT_JTYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
 	(RVC_X(x_, RVC_J_IMM_3_1_OPOFF, RVC_J_IMM_3_1_MASK) << RVC_J_IMM_3_1_OFF) | \
 	(RVC_X(x_, RVC_J_IMM_4_OPOFF, RVC_J_IMM_4_MASK) << RVC_J_IMM_4_OFF) | \
@@ -210,7 +210,7 @@ static inline bool is_ ## INSN_NAME ## _insn(long insn) \
 	(RVC_X(x_, RVC_J_IMM_10_OPOFF, RVC_J_IMM_10_MASK) << RVC_J_IMM_10_OFF) | \
 	(RVC_IMM_SIGN(x_) << RVC_J_IMM_SIGN_OFF); })
 
-#define EXTRACT_RVC_B_IMM(x) \
+#define RVC_EXTRACT_BTYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
 	(RVC_X(x_, RVC_B_IMM_2_1_OPOFF, RVC_B_IMM_2_1_MASK) << RVC_B_IMM_2_1_OFF) | \
 	(RVC_X(x_, RVC_B_IMM_4_3_OPOFF, RVC_B_IMM_4_3_MASK) << RVC_B_IMM_4_3_OFF) | \
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 963ed7edcff2..137c6d870d58 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -29,20 +29,20 @@ DECLARE_INSN(c_jal, MATCH_C_JAL, MASK_C_JAL)
 #else
 #define is_c_jal_insn(opcode) 0
 #endif
-DECLARE_INSN(jalr, MATCH_JALR, MASK_JALR)
-DECLARE_INSN(jal, MATCH_JAL, MASK_JAL)
-DECLARE_INSN(c_jr, MATCH_C_JR, MASK_C_JR)
-DECLARE_INSN(c_jalr, MATCH_C_JALR, MASK_C_JALR)
-DECLARE_INSN(c_j, MATCH_C_J, MASK_C_J)
-DECLARE_INSN(beq, MATCH_BEQ, MASK_BEQ)
-DECLARE_INSN(bne, MATCH_BNE, MASK_BNE)
-DECLARE_INSN(blt, MATCH_BLT, MASK_BLT)
-DECLARE_INSN(bge, MATCH_BGE, MASK_BGE)
-DECLARE_INSN(bltu, MATCH_BLTU, MASK_BLTU)
-DECLARE_INSN(bgeu, MATCH_BGEU, MASK_BGEU)
-DECLARE_INSN(c_beqz, MATCH_C_BEQZ, MASK_C_BEQZ)
-DECLARE_INSN(c_bnez, MATCH_C_BNEZ, MASK_C_BNEZ)
-DECLARE_INSN(sret, MATCH_SRET, MASK_SRET)
+DECLARE_INSN(jalr, RVG_MATCH_JALR, RVG_MASK_JALR)
+DECLARE_INSN(jal, RVG_MATCH_JAL, RVG_MASK_JAL)
+DECLARE_INSN(c_jr, RVC_MATCH_C_JR, RVC_MASK_C_JR)
+DECLARE_INSN(c_jalr, RVC_MATCH_C_JALR, RVC_MASK_C_JALR)
+DECLARE_INSN(c_j, RVC_MATCH_C_J, RVC_MASK_C_J)
+DECLARE_INSN(beq, RVG_MATCH_BEQ, RVG_MASK_BEQ)
+DECLARE_INSN(bne, RVG_MATCH_BNE, RVG_MASK_BNE)
+DECLARE_INSN(blt, RVG_MATCH_BLT, RVG_MASK_BLT)
+DECLARE_INSN(bge, RVG_MATCH_BGE, RVG_MASK_BGE)
+DECLARE_INSN(bltu, RVG_MATCH_BLTU, RVG_MASK_BLTU)
+DECLARE_INSN(bgeu, RVG_MATCH_BGEU, RVG_MASK_BGEU)
+DECLARE_INSN(c_beqz, RVC_MATCH_C_BEQZ, RVC_MASK_C_BEQZ)
+DECLARE_INSN(c_bnez, RVC_MATCH_C_BNEZ, RVC_MASK_C_BNEZ)
+DECLARE_INSN(sret, RVG_MATCH_SRET, RVG_MASK_SRET)
 
 static int decode_register_index(unsigned long opcode, int offset)
 {
@@ -69,19 +69,19 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
 			rs1_num = decode_register_index(op_code, RVC_C2_RS1_OPOFF);
 			*next_addr = regs_ptr[rs1_num];
 		} else if (is_c_j_insn(op_code) || is_c_jal_insn(op_code)) {
-			*next_addr = EXTRACT_RVC_J_IMM(op_code) + pc;
+			*next_addr = RVC_EXTRACT_JTYPE_IMM(op_code) + pc;
 		} else if (is_c_beqz_insn(op_code)) {
 			rs1_num = decode_register_index_short(op_code,
 							      RVC_C1_RS1_OPOFF);
 			if (!rs1_num || regs_ptr[rs1_num] == 0)
-				*next_addr = EXTRACT_RVC_B_IMM(op_code) + pc;
+				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
 			else
 				*next_addr = pc + 2;
 		} else if (is_c_bnez_insn(op_code)) {
 			rs1_num =
 			    decode_register_index_short(op_code, RVC_C1_RS1_OPOFF);
 			if (rs1_num && regs_ptr[rs1_num] != 0)
-				*next_addr = EXTRACT_RVC_B_IMM(op_code) + pc;
+				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
 			else
 				*next_addr = pc + 2;
 		} else {
@@ -90,7 +90,7 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
 	} else {
 		if ((op_code & __INSN_OPCODE_MASK) == __INSN_BRANCH_OPCODE) {
 			bool result = false;
-			long imm = EXTRACT_BTYPE_IMM(op_code);
+			long imm = RV_EXTRACT_BTYPE_IMM(op_code);
 			unsigned long rs1_val = 0, rs2_val = 0;
 
 			rs1_num = decode_register_index(op_code, RVG_RS1_OPOFF);
@@ -121,12 +121,12 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
 			else
 				*next_addr = pc + 4;
 		} else if (is_jal_insn(op_code)) {
-			*next_addr = EXTRACT_JTYPE_IMM(op_code) + pc;
+			*next_addr = RV_EXTRACT_JTYPE_IMM(op_code) + pc;
 		} else if (is_jalr_insn(op_code)) {
 			rs1_num = decode_register_index(op_code, RVG_RS1_OPOFF);
 			if (rs1_num)
 				*next_addr = ((unsigned long *)regs)[rs1_num];
-			*next_addr += EXTRACT_ITYPE_IMM(op_code);
+			*next_addr += RV_EXTRACT_ITYPE_IMM(op_code);
 		} else if (is_sret_insn(op_code)) {
 			*next_addr = pc;
 		} else {
-- 
2.35.1

