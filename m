Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ACA6458CB
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 12:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiLGLU1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Dec 2022 06:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLGLTw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Dec 2022 06:19:52 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5683E08E
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 03:19:48 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CE3BF4434D
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 11:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670411986;
        bh=BqBLrbBfF57to8zw35DaAmnKCfOumSab8VXJ4GtiU+k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=O2/XzvNRh4QeGYTWJlemva/rGUnaw29GjxdKiglq6cMZQbqKgGB0ymFwIeeDonCg1
         Cm06wxbj8seJkQgwhO5RRk6ZwOA7G7VEZybK3hxOj7d2qUWaUemjo/K5kmue7hqcoP
         flqGxyjWbobIaiIwlDtyuElo/zabHB6eloQevLeJn6V3i/0ClCZL6L1NLDhtjeiuAo
         QRxv/hw9f3eTOsHRZoLW+JfYc4CmoCcGFIMyEM4LNd3mJoty7nbKSpFWCwbIUbenxo
         VAeIgfKhMilTBWh+xCfAp1gyr7BvbdEwSNa7Tbhv0o5K+r5JV7IKTu3bwa5Azg2ChA
         HuogFCBOjdzZQ==
Received: by mail-yb1-f198.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so18538908yba.1
        for <linux-efi@vger.kernel.org>; Wed, 07 Dec 2022 03:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqBLrbBfF57to8zw35DaAmnKCfOumSab8VXJ4GtiU+k=;
        b=KvJKNt7NLFbpUd+xHsxO1QZqrfDIJyEOFBi7skVIoMyLC//f7locRFjmC+sBtK58uh
         rBVmR3IlnmHMnE4zopkMALkQPIKSS3V6RE+y5SvSWW8xBmkDIl3J58R6KUDFrHxYkvWA
         yHL/Nw+mgJcpn0TwJF3LQlnHApFuNeg9AyVpmTkXQW6rT2AK8I1IoSN2EHSRI910H52D
         Qz7CLxqQKhMh64Z31GIMM4ym5pg9JeCoFVGax46DboyKByVwgeKIeb2eUH5SP6olg/8S
         0O3upkZvaJ41t9pJCp/TjwWKG1l1MkK+Tn10NA/zFZHZF5OvK8FFsO2SbyK2twKs20lF
         zPuw==
X-Gm-Message-State: ANoB5pkBPRYQ5x85IJs/ntMkkIgQ7e9PWbu4OPTzWpwCHg0rhnrB2xTT
        SqvzWLiIDudj4S8C6+ubl6sDOZv/izzklRJNpyOc5TJEasgfoHfMc7QSoq3B69binwGLh56P3RL
        bPjBAynCzkQdRT0YheiRsT0UJxmEo/T2D97bthmP/6sajJwumnBMASQ==
X-Received: by 2002:a81:5294:0:b0:3c9:6f0d:5197 with SMTP id g142-20020a815294000000b003c96f0d5197mr41668020ywb.230.1670411985286;
        Wed, 07 Dec 2022 03:19:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4LQRXs/RkHLQIIwb8rNtIWPpKCyUgpuoTYghPUM4F8QwSV24A2dGwFVR0bT9Wmvw4JhOaKzDYDBHIjq7ix3Q8=
X-Received: by 2002:a81:5294:0:b0:3c9:6f0d:5197 with SMTP id
 g142-20020a815294000000b003c96f0d5197mr41668009ywb.230.1670411985063; Wed, 07
 Dec 2022 03:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20221130225614.1594256-1-heiko@sntech.de> <20221201193353.7rtpqrkk7ws34e3k@kamzik>
 <3628021.R56niFO833@diego> <2256630.NgBsaNRSFp@diego> <20221207104454.7r3sx37mvlfc73jq@kamzik>
In-Reply-To: <20221207104454.7r3sx37mvlfc73jq@kamzik>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 7 Dec 2022 12:19:28 +0100
Message-ID: <CAJM55Z9y5yJ_MPNrcrunOEEBpoMCFAqV7408H0AbyYxg3c2oWg@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] RISC-V: fix auipc-jalr addresses in patched alternatives
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Dec 2022 at 11:44, Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Wed, Dec 07, 2022 at 10:35:50AM +0100, Heiko St=C3=BCbner wrote:
> > Am Dienstag, 6. Dezember 2022, 23:10:01 CET schrieb Heiko St=C3=BCbner:
> > > Am Donnerstag, 1. Dezember 2022, 20:33:53 CET schrieb Andrew Jones:
> > > > On Wed, Nov 30, 2022 at 11:56:11PM +0100, Heiko Stuebner wrote:
> > > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ...
> > > > > +#define to_auipc_imm(value)                                     =
       \
