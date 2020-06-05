Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40E1EF15C
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFEGdf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 02:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEGdf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 02:33:35 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB6A207F7;
        Fri,  5 Jun 2020 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591338814;
        bh=OyA0SPdScgbcmUmLNB1wHj6mmcj7lB0EY3tbkA7rHB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GcrwA40+pCfJEgqHhw/H6BJWQfIkY/Pflgt2kw8G2LE21WYN61OKVqMbQ2RyreY9y
         Dn8EePdZvUu5U45bOdWxRhPok/y3j/zTXMyXbm98UcQGj/i2I1IG/XIzeGRR/qaUhm
         Uylkbd6xg5d7CemDK5JN0KQXjsLXcLmysnP00jmI=
Received: by mail-oi1-f176.google.com with SMTP id p70so7314875oic.12;
        Thu, 04 Jun 2020 23:33:34 -0700 (PDT)
X-Gm-Message-State: AOAM530fgUSiqvuhYLqzSX4iMumxCG1n80YclCnE2WdzKAfJbV2scIfw
        YVRV2ogx2QXA/GvCex2HgWXNzneDPNUXh1Gshms=
X-Google-Smtp-Source: ABdhPJxIcXiCQoQNMIxa1oDKCzFpm8Ra4nnADMDyHj9KIW1QIH13VaPG2u51XM8ZpTyBvm2z4U2aC2pN7RJCyla40iM=
X-Received: by 2002:aca:b707:: with SMTP id h7mr1057058oif.174.1591338813378;
 Thu, 04 Jun 2020 23:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-6-nivedita@alum.mit.edu> <20200605003134.GA95743@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200605003134.GA95743@rdna-mbp.dhcp.thefacebook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Jun 2020 08:33:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
Message-ID: <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
Subject: Re: [PATCH 05/24] efi/libstub: Optimize for size instead of speed
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Andrey,

On Fri, 5 Jun 2020 at 02:31, Andrey Ignatov <rdna@fb.com> wrote:
>
> Arvind Sankar <nivedita@alum.mit.edu> [Wed, 1969-12-31 23:00 -0800]:
> > Reclaim the bloat from the addition of printf by optimizing the stub for
> > size. With gcc 9, the text size of the stub is:
> >
> > ARCH    before  +printf    -Os
> > arm      35197    37889  34638
> > arm64    34883    38159  34479
> > i386     18571    21657  17025
> > x86_64   25677    29328  22144
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  drivers/firmware/efi/libstub/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index fb34c9d14a3c..034d71663b1e 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -7,7 +7,7 @@
> >  #
> >  cflags-$(CONFIG_X86_32)              := -march=i386
> >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
> > -cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
> > +cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ \
> >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
> >                                  -mno-mmx -mno-sse -fshort-wchar \
> >                                  -Wno-pointer-sign \
> > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> > -KBUILD_CFLAGS                        := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
> > +KBUILD_CFLAGS                        := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
> >                                  -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
> >                                  -D__NO_FORTIFY \
> >                                  $(call cc-option,-ffreestanding) \
>
> Hi Arvind,
>
> This patch breaks build for me:
>
> $>make -j32 -s bzImage
> drivers/firmware/efi/libstub/alignedmem.c: In function \x2018efi_allocate_pages_aligned\x2019:
> drivers/firmware/efi/libstub/alignedmem.c:38:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
>   status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
>          ^

Which version of GCC are you using?


> In file included from drivers/firmware/efi/libstub/alignedmem.c:6:0:
> drivers/firmware/efi/libstub/efistub.h:49:64: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
>  #define efi_bs_call(func, ...) efi_system_table->boottime->func(__VA_ARGS__)
>                                                                 ^
> drivers/firmware/efi/libstub/alignedmem.c:50:4: note: in expansion of macro \x2018efi_bs_call\x2019
>     efi_bs_call(free_pages, alloc_addr, slack - l + 1);
>     ^
> drivers/firmware/efi/libstub/alignedmem.c:50: confused by earlier errors, bailing out
> In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:19:0:
> drivers/firmware/efi/libstub/efi-stub-helper.c: In function \x2018efi_char16_puts\x2019:
> drivers/firmware/efi/libstub/efistub.h:52:51: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
>  #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
>                                                    ^
> drivers/firmware/efi/libstub/efi-stub-helper.c:37:2: note: in expansion of macro \x2018efi_call_proto\x2019
>   efi_call_proto(efi_table_attr(efi_system_table, con_out),
>   ^
> drivers/firmware/efi/libstub/efi-stub-helper.c:37: confused by earlier errors, bailing out
> drivers/firmware/efi/libstub/file.c: In function \x2018handle_cmdline_files\x2019:
> drivers/firmware/efi/libstub/file.c:73:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
>   status = efi_bs_call(handle_protocol, image->device_handle, &fs_proto,
>          ^
> drivers/firmware/efi/libstub/file.c:73: confused by earlier errors, bailing out
> Preprocessed source stored into /tmp/ccc4T4FI.out file, please attach this to your bugreport.
> make[5]: *** [drivers/firmware/efi/libstub/alignedmem.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> drivers/firmware/efi/libstub/gop.c: In function \x2018efi_setup_gop\x2019:
> drivers/firmware/efi/libstub/gop.c:565:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
>   status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>          ^
> drivers/firmware/efi/libstub/gop.c:565: confused by earlier errors, bailing out
> Preprocessed source stored into /tmp/ccgQG7p4.out file, please attach this to your bugreport.
> make[5]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 1
> Preprocessed source stored into /tmp/ccnqGnqG.out file, please attach this to your bugreport.
> make[5]: *** [drivers/firmware/efi/libstub/file.o] Error 1
> Preprocessed source stored into /tmp/ccle7n2N.out file, please attach this to your bugreport.
> make[5]: *** [drivers/firmware/efi/libstub/gop.o] Error 1
> make[4]: *** [drivers/firmware/efi/libstub] Error 2
> make[3]: *** [drivers/firmware/efi] Error 2
> make[2]: *** [drivers/firmware] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
>
> Either reverting the patch or disabling CONFIG_EFI_STUB fixes it.
>
> Initially I found it on bpf/bpf-next HEAD but same happens on
> torvalds/linux.
>
> I attach the config I used.
>
> --
> Andrey Ignatov
