Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5265BCEEE
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiISOct (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiISOca (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 10:32:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FBF3337B
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 07:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDB77B81C5A
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 14:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89826C43143
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663597936;
        bh=c0RCW4mVU/hiAcOtEc1DJxX921PrCt6wtozeba1Ew34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K0V2cXOMmhfshlZtsOquZ/JO8HGTP3Er0JR6XmLHOBghdkYS5H3+S4gxNbVg8chrd
         o8zo8pHzlFyiHlt5D2hdCAuinsPvg2X4BIxhcznlUm8dN8pHr7JdeE7ZzZPliAwK9v
         3OKAch22b9y9vcAVzmhgFMt3d3ss2J2wMgdsI6teuJKzs3th8UZgflPsOxdQRHDd3P
         gUGQd3QHTSNU89bmE/tszI6b4J4EyyDoP9jhDhXYLLZQmLiZ375MdQvVqlY7YkEpJA
         3LC/954ajS16wqmHSjeEmKob1LlMd/ZEBCznm2ifLOnb/93UODdPhCUb7rhwWKvyED
         hX3V7eoYBtBeg==
Received: by mail-lf1-f49.google.com with SMTP id f9so46533498lfr.3
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 07:32:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf3nZn6OCL8S9BKRYwywIvw401bLYRMYXXd2L66Ai/juECMMtGGi
        GkRPc0Osp1o5h5fWTmXCpMmwV1qUtzla9GF6e8Q=
X-Google-Smtp-Source: AMsMyM6w9JTEJ8BNvItRqU82lFNLnf5GdW6h9z+v+iR476Bx6cmhFE19XpXDjD5CxA8hibkyfpDQ20BWNcclZzCvnZs=
X-Received: by 2002:a05:6512:ba1:b0:498:9890:1bb4 with SMTP id
 b33-20020a0565120ba100b0049898901bb4mr5933554lfv.122.1663597934468; Mon, 19
 Sep 2022 07:32:14 -0700 (PDT)
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
 <CAAhV-H67dgV_M2RW37wh_=aA8dr=f_nSbdab3sQPKUvDKws+xQ@mail.gmail.com>
 <CAMj1kXEWJ9TbhWRTiqFDtHr36dhkc1RfyL8ft06uDsN08x6eYA@mail.gmail.com>
 <CAAhV-H5BQAWFAT2vRZxO8L=pU0X5hGD-vHpyRVK0k7UKaLJJpQ@mail.gmail.com>
 <CAMj1kXEpFiRORzz=qQ5oCAUAgSDyCnf8p5Hb=NuMYMVcKfNYqw@mail.gmail.com> <CAAhV-H584umex2jcSBju3ZjqDELBQWpna8A6QxRYBDvvvueHGw@mail.gmail.com>
In-Reply-To: <CAAhV-H584umex2jcSBju3ZjqDELBQWpna8A6QxRYBDvvvueHGw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Sep 2022 16:32:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGgV+Ucb=0076-9PBFWeL-1W6-XAFD3BK=miiZK6ddwPg@mail.gmail.com>
Message-ID: <CAMj1kXGgV+Ucb=0076-9PBFWeL-1W6-XAFD3BK=miiZK6ddwPg@mail.gmail.com>
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

On Mon, 19 Sept 2022 at 16:25, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Mon, Sep 19, 2022 at 8:27 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 19 Sept 2022 at 14:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > On Mon, Sep 19, 2022 at 8:11 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Mon, 19 Sept 2022 at 13:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > >
> > > > > On Mon, Sep 19, 2022 at 7:21 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, 19 Sept 2022 at 13:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 19, 2022 at 6:49 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 19 Sept 2022 at 12:47, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Sep 19, 2022 at 6:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, 19 Sept 2022 at 12:33, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi, Ard,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Sep 19, 2022 at 2:22 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, 19 Sept 2022 at 08:06, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > >  Hi, Ard,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, Sep 19, 2022 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, 19 Sept 2022 at 03:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi, Ard,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I think the parameters passed to the core kernel need to be discussed.
> > > > > > > > > > > > > > > The old way (so-called old world):
> > > > > > > > > > > > > > > a0=argc, a1=argv, a1=bpi
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The current way (so-called new world):
> > > > > > > > > > > > > > > a0=efi boot flag, a1=fdt pointer
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The new way (in this patchset):
> > > > > > > > > > > > > > > a0=efi boot flag, a1=systemtable, a2=cmdline
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I prefer to use the current way, there are 3 reasons:
> > > > > > > > > > > > > > > 1, both acpi system and dt system can use the same parameters passing method;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > DT systems will use this too. The distinction is between EFI boot and
> > > > > > > > > > > > > > non-EFI boot. We *really* should keep these separate, given the
> > > > > > > > > > > > > > experience on ARM, where other projects invent ways to pass those
> > > > > > > > > > > > > > values to the kernel without going through the stub.
> > > > > > > > > > > > > In the last patch I see:
> > > > > > > > > > > > > +               void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               early_init_dt_scan(fdt_ptr);
> > > > > > > > > > > > > +               early_init_fdt_reserve_self();
> > > > > > > > > > > > > +
> > > > > > > > > > > > >                 clear_bit(EFI_BOOT, &efi.flags);
> > > > > > > > > > > > > So I suppose for the DT system that means a0=efi boot flag, a1=fdt
> > > > > > > > > > > > > pointer, a2=cmdline? Then it is not exactly the same as the ACPI
> > > > > > > > > > > > > system, but similar.
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > No, for non-EFI DT boot, the command line is passed via the DT, so
> > > > > > > > > > > > a0=0x0 (non-efi), a1=DT, a2=0x0
> > > > > > > > > > > >
> > > > > > > > > > > > Do you intend to support non-EFI DT boot by the way?
> > > > > > > > > > > I think we needn't support non-EFI DT boot, so a0=efi boot flag,
> > > > > > > > > > > a1=systemtable, a2=cmdline is just OK (or maybe we can exchange a1/a2,
> > > > > > > > > > > which looks similar to the old-world).
> > > > > > > > > >
> > > > > > > > > > Excellent. If non-EFI boot is not supported, we can drop the code that
> > > > > > > > > > deals with that.
> > > > > > > > > >
> > > > > > > > > > > But I have another question: is
> > > > > > > > > > > it early enough to get DT from systemtable for DT boot (in the current
> > > > > > > > > > > way DT is the earliest thing)?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > If you rely on DT only for the hardware description, then loading it
> > > > > > > > > > from efi_init() should be fine.
> > > > > > > > > OK, then please drop patch #12 at this time. It can be added when we
> > > > > > > > > add Loongson-2K support.
> > > > > > > > >
> > > > > > > >
> > > > > > > > OK
> > > > > > > >
> > > > > > > > > > > > I don't think it makes sense to allow efi=novamap on LoongArch, given
> > > > > > > > > > > > that we cannot make use of the runtime services that way. So in my
> > > > > > > > > > > > code, efi_novamap is set to false unconditionally.
> > > > > > > > > > > Emm, I prefer to support "efi=novamap", the core kernel has already
> > > > > > > > > > > supported "noefi" to disable runtime, I don't want to hack
> > > > > > > > > > > efi_novamap. So please keep the efi boot flag, thanks.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Fair enough. Do you have any uses for efi_novamap in mind?
> > > > > > > > > I usually use "efi=novamap" in EFI shell to see whether it can work
> > > > > > > > > well without runtime. And I think I will modify this patch these days
> > > > > > > > > because in another thread you said that this series cannot boot.
> > > > > > > >
> > > > > > > > It works fine now.
> > > > > > > >
> > > > > > > > However, clearing the EFI_BOOT flag is not the correct way to disable
> > > > > > > > runtime services only. And note that we also have efi=noruntime - does
> > > > > > > > that currently work on LoongArch?
> > > > > > > OK, but we don't need to add a new "efi=noruntime" parameter, I can
> > > > > > > use "noefi" instead.
> > > > > >
> > > > > > OK
> > > > > >
> > > > > > > But I think support "efi=novamap" is not a bad
> > > > > > > idea (maybe I misunderstood its usage).
> > > > > > >
> > > > > >
> > > > > > It basically exists to deal with broken EFI firmware on ARM laptops
> > > > > > that were only intended to run Windows. Windows calls
> > > > > > SetVirtualAddressMap() *after* creating the new mappings, and some
> > > > > > broken firmware drivers will access those regions too early.
> > > > > >
> > > > > > On Linux, we install the mapping first, and then much later, we
> > > > > > actually create the mappings and only activate them on a single CPU
> > > > > > while the EFI runtime service call is in progress.
> > > > > >
> > > > > > In any case, I will reinstate the efi_novamap logic for now - we can
> > > > > > always revisit it later.
> > > > > OK, now I think there are no big problems. Only some bikesheddings:
> > > > > 1, Please use "a0=efi boot flag, a1=cmdline a2=systemtable" to pass
> > > > > boot information, it looks most similar to the old-world, and we can
> > > > > distinguish old-world/new-world by judging whether a0 is greater than
> > > > > 1.
> > > > > 2, I prefer "early return" in efi_init, i.e., if (boot_memmap ==
> > > > > EFI_INVALID_TABLE_ADDR) then return immediately, this makes
> > > > > indentation look better.
> > > > > 3, Declare "cmdline" out of the if() condition in init_environ() looks better.
> > > > > 4, I prefer "kernel_addr" rather than "image_addr" in efi_boot_kernel().
> > > > > 5, It seems that one line is enough for the last statement in efi_boot_kernel().
> > > > >
> > > >
> > > > OK
> > > >
> > > > > Hope this series will be stable as soon as possible, our kexec/kdump
> > > > > work needs to adjust because of this change. :)
> > > > >
> > > >
> > > > Do you have a link to those patches?
> > > There is a snapshot for patches pending for 6.1:
> > > https://github.com/loongson/linux/commits/loongarch-next
> >
> > Thanks. I already spotted an issue there which is exactly the kind of
> > thing I am trying to avoid with this series.
> >
> > diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
> > index 7423361b0ebc9b..c68c88e40cc0b9 100644
> > --- a/arch/loongarch/kernel/mem.c
> > +++ b/arch/loongarch/kernel/mem.c
> > @@ -61,4 +62,9 @@ void __init memblock_init(void)
> >
> >   /* Reserve the initrd */
> >   reserve_initrd_mem();
> > +
> > + /* Main reserved memory for the elf core head */
> > + early_init_fdt_scan_reserved_mem();
> > + /* Parse linux,usable-memory-range for crash dump kernel */
> > + early_init_dt_check_for_usable_mem_range();
> >  }
> >
> > So here, we are adding support for DT memory reservations, which kdump
> > apparently needs.
> >
> > However, this parsing of the DT not only happens on kexec boot: all
> > ACPI and DT kernels will now honour FDT memory reservations passed in
> > via a DT when booting the first kernel, and external projects may use
> > this and start to depend on this.
> >
> > Once something like this hits the upstream kernel, it is *very*
> > difficult to change or remove.
> >
> > If you only need to pass the usable memory range for kcrash/kdump,
> > it's probably better to use a command line option for that, instead of
> > relying on DT memory reservations.
> Thank you for your suggestion, but we found some trouble when handle
> initrd in kexec.
> In current implementation, we generate a fdt in kexec-tools, then fill
> "linux,usable-memory-range", "linux,elfcorehdr" and initrd information
> in it. After this series, we can use "mem=xxx" "elfcorehdr=" in
> cmdline, but how to handle initrd information which is stored in a
> system table?
>

There are two options:
- use initrdmem= on the command line
- update the INITRD config table in memory (i.e., update the base and
size to refer to the new initrd image)
