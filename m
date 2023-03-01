Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904856A6C17
	for <lists+linux-efi@lfdr.de>; Wed,  1 Mar 2023 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCAMHY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Mar 2023 07:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCAMHX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Mar 2023 07:07:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452C36FF2;
        Wed,  1 Mar 2023 04:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63513B81015;
        Wed,  1 Mar 2023 12:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C5EC433A0;
        Wed,  1 Mar 2023 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677672437;
        bh=a4HXikBAfsTGDGyY1EqABSnmg24eMbvSd2S3rx8Tm3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g40MrPv8lcWOXW6/DizK90pXcXhc5ZjN2N+VBsCEDK7j5myN+H9h1bjMfK6/7Gbnz
         lYMYIwByn/cqiOtfaEfzgbJG3ABBHsf0u5lMxbKs3qwOHrHevPZ6exQaDcay4BGu6b
         Q/IbO19ioZ/KKm+C3xC9F40Tvwp5GViQZSQfIh7GufQmRhCANRnlODjcpjBVDixcO3
         9C3VbhKUOPAA/SeD/QBo4/CWNO+cO/hlHvUj3dGDcjE6gWCpofNg6yQFkCkyV5iBAP
         wQ1Z/+7FVoPsUC0vaWf1bt7koqf5wVulZ8sTa/P4kibx6ZY30S6NpOmcaLFBzTJtpL
         NOD1sr6ylcxmQ==
Received: by mail-ed1-f46.google.com with SMTP id s26so52682660edw.11;
        Wed, 01 Mar 2023 04:07:16 -0800 (PST)
X-Gm-Message-State: AO0yUKVPG4Y7QJS2oOZEXmP4TlanW4KVUw+EmgLHTpkfjEUN7VJLdYt1
        GB0MBIeUoy5KOObvTkAf9Al8/vzQHfE5Z+5RSOM=
X-Google-Smtp-Source: AK7set+ZPFIRI5EJZyj6BlqoXxNozNx266bdzbtmag0+xgRl1DE36MIgV7uSxWvYQpCEJzBy1trQnMbYscC4Ba5Vz+M=
X-Received: by 2002:a17:906:4f99:b0:8b0:e909:9136 with SMTP id
 o25-20020a1709064f9900b008b0e9099136mr3012557eju.1.1677672435185; Wed, 01 Mar
 2023 04:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20230301085545.2373646-1-chenhuacai@loongson.cn>
 <aba37b65-6fc4-721e-ebc5-df52533e4791@loongson.cn> <CAAhV-H6xAKQ94T5=+iVASwi8F=7+G_ptSGVVBOw4L1fCR+EQOw@mail.gmail.com>
 <dfd6a1cb-25be-cc11-4134-b2e92e353c00@loongson.cn>
In-Reply-To: <dfd6a1cb-25be-cc11-4134-b2e92e353c00@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 1 Mar 2023 20:06:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4q2+s2fV6DqSK8H0cByvJsd78GBB_Vw9gxHMfBu2Scug@mail.gmail.com>
Message-ID: <CAAhV-H4q2+s2fV6DqSK8H0cByvJsd78GBB_Vw9gxHMfBu2Scug@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Youling,

On Wed, Mar 1, 2023 at 6:08=E2=80=AFPM Youling Tang <tangyouling@loongson.c=
n> wrote:
>
> Hi, Huacai
>
> On 03/01/2023 05:30 PM, Huacai Chen wrote:
> > Hi, Youling,
> >
> > On Wed, Mar 1, 2023 at 5:21=E2=80=AFPM Youling Tang <tangyouling@loongs=
on.cn> wrote:
> >>
> >> Hi, Huacai
> >>
> >> On 03/01/2023 04:55 PM, Huacai Chen wrote:
> >>> Since Linux-6.3, LoongArch supports PIE kernel now, so let's reintrod=
uce
> >>> efi_relocate_kernel() to relocate the core kernel.
> >>
> >> If we strongly rely on the PIE feature after the modification, we need
> >> to modify it as follows,
> > There is no strong rely, efi_relocate_kernel() can also handle the
> > non-PIE kernel.
>
> IMHO, if EFI_KIMG_PREFERRED_ADDRESS is no longer defined as
> `PHYSADDR(VMLINUX_LOAD_ADDRESS)` (physical link address), we need to
> relocate through the RELOCATABLE function, so it is recommended to
> select RELOCATABLE if EFI_STUB is enabled
We can select RELOCATABLE when we modify EFI_KIMG_PREFERRED_ADDRESS.
Before that I prefer to give a chance to build a non-PIE kernel.

Huacai
>
> Youling.
> >
> > Huacai
> >>
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -137,6 +137,7 @@ config LOONGARCH
> >>          select PCI_MSI_ARCH_FALLBACKS
> >>          select PCI_QUIRKS
> >>          select PERF_USE_VMALLOC
> >> +       select RELOCATABLE
> >>          select RTC_LIB
> >>          select SMP
> >>          select SPARSE_IRQ
> >>
> >> or:
> >>
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -360,6 +360,7 @@ config EFI_STUB
> >>          default y
> >>          depends on EFI
> >>          select EFI_GENERIC_STUB
> >> +       select RELOCATABLE
> >>          help
> >>
> >> Youling.
> >>
> >>>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>>  drivers/firmware/efi/libstub/loongarch-stub.c | 24 ++++++-----------=
--
> >>>  1 file changed, 7 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/=
firmware/efi/libstub/loongarch-stub.c
> >>> index eee7ed43cdfb..72c71ae201f0 100644
> >>> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> >>> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> >>> @@ -21,26 +21,16 @@ efi_status_t handle_kernel_image(unsigned long *i=
mage_addr,
> >>>                                efi_loaded_image_t *image,
> >>>                                efi_handle_t image_handle)
> >>>  {
> >>> -     int nr_pages =3D round_up(kernel_asize, EFI_ALLOC_ALIGN) / EFI_=
PAGE_SIZE;
> >>> -     efi_physical_addr_t kernel_addr =3D EFI_KIMG_PREFERRED_ADDRESS;
> >>>       efi_status_t status;
> >>> +     unsigned long kernel_addr =3D 0;
> >>>
> >>> -     /*
> >>> -      * Allocate space for the kernel image at the preferred offset.=
 This is
> >>> -      * the only location in memory from where we can execute the im=
age, so
> >>> -      * no point in falling back to another allocation.
> >>> -      */
> >>> -     status =3D efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> >>> -                          EFI_LOADER_DATA, nr_pages, &kernel_addr);
> >>> -     if (status !=3D EFI_SUCCESS)
> >>> -             return status;
> >>> -
> >>> -     *image_addr =3D EFI_KIMG_PREFERRED_ADDRESS;
> >>> -     *image_size =3D kernel_asize;
> >>> +     kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset;
> >>> +
> >>> +     status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, kern=
el_asize,
> >>> +                  EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align=
(), 0x0);
> >>>
> >>> -     memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
> >>> -            (void *)&kernel_offset - kernel_offset,
> >>> -            kernel_fsize);
> >>> +     *image_addr =3D kernel_addr;
> >>> +     *image_size =3D kernel_asize;
> >>>
> >>>       return status;
> >>>  }
> >>>
> >>
>
>
