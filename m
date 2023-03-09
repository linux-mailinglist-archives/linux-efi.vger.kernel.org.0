Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61886B2C92
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCISDg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 13:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCISDf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 13:03:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482552F7A
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 10:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F269E61B33
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 18:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD30C4339B
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678385013;
        bh=USoZWQXX82Lppr6+DEpLafVxGpGdTS7QaX5sRwRzo6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bPIOHUeXku9L208PLMQ6Y8k8mVXhMl3cF18YARL7OLwR69JynRKQBSfXyyYqlnDTc
         8e5LingyRXBQ+sbmPN+5DNhP2/i+5pnSRTODGt4RBNNRm9KOosInuNG6u/ChCYUz6U
         vSJYKfgSldFbzK6zs5J+EGE0D+ORqNKBzpvcDJa+rMYSgaC34SlWliECXiRAIasi/E
         1LbfSsalTmCrxTCuuuLhpK8uqe7HEu+3OKn7v7vTWcYieFDtAjlrru6TJw4IqoKmuM
         aayx+vYMMT8r5WGCfnbHCC1Zo/Wzt7C5lkHZScn/l3KXbUfJMhESSd8ZfdzAHgrRNR
         QqlCjB63cQ4+Q==
Received: by mail-lf1-f51.google.com with SMTP id i28so3439919lfv.0
        for <linux-efi@vger.kernel.org>; Thu, 09 Mar 2023 10:03:33 -0800 (PST)
X-Gm-Message-State: AO0yUKXQ5LAueel55s0PRVRoqs3fp++17iaorqrsBZM5nFsviFa0ho5Q
        60mh9gyQGZyKeBUSB14YFnOiIY0Vfg0MSUuXptY=
X-Google-Smtp-Source: AK7set+zJrYyFbQCH2zwwWHtA9SqtXXdXOMokIbKBAaWnqcUnDNEmb8qCJetyXzoE6CtTsxwAe69v0D7dzrvTQy2fG4=
X-Received: by 2002:ac2:539c:0:b0:4d5:ca42:e43b with SMTP id
 g28-20020ac2539c000000b004d5ca42e43bmr7249803lfh.4.1678385011384; Thu, 09 Mar
 2023 10:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20230308202209.2980947-1-ardb@kernel.org> <20230308202209.2980947-5-ardb@kernel.org>
 <7665e476c2e6ba6f89d85ad87735ff38@ispras.ru>
In-Reply-To: <7665e476c2e6ba6f89d85ad87735ff38@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Mar 2023 19:03:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFOgYCtx0C+Xqiv+SaUUrjyjEcYSqAt=1wRWA5m=ZZa-g@mail.gmail.com>
Message-ID: <CAMj1kXFOgYCtx0C+Xqiv+SaUUrjyjEcYSqAt=1wRWA5m=ZZa-g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] efi: x86: Split PE/COFF .text section into .text
 and .data
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Mar 2023 at 19:02, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-08 23:22, Ard Biesheuvel wrote:
> > Modern PE loader implementations used by EFI will honour the PE section
> > permission attributes, and so we can use them to avoid mappings that
> > are
> > writable and executable at the same time.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/header.S      | 17 ++++++++++++++++
> >  arch/x86/boot/tools/build.c | 21 +++++++++++++++-----
> >  2 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > index 4f1e1791cda4d316..a8ff8bbb17bca7d7 100644
> > --- a/arch/x86/boot/header.S
> > +++ b/arch/x86/boot/header.S
> > @@ -253,6 +253,23 @@ section_table:
> >               IMAGE_SCN_MEM_READ              | \
> >               IMAGE_SCN_MEM_EXECUTE           # Characteristics
> >
> > +     .ascii  ".data"
> > +     .byte   0
> > +     .byte   0
> > +     .byte   0
> > +     .long   0
> > +     .long   0x0                             # startup_{32,64}
> > +     .long   0                               # Size of initialized data
> > +                                             # on disk
> > +     .long   0x0                             # startup_{32,64}
> > +     .long   0                               # PointerToRelocations
> > +     .long   0                               # PointerToLineNumbers
> > +     .word   0                               # NumberOfRelocations
> > +     .word   0                               # NumberOfLineNumbers
> > +     .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> > +             IMAGE_SCN_MEM_READ              | \
> > +             IMAGE_SCN_MEM_WRITE             # Characteristics
> > +
> >       .set    section_count, (. - section_table) / 40
> >  #endif /* CONFIG_EFI_STUB */
> >
> > diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> > index 883e6359221cd588..b449c82feaadf2b8 100644
> > --- a/arch/x86/boot/tools/build.c
> > +++ b/arch/x86/boot/tools/build.c
> > @@ -119,6 +119,7 @@ static unsigned long efi_boot_params;
> >  static unsigned long kernel_info;
> >  static unsigned long startup_64;
> >  static unsigned long _ehead;
> > +static unsigned long _data;
> >  static unsigned long _end;
> >
> >
> > /*----------------------------------------------------------------------*/
> > @@ -347,10 +348,15 @@ static unsigned int
> > update_pecoff_sections(unsigned int text_start, unsigned int
> >       init_sz += CONFIG_PHYSICAL_ALIGN;
> >
> >       /*
> > -      * Size of code: Subtract the size of the first sector (512 bytes)
> > -      * which includes the header.
> > +      * Size of code: the size of the combined .text/.rodata section,
> > which
> > +      * ends at the _data marker symbol.
> >        */
> > -     put_unaligned_le32(text_sz + bss_sz, &hdr->text_size);
> > +     put_unaligned_le32(_data, &hdr->text_size);
> > +
> > +     /*
> > +      * Size of data: the size of the combined .data/.bss section.
> > +      */
> > +     put_unaligned_le32(text_sz - _data + bss_sz, &hdr->data_size);
> >
> >       /* Size of image */
> >       put_unaligned_le32(init_sz, &hdr->image_size);
> > @@ -360,9 +366,13 @@ static unsigned int
> > update_pecoff_sections(unsigned int text_start, unsigned int
> >        */
> >       put_unaligned_le32(text_start + efi_pe_entry, &hdr->entry_point);
> >
> > -     update_pecoff_section_header_fields(".text", text_start, text_sz +
> > bss_sz,
> > -                                         text_sz, text_start);
> > +     update_pecoff_section_header_fields(".text", text_start, _data,
> > +                                         _data, text_start);
> >
> > +     update_pecoff_section_header_fields(".data", text_start + _data,
> > +                                         text_sz - _data + bss_sz,
> > +                                         text_sz - _data,
> > +                                         text_start + _data);
> >       return text_start + file_sz;
> >  }
> >
> > @@ -455,6 +465,7 @@ static void parse_zoffset(char *fname)
> >               PARSE_ZOFS(p, kernel_info);
> >               PARSE_ZOFS(p, startup_64);
> >               PARSE_ZOFS(p, _ehead);
> > +             PARSE_ZOFS(p, _data);
>
> This also requires _data to be fetched to zoffset.h:
>

Indeed - I'd fixed that locally but failed to include it in the patch,
apologies.

> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 8203f1a23f7a..0e5a18c3c165 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>
>   SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
>
> -sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z]
> \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|efi_boot_params\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define
> ZO_\2 0x\1/p'
> +sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z]
> \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|efi_boot_params\|input_data\|kernel_info\|_end\|_ehead\|_text\|_data\|z_.*\)$$/\#define
> ZO_\2 0x\1/p'
>
>   quiet_cmd_zoffset = ZOFFSET $@
>         cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
>
> >               PARSE_ZOFS(p, _end);
> >
> >               p = strchr(p, '\n');
