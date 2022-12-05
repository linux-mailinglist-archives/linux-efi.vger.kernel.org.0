Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9697642BD5
	for <lists+linux-efi@lfdr.de>; Mon,  5 Dec 2022 16:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiLEPcN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Dec 2022 10:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiLEPbh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Dec 2022 10:31:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC381A208
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 07:30:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f7so16277205edc.6
        for <linux-efi@vger.kernel.org>; Mon, 05 Dec 2022 07:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuLNXksnCiOj0gcRynfZuf0vnp4nHhaDBoV6r3j89ZI=;
        b=Yma+2IL39iCa1fkmIHS8bBDhyNDsM/4jWtCtGMIQOi7da4MS/fcU7OgNn71TbsUYbV
         8eFGAJIsvPullFUJMAfjvzQGRph7YVhuEHmKqBwYScrOb37/rCnkKYl6uqyjgUtIwmh7
         uCXUZ1X5DmFk8twBWYrpeyxDI9Zb+u30otkaedzbhKpX5LCrHitbLROszIg5nJA56q5b
         0N/dypMVF52E5ahazmU28ZY/FKayzzPXSgrpwi6CHroJTYPddV70QGoMtBYTasWqaTJ+
         df4J4Ow7D9Jaf9iGlgoaiZyPxgJ4X2FNLlS9EybbYFe4uvdltw1eBmDoT6lKbDz9E6hM
         O2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuLNXksnCiOj0gcRynfZuf0vnp4nHhaDBoV6r3j89ZI=;
        b=vTMh0HJFIbq3IqaRy4nrmF2z3WSpYfOejy9F0/VAE1wSFjufpMu9crmx6e737xnM5t
         LIMUwA5TsTVN8Z7zoV4n3OKnJd5aZ1EjhSSSBA6XTl3fw9cSRrhSpVOeVLa6CRKSQZMk
         wy5+HTxAp75ESR4wjW4pVXHQ3lBSz4SdP+2AqnamKV3xv/k38nJPxyq2M1gg2JvoSQje
         m2bxDm0f+fjnvPVOzDVon1qkESuT9feOac6dbdnQNGHsLl/gBQX59yudVYP7NrJ3SHA/
         OPEd0dS4T4860AazhXmjn1YXaeaQRSGZpKI1SyAO9sTgCCPSckdH0ZpmERXb53Ys77LF
         vy+A==
X-Gm-Message-State: ANoB5pkhFVmAYz6RjK50A44L8FUf3VnQmLKcXxeTdzRjssTocURv4ZQV
        fK+zg9KYbKr8dmJlyod+/9tLgw==
X-Google-Smtp-Source: AA0mqf59C+Fb5LlQfE/u3P9GmnFt+9HfXqCUkJGKMWswh3/AqgHckh0cwX7ZNtnsgd30+6YIXCeFpA==
X-Received: by 2002:aa7:dd4b:0:b0:467:65a2:f635 with SMTP id o11-20020aa7dd4b000000b0046765a2f635mr61788240edw.106.1670254228514;
        Mon, 05 Dec 2022 07:30:28 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b007b9269a0423sm6353787ejd.172.2022.12.05.07.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:30:28 -0800 (PST)
Date:   Mon, 5 Dec 2022 16:30:27 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 02/14] RISC-V: add prefix to all constants/macros in
 parse_asm.h
Message-ID: <20221205153027.vfvia6dxgghtxu4d@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-3-heiko@sntech.de>
 <20221205140057.gxsegkbgszfust4y@kamzik>
 <20221205145323.l2dro6dt7muumqpn@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205145323.l2dro6dt7muumqpn@kamzik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 05, 2022 at 03:53:23PM +0100, Andrew Jones wrote:
