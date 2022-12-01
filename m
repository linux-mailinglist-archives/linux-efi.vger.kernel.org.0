Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383C663F863
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 20:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiLATe5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 14:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLATek (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 14:34:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4293810
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 11:33:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b8so3690674edf.11
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 11:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJeVMWjMdeUD/fv0X+iIoNOgAa8aslZkgiHk2581/Vg=;
        b=Lp2aSn3VG3dW/3ODe2xKTTTN7WYcyGhD9HnM0Y7PBgv0TDyyR2A+hTN/C5Wxcb869l
         BwtkBPQTUsdiA92BkXZIS/IP94Ba/QN6ADFjAdaU4TB9Nkoi8sKkjFIt5OsIt+wL0zV6
         09BSMimOlGRFJisJsNYMOytrmi+/wUAkYOJlOndtG+SmHZyILGrLHJZQKd1glDKN6iQV
         LS2T8P+dngVfeYy32KShIc+45yhyrpvBUlPNRODFEI0tKSVxupF9GrpWx29xR5jHR7sf
         1JJqb+f0VooAFqoJaRVg0MDt0GGhao28juhQHF/QWbbPgjQ9kphW5mIq3dgWjwwGe8Hr
         /33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJeVMWjMdeUD/fv0X+iIoNOgAa8aslZkgiHk2581/Vg=;
        b=sj/k1pgoMkGJgkkcNkF5mEx+JhrKCw7f2ObtfPvKGIXpsZLGpPqSa3Iyzf8CVihrWt
         sv7IZIQ34qVEL4mPBjpeBib/Cm5DF6zSgGAXJ2BmddpBsCt8B31LIEDlCwJIAYywhAnM
         7/lFhzODcwgD87udqGcKFZNbPIhWnwY9tmOz5NqeyOdTiiGA22l9N7xLN2jUNgTi3G0V
         fosS9SUbAc08PonkjR0EQCxEqZDPL4To5X6qFWVuGJcy577jvABumaEOEEJNnhFppOoe
         VbuRlC17n7YpVJ9mjDwa6M9FlyMPr9JIwSZi+QzK/Z05s7vMoEXI3tdfyXKtu/YNrHIn
         C0YQ==
X-Gm-Message-State: ANoB5pn+IifxMasr0yVO1mfs0qTooxCe6ZVEgAmoYb4O7Yhkq5ufRhdn
        w532chv8xVsdaGxPF04R40bS8K7IlwojQg==
X-Google-Smtp-Source: AA0mqf4NphVnM3DoB0W1K9rNiifJKo8d0q9xuXb1RePJKEk/uZOw0wEgNUJxNP12yRbryiEMFWPt4g==
X-Received: by 2002:a50:fc11:0:b0:45a:1bfa:98bf with SMTP id i17-20020a50fc11000000b0045a1bfa98bfmr61456952edr.413.1669923236423;
        Thu, 01 Dec 2022 11:33:56 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id op4-20020a170906bce400b0078df3b4464fsm2165966ejb.19.2022.12.01.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:33:55 -0800 (PST)
Date:   Thu, 1 Dec 2022 20:33:53 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 11/14] RISC-V: fix auipc-jalr addresses in patched
 alternatives
Message-ID: <20221201193353.7rtpqrkk7ws34e3k@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-12-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130225614.1594256-12-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 30, 2022 at 11:56:11PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Alternatives live in a different section, so addresses used by call
> functions will point to wrong locations after the patch got applied.
> 
> Similar to arm64, adjust the location to consider that offset.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/alternative.h |  3 ++
>  arch/riscv/kernel/alternative.c      | 72 ++++++++++++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c       | 11 ++++-
>  3 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 6511dd73e812..c58ec3cc4bc3 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -27,6 +27,9 @@ void __init apply_boot_alternatives(void);
>  void __init apply_early_boot_alternatives(void);
>  void apply_module_alternatives(void *start, size_t length);
>  
> +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned int len,
> +				      int patch_offset);
> +
>  struct alt_entry {
>  	void *old_ptr;		 /* address of original instruciton or data  */
>  	void *alt_ptr;		 /* address of replacement instruction or data */
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index a7d26a00beea..292cc42dc3be 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -15,6 +15,8 @@
>  #include <asm/vendorid_list.h>
>  #include <asm/sbi.h>
>  #include <asm/csr.h>
> +#include <asm/insn.h>
> +#include <asm/patch.h>
>  
>  struct cpu_manufacturer_info_t {
>  	unsigned long vendor_id;
> @@ -53,6 +55,76 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
>  	}
>  }
>  
> +static unsigned int riscv_instruction_at(void *p, unsigned int offset)

How about explicitly returning a u32?

> +{
> +	u16 *parcel = p + (offset * sizeof(u32));

nit: I realize this is just a helper function, but I think a cleaner
interface would require the caller do this math, or at least the offset
scaling, since only the caller knows it's necessary. And, the call to
patch_text_nosync() requires all the math, so it'd be consistent for
riscv_instruction_at() to only take a pointer too.

> +
> +	return (unsigned int)parcel[0] | (unsigned int)parcel[1] << 16;
> +}
> +
> +static inline bool riscv_insn_is_auipc_jalr(u32 insn1, u32 insn2)
> +{
> +	return riscv_insn_is_auipc(insn1) && riscv_insn_is_jalr(insn2);
> +}
> +
> +#define JALR_SIGN_MASK		BIT(RV_I_IMM_SIGN_OPOFF - RV_I_IMM_11_0_OPOFF)

