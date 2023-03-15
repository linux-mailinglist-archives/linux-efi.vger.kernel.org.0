Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAAA6BA400
	for <lists+linux-efi@lfdr.de>; Wed, 15 Mar 2023 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCOAXP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCOAXN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 20:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E348D7697;
        Tue, 14 Mar 2023 17:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DEDC6187A;
        Wed, 15 Mar 2023 00:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E08FC433D2;
        Wed, 15 Mar 2023 00:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678839789;
        bh=2QQtgRrccTkaMZwdVpBo0tfL90iRhmvFQT37IuFiBsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ltmCjBMrn1C8dN8MNPeAvRxt3xzd6oXzFu9AbPOEDZcVfV7jeKieCIif1oHdl7vD8
         sTeXz6pcFHOfc3C2YZhlfjPaMHnfoEiMs/GnTEP10VWvaEuY6E2afIFZEjxW0uD5gi
         mQI3RPWOh9YuRrW7bIXaPOoVPgW7AnlokSR9MOdQWhHbeaaNppvCAZDOzLPDKUTASO
         mEOdRhO1Q0sTq+6N+LXXO8btFYY9Vx0HFdZrApHH6C9ahuAIi6AB3utQ7ljcKTHl3j
         NOD/rryBnZXXAA5w04sumbjJIKFmaqO3+fblU4ThF0EAOOaQ6soiISp/k9xQvy3+0R
         Cbte/H4aYm4Vw==
Received: by mail-ed1-f51.google.com with SMTP id x3so69062586edb.10;
        Tue, 14 Mar 2023 17:23:09 -0700 (PDT)
X-Gm-Message-State: AO0yUKX5hvF+qX/ijrVB/+0zblRgBH+zXgg0EVQ8S91BINOMTL7V3Bza
        hSjNLK8ugHlpx1xLAWBpbMddCs4l5hxma2LRoGg=
X-Google-Smtp-Source: AK7set8CeexM23o3h1SN2bR6jNRNAm0u6quChI4QXKxm0fMZXTsGg6kab1YcgQpmoRtPvQUwhLyDrcuPqQZqcA3cTMI=
X-Received: by 2002:a17:906:4c9a:b0:8b2:d871:d74a with SMTP id
 q26-20020a1709064c9a00b008b2d871d74amr2112085eju.10.1678839787663; Tue, 14
 Mar 2023 17:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230310021749.921041-1-chenhuacai@loongson.cn> <CAMj1kXHHVxM2YGQ9Ytdf=nEB6CU9GHSDgek+V2SghYh5Aq-uSg@mail.gmail.com>
In-Reply-To: <CAMj1kXHHVxM2YGQ9Ytdf=nEB6CU9GHSDgek+V2SghYh5Aq-uSg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 15 Mar 2023 08:22:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7RmHkN3XYYzKZZa1dm8c6b16XgQGYo5ZQvuZSkGRetKA@mail.gmail.com>
Message-ID: <CAAhV-H7RmHkN3XYYzKZZa1dm8c6b16XgQGYo5ZQvuZSkGRetKA@mail.gmail.com>
Subject: Re: [PATCH V2] efi/libstub: Call setup_graphics() before handle_kernel_image()
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, linux-efi@vger.kernel.org,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 15, 2023 at 6:31=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 10 Mar 2023 at 03:18, Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Commit 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint
> > into separate file") moves setup_graphics() into efi_stub_common() whic=
h
> > is after handle_kernel_image(). This causes efifb no longer work becaus=
e
> > handle_kernel_image() may move the core kernel to its preferred address=
,
> > which means the screen_info filled by the efistub will not be the same
> > as the one accessed by the core kernel. So let us call setup_graphics()
> > before handle_kernel_image() which restores the old behavior.
> >
> > The side effect is zboot will not call setup_graphics(), but I think
> > zboot doesn't need it either.
> >
> > Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint =
into separate file")
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Please drop this patch from the loonarch tree - it is causing a
> conflict in linux-next.
OK, will do.

