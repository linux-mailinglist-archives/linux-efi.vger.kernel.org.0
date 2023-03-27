Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D96CA1D3
	for <lists+linux-efi@lfdr.de>; Mon, 27 Mar 2023 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjC0K5n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Mar 2023 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC0K5m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Mar 2023 06:57:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17ECFE
        for <linux-efi@vger.kernel.org>; Mon, 27 Mar 2023 03:57:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9571EB80C71
        for <linux-efi@vger.kernel.org>; Mon, 27 Mar 2023 10:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450FDC433EF
        for <linux-efi@vger.kernel.org>; Mon, 27 Mar 2023 10:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679914658;
        bh=M0lyeCYiAubYBmj7L+RlRHKmsaKc/JhPoGXtQ36DfLU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IGWP7LjJWPx4hfJlR6iGUdZHTWfaos4mC8njqhF2WaTOr8pL5vZH9mxFmAGb5sbwK
         CwYO7YKtmcL75flAOFjzqtaVkslPZT9oPuwBFLJPKDVlV/460kLwci1XV5HPYQ2Je5
         7vcUROoI0PhSkoMpDWRSz/C9WH+hORYg6en8jZIxKNx3OZJCu8ViUKe2dc7/EI0vys
         KIuOdAjdiRdSfzqo7GPDb//raXosW24W/8YUQlzUWG2laYcBxHx8TH23c7XT2u8KJg
         ebl7iaGKsxgBDOFeCKsI6fDjEfKNHta/7kFDwsHj/NqUK2J5jj9d7CdYGDBQ3xJ+PR
         ZuTmW5Cly30tQ==
Received: by mail-lj1-f171.google.com with SMTP id s20so8509074ljp.1
        for <linux-efi@vger.kernel.org>; Mon, 27 Mar 2023 03:57:38 -0700 (PDT)
X-Gm-Message-State: AAQBX9crTFEW0Pc+6Ori5bDxJP8gFiJL1N1eHEKofpQLVN6vbIx2Fqvy
        7Mtyh+REeu3WxPk6TvxMS4B6Y1V+FGO0WsDOBGc=
X-Google-Smtp-Source: AKy350bkKgiMcnmYXJ4eOGCl9cTfYB/7cuCRaZbyp4gfD1mWkZEGR354xhF+LOAEm/uPH/lhRYvQQiv8cUxMFPxqphg=
X-Received: by 2002:a2e:9d47:0:b0:29b:28cb:bea6 with SMTP id
 y7-20020a2e9d47000000b0029b28cbbea6mr3393153ljj.2.1679914656340; Mon, 27 Mar
 2023 03:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230327095123.20023-1-kernelfans@gmail.com>
In-Reply-To: <20230327095123.20023-1-kernelfans@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Mar 2023 12:57:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
Message-ID: <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
Subject: Re: [PATCH] efi: zboot: Ensure zboot PIC
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 27 Mar 2023 at 11:51, Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Using objcopy to reform vmlinuz.efi.elf to vmlinuz.efi will not convey
> any relocation information. That means vmlinuz.efi is expected to be
> PIC.
>
> At present, vmlinuz.efi is PIC. But it is better to adopt the same

Why is it better?

> solution used by the kernel to resolve the code relocation issue by
> itself. That is to resolve R_AARCH64_RELATIVE at the runtime.
>

This breaks other architectures.

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> To: linux-efi@vger.kernel.org


> ---
>  drivers/firmware/efi/libstub/Makefile       |  2 +-
>  drivers/firmware/efi/libstub/Makefile.zboot |  2 +-
>  drivers/firmware/efi/libstub/zboot-entry.S  | 35 +++++++++++++++++++++
>  drivers/firmware/efi/libstub/zboot.c        |  2 +-
>  drivers/firmware/efi/libstub/zboot.lds      |  6 ++++
>  5 files changed, 44 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/zboot-entry.S
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 80d85a5169fb..4447395d7218 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -95,7 +95,7 @@ lib-$(CONFIG_LOONGARCH)               += loongarch.o loongarch-stub.o
>  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>
>  zboot-obj-$(CONFIG_RISCV)      := lib-clz_ctz.o lib-ashldi3.o
> -lib-$(CONFIG_EFI_ZBOOT)                += zboot.o $(zboot-obj-y)
> +lib-$(CONFIG_EFI_ZBOOT)                += zboot-entry.o zboot.o $(zboot-obj-y)
>
>  extra-y                                := $(lib-y)
>  lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> index 43e9a4cab9f5..1ed948cee92f 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -36,7 +36,7 @@ $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FO
>
>  ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> -LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
> +LDFLAGS_vmlinuz.efi.elf :=  --no-undefined -X -shared -Bsymbolic -z notext --no-apply-dynamic-relocs -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
>  $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
>         $(call if_changed,ld)
>
> diff --git a/drivers/firmware/efi/libstub/zboot-entry.S b/drivers/firmware/efi/libstub/zboot-entry.S
> new file mode 100644
> index 000000000000..072207f2f6ba
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/zboot-entry.S
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include <asm/elf.h>
> +#define ZBOOT_HEADER_BASE 0
> +
> +       .text
> +/*
> + * x0: efi_handle_t
> + * x1: efi_system_table_t *
> + */
> +       .global efi_zboot_entry
> +efi_zboot_entry:
> +       adrp    x2, efi_zboot_header
> +       add     x2, x2, :lo12:efi_zboot_header
> +       mov     x3, ZBOOT_HEADER_BASE
> +       sub     x3, x2, x3              // delta between actual and linked address
> +       adrp    x4, _rela_start
> +       add     x4, x4, :lo12:_rela_start
> +       adrp    x5, _rela_end
> +       add     x5, x5, :lo12:_rela_end
> +
> +0:     cmp     x5, x4
> +       b.hs    1f
> +       ldp     x6, x7, [x4], #24
> +       ldr     x8, [x4, #-8]
> +       cmp     w7, #R_AARCH64_RELATIVE
> +       b.ne    0b
> +       add     x8, x8, x3
> +       str     x8, [x6, x3]
> +       b       0b
> +
> +1:
> +       dsb     ishst
> +       ic      iallu
> +       b       efi_zboot_main
> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> index ba234e062a1a..7aa6b2e6d104 100644
> --- a/drivers/firmware/efi/libstub/zboot.c
> +++ b/drivers/firmware/efi/libstub/zboot.c
> @@ -58,7 +58,7 @@ void __weak efi_cache_sync_image(unsigned long image_base,
>  }
>
>  asmlinkage efi_status_t __efiapi
> -efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
> +efi_zboot_main(efi_handle_t handle, efi_system_table_t *systab)
>  {
>         unsigned long compressed_size = _gzdata_end - _gzdata_start;
>         unsigned long image_base, alloc_size, code_size;
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index 93d33f68333b..631942604c3f 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -12,6 +12,12 @@ SECTIONS
>                 *(.text* .init.text*)
>         }
>
> +       .rela.dyn : ALIGN(8) {
> +               __efistub__rela_start = .;
> +               *(.rela .rela*)
> +               __efistub__rela_end = .;
> +       }
> +
>         .rodata : ALIGN(8) {
>                 __efistub__gzdata_start = .;
>                 *(.gzdata)
> --
> 2.31.1
>
