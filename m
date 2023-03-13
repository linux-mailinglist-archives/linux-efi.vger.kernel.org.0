Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFFD6B703A
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 08:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCMHpx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 03:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMHpw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 03:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE928D28
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D349761128
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 07:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38662C4339C
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678693550;
        bh=ZKMPBYcrfQLP8JgYbOCW8NaYkHCzlLgdsfOQ5o4lnKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R2ERRihdgajL6YANL4HC7/w+t6NHMiOpTSrgRZCCxKS0wPzpkPHCm3GdC3jPhiocn
         htXvQOW+WSKGjjnKVpqsmyYthKMNBYO/LU29ORJm4eiC+XsKwoOxdR3NhBNLD7hdYz
         2Q4ER7cfgwFklfKF8H2ziMK0IerEV2rVbQvYfZqgP7qqhc/RsUaPsoWUw07WnY+VOg
         7j0GQvA+FY8c8BvqbEUgekQuT6Cd3K484a7m6tCQ0hUL2XIVPMnU9SO0Tu9adYy3qt
         u/aS0lWVOqVABJcUTZ/LgONAXw9NFqHGYBKKcU2qIklnpCU6Neb6NKf3bSrHHZFERs
         b4bGEqIOoRrvA==
Received: by mail-lf1-f44.google.com with SMTP id m4so1474402lfj.2
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:45:50 -0700 (PDT)
X-Gm-Message-State: AO0yUKV2LjrSaUUeZBvUyUpq272ShJQ9Tz3ySf1tUB6U0cpZan7ZGr8g
        fEDCE1hliPXViQeiMHbsJUM1G3rrYSXjFzMogks=
X-Google-Smtp-Source: AK7set+6NzUdKiSERR5UqgAqYmN5vpH2hC7YlrmxcqSHAL9Ct66eEi4HWQqDgziTUw1ZZ1UHRh6nUFyeRMu5sQtfWvE=
X-Received: by 2002:ac2:4c2e:0:b0:4d5:ca32:6ae4 with SMTP id
 u14-20020ac24c2e000000b004d5ca326ae4mr10123779lfq.4.1678693548189; Mon, 13
 Mar 2023 00:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230312225838.3702574-1-ardb@kernel.org>
In-Reply-To: <20230312225838.3702574-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Mar 2023 08:45:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGeL8p5Ctg=fsCnJYqmA8NHeN9uMgO1JWVxoiyBdSau4Q@mail.gmail.com>
Message-ID: <CAMj1kXGeL8p5Ctg=fsCnJYqmA8NHeN9uMgO1JWVxoiyBdSau4Q@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Always pass screen_info via config table
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

On Sun, 12 Mar 2023 at 23:58, Ard Biesheuvel <ardb@kernel.org> wrote:
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
> To fix this and simplify things at the same time, let's just always use
> the config table method.
>
> Cc: loongarch@lists.linux.dev
> Cc: Xuefeng Li <lixuefeng@loongson.cn>
> Cc: Xuerui Wang <kernel@xen0n.name>
> Cc: loongson-kernel@lists.loongnix.cn
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuacai@loongson.cn/
> Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Please disregard - I think I can simplify this without losing the very
early earlycon.


> ---
>  arch/arm64/kernel/image-vars.h             |  1 -
>  arch/loongarch/kernel/image-vars.h         |  1 -
>  arch/riscv/kernel/image-vars.h             |  1 -
>  drivers/firmware/efi/libstub/efi-stub.c    |  9 ---------
>  drivers/firmware/efi/libstub/screen_info.c | 19 -------------------
>  5 files changed, 31 deletions(-)
>
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 8309197c0ebd4a8e..01382bd99d0addea 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -27,7 +27,6 @@ PROVIDE(__efistub__text                       = _text);
>  PROVIDE(__efistub__end                 = _end);
>  PROVIDE(__efistub___inittext_end               = __inittext_end);
>  PROVIDE(__efistub__edata               = _edata);
> -PROVIDE(__efistub_screen_info          = screen_info);
>  PROVIDE(__efistub__ctype               = _ctype);
>
>  PROVIDE(__pi___memcpy                  = __pi_memcpy);
> diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
> index e561989d02de93c5..110cdc32cba5f28b 100644
> --- a/arch/loongarch/kernel/image-vars.h
> +++ b/arch/loongarch/kernel/image-vars.h
> @@ -12,7 +12,6 @@ __efistub_kernel_entry                = kernel_entry;
>  __efistub_kernel_asize         = kernel_asize;
>  __efistub_kernel_fsize         = kernel_fsize;
>  __efistub_kernel_offset                = kernel_offset;
> -__efistub_screen_info          = screen_info;
>
>  #endif
>
> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> index 7e2962ef73f92e95..5e2515fa013495cb 100644
> --- a/arch/riscv/kernel/image-vars.h
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -29,7 +29,6 @@ __efistub__start              = _start;
>  __efistub__start_kernel                = _start_kernel;
>  __efistub__end                 = _end;
>  __efistub__edata               = _edata;
> -__efistub_screen_info          = screen_info;
>
>  #endif
>
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
> index 8e76a8b384ba142d..7b791541a1ad1b48 100644
> --- a/drivers/firmware/efi/libstub/screen_info.c
> +++ b/drivers/firmware/efi/libstub/screen_info.c
> @@ -5,25 +5,6 @@
>
>  #include "efistub.h"
>
> -/*
> - * There are two ways of populating the core kernel's struct screen_info via the stub:
> - * - using a configuration table, like below, which relies on the EFI init code
> - *   to locate the table and copy the contents;
> - * - by linking directly to the core kernel's copy of the global symbol.
> - *
> - * The latter is preferred because it makes the EFIFB earlycon available very
> - * early, but it only works if the EFI stub is part of the core kernel image
> - * itself. The zboot decompressor can only use the configuration table
> - * approach.
> - *
> - * In order to support both methods from the same build of the EFI stub
> - * library, provide this dummy global definition of struct screen_info. If it
> - * is required to satisfy a link dependency, it means we need to override the
> - * __weak alloc and free methods with the ones below, and those will be pulled
> - * in as well.
> - */
> -struct screen_info screen_info;
> -
>  static efi_guid_t screen_info_guid = LINUX_EFI_SCREEN_INFO_TABLE_GUID;
>
>  struct screen_info *alloc_screen_info(void)
> --
> 2.39.2
>
