Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40CA532A1F
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 14:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiEXMLs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 May 2022 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiEXMLr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 May 2022 08:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978BF3BBE9;
        Tue, 24 May 2022 05:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F126153C;
        Tue, 24 May 2022 12:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC7CC34115;
        Tue, 24 May 2022 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653394305;
        bh=WAxME2jCqnYq3zOI/E/rWkFD9vU/aHCVb7JhmBT2ysw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YuGTtIFcMl/M2mNRzQsW3c95pU2bnO87GRa0mpvwQXShnVBnHT4PyToI6EEbHsLtB
         1fd5jNBVYxYvjFgkARs8v1vMdQk5qFfoR3r3bc3LEJcG1dHwbl6kZhhJ/LWl7RcxR7
         jgf6LtM5vcIlLpNu6msGi4/M0AColxzN51jgAJaXw+mqMXwHOUFSHMz1gThkj90Uh8
         BNobRS/FHuYMLFAzigLzcIjyd5TyZy3ncOM/8t3ej6wto9kyWet1LyK/Unq4P56jhn
         0nXbS0uvJS4yHG/dmTKuwxM/lxgjsFI7YnD75oPPohOukEY69KvO5Z2bXEMYkZjt/Q
         6zgYWVvsrKBiw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-e93bbb54f9so21923324fac.12;
        Tue, 24 May 2022 05:11:45 -0700 (PDT)
X-Gm-Message-State: AOAM533gucPHWLhZGqmtNl298VeHuGPe9wnLgPaqTbc5r3t2Wn9bkdyH
        UBBBHrXAEhRXjV6NyNEgt8Jy6tcbTGHFooa+JZY=
X-Google-Smtp-Source: ABdhPJztDF5PV1kXacwpIMJOpIfgEFC8mJZ6y0CYNryPpsBU9wmRW7bvPayvDt7TraMnf5JrVtNBHJo/yPK7N8NbKjM=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr2447846oap.228.1653394304682; Tue, 24
 May 2022 05:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <1653360644-28872-1-git-send-email-baihaowen@meizu.com>
 <CAAhV-H7Xw-LPdHg1mVF1aZ67RQACBP0kans+moZ3GaRb5PF6VA@mail.gmail.com>
 <CAAhV-H4Qcj9y6opY3WMTbE8myo77fYRb8Z42C+MPYuScz8N67g@mail.gmail.com> <CAAhV-H6tKeyeo3L7=C2NUQyw_cJpusWYmGUrm8LVVidvjB3MgQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6tKeyeo3L7=C2NUQyw_cJpusWYmGUrm8LVVidvjB3MgQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 May 2022 14:11:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEEjCNedgBqfLLXGTD1FgfoTSREMT8Xjn7Ec4_1twrNmg@mail.gmail.com>
Message-ID: <CAMj1kXEEjCNedgBqfLLXGTD1FgfoTSREMT8Xjn7Ec4_1twrNmg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: take size of pointed value, not pointer
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Haowen Bai <baihaowen@meizu.com>,
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

On Tue, 24 May 2022 at 13:41, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Haowen,
>
> On Tue, May 24, 2022 at 12:03 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Tue, May 24, 2022 at 11:06 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi, Haowen,
> > >
> > > On Tue, May 24, 2022 at 10:52 AM Haowen Bai <baihaowen@meizu.com> wrote:
> > > >
> > > > Sizeof a pointer-typed expression returns the size of the pointer, not
> > > > that of the pointed data.
> > > Your patch is correct, but the original patch hasn't been upstream, I don't
> > > know how to handle it.
> > I've squash your patch to the original one and add a Co-developed-by:,
> > not sure it is the best solution. Thanks.
> I was suggested that a "Suggested-by" is suitable.
> https://lore.kernel.org/lkml/CAAhV-H6k=xC-fDYnwsqSeoj7QPPn8RAcR+waQMa8yTs5J-XOSg@mail.gmail.com/T/#t
>

Finding and fixing mistakes is the normal review process, and not
every addressed comment needs to be reflected in the tags, even if the
contributor sent it as a separate patch. Adding 'Suggested-by' to the
entire patch falsely implies that the author of the bugfix suggested
the entire work, which is not desirable either.

In this case, the bugfix is a well-known anti-pattern which is not
specific to the introduced code. I don't think this warrants a tag
tbh.