> On Mon, Dec 05, 2022 at 03:00:57PM +0100, Andrew Jones wrote:
> > On Wed, Nov 30, 2022 at 11:56:02PM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > 
> > > Some of the constants and macros already have suitable RV_, RVG_ or
> > > RVC_ prefixes.
> > > 
> > > Extend this to the rest of the file as well, as we want to use these
> > > things in a broader scope soon.
> > > 
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > ---
> > >  arch/riscv/include/asm/parse_asm.h | 194 ++++++++++++++---------------
> > >  arch/riscv/kernel/kgdb.c           |  40 +++---
> > >  2 files changed, 117 insertions(+), 117 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
> > > index 7fee806805c1..ea51542e0c65 100644
> > > --- a/arch/riscv/include/asm/parse_asm.h
> > > +++ b/arch/riscv/include/asm/parse_asm.h
> > > @@ -6,37 +6,37 @@
> > >  #include <linux/bits.h>
> > >  
> > >  /* The bit field of immediate value in I-type instruction */
> > > -#define I_IMM_SIGN_OPOFF	31
> > > -#define I_IMM_11_0_OPOFF	20
> > > -#define I_IMM_SIGN_OFF		12
> > > -#define I_IMM_11_0_OFF		0
> > > -#define I_IMM_11_0_MASK		GENMASK(11, 0)
> > > +#define RV_I_IMM_SIGN_OPOFF	31
> > > +#define RV_I_IMM_11_0_OPOFF	20
> > > +#define RV_I_IMM_SIGN_OFF	12
> > > +#define RV_I_IMM_11_0_OFF	0
> > > +#define RV_I_IMM_11_0_MASK	GENMASK(11, 0)
> > >  
> > >  /* The bit field of immediate value in J-type instruction */
> > > -#define J_IMM_SIGN_OPOFF	31
> > > -#define J_IMM_10_1_OPOFF	21
> > > -#define J_IMM_11_OPOFF		20
> > > -#define J_IMM_19_12_OPOFF	12
> > > -#define J_IMM_SIGN_OFF		20
> > > -#define J_IMM_10_1_OFF		1
> > > -#define J_IMM_11_OFF		11
> > > -#define J_IMM_19_12_OFF		12
> > > -#define J_IMM_10_1_MASK		GENMASK(9, 0)
> > > -#define J_IMM_11_MASK		GENMASK(0, 0)
> > > -#define J_IMM_19_12_MASK	GENMASK(7, 0)
> > > +#define RV_J_IMM_SIGN_OPOFF	31
> > > +#define RV_J_IMM_10_1_OPOFF	21
> > > +#define RV_J_IMM_11_OPOFF	20
> > > +#define RV_J_IMM_19_12_OPOFF	12
> > > +#define RV_J_IMM_SIGN_OFF	20
> > > +#define RV_J_IMM_10_1_OFF	1
> > > +#define RV_J_IMM_11_OFF		11
> > > +#define RV_J_IMM_19_12_OFF	12
> > > +#define RV_J_IMM_10_1_MASK	GENMASK(9, 0)
> > > +#define RV_J_IMM_11_MASK	GENMASK(0, 0)
> > > +#define RV_J_IMM_19_12_MASK	GENMASK(7, 0)
> > 
> > Looking at the macros below which shift down, mask, and then shift
> > back up, and how these macros are used in the later alternative patching
> > patches, both in this series and Jisheng's, make me think it'd be better
> > to define them already shifted, e.g.
> > 
> > #define RV_J_IMM_10_1_MASK	GENMASK(30, 21)
> > #define RV_J_IMM_11_MASK	GENMASK(20, 20)
> > #define RV_J_IMM_19_12_MASK 	GENMASK(19, 12)
> 
> Eh, never mind, I momentarily lost track of _OFF vs. _OPOFF. These
> macro names are hard to read/track. Maybe what we really need are
> extract() (which we already have, but as macros) and deposit().
> And just put the shifts and masks directly in the extract and deposit
> functions. Taking J-type for example,
> 
> static inline s32 rv_insn_imm_sign(u32 x)
> {
> 	return -((x >> 31) & 1);
> }
> 
> static inline s32 rv_insn_extract_j_imm(u32 insn)
> {
> 	return (rv_insn_imm_sign(insn & BIT(31)) << 20)	|
> 	       ((insn & GENMASK(19, 12)) << 12)		|
> 	       ((insn & BIT(20)) << 11)			|
> 	       ((insn & GENMASK(30, 25)) << 5)		|
> 	       ((insn & GENMASK(24, 21)) << 1);
> }
>   
> static inline void rv_insn_deposit_j_imm(u32 *insn, s32 imm)
> {
> 	*insn &= GENMASK(11, 7) | GENMASK(6, 0);
> 
> 	*insn |= ((imm & BIT(20)) << 31)	|
> 		 ((imm & GENMASK(10, 1)) << 21)	|
> 		 ((imm & BIT(11)) << 20)	|
> 		 ((imm & GENMASK(19, 12)) << 12);
> }
> 
> A pair of static inlines like those for each type would be easier to
> read and use, IMHO.

