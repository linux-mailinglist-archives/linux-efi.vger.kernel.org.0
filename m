Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B975BCA96
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiISLVf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiISLVd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 07:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB41CB1B
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 04:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C0D60F25
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 11:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8C2C43142
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663586490;
        bh=bbWfo3Vzg8ejEcZiBSarWuwQEIBNh90XgVZBh8VeqdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KvbfaK0/2CtTgsThN6xF3EtxoJkfwUX4+sKwKBAlk5apQ6P5zm0/UV37wCFeC7FL3
         GdvFvJOOVI9GjBOyTwsBLsMrgWTn+RmLWbgA8Q/sqXgg3SttnWLb27LmweTAUDTwdG
         F/ccmsNdvDRGn/VRMhmbDYkH0gq89PrQEF5IMD56vl0yWa8jSL+wLp7drwG3nXPKnR
         AKVIF4u8WSb7NkmGfKs1EHmKdoSmp8kGFtF0qjCc4VW4h8Et5SLAn7fLtyWPwdwfXo
         /cT0e3i0slsQtjEYbm4sb8pJhUd0aEPyYxALKJkyFyAE7R0zfdPodWZulnf/EwGt0b
         Mht4FIdjkfs+A==
Received: by mail-lj1-f177.google.com with SMTP id h3so25046104lja.1
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 04:21:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf3MQWwpSCuAbEEBKSm7w1GLvG4GMuUshhBIBDA6ZXpWDbVhp/o6
        QZVYAaGSdlj8w70LPr8JzRafuT14hOoBfJN98N8=
X-Google-Smtp-Source: AMsMyM4evu2dn9A8ICbqZdiyGWbtAQdRhmsmnTcz+NSnEFfaWo/y54dtH5wZuyg1/ClyHZYugKwr0XhgfLga99gOcyA=
X-Received: by 2002:a2e:a274:0:b0:26c:39f6:7acf with SMTP id
 k20-20020a2ea274000000b0026c39f67acfmr5069455ljm.291.1663586488656; Mon, 19
 Sep 2022 04:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220918213544.2176249-1-ardb@kernel.org> <20220918213544.2176249-12-ardb@kernel.org>
 <CAAhV-H6Ke88sirvX9ut7JLWy+xaERZ7BeMEf97WHRWbsLqZC0A@mail.gmail.com>
 <CAMj1kXHuQHuCt9Z=qWRH_aZY5_+LzpicyE=agMyAX+O14khL_g@mail.gmail.com>
 <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com>
 <CAMj1kXFKmvSt1092xBUHVXf9NxDFDSDyPDNpwfGUKWGWAPAE9Q@mail.gmail.com>
 <CAAhV-H7-9yx4EmtLrvE6arVahsT7AySLyyxk0yXUWPicWfgRjQ@mail.gmail.com>
 <CAMj1kXFuKo=SGGycD8E-FjN9kHsJ45ZCHaRdqgX3bT6XRG418A@mail.gmail.com>
 <CAAhV-H5PbYA+FL6KUVHVGkgC9R_4aNG02d78bTF7senikFPJLw@mail.gmail.com>
 <CAMj1kXHDo26TsVmQATagru6gqo+U8a0k-3uf2Di9JLLDVoGoSg@mail.gmail.com> <CAAhV-H78ErUvzKK-+tcjYq6YKT8G4gtV5VhzsGg-yZYQPRR+bA@mail.gmail.com>
In-Reply-To: <CAAhV-H78ErUvzKK-+tcjYq6YKT8G4gtV5VhzsGg-yZYQPRR+bA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Sep 2022 13:21:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEG7=HWMmu-=_=CjG1gSgz6Q_eTsUjob7sP2uxt5q1_Eg@mail.gmail.com>
Message-ID: <CAMj1kXEG7=HWMmu-=_=CjG1gSgz6Q_eTsUjob7sP2uxt5q1_Eg@mail.gmail.com>
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

