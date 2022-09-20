Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25615BD999
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 03:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiITBpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiITBpW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 21:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A6B48E9F
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 18:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 748A7621CD
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 01:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF6AC433D6
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 01:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663638317;
        bh=dNI5Tyuza9Rw8kK0EAtwuQskvri/F9Np8hbx+P/xVRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FWdHuGuV4YKxSX9sl3XJJcVXFuS/0KFRnLzsU59J+jmzrxUA0CV86TXX4QxaRxjwo
         eqq05KTnahK1l7DmDdhPYHsLMfxsGEdDJaxIFh7s5Wkvaj12kr2DgMlV8Zagd464CF
         oRH0+xIwSX3kKf1I9ZRA3+VRT075OWZ6qudoAuRlbC/ZOjjBTBanQMEwiE/8NjBLdA
         dOhjO7BmZ1Fu8vV+mVORgqN92G8V8xQnkNyyD7ceq6n09QfNR9qTk5b4cwsIkYoa3W
         bWy7wJ4tgLssLJZ9O/aEiUOqh5XYSbpRXRIra7z2b+a8rh0NM6xA+O4RTwYTbLpQyk
         XKJjpib57ha1w==
Received: by mail-vs1-f52.google.com with SMTP id o123so1540061vsc.3
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 18:45:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf050jGLmxc3eZU2LDA4fNJnYpCT9HLB2xUtRVQbTAcuZ/2jjMTv
        Gckb/DhbRVz4so8MlShwOknNPaPxWBDs5H2vRbM=
X-Google-Smtp-Source: AMsMyM5IR83UtzY96o478A5Q00LlDV3mCnRAtF2oRR1OOqQjPwkFvj1GDsrdJIymo0PBzkqaYLPxh730WdOvp2rXx1Q=
X-Received: by 2002:a05:6102:3d05:b0:398:7dce:8492 with SMTP id
 i5-20020a0561023d0500b003987dce8492mr7225655vsv.43.1663638316730; Mon, 19 Sep
 2022 18:45:16 -0700 (PDT)
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
 <CAMj1kXEpFiRORzz=qQ5oCAUAgSDyCnf8p5Hb=NuMYMVcKfNYqw@mail.gmail.com>
 <CAAhV-H584umex2jcSBju3ZjqDELBQWpna8A6QxRYBDvvvueHGw@mail.gmail.com>
 <CAMj1kXGgV+Ucb=0076-9PBFWeL-1W6-XAFD3BK=miiZK6ddwPg@mail.gmail.com>
 <CAAhV-H5gtw1tb040mV8o=P=5onfTZwDEVm1tTooWLOW-kyHAMw@mail.gmail.com>
 <CAMj1kXGWLAJqf3fmqPm9JWTC06i=t2fhZi2_Tfjh40rtUQLwXg@mail.gmail.com>
 <CAAhV-H5iy1GC+JXGeSh0EPQ=TT9m_oFKMknk-7JSpQ-0HdK9Rw@mail.gmail.com> <CAMj1kXF=aGFktg1jGq4mN_73ko3j-jt4=Xc1xAR0jWx_OT0tVw@mail.gmail.com>
In-Reply-To: <CAMj1kXF=aGFktg1jGq4mN_73ko3j-jt4=Xc1xAR0jWx_OT0tVw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 20 Sep 2022 09:44:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5SVOwz9uM-SC_iDH2juGMhNEGMxd6j6itDsQhRENoBCw@mail.gmail.com>
Message-ID: <CAAhV-H5SVOwz9uM-SC_iDH2juGMhNEGMxd6j6itDsQhRENoBCw@mail.gmail.com>
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

Hi, Ard,

