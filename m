Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7559D63E3C5
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 23:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK3W4y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 17:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiK3W4s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 17:56:48 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF093A43
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 14:56:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0W0L-0005PW-3H; Wed, 30 Nov 2022 23:56:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, heiko@sntech.de,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 06/14] RISC-V: Move riscv_insn_is_* macros into a common header
Date:   Wed, 30 Nov 2022 23:56:06 +0100
Message-Id: <20221130225614.1594256-7-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130225614.1594256-1-heiko@sntech.de>
References: <20221130225614.1594256-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DRUGS_ERECTILE,
        DRUGS_ERECTILE_OBFU,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Right now the riscv kernel has (at least) two independent sets
of functions to check if an encoded instruction is of a specific
type. One in kgdb and one kprobes simulate-insn code.

More parts of the kernel will probably need this in the future,
so instead of allowing this duplication to go on further,
move macros that do the function declaration in a common header,
similar to at least aarch64.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/parse_asm.h       | 42 ++++++++++++++++----
 arch/riscv/kernel/kgdb.c                 | 49 ++++++++----------------
 arch/riscv/kernel/probes/simulate-insn.h | 26 +++----------
 3 files changed, 55 insertions(+), 62 deletions(-)

diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
index 28742eb19034..50c899cf4de5 100644
--- a/arch/riscv/include/asm/parse_asm.h
+++ b/arch/riscv/include/asm/parse_asm.h
@@ -193,13 +193,41 @@
 #define __INSN_OPCODE_MASK	_UL(0x7F)
 #define __INSN_BRANCH_OPCODE	_UL(RVG_OPCODE_BRANCH)
 