We know I-type IMM is 11 bits, so we could just define this as BIT(11).

> +#define AUIPC_PAD		(0x00001000)
> +
> +#define to_jalr_imm(value)						\
> +	((value & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF)

Should put () around the macro argument, (value)

> +
> +#define to_auipc_imm(value)						\
> +	((value & JALR_SIGN_MASK) ?					\
> +	((value & RV_U_IMM_31_12_MASK) + AUIPC_PAD) :	\
> +	(value & RV_U_IMM_31_12_MASK))

I know RV_U_IMM_31_12_OPOFF is 0, but it looks odd not shifting
RV_U_IMM_31_12_MASK when we do shift RV_I_IMM_11_0_MASK.

So, it looks like to_auipc_imm() is doing

   offset[31:12] + ((value & BIT(11)) ? (1 << 12) : 0)

but the spec says the auipc part of the 'call' pseudoinstruction should be

   offset[31:12] + offset[11]
 
which I think would be written as

 ((((value) & RV_U_IMM_31_12_MASK) << RV_U_IMM_31_12_OPOFF) + ((value) & BIT(11)))

or what am I missing?

> +
> +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned int len,
> +				      int patch_offset)
> +{
> +	int num_instr = len / sizeof(u32);
> +	unsigned int call[2];
> +	int i;
> +	int imm;
> +	u32 rd1;
> +
> +	/*
> +	 * stop one instruction before the end, as we're checking
> +	 * for auipc + jalr
> +	 */
> +	for (i = 0; i < num_instr - 1; i++) {

If we change riscv_instruction_at() to just take a pointer then we can do
the math in the for() and actually just use pointer arithmetic.

        uint32_t *p = alt_ptr;
        for (i = 0; i < num_instr - 1; i++, p++) {

> +		u32 inst1 = riscv_instruction_at(alt_ptr, i);
                                                 p
> +		u32 inst2 = riscv_instruction_at(alt_ptr, i + 1);
                                                 p + 1
> +
> +		if (!riscv_insn_is_auipc_jalr(inst1, inst2))
> +			continue;
> +
> +		/* call will use ra register */
> +		rd1 = RV_EXTRACT_RD_REG(inst1);
> +		if (rd1 != 1)
> +			continue;

nit: rd1 is only used once, how about

 if (RV_EXTRACT_RD_REG(inst1) != 1)

> +
> +		/* get and adjust new target address */
> +		imm = RV_EXTRACT_UTYPE_IMM(inst1);

Based on my understanding of a auipc part of the 'call', it seems we
should be subtracting BIT(11) here. And, since RV_EXTRACT_* does sign-
extension for I-type, then I'm not sure we should use it. So,

        imm = (inst2 >> RV_I_IMM_11_0_OPOFF) & RV_I_IMM_11_0_MASK;
	imm += ((inst1 >> RV_U_IMM_31_12_OPOFF) & RV_U_IMM_31_12_MASK) - (imm & BIT(11));

> +		imm += RV_EXTRACT_ITYPE_IMM(inst2);
> +		imm -= patch_offset;
> +
> +		/* pick the original auipc + jalr */
> +		call[0] = inst1;
> +		call[1] = inst2;
> +
> +		/* drop the old IMMs */
> +		call[0] &= ~(RV_U_IMM_31_12_MASK);

Same comment as above about RV_U_IMM_31_12_OPOFF. IMO, this would be more
consistent with the shift, even though it's zero.

                call[0] &= ~(RV_U_IMM_31_12_MASK << RV_U_IMM_31_12_OPOFF);

> +		call[1] &= ~(RV_I_IMM_11_0_MASK << RV_I_IMM_11_0_OPOFF);
> +
> +		/* add the adapted IMMs */
> +		call[0] |= to_auipc_imm(imm);

As pointed out above, I'm not sure about to_auipc_imm().

> +		call[1] |= to_jalr_imm(imm);
> +
> +		/* patch the call place again */
> +		patch_text_nosync(alt_ptr + i * sizeof(u32), call, 8);
                                  ^                                ^
				  p		       sizeof(u32) * 2
> +	}
> +}
> +
>  /*
>   * This is called very early in the boot process (directly after we run
>   * a feature detect on the boot CPU). No need to worry about other CPUs
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 694267d1fe81..ba62a4ff5ccd 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -316,8 +316,15 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  		}
>  
>  		tmp = (1U << alt->errata_id);
> -		if (cpu_req_feature & tmp)
> -			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> +		if (cpu_req_feature & tmp) {
> +			/* do the basic patching */
> +			patch_text_nosync(alt->old_ptr, alt->alt_ptr,
> +					  alt->alt_len);

nit: I'd leave this line long and only have one wrap in the line below

> +
> +			riscv_alternative_fix_auipc_jalr(alt->old_ptr,
> +							 alt->alt_len,
> +							 alt->old_ptr - alt->alt_ptr);
> +		}
>  	}
>  }
>  #endif
> -- 
> 2.35.1
>

Thanks,
drew
