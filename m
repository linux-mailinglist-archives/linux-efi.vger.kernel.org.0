Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBEB6CB81B
	for <lists+linux-efi@lfdr.de>; Tue, 28 Mar 2023 09:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjC1HdF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Mar 2023 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC1Hc7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Mar 2023 03:32:59 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7383C3D
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 00:32:37 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5445009c26bso214142557b3.8
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679988747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eBTos7X10Y0870qbpas9et3vT+slIy6BhF9oNfQCnk=;
        b=nLDLk2ye4UTPtIGNPs5cUOrzZaQomNh5Rc6TsP/QOzyRik6B0FPpj7umY6O2kh32VW
         5EsmuqCWQuq3lDuJ7DfeMMz3UzR+OJ6aPRU7BTXHrJce78aCIQqLjtHwXxY834kVMWgI
         ZJ4ocJYAttDml08FJBma0SMH+SyVIDTbsGD1bOlKF2dsStmUb23r4TFHe7SdBRrAFXbF
         PP7wYsz/KmAstb63Iil3edzr/fu+qe2Sew4pqChEtBopMMcpEpVdNI1rd/Z+PlrUnNkX
         88qYJs9QxfQ/fdCaCStnxTJmpvXIBkgBkoGyODRQ0DTv6LBn5BtpmkagOG4sHPwe0R7c
         RmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eBTos7X10Y0870qbpas9et3vT+slIy6BhF9oNfQCnk=;
        b=bXyygNsmWjbyOqf1l88jNjyyX8nvO9fSjvohmhlIyjW4yzSShrC3ki1qfHTJws4Ux2
         YP+3USKIdSpGt1CNors5d0iv8iVzwDMAYd/ZePZ4fkcN8vGZ6lazHqAG2mntF0MLWQRX
         pdF5fFCZrMlKijCcJgeL463qsbb0UVTElVPYzvfBYTkvuV6j8ndykxpA5DcQ2HG+O6XI
         JNKKSzkmZlmIFIXO8z24a/hNgOHnAVD6CFS40NkyHfKVxvUEm/qeCYLyleS8u7Twyyhx
         CbuUcTWdm7SaiuiWq1vHkQovrTgLFJEtZQdjdYlurDFma25VWvWUK59wfhXdaBw2PPtw
         3TOQ==
X-Gm-Message-State: AAQBX9dPvC/vvTBHDK0djvPMu32eKvqy9fTAePDS/Xm/wRfvdz+uUEgi
        b3dzXk4FLh+ChKmaKTweKKDobP1ww7y4qV+jOQ==
X-Google-Smtp-Source: AKy350Ywk4m6tmfyY6DeyC+IS7Pwq4lNGIvzGDRom1JA6bs7R5smz/4nAiI/1I9YKu1WFc5K9+DRPALR6zmEX0QDOXo=
X-Received: by 2002:a81:b387:0:b0:545:5f92:f7ee with SMTP id
 r129-20020a81b387000000b005455f92f7eemr6518924ywh.2.1679988746827; Tue, 28
 Mar 2023 00:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230327095123.20023-1-kernelfans@gmail.com> <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 28 Mar 2023 15:32:15 +0800
Message-ID: <CAFgQCTuc7yshP8gUJ4XzRR23R5HqoQ02qkA_cvXJM9BXMXLsUw@mail.gmail.com>
Subject: Re: [PATCH] efi: zboot: Ensure zboot PIC
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 27, 2023 at 6:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Mon, 27 Mar 2023 at 11:51, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > Using objcopy to reform vmlinuz.efi.elf to vmlinuz.efi will not convey
> > any relocation information. That means vmlinuz.efi is expected to be
> > PIC.
> >
> > At present, vmlinuz.efi is PIC. But it is better to adopt the same
>
> Why is it better?
>

I think except carefully coded with asm language, there is no
guarantee which prevents the compiler from generating position
dependent code.  Or is there any presumption here?

> > solution used by the kernel to resolve the code relocation issue by
> > itself. That is to resolve R_AARCH64_RELATIVE at the runtime.
> >
>
> This breaks other architectures.
>

Oops, could it be done by:
#if defined(_aarch64_)
#define R_ARCH_RELATIVE R_AARCH64_RELATIVE
#else
#define R_ARCH_RELATIVE 0
#endif

Since any r_type equaling 0 can not be ejected into the relocation
section, this macro will make the code dummy in essential.

Thanks,

    Pingfan

> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > To: linux-efi@vger.kernel.org
>
>
> > ---
> >  drivers/firmware/efi/libstub/Makefile       |  2 +-
> >  drivers/firmware/efi/libstub/Makefile.zboot |  2 +-
> >  drivers/firmware/efi/libstub/zboot-entry.S  | 35 +++++++++++++++++++++
> >  drivers/firmware/efi/libstub/zboot.c        |  2 +-
> >  drivers/firmware/efi/libstub/zboot.lds      |  6 ++++
> >  5 files changed, 44 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/firmware/efi/libstub/zboot-entry.S
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/e=
fi/libstub/Makefile
> > index 80d85a5169fb..4447395d7218 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -95,7 +95,7 @@ lib-$(CONFIG_LOONGARCH)               +=3D loongarch.=
o loongarch-stub.o
> >  CFLAGS_arm32-stub.o            :=3D -DTEXT_OFFSET=3D$(TEXT_OFFSET)
> >
> >  zboot-obj-$(CONFIG_RISCV)      :=3D lib-clz_ctz.o lib-ashldi3.o
> > -lib-$(CONFIG_EFI_ZBOOT)                +=3D zboot.o $(zboot-obj-y)
> > +lib-$(CONFIG_EFI_ZBOOT)                +=3D zboot-entry.o zboot.o $(zb=
oot-obj-y)
> >
> >  extra-y                                :=3D $(lib-y)
> >  lib-y                          :=3D $(patsubst %.o,%.stub.o,$(lib-y))
> > diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firm=
ware/efi/libstub/Makefile.zboot
> > index 43e9a4cab9f5..1ed948cee92f 100644
> > --- a/drivers/firmware/efi/libstub/Makefile.zboot
> > +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> > @@ -36,7 +36,7 @@ $(obj)/zboot-header.o: $(srctree)/drivers/firmware/ef=
i/libstub/zboot-header.S FO
> >
> >  ZBOOT_DEPS :=3D $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/=
libstub/lib.a
> >
> > -LDFLAGS_vmlinuz.efi.elf :=3D -T $(srctree)/drivers/firmware/efi/libstu=
b/zboot.lds
> > +LDFLAGS_vmlinuz.efi.elf :=3D  --no-undefined -X -shared -Bsymbolic -z =
notext --no-apply-dynamic-relocs -T $(srctree)/drivers/firmware/efi/libstub=
/zboot.lds
> >  $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
> >         $(call if_changed,ld)
> >
> > diff --git a/drivers/firmware/efi/libstub/zboot-entry.S b/drivers/firmw=
are/efi/libstub/zboot-entry.S
> > new file mode 100644
> > index 000000000000..072207f2f6ba
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/zboot-entry.S
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include <asm/elf.h>
> > +#define ZBOOT_HEADER_BASE 0
> > +
> > +       .text
> > +/*
> > + * x0: efi_handle_t
> > + * x1: efi_system_table_t *
> > + */
> > +       .global efi_zboot_entry
> > +efi_zboot_entry:
> > +       adrp    x2, efi_zboot_header
> > +       add     x2, x2, :lo12:efi_zboot_header
> > +       mov     x3, ZBOOT_HEADER_BASE
> > +       sub     x3, x2, x3              // delta between actual and lin=
ked address
> > +       adrp    x4, _rela_start
> > +       add     x4, x4, :lo12:_rela_start
> > +       adrp    x5, _rela_end
> > +       add     x5, x5, :lo12:_rela_end
> > +
> > +0:     cmp     x5, x4
> > +       b.hs    1f
> > +       ldp     x6, x7, [x4], #24
> > +       ldr     x8, [x4, #-8]
> > +       cmp     w7, #R_AARCH64_RELATIVE
> > +       b.ne    0b
> > +       add     x8, x8, x3
> > +       str     x8, [x6, x3]
> > +       b       0b
> > +
> > +1:
> > +       dsb     ishst
> > +       ic      iallu
> > +       b       efi_zboot_main
> > diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/ef=
i/libstub/zboot.c
> > index ba234e062a1a..7aa6b2e6d104 100644
> > --- a/drivers/firmware/efi/libstub/zboot.c
> > +++ b/drivers/firmware/efi/libstub/zboot.c
> > @@ -58,7 +58,7 @@ void __weak efi_cache_sync_image(unsigned long image_=
base,
> >  }
> >
> >  asmlinkage efi_status_t __efiapi
> > -efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
> > +efi_zboot_main(efi_handle_t handle, efi_system_table_t *systab)
> >  {
> >         unsigned long compressed_size =3D _gzdata_end - _gzdata_start;
> >         unsigned long image_base, alloc_size, code_size;
> > diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/=
efi/libstub/zboot.lds
> > index 93d33f68333b..631942604c3f 100644
> > --- a/drivers/firmware/efi/libstub/zboot.lds
> > +++ b/drivers/firmware/efi/libstub/zboot.lds
> > @@ -12,6 +12,12 @@ SECTIONS
> >                 *(.text* .init.text*)
> >         }
> >
> > +       .rela.dyn : ALIGN(8) {
> > +               __efistub__rela_start =3D .;
> > +               *(.rela .rela*)
> > +               __efistub__rela_end =3D .;
> > +       }
> > +
> >         .rodata : ALIGN(8) {
> >                 __efistub__gzdata_start =3D .;
> >                 *(.gzdata)
> > --
> > 2.31.1
> >
