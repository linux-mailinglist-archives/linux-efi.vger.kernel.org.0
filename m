Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D036D76B3
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbjDEIUH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbjDEIUG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 04:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42051BE9;
        Wed,  5 Apr 2023 01:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C7C62478;
        Wed,  5 Apr 2023 08:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E440FC433EF;
        Wed,  5 Apr 2023 08:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680682803;
        bh=HTUknxnqfIabBIx4Bda/TFF4Z3TEp0Sas+BirzctAuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NHVTENUStB4N09PGbnv9YkuNK/iJb+jqc4qJt8YZZ+UManJrSjTAHeU1F9SKSM6E+
         cfwrBxfKBIkJJI/dEhh5N027uyH4i2gjOX4fyyBBMlxlaj6UHH/KbaFdIc7W4Xbnji
         Yi4eo4tUpHkMCEtitg5lg2tROLeWrSD4eFtssEPfui+/5SZrDEoZPBOQqTpsRbaAFJ
         4j1P+pSQQWjBrIT7A7dHUDTjY7FXS/K2Tdn+hP24vUtJKNi8qTjPK0ns6IKaLYl1BZ
         L9MJWfQi/ABC4EJP0Eu1bXvfayKfiwm0QhKCM80GZE5zEg4b7FQM8zUvkQuhyRSfSb
         3PXMyq38rTXzg==
Received: by mail-lf1-f53.google.com with SMTP id x17so45622980lfu.5;
        Wed, 05 Apr 2023 01:20:03 -0700 (PDT)
X-Gm-Message-State: AAQBX9dqtm+PiQ8k9TjdBW+vd0v+2JJ2XM55ZCJjauMGLdLV7RJMC5Sh
        Vx7lBGj7+/i3a97LUdwpsVRb9yahui+Wm7CdUqs=
X-Google-Smtp-Source: AKy350Y1vsozuiEohMdC88enx0BW5x8KnWhTDNQHmY6q/zjfeBiLMb9D+cbTNBPI11aW/NvjzPzzm9TqBufZeyFWyII=
X-Received: by 2002:a05:6512:32d0:b0:4e8:4409:bb76 with SMTP id
 f16-20020a05651232d000b004e84409bb76mr1033018lfg.2.1680682801960; Wed, 05 Apr
 2023 01:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230301085545.2373646-1-chenhuacai@loongson.cn>
 <aba37b65-6fc4-721e-ebc5-df52533e4791@loongson.cn> <CAAhV-H6xAKQ94T5=+iVASwi8F=7+G_ptSGVVBOw4L1fCR+EQOw@mail.gmail.com>
 <dfd6a1cb-25be-cc11-4134-b2e92e353c00@loongson.cn> <CAAhV-H4q2+s2fV6DqSK8H0cByvJsd78GBB_Vw9gxHMfBu2Scug@mail.gmail.com>
 <CAAhV-H54MWEXgqPqv+23vQxQU455iMnwON37uiByyci9cgh5Hg@mail.gmail.com>
In-Reply-To: <CAAhV-H54MWEXgqPqv+23vQxQU455iMnwON37uiByyci9cgh5Hg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 5 Apr 2023 10:19:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEe37g=1DEQcWFEDCLRihZLX14Kso0dwon71W+5jqyDrA@mail.gmail.com>
Message-ID: <CAMj1kXEe37g=1DEQcWFEDCLRihZLX14Kso0dwon71W+5jqyDrA@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Reintroduce efi_relocate_kernel() to
 relocate kernel
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 5 Apr 2023 at 10:14, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> What is the status of this patch now?
>

I'd still like to understand how zboot is affected. It has

static unsigned long alloc_preferred_address(unsigned long alloc_size)
{
#ifdef EFI_KIMG_PREFERRED_ADDRESS
        efi_physical_addr_t efi_addr =3D EFI_KIMG_PREFERRED_ADDRESS;

        if (efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS, EFI_LOADER_DA=
TA,
                        alloc_size / EFI_PAGE_SIZE, &efi_addr) =3D=3D EFI_S=
UCCESS)
                return efi_addr;
#endif
        return ULONG_MAX;
}

and if I understand you correctly, we never needed this in the first place?

(I understand this is a separate issue, but it would be nice to get
rid of EFI_KIMG_PREFERRED_ADDRESS entirely if we can.)



