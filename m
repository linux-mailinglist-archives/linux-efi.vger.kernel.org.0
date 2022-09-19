Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA945BCB9B
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiISMPK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 08:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISMPJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 08:15:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8F6583
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 05:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B08A5CE1003
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 12:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6934C433D7
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663589698;
        bh=IA1S2Nv9VZWsDvylCXfvdd8COJg35roCjdyr7j/uutU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p5y0d8wq7cWvLRMj4jJt0Osq5dln415QiD9rRgAtgzmX5mvgqqhdEq+RVCTJXMQk5
         Jm/5RP96CNhG28xyLJL7pCcQG83p7C46gsfOypeE28UVZiTRP7lEfU4jcfKr6hjV4X
         UO7Hqw8KwiaRMJ7q1JHvazakEGKg4I6kc/AtM4cGOV2J1fFZuEJDEgVrC9ei4BWO9I
         4NWVnOsRV6BgUToDbJJZW5PQXLMWD9Ss84CHfGaa6cEsbJNX4ZAlasrqVUE8UogYF3
         BaLYnkDKhKzF3qfvT/C5JlxeQpI3x/V20Ci6BknhrILQGDjmH++HgHeC6mVg92pDbJ
         Vwnkc+IuXGn+g==
Received: by mail-vs1-f53.google.com with SMTP id 129so29678297vsi.10
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 05:14:58 -0700 (PDT)
X-Gm-Message-State: ACrzQf1cmeHFa6qkYgRksI1jUjIqGy/PHJthkrlCT88N6gWT2QNsrGPP
        ImQTNYDwbBWmt2LmdJfzh8HC2041/5CJFOiGxMk=
X-Google-Smtp-Source: AMsMyM4IaLDhSch97P1Tb8ZaF2lS02n5GmTjxlHl6hKc1aICVlpUbt7xLd3bqBajj4qPbrMsIG+m8LmGu4hhGET3Zs4=
X-Received: by 2002:a67:d491:0:b0:398:1bbc:bc85 with SMTP id
 g17-20020a67d491000000b003981bbcbc85mr5798844vsj.59.1663589697478; Mon, 19
 Sep 2022 05:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220918213544.2176249-1-ardb@kernel.org> <20220918213544.2176249-12-ardb@kernel.org>
 <CAAhV-H6Ke88sirvX9ut7JLWy+xaERZ7BeMEf97WHRWbsLqZC0A@mail.gmail.com>
 <CAMj1kXHuQHuCt9Z=qWRH_aZY5_+LzpicyE=agMyAX+O14khL_g@mail.gmail.com>
 <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com>
 <CAMj1kXFKmvSt1092xBUHVXf9NxDFDSDyPDNpwfGUKWGWAPAE9Q@mail.gmail.com>
 <CAAhV-H7-9yx4EmtLrvE6arVahsT7AySLyyxk0yXUWPicWfgRjQ@mail.gmail.com>
 <CAMj1kXFuKo=SGGycD8E-FjN9kHsJ45ZCHaRdqgX3bT6XRG418A@mail.gmail.com>
 <CAAhV-H5PbYA+FL6KUVHVGkgC9R_4aNG02d78bTF7senikFPJLw@mail.gmail.com>
 <CAMj1kXHDo26TsVmQATagru6gqo+U8a0k-3uf2Di9JLLDVoGoSg@mail.gmail.com>
 <CAAhV-H78ErUvzKK-+tcjYq6YKT8G4gtV5VhzsGg-yZYQPRR+bA@mail.gmail.com>
 <CAMj1kXEG7=HWMmu-=_=CjG1gSgz6Q_eTsUjob7sP2uxt5q1_Eg@mail.gmail.com>
 <CAAhV-H67dgV_M2RW37wh_=aA8dr=f_nSbdab3sQPKUvDKws+xQ@mail.gmail.com> <CAMj1kXEWJ9TbhWRTiqFDtHr36dhkc1RfyL8ft06uDsN08x6eYA@mail.gmail.com>
