Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04F178599
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 23:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgCCW0P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 17:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgCCW0P (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 17:26:15 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E8A20848
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 22:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583274374;
        bh=IQRk+eFyYJbHwb5eI2wYOOU5Ad0xyo8Ui/jniBEGSF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H1iXvAO8KqFpuVbyeWy2cJXvNy03pBgZ3Z4aFPJy1/64efKNP8vtdwTu47HOQ8DEd
         LjJrSdVI4VJg9GPFvawj+9RlHGZolWEDJx9ocnJE9WBk5JAQtxx+eBhE5A8GEWpPux
         ZZF7PYIUeJL970gwHM6u2b3y2na2ZGVqVo+oeKvM=
Received: by mail-wr1-f43.google.com with SMTP id x7so6524336wrr.0
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 14:26:14 -0800 (PST)
X-Gm-Message-State: ANhLgQ1Y/IVIzXQsucogiBeL6oh7iTAv8hxSs2CLxZ3XNRep1ZmrEJCQ
        wdH8YKpcD14pwpQiAc8soyzoyG3ghH4dEtldz8EpnA==
X-Google-Smtp-Source: ADFU+vu1fLRYbCKGQ/5O+V3FsnX68e8PkwyG8jiBMrqAlOtj12J1JrgdIvP+mFodyfHh5And3nvSwNdP+60iKiui/Gs=
X-Received: by 2002:adf:e742:: with SMTP id c2mr193882wrn.262.1583274372835;
 Tue, 03 Mar 2020 14:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu> <20200303221205.4048668-1-nivedita@alum.mit.edu>
In-Reply-To: <20200303221205.4048668-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 23:26:01 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_S_BwKRXhRz2=AoNj2E8sxuXSfZwg2poLDq96FmaoVtA@mail.gmail.com>
Message-ID: <CAKv+Gu_S_BwKRXhRz2=AoNj2E8sxuXSfZwg2poLDq96FmaoVtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Minimize the need to move the kernel in the EFI stub
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
> This series adds the ability to use the entire PE image space for
> decompression, provides the preferred address to the PE loader via the
> header, and finally restricts efi_relocate_kernel to cases where we
> really need it rather than whenever we were loaded at something other
> than preferred address.
>
> Based on tip:efi/core + the cleanup series [1]
> [1] https://lore.kernel.org/linux-efi/20200301230436.2246909-1-nivedita@alum.mit.edu/
>
> Changes from v1
> - clarify a few comments
> - cleanups to code formatting
>
> Arvind Sankar (5):
>   x86/boot/compressed/32: Save the output address instead of
>     recalculating it
>   efi/x86: Decompress at start of PE image load address
>   efi/x86: Add kernel preferred address to PE header
>   efi/x86: Remove extra headroom for setup block
>   efi/x86: Don't relocate the kernel unless necessary
>

Thanks. I have queued these up in efi/next, along with your mixed mode cleanups.


>  arch/x86/boot/compressed/head_32.S      | 42 +++++++++++++++-------
>  arch/x86/boot/compressed/head_64.S      | 42 ++++++++++++++++++++--
>  arch/x86/boot/header.S                  |  6 ++--
>  arch/x86/boot/tools/build.c             | 44 ++++++++++++++++-------
>  drivers/firmware/efi/libstub/x86-stub.c | 48 ++++++++++++++++++++++---
>  5 files changed, 147 insertions(+), 35 deletions(-)
>
> Range-diff against v1:
> 1:  0cdb6bf27a24 ! 1:  2ecbf60b9ecd x86/boot/compressed/32: Save the output address instead of recalculating it
>     @@ Metadata
>       ## Commit message ##
>          x86/boot/compressed/32: Save the output address instead of recalculating it
>
>     -    In preparation for being able to decompress starting at a different
>     -    address than startup_32, save the calculated output address instead of
>     -    recalculating it later.
>     +    In preparation for being able to decompress into a buffer starting at a
>     +    different address than startup_32, save the calculated output address
>     +    instead of recalculating it later.
>
>          We now keep track of three addresses:
>                  %edx: startup_32 as we were loaded by bootloader
> 2:  d4df840752ac ! 2:  e2bdbe6cb692 efi/x86: Decompress at start of PE image load address
>     @@ arch/x86/boot/compressed/head_64.S: SYM_FUNC_START(efi32_pe_entry)
>         movl    -4(%ebp), %esi                  // loaded_image
>         movl    LI32_image_base(%esi), %esi     // loaded_image->image_base
>         movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry
>     ++  /*
>     ++   * We need to set the image_offset variable here since startup_32 will
>     ++   * use it before we get to the 64-bit efi_pe_entry in C code.
>     ++   */
>      +  subl    %esi, %ebx
>      +  movl    %ebx, image_offset(%ebp)        // save image_offset
>         jmp     efi32_pe_stub_entry
>     @@ drivers/firmware/efi/libstub/x86-stub.c: unsigned long efi_main(efi_handle_t han
>                         efi_printk("efi_relocate_kernel() failed!\n");
>                         goto fail;
>                 }
>     ++          /*
>     ++           * Now that we've copied the kernel elsewhere, we no longer
>     ++           * have a setup block before startup_32, so reset image_offset
>     ++           * to zero in case it was set earlier.
>     ++           */
>      +          image_offset = 0;
>         }
>
> 3:  4bae68f25b90 ! 3:  ea840f78f138 efi/x86: Add kernel preferred address to PE header
>     @@ arch/x86/boot/header.S: optional_header:
>
>       extra_header_fields:
>      +  # PE specification requires ImageBase to be 64k-aligned
>     -+  .set    ImageBase, (LOAD_PHYSICAL_ADDR+0xffff) & ~0xffff
>     ++  .set    image_base, (LOAD_PHYSICAL_ADDR + 0xffff) & ~0xffff
>       #ifdef CONFIG_X86_32
>      -  .long   0                               # ImageBase
>     -+  .long   ImageBase                       # ImageBase
>     ++  .long   image_base                      # ImageBase
>       #else
>      -  .quad   0                               # ImageBase
>     -+  .quad   ImageBase                       # ImageBase
>     ++  .quad   image_base                      # ImageBase
>       #endif
>         .long   0x20                            # SectionAlignment
>         .long   0x20                            # FileAlignment
> 4:  2330a25c6b0f ! 4:  c25a9b507d6d efi/x86: Remove extra headroom for setup block
>     @@ Commit message
>          account for setup block") added headroom to the PE image to account for
>          the setup block, which wasn't used for the decompression buffer.
>
>     -    Now that we decompress from the start of the image, this is no longer
>     -    required.
>     +    Now that the decompression buffer is located at the start of the image,
>     +    and includes the setup block, this is no longer required.
>
>          Add a check to make sure that the head section of the compressed kernel
>          won't overwrite itself while relocating. This is only for
> 5:  2081f91cbe75 ! 5:  d3dc3af1c7b8 efi/x86: Don't relocate the kernel unless necessary
>     @@ arch/x86/boot/tools/build.c: static void update_pecoff_text(unsigned int text_st
>          * Size of code: Subtract the size of the first sector (512 bytes)
>
>       ## drivers/firmware/efi/libstub/x86-stub.c ##
>     +@@
>     +
>     + #include "efistub.h"
>     +
>     ++/* Maximum physical address for 64-bit kernel with 4-level paging */
>     ++#define MAXMEM_X86_64_4LEVEL (1ull << 46)
>     ++
>     + static efi_system_table_t *sys_table;
>     + extern const bool efi_is64;
>     + extern u32 image_offset;
>      @@ drivers/firmware/efi/libstub/x86-stub.c: unsigned long efi_main(efi_handle_t handle,
>                              struct boot_params *boot_params)
>       {
>     @@ drivers/firmware/efi/libstub/x86-stub.c: unsigned long efi_main(efi_handle_t han
>      -   * address, relocate it.
>      +   * If the kernel isn't already loaded at a suitable address,
>      +   * relocate it.
>     ++   *
>      +   * It must be loaded above LOAD_PHYSICAL_ADDR.
>     -+   * The maximum address for 64-bit is 1 << 46 for 4-level paging.
>     ++   *
>     ++   * The maximum address for 64-bit is 1 << 46 for 4-level paging. This
>     ++   * is defined as the macro MAXMEM, but unfortunately that is not a
>     ++   * compile-time constant if 5-level paging is configured, so we instead
>     ++   * define our own macro for use here.
>     ++   *
>      +   * For 32-bit, the maximum address is complicated to figure out, for
>      +   * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
>      +   * KASLR uses.
>     ++   *
>      +   * Also relocate it if image_offset is zero, i.e. we weren't loaded by
>      +   * LoadImage, but we are not aligned correctly.
>          */
>      -  if (bzimage_addr - image_offset != hdr->pref_address) {
>     ++
>      +  buffer_start = ALIGN(bzimage_addr - image_offset,
>      +                       hdr->kernel_alignment);
>      +  buffer_end = buffer_start + hdr->init_size;
>      +
>     -+  if (buffer_start < LOAD_PHYSICAL_ADDR
>     -+      || IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE
>     -+      || IS_ENABLED(CONFIG_X86_64) && buffer_end > 1ull << 46
>     -+      || image_offset == 0 && !IS_ALIGNED(bzimage_addr,
>     -+                                          hdr->kernel_alignment)) {
>     ++  if ((buffer_start < LOAD_PHYSICAL_ADDR)                              ||
>     ++      (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
>     ++      (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
>     ++      (image_offset == 0 && !IS_ALIGNED(bzimage_addr,
>     ++                                        hdr->kernel_alignment))) {
>                 status = efi_relocate_kernel(&bzimage_addr,
>                                              hdr->init_size, hdr->init_size,
>                                              hdr->pref_address,
> --
> 2.24.1
>
