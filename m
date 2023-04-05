Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CD6D7958
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjDEKNm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDEKNl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 06:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929AB1737;
        Wed,  5 Apr 2023 03:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 259786241E;
        Wed,  5 Apr 2023 10:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E4C433A0;
        Wed,  5 Apr 2023 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680689619;
        bh=BgubXGAhcAD8xmB3Wb4qFa5qZlD7IhSEYapF4EJB5M4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aLGxBSg5Mk09I9qHbAkz1gOv9DDL1JJwef7ejhT1lkzKe7H4Sd7ZytfDo6SKH6J6g
         RngLBfrJ7rphKUh23sLnrjIwx6D+pLtgGocbt6ChSW91EHf1MkFGXGITGHyYcqHlCm
         VHv/q1FEQEcHXMV85gTu82gOEzNxKHV5HywfqWE+QLbL1yd8ilkZk29oh7eByFQwKm
         1YKCnUyhr7HjB8eQgaDl2i/N8uck+92Eotee8skKFOk4Fw7OH47c/onT2JI0Fj/4Qz
         Bsnhf1au7/Srj8jX8KTn/K4+HXsn3KHrnGG8wwL3bnY/KPeCEk5GWbVdjjg9Vv9OM7
         EjY0P7dfyBUMA==
Received: by mail-lf1-f50.google.com with SMTP id j11so45872596lfg.13;
        Wed, 05 Apr 2023 03:13:39 -0700 (PDT)
X-Gm-Message-State: AAQBX9eNUk1e6lQw9qLa9iBQA/qYIHDi1/ALhY6C0yIEU/HoeizPTKbc
        sW0CYjwX5K3VVn5mbSQ4rWFabh/D5ocuPPEgCRA=
X-Google-Smtp-Source: AKy350ajNiKHcHu3nmUd6p7vtVwwe616jxlR0Qog2XxZUcWDGLZZdDLgXX+Y1Jg5JkBZN/eX7aczjr8qTya8EJvJfh0=
X-Received: by 2002:a05:6512:68:b0:4eb:3f68:553f with SMTP id
 i8-20020a056512006800b004eb3f68553fmr1667233lfo.9.1680689617206; Wed, 05 Apr
 2023 03:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230301085545.2373646-1-chenhuacai@loongson.cn>
 <aba37b65-6fc4-721e-ebc5-df52533e4791@loongson.cn> <CAAhV-H6xAKQ94T5=+iVASwi8F=7+G_ptSGVVBOw4L1fCR+EQOw@mail.gmail.com>
 <dfd6a1cb-25be-cc11-4134-b2e92e353c00@loongson.cn> <CAAhV-H4q2+s2fV6DqSK8H0cByvJsd78GBB_Vw9gxHMfBu2Scug@mail.gmail.com>
 <CAAhV-H54MWEXgqPqv+23vQxQU455iMnwON37uiByyci9cgh5Hg@mail.gmail.com>
 <CAMj1kXEe37g=1DEQcWFEDCLRihZLX14Kso0dwon71W+5jqyDrA@mail.gmail.com> <CAAhV-H7XMWKOQhfh5z5s79oJ_RDCfa5VSEs2m=9thq1GFL=WzA@mail.gmail.com>
In-Reply-To: <CAAhV-H7XMWKOQhfh5z5s79oJ_RDCfa5VSEs2m=9thq1GFL=WzA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 5 Apr 2023 12:13:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGKTL5df-FaMQ-Y+6-aKMLK44P9=fhzHtxm-HyOScZz6g@mail.gmail.com>
Message-ID: <CAMj1kXGKTL5df-FaMQ-Y+6-aKMLK44P9=fhzHtxm-HyOScZz6g@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Reintroduce efi_relocate_kernel() to
 relocate kernel
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 5 Apr 2023 at 11:57, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Wed, Apr 5, 2023 at 4:20=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Wed, 5 Apr 2023 at 10:14, Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi, Ard,
> > >
> > > What is the status of this patch now?
> > >
> >
> > I'd still like to understand how zboot is affected. It has
> >
> > static unsigned long alloc_preferred_address(unsigned long alloc_size)
> > {
> > #ifdef EFI_KIMG_PREFERRED_ADDRESS
> >         efi_physical_addr_t efi_addr =3D EFI_KIMG_PREFERRED_ADDRESS;
> >
> >         if (efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS, EFI_LOADE=
R_DATA,
> >                         alloc_size / EFI_PAGE_SIZE, &efi_addr) =3D=3D E=
FI_SUCCESS)
> >                 return efi_addr;
> > #endif
> >         return ULONG_MAX;
> > }
> >
> > and if I understand you correctly, we never needed this in the first pl=
ace?
> Technically we don't need this, but I think setting a preferred
> address as before may be better (keeping the default behavior the same
> as before can avoid some unexpected problem).
>

OK makes sense

I have queued this up now, should appear in -next tomorrow.
