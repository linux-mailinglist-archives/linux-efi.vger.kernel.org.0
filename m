Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F15BC2DA
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 08:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiISGdy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 02:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISGdx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 02:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4F1A053
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 23:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D06D760B71
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 06:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3996EC43141
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663569231;
        bh=qHWL4WdATNWAwk72mOr/16q6SJQs7sObRP3fl7UD6ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQ+RjgNs2DAFl7f7Pjr8b3giPjbus1Cx0XX+FkvZWiW+LoByaRZOtf42S7zLT3+5t
         UTaH/HPHKhcZ7EsZKzBakpre4/+J3mcPlZCrvxv+A89N3CVAymtJ40guD0CUalrPHF
         H17yVbxKtjEkdYq4WQs/SGtnC9j5fBz+Vrhn2mxKyK3tREDlWDZhuaQDLep6b2k5rv
         vGPBsrqioS1o1cBKWGyACecVuH/vATTM7Znl4gPIMRnWiXPNNrMcbBcunos1+IfqfV
         5GEuLGO6sj7oi8nXRwJa7E3e3gvovhx2ozmEt4dV2lGHtspG4SBe19CuL+zLUnt4xS
         Mwxv2FnPwQ1Zw==
Received: by mail-lf1-f47.google.com with SMTP id a3so33334715lfk.9
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 23:33:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf2TD1KMOhczndJUSgyXjv6b7q12whS4WDTgiq1nvQaYSjZDkdG9
        pLIfLzJ9yy1qeKwcUl07io3FbvF2Mi8wzJhqKSM=
X-Google-Smtp-Source: AMsMyM52yUt+ycJ0Ymsf2uNStsk+t/EEB9h3cAygM0MYTXeJ23B5gqMk5C8dokb4SG12lH2g7tY3h4LDMo26bOydXnM=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr5398289lfb.583.1663569229022; Sun, 18
 Sep 2022 23:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220918213544.2176249-1-ardb@kernel.org> <20220918213544.2176249-12-ardb@kernel.org>
 <CAAhV-H6Ke88sirvX9ut7JLWy+xaERZ7BeMEf97WHRWbsLqZC0A@mail.gmail.com>
 <CAMj1kXHuQHuCt9Z=qWRH_aZY5_+LzpicyE=agMyAX+O14khL_g@mail.gmail.com>
 <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com> <CAMj1kXFKmvSt1092xBUHVXf9NxDFDSDyPDNpwfGUKWGWAPAE9Q@mail.gmail.com>
In-Reply-To: <CAMj1kXFKmvSt1092xBUHVXf9NxDFDSDyPDNpwfGUKWGWAPAE9Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Sep 2022 08:33:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHvAahn9kMvazoA=Zn6c7047zUP7zju6BEeMeATFORXEA@mail.gmail.com>
Message-ID: <CAMj1kXHvAahn9kMvazoA=Zn6c7047zUP7zju6BEeMeATFORXEA@mail.gmail.com>
Subject: Re: [PATCH 11/12] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 19 Sept 2022 at 08:22, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 19 Sept 2022 at 08:06, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> >  Hi, Ard,
> >
> > On Mon, Sep 19, 2022 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 19 Sept 2022 at 03:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > Hi, Ard,
> > > >
> > > > I think the parameters passed to the core kernel need to be discussed.
> > > > The old way (so-called old world):
> > > > a0=argc, a1=argv, a1=bpi
> > > >
> > > > The current way (so-called new world):
> > > > a0=efi boot flag, a1=fdt pointer
> > > >
> > > > The new way (in this patchset):
> > > > a0=efi boot flag, a1=systemtable, a2=cmdline
> > > >
> > > > I prefer to use the current way, there are 3 reasons:
> > > > 1, both acpi system and dt system can use the same parameters passing method;
> > >
> > > DT systems will use this too. The distinction is between EFI boot and
> > > non-EFI boot. We *really* should keep these separate, given the
> > > experience on ARM, where other projects invent ways to pass those
> > > values to the kernel without going through the stub.
> > In the last patch I see:
> > +               void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> > +
> > +               early_init_dt_scan(fdt_ptr);
> > +               early_init_fdt_reserve_self();
> > +
> >                 clear_bit(EFI_BOOT, &efi.flags);
> > So I suppose for the DT system that means a0=efi boot flag, a1=fdt
> > pointer, a2=cmdline? Then it is not exactly the same as the ACPI
> > system, but similar.
> >
>
> No, for non-EFI DT boot, the command line is passed via the DT, so
> a0=0x0 (non-efi), a1=DT, a2=0x0
>
> Do you intend to support non-EFI DT boot by the way?
>
> So
>
> a2  != 0x0 means old world
> a0 != 0x0 means EFI boot, a1 is the command line
> a0 == 0x0 means !EFI boot, a1 is the DT
>

Note: the above applies if we decide to merge the EFI boolean and the
system table pointer into register #0.
