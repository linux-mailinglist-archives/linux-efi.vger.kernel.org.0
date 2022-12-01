Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C663F5E1
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLARFm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 12:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLARFm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 12:05:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D5827154
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 09:05:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a16so3193625edb.9
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 09:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oP1QP0YWS7CJi46I4+pKFvIESUxAUWHyU41+Tg9Gm9s=;
        b=m5v6kE1rY8s1X+MJt3aXSmMNlzCHV8mrPgaShkNqLp1G107XI1WTX0Ae8U8m15u89S
         BXTKItTRXGFcJJn/93mSkh+wT9d31lf9DbuVL2r4VncUHWtwUty5xKalGonxnhQI5YwC
         bA35Apk6NX5y2sqgPXv0ZKtWtiT+ulLcJLeSyoo270GPZimE4GULh33wVMTDTIx9RbWA
         AG7isSxb1CIW3hBHz4uHSgEBRPpurvwe7teAU7/Fei4n9L0JlvYdwGKNiKE6WSvpamWJ
         2NB3mQXEQYPFboNxJP7bPRxkTrknW82ZUS/e7Rp51mWN0FGPi9OT1QCG46GEKyvm8QPK
         IGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP1QP0YWS7CJi46I4+pKFvIESUxAUWHyU41+Tg9Gm9s=;
        b=JzkGcu8ERosM+x0vhtEVUIeVMj6Pk5vND4TlUnRRK2LCXvk8FPDJ3I8nTTs7fpfcY+
         ATyoz+4rjmFRsqVoZQyyZEE03VTzVRhpetWM6+2TxZb1N2RTckSiMt+rCA3bJOR8rSbw
         lZaR2pHd2k/LawqX+yqIIT/0YWEDq3bnJN7Q/dO6aH5h/VromMmUWLmfd/xI0mbgjY6Y
         2xhzXFwzMmARG/wSfCMpVrF+BuMiOTZc9OjQAvrit19QjqcCXfdO/aY59NMB7XpW55n4
         mU1TgppkvJH/mGfkZhnqoDJTUab6QB00UgNyoED4g0vK8vdfiW2rzLV63eN/1bSo4BEx
         fJ+Q==
X-Gm-Message-State: ANoB5pkYRpekrBYf9Uxe2KXlojCQ63pemQ4UMGk0dt5eAKx2unMkkdPi
        D6RsxkczaLgdnW67WoGv59gdLA==
X-Google-Smtp-Source: AA0mqf7+sI9sLhanwztWdOBJS0j4o122YNTmOn8CyvzYajpd4MdvKZw+Py/BaeQRuCfXzGWbp3EP8A==
X-Received: by 2002:aa7:c986:0:b0:46b:b010:3f43 with SMTP id c6-20020aa7c986000000b0046bb0103f43mr7915943edt.215.1669914339759;
        Thu, 01 Dec 2022 09:05:39 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709063cb100b007b4bc423b41sm1934395ejh.190.2022.12.01.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:05:39 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:05:37 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v3 01/14] RISC-V: fix funct4 definition for c.jalr in
 parse_asm.h
Message-ID: <20221201170537.mb3o6lybg25muf3n@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-2-heiko@sntech.de>
 <20221201170023.tocmgewlwjrc7t6d@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201170023.tocmgewlwjrc7t6d@kamzik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 01, 2022 at 06:00:23PM +0100, Andrew Jones wrote:
> On Wed, Nov 30, 2022 at 11:56:01PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > 
> > The opcode definition for c.jalr is
> >     c.jalr c_rs1_n0  1..0=2 15..13=4 12=1 6..2=0
> > 
> > This means funct4 consisting of bit [15:12] is 1001b, so the value is 0x9.
> 
> I presume kgdb c.jalr stepping was broken before this patch and, if so,
> then we should add a comment stating that and also
> 
>   Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")
> 
> and maybe to help keep me motivated :-)
> 
>   Reported-by: Andrew Jones <ajones@ventanamicro.com>
>

Oh, and,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

> Thanks,
> drew
> 
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > ---
> >  arch/riscv/include/asm/parse_asm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
> > index f36368de839f..7fee806805c1 100644
> > --- a/arch/riscv/include/asm/parse_asm.h
> > +++ b/arch/riscv/include/asm/parse_asm.h
> > @@ -125,7 +125,7 @@
> >  #define FUNCT3_C_J		0xa000
> >  #define FUNCT3_C_JAL		0x2000
> >  #define FUNCT4_C_JR		0x8000
> > -#define FUNCT4_C_JALR		0xf000
> > +#define FUNCT4_C_JALR		0x9000
> >  
> >  #define FUNCT12_SRET		0x10200000
> >  
> > -- 
> > 2.35.1
> > 
