Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A241F6C63C8
	for <lists+linux-efi@lfdr.de>; Thu, 23 Mar 2023 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCWJgF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Mar 2023 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCWJfi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Mar 2023 05:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD22DE43
        for <linux-efi@vger.kernel.org>; Thu, 23 Mar 2023 02:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D817662574
        for <linux-efi@vger.kernel.org>; Thu, 23 Mar 2023 09:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48988C4339E
        for <linux-efi@vger.kernel.org>; Thu, 23 Mar 2023 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679564036;
        bh=DGKZC1OHgdJG6o8Idmbtp2aTGI4a6sfyoWdx6/GH+Qg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TXXVAKYowMG1OgpvymicsYRdUCZUTW1rQFGh+jrpj1CtiSjP4bcE9Ob5ddl+BIt/F
         YfHdU8WkQ3jHnKznbGnIKJ36oJhaiYs4Qmy5UAi6TX2ZLAKeLI8L0iNoARRvS0iO4y
         0/f4PmKIUG7OTIn1ERJAdm8OB8ZqvFKd4dLxhoecI3gUKc8mpZjAstuhurgQSPSz24
         gLV8bO/HVFaK0Es9gKYTnToColarI38S7VHwV9c1mP56fToUY4f9p+6UcW4jt7URV3
         iBN1O3kK73inghaYVsNnxuAeFF6B5SFz88TUp32UVdT42rmw26mzcvIvobn7OWdo29
         jjU0NAixm70tw==
Received: by mail-ed1-f41.google.com with SMTP id ew6so20704480edb.7
        for <linux-efi@vger.kernel.org>; Thu, 23 Mar 2023 02:33:56 -0700 (PDT)
X-Gm-Message-State: AO0yUKUAtkKllinUjWZVWqdt5+bwZP4l7KuJcyzDXiYbGm2gnF85ISe4
        Thu8aDJu4W+wZa/i6styS+Exp1Pzr96lCMlVB84=
X-Google-Smtp-Source: AK7set/dHunoYdWYcWlmemEEYxDQYnx2zAeuFc1zABepjKB8nHJTPC/yyKIqxJ+YPyvz+6UC+0CUZXOJFtwsSCLvyFQ=
X-Received: by 2002:a50:951e:0:b0:4fc:1608:68c8 with SMTP id
 u30-20020a50951e000000b004fc160868c8mr5008916eda.1.1679564034421; Thu, 23 Mar
 2023 02:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230322141037.3684946-1-ardb@kernel.org>
In-Reply-To: <20230322141037.3684946-1-ardb@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 23 Mar 2023 17:33:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=MOR265Srkk7gJ8RyFFEZ5QSJ26XiO=g+AGZR-9dgHw@mail.gmail.com>
Message-ID: <CAAhV-H6=MOR265Srkk7gJ8RyFFEZ5QSJ26XiO=g+AGZR-9dgHw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: Use relocated version of kernel's struct screen_info
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
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

Tested-by: Huacai Chen <chenhuacai@loongson.cn>

