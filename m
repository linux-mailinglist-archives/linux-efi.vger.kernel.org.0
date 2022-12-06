Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E91644E5D
	for <lists+linux-efi@lfdr.de>; Tue,  6 Dec 2022 23:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLFWKZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 17:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLFWKY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 17:10:24 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49A2F015
        for <linux-efi@vger.kernel.org>; Tue,  6 Dec 2022 14:10:19 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p2g8Z-0005Rk-J7; Tue, 06 Dec 2022 23:10:03 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 11/14] RISC-V: fix auipc-jalr addresses in patched alternatives
Date:   Tue, 06 Dec 2022 23:10:01 +0100
Message-ID: <3628021.R56niFO833@diego>
In-Reply-To: <20221201193353.7rtpqrkk7ws34e3k@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de> <20221130225614.1594256-12-heiko@sntech.de> <20221201193353.7rtpqrkk7ws34e3k@kamzik>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Donnerstag, 1. Dezember 2022, 20:33:53 CET schrieb Andrew Jones:
> On Wed, Nov 30, 2022 at 11:56:11PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > 
> > Alternatives live in a different section, so addresses used by call
> > functions will point to wrong locations after the patch got applied.
> > 
> > Similar to arm64, adjust the location to consider that offset.
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > ---
> >  arch/riscv/include/asm/alternative.h |  3 ++
> >  arch/riscv/kernel/alternative.c      | 72 ++++++++++++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c       | 11 ++++-
> >  3 files changed, 84 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> > index 6511dd73e812..c58ec3cc4bc3 100644
> > --- a/arch/riscv/include/asm/alternative.h
> > +++ b/arch/riscv/include/asm/alternative.h
> > @@ -27,6 +27,9 @@ void __init apply_boot_alternatives(void);
> >  void __init apply_early_boot_alternatives(void);
> >  void apply_module_alternatives(void *start, size_t length);
> >  
> > +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned int len,
> > +				      int patch_offset);
> > +
> >  struct alt_entry {
> >  	void *old_ptr;		 /* address of original instruciton or data  */
> >  	void *alt_ptr;		 /* address of replacement instruction or data */
> > diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> > index a7d26a00beea..292cc42dc3be 100644
> > --- a/arch/riscv/kernel/alternative.c
> > +++ b/arch/riscv/kernel/alternative.c
> > @@ -15,6 +15,8 @@
> >  #include <asm/vendorid_list.h>
> >  #include <asm/sbi.h>
> >  #include <asm/csr.h>
> > +#include <asm/insn.h>
> > +#include <asm/patch.h>
> >  
> >  struct cpu_manufacturer_info_t {
> >  	unsigned long vendor_id;
> > @@ -53,6 +55,76 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
> >  	}
> >  }
> >  
> > +static unsigned int riscv_instruction_at(void *p, unsigned int offset)
> 
> How about explicitly returning a u32?

ok

