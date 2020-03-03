Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00931782D9
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 20:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgCCTIv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 14:08:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgCCTIu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 14:08:50 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73620208C3
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583262529;
        bh=mKE3HtE/aTkp0UlhtxahKZBgoDUFqA0POdykfcgqlGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cuPF82uYsyrRXu+Jp1Zf1mzesnqA7iSLVrZ/IxZAnf0DH1YwYVwaX0x71Pv6+DTd1
         0phCb1txHFJa4uWhoeezmLk8AGg/0LWBaLgh5XicGpPnkUP8rRfQjJJXCzSsrfse+l
         kpJuxlcZbqpGZKyk1I8BnbytPyjPiwjev8IgKaZ4=
Received: by mail-wm1-f48.google.com with SMTP id 6so4553126wmi.5
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 11:08:49 -0800 (PST)
X-Gm-Message-State: ANhLgQ0V5Hh/JXF0qLyZLap4e9ezM2T2md2Y84el75wgDFgIsNTBGPCM
        vVsl3nE6Et5ELEn7m1J9G6W9AKtyqT/4aXvSZOqvPw==
X-Google-Smtp-Source: ADFU+vu5OPgIYhOba6bSYHkKXk/xTSx4zBMO8fWnm/mwPAvL8SdOkwFOP2xVqup7Qh/wMYCkH7of+moi3EtFkyXzRY4=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr7779wmi.133.1583262527713;
 Tue, 03 Mar 2020 11:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu> <20200301230537.2247550-3-nivedita@alum.mit.edu>
In-Reply-To: <20200301230537.2247550-3-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 20:08:36 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-f=mZwxAyLOzkrtSFPpxsKweRU2rKBUwTK0_r7s6gZPQ@mail.gmail.com>
Message-ID: <CAKv+Gu-f=mZwxAyLOzkrtSFPpxsKweRU2rKBUwTK0_r7s6gZPQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] efi/x86: Decompress at start of PE image load address
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Mar 2020 at 00:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> When booted via PE loader, define image_offset to hold the offset of
> startup_32 from the start of the PE image, and use it as the start of
> the decompression buffer.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/head_32.S      | 17 +++++++++++
>  arch/x86/boot/compressed/head_64.S      | 38 +++++++++++++++++++++++--
>  drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++--
>  3 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 894182500606..98b224f5a025 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -100,6 +100,19 @@ SYM_FUNC_START(startup_32)
>
>  #ifdef CONFIG_RELOCATABLE
>         movl    %edx, %ebx
> +
> +#ifdef CONFIG_EFI_STUB
> +/*
> + * If we were loaded via the EFI LoadImage service, startup_32 will be at an
> + * offset to the start of the space allocated for the image. efi_pe_entry will
> + * setup image_offset to tell us where the image actually starts, so that we
> + * can use the full available buffer.
> + *     image_offset = startup_32 - image_base
> + * Otherwise image_offset will be zero and have no effect on the calculations.
> + */
> +       subl    image_offset(%edx), %ebx
> +#endif
> +
>         movl    BP_kernel_alignment(%esi), %eax
>         decl    %eax
>         addl    %eax, %ebx
> @@ -226,6 +239,10 @@ SYM_DATA_START_LOCAL(gdt)
>         .quad   0x00cf92000000ffff      /* __KERNEL_DS */
>  SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
>
> +#ifdef CONFIG_EFI_STUB
> +SYM_DATA(image_offset, .long 0)
> +#endif
> +
>  /*
>   * Stack and heap for uncompression
>   */
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 5d8338a693ce..1a4ea8738df0 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -99,6 +99,19 @@ SYM_FUNC_START(startup_32)
>
>  #ifdef CONFIG_RELOCATABLE
>         movl    %ebp, %ebx
> +
> +#ifdef CONFIG_EFI_STUB
> +/*
> + * If we were loaded via the EFI LoadImage service, startup_32 will be at an
> + * offset to the start of the space allocated for the image. efi_pe_entry will
> + * setup image_offset to tell us where the image actually starts, so that we
> + * can use the full available buffer.
> + *     image_offset = startup_32 - image_base
> + * Otherwise image_offset will be zero and have no effect on the calculations.
> + */
> +       subl    image_offset(%ebp), %ebx
> +#endif
> +
>         movl    BP_kernel_alignment(%esi), %eax
>         decl    %eax
>         addl    %eax, %ebx
> @@ -111,9 +124,8 @@ SYM_FUNC_START(startup_32)
>  1:
>
>         /* Target address to relocate to for decompression */
> -       movl    BP_init_size(%esi), %eax
> -       subl    $_end, %eax
> -       addl    %eax, %ebx
> +       addl    BP_init_size(%esi), %ebx
> +       subl    $_end, %ebx
>
>  /*
>   * Prepare for entering 64 bit mode
> @@ -299,6 +311,20 @@ SYM_CODE_START(startup_64)
>         /* Start with the delta to where the kernel will run at. */
>  #ifdef CONFIG_RELOCATABLE
>         leaq    startup_32(%rip) /* - $startup_32 */, %rbp
> +
> +#ifdef CONFIG_EFI_STUB
> +/*
> + * If we were loaded via the EFI LoadImage service, startup_32 will be at an
> + * offset to the start of the space allocated for the image. efi_pe_entry will
> + * setup image_offset to tell us where the image actually starts, so that we
> + * can use the full available buffer.
> + *     image_offset = startup_32 - image_base
> + * Otherwise image_offset will be zero and have no effect on the calculations.
> + */
> +       movl    image_offset(%rip), %eax
> +       subq    %rax, %rbp
> +#endif
> +
>         movl    BP_kernel_alignment(%rsi), %eax
>         decl    %eax
>         addq    %rax, %rbp
> @@ -647,6 +673,10 @@ SYM_DATA_START_LOCAL(gdt)
>         .quad   0x0000000000000000      /* TS continued */
>  SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
>
> +#ifdef CONFIG_EFI_STUB
> +SYM_DATA(image_offset, .long 0)
> +#endif
> +
>  #ifdef CONFIG_EFI_MIXED
>  SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
>  SYM_DATA(efi_is64, .byte 1)
> @@ -712,6 +742,8 @@ SYM_FUNC_START(efi32_pe_entry)
>         movl    -4(%ebp), %esi                  // loaded_image
>         movl    LI32_image_base(%esi), %esi     // loaded_image->image_base
>         movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry
> +       subl    %esi, %ebx
> +       movl    %ebx, image_offset(%ebp)        // save image_offset

