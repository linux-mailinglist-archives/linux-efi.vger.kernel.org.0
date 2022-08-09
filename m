Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975A958D59F
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiHIIq2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbiHIIqS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:46:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210022286
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57406B80E11
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F74C43470
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660034775;
        bh=OTZ8/JwjQqwzyMYwa7jslxXAyseBM4QxNjPCRrabTEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vb92JwLlt1xTfLseeoADrsjl+oEaA5z4b8xjx7GyGbGfIC5b4sCG817lu/SkTUcRi
         6Q3nfKffyOg1J/qUvrWHCqKtkCXUW6GyO9reyDfSWJ+pxgI1nKmhWGvy8buR2YczNU
         Vn6savZpqrcm1RP+srllVZZSGnbNmOmvEvYmze7iMsDtWnGju6sMdPODY5Xcz69bU4
         HQrBUYOPR3tH6eEzO8n8I/sPsehmgVm7i6TTQDZdT0p8W+lgNKmbL+18A+tOXjo1VN
         WOZ027EAda+FWrWESQ8fg9V4F6jitLbySRwZfeFFVgWIP3uWclmS405fOEeKUY6/Dg
         Iqho+G4HpGcHg==
Received: by mail-wr1-f45.google.com with SMTP id z12so13515797wrs.9
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 01:46:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo0k0ww9O1tkclDbWq3RR8wso4C8m9GNVKQiePl+d5EXeE71OTK2
        fW7yQcyKtLFH2llLeTlE4l6FbuTFVvvQhf0hqW8=
X-Google-Smtp-Source: AA6agR5ZkEb0RAyVdP+oMDvO3PQoZBaTZheBMd/goKRNO2Q+cqqDfFPm1KwcdhAyN1yWG17ppp+cOTQHE3I4AB/3utU=
X-Received: by 2002:a05:6000:186f:b0:222:c091:9c59 with SMTP id
 d15-20020a056000186f00b00222c0919c59mr8272802wri.78.1660034773199; Tue, 09
 Aug 2022 01:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220809080944.1119654-1-ardb@kernel.org> <28a84915-7fa0-7691-08e7-69db792979c7@canonical.com>
In-Reply-To: <28a84915-7fa0-7691-08e7-69db792979c7@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Aug 2022 10:46:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHLw419xpULVP5wZUW0fnAz0ovJ+RmkFFdDGtUmNM2wSQ@mail.gmail.com>
Message-ID: <CAMj1kXHLw419xpULVP5wZUW0fnAz0ovJ+RmkFFdDGtUmNM2wSQ@mail.gmail.com>
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

On Tue, 9 Aug 2022 at 10:38, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/9/22 10:09, Ard Biesheuvel wrote:
> > Relatively modern architectures such as arm64 or RISC-V don't implement
> > a self-decompressing kernel, and leave it up to the bootloader to
> > decompress the compressed image before executing it. For bare metal
> > boot, this policy makes sense, as a self-decompressing image essentially
> > duplicates a lot of fiddly preparation work to create a 1:1 mapping and
> > set up the C runtime, and to discover or infer where DRAM lives from
> > device trees or other firmware tables.
> >
> > For EFI boot, the situation is a bit different: the EFI entrypoint is
> > called with a 1:1 cached mapping covering all of DRAM already active,
> > and with a stack, a heap, a memory map and boot services to load and
> > start images. This means it is rather trivial to implement a
> > self-decompressing wrapper for EFI boot in a generic manner, and reuse
> > it across architectures that implement EFI boot.
> >
> > The only slight downside is that when UEFI secure boot is enabled, the
> > generic LoadImage/StartImage only allow signed images to be loaded and
> > started, and we prefer to avoid the need to sign both the inner and
> > outer PE/COFF images. This series adopts the EFI shim approach, i.e., to
> > override an internal UEFI/PI protocol that is used by the image loader,
> > to allow the inner image to be booted after decompression. This has been
>
> We should avoid requiring anything that is not in the UEFI
> specification. If you have any additional requirements, please, create a
> change request for the UEFI specification.
>

As I have explained numerous times before, the EFI spec was intended
to be extensible (hence the 'E'). The ACPI, SMBIOS and TCG specs all
augment the EFI specification by defining protocols, GUIDs and other
things that are only relevant in a EFI context, but none of those are
covered by the EFI spec itself.

> Overriding the services of the system table is dangerous and should be
> avoided.
>

Agreed. But this is not what is happening here.

> There is no need for two UEFI binaries one inside the other and we
> should avoid such overengineering.
>

I disagree. Using an EFI app to encapsulate another one is the only
generic way to go about this, as far as I can tell.

> Today we append an uncompressed kernel to the EFI stub. The stub
> relocates it, sets up the memory map and calls it entry point.
>

Not exactly. On arm64 as well as RISC-V, the EFI stub and the kernel
proper are essentially the same executable image.

> Just add decompressor code to the EFI stub and instead of appending an
> uncompressed kernel append a compressed one. Then sign a binary
> consisting of the EFI stub and the compressed kernel.
>

Yes, this would be a cleaner approach, although it would require more
re-engineering of the EFI stub, in particular, it would require
cloning more code, and adding additional build and link steps.

> This way you don't need any change to UEFI firmware at all and you don't
> need to override UEFI services.
>
> Another reasonable approach would be to zip the signed UEFI binary (EFI
> stub with uncompressed kernel) and let the UEFI firmware unzip it and
> check the signature of the decompressed UEFI binary. This would not
> require any patch in Linux at all and would be simple to implement in
> U-Boot.
>

This is how it works today. One problem with this is that the image
needs to be decompressed in order to sign it, or verify its signature.
In general, having compression at the outside like this is fiddly
because it is no longer a PE/COFF image, and the EFI spec only reasons
about PE/COFF images as executable images. So we'd need to change the
UEFI spec or the PE/COFF spec.
