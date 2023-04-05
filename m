Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6E6D7696
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjDEIOO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbjDEION (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 04:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E0F5;
        Wed,  5 Apr 2023 01:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42B2D6245E;
        Wed,  5 Apr 2023 08:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFBFC4339E;
        Wed,  5 Apr 2023 08:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680682451;
        bh=1nSglfItAuDI4ol4In4nVcuiP9G4IB0lSOQfSgEOfCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L2Yi2n4zcZcm4bQPPU9sZ242yVQyuXbhGtQaan735qEWwqiZ3wEPVMZQsqABQgPEE
         h4Kuprkm89+5gPA24oQ2/9I6eV+LxhDUM2DUcXKpKVy5YXk7ArZN8NAuzjgl5VARRM
         wcer0NjYmQr4y7zJeSmHLlI0s9iLgrNG/AiSJm3oCm76Psb/7/jWEHFAIoE64Br1Ir
         lkpXFbN/G+Wp+8QoAUqC4V96V88RgLk80ykpJndM/K6uzZYw3/LwclwTFJxRWBOlFP
         4KsAIdE+vLwRKmB/mycLYLgwJ26PzfrOT1aGIFg+RaabKatVZcAOnvHIPkiwmY5GQd
         GpKW41dSctb4g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5002e950e23so208382a12.1;
        Wed, 05 Apr 2023 01:14:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9fg1rVS6/naNV0sH8O/Ni+I5Xv9506cLvgUbwJQxll5ytn6PMv6
        VfjrAv2SbrwVtgzET/Bm+jLWhzU2iE6FuAJSDDQ=
X-Google-Smtp-Source: AKy350aZNiqLEErKnpGDDjTYf9nmSTpBW2y8eaHbCzbBzYF6e/OECEGTKWU0mUgFMSf3y0GLmz5oA6Fxo7YXcJdc8Xk=
X-Received: by 2002:a50:9509:0:b0:4ab:49b9:686d with SMTP id
 u9-20020a509509000000b004ab49b9686dmr691501eda.1.1680682449803; Wed, 05 Apr
 2023 01:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230301085545.2373646-1-chenhuacai@loongson.cn>
 <aba37b65-6fc4-721e-ebc5-df52533e4791@loongson.cn> <CAAhV-H6xAKQ94T5=+iVASwi8F=7+G_ptSGVVBOw4L1fCR+EQOw@mail.gmail.com>
 <dfd6a1cb-25be-cc11-4134-b2e92e353c00@loongson.cn> <CAAhV-H4q2+s2fV6DqSK8H0cByvJsd78GBB_Vw9gxHMfBu2Scug@mail.gmail.com>
In-Reply-To: <CAAhV-H4q2+s2fV6DqSK8H0cByvJsd78GBB_Vw9gxHMfBu2Scug@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 5 Apr 2023 16:13:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H54MWEXgqPqv+23vQxQU455iMnwON37uiByyci9cgh5Hg@mail.gmail.com>
Message-ID: <CAAhV-H54MWEXgqPqv+23vQxQU455iMnwON37uiByyci9cgh5Hg@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Reintroduce efi_relocate_kernel() to
 relocate kernel
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Ard,

What is the status of this patch now?

Huacai

On Wed, Mar 1, 2023 at 8:06=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Youling,
>
> On Wed, Mar 1, 2023 at 6:08=E2=80=AFPM Youling Tang <tangyouling@loongson=
.cn> wrote:
> >
> > Hi, Huacai
> >
> > On 03/01/2023 05:30 PM, Huacai Chen wrote:
> > > Hi, Youling,
> > >
> > > On Wed, Mar 1, 2023 at 5:21=E2=80=AFPM Youling Tang <tangyouling@loon=
gson.cn> wrote:
> > >>
> > >> Hi, Huacai
> > >>
> > >> On 03/01/2023 04:55 PM, Huacai Chen wrote:
> > >>> Since Linux-6.3, LoongArch supports PIE kernel now, so let's reintr=
oduce
> > >>> efi_relocate_kernel() to relocate the core kernel.
> > >>
> > >> If we strongly rely on the PIE feature after the modification, we ne=
ed
> > >> to modify it as follows,
> > > There is no strong rely, efi_relocate_kernel() can also handle the
> > > non-PIE kernel.
> >
> > IMHO, if EFI_KIMG_PREFERRED_ADDRESS is no longer defined as
> > `PHYSADDR(VMLINUX_LOAD_ADDRESS)` (physical link address), we need to
> > relocate through the RELOCATABLE function, so it is recommended to
> > select RELOCATABLE if EFI_STUB is enabled
> We can select RELOCATABLE when we modify EFI_KIMG_PREFERRED_ADDRESS.
> Before that I prefer to give a chance to build a non-PIE kernel.
>
> Huacai
> >
> > Youling.
> > >
> > > Huacai
> > >>
> > >> --- a/arch/loongarch/Kconfig
> > >> +++ b/arch/loongarch/Kconfig
> > >> @@ -137,6 +137,7 @@ config LOONGARCH
> > >>          select PCI_MSI_ARCH_FALLBACKS
> > >>          select PCI_QUIRKS
> > >>          select PERF_USE_VMALLOC
> > >> +       select RELOCATABLE
> > >>          select RTC_LIB
> > >>          select SMP
> > >>          select SPARSE_IRQ
> > >>
> > >> or:
> > >>
> > >> --- a/arch/loongarch/Kconfig
> > >> +++ b/arch/loongarch/Kconfig
> > >> @@ -360,6 +360,7 @@ config EFI_STUB
> > >>          default y
> > >>          depends on EFI
> > >>          select EFI_GENERIC_STUB
> > >> +       select RELOCATABLE
> > >>          help
> > >>
> > >> Youling.
> > >>
> > >>>
> > >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >>> ---
> > >>>  drivers/firmware/efi/libstub/loongarch-stub.c | 24 ++++++---------=
----
> > >>>  1 file changed, 7 insertions(+), 17 deletions(-)
> > >>>
> > >>> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/driver=
s/firmware/efi/libstub/loongarch-stub.c
> > >>> index eee7ed43cdfb..72c71ae201f0 100644
> > >>> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> > >>> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > >>> @@ -21,26 +21,16 @@ efi_status_t handle_kernel_image(unsigned long =
*image_addr,
> > >>>                                efi_loaded_image_t *image,
> > >>>                                efi_handle_t image_handle)
> > >>>  {
> > >>> -     int nr_pages =3D round_up(kernel_asize, EFI_ALLOC_ALIGN) / EF=
I_PAGE_SIZE;
> > >>> -     efi_physical_addr_t kernel_addr =3D EFI_KIMG_PREFERRED_ADDRES=
S;
> > >>>       efi_status_t status;
> > >>> +     unsigned long kernel_addr =3D 0;
> > >>>
> > >>> -     /*
> > >>> -      * Allocate space for the kernel image at the preferred offse=
t. This is
> > >>> -      * the only location in memory from where we can execute the =
image, so
> > >>> -      * no point in falling back to another allocation.
> > >>> -      */
> > >>> -     status =3D efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> > >>> -                          EFI_LOADER_DATA, nr_pages, &kernel_addr)=
;
> > >>> -     if (status !=3D EFI_SUCCESS)
> > >>> -             return status;
> > >>> -
> > >>> -     *image_addr =3D EFI_KIMG_PREFERRED_ADDRESS;
> > >>> -     *image_size =3D kernel_asize;
> > >>> +     kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset=
;
> > >>> +
> > >>> +     status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, ke=
rnel_asize,
> > >>> +                  EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_ali=
gn(), 0x0);
> > >>>
> > >>> -     memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
> > >>> -            (void *)&kernel_offset - kernel_offset,
> > >>> -            kernel_fsize);
> > >>> +     *image_addr =3D kernel_addr;
> > >>> +     *image_size =3D kernel_asize;
> > >>>
> > >>>       return status;
> > >>>  }
> > >>>
> > >>
> >
> >