On Wed, Mar 22, 2023 at 10:10=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> In some cases, we expose the kernel's struct screen_info to the EFI stub
> directly, so it gets populated before even entering the kernel.  This
> means the early console is available as soon as the early param parsing
> happens, which is nice. It also means we need two different ways to pass
> this information, as this trick only works if the EFI stub is baked into
> the core kernel image, which is not always the case.
>
> Huacai reports that the preparatory refactoring that was needed to
> implement this alternative method for zboot resulted in a non-functional
> efifb earlycon for other cases as well, due to the reordering of the
> kernel image relocation with the population of the screen_info struct,
> and the latter now takes place after copying the image to its new
> location, which means we copy the old, uninitialized state.
>
> So let's ensure that the same-image version of alloc_screen_info()
> produces the correct screen_info pointer, by taking the displacement of
> the loaded image into account.
>
> Cc: loongarch@lists.linux.dev
> Cc: Xuefeng Li <lixuefeng@loongson.cn>
> Cc: Xuerui Wang <kernel@xen0n.name>
> Cc: loongson-kernel@lists.loongnix.cn
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuaca=
i@loongson.cn/
> Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint in=
to separate file")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2:
> - ensure image->image_base is accurate (Redhat has shipped broken GRUB
>   versions that put bogus values in there)
> - ensure that the config table screen_info version is only used when
>   needed
>
>  drivers/firmware/efi/libstub/arm64-stub.c     |  4 +++-
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 15 +++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub.c       |  9 ---------
>  drivers/firmware/efi/libstub/efistub.h        |  1 +
>  drivers/firmware/efi/libstub/screen_info.c    |  9 +--------
>  drivers/firmware/efi/libstub/zboot.c          |  9 +++++++++
>  6 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware=
/efi/libstub/arm64-stub.c
> index b996553cdb4c3587..770b8ecb73984c61 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -85,8 +85,10 @@ efi_status_t handle_kernel_image(unsigned long *image_=
addr,
>                 }
>         }
>
> -       if (image->image_base !=3D _text)
> +       if (image->image_base !=3D _text) {
>                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has=
 bogus value\n");
> +               image->image_base =3D _text;
> +       }
>
>         if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN))
>                 efi_err("FIRMWARE BUG: kernel image not aligned on %dk bo=
undary\n",
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firm=
ware/efi/libstub/efi-stub-entry.c
> index 5245c4f031c0a70a..d66e400cd4ccfa19 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -5,6 +5,19 @@
>
>  #include "efistub.h"
>
> +static unsigned long screen_info_offset;
> +
> +struct screen_info *alloc_screen_info(void)
> +{
> +       if (IS_ENABLED(CONFIG_ARM))
> +               return __alloc_screen_info();
> +       return (void *)&screen_info + screen_info_offset;
> +}
> +
> +void __weak free_screen_info(struct screen_info *si)
> +{
> +}
> +
>  /*
>   * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V a=
nd
>   * LoongArch. This is the entrypoint that is described in the PE/COFF he=
ader
> @@ -56,6 +69,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>                 return status;
>         }
>
> +       screen_info_offset =3D image_addr - (unsigned long)image->image_b=
ase;
> +
>         status =3D efi_stub_common(handle, image, image_addr, cmdline_ptr=
);
>
>         efi_free(image_size, image_addr);
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/e=
fi/libstub/efi-stub.c
> index 2955c1ac6a36ee00..c4b9eccad0f103dc 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -47,15 +47,6 @@
>  static u64 virtmap_base =3D EFI_RT_VIRTUAL_BASE;
>  static bool flat_va_mapping =3D (EFI_RT_VIRTUAL_OFFSET !=3D 0);
>
> -struct screen_info * __weak alloc_screen_info(void)
> -{
> -       return &screen_info;
> -}
> -
> -void __weak free_screen_info(struct screen_info *si)
> -{
> -}
> -
>  static struct screen_info *setup_graphics(void)
>  {
>         efi_guid_t gop_proto =3D EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/ef=
i/libstub/efistub.h
> index bd9c38a93bbce09c..148013bcb5f89fdd 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1062,6 +1062,7 @@ efi_enable_reset_attack_mitigation(void) { }
>  void efi_retrieve_tpm2_eventlog(void);
>
>  struct screen_info *alloc_screen_info(void);
> +struct screen_info *__alloc_screen_info(void);
>  void free_screen_info(struct screen_info *si);
>
>  void efi_cache_sync_image(unsigned long image_base,
> diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmwar=
e/efi/libstub/screen_info.c
> index 8e76a8b384ba142d..4be1c4d1f922becd 100644
> --- a/drivers/firmware/efi/libstub/screen_info.c
> +++ b/drivers/firmware/efi/libstub/screen_info.c
> @@ -15,18 +15,11 @@
>   * early, but it only works if the EFI stub is part of the core kernel i=
mage
>   * itself. The zboot decompressor can only use the configuration table
>   * approach.
> - *
> - * In order to support both methods from the same build of the EFI stub
> - * library, provide this dummy global definition of struct screen_info. =
If it
> - * is required to satisfy a link dependency, it means we need to overrid=
e the
> - * __weak alloc and free methods with the ones below, and those will be =
pulled
> - * in as well.
>   */
> -struct screen_info screen_info;
>
>  static efi_guid_t screen_info_guid =3D LINUX_EFI_SCREEN_INFO_TABLE_GUID;
>
> -struct screen_info *alloc_screen_info(void)
> +struct screen_info *__alloc_screen_info(void)
>  {
>         struct screen_info *si;
>         efi_status_t status;
> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/=
libstub/zboot.c
> index ba234e062a1a29da..10a161e6d5555fe1 100644
> --- a/drivers/firmware/efi/libstub/zboot.c
> +++ b/drivers/firmware/efi/libstub/zboot.c
> @@ -57,6 +57,15 @@ void __weak efi_cache_sync_image(unsigned long image_b=
ase,
>         // executable code loaded into memory to be safe for execution.
>  }
>
> +struct screen_info *alloc_screen_info(void)
> +{
> +       return __alloc_screen_info();
> +}
> +
> +void __weak free_screen_info(struct screen_info *si)
> +{
> +}
> +
>  asmlinkage efi_status_t __efiapi
>  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
>  {
> --
> 2.39.2
>
>
