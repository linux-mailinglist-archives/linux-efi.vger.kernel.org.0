Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0475A53297A
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiEXLlu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 May 2022 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiEXLlr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 May 2022 07:41:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E8E2B;
        Tue, 24 May 2022 04:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CADF7CE19E5;
        Tue, 24 May 2022 11:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1F5C34113;
        Tue, 24 May 2022 11:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653392467;
        bh=xyWOEhDS7IyLf1PZjyOsltV+5LA6MRIE8wzpbN6RO0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VIvgCy9gSHU5nSmAvmpaFooT8IVlIoVYtfN8vlLvB2J5MQiwXn1CsnZAP4IIUeuGh
         W62P/g2ArPB6jVng0iBr+zRO3vAscMZ+kaP8SMBnlbPrBzvNjjja+p1fWLlbzbjXNb
         +vR/ci7tlER5iez/aDsJfjXrLjUY+nvp6OKwaXhpuJht1dQXqwnkzLlQOdN5uLuP2V
         PRg/WwXWZysf6ZtLE9GhCrcyBiX1mgmLn1pg6kmpBjr70ez7KzglZWQeCZY/UnK/Hs
         hw1JSsDJvXc0wqD11glOK7qSsJLiPnlEd3dkZLwL/BFMFCXmQBVuaXY5cVYW1jbfgd
         //alJL979cQOg==
Received: by mail-vs1-f43.google.com with SMTP id j7so5862472vsp.12;
        Tue, 24 May 2022 04:41:07 -0700 (PDT)
X-Gm-Message-State: AOAM533Ml/z/pXFgsfrw3YyIkuGOd7TgG8ZuA871AF6T5WjYuvYBLzkZ
        XUQbAggIHauUKmCOx9VZktdEQHSv+95aLxWXB2Q=
X-Google-Smtp-Source: ABdhPJzCJ2u9jysf3Y3UYbKCx2FPWfsiC1PXV3/DgImJFn80toQja8XBmo+Xx7+ajGyarrIJNUtFoQlBmChBHi8+Zs0=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr10238947vso.20.1653392466187; Tue, 24
 May 2022 04:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <1653360644-28872-1-git-send-email-baihaowen@meizu.com>
 <CAAhV-H7Xw-LPdHg1mVF1aZ67RQACBP0kans+moZ3GaRb5PF6VA@mail.gmail.com> <CAAhV-H4Qcj9y6opY3WMTbE8myo77fYRb8Z42C+MPYuScz8N67g@mail.gmail.com>
In-Reply-To: <CAAhV-H4Qcj9y6opY3WMTbE8myo77fYRb8Z42C+MPYuScz8N67g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 19:40:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6tKeyeo3L7=C2NUQyw_cJpusWYmGUrm8LVVidvjB3MgQ@mail.gmail.com>
Message-ID: <CAAhV-H6tKeyeo3L7=C2NUQyw_cJpusWYmGUrm8LVVidvjB3MgQ@mail.gmail.com>
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

Hi, Haowen,

On Tue, May 24, 2022 at 12:03 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 11:06 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Haowen,
> >
> > On Tue, May 24, 2022 at 10:52 AM Haowen Bai <baihaowen@meizu.com> wrote:
> > >
> > > Sizeof a pointer-typed expression returns the size of the pointer, not
> > > that of the pointed data.
> > Your patch is correct, but the original patch hasn't been upstream, I don't
> > know how to handle it.
> I've squash your patch to the original one and add a Co-developed-by:,
> not sure it is the best solution. Thanks.
I was suggested that a "Suggested-by" is suitable.
https://lore.kernel.org/lkml/CAAhV-H6k=xC-fDYnwsqSeoj7QPPn8RAcR+waQMa8yTs5J-XOSg@mail.gmail.com/T/#t

Huacai
>
> >
> > >
> > > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > > ---
> > >  arch/loongarch/kernel/efi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > > index f9fdeb1ae358..f0e5d0feffc2 100644
> > > --- a/arch/loongarch/kernel/efi.c
> > > +++ b/arch/loongarch/kernel/efi.c
> > > @@ -180,7 +180,7 @@ void __init efi_init(void)
> > >         if (!efi_system_table)
> > >                 return;
> > >
> > > -       efi_systab = (efi_system_table_t *)early_memremap_ro(efi_system_table, sizeof(efi_systab));
> > > +       efi_systab = (efi_system_table_t *)early_memremap_ro(efi_system_table, sizeof(*efi_systab));
> > >         if (!efi_systab) {
> > >                 pr_err("Can't find EFI system table.\n");
> > >                 return;
> > > --
> > > 2.7.4
> > >