-/* Define a series of is_XXX_insn functions to check if the value INSN
- * is an instance of instruction XXX.
- */
-#define DECLARE_INSN(INSN_NAME, INSN_MATCH, INSN_MASK) \
-static inline bool is_ ## INSN_NAME ## _insn(long insn) \
-{ \
-	return (insn & (INSN_MASK)) == (INSN_MATCH); \
+#define __RISCV_INSN_FUNCS(name, mask, val)				\
+static __always_inline bool riscv_insn_is_##name(u32 code)		\
+{									\
+	BUILD_BUG_ON(~(mask) & (val));					\
+	return (code & (mask)) == (val);				\
+}									\
+
+#if __riscv_xlen == 32
+/* C.JAL is an RV32C-only instruction */
+__RISCV_INSN_FUNCS(c_jal, RVC_MASK_C_JAL, RVC_MATCH_C_JAL)
+#else
+#define riscv_insn_is_c_jal(opcode) 0
+#endif
+__RISCV_INSN_FUNCS(auipc, RVG_MASK_AUIPC, RVG_MATCH_AUIPC)
+__RISCV_INSN_FUNCS(jalr, RVG_MASK_JALR, RVG_MATCH_JALR)
+__RISCV_INSN_FUNCS(jal, RVG_MASK_JAL, RVG_MATCH_JAL)
+__RISCV_INSN_FUNCS(c_jr, RVC_MASK_C_JR, RVC_MATCH_C_JR)
+__RISCV_INSN_FUNCS(c_jalr, RVC_MASK_C_JALR, RVC_MATCH_C_JALR)
+__RISCV_INSN_FUNCS(c_j, RVC_MASK_C_J, RVC_MATCH_C_J)
+__RISCV_INSN_FUNCS(beq, RVG_MASK_BEQ, RVG_MATCH_BEQ)
+__RISCV_INSN_FUNCS(bne, RVG_MASK_BNE, RVG_MATCH_BNE)
+__RISCV_INSN_FUNCS(blt, RVG_MASK_BLT, RVG_MATCH_BLT)
+__RISCV_INSN_FUNCS(bge, RVG_MASK_BGE, RVG_MATCH_BGE)
+__RISCV_INSN_FUNCS(bltu, RVG_MASK_BLTU, RVG_MATCH_BLTU)
+__RISCV_INSN_FUNCS(bgeu, RVG_MASK_BGEU, RVG_MATCH_BGEU)
+__RISCV_INSN_FUNCS(c_beqz, RVC_MASK_C_BEQZ, RVC_MATCH_C_BEQZ)
+__RISCV_INSN_FUNCS(c_bnez, RVC_MASK_C_BNEZ, RVC_MATCH_C_BNEZ)
+__RISCV_INSN_FUNCS(c_ebreak, RVC_MASK_C_EBREAK, RVC_MATCH_C_EBREAK)
+__RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
+__RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
+
+/* special case to catch _any_ branch instruction */
+static __always_inline bool riscv_insn_is_branch(u32 code)
+{
+	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_BRANCH;
 }
 
 #define RV_IMM_SIGN(x) (-(((x) >> 31) & 1))
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 137c6d870d58..61237aeb493c 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -23,27 +23,6 @@ enum {
 static unsigned long stepped_address;
 static unsigned int stepped_opcode;
 
-#if __riscv_xlen == 32
-/* C.JAL is an RV32C-only instruction */
-DECLARE_INSN(c_jal, MATCH_C_JAL, MASK_C_JAL)
-#else
-#define is_c_jal_insn(opcode) 0
-#endif
-DECLARE_INSN(jalr, RVG_MATCH_JALR, RVG_MASK_JALR)
-DECLARE_INSN(jal, RVG_MATCH_JAL, RVG_MASK_JAL)
-DECLARE_INSN(c_jr, RVC_MATCH_C_JR, RVC_MASK_C_JR)
-DECLARE_INSN(c_jalr, RVC_MATCH_C_JALR, RVC_MASK_C_JALR)
-DECLARE_INSN(c_j, RVC_MATCH_C_J, RVC_MASK_C_J)
-DECLARE_INSN(beq, RVG_MATCH_BEQ, RVG_MASK_BEQ)
-DECLARE_INSN(bne, RVG_MATCH_BNE, RVG_MASK_BNE)
-DECLARE_INSN(blt, RVG_MATCH_BLT, RVG_MASK_BLT)
-DECLARE_INSN(bge, RVG_MATCH_BGE, RVG_MASK_BGE)
-DECLARE_INSN(bltu, RVG_MATCH_BLTU, RVG_MASK_BLTU)
-DECLARE_INSN(bgeu, RVG_MATCH_BGEU, RVG_MASK_BGEU)
-DECLARE_INSN(c_beqz, RVC_MATCH_C_BEQZ, RVC_MASK_C_BEQZ)
-DECLARE_INSN(c_bnez, RVC_MATCH_C_BNEZ, RVC_MASK_C_BNEZ)
-DECLARE_INSN(sret, RVG_MATCH_SRET, RVG_MASK_SRET)
-
 static int decode_register_index(unsigned long opcode, int offset)
 {
 	return (opcode >> offset) & 0x1F;
@@ -65,19 +44,21 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
 	if (get_kernel_nofault(op_code, (void *)pc))
 		return -EINVAL;
 	if ((op_code & __INSN_LENGTH_MASK) != __INSN_LENGTH_GE_32) {
-		if (is_c_jalr_insn(op_code) || is_c_jr_insn(op_code)) {
+		if (riscv_insn_is_c_jalr(op_code) ||
+		    riscv_insn_is_c_jr(op_code)) {
 			rs1_num = decode_register_index(op_code, RVC_C2_RS1_OPOFF);
 			*next_addr = regs_ptr[rs1_num];
-		} else if (is_c_j_insn(op_code) || is_c_jal_insn(op_code)) {
+		} else if (riscv_insn_is_c_j(op_code) ||
+			   riscv_insn_is_c_jal(op_code)) {
 			*next_addr = RVC_EXTRACT_JTYPE_IMM(op_code) + pc;
-		} else if (is_c_beqz_insn(op_code)) {
+		} else if (riscv_insn_is_c_beqz(op_code)) {
 			rs1_num = decode_register_index_short(op_code,
 							      RVC_C1_RS1_OPOFF);
 			if (!rs1_num || regs_ptr[rs1_num] == 0)
 				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
 			else
 				*next_addr = pc + 2;
-		} else if (is_c_bnez_insn(op_code)) {
+		} else if (riscv_insn_is_c_bnez(op_code)) {
 			rs1_num =
 			    decode_register_index_short(op_code, RVC_C1_RS1_OPOFF);
 			if (rs1_num && regs_ptr[rs1_num] != 0)
@@ -100,34 +81,34 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
 			if (rs2_num)
 				rs2_val = regs_ptr[rs2_num];
 
-			if (is_beq_insn(op_code))
+			if (riscv_insn_is_beq(op_code))
 				result = (rs1_val == rs2_val) ? true : false;
-			else if (is_bne_insn(op_code))
+			else if (riscv_insn_is_bne(op_code))
 				result = (rs1_val != rs2_val) ? true : false;
-			else if (is_blt_insn(op_code))
+			else if (riscv_insn_is_blt(op_code))
 				result =
 				    ((long)rs1_val <
 				     (long)rs2_val) ? true : false;
-			else if (is_bge_insn(op_code))
+			else if (riscv_insn_is_bge(op_code))
 				result =
 				    ((long)rs1_val >=
 				     (long)rs2_val) ? true : false;
-			else if (is_bltu_insn(op_code))
+			else if (riscv_insn_is_bltu(op_code))
 				result = (rs1_val < rs2_val) ? true : false;
-			else if (is_bgeu_insn(op_code))
+			else if (riscv_insn_is_bgeu(op_code))
 				result = (rs1_val >= rs2_val) ? true : false;
 			if (result)
 				*next_addr = imm + pc;
 			else
 				*next_addr = pc + 4;
-		} else if (is_jal_insn(op_code)) {
+		} else if (riscv_insn_is_jal(op_code)) {
 			*next_addr = RV_EXTRACT_JTYPE_IMM(op_code) + pc;
-		} else if (is_jalr_insn(op_code)) {
+		} else if (riscv_insn_is_jalr(op_code)) {
 			rs1_num = decode_register_index(op_code, RVG_RS1_OPOFF);
 			if (rs1_num)
 				*next_addr = ((unsigned long *)regs)[rs1_num];
 			*next_addr += RV_EXTRACT_ITYPE_IMM(op_code);
-		} else if (is_sret_insn(op_code)) {
+		} else if (riscv_insn_is_sret(op_code)) {
 			*next_addr = pc;
 		} else {
 			*next_addr = pc + 4;
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index cb6ff7dccb92..29fb16cd335c 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -3,14 +3,7 @@
 #ifndef _RISCV_KERNEL_PROBES_SIMULATE_INSN_H
 #define _RISCV_KERNEL_PROBES_SIMULATE_INSN_H
 
-#define __RISCV_INSN_FUNCS(name, mask, val)				\
-static __always_inline bool riscv_insn_is_##name(probe_opcode_t code)	\
-{									\
-	BUILD_BUG_ON(~(mask) & (val));					\
-	return (code & (mask)) == (val);				\
-}									\
-bool simulate_##name(u32 opcode, unsigned long addr,			\
-		     struct pt_regs *regs)
+#include <asm/parse_asm.h>
 
 #define RISCV_INSN_REJECTED(name, code)					\
 	do {								\
@@ -30,18 +23,9 @@ __RISCV_INSN_FUNCS(fence,	0x7f, 0x0f);
 		}							\
 	} while (0)
 
-__RISCV_INSN_FUNCS(c_j,		0xe003, 0xa001);
-__RISCV_INSN_FUNCS(c_jr,	0xf007, 0x8002);
-__RISCV_INSN_FUNCS(c_jal,	0xe003, 0x2001);
-__RISCV_INSN_FUNCS(c_jalr,	0xf007, 0x9002);
-__RISCV_INSN_FUNCS(c_beqz,	0xe003, 0xc001);
-__RISCV_INSN_FUNCS(c_bnez,	0xe003, 0xe001);
-__RISCV_INSN_FUNCS(c_ebreak,	0xffff, 0x9002);
-
-__RISCV_INSN_FUNCS(auipc,	0x7f, 0x17);
-__RISCV_INSN_FUNCS(branch,	0x7f, 0x63);
-
-__RISCV_INSN_FUNCS(jal,		0x7f, 0x6f);
-__RISCV_INSN_FUNCS(jalr,	0x707f, 0x67);
+bool simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_branch(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
+bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
 
 #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
-- 
2.35.1