On Mon, Sep 19, 2022 at 11:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 19 Sept 2022 at 17:09, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Mon, Sep 19, 2022 at 10:44 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 19 Sept 2022 at 16:43, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > On Mon, Sep 19, 2022 at 10:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Mon, 19 Sept 2022 at 16:25, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > >
> > > > > > Hi, Ard,
> > > > > >
> > > > > > On Mon, Sep 19, 2022 at 8:27 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, 19 Sept 2022 at 14:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 19, 2022 at 8:11 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 19 Sept 2022 at 13:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Sep 19, 2022 at 7:21 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 19 Sept 2022 at 13:15, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Sep 19, 2022 at 6:49 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, 19 Sept 2022 at 12:47, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, Sep 19, 2022 at 6:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, 19 Sept 2022 at 12:33, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi, Ard,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Mon, Sep 19, 2022 at 2:22 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Mon, 19 Sept 2022 at 08:06, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >  Hi, Ard,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Mon, Sep 19, 2022 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Mon, 19 Sept 2022 at 03:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi, Ard,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I think the parameters passed to the core kernel need to be discussed.
> > > > > > > > > > > > > > > > > > > > The old way (so-called old world):
> > > > > > > > > > > > > > > > > > > > a0=argc, a1=argv, a1=bpi
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > The current way (so-called new world):
> > > > > > > > > > > > > > > > > > > > a0=efi boot flag, a1=fdt pointer
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > The new way (in this patchset):
> > > > > > > > > > > > > > > > > > > > a0=efi boot flag, a1=systemtable, a2=cmdline
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I prefer to use the current way, there are 3 reasons:
> > > > > > > > > > > > > > > > > > > > 1, both acpi system and dt system can use the same parameters passing method;
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > DT systems will use this too. The distinction is between EFI boot and
> > > > > > > > > > > > > > > > > > > non-EFI boot. We *really* should keep these separate, given the
> > > > > > > > > > > > > > > > > > > experience on ARM, where other projects invent ways to pass those
> > > > > > > > > > > > > > > > > > > values to the kernel without going through the stub.
> > > > > > > > > > > > > > > > > > In the last patch I see:
> > > > > > > > > > > > > > > > > > +               void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +               early_init_dt_scan(fdt_ptr);
> > > > > > > > > > > > > > > > > > +               early_init_fdt_reserve_self();
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > >                 clear_bit(EFI_BOOT, &efi.flags);
> > > > > > > > > > > > > > > > > > So I suppose for the DT system that means a0=efi boot flag, a1=fdt
> > > > > > > > > > > > > > > > > > pointer, a2=cmdline? Then it is not exactly the same as the ACPI
> > > > > > > > > > > > > > > > > > system, but similar.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > No, for non-EFI DT boot, the command line is passed via the DT, so
> > > > > > > > > > > > > > > > > a0=0x0 (non-efi), a1=DT, a2=0x0
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Do you intend to support non-EFI DT boot by the way?
> > > > > > > > > > > > > > > > I think we needn't support non-EFI DT boot, so a0=efi boot flag,
> > > > > > > > > > > > > > > > a1=systemtable, a2=cmdline is just OK (or maybe we can exchange a1/a2,
> > > > > > > > > > > > > > > > which looks similar to the old-world).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Excellent. If non-EFI boot is not supported, we can drop the code that
> > > > > > > > > > > > > > > deals with that.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > But I have another question: is
> > > > > > > > > > > > > > > > it early enough to get DT from systemtable for DT boot (in the current
> > > > > > > > > > > > > > > > way DT is the earliest thing)?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If you rely on DT only for the hardware description, then loading it
> > > > > > > > > > > > > > > from efi_init() should be fine.
> > > > > > > > > > > > > > OK, then please drop patch #12 at this time. It can be added when we
> > > > > > > > > > > > > > add Loongson-2K support.
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > OK
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I don't think it makes sense to allow efi=novamap on LoongArch, given
> > > > > > > > > > > > > > > > > that we cannot make use of the runtime services that way. So in my
> > > > > > > > > > > > > > > > > code, efi_novamap is set to false unconditionally.
> > > > > > > > > > > > > > > > Emm, I prefer to support "efi=novamap", the core kernel has already
> > > > > > > > > > > > > > > > supported "noefi" to disable runtime, I don't want to hack
> > > > > > > > > > > > > > > > efi_novamap. So please keep the efi boot flag, thanks.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Fair enough. Do you have any uses for efi_novamap in mind?
> > > > > > > > > > > > > > I usually use "efi=novamap" in EFI shell to see whether it can work
> > > > > > > > > > > > > > well without runtime. And I think I will modify this patch these days
> > > > > > > > > > > > > > because in another thread you said that this series cannot boot.
> > > > > > > > > > > > >
> > > > > > > > > > > > > It works fine now.
> > > > > > > > > > > > >
> > > > > > > > > > > > > However, clearing the EFI_BOOT flag is not the correct way to disable
> > > > > > > > > > > > > runtime services only. And note that we also have efi=noruntime - does
> > > > > > > > > > > > > that currently work on LoongArch?
> > > > > > > > > > > > OK, but we don't need to add a new "efi=noruntime" parameter, I can
> > > > > > > > > > > > use "noefi" instead.
> > > > > > > > > > >
> > > > > > > > > > > OK
> > > > > > > > > > >
> > > > > > > > > > > > But I think support "efi=novamap" is not a bad
> > > > > > > > > > > > idea (maybe I misunderstood its usage).
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > It basically exists to deal with broken EFI firmware on ARM laptops
> > > > > > > > > > > that were only intended to run Windows. Windows calls
> > > > > > > > > > > SetVirtualAddressMap() *after* creating the new mappings, and some
> > > > > > > > > > > broken firmware drivers will access those regions too early.
> > > > > > > > > > >
> > > > > > > > > > > On Linux, we install the mapping first, and then much later, we
> > > > > > > > > > > actually create the mappings and only activate them on a single CPU
> > > > > > > > > > > while the EFI runtime service call is in progress.
> > > > > > > > > > >
> > > > > > > > > > > In any case, I will reinstate the efi_novamap logic for now - we can
> > > > > > > > > > > always revisit it later.
> > > > > > > > > > OK, now I think there are no big problems. Only some bikesheddings:
> > > > > > > > > > 1, Please use "a0=efi boot flag, a1=cmdline a2=systemtable" to pass
> > > > > > > > > > boot information, it looks most similar to the old-world, and we can
> > > > > > > > > > distinguish old-world/new-world by judging whether a0 is greater than
> > > > > > > > > > 1.
> > > > > > > > > > 2, I prefer "early return" in efi_init, i.e., if (boot_memmap ==
> > > > > > > > > > EFI_INVALID_TABLE_ADDR) then return immediately, this makes
> > > > > > > > > > indentation look better.
> > > > > > > > > > 3, Declare "cmdline" out of the if() condition in init_environ() looks better.
> > > > > > > > > > 4, I prefer "kernel_addr" rather than "image_addr" in efi_boot_kernel().
> > > > > > > > > > 5, It seems that one line is enough for the last statement in efi_boot_kernel().
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > OK
> > > > > > > > >
> > > > > > > > > > Hope this series will be stable as soon as possible, our kexec/kdump
> > > > > > > > > > work needs to adjust because of this change. :)
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Do you have a link to those patches?
> > > > > > > > There is a snapshot for patches pending for 6.1:
> > > > > > > > https://github.com/loongson/linux/commits/loongarch-next
> > > > > > >
> > > > > > > Thanks. I already spotted an issue there which is exactly the kind of
> > > > > > > thing I am trying to avoid with this series.
> > > > > > >
> > > > > > > diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
> > > > > > > index 7423361b0ebc9b..c68c88e40cc0b9 100644
> > > > > > > --- a/arch/loongarch/kernel/mem.c
> > > > > > > +++ b/arch/loongarch/kernel/mem.c
> > > > > > > @@ -61,4 +62,9 @@ void __init memblock_init(void)
> > > > > > >
> > > > > > >   /* Reserve the initrd */
> > > > > > >   reserve_initrd_mem();
> > > > > > > +
> > > > > > > + /* Main reserved memory for the elf core head */
> > > > > > > + early_init_fdt_scan_reserved_mem();
> > > > > > > + /* Parse linux,usable-memory-range for crash dump kernel */
> > > > > > > + early_init_dt_check_for_usable_mem_range();
> > > > > > >  }
> > > > > > >
> > > > > > > So here, we are adding support for DT memory reservations, which kdump
> > > > > > > apparently needs.
> > > > > > >
> > > > > > > However, this parsing of the DT not only happens on kexec boot: all
> > > > > > > ACPI and DT kernels will now honour FDT memory reservations passed in
> > > > > > > via a DT when booting the first kernel, and external projects may use
> > > > > > > this and start to depend on this.
> > > > > > >
> > > > > > > Once something like this hits the upstream kernel, it is *very*
> > > > > > > difficult to change or remove.
> > > > > > >
> > > > > > > If you only need to pass the usable memory range for kcrash/kdump,
> > > > > > > it's probably better to use a command line option for that, instead of
> > > > > > > relying on DT memory reservations.
> > > > > > Thank you for your suggestion, but we found some trouble when handle
> > > > > > initrd in kexec.
> > > > > > In current implementation, we generate a fdt in kexec-tools, then fill
> > > > > > "linux,usable-memory-range", "linux,elfcorehdr" and initrd information
> > > > > > in it. After this series, we can use "mem=xxx" "elfcorehdr=" in
> > > > > > cmdline, but how to handle initrd information which is stored in a
> > > > > > system table?
> > > > > >
> > > > >
> > > > > There are two options:
> > > > > - use initrdmem= on the command line
> > > > This is not a good way, even if the second kernel handle "initrdmem=",
> > > > it will conflict with the config table.
> > > >
> > >
> > > It will not conflict - initrdmem= supersedes the INITRD table because
> > > early param passing happens after efi_init().
> > >
> > > > > - update the INITRD config table in memory (i.e., update the base and
> > > > > size to refer to the new initrd image)
> > > > This way seems practicable, but we don't know how to handle it in
> > > > kexec-tools. :(
> > > >
> > >
> > > Good point. Let me think a bit about this.
> > OK, then let's go back to this series itself. :)
> >
> > I have seen the latest code in your git repo, I don't think we need
> > efi_disable_rt. Instead, setting/clearing EFI_BOOT according to a0 as
> > before seems reasonable.
> >
>
> No, not really. EFI_BOOT basically means 'did I boot via EFI?' and
> strictly, you should not be attempting to access the EFI system table
> or parse EFI config tables unless EFI_BOOT is true.
>
> Deviating from this makes it more difficult for generic code to reason
> about what parts of EFI are active on a given system.
>
> > If efi_novamap breaks something, I can accept "set efi_novamap to
> > false" in the previous version, or just ignore its value in the
> > efistub, but a0 should clearly be the indicator of EFI_BOOT.
> >
>
> I'm fine with keeping efi_novamap if you think it has a value. To me,
> it seems rather pointless, because it prevents you from using the
> runtime services.
>
> If you want a0 to control the EFI boot flag, you should find another
> way to control whether runtime services can be used, because they are
> really two different things.
I'm very sorry, after an offline discussion with my colleagues,
non-EFI DT boot is still needed (very sadly, we want to drop non-EFI
firmware but we can't do that). However, for non-EFI DT boot we will
use the same parameter passing method (a0=efi boot flag, a1=cmdline,
a2=systemtable), firmware will generate a simple systemtable only for
DT. In this way all boot methods share the same logic, and also make
kexec easy to implement.

So, let's make a0 the real "efi boot flag" and let it control
EFI_BOOT, for efistub, we can just pass "true" unconditionally
(whether support efi_novamap is not as important as the efi boot flag
for us, as you said, efi_novamap is just for broken firmware).

Huacai
