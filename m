Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794516BA283
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 23:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCNWb7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNWb6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 18:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB8457D9;
        Tue, 14 Mar 2023 15:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 774E261A33;
        Tue, 14 Mar 2023 22:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35CCC433A0;
        Tue, 14 Mar 2023 22:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678833116;
        bh=gk2Tymhp90otil403oGS0ANqZWeCizhGEMkb0lNl/8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mcLhpHQ41+l3ZFkdnFlFNE8w5Oe4LXFS6tcL8bcmYEiTnAg6X0bzqw0gUsfDrA3Q7
         +7Jl2uudovBM+Ukm1La2txFTa+jfv4/ZklAx4Jy1b2VAqWUh/nRMmO9qr798i1G8UW
         3fDalxr1MaI12yAt80xTOPWblZFUb6XXR05FhQb6VXktjaTT58Gmn5pAsR7GgufTRu
         9ewa9pV65lK7lLQG566fB91KrVl95+RCiDp0eSuFcMKfvYUp8nEH/XA/DnluYFVyh8
         OukGvkkZqQ6LI6Ofro8ayN8If5hZfTMO1/iahgyOOLDJyHelvohP274895H/Kq/2Xh
         ZoqARQdFChuQw==
Received: by mail-lf1-f49.google.com with SMTP id o8so2004803lfo.0;
        Tue, 14 Mar 2023 15:31:56 -0700 (PDT)
X-Gm-Message-State: AO0yUKUw+XeOcH36zoqgbMBBwK6v+E8rSVqb03Wvdd4W5IIpx931oq9N
        QG5v8VGUsJIkFjNokX+huKzVQhkeFMBxnBirmCE=
X-Google-Smtp-Source: AK7set9fvG9iDYqG/ZvBlfEHhTScuhZtnxiap1NyONzoBOYfBmNA4HZWcpy6H3lTt4ZiqCD9p5BTAYNc+41ucBzYWrs=
X-Received: by 2002:ac2:4203:0:b0:4d5:ca42:e43b with SMTP id
 y3-20020ac24203000000b004d5ca42e43bmr1239812lfh.4.1678833114813; Tue, 14 Mar
 2023 15:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230310021749.921041-1-chenhuacai@loongson.cn>
In-Reply-To: <20230310021749.921041-1-chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Mar 2023 23:31:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHHVxM2YGQ9Ytdf=nEB6CU9GHSDgek+V2SghYh5Aq-uSg@mail.gmail.com>
Message-ID: <CAMj1kXHHVxM2YGQ9Ytdf=nEB6CU9GHSDgek+V2SghYh5Aq-uSg@mail.gmail.com>
Subject: Re: [PATCH V2] efi/libstub: Call setup_graphics() before handle_kernel_image()
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-efi@vger.kernel.org,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Mar 2023 at 03:18, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Commit 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint
> into separate file") moves setup_graphics() into efi_stub_common() which
> is after handle_kernel_image(). This causes efifb no longer work because
> handle_kernel_image() may move the core kernel to its preferred address,
> which means the screen_info filled by the efistub will not be the same
> as the one accessed by the core kernel. So let us call setup_graphics()
> before handle_kernel_image() which restores the old behavior.
>
> The side effect is zboot will not call setup_graphics(), but I think
> zboot doesn't need it either.
>
> Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Please drop this patch from the loonarch tree - it is causing a
conflict in linux-next.


> ---
> V2: Use static declaration for setup_graphics() to avoid build warnings.
>
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 29 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub.c       | 27 -----------------
>  2 files changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index 5245c4f031c0..f971fd25a4eb 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -5,6 +5,30 @@
>
>  #include "efistub.h"
>
> +static struct screen_info *setup_graphics(void)
> +{
> +       unsigned long size;
> +       efi_status_t status;
> +       efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> +       void **gop_handle = NULL;
> +       struct screen_info *si = NULL;
> +
> +       size = 0;
> +       status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> +                            &gop_proto, NULL, &size, gop_handle);
> +       if (status == EFI_BUFFER_TOO_SMALL) {
> +               si = alloc_screen_info();
> +               if (!si)
> +                       return NULL;
> +               status = efi_setup_gop(si, &gop_proto, size);
> +               if (status != EFI_SUCCESS) {
> +                       free_screen_info(si);
> +                       return NULL;
> +               }
> +       }
> +       return si;
> +}
> +
>  /*
>   * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V and
>   * LoongArch. This is the entrypoint that is described in the PE/COFF header
> @@ -22,6 +46,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
>         unsigned long reserve_addr = 0;
>         unsigned long reserve_size = 0;
> +       struct screen_info *si;
>
>         WRITE_ONCE(efi_system_table, systab);
>
> @@ -47,6 +72,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>
>         efi_info("Booting Linux Kernel...\n");
>
> +       si = setup_graphics();
> +
>         status = handle_kernel_image(&image_addr, &image_size,
>                                      &reserve_addr,
>                                      &reserve_size,
> @@ -58,6 +85,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>
>         status = efi_stub_common(handle, image, image_addr, cmdline_ptr);
>
> +       free_screen_info(si);
> +
>         efi_free(image_size, image_addr);
>         efi_free(reserve_size, reserve_addr);
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 2955c1ac6a36..bc67af721412 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -56,30 +56,6 @@ void __weak free_screen_info(struct screen_info *si)
>  {
>  }
>
> -static struct screen_info *setup_graphics(void)
> -{
> -       efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> -       efi_status_t status;
> -       unsigned long size;
> -       void **gop_handle = NULL;
> -       struct screen_info *si = NULL;
> -
> -       size = 0;
> -       status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> -                            &gop_proto, NULL, &size, gop_handle);
> -       if (status == EFI_BUFFER_TOO_SMALL) {
> -               si = alloc_screen_info();
> -               if (!si)
> -                       return NULL;
> -               status = efi_setup_gop(si, &gop_proto, size);
> -               if (status != EFI_SUCCESS) {
> -                       free_screen_info(si);
> -                       return NULL;
> -               }
> -       }
> -       return si;
> -}
> -
>  static void install_memreserve_table(void)
>  {
>         struct linux_efi_memreserve *rsv;
> @@ -163,14 +139,12 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>                              unsigned long image_addr,
>                              char *cmdline_ptr)
>  {
> -       struct screen_info *si;
>         efi_status_t status;
>
>         status = check_platform_features();
>         if (status != EFI_SUCCESS)
>                 return status;
>
> -       si = setup_graphics();
>
>         efi_retrieve_tpm2_eventlog();
>
> @@ -190,7 +164,6 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>
>         status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
>
> -       free_screen_info(si);
>         return status;
>  }
>
> --
> 2.39.1
>
