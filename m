Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFAB64581C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 11:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLGKpA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Dec 2022 05:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLGKo7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Dec 2022 05:44:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332002CE13
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 02:44:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c66so18000759edf.5
        for <linux-efi@vger.kernel.org>; Wed, 07 Dec 2022 02:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WIyyFsEDdJszW+QGVtD/j+P/QpHLN0kh1fUvi+pqVbc=;
        b=I28zWxSyXTcoSYTHDDfPv93ax7S7OjkjD8G+LsBSLP/R975lnprvMKqA4lVMvq9FAc
         q52dORUYVC6Np2cnUBLJqQ/9koGYZ6xZW36xgGkxLyz45BqPGJv+zy+G/BeF2Vqnc7Ka
         XNwHywy2U1MC/plRKvWOqQsznQTdIe3I3Jjy+6CzY6MphkSRdgRq+rBu2Is0MKdiG619
         cZ/1tgObehulegAm40GMo0xhNTjsFLWDfggj+FO1V/7EWpsXj9+eU6ZOtqNqtwpivD34
         sXlZC7eqeX36OCRiLwzxdB7Kw8zVaEJdUp6zwIB5fa7O57m68Iz3znGW5WTE4Q3tMF9k
         AS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIyyFsEDdJszW+QGVtD/j+P/QpHLN0kh1fUvi+pqVbc=;
        b=VqdnvRfGFTUb2WoIs1eBMduFr570bCgXBoidXlAnhUiYvvbL208CtGAP84f6LO0Xq2
         pTbPkgDq9oyC98m6KMIKTkz33efkX0woYSAO93qyVn44P5e+spVhOHcChHvOl88E0Rgl
         Ez1M7RkmrxGmOo4uywQNi1jDLf3wHdHowX5R0/DINsEbWR4dzRaZ3mWnqi6/Y15FA++q
         L69eDqp3/6iKCpm5vHLsYRD+cIjynMHVArkFLO+bFYOeAC8dgT5pJapU1kRM33JUEhdn
         Dm/dhu0G94eqpE407QYu4q72Qr3Te8pxwpUxQA+caAL1eAwsn0Y3exiuMttBcFdG9nmB
         3EBQ==
X-Gm-Message-State: ANoB5plbLQ47vpu/Leg0QFANTsb2uIXcc37IvC8a6pfBkm3ni1lNSshX
        nmolKlH7GfEokJx5c9RntuCl43sv2PM4UFHi
X-Google-Smtp-Source: AA0mqf6mUjK024A8sixt5aDOMvR7TrM0k1pBECHMFi/ndvD0TyLcxWe4HW70fW8i6r1uI5ACMbfC6Q==
X-Received: by 2002:a05:6402:5406:b0:467:4b3d:f2ed with SMTP id ev6-20020a056402540600b004674b3df2edmr293577edb.101.1670409895739;
        Wed, 07 Dec 2022 02:44:55 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b0073d81b0882asm8284525ejx.7.2022.12.07.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:44:55 -0800 (PST)
Date:   Wed, 7 Dec 2022 11:44:54 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 11/14] RISC-V: fix auipc-jalr addresses in patched
 alternatives
Message-ID: <20221207104454.7r3sx37mvlfc73jq@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221201193353.7rtpqrkk7ws34e3k@kamzik>
 <3628021.R56niFO833@diego>
 <2256630.NgBsaNRSFp@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2256630.NgBsaNRSFp@diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 07, 2022 at 10:35:50AM +0100, Heiko Stübner wrote:
> Am Dienstag, 6. Dezember 2022, 23:10:01 CET schrieb Heiko Stübner:
> > Am Donnerstag, 1. Dezember 2022, 20:33:53 CET schrieb Andrew Jones:
> > > On Wed, Nov 30, 2022 at 11:56:11PM +0100, Heiko Stuebner wrote:
> > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
...
> > > > +#define to_auipc_imm(value)						\
> > > > +	((value & JALR_SIGN_MASK) ?					\
> > > > +	((value & RV_U_IMM_31_12_MASK) + AUIPC_PAD) :	\
> > > > +	(value & RV_U_IMM_31_12_MASK))
> > > 
> > > I know RV_U_IMM_31_12_OPOFF is 0, but it looks odd not shifting
> > > RV_U_IMM_31_12_MASK when we do shift RV_I_IMM_11_0_MASK.
> > > 
> > > So, it looks like to_auipc_imm() is doing
> > > 
> > >    offset[31:12] + ((value & BIT(11)) ? (1 << 12) : 0)
> > > 
> > > but the spec says the auipc part of the 'call' pseudoinstruction should be
> > 
> > can you point me to that part of the spec?
> > 
> > For educational purposes, because in the main riscv-spec I only found
> > the main auipc + jalr descriptions, but nothing about the actual
> > "call" pseudoinstruction.
> > 
> > [and I'm probably just looking at the wrong document]
> > 
> > 
> > >    offset[31:12] + offset[11]
> > >  
> > > which I think would be written as
> > > 
> > >  ((((value) & RV_U_IMM_31_12_MASK) << RV_U_IMM_31_12_OPOFF) + ((value) & BIT(11)))
> > > 
> > > or what am I missing?
> 
> So far I've found the riscv-asm-manual [0], which only states for call
> 	auipc x1, offset[31:12]
> 	jalr x1, x1, offset[11:0]
> 
> and the psABI spec [1], neither mention your "offset[31:12] + offset[11]" ?
> 
> But [1] does contain that tiny sentence
> "The successive instruction has a signed 12-bit immediate so the value
>  of the preceding high 20-bit relocation may have 1 added to it."
> 
> 
> I.e. the lower 12 bits become themself a signed number [-2048:2047]
> 
> Take an example:
> - address is 1862116 ( 0b 111000110 100111100100 )
> - address[31:12] becomes 1859584 (as 0b 111000110 000000000000)
> - while address[11:0] is 2532 as part of the bigger number
> - as lone 12bit signed IMM it becomes -1564
> - so you need to add this 4096 to the auipc IMM to compensate
> 
> 
> Heiko
> 
> 
> [0] https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md
> [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/tag/v1.0

Yeah, I got this figured out yesterday and sent another mail confirming
the way you had it was right. Did you receive that mail?

Where I see 

 call offset     auipc x1, offset[31 : 12] + offset[11]
                 jalr x1, offset[11:0](x1)

is in chapter 25 of the unprivileged ISA.

> 
> > 
> > that whole thing came from the ftrace parts, also doing call fixup voodoo
> > And I can't really say that I understand every nook and cranny of it.
> > 
> > But for practical purposes, the addresses generated now work,
> > and also seem to work for the ftrace counterpart (see include/asm/ftrace.h)
> > 
> > [another place that will profit from more generalization :-) ]
> > 
> > 
> > > > +
> > > > +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned int len,
> > > > +				      int patch_offset)
> > > > +{
> > > > +	int num_instr = len / sizeof(u32);
> > > > +	unsigned int call[2];
> > > > +	int i;
> > > > +	int imm;
> > > > +	u32 rd1;
> > > > +
> > > > +	/*
> > > > +	 * stop one instruction before the end, as we're checking
> > > > +	 * for auipc + jalr
> > > > +	 */
> > > > +	for (i = 0; i < num_instr - 1; i++) {
> > > 
> > > If we change riscv_instruction_at() to just take a pointer then we can do
> > > the math in the for() and actually just use pointer arithmetic.
> > > 
> > >         uint32_t *p = alt_ptr;
> > >         for (i = 0; i < num_instr - 1; i++, p++) {
> > 
> > Wasn't not using uint32 pointers the whole point of going with the accessor?

Oh, right. So maybe stick to the offsetting, but still do the math in the
caller.

Thanks,
drew