In-Reply-To: <CAMj1kXEWJ9TbhWRTiqFDtHr36dhkc1RfyL8ft06uDsN08x6eYA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 19 Sep 2022 20:14:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5BQAWFAT2vRZxO8L=pU0X5hGD-vHpyRVK0k7UKaLJJpQ@mail.gmail.com>
Message-ID: <CAAhV-H5BQAWFAT2vRZxO8L=pU0X5hGD-vHpyRVK0k7UKaLJJpQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Sep 19, 2022 at 8:11 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 19 Sept 2022 at 13:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Mon, Sep 19, 2022 at 7:21 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 19 Sept 2022 at 13:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > On Mon, Sep 19, 2022 at 6:49 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Mon, 19 Sept 2022 at 12:47, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Sep 19, 2022 at 6:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, 19 Sept 2022 at 12:33, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi, Ard,
> > > > > > > >
> > > > > > > > On Mon, Sep 19, 2022 at 2:22 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 19 Sept 2022 at 08:06, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > >  Hi, Ard,
> > > > > > > > > >
> > > > > > > > > > On Mon, Sep 19, 2022 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 19 Sept 2022 at 03:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi, Ard,
> > > > > > > > > > > >
> > > > > > > > > > > > I think the parameters passed to the core kernel need to be discussed.
> > > > > > > > > > > > The old way (so-called old world):
> > > > > > > > > > > > a0=argc, a1=argv, a1=bpi
> > > > > > > > > > > >
> > > > > > > > > > > > The current way (so-called new world):
> > > > > > > > > > > > a0=efi boot flag, a1=fdt pointer
> > > > > > > > > > > >
> > > > > > > > > > > > The new way (in this patchset):
> > > > > > > > > > > > a0=efi boot flag, a1=systemtable, a2=cmdline
> > > > > > > > > > > >
> > > > > > > > > > > > I prefer to use the current way, there are 3 reasons:
> > > > > > > > > > > > 1, both acpi system and dt system can use the same parameters passing method;
> > > > > > > > > > >
> > > > > > > > > > > DT systems will use this too. The distinction is between EFI boot and
> > > > > > > > > > > non-EFI boot. We *really* should keep these separate, given the
> > > > > > > > > > > experience on ARM, where other projects invent ways to pass those
> > > > > > > > > > > values to the kernel without going through the stub.
> > > > > > > > > > In the last patch I see:
> > > > > > > > > > +               void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> > > > > > > > > > +
> > > > > > > > > > +               early_init_dt_scan(fdt_ptr);
> > > > > > > > > > +               early_init_fdt_reserve_self();
> > > > > > > > > > +
> > > > > > > > > >                 clear_bit(EFI_BOOT, &efi.flags);
> > > > > > > > > > So I suppose for the DT system that means a0=efi boot flag, a1=fdt
> > > > > > > > > > pointer, a2=cmdline? Then it is not exactly the same as the ACPI
> > > > > > > > > > system, but similar.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > No, for non-EFI DT boot, the command line is passed via the DT, so
> > > > > > > > > a0=0x0 (non-efi), a1=DT, a2=0x0
> > > > > > > > >
> > > > > > > > > Do you intend to support non-EFI DT boot by the way?
> > > > > > > > I think we needn't support non-EFI DT boot, so a0=efi boot flag,
> > > > > > > > a1=systemtable, a2=cmdline is just OK (or maybe we can exchange a1/a2,
> > > > > > > > which looks similar to the old-world).
> > > > > > >
> > > > > > > Excellent. If non-EFI boot is not supported, we can drop the code that
> > > > > > > deals with that.
> > > > > > >
> > > > > > > > But I have another question: is
> > > > > > > > it early enough to get DT from systemtable for DT boot (in the current
> > > > > > > > way DT is the earliest thing)?
> > > > > > > >
> > > > > > >
> > > > > > > If you rely on DT only for the hardware description, then loading it
> > > > > > > from efi_init() should be fine.
> > > > > > OK, then please drop patch #12 at this time. It can be added when we
> > > > > > add Loongson-2K support.
> > > > > >
> > > > >
> > > > > OK
> > > > >
> > > > > > > > > I don't think it makes sense to allow efi=novamap on LoongArch, given
> > > > > > > > > that we cannot make use of the runtime services that way. So in my
> > > > > > > > > code, efi_novamap is set to false unconditionally.
> > > > > > > > Emm, I prefer to support "efi=novamap", the core kernel has already
> > > > > > > > supported "noefi" to disable runtime, I don't want to hack
> > > > > > > > efi_novamap. So please keep the efi boot flag, thanks.
> > > > > > > >
> > > > > > >
> > > > > > > Fair enough. Do you have any uses for efi_novamap in mind?
> > > > > > I usually use "efi=novamap" in EFI shell to see whether it can work
> > > > > > well without runtime. And I think I will modify this patch these days
> > > > > > because in another thread you said that this series cannot boot.
> > > > >
> > > > > It works fine now.
> > > > >
> > > > > However, clearing the EFI_BOOT flag is not the correct way to disable
> > > > > runtime services only. And note that we also have efi=noruntime - does
> > > > > that currently work on LoongArch?
> > > > OK, but we don't need to add a new "efi=noruntime" parameter, I can
> > > > use "noefi" instead.
> > >
> > > OK
> > >
> > > > But I think support "efi=novamap" is not a bad
> > > > idea (maybe I misunderstood its usage).
> > > >
> > >
> > > It basically exists to deal with broken EFI firmware on ARM laptops
> > > that were only intended to run Windows. Windows calls
> > > SetVirtualAddressMap() *after* creating the new mappings, and some
> > > broken firmware drivers will access those regions too early.
> > >
> > > On Linux, we install the mapping first, and then much later, we
> > > actually create the mappings and only activate them on a single CPU
> > > while the EFI runtime service call is in progress.
> > >
> > > In any case, I will reinstate the efi_novamap logic for now - we can
> > > always revisit it later.
> > OK, now I think there are no big problems. Only some bikesheddings:
> > 1, Please use "a0=efi boot flag, a1=cmdline a2=systemtable" to pass
> > boot information, it looks most similar to the old-world, and we can
> > distinguish old-world/new-world by judging whether a0 is greater than
> > 1.
> > 2, I prefer "early return" in efi_init, i.e., if (boot_memmap ==
> > EFI_INVALID_TABLE_ADDR) then return immediately, this makes
> > indentation look better.
> > 3, Declare "cmdline" out of the if() condition in init_environ() looks better.
> > 4, I prefer "kernel_addr" rather than "image_addr" in efi_boot_kernel().
> > 5, It seems that one line is enough for the last statement in efi_boot_kernel().
> >
>
> OK
>
> > Hope this series will be stable as soon as possible, our kexec/kdump
> > work needs to adjust because of this change. :)
> >
>
> Do you have a link to those patches?
There is a snapshot for patches pending for 6.1:
https://github.com/loongson/linux/commits/loongarch-next
