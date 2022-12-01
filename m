Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8D63F5EF
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 18:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLARHf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 12:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiLARHX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 12:07:23 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02480B71FF
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 09:07:14 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0n1e-0002pm-Fd; Thu, 01 Dec 2022 18:07:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 01/14] RISC-V: fix funct4 definition for c.jalr in parse_asm.h
Date:   Thu, 01 Dec 2022 18:07:05 +0100
Message-ID: <4345992.BddDVKsqQX@diego>
In-Reply-To: <20221201170537.mb3o6lybg25muf3n@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de> <20221201170023.tocmgewlwjrc7t6d@kamzik> <20221201170537.mb3o6lybg25muf3n@kamzik>
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

Am Donnerstag, 1. Dezember 2022, 18:05:37 CET schrieb Andrew Jones:
> On Thu, Dec 01, 2022 at 06:00:23PM +0100, Andrew Jones wrote:
> > On Wed, Nov 30, 2022 at 11:56:01PM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > 
> > > The opcode definition for c.jalr is
> > >     c.jalr c_rs1_n0  1..0=2 15..13=4 12=1 6..2=0
> > > 
> > > This means funct4 consisting of bit [15:12] is 1001b, so the value is 0x9.
> > 
> > I presume kgdb c.jalr stepping was broken before this patch and, if so,
> > then we should add a comment stating that and also
> > 
> >   Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")
> > 
> > and maybe to help keep me motivated :-)
> > 
> >   Reported-by: Andrew Jones <ajones@ventanamicro.com>
> >
> 
> Oh, and,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

as I need another round for the purgatory thing anyway, I've added all 3
of the things above :-)

> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > ---
> > >  arch/riscv/include/asm/parse_asm.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
> > > index f36368de839f..7fee806805c1 100644
> > > --- a/arch/riscv/include/asm/parse_asm.h
> > > +++ b/arch/riscv/include/asm/parse_asm.h
> > > @@ -125,7 +125,7 @@
> > >  #define FUNCT3_C_J		0xa000
> > >  #define FUNCT3_C_JAL		0x2000
> > >  #define FUNCT4_C_JR		0x8000
> > > -#define FUNCT4_C_JALR		0xf000
> > > +#define FUNCT4_C_JALR		0x9000
> > >  
> > >  #define FUNCT12_SRET		0x10200000
> > >  
> 