> > > > > +       ((value & JALR_SIGN_MASK) ?                              =
       \
> > > > > +       ((value & RV_U_IMM_31_12_MASK) + AUIPC_PAD) :   \
> > > > > +       (value & RV_U_IMM_31_12_MASK))
> > > >
> > > > I know RV_U_IMM_31_12_OPOFF is 0, but it looks odd not shifting
> > > > RV_U_IMM_31_12_MASK when we do shift RV_I_IMM_11_0_MASK.
> > > >
> > > > So, it looks like to_auipc_imm() is doing
> > > >
> > > >    offset[31:12] + ((value & BIT(11)) ? (1 << 12) : 0)
> > > >
> > > > but the spec says the auipc part of the 'call' pseudoinstruction sh=
ould be
> > >
> > > can you point me to that part of the spec?
> > >
> > > For educational purposes, because in the main riscv-spec I only found
> > > the main auipc + jalr descriptions, but nothing about the actual
> > > "call" pseudoinstruction.
> > >
> > > [and I'm probably just looking at the wrong document]
> > >
> > >
> > > >    offset[31:12] + offset[11]
> > > >
> > > > which I think would be written as
> > > >
> > > >  ((((value) & RV_U_IMM_31_12_MASK) << RV_U_IMM_31_12_OPOFF) + ((val=
ue) & BIT(11)))
> > > >
> > > > or what am I missing?
> >
> > So far I've found the riscv-asm-manual [0], which only states for call
> >       auipc x1, offset[31:12]
> >       jalr x1, x1, offset[11:0]
> >
> > and the psABI spec [1], neither mention your "offset[31:12] + offset[11=
]" ?
> >
> > But [1] does contain that tiny sentence
> > "The successive instruction has a signed 12-bit immediate so the value
> >  of the preceding high 20-bit relocation may have 1 added to it."
> >
> >
> > I.e. the lower 12 bits become themself a signed number [-2048:2047]
> >
> > Take an example:
> > - address is 1862116 ( 0b 111000110 100111100100 )
> > - address[31:12] becomes 1859584 (as 0b 111000110 000000000000)
> > - while address[11:0] is 2532 as part of the bigger number
> > - as lone 12bit signed IMM it becomes -1564
> > - so you need to add this 4096 to the auipc IMM to compensate
> >
> >
> > Heiko
> >
> >
> > [0] https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv=
-asm.md
> > [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/tag/v=
1.0
>
> Yeah, I got this figured out yesterday and sent another mail confirming
> the way you had it was right. Did you receive that mail?
>
> Where I see
>
>  call offset     auipc x1, offset[31 : 12] + offset[11]
>                  jalr x1, offset[11:0](x1)
>
> is in chapter 25 of the unprivileged ISA.

Sorry, for being late to the conversation. We've fixed confusion about
this auipc/jalr offset at least once before. Maybe that explanation
there is helpful to someone:
https://git.kernel.org/torvalds/c/0966d385830de3470b7131db8e86c0c5bc9c52dc

> >
> > >
> > > that whole thing came from the ftrace parts, also doing call fixup vo=
odoo
> > > And I can't really say that I understand every nook and cranny of it.
> > >
> > > But for practical purposes, the addresses generated now work,
> > > and also seem to work for the ftrace counterpart (see include/asm/ftr=
ace.h)
> > >
> > > [another place that will profit from more generalization :-) ]
> > >
> > >
> > > > > +
> > > > > +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned in=
t len,
> > > > > +                                     int patch_offset)
> > > > > +{
> > > > > +       int num_instr =3D len / sizeof(u32);
> > > > > +       unsigned int call[2];
> > > > > +       int i;
> > > > > +       int imm;
> > > > > +       u32 rd1;
> > > > > +
> > > > > +       /*
> > > > > +        * stop one instruction before the end, as we're checking
> > > > > +        * for auipc + jalr
> > > > > +        */
> > > > > +       for (i =3D 0; i < num_instr - 1; i++) {
> > > >
> > > > If we change riscv_instruction_at() to just take a pointer then we =
can do
> > > > the math in the for() and actually just use pointer arithmetic.
> > > >
> > > >         uint32_t *p =3D alt_ptr;
> > > >         for (i =3D 0; i < num_instr - 1; i++, p++) {
> > >
> > > Wasn't not using uint32 pointers the whole point of going with the ac=
cessor?
>
> Oh, right. So maybe stick to the offsetting, but still do the math in the
> caller.
>
> Thanks,
> drew
