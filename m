Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284481782F1
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 20:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgCCTPp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 14:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbgCCTPn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 14:15:43 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB14F2073B
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583262941;
        bh=X9Yf9HU7bkYdwj/Oz/QtiPCpUgJ6zgCXdNdmoiqJdzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TUwWs6u0BK+bZSnRr6kK3Wi9CnNLaN0qzU0uUoboizhwcpCWlrBViHOCeZPRoxa8o
         mKgLTStDsnOy2nLGmcvk+Ywb4ildVip+6LhXD+vvsKiwyHmMfNneKObfWdaAYptpcU
         57xa/H+EBR6eevvmp2Sm0YPhA64s/9dUk8KwYPq0=
Received: by mail-wr1-f52.google.com with SMTP id r17so5868644wrj.7
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 11:15:41 -0800 (PST)
X-Gm-Message-State: ANhLgQ3uEbcYBcOkn7LL4qfsQVi4/K6sqABRnP+5++7Sfj6YwHHcmSOE
        lcTXYtvV7LFVbHG7ydDtzI6u9xWAzy7Hz+neu/C6EQ==
X-Google-Smtp-Source: ADFU+vviylojPwdySE5n+zIHUiFue0P60nexG3bVhMvRSXoSBvap6SIOGaoczvCpC1jKjSaBvxtjm3Bwhv0KjkAahjM=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr6969832wrw.252.1583262940064;
 Tue, 03 Mar 2020 11:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu> <20200301230537.2247550-6-nivedita@alum.mit.edu>
In-Reply-To: <20200301230537.2247550-6-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 20:15:29 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_g-Yf0--gC-zKbQbfR-8=+NMCo=kmLD-NwOxgST6e63g@mail.gmail.com>
Message-ID: <CAKv+Gu_g-Yf0--gC-zKbQbfR-8=+NMCo=kmLD-NwOxgST6e63g@mail.gmail.com>
Subject: Re: [PATCH 5/5] efi/x86: Don't relocate the kernel unless necessary
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
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/tools/build.c             | 16 ++++++----------
>  drivers/firmware/efi/libstub/x86-stub.c | 22 +++++++++++++++++++---
>  2 files changed, 25 insertions(+), 13 deletions(-)
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
> index 0c4a6352cfd3..957feeacdd8f 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -717,6 +717,7 @@ unsigned long efi_main(efi_handle_t handle,
>                              struct boot_params *boot_params)
>  {
>         unsigned long bzimage_addr = (unsigned long)startup_32;
> +       unsigned long buffer_start, buffer_end;
>         struct setup_header *hdr = &boot_params->hdr;
>         efi_status_t status;
>         unsigned long cmdline_paddr;
> @@ -728,10 +729,25 @@ unsigned long efi_main(efi_handle_t handle,
>                 efi_exit(handle, EFI_INVALID_PARAMETER);
>
>         /*
> -        * If the kernel isn't already loaded at the preferred load
> -        * address, relocate it.
> +        * If the kernel isn't already loaded at a suitable address,
> +        * relocate it.
> +        * It must be loaded above LOAD_PHYSICAL_ADDR.
> +        * The maximum address for 64-bit is 1 << 46 for 4-level paging.
> +        * For 32-bit, the maximum address is complicated to figure out, for
> +        * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
> +        * KASLR uses.
> +        * Also relocate it if image_offset is zero, i.e. we weren't loaded by
> +        * LoadImage, but we are not aligned correctly.
>          */
> -       if (bzimage_addr - image_offset != hdr->pref_address) {
> +       buffer_start = ALIGN(bzimage_addr - image_offset,
> +                            hdr->kernel_alignment);
> +       buffer_end = buffer_start + hdr->init_size;
> +
> +       if (buffer_start < LOAD_PHYSICAL_ADDR
> +           || IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE
> +           || IS_ENABLED(CONFIG_X86_64) && buffer_end > 1ull << 46
> +           || image_offset == 0 && !IS_ALIGNED(bzimage_addr,
> +                                               hdr->kernel_alignment)) {

Could you please
- put the || at the end
- put () around the terms
- add a #define for 1ull << 46


>                 status = efi_relocate_kernel(&bzimage_addr,
>                                              hdr->init_size, hdr->init_size,
>                                              hdr->pref_address,
> --
> 2.24.1
>
