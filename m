Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20D61EF8B9
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgFENOX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFENOX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Jun 2020 09:14:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6037C08C5C2;
        Fri,  5 Jun 2020 06:14:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z1so8385535qtn.2;
        Fri, 05 Jun 2020 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IT+O1en9ajm4h/0bA78mh/qTFH2R4012BCps6CYwJ7Y=;
        b=Th0/T9Uh8Di2JQdlUnRSqYBXiCATzWobgwdULkCKsJuBY93eDMJ2lhoutJQJDEEcCm
         9hV2SaKZFyDcNpABLxcZXmcc0ncD2H4O+7RguxwMOr6BwtP2Iq73yUgBsOk2YVZBXAuI
         bQMUiaqlzdMzHZrC9Ut+zaVKCCg8Y2wGsS9do9CB9KLaxbpm0Wku/7qeaLbeKn8Ph1Te
         eUGNaqsBp2GRN942O0yE7SmwUT8UsiL6RwKKnPbdoRCTQWjNmsvTZTSVhYAC6BuKBh3X
         chNMkSs+CZxxDhQt5wtQE5s9hvhK69MAS2awzrdX7dDFVpcwMFfHZP9ZERwgsrmeJFnz
         sclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IT+O1en9ajm4h/0bA78mh/qTFH2R4012BCps6CYwJ7Y=;
        b=MlM4UgNT4OKBlh+ZANsGDobcaW4ulTxD+ZZAPsBRfKsFqUHbvFU6M2ZJzjNW5G1KeI
         srSInqr6fXWnykElv0UEGPFKURhxJkW9zc3UIbkSknKMzcWIj34Lg0dGAYvrwjZA9U3e
         nRiZSI6gwbaVr6xJVo6ZQ4TcmwDHyu5t/blDOwQf3xfuKtMUPuXwPFvrPl3n4PfMNy1M
         o2DsmwaS13OFOwFdoY7QRu1NG5fnyIQt+dJXul0LXwEWkroEGL9z8uHvjRzw1L6b33OJ
         moueusudIhN8hZsS+ioAfO3e5dQnPgC0ht43hJnOz4ljpP8ayzeUnMqJtgdF24id2/IN
         4Eiw==
X-Gm-Message-State: AOAM531GKUxuG3xFh+kWuCto2unFwQTOvP5E3KUjLt1AGzerMhH95QBE
        LtOFjOJHdwGM4UcbZyBHfL8=
X-Google-Smtp-Source: ABdhPJygk7BM6cSBayEwlckEM1TSKj7EZDuX1ulnxFip1Dzy1heWaLATzj0Eq8gAtdgZusUlEnP29A==
X-Received: by 2002:ac8:7252:: with SMTP id l18mr9582690qtp.71.1591362861831;
        Fri, 05 Jun 2020 06:14:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h19sm6976040qkl.49.2020.06.05.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:14:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 5 Jun 2020 09:14:19 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andrey Ignatov <rdna@fb.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 05/24] efi/libstub: Optimize for size instead of speed
Message-ID: <20200605131419.GA560594@rani.riverdale.lan>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-6-nivedita@alum.mit.edu>
 <20200605003134.GA95743@rdna-mbp.dhcp.thefacebook.com>
 <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 05, 2020 at 08:33:22AM +0200, Ard Biesheuvel wrote:
> Hello Andrey,
> 
> On Fri, 5 Jun 2020 at 02:31, Andrey Ignatov <rdna@fb.com> wrote:
> >
> > Arvind Sankar <nivedita@alum.mit.edu> [Wed, 1969-12-31 23:00 -0800]:
> > > Reclaim the bloat from the addition of printf by optimizing the stub for
> > > size. With gcc 9, the text size of the stub is:
> > >
> > > ARCH    before  +printf    -Os
> > > arm      35197    37889  34638
> > > arm64    34883    38159  34479
> > > i386     18571    21657  17025
> > > x86_64   25677    29328  22144
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > ---
> > >  drivers/firmware/efi/libstub/Makefile | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index fb34c9d14a3c..034d71663b1e 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -7,7 +7,7 @@
> > >  #
> > >  cflags-$(CONFIG_X86_32)              := -march=i386
> > >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
> > > -cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
> > > +cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ \
> > >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
> > >                                  -mno-mmx -mno-sse -fshort-wchar \
> > >                                  -Wno-pointer-sign \
> > > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >
> > >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > >
> > > -KBUILD_CFLAGS                        := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
> > > +KBUILD_CFLAGS                        := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
> > >                                  -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
> > >                                  -D__NO_FORTIFY \
> > >                                  $(call cc-option,-ffreestanding) \
> >
> > Hi Arvind,
> >
> > This patch breaks build for me:
> >
> > $>make -j32 -s bzImage
> > drivers/firmware/efi/libstub/alignedmem.c: In function \x2018efi_allocate_pages_aligned\x2019:
> > drivers/firmware/efi/libstub/alignedmem.c:38:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
> >   status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
> >          ^
> 
> Which version of GCC are you using?

