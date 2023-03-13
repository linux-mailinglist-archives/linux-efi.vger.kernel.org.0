Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6036B719C
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 09:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCMIvi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 04:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCMIu6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 04:50:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA54FF0A
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 01:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 72009CE0EC8
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 08:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955FFC433D2
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678697302;
        bh=+DbQKe7hrt+KUG/wuvemcgzf1ZPH76x53joSbhJsicE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=obmcX4O00hMQUIaEqZD+KbLtn5eQ5l2NIVMN0Oj4KzHfx2f9v6M35lQN8oB21GM8H
         m7WWh1YtSvQSFCtAE6J0tsSSVJnROgrOPktXIjBv9NqDrXZB7wChnrbqBfGneOiM6k
         S9E4lLSH1NpAvlNUu8MxmzXmKC9tVE+vBGYld0o9JFLoOzJwXffymhJXRDvtmyF92A
         +B7yhjuWvLNoLXj+iQsZMydCsRZI0Q8xyUMUeK6lakqVJ3dXd6enFgcHzXUX6tvYKO
         9MHOahej8KpXu5aafZvBJNqSpQkxXoawcSozMAOzmScSeaa/zUPxW/ojTADQcWTlyh
         feFXnsCoBL9HQ==
Received: by mail-lf1-f52.google.com with SMTP id n2so14626613lfb.12
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 01:48:22 -0700 (PDT)
X-Gm-Message-State: AO0yUKXBNY2CME0ERcG4gL/i7/DuajEUp/cPtmS5H9sxx/+pN4eVst+l
        5HxqZlflRKhrEadHBEBqk93JIwne0eZsyBSU5pk=
X-Google-Smtp-Source: AK7set/U0P1/BMANqcZ6utTxAsGL2IA04u0QZRigG2g8xGNiO8rFLoe0oRBFrBYdDCdI20aRFPaRXq2fKSCzXIPdls4=
X-Received: by 2002:ac2:5dc7:0:b0:4dd:98c6:ee3 with SMTP id
 x7-20020ac25dc7000000b004dd98c60ee3mr10596308lfq.4.1678697300673; Mon, 13 Mar
 2023 01:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230313081432.3769496-1-ardb@kernel.org>
In-Reply-To: <20230313081432.3769496-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Mar 2023 09:48:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFBB9DK_zNL2h2=5-8P+VzOO=K1SgJ+07C55zbZoMHRLw@mail.gmail.com>
Message-ID: <CAMj1kXFBB9DK_zNL2h2=5-8P+VzOO=K1SgJ+07C55zbZoMHRLw@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Use relocated version of kernel's struct screen_info
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Mar 2023 at 09:14, Ard Biesheuvel <ardb@kernel.org> wrote:
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
> So let's ensure that alloc_screen_info() produces the correct
> screen_info pointer, by keeping its relocated address in a global
> variable.
>
> Cc: loongarch@lists.linux.dev
> Cc: Xuefeng Li <lixuefeng@loongson.cn>
> Cc: Xuerui Wang <kernel@xen0n.name>
> Cc: loongson-kernel@lists.loongnix.cn
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuacai@loongson.cn/
> Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

This is still not working :-(

> ---
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 14 ++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub.c       |  9 ---------
>  drivers/firmware/efi/libstub/screen_info.c    |  7 -------
>  3 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index 5245c4f031c0a70a..883ef2c88f522c4b 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -5,6 +5,17 @@
>
>  #include "efistub.h"
>
> +static struct screen_info *si;
> +
> +struct screen_info *alloc_screen_info(void)
> +{
> +       return si;
> +}
> +
> +void free_screen_info(struct screen_info *si)
> +{
> +}
> +
>  /*
>   * EFI entry point for the generic EFI stub used by ARM, arm64, RISC-V and
>   * LoongArch. This is the entrypoint that is described in the PE/COFF header
> @@ -56,6 +67,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>                 return status;
>         }
>
> +       /* point si to the relocated copy of struct screen_info */
> +       si = (void *)&screen_info + image_addr - (unsigned long)image->image_base;
> +
>         status = efi_stub_common(handle, image, image_addr, cmdline_ptr);
>
>         efi_free(image_size, image_addr);
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 2955c1ac6a36ee00..c4b9eccad0f103dc 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -47,15 +47,6 @@
>  static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
>  static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
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
>         efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
> index 8e76a8b384ba142d..b2637420fe53911e 100644
> --- a/drivers/firmware/efi/libstub/screen_info.c
> +++ b/drivers/firmware/efi/libstub/screen_info.c
> @@ -15,14 +15,7 @@
>   * early, but it only works if the EFI stub is part of the core kernel image
>   * itself. The zboot decompressor can only use the configuration table
>   * approach.
> - *
> - * In order to support both methods from the same build of the EFI stub
> - * library, provide this dummy global definition of struct screen_info. If it
> - * is required to satisfy a link dependency, it means we need to override the
> - * __weak alloc and free methods with the ones below, and those will be pulled
> - * in as well.
>   */
> -struct screen_info screen_info;
>
>  static efi_guid_t screen_info_guid = LINUX_EFI_SCREEN_INFO_TABLE_GUID;
>
> --
> 2.39.2
>