> On Wed, Mar 1, 2023 at 8:06=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
> >
> > Hi, Youling,
> >
> > On Wed, Mar 1, 2023 at 6:08=E2=80=AFPM Youling Tang <tangyouling@loongs=
on.cn> wrote:
> > >
> > > Hi, Huacai
> > >
> > > On 03/01/2023 05:30 PM, Huacai Chen wrote:
> > > > Hi, Youling,
> > > >
> > > > On Wed, Mar 1, 2023 at 5:21=E2=80=AFPM Youling Tang <tangyouling@lo=
ongson.cn> wrote:
> > > >>
> > > >> Hi, Huacai
> > > >>
> > > >> On 03/01/2023 04:55 PM, Huacai Chen wrote:
> > > >>> Since Linux-6.3, LoongArch supports PIE kernel now, so let's rein=
troduce
> > > >>> efi_relocate_kernel() to relocate the core kernel.
> > > >>
> > > >> If we strongly rely on the PIE feature after the modification, we =
need
> > > >> to modify it as follows,
> > > > There is no strong rely, efi_relocate_kernel() can also handle the
> > > > non-PIE kernel.
> > >
> > > IMHO, if EFI_KIMG_PREFERRED_ADDRESS is no longer defined as
> > > `PHYSADDR(VMLINUX_LOAD_ADDRESS)` (physical link address), we need to
> > > relocate through the RELOCATABLE function, so it is recommended to
> > > select RELOCATABLE if EFI_STUB is enabled
> > We can select RELOCATABLE when we modify EFI_KIMG_PREFERRED_ADDRESS.
> > Before that I prefer to give a chance to build a non-PIE kernel.
> >
> > Huacai
> > >
> > > Youling.
> > > >
> > > > Huacai
> > > >>
> > > >> --- a/arch/loongarch/Kconfig
> > > >> +++ b/arch/loongarch/Kconfig
> > > >> @@ -137,6 +137,7 @@ config LOONGARCH
> > > >>          select PCI_MSI_ARCH_FALLBACKS
> > > >>          select PCI_QUIRKS
> > > >>          select PERF_USE_VMALLOC
> > > >> +       select RELOCATABLE
> > > >>          select RTC_LIB
> > > >>          select SMP
> > > >>          select SPARSE_IRQ
> > > >>
> > > >> or:
> > > >>
> > > >> --- a/arch/loongarch/Kconfig
> > > >> +++ b/arch/loongarch/Kconfig
> > > >> @@ -360,6 +360,7 @@ config EFI_STUB
> > > >>          default y
> > > >>          depends on EFI
> > > >>          select EFI_GENERIC_STUB
> > > >> +       select RELOCATABLE
> > > >>          help
> > > >>
> > > >> Youling.
> > > >>
> > > >>>
> > > >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > >>> ---
> > > >>>  drivers/firmware/efi/libstub/loongarch-stub.c | 24 ++++++-------=
------
> > > >>>  1 file changed, 7 insertions(+), 17 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/driv=
ers/firmware/efi/libstub/loongarch-stub.c
> > > >>> index eee7ed43cdfb..72c71ae201f0 100644
> > > >>> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > > >>> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > >>> @@ -21,26 +21,16 @@ efi_status_t handle_kernel_image(unsigned lon=
g *image_addr,
> > > >>>                                efi_loaded_image_t *image,
> > > >>>                                efi_handle_t image_handle)
> > > >>>  {
> > > >>> -     int nr_pages =3D round_up(kernel_asize, EFI_ALLOC_ALIGN) / =
EFI_PAGE_SIZE;
> > > >>> -     efi_physical_addr_t kernel_addr =3D EFI_KIMG_PREFERRED_ADDR=
ESS;
> > > >>>       efi_status_t status;
> > > >>> +     unsigned long kernel_addr =3D 0;
> > > >>>
> > > >>> -     /*
> > > >>> -      * Allocate space for the kernel image at the preferred off=
set. This is
> > > >>> -      * the only location in memory from where we can execute th=
e image, so
> > > >>> -      * no point in falling back to another allocation.
> > > >>> -      */
> > > >>> -     status =3D efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS=
,
> > > >>> -                          EFI_LOADER_DATA, nr_pages, &kernel_add=
r);
> > > >>> -     if (status !=3D EFI_SUCCESS)
> > > >>> -             return status;
> > > >>> -
> > > >>> -     *image_addr =3D EFI_KIMG_PREFERRED_ADDRESS;
> > > >>> -     *image_size =3D kernel_asize;
> > > >>> +     kernel_addr =3D (unsigned long)&kernel_offset - kernel_offs=
et;
> > > >>> +
> > > >>> +     status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, =
kernel_asize,
> > > >>> +                  EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_a=
lign(), 0x0);
> > > >>>
> > > >>> -     memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
> > > >>> -            (void *)&kernel_offset - kernel_offset,
> > > >>> -            kernel_fsize);
> > > >>> +     *image_addr =3D kernel_addr;
> > > >>> +     *image_size =3D kernel_asize;
> > > >>>
> > > >>>       return status;
> > > >>>  }
> > > >>>
> > > >>
> > >
> > >
