Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B56A69F8
	for <lists+linux-efi@lfdr.de>; Wed,  1 Mar 2023 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCAJoW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Mar 2023 04:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAJoV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Mar 2023 04:44:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9936010A94;
        Wed,  1 Mar 2023 01:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43999B80E4F;
        Wed,  1 Mar 2023 09:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D11C433A0;
        Wed,  1 Mar 2023 09:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677663857;
        bh=LZzEDPcJwQ6+IkBdB/aTbnD5j0ED5HzjLlWGuXrj4MQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aWYUdEbq93vc/HkOx3NN0cL7E9WwH52vKJN92Esll0/LO3aQJkes8tw5puChTlHIV
         13V3riLhkze4+mF7dMz3iJSWdF0rNcnTfbxfZRSrDvZeTqgoQ0JGBbk+IL2G3tffmA
         xfDPTpYSCT5fTqQFfeist5FYAarZTiy25w5fWj1uWyMPhBzu4vQb54nKjpeqenkTzJ
         XezdtyaIiSwreYcflNIdW9R5BBVNG9WhoyQpgmHiZkCAhoy+Nc4tSBQRBTPA2h0zc3
         t7akEg7F1fsZ/PM8VyUp4XmWMt5uIUzoo+/ocJPtrppAy032dMpbLoXCm/Q304sNas
         3j/85L/Z5JUpw==
Received: by mail-ed1-f54.google.com with SMTP id h16so51298565edz.10;
        Wed, 01 Mar 2023 01:44:17 -0800 (PST)
X-Gm-Message-State: AO0yUKWXpM8EJ8Kyd4KZII6vRrXUI0gcRkIrt8WcfOvZCcxqVskCNiuD
        8Rm6bkWsjp0W1MfQuUMMT0s5SMpZMIlhDDePxlE=
X-Google-Smtp-Source: AK7set+U7hVe6lwKCGqravzPTCZ7gIt6Kjfl33q220fxKsy5oSFarmOG7xwMi10QiLstrLrf7Rv5h0AsO+NX5kJhjVU=
X-Received: by 2002:a17:906:271a:b0:877:7480:c561 with SMTP id
 z26-20020a170906271a00b008777480c561mr2904679ejc.1.1677663856014; Wed, 01 Mar
 2023 01:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20230301085545.2373646-1-chenhuacai@loongson.cn> <CAMj1kXFybJ=snO5YG=6Uy2Qoi98b-6YTKX0Z9=1GPn=JMdxUiQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFybJ=snO5YG=6Uy2Qoi98b-6YTKX0Z9=1GPn=JMdxUiQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 1 Mar 2023 17:44:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Ed2PsOAmghM2NJB6fPbbdiq3ctF6ogjs6q+zCJykPAA@mail.gmail.com>
Message-ID: <CAAhV-H6Ed2PsOAmghM2NJB6fPbbdiq3ctF6ogjs6q+zCJykPAA@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Reintroduce efi_relocate_kernel() to
 relocate kernel
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

Hi, Ard,

On Wed, Mar 1, 2023 at 5:17=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 1 Mar 2023 at 09:55, Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Since Linux-6.3, LoongArch supports PIE kernel now, so let's reintroduc=
e
> > efi_relocate_kernel() to relocate the core kernel.
> >
>
> Nice!
>
> I assume you will need to make a similar change for zboot?
zboot is always PIE (even before 6.3), so I suppose we don't need to
do anything?

Huacai
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/firmware/efi/libstub/loongarch-stub.c | 24 ++++++-------------
> >  1 file changed, 7 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/fi=
rmware/efi/libstub/loongarch-stub.c
> > index eee7ed43cdfb..72c71ae201f0 100644
> > --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > @@ -21,26 +21,16 @@ efi_status_t handle_kernel_image(unsigned long *ima=
ge_addr,
> >                                  efi_loaded_image_t *image,
> >                                  efi_handle_t image_handle)
> >  {
> > -       int nr_pages =3D round_up(kernel_asize, EFI_ALLOC_ALIGN) / EFI_=
PAGE_SIZE;
> > -       efi_physical_addr_t kernel_addr =3D EFI_KIMG_PREFERRED_ADDRESS;
> >         efi_status_t status;
> > +       unsigned long kernel_addr =3D 0;
> >
> > -       /*
> > -        * Allocate space for the kernel image at the preferred offset.=
 This is
> > -        * the only location in memory from where we can execute the im=
age, so
> > -        * no point in falling back to another allocation.
> > -        */
> > -       status =3D efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> > -                            EFI_LOADER_DATA, nr_pages, &kernel_addr);
> > -       if (status !=3D EFI_SUCCESS)
> > -               return status;
> > -
> > -       *image_addr =3D EFI_KIMG_PREFERRED_ADDRESS;
> > -       *image_size =3D kernel_asize;
> > +       kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset;
> > +
> > +       status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, kern=
el_asize,
> > +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align=
(), 0x0);
> >
> > -       memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
> > -              (void *)&kernel_offset - kernel_offset,
> > -              kernel_fsize);
> > +       *image_addr =3D kernel_addr;
> > +       *image_size =3D kernel_asize;
> >
> >         return status;
> >  }
> > --
> > 2.39.1
> >