BTW, it looks like arch/riscv/kernel/module.c might be another place
we could apply deposit functions.

Thanks,
drew

> 
> Thanks,
> drew
> 
> 
> > 
> > Thanks,
> > drew
> > 
> > >  
> > >  /* The bit field of immediate value in B-type instruction */
> > > -#define B_IMM_SIGN_OPOFF	31
> > > -#define B_IMM_10_5_OPOFF	25
> > > -#define B_IMM_4_1_OPOFF		8
> > > -#define B_IMM_11_OPOFF		7
> > > -#define B_IMM_SIGN_OFF		12
> > > -#define B_IMM_10_5_OFF		5
> > > -#define B_IMM_4_1_OFF		1
> > > -#define B_IMM_11_OFF		11
> > > -#define B_IMM_10_5_MASK		GENMASK(5, 0)
> > > -#define B_IMM_4_1_MASK		GENMASK(3, 0)
> > > -#define B_IMM_11_MASK		GENMASK(0, 0)
> > > +#define RV_B_IMM_SIGN_OPOFF	31
> > > +#define RV_B_IMM_10_5_OPOFF	25
> > > +#define RV_B_IMM_4_1_OPOFF	8
> > > +#define RV_B_IMM_11_OPOFF	7
> > > +#define RV_B_IMM_SIGN_OFF	12
> > > +#define RV_B_IMM_10_5_OFF	5
> > > +#define RV_B_IMM_4_1_OFF	1
> > > +#define RV_B_IMM_11_OFF		11
> > > +#define RV_B_IMM_10_5_MASK	GENMASK(5, 0)
> > > +#define RV_B_IMM_4_1_MASK	GENMASK(3, 0)
> > > +#define RV_B_IMM_11_MASK	GENMASK(0, 0)
> > >  
> > >  /* The register offset in RVG instruction */
> > >  #define RVG_RS1_OPOFF		15
> > > @@ -100,71 +100,71 @@
> > >  #define RVC_C2_RD_OPOFF		7
> > >  
> > >  /* parts of opcode for RVG*/
> > > -#define OPCODE_BRANCH		0x63
> > > -#define OPCODE_JALR		0x67
> > > -#define OPCODE_JAL		0x6f
> > > -#define OPCODE_SYSTEM		0x73
> > > +#define RVG_OPCODE_BRANCH	0x63
> > > +#define RVG_OPCODE_JALR		0x67
> > > +#define RVG_OPCODE_JAL		0x6f
> > > +#define RVG_OPCODE_SYSTEM	0x73
> > >  
> > >  /* parts of opcode for RVC*/
> > > -#define OPCODE_C_0		0x0
> > > -#define OPCODE_C_1		0x1
> > > -#define OPCODE_C_2		0x2
> > > +#define RVC_OPCODE_C0		0x0
> > > +#define RVC_OPCODE_C1		0x1
> > > +#define RVC_OPCODE_C2		0x2
> > >  
> > >  /* parts of funct3 code for I, M, A extension*/
> > > -#define FUNCT3_JALR		0x0
> > > -#define FUNCT3_BEQ		0x0
> > > -#define FUNCT3_BNE		0x1000
> > > -#define FUNCT3_BLT		0x4000
> > > -#define FUNCT3_BGE		0x5000
> > > -#define FUNCT3_BLTU		0x6000
> > > -#define FUNCT3_BGEU		0x7000
> > > +#define RVG_FUNCT3_JALR		0x0
> > > +#define RVG_FUNCT3_BEQ		0x0
> > > +#define RVG_FUNCT3_BNE		0x1000
> > > +#define RVG_FUNCT3_BLT		0x4000
> > > +#define RVG_FUNCT3_BGE		0x5000
> > > +#define RVG_FUNCT3_BLTU		0x6000
> > > +#define RVG_FUNCT3_BGEU		0x7000
> > >  
> > >  /* parts of funct3 code for C extension*/
> > > -#define FUNCT3_C_BEQZ		0xc000
> > > -#define FUNCT3_C_BNEZ		0xe000
> > > -#define FUNCT3_C_J		0xa000
> > > -#define FUNCT3_C_JAL		0x2000
> > > -#define FUNCT4_C_JR		0x8000
> > > -#define FUNCT4_C_JALR		0x9000
> > > -
> > > -#define FUNCT12_SRET		0x10200000
> > > -
> > > -#define MATCH_JALR		(FUNCT3_JALR | OPCODE_JALR)
> > > -#define MATCH_JAL		(OPCODE_JAL)
> > > -#define MATCH_BEQ		(FUNCT3_BEQ | OPCODE_BRANCH)
> > > -#define MATCH_BNE		(FUNCT3_BNE | OPCODE_BRANCH)
> > > -#define MATCH_BLT		(FUNCT3_BLT | OPCODE_BRANCH)
> > > -#define MATCH_BGE		(FUNCT3_BGE | OPCODE_BRANCH)
> > > -#define MATCH_BLTU		(FUNCT3_BLTU | OPCODE_BRANCH)
> > > -#define MATCH_BGEU		(FUNCT3_BGEU | OPCODE_BRANCH)
> > > -#define MATCH_SRET		(FUNCT12_SRET | OPCODE_SYSTEM)
> > > -#define MATCH_C_BEQZ		(FUNCT3_C_BEQZ | OPCODE_C_1)
> > > -#define MATCH_C_BNEZ		(FUNCT3_C_BNEZ | OPCODE_C_1)
> > > -#define MATCH_C_J		(FUNCT3_C_J | OPCODE_C_1)
> > > -#define MATCH_C_JAL		(FUNCT3_C_JAL | OPCODE_C_1)
> > > -#define MATCH_C_JR		(FUNCT4_C_JR | OPCODE_C_2)
> > > -#define MATCH_C_JALR		(FUNCT4_C_JALR | OPCODE_C_2)
> > > -
> > > -#define MASK_JALR		0x707f
> > > -#define MASK_JAL		0x7f
> > > -#define MASK_C_JALR		0xf07f
> > > -#define MASK_C_JR		0xf07f
> > > -#define MASK_C_JAL		0xe003
> > > -#define MASK_C_J		0xe003
> > > -#define MASK_BEQ		0x707f
> > > -#define MASK_BNE		0x707f
> > > -#define MASK_BLT		0x707f
> > > -#define MASK_BGE		0x707f
> > > -#define MASK_BLTU		0x707f
> > > -#define MASK_BGEU		0x707f
> > > -#define MASK_C_BEQZ		0xe003
> > > -#define MASK_C_BNEZ		0xe003
> > > -#define MASK_SRET		0xffffffff
> > > +#define RVC_FUNCT3_C_BEQZ	0xc000
> > > +#define RVC_FUNCT3_C_BNEZ	0xe000
> > > +#define RVC_FUNCT3_C_J		0xa000
> > > +#define RVC_FUNCT3_C_JAL	0x2000
> > > +#define RVC_FUNCT4_C_JR		0x8000
> > > +#define RVC_FUNCT4_C_JALR	0x9000
> > > +
> > > +#define RVG_FUNCT12_SRET	0x10200000
> > > +
> > > +#define RVG_MATCH_JALR		(RVG_FUNCT3_JALR | RVG_OPCODE_JALR)
> > > +#define RVG_MATCH_JAL		(RVG_OPCODE_JAL)
> > > +#define RVG_MATCH_BEQ		(RVG_FUNCT3_BEQ | RVG_OPCODE_BRANCH)
> > > +#define RVG_MATCH_BNE		(RVG_FUNCT3_BNE | RVG_OPCODE_BRANCH)
> > > +#define RVG_MATCH_BLT		(RVG_FUNCT3_BLT | RVG_OPCODE_BRANCH)
> > > +#define RVG_MATCH_BGE		(RVG_FUNCT3_BGE | RVG_OPCODE_BRANCH)
> > > +#define RVG_MATCH_BLTU		(RVG_FUNCT3_BLTU | RVG_OPCODE_BRANCH)
> > > +#define RVG_MATCH_BGEU		(RVG_FUNCT3_BGEU | RVG_OPCODE_BRANCH)
> > > +#define RVG_MATCH_SRET		(RVG_FUNCT12_SRET | RVG_OPCODE_SYSTEM)
> > > +#define RVC_MATCH_C_BEQZ	(RVC_FUNCT3_C_BEQZ | RVC_OPCODE_C1)
> > > +#define RVC_MATCH_C_BNEZ	(RVC_FUNCT3_C_BNEZ | RVC_OPCODE_C1)
> > > +#define RVC_MATCH_C_J		(RVC_FUNCT3_C_J | RVC_OPCODE_C1)
> > > +#define RVC_MATCH_C_JAL		(RVC_FUNCT3_C_JAL | RVC_OPCODE_C1)
> > > +#define RVC_MATCH_C_JR		(RVC_FUNCT4_C_JR | RVC_OPCODE_C2)
> > > +#define RVC_MATCH_C_JALR	(RVC_FUNCT4_C_JALR | RVC_OPCODE_C2)
> > > +
> > > +#define RVG_MASK_JALR		0x707f
> > > +#define RVG_MASK_JAL		0x7f
> > > +#define RVC_MASK_C_JALR		0xf07f
> > > +#define RVC_MASK_C_JR		0xf07f
> > > +#define RVC_MASK_C_JAL		0xe003
> > > +#define RVC_MASK_C_J		0xe003
> > > +#define RVG_MASK_BEQ		0x707f
> > > +#define RVG_MASK_BNE		0x707f
> > > +#define RVG_MASK_BLT		0x707f
> > > +#define RVG_MASK_BGE		0x707f
> > > +#define RVG_MASK_BLTU		0x707f
> > > +#define RVG_MASK_BGEU		0x707f
> > > +#define RVC_MASK_C_BEQZ		0xe003
> > > +#define RVC_MASK_C_BNEZ		0xe003
> > > +#define RVG_MASK_SRET		0xffffffff
> > >  
> > >  #define __INSN_LENGTH_MASK	_UL(0x3)
> > >  #define __INSN_LENGTH_GE_32	_UL(0x3)
> > >  #define __INSN_OPCODE_MASK	_UL(0x7F)
> > > -#define __INSN_BRANCH_OPCODE	_UL(OPCODE_BRANCH)
> > > +#define __INSN_BRANCH_OPCODE	_UL(RVG_OPCODE_BRANCH)
> > >  
> > >  /* Define a series of is_XXX_insn functions to check if the value INSN
> > >   * is an instance of instruction XXX.
> > > @@ -180,26 +180,26 @@ static inline bool is_ ## INSN_NAME ## _insn(long insn) \
> > >  #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
> > >  #define RVC_X(X, s, mask) RV_X(X, s, mask)
> > >  
> > > -#define EXTRACT_JTYPE_IMM(x) \
> > > +#define RV_EXTRACT_JTYPE_IMM(x) \
> > >  	({typeof(x) x_ = (x); \
> > > -	(RV_X(x_, J_IMM_10_1_OPOFF, J_IMM_10_1_MASK) << J_IMM_10_1_OFF) | \
> > > -	(RV_X(x_, J_IMM_11_OPOFF, J_IMM_11_MASK) << J_IMM_11_OFF) | \
> > > -	(RV_X(x_, J_IMM_19_12_OPOFF, J_IMM_19_12_MASK) << J_IMM_19_12_OFF) | \
> > > -	(RV_IMM_SIGN(x_) << J_IMM_SIGN_OFF); })
> > > +	(RV_X(x_, RV_J_IMM_10_1_OPOFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_1_OFF) | \
> > > +	(RV_X(x_, RV_J_IMM_11_OPOFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OFF) | \
> > > +	(RV_X(x_, RV_J_IMM_19_12_OPOFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_19_12_OFF) | \
> > > +	(RV_IMM_SIGN(x_) << RV_J_IMM_SIGN_OFF); })
> > >  
> > > -#define EXTRACT_ITYPE_IMM(x) \
> > > +#define RV_EXTRACT_ITYPE_IMM(x) \
> > >  	({typeof(x) x_ = (x); \
> > > -	(RV_X(x_, I_IMM_11_0_OPOFF, I_IMM_11_0_MASK)) | \
> > > -	(RV_IMM_SIGN(x_) << I_IMM_SIGN_OFF); })
> > > +	(RV_X(x_, RV_I_IMM_11_0_OPOFF, RV_I_IMM_11_0_MASK)) | \
> > > +	(RV_IMM_SIGN(x_) << RV_I_IMM_SIGN_OFF); })
> > >  
> > > -#define EXTRACT_BTYPE_IMM(x) \
> > > +#define RV_EXTRACT_BTYPE_IMM(x) \
> > >  	({typeof(x) x_ = (x); \
> > > -	(RV_X(x_, B_IMM_4_1_OPOFF, B_IMM_4_1_MASK) << B_IMM_4_1_OFF) | \
> > > -	(RV_X(x_, B_IMM_10_5_OPOFF, B_IMM_10_5_MASK) << B_IMM_10_5_OFF) | \
> > > -	(RV_X(x_, B_IMM_11_OPOFF, B_IMM_11_MASK) << B_IMM_11_OFF) | \
> > > -	(RV_IMM_SIGN(x_) << B_IMM_SIGN_OFF); })
> > > +	(RV_X(x_, RV_B_IMM_4_1_OPOFF, RV_B_IMM_4_1_MASK) << RV_B_IMM_4_1_OFF) | \
> > > +	(RV_X(x_, RV_B_IMM_10_5_OPOFF, RV_B_IMM_10_5_MASK) << RV_B_IMM_10_5_OFF) | \
> > > +	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
> > > +	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
> > >  
> > > -#define EXTRACT_RVC_J_IMM(x) \
> > > +#define RVC_EXTRACT_JTYPE_IMM(x) \
> > >  	({typeof(x) x_ = (x); \
> > >  	(RVC_X(x_, RVC_J_IMM_3_1_OPOFF, RVC_J_IMM_3_1_MASK) << RVC_J_IMM_3_1_OFF) | \
> > >  	(RVC_X(x_, RVC_J_IMM_4_OPOFF, RVC_J_IMM_4_MASK) << RVC_J_IMM_4_OFF) | \
> > > @@ -210,7 +210,7 @@ static inline bool is_ ## INSN_NAME ## _insn(long insn) \
> > >  	(RVC_X(x_, RVC_J_IMM_10_OPOFF, RVC_J_IMM_10_MASK) << RVC_J_IMM_10_OFF) | \
> > >  	(RVC_IMM_SIGN(x_) << RVC_J_IMM_SIGN_OFF); })
> > >  
> > > -#define EXTRACT_RVC_B_IMM(x) \
> > > +#define RVC_EXTRACT_BTYPE_IMM(x) \
> > >  	({typeof(x) x_ = (x); \
> > >  	(RVC_X(x_, RVC_B_IMM_2_1_OPOFF, RVC_B_IMM_2_1_MASK) << RVC_B_IMM_2_1_OFF) | \
> > >  	(RVC_X(x_, RVC_B_IMM_4_3_OPOFF, RVC_B_IMM_4_3_MASK) << RVC_B_IMM_4_3_OFF) | \
> > > diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
> > > index 963ed7edcff2..137c6d870d58 100644
> > > --- a/arch/riscv/kernel/kgdb.c
> > > +++ b/arch/riscv/kernel/kgdb.c
> > > @@ -29,20 +29,20 @@ DECLARE_INSN(c_jal, MATCH_C_JAL, MASK_C_JAL)
> > >  #else
> > >  #define is_c_jal_insn(opcode) 0
> > >  #endif
> > > -DECLARE_INSN(jalr, MATCH_JALR, MASK_JALR)
> > > -DECLARE_INSN(jal, MATCH_JAL, MASK_JAL)
> > > -DECLARE_INSN(c_jr, MATCH_C_JR, MASK_C_JR)
> > > -DECLARE_INSN(c_jalr, MATCH_C_JALR, MASK_C_JALR)
> > > -DECLARE_INSN(c_j, MATCH_C_J, MASK_C_J)
> > > -DECLARE_INSN(beq, MATCH_BEQ, MASK_BEQ)
> > > -DECLARE_INSN(bne, MATCH_BNE, MASK_BNE)
> > > -DECLARE_INSN(blt, MATCH_BLT, MASK_BLT)
> > > -DECLARE_INSN(bge, MATCH_BGE, MASK_BGE)
> > > -DECLARE_INSN(bltu, MATCH_BLTU, MASK_BLTU)
> > > -DECLARE_INSN(bgeu, MATCH_BGEU, MASK_BGEU)
> > > -DECLARE_INSN(c_beqz, MATCH_C_BEQZ, MASK_C_BEQZ)
> > > -DECLARE_INSN(c_bnez, MATCH_C_BNEZ, MASK_C_BNEZ)
> > > -DECLARE_INSN(sret, MATCH_SRET, MASK_SRET)
> > > +DECLARE_INSN(jalr, RVG_MATCH_JALR, RVG_MASK_JALR)
> > > +DECLARE_INSN(jal, RVG_MATCH_JAL, RVG_MASK_JAL)
> > > +DECLARE_INSN(c_jr, RVC_MATCH_C_JR, RVC_MASK_C_JR)
> > > +DECLARE_INSN(c_jalr, RVC_MATCH_C_JALR, RVC_MASK_C_JALR)
> > > +DECLARE_INSN(c_j, RVC_MATCH_C_J, RVC_MASK_C_J)
> > > +DECLARE_INSN(beq, RVG_MATCH_BEQ, RVG_MASK_BEQ)
> > > +DECLARE_INSN(bne, RVG_MATCH_BNE, RVG_MASK_BNE)
> > > +DECLARE_INSN(blt, RVG_MATCH_BLT, RVG_MASK_BLT)
> > > +DECLARE_INSN(bge, RVG_MATCH_BGE, RVG_MASK_BGE)
> > > +DECLARE_INSN(bltu, RVG_MATCH_BLTU, RVG_MASK_BLTU)
> > > +DECLARE_INSN(bgeu, RVG_MATCH_BGEU, RVG_MASK_BGEU)
> > > +DECLARE_INSN(c_beqz, RVC_MATCH_C_BEQZ, RVC_MASK_C_BEQZ)
> > > +DECLARE_INSN(c_bnez, RVC_MATCH_C_BNEZ, RVC_MASK_C_BNEZ)
> > > +DECLARE_INSN(sret, RVG_MATCH_SRET, RVG_MASK_SRET)
> > >  
> > >  static int decode_register_index(unsigned long opcode, int offset)
> > >  {
> > > @@ -69,19 +69,19 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
> > >  			rs1_num = decode_register_index(op_code, RVC_C2_RS1_OPOFF);
> > >  			*next_addr = regs_ptr[rs1_num];
> > >  		} else if (is_c_j_insn(op_code) || is_c_jal_insn(op_code)) {
> > > -			*next_addr = EXTRACT_RVC_J_IMM(op_code) + pc;
> > > +			*next_addr = RVC_EXTRACT_JTYPE_IMM(op_code) + pc;
> > >  		} else if (is_c_beqz_insn(op_code)) {
> > >  			rs1_num = decode_register_index_short(op_code,
> > >  							      RVC_C1_RS1_OPOFF);
> > >  			if (!rs1_num || regs_ptr[rs1_num] == 0)
> > > -				*next_addr = EXTRACT_RVC_B_IMM(op_code) + pc;
> > > +				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
> > >  			else
> > >  				*next_addr = pc + 2;
> > >  		} else if (is_c_bnez_insn(op_code)) {
> > >  			rs1_num =
> > >  			    decode_register_index_short(op_code, RVC_C1_RS1_OPOFF);
> > >  			if (rs1_num && regs_ptr[rs1_num] != 0)
> > > -				*next_addr = EXTRACT_RVC_B_IMM(op_code) + pc;
> > > +				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
> > >  			else
> > >  				*next_addr = pc + 2;
> > >  		} else {
> > > @@ -90,7 +90,7 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
> > >  	} else {
> > >  		if ((op_code & __INSN_OPCODE_MASK) == __INSN_BRANCH_OPCODE) {
> > >  			bool result = false;
> > > -			long imm = EXTRACT_BTYPE_IMM(op_code);
> > > +			long imm = RV_EXTRACT_BTYPE_IMM(op_code);
> > >  			unsigned long rs1_val = 0, rs2_val = 0;
> > >  
> > >  			rs1_num = decode_register_index(op_code, RVG_RS1_OPOFF);
> > > @@ -121,12 +121,12 @@ static int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
> > >  			else
> > >  				*next_addr = pc + 4;
> > >  		} else if (is_jal_insn(op_code)) {
> > > -			*next_addr = EXTRACT_JTYPE_IMM(op_code) + pc;
> > > +			*next_addr = RV_EXTRACT_JTYPE_IMM(op_code) + pc;
> > >  		} else if (is_jalr_insn(op_code)) {
> > >  			rs1_num = decode_register_index(op_code, RVG_RS1_OPOFF);
> > >  			if (rs1_num)
> > >  				*next_addr = ((unsigned long *)regs)[rs1_num];
> > > -			*next_addr += EXTRACT_ITYPE_IMM(op_code);
> > > +			*next_addr += RV_EXTRACT_ITYPE_IMM(op_code);
> > >  		} else if (is_sret_insn(op_code)) {
> > >  			*next_addr = pc;
> > >  		} else {
> > > -- 
> > > 2.35.1
> > > 