On Mon, 19 Sept 2022 at 13:15, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Mon, Sep 19, 2022 at 6:49 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 19 Sept 2022 at 12:47, Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > On Mon, Sep 19, 2022 at 6:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Mon, 19 Sept 2022 at 12:33, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > >
> > > > > Hi, Ard,
> > > > >
> > > > > On Mon, Sep 19, 2022 at 2:22 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, 19 Sept 2022 at 08:06, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > >
> > > > > > >  Hi, Ard,
> > > > > > >
> > > > > > > On Mon, Sep 19, 2022 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 19 Sept 2022 at 03:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi, Ard,
> > > > > > > > >
> > > > > > > > > I think the parameters passed to the core kernel need to be discussed.
> > > > > > > > > The old way (so-called old world):
> > > > > > > > > a0=argc, a1=argv, a1=bpi
> > > > > > > > >
> > > > > > > > > The current way (so-called new world):
> > > > > > > > > a0=efi boot flag, a1=fdt pointer
> > > > > > > > >
> > > > > > > > > The new way (in this patchset):
> > > > > > > > > a0=efi boot flag, a1=systemtable, a2=cmdline
> > > > > > > > >
> > > > > > > > > I prefer to use the current way, there are 3 reasons:
> > > > > > > > > 1, both acpi system and dt system can use the same parameters passing method;
> > > > > > > >
> > > > > > > > DT systems will use this too. The distinction is between EFI boot and
> > > > > > > > non-EFI boot. We *really* should keep these separate, given the
> > > > > > > > experience on ARM, where other projects invent ways to pass those
> > > > > > > > values to the kernel without going through the stub.
> > > > > > > In the last patch I see:
> > > > > > > +               void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> > > > > > > +
> > > > > > > +               early_init_dt_scan(fdt_ptr);
> > > > > > > +               early_init_fdt_reserve_self();
> > > > > > > +
> > > > > > >                 clear_bit(EFI_BOOT, &efi.flags);
> > > > > > > So I suppose for the DT system that means a0=efi boot flag, a1=fdt
> > > > > > > pointer, a2=cmdline? Then it is not exactly the same as the ACPI
> > > > > > > system, but similar.
> > > > > > >
> > > > > >
> > > > > > No, for non-EFI DT boot, the command line is passed via the DT, so
> > > > > > a0=0x0 (non-efi), a1=DT, a2=0x0
> > > > > >
> > > > > > Do you intend to support non-EFI DT boot by the way?
> > > > > I think we needn't support non-EFI DT boot, so a0=efi boot flag,
> > > > > a1=systemtable, a2=cmdline is just OK (or maybe we can exchange a1/a2,
> > > > > which looks similar to the old-world).
> > > >
> > > > Excellent. If non-EFI boot is not supported, we can drop the code that
> > > > deals with that.
> > > >
> > > > > But I have another question: is
> > > > > it early enough to get DT from systemtable for DT boot (in the current
> > > > > way DT is the earliest thing)?
> > > > >
> > > >
> > > > If you rely on DT only for the hardware description, then loading it
> > > > from efi_init() should be fine.
> > > OK, then please drop patch #12 at this time. It can be added when we
> > > add Loongson-2K support.
> > >
> >
> > OK
> >
> > > > > > I don't think it makes sense to allow efi=novamap on LoongArch, given
> > > > > > that we cannot make use of the runtime services that way. So in my
> > > > > > code, efi_novamap is set to false unconditionally.
> > > > > Emm, I prefer to support "efi=novamap", the core kernel has already
> > > > > supported "noefi" to disable runtime, I don't want to hack
> > > > > efi_novamap. So please keep the efi boot flag, thanks.
> > > > >
> > > >
> > > > Fair enough. Do you have any uses for efi_novamap in mind?
> > > I usually use "efi=novamap" in EFI shell to see whether it can work
> > > well without runtime. And I think I will modify this patch these days
> > > because in another thread you said that this series cannot boot.
> >
> > It works fine now.
> >
> > However, clearing the EFI_BOOT flag is not the correct way to disable
> > runtime services only. And note that we also have efi=noruntime - does
> > that currently work on LoongArch?
> OK, but we don't need to add a new "efi=noruntime" parameter, I can
> use "noefi" instead.

OK

> But I think support "efi=novamap" is not a bad
> idea (maybe I misunderstood its usage).
>

It basically exists to deal with broken EFI firmware on ARM laptops
that were only intended to run Windows. Windows calls
SetVirtualAddressMap() *after* creating the new mappings, and some
broken firmware drivers will access those regions too early.

On Linux, we install the mapping first, and then much later, we
actually create the mappings and only activate them on a single CPU
while the EFI runtime service call is in progress.

In any case, I will reinstate the efi_novamap logic for now - we can
always revisit it later.
