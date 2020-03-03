Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0536178620
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 00:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgCCXIr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 18:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbgCCXIq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 18:08:46 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A429120866
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583276925;
        bh=Zhexf+t5rjSF6lDODnx2yi8LXcdCC2u1PQcGluLFGWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xp0maKDkYbJU3BCPo9SgBAleRcnS/tacsnRdjIpJnosb3LbdK25X2T9lF8Wa+zLty
         Cv3BILFzW7tv5UUDGQSL3b1nV++zQbo8cbvgUnKRL9jX365TCF0olpj1FRn5r5A1aH
         saWygbhbYOCOQxGnf6kQh5Qk433idS739Nuj5468=
Received: by mail-wm1-f43.google.com with SMTP id e26so4640870wme.5
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 15:08:45 -0800 (PST)
X-Gm-Message-State: ANhLgQ3vuWi7UGrYY+/Qo/mD0WgjqVhETHHybojOWe+I0eJf6wejr1d2
        vwXIatH9zfq46RL2WOEK8cM1LDcXSgMA/YfSXKppxw==
X-Google-Smtp-Source: ADFU+vvi85lSN182YUU+MdiVv0/nM2RfPEoUUxoqYxw2FXb3q7PSm8aIboX0yJXqJwlmniib7znXh1lZc96RVYeyF0w=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr765473wmi.133.1583276924026;
 Tue, 03 Mar 2020 15:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu> <20200303221205.4048668-6-nivedita@alum.mit.edu>
In-Reply-To: <20200303221205.4048668-6-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 00:08:33 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9LON5SeJ7UMTeHxP1OcSkz_eGGunpXx_csjh_fp1PhDA@mail.gmail.com>
Message-ID: <CAKv+Gu9LON5SeJ7UMTeHxP1OcSkz_eGGunpXx_csjh_fp1PhDA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] efi/x86: Don't relocate the kernel unless necessary
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Mar 2020 at 23:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Add alignment slack to the PE image size, so that we can realign the
> decompression buffer within the space allocated for the image.
>
> Only relocate the kernel if it has been loaded at an unsuitable address:
> * Below LOAD_PHYSICAL_ADDR, or
> * Above 64T for 64-bit and 512MiB for 32-bit
>
> For 32-bit, the upper limit is conservative, but the exact limit can be
> difficult to calculate.
>

Could we get rid of the call to efi_low_alloc_above() in
efi_relocate_kernel(), and just allocate top down with the right
alignment? I'd like to get rid of efi_low_alloc() et al if we can.



> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/tools/build.c             | 16 +++++-------
>  drivers/firmware/efi/libstub/x86-stub.c | 33 ++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> index 3d03ad753ed5..db528961c283 100644
> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -238,21 +238,17 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
>
>         pe_header = get_unaligned_le32(&buf[0x3c]);
>
> -#ifdef CONFIG_EFI_MIXED
>         /*
> -        * In mixed mode, we will execute startup_32() at whichever offset in
> -        * memory it happened to land when the PE/COFF loader loaded the image,
> -        * which may be misaligned with respect to the kernel_alignment field
> -        * in the setup header.
> +        * The PE/COFF loader may load the image at an address which is
> +        * misaligned with respect to the kernel_alignment field in the setup
> +        * header.
>          *
> -        * In order for startup_32 to safely execute in place at this offset,
> -        * we need to ensure that the CONFIG_PHYSICAL_ALIGN aligned allocation
> -        * it creates for the page tables does not extend beyond the declared
> -        * size of the image in the PE/COFF header. So add the required slack.
> +        * In order to avoid relocating the kernel to correct the misalignment,
> +        * add slack to allow the buffer to be aligned within the declared size
> +        * of the image.
>          */
>         bss_sz  += CONFIG_PHYSICAL_ALIGN;
>         init_sz += CONFIG_PHYSICAL_ALIGN;
> -#endif
>
>         /*
>          * Size of code: Subtract the size of the first sector (512 bytes)
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index e71b8421e088..fbc4354f534c 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -17,6 +17,9 @@
>
>  #include "efistub.h"
>
> +/* Maximum physical address for 64-bit kernel with 4-level paging */
> +#define MAXMEM_X86_64_4LEVEL (1ull << 46)
> +
>  static efi_system_table_t *sys_table;
>  extern const bool efi_is64;
>  extern u32 image_offset;
> @@ -717,6 +720,7 @@ unsigned long efi_main(efi_handle_t handle,
>                              struct boot_params *boot_params)
>  {
>         unsigned long bzimage_addr = (unsigned long)startup_32;
> +       unsigned long buffer_start, buffer_end;
>         struct setup_header *hdr = &boot_params->hdr;
>         efi_status_t status;
>         unsigned long cmdline_paddr;
> @@ -728,10 +732,33 @@ unsigned long efi_main(efi_handle_t handle,
>                 efi_exit(handle, EFI_INVALID_PARAMETER);
>
>         /*
> -        * If the kernel isn't already loaded at the preferred load
> -        * address, relocate it.
> +        * If the kernel isn't already loaded at a suitable address,
> +        * relocate it.
> +        *
> +        * It must be loaded above LOAD_PHYSICAL_ADDR.
> +        *
> +        * The maximum address for 64-bit is 1 << 46 for 4-level paging. This
> +        * is defined as the macro MAXMEM, but unfortunately that is not a
> +        * compile-time constant if 5-level paging is configured, so we instead
> +        * define our own macro for use here.
> +        *
> +        * For 32-bit, the maximum address is complicated to figure out, for
> +        * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
> +        * KASLR uses.
> +        *
> +        * Also relocate it if image_offset is zero, i.e. we weren't loaded by
> +        * LoadImage, but we are not aligned correctly.
>          */
> -       if (bzimage_addr - image_offset != hdr->pref_address) {
> +
> +       buffer_start = ALIGN(bzimage_addr - image_offset,
> +                            hdr->kernel_alignment);
> +       buffer_end = buffer_start + hdr->init_size;
> +
> +       if ((buffer_start < LOAD_PHYSICAL_ADDR)                              ||
> +           (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
> +           (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
> +           (image_offset == 0 && !IS_ALIGNED(bzimage_addr,
> +                                             hdr->kernel_alignment))) {
>                 status = efi_relocate_kernel(&bzimage_addr,
>                                              hdr->init_size, hdr->init_size,
>                                              hdr->pref_address,
> --
> 2.24.1
>