So I guess we are assigning image_offset here because we need it to be
set before we get to efi_pe_entry() ?

I think that deserves a comment.

>         jmp     efi32_pe_stub_entry
>
>  2:     popl    %edi                            // restore callee-save registers
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 7f3e97c2aad3..0c4a6352cfd3 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -19,6 +19,7 @@
>
>  static efi_system_table_t *sys_table;
>  extern const bool efi_is64;
> +extern u32 image_offset;
>
>  __pure efi_system_table_t *efi_system_table(void)
>  {
> @@ -364,6 +365,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         struct boot_params *boot_params;
>         struct setup_header *hdr;
>         efi_loaded_image_t *image;
> +       void *image_base;
>         efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
>         int options_size = 0;
>         efi_status_t status;
> @@ -384,7 +386,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>                 efi_exit(handle, status);
>         }
>
> -       hdr = &((struct boot_params *)efi_table_attr(image, image_base))->hdr;
> +       image_base = efi_table_attr(image, image_base);
> +       image_offset = (void *)startup_32 - image_base;
> +
> +       hdr = &((struct boot_params *)image_base)->hdr;
>         above4g = hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G;
>
>         status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params,
> @@ -399,7 +404,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         hdr = &boot_params->hdr;
>
>         /* Copy the second sector to boot_params */
> -       memcpy(&hdr->jump, efi_table_attr(image, image_base) + 512, 512);
> +       memcpy(&hdr->jump, image_base + 512, 512);
>
>         /*
>          * Fill out some of the header fields ourselves because the
> @@ -726,7 +731,7 @@ unsigned long efi_main(efi_handle_t handle,
>          * If the kernel isn't already loaded at the preferred load
>          * address, relocate it.
>          */
> -       if (bzimage_addr != hdr->pref_address) {
> +       if (bzimage_addr - image_offset != hdr->pref_address) {
>                 status = efi_relocate_kernel(&bzimage_addr,
>                                              hdr->init_size, hdr->init_size,
>                                              hdr->pref_address,
> @@ -736,6 +741,7 @@ unsigned long efi_main(efi_handle_t handle,
>                         efi_printk("efi_relocate_kernel() failed!\n");
>                         goto fail;
>                 }
> +               image_offset = 0;

Again, this could do with a comment why this should be 0x0 for the
relocated image. It may all seem super obvious now, but our future
selves are probably not as smart as we are today :-)

>         }
>
>         /*
> --
> 2.24.1
>