gcc-4.8.5 from the config. I got a copy and can reproduce it. Just
adding -maccumulate-outgoing-args appears to fix it, checking some more.

> 
> 
> > In file included from drivers/firmware/efi/libstub/alignedmem.c:6:0:
> > drivers/firmware/efi/libstub/efistub.h:49:64: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
> >  #define efi_bs_call(func, ...) efi_system_table->boottime->func(__VA_ARGS__)
> >                                                                 ^
> > drivers/firmware/efi/libstub/alignedmem.c:50:4: note: in expansion of macro \x2018efi_bs_call\x2019
> >     efi_bs_call(free_pages, alloc_addr, slack - l + 1);
> >     ^
> > drivers/firmware/efi/libstub/alignedmem.c:50: confused by earlier errors, bailing out
> > In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:19:0:
> > drivers/firmware/efi/libstub/efi-stub-helper.c: In function \x2018efi_char16_puts\x2019:
> > drivers/firmware/efi/libstub/efistub.h:52:51: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
> >  #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
> >                                                    ^
> > drivers/firmware/efi/libstub/efi-stub-helper.c:37:2: note: in expansion of macro \x2018efi_call_proto\x2019
> >   efi_call_proto(efi_table_attr(efi_system_table, con_out),
> >   ^
> > drivers/firmware/efi/libstub/efi-stub-helper.c:37: confused by earlier errors, bailing out
> > drivers/firmware/efi/libstub/file.c: In function \x2018handle_cmdline_files\x2019:
> > drivers/firmware/efi/libstub/file.c:73:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
> >   status = efi_bs_call(handle_protocol, image->device_handle, &fs_proto,
> >          ^
> > drivers/firmware/efi/libstub/file.c:73: confused by earlier errors, bailing out
> > Preprocessed source stored into /tmp/ccc4T4FI.out file, please attach this to your bugreport.
> > make[5]: *** [drivers/firmware/efi/libstub/alignedmem.o] Error 1
> > make[5]: *** Waiting for unfinished jobs....
> > drivers/firmware/efi/libstub/gop.c: In function \x2018efi_setup_gop\x2019:
> > drivers/firmware/efi/libstub/gop.c:565:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
> >   status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> >          ^
> > drivers/firmware/efi/libstub/gop.c:565: confused by earlier errors, bailing out
> > Preprocessed source stored into /tmp/ccgQG7p4.out file, please attach this to your bugreport.
> > make[5]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 1
> > Preprocessed source stored into /tmp/ccnqGnqG.out file, please attach this to your bugreport.
> > make[5]: *** [drivers/firmware/efi/libstub/file.o] Error 1
> > Preprocessed source stored into /tmp/ccle7n2N.out file, please attach this to your bugreport.
> > make[5]: *** [drivers/firmware/efi/libstub/gop.o] Error 1
> > make[4]: *** [drivers/firmware/efi/libstub] Error 2
> > make[3]: *** [drivers/firmware/efi] Error 2
> > make[2]: *** [drivers/firmware] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [drivers] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [sub-make] Error 2
> >
> > Either reverting the patch or disabling CONFIG_EFI_STUB fixes it.
> >
> > Initially I found it on bpf/bpf-next HEAD but same happens on
> > torvalds/linux.
> >
> > I attach the config I used.
> >
> > --
> > Andrey Ignatov