Huacai
>
>
> > ---
> > V2: Use static declaration for setup_graphics() to avoid build warnings=
.
> >
> >  drivers/firmware/efi/libstub/efi-stub-entry.c | 29 +++++++++++++++++++
> >  drivers/firmware/efi/libstub/efi-stub.c       | 27 -----------------
> >  2 files changed, 29 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/fi=
rmware/efi/libstub/efi-stub-entry.c
> > index 5245c4f031c0..f971fd25a4eb 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> > @@ -5,6 +5,30 @@
> >
> >  #include "efistub.h"
> >
> > +static struct screen_info *setup_graphics(void)
> > +{
> > +       unsigned long size;
> > +       efi_status_t status;
> > +       efi_guid_t gop_proto =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> > +       void **gop_handle =3D NULL;
> > +       struct screen_info *si =3D NULL;
> > +
> > +       size =3D 0;
> > +       status =3D efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> > +                            &gop_proto, NULL, &size, gop_handle);
> > +       if (status =3D=3D EFI_BUFFER_TOO_SMALL) {
> > +               si =3D alloc_screen_info();
> > +               if (!si)
> > +                       return NULL;
> > +               status =3D efi_setup_gop(si, &gop_proto, size);
> > +               if (status !=3D EFI_SUCCESS) {
> > +                       free_screen_info(si);
> > +                       return NULL;
> > +               }
> > +       }
> > +       return si;
> > +}
> > +
> >  /*
> >   * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V=
 and
> >   * LoongArch. This is the entrypoint that is described in the PE/COFF =
header
> > @@ -22,6 +46,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handl=
e,
> >         efi_guid_t loaded_image_proto =3D LOADED_IMAGE_PROTOCOL_GUID;
> >         unsigned long reserve_addr =3D 0;
> >         unsigned long reserve_size =3D 0;
> > +       struct screen_info *si;
> >
> >         WRITE_ONCE(efi_system_table, systab);
> >
> > @@ -47,6 +72,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handl=
e,
> >
> >         efi_info("Booting Linux Kernel...\n");
> >
> > +       si =3D setup_graphics();
> > +
> >         status =3D handle_kernel_image(&image_addr, &image_size,
> >                                      &reserve_addr,
> >                                      &reserve_size,
> > @@ -58,6 +85,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handl=
e,
> >
> >         status =3D efi_stub_common(handle, image, image_addr, cmdline_p=
tr);
> >
> > +       free_screen_info(si);
> > +
> >         efi_free(image_size, image_addr);
> >         efi_free(reserve_size, reserve_addr);
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware=
/efi/libstub/efi-stub.c
> > index 2955c1ac6a36..bc67af721412 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -56,30 +56,6 @@ void __weak free_screen_info(struct screen_info *si)
> >  {
> >  }
> >
> > -static struct screen_info *setup_graphics(void)
> > -{
> > -       efi_guid_t gop_proto =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> > -       efi_status_t status;
> > -       unsigned long size;
> > -       void **gop_handle =3D NULL;
> > -       struct screen_info *si =3D NULL;
> > -
> > -       size =3D 0;
> > -       status =3D efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> > -                            &gop_proto, NULL, &size, gop_handle);
> > -       if (status =3D=3D EFI_BUFFER_TOO_SMALL) {
> > -               si =3D alloc_screen_info();
> > -               if (!si)
> > -                       return NULL;
> > -               status =3D efi_setup_gop(si, &gop_proto, size);
> > -               if (status !=3D EFI_SUCCESS) {
> > -                       free_screen_info(si);
> > -                       return NULL;
> > -               }
> > -       }
> > -       return si;
> > -}
> > -
> >  static void install_memreserve_table(void)
> >  {
> >         struct linux_efi_memreserve *rsv;
> > @@ -163,14 +139,12 @@ efi_status_t efi_stub_common(efi_handle_t handle,
> >                              unsigned long image_addr,
> >                              char *cmdline_ptr)
> >  {
> > -       struct screen_info *si;
> >         efi_status_t status;
> >
> >         status =3D check_platform_features();
> >         if (status !=3D EFI_SUCCESS)
> >                 return status;
> >
> > -       si =3D setup_graphics();
> >
> >         efi_retrieve_tpm2_eventlog();
> >
> > @@ -190,7 +164,6 @@ efi_status_t efi_stub_common(efi_handle_t handle,
> >
> >         status =3D efi_boot_kernel(handle, image, image_addr, cmdline_p=
tr);
> >
> > -       free_screen_info(si);
> >         return status;
> >  }
> >
> > --
> > 2.39.1
> >
