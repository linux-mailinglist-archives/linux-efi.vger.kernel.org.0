Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E76A69A0
	for <lists+linux-efi@lfdr.de>; Wed,  1 Mar 2023 10:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCAJRE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Mar 2023 04:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCAJRD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Mar 2023 04:17:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1774B975B;
        Wed,  1 Mar 2023 01:17:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F326129A;
        Wed,  1 Mar 2023 09:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13576C433A0;
        Wed,  1 Mar 2023 09:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677662221;
        bh=lovfDVL8Scu9QyarHVO8qpnpcBeZhltZD2l0DKHmN4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qVrBIPeo0qRh+Qr6oXK8/vpk7W0jNsW4w7n0Kd53kI3rQBSxiULJKuqjgLMpUjd58
         6I5m10JAbUhAMAouVVoN8XLRWks9rx2gsjEznJrHh5Ut2F/iZCS9ZJbf9hOgyJPgRl
         Lmkl5K2lzpEUlMyuuTKC4i6TSueLS5/5ErOdHRDNtlgQLC/wWow3VDCf+1Holi/FUA
         QAs3rNRS17scdzwJvz75kQRl7mUmCqKzzoskUeULK8AmqWzIshnyWq/Eo1snPNp/ia
         PoRcZJQorQh6prF/C7QhC1/Op438MpxWlRD3SIlmWUrP6CqKiwFQaT8ZttjQEhry2m
         4AmmPJu0V3Wwg==
Received: by mail-lj1-f171.google.com with SMTP id b10so13300251ljr.0;
        Wed, 01 Mar 2023 01:17:00 -0800 (PST)
X-Gm-Message-State: AO0yUKVnbP2bvs02T8bPf5wgV9XytENvePlOAz7fuuC2fozWZbwsFbp3
        RIDtbYL7OUORLOUNig1LBrHPhA15hCoe6uX+nEY=
X-Google-Smtp-Source: AK7set8Jxay6/XzRPbvyFuBXH/4bCLtcWK7sNwXjsYGVnArLTvXs6uFBWyOYAFgn2PY3QJRfnMfcmoD/BEom1rGEImc=
X-Received: by 2002:a2e:b989:0:b0:295:ba26:8ad4 with SMTP id
 p9-20020a2eb989000000b00295ba268ad4mr1803515ljp.2.1677662219042; Wed, 01 Mar
 2023 01:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20230301085545.2373646-1-chenhuacai@loongson.cn>
In-Reply-To: <20230301085545.2373646-1-chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Mar 2023 10:16:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFybJ=snO5YG=6Uy2Qoi98b-6YTKX0Z9=1GPn=JMdxUiQ@mail.gmail.com>
Message-ID: <CAMj1kXFybJ=snO5YG=6Uy2Qoi98b-6YTKX0Z9=1GPn=JMdxUiQ@mail.gmail.com>
Subject: Re: [PATCH] efi/loongarch: Reintroduce efi_relocate_kernel() to
 relocate kernel
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

On Wed, 1 Mar 2023 at 09:55, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Since Linux-6.3, LoongArch supports PIE kernel now, so let's reintroduce
> efi_relocate_kernel() to relocate the core kernel.
>

Nice!

I assume you will need to make a similar change for zboot?

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/firmware/efi/libstub/loongarch-stub.c | 24 ++++++-------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> index eee7ed43cdfb..72c71ae201f0 100644
> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> @@ -21,26 +21,16 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>                                  efi_loaded_image_t *image,
>                                  efi_handle_t image_handle)
>  {
> -       int nr_pages = round_up(kernel_asize, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
> -       efi_physical_addr_t kernel_addr = EFI_KIMG_PREFERRED_ADDRESS;
>         efi_status_t status;
> +       unsigned long kernel_addr = 0;
>
> -       /*
> -        * Allocate space for the kernel image at the preferred offset. This is
> -        * the only location in memory from where we can execute the image, so
> -        * no point in falling back to another allocation.
> -        */
> -       status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> -                            EFI_LOADER_DATA, nr_pages, &kernel_addr);
> -       if (status != EFI_SUCCESS)
> -               return status;
> -
> -       *image_addr = EFI_KIMG_PREFERRED_ADDRESS;
> -       *image_size = kernel_asize;
> +       kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
> +
> +       status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
> +                    EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align(), 0x0);
>
> -       memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
> -              (void *)&kernel_offset - kernel_offset,
> -              kernel_fsize);
> +       *image_addr = kernel_addr;
> +       *image_size = kernel_asize;
>
>         return status;
>  }
> --
> 2.39.1
>