> > +{
> > +	u16 *parcel = p + (offset * sizeof(u32));
> 
> nit: I realize this is just a helper function, but I think a cleaner
> interface would require the caller do this math, or at least the offset
> scaling, since only the caller knows it's necessary. And, the call to
> patch_text_nosync() requires all the math, so it'd be consistent for
> riscv_instruction_at() to only take a pointer too.

ok

> 
> > +
> > +	return (unsigned int)parcel[0] | (unsigned int)parcel[1] << 16;
> > +}
> > +
> > +static inline bool riscv_insn_is_auipc_jalr(u32 insn1, u32 insn2)
> > +{
> > +	return riscv_insn_is_auipc(insn1) && riscv_insn_is_jalr(insn2);
> > +}
> > +
> > +#define JALR_SIGN_MASK		BIT(RV_I_IMM_SIGN_OPOFF - RV_I_IMM_11_0_OPOFF)
> 
> We know I-type IMM is 11 bits, so we could just define this as BIT(11).
> 
> > +#define AUIPC_PAD		(0x00001000)
> > +
> > +#define to_jalr_imm(value)						\
> > +	((value & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF)
> 
> Should put () around the macro argument, (value)
> 
> > +
> > +#define to_auipc_imm(value)						\
> > +	((value & JALR_SIGN_MASK) ?					\
> > +	((value & RV_U_IMM_31_12_MASK) + AUIPC_PAD) :	\
> > +	(value & RV_U_IMM_31_12_MASK))
> 
> I know RV_U_IMM_31_12_OPOFF is 0, but it looks odd not shifting
> RV_U_IMM_31_12_MASK when we do shift RV_I_IMM_11_0_MASK.
> 
> So, it looks like to_auipc_imm() is doing
> 
>    offset[31:12] + ((value & BIT(11)) ? (1 << 12) : 0)
> 
> but the spec says the auipc part of the 'call' pseudoinstruction should be

can you point me to that part of the spec?

For educational purposes, because in the main riscv-spec I only found
the main auipc + jalr descriptions, but nothing about the actual
"call" pseudoinstruction.

[and I'm probably just looking at the wrong document]


>    offset[31:12] + offset[11]
>  
> which I think would be written as
> 
>  ((((value) & RV_U_IMM_31_12_MASK) << RV_U_IMM_31_12_OPOFF) + ((value) & BIT(11)))
> 
> or what am I missing?

that whole thing came from the ftrace parts, also doing call fixup voodoo
And I can't really say that I understand every nook and cranny of it.

But for practical purposes, the addresses generated now work,
and also seem to work for the ftrace counterpart (see include/asm/ftrace.h)

[another place that will profit from more generalization :-) ]


> > +
> > +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned int len,
> > +				      int patch_offset)
> > +{
> > +	int num_instr = len / sizeof(u32);
> > +	unsigned int call[2];
> > +	int i;
> > +	int imm;
> > +	u32 rd1;
> > +
> > +	/*
> > +	 * stop one instruction before the end, as we're checking
> > +	 * for auipc + jalr
> > +	 */
> > +	for (i = 0; i < num_instr - 1; i++) {
> 
> If we change riscv_instruction_at() to just take a pointer then we can do
> the math in the for() and actually just use pointer arithmetic.
> 
>         uint32_t *p = alt_ptr;
>         for (i = 0; i < num_instr - 1; i++, p++) {

Wasn't not using uint32 pointers the whole point of going with the accessor?


> > +		u32 inst1 = riscv_instruction_at(alt_ptr, i);
>                                                  p
> > +		u32 inst2 = riscv_instruction_at(alt_ptr, i + 1);
>                                                  p + 1
> > +
> > +		if (!riscv_insn_is_auipc_jalr(inst1, inst2))
> > +			continue;
> > +
> > +		/* call will use ra register */
> > +		rd1 = RV_EXTRACT_RD_REG(inst1);
> > +		if (rd1 != 1)
> > +			continue;
> 
> nit: rd1 is only used once, how about
> 
>  if (RV_EXTRACT_RD_REG(inst1) != 1)

ok


Need to look at the rest tomorrow
Heiko


> > +
> > +		/* get and adjust new target address */
> > +		imm = RV_EXTRACT_UTYPE_IMM(inst1);
> 
> Based on my understanding of a auipc part of the 'call', it seems we
> should be subtracting BIT(11) here. And, since RV_EXTRACT_* does sign-
> extension for I-type, then I'm not sure we should use it. So,
> 
>         imm = (inst2 >> RV_I_IMM_11_0_OPOFF) & RV_I_IMM_11_0_MASK;
> 	imm += ((inst1 >> RV_U_IMM_31_12_OPOFF) & RV_U_IMM_31_12_MASK) - (imm & BIT(11));
> 
> > +		imm += RV_EXTRACT_ITYPE_IMM(inst2);
> > +		imm -= patch_offset;
> > +
> > +		/* pick the original auipc + jalr */
> > +		call[0] = inst1;
> > +		call[1] = inst2;
> > +
> > +		/* drop the old IMMs */
> > +		call[0] &= ~(RV_U_IMM_31_12_MASK);
> 
> Same comment as above about RV_U_IMM_31_12_OPOFF. IMO, this would be more
> consistent with the shift, even though it's zero.
> 
>                 call[0] &= ~(RV_U_IMM_31_12_MASK << RV_U_IMM_31_12_OPOFF);
> 
> > +		call[1] &= ~(RV_I_IMM_11_0_MASK << RV_I_IMM_11_0_OPOFF);
> > +
> > +		/* add the adapted IMMs */
> > +		call[0] |= to_auipc_imm(imm);
> 
> As pointed out above, I'm not sure about to_auipc_imm().
> 
> > +		call[1] |= to_jalr_imm(imm);
> > +
> > +		/* patch the call place again */
> > +		patch_text_nosync(alt_ptr + i * sizeof(u32), call, 8);
>                                   ^                                ^
> 				  p		       sizeof(u32) * 2
> > +	}
> > +}
> > +
> >  /*
> >   * This is called very early in the boot process (directly after we run
> >   * a feature detect on the boot CPU). No need to worry about other CPUs
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 694267d1fe81..ba62a4ff5ccd 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -316,8 +316,15 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
> >  		}
> >  
> >  		tmp = (1U << alt->errata_id);
> > -		if (cpu_req_feature & tmp)
> > -			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> > +		if (cpu_req_feature & tmp) {
> > +			/* do the basic patching */
> > +			patch_text_nosync(alt->old_ptr, alt->alt_ptr,
> > +					  alt->alt_len);
> 
> nit: I'd leave this line long and only have one wrap in the line below
> 
> > +
> > +			riscv_alternative_fix_auipc_jalr(alt->old_ptr,
> > +							 alt->alt_len,
> > +							 alt->old_ptr - alt->alt_ptr);
> > +		}
> >  	}
> >  }
> >  #endif
> >
> 
> Thanks,
> drew
> 




