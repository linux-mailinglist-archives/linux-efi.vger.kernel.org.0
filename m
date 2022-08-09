Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA44C58D604
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 11:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiHIJKz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiHIJKv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 05:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F32BDE
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 02:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC11860B85
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 09:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF0EC43140
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660036250;
        bh=ypeEPcDHO+Ql1Bm64K6nXNAha1Khynz6VpZNx86zmsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sIK3ymzCXAIVsEAUXrNtymgfPMKah35CVii/dzpGuPW4H+uIrylb+AjKMsYGnJVR+
         MCfUVZJUL2h3rDWvywhB+Z6Q4A7tPKVDevLFCo5ya7YDR32XYSTLpPtTYmaAUPYCf3
         +9Wh90VU9Zgh/CM321YhqhVXHF9g94Ouokh9plN4DzseLult+AV55lHalLolCrIuxa
         HTR5j7L82inB6vh7XHz86RdoAXycrnAbgoj7VDAUI1kbDg5lupscuw91yTN439oSl8
         oZbwbu/0cUR/c9b9kav0Ci50Qo6/3Q/ZgjyDbM+jIL3u/5DCucF5rwBBz8X0q33jWU
         SGNDYNQGBVMrg==
Received: by mail-wr1-f52.google.com with SMTP id l4so13557682wrm.13
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 02:10:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo3/9NTmAK9MdiEsWpPoHnh/3aprcYSo3Smd/qqe/pakxJg6ClPl
        TwlwCdyC8cwXHuXldReLinvmrIIpVgSFH2MKHd0=
X-Google-Smtp-Source: AA6agR7qnAoFPzfgnuCS5kQD+6nWjUaQQJDZObPqFLPRsGR/k4ymbtp6EAvgTAh2ZIf3L4rSD9n+0UFfWvkDIB0Adok=
X-Received: by 2002:a5d:64a6:0:b0:21f:b3b:5cc9 with SMTP id
 m6-20020a5d64a6000000b0021f0b3b5cc9mr12912429wrp.601.1660036248203; Tue, 09
 Aug 2022 02:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220809080944.1119654-1-ardb@kernel.org> <28a84915-7fa0-7691-08e7-69db792979c7@canonical.com>
 <CAMj1kXHLw419xpULVP5wZUW0fnAz0ovJ+RmkFFdDGtUmNM2wSQ@mail.gmail.com> <ca0a22d9-d80c-836d-9b04-fa9d3e2c79c0@canonical.com>
In-Reply-To: <ca0a22d9-d80c-836d-9b04-fa9d3e2c79c0@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Aug 2022 11:10:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHPvc3UoWzsVhm03JDE5LN+xc_tKsSiFu0gOzNfEd2zTg@mail.gmail.com>
Message-ID: <CAMj1kXHPvc3UoWzsVhm03JDE5LN+xc_tKsSiFu0gOzNfEd2zTg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] efi: implement generic compressed boot support
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 9 Aug 2022 at 11:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/9/22 10:46, Ard Biesheuvel wrote:
> > On Tue, 9 Aug 2022 at 10:38, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 8/9/22 10:09, Ard Biesheuvel wrote:
> >>> Relatively modern architectures such as arm64 or RISC-V don't implement
> >>> a self-decompressing kernel, and leave it up to the bootloader to
> >>> decompress the compressed image before executing it. For bare metal
> >>> boot, this policy makes sense, as a self-decompressing image essentially
> >>> duplicates a lot of fiddly preparation work to create a 1:1 mapping and
> >>> set up the C runtime, and to discover or infer where DRAM lives from
> >>> device trees or other firmware tables.
> >>>
> >>> For EFI boot, the situation is a bit different: the EFI entrypoint is
> >>> called with a 1:1 cached mapping covering all of DRAM already active,
> >>> and with a stack, a heap, a memory map and boot services to load and
> >>> start images. This means it is rather trivial to implement a
> >>> self-decompressing wrapper for EFI boot in a generic manner, and reuse
> >>> it across architectures that implement EFI boot.
> >>>
> >>> The only slight downside is that when UEFI secure boot is enabled, the
> >>> generic LoadImage/StartImage only allow signed images to be loaded and
> >>> started, and we prefer to avoid the need to sign both the inner and
> >>> outer PE/COFF images. This series adopts the EFI shim approach, i.e., to
> >>> override an internal UEFI/PI protocol that is used by the image loader,
> >>> to allow the inner image to be booted after decompression. This has been
> >>
> >> We should avoid requiring anything that is not in the UEFI
> >> specification. If you have any additional requirements, please, create a
> >> change request for the UEFI specification.
> >>
> >
> > As I have explained numerous times before, the EFI spec was intended
> > to be extensible (hence the 'E'). The ACPI, SMBIOS and TCG specs all
> > augment the EFI specification by defining protocols, GUIDs and other
> > things that are only relevant in a EFI context, but none of those are
> > covered by the EFI spec itself.
> >
> >> Overriding the services of the system table is dangerous and should be
> >> avoided.
> >>
> >
> > Agreed. But this is not what is happening here.
> >
> >> There is no need for two UEFI binaries one inside the other and we
> >> should avoid such overengineering.
> >>
> >
> > I disagree. Using an EFI app to encapsulate another one is the only
> > generic way to go about this, as far as I can tell.
>
> Please, elaborate why the inner compressed binary needs to be UEFI to
> boot into Linux while currently we don't need a an uncompressed inner
> UEFI binary.
>

If the inner binary is not EFI / PE/COFF, there is no generic way to
boot it. Every architecture has its own rules of how this needs to be
implemented.

> >
> >> Today we append an uncompressed kernel to the EFI stub. The stub
> >> relocates it, sets up the memory map and calls it entry point.
> >>
> >
> > Not exactly. On arm64 as well as RISC-V, the EFI stub and the kernel
> > proper are essentially the same executable image.
>
> Currently on ARM and RISC-V you have a file with two entry points:
>
> * EFI stub
> * legacy entry point
>
> The EFI stub calls the legacy entry point. In the EFI case some part of
> the EFI stub lives on at runtime. The same pointers passed to the legacy
> entry point could also be passed to a decompressed legacy kernel.
>

Nit: no part of the EFI stub lives on at runtime, but that is beside the point.

You are right that the EFI stub could be logically disjoint from the
payload, and so it could theoretically decompress its payload before
starting it.

> The EFI stub and the kernel should be completely separate binaries. Then
> you just need the cp command to join them.
>

It is not that simple, unfortunately. The EFI stub on arm64 and RISC-V
refers to many ELF symbols directly, and so splitting those images
requires some intrusive build system changes.

> >
> >> Just add decompressor code to the EFI stub and instead of appending an
> >> uncompressed kernel append a compressed one. Then sign a binary
> >> consisting of the EFI stub and the compressed kernel.
> >>
> >
> > Yes, this would be a cleaner approach, although it would require more
> > re-engineering of the EFI stub, in particular, it would require
> > cloning more code, and adding additional build and link steps.
>
> If this is the cleanest approach, we should go for it.
>

That is a fair point. Unfortunately, it will no longer be generic, and
each architecture will have to implement this individually.
