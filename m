Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC825321D8
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 06:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiEXEDN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 May 2022 00:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiEXEDM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 May 2022 00:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5232A7091F;
        Mon, 23 May 2022 21:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C79976137A;
        Tue, 24 May 2022 04:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FCFC385AA;
        Tue, 24 May 2022 04:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653364988;
        bh=3chKRr/tcJf7V0ZhM12uWINmUPbaPhX99jsnzK4PsQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FWVVjlZh7TF6EkoTlVCE1awKjVx24DMcPqMerJX80FQ6htXzc3BAjqlDhF7j6MA7c
         OvoufoxysvpHjxIGafoj1h7a/IYGAay+KQ35M45KflnAea1b20jzMMBH7bs28pVUjS
         8XGXb7QryJa5DRgeJD8/AX+tuRutrkwgYIoFsJq7gcclNfA7dFj0BvQ982AJnNDPai
         e2yVKdGFTOwB52W8OlgGU8DY5WkYD7/A0KoPi3YrLhgjFX9k4Ylh2Mv+GAvI4wVs7e
         uoLZiSFV9C0ZVQ0Ohr1slm2vnSEdFifbHz7XgH97lSWM8LPtUteCbA1rwWaBl+h0eo
         yBtiNWL2/BIqg==
Received: by mail-vs1-f53.google.com with SMTP id j7so16272277vsj.7;
        Mon, 23 May 2022 21:03:08 -0700 (PDT)
X-Gm-Message-State: AOAM531FiJKAHaEZHliuMQyOhhrtnXAPg95S+1D4QYwlFb3uNN/jrwlD
        pBrcjHoZ7NH6URH3WzoRrmllX9K8dwdgfmlQzEI=
X-Google-Smtp-Source: ABdhPJy7G/Lr/eV1C1hixtJcpmksdrWm3lrB8tKfo2lAmUa2XNsxlPJrJzy4ti0q9eeiYft3r+HmuwHLrjotRU5bVHc=
X-Received: by 2002:a67:f58f:0:b0:335:d1e6:d5d3 with SMTP id
 i15-20020a67f58f000000b00335d1e6d5d3mr9647693vso.16.1653364987161; Mon, 23
 May 2022 21:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <1653360644-28872-1-git-send-email-baihaowen@meizu.com> <CAAhV-H7Xw-LPdHg1mVF1aZ67RQACBP0kans+moZ3GaRb5PF6VA@mail.gmail.com>
In-Reply-To: <CAAhV-H7Xw-LPdHg1mVF1aZ67RQACBP0kans+moZ3GaRb5PF6VA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 12:03:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Qcj9y6opY3WMTbE8myo77fYRb8Z42C+MPYuScz8N67g@mail.gmail.com>
Message-ID: <CAAhV-H4Qcj9y6opY3WMTbE8myo77fYRb8Z42C+MPYuScz8N67g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: take size of pointed value, not pointer
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 24, 2022 at 11:06 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Haowen,
>
> On Tue, May 24, 2022 at 10:52 AM Haowen Bai <baihaowen@meizu.com> wrote:
> >
> > Sizeof a pointer-typed expression returns the size of the pointer, not
> > that of the pointed data.
> Your patch is correct, but the original patch hasn't been upstream, I don't
> know how to handle it.
I've squash your patch to the original one and add a Co-developed-by:,
not sure it is the best solution. Thanks.

>
> >
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > ---
> >  arch/loongarch/kernel/efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > index f9fdeb1ae358..f0e5d0feffc2 100644
> > --- a/arch/loongarch/kernel/efi.c
> > +++ b/arch/loongarch/kernel/efi.c
> > @@ -180,7 +180,7 @@ void __init efi_init(void)
> >         if (!efi_system_table)
> >                 return;
> >
> > -       efi_systab = (efi_system_table_t *)early_memremap_ro(efi_system_table, sizeof(efi_systab));
> > +       efi_systab = (efi_system_table_t *)early_memremap_ro(efi_system_table, sizeof(*efi_systab));
> >         if (!efi_systab) {
> >                 pr_err("Can't find EFI system table.\n");
> >                 return;
> > --
> > 2.7.4
> >
