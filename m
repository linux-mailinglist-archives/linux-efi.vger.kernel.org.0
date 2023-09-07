Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2365797BA2
	for <lists+linux-efi@lfdr.de>; Thu,  7 Sep 2023 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjIGSWW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Sep 2023 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjIGSWF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Sep 2023 14:22:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE9A1;
        Thu,  7 Sep 2023 11:22:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BB3C3278A;
        Thu,  7 Sep 2023 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694094288;
        bh=/OVUfzDp4Xrk04AuhCWrPrCSSYysDp+76lOBSLs7QAY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dK7kJJoJDugC1umsl2LyMqRHpfNLFg1ODJMVQ2KVo7ElBQlDvMXaq/ayUKEIwqun9
         abmEEeJQdi39m9rKOFzQTmj46er5xlCEtQy7DhZ/8UPllBWeluIv2tHH1soLMUcHa5
         beUXjpywPfna1UeS6T/h2iZUQomZeJ/6ymn+T0j6k0Xi8syCTi+/RdxI5pHxpiAtCf
         nDWWRU7WB23GQ7y/WtWVFEfE89v43QMjqxaHyke/fb/VZ/Gdrt88Hljo0Uxzy9eyVn
         GCztCgddem1L+RZfp342AfPzWZpBu9Tw6tdfaY8zOm5av2l7VE0E6JAXxd2s5Ka0Td
         3zemXCtHfB55w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5008faf4456so1618449e87.3;
        Thu, 07 Sep 2023 06:44:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxT7GB7cu1P72xjej6PewGsB2ChUWqQzgJIBPZii8lN9wlKnUgD
        AwPYLQF7zHMPZCP6pGGrToh/bwaRrH/RvyS647g=
X-Google-Smtp-Source: AGHT+IEN9THZbUbfOjvw8QWsthDcHarkRsqofbzn2/8JnFB7hKNt3JSr+VUqqRpHaWGaEwP/nd+nfCz/yxgyKANE0Hk=
X-Received: by 2002:a05:6512:3b95:b0:501:bee7:487b with SMTP id
 g21-20020a0565123b9500b00501bee7487bmr6016781lfv.11.1694094286129; Thu, 07
 Sep 2023 06:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230818134422.380032-16-ardb@kernel.org> <98D635CA-43D4-4A0B-8791-2FDC1DC695B3@posteo.de>
In-Reply-To: <98D635CA-43D4-4A0B-8791-2FDC1DC695B3@posteo.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Sep 2023 15:44:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGhM+jqL8fZjjrPeoaC7Qc5tRDfRmmia5x-UVpB-uH_Xw@mail.gmail.com>
Message-ID: <CAMj1kXGhM+jqL8fZjjrPeoaC7Qc5tRDfRmmia5x-UVpB-uH_Xw@mail.gmail.com>
Subject: Re: [PATCH 15/17] x86/boot: Split off PE/COFF .data section
To:     =?UTF-8?Q?Marvin_H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Aug 2023 at 16:35, Marvin H=C3=A4user <mhaeuser@posteo.de> wrote=
:
>
> Hi Ard,
>
> Thanks for your effort! Not sure what the documentation policies are, but=
 might it be worth mentioning that we cannot have .rdata at this time, beca=
use current-gen EFI will map it as RW?
>

Yeah I'll mention this in the next version.


> Best regards,
> Marvin
>
> > On Aug 18, 2023, at 15:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> > =EF=BB=BFDescribe the code and data of the decompressor binary using se=
parate
> > .text and .data PE/COFF sections, so that we will be able to map them
> > using restricted permissions once we increase the section and file
> > alignment sufficiently. This avoids the need for memory mappings that
> > are writable and executable at the same time, which is something that
> > is best avoided for security reasons.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > arch/x86/boot/Makefile |  2 +-
> > arch/x86/boot/header.S | 19 +++++++++++++++----
> > 2 files changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> > index b26e30a2d865f72d..50c50fce646e2417 100644
> > --- a/arch/x86/boot/Makefile
> > +++ b/arch/x86/boot/Makefile
> > @@ -90,7 +90,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
> >
> > SETUP_OBJS =3D $(addprefix $(obj)/,$(setup-y))
> >
> > -sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._=
stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_t=
ext\|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> > +sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._=
stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_t=
ext\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> >
> > quiet_cmd_zoffset =3D ZOFFSET $@
> >       cmd_zoffset =3D $(NM) $< | sed -n $(sed-zoffset) > $@
> > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > index ccfb7a7d8c29275e..25dda40dacb52292 100644
> > --- a/arch/x86/boot/header.S
> > +++ b/arch/x86/boot/header.S
> > @@ -79,9 +79,9 @@ optional_header:
> >    .byte    0x02                # MajorLinkerVersion
> >    .byte    0x14                # MinorLinkerVersion
> >
> > -    .long    setup_size + ZO__end - 0x200    # SizeOfCode
> > +    .long    ZO__data            # SizeOfCode
> >
> > -    .long    0                # SizeOfInitializedData
> > +    .long    ZO__end - ZO__data        # SizeOfInitializedData
> >    .long    0                # SizeOfUninitializedData
> >
> >    .long    setup_size + ZO_efi_pe_entry    # AddressOfEntryPoint
> > @@ -182,9 +182,9 @@ section_table:
> >    .byte    0
> >    .byte    0
> >    .byte    0
> > -    .long    ZO__end
> > +    .long    ZO__data
> >    .long    setup_size
> > -    .long    ZO__edata            # Size of initialized data
> > +    .long    ZO__data            # Size of initialized data
> >                        # on disk
> >    .long    setup_size
> >    .long    0                # PointerToRelocations
> > @@ -195,6 +195,17 @@ section_table:
> >        IMAGE_SCN_MEM_READ        | \
> >        IMAGE_SCN_MEM_EXECUTE        # Characteristics
> >
> > +    .ascii    ".data\0\0\0"
> > +    .long    ZO__end - ZO__data        # VirtualSize
> > +    .long    setup_size + ZO__data        # VirtualAddress
> > +    .long    ZO__edata - ZO__data        # SizeOfRawData
> > +    .long    setup_size + ZO__data        # PointerToRawData
> > +
> > +    .long    0, 0, 0
> > +    .long    IMAGE_SCN_CNT_INITIALIZED_DATA    | \
> > +        IMAGE_SCN_MEM_READ        | \
> > +        IMAGE_SCN_MEM_WRITE        # Characteristics
> > +
> >    .set    section_count, (. - section_table) / 40
> > #endif /* CONFIG_EFI_STUB */
> >
> > --
> > 2.39.2
>
