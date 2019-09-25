Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDECBBE136
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfIYPZ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 11:25:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38210 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfIYPZ0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Sep 2019 11:25:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so5432759wmi.3
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2019 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73pxrGADl05fvIhxtHyUr33GKnX1reVZ0Z0sd/GO+CE=;
        b=b5DW4/OTOul5dUZMfkjjRTjZrOLu7AQrCCelc+d2uQTcbcHVco8B5FW0l+5nCj2pz2
         tsNA9MHTncjXEkJXoWhMJe5tPYs2luUtwlmAZZp8METBjdXV9F6R01sIMOnFYGpkRV3W
         RbyLFdjBbZD03zoXwMeako+5VIPEkWDk6a6khCEOBOaDPbDVlu+ax4Jwv3N4sAWn+aVW
         QZwhY5N1grTygBhpXYJydN9vBqGGzAeBa0gGRp6t9aTD7A/sUmhkzgIp+NifNmuxBuw2
         g/VZJN1EcrhBp5AXrx3Cyx07vGOXQh/0UnFPjXaMOL+PhC1KnzuhzI3g2iT+byH7jQbP
         S0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73pxrGADl05fvIhxtHyUr33GKnX1reVZ0Z0sd/GO+CE=;
        b=qbsKMYR5/SioB7NOYNC0kshonMrUanxj5JLy9n3pnJb7jB0/cI+rfF3FizxL3w7G8o
         nchdUF8IpuY68tLMFnkHS45Ny+jEhTGaAJquPaBy/I1JiT/UUptj0kdbzToDrR+iG8Md
         fsQVAl+zOFbCxPiknxvtL36iQ4AsDx/zMo6zH3kDpEZoWQRzM9X/bOcsYbsP9xDfbcfl
         BXLj1J5zWRwcIG6nh6xH8iCZzqG329JacowSWtBzr159wDHj4hBm8elFxlYfUpvYkFBo
         +xh42yoN6TcIsyeR5NMbE1ew5gSw0e/YYJV2BQ0AVsulLDEx8kQt7iVhtEKi0FkoS9ZO
         z4JA==
X-Gm-Message-State: APjAAAXcF0w4ZQpIytjJAoQ2yo1etgkZPwuEx3JgxkObIkdEdenaxoup
        BdG43gxxGDEhm8Os8EAL7oGVL/BBiQwKCeeOIwvTrg==
X-Google-Smtp-Source: APXvYqy0tY+BzqhxLnEuXiL5jipzRnTerZer8xE1mmYCciMwhFV3LF+qARnXaB54MYSeTXTi37zD6cjtf5K56y1SlmI=
X-Received: by 2002:a7b:c451:: with SMTP id l17mr7792934wmi.61.1569425121379;
 Wed, 25 Sep 2019 08:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190919160521.13820-1-kasong@redhat.com>
In-Reply-To: <20190919160521.13820-1-kasong@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 17:25:09 +0200
Message-ID: <CAKv+Gu95NGPF7m9_K-0MDmti7XN++cfyYWRj6WEXqpYzDM9Btg@mail.gmail.com>
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Kairui Song <kasong@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Sep 2019 at 18:06, Kairui Song <kasong@redhat.com> wrote:
>
> Currently, kernel fails to boot on some HyperV VMs when using EFI.
> And it's a potential issue on all platforms.
>
> It's caused a broken kernel relocation on EFI systems, when below three
> conditions are met:
>
> 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
>    by the loader.
> 2. There isn't enough room to contain the kernel, starting from the
>    default load address (eg. something else occupied part the region).
> 3. In the memmap provided by EFI firmware, there is a memory region
>    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
>    kernel.
>
> Efi stub will perform a kernel relocation when condition 1 is met. But
> due to condition 2, efi stub can't relocate kernel to the preferred
> address, so it fallback to query and alloc from EFI firmware for lowest
> usable memory region.
>
> It's incorrect to use the lowest memory address. In later stage, kernel
> will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> but efi stub will end up relocating kernel below it.
>
> Then before the kernel decompressing. Kernel will do another relocation
> to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> over write the blockage at the default load address, which efi stub tried
> to avoid, and lead to unexpected behavior. Beside, the memory region it
> writes to is not allocated from EFI firmware, which is also wrong.
>
> To fix it, just don't let efi stub relocate the kernel to any address
> lower than lowest acceptable address.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
>

Hello Kairui,

This patch looks correct to me, but it needs an ack from the x86
maintainers, since the rules around LOAD_PHYSICAL_ADDR are specific to
the x86 architecture.


> ---
>
> Update from V1:
>  - Redo the commit message.
>
>  arch/x86/boot/compressed/eboot.c               |  8 +++++---
>  drivers/firmware/efi/libstub/arm32-stub.c      |  2 +-
>  drivers/firmware/efi/libstub/arm64-stub.c      |  2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 12 ++++++++----
>  include/linux/efi.h                            |  5 +++--
>  5 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 936bdb924ec2..8207e8aa297e 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -13,6 +13,7 @@
>  #include <asm/e820/types.h>
>  #include <asm/setup.h>
>  #include <asm/desc.h>
> +#include <asm/boot.h>
>
>  #include "../string.h"
>  #include "eboot.h"
> @@ -432,7 +433,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
>         }
>
>         status = efi_low_alloc(sys_table, 0x4000, 1,
> -                              (unsigned long *)&boot_params);
> +                              (unsigned long *)&boot_params, 0);
>         if (status != EFI_SUCCESS) {
>                 efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
>                 return NULL;
> @@ -817,7 +818,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>
>         gdt->size = 0x800;
>         status = efi_low_alloc(sys_table, gdt->size, 8,
> -                          (unsigned long *)&gdt->address);
> +                              (unsigned long *)&gdt->address, 0);
>         if (status != EFI_SUCCESS) {
>                 efi_printk(sys_table, "Failed to allocate memory for 'gdt'\n");
>                 goto fail;
> @@ -842,7 +843,8 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>                 status = efi_relocate_kernel(sys_table, &bzimage_addr,
>                                              hdr->init_size, hdr->init_size,
>                                              hdr->pref_address,
> -                                            hdr->kernel_alignment);
> +                                            hdr->kernel_alignment,
> +                                            LOAD_PHYSICAL_ADDR);
>                 if (status != EFI_SUCCESS) {
>                         efi_printk(sys_table, "efi_relocate_kernel() failed!\n");
>                         goto fail;
> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> index e8f7aefb6813..bf6f954d6afe 100644
> --- a/drivers/firmware/efi/libstub/arm32-stub.c
> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> @@ -220,7 +220,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
>         *image_size = image->image_size;
>         status = efi_relocate_kernel(sys_table, image_addr, *image_size,
>                                      *image_size,
> -                                    dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
> +                                    dram_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
>         if (status != EFI_SUCCESS) {
>                 pr_efi_err(sys_table, "Failed to relocate kernel.\n");
>                 efi_free(sys_table, *reserve_size, *reserve_addr);
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 1550d244e996..3d2e517e10f4 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -140,7 +140,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>         if (status != EFI_SUCCESS) {
>                 *reserve_size = kernel_memsize + TEXT_OFFSET;
>                 status = efi_low_alloc(sys_table_arg, *reserve_size,
> -                                      MIN_KIMG_ALIGN, reserve_addr);
> +                                      MIN_KIMG_ALIGN, reserve_addr, 0);
>
>                 if (status != EFI_SUCCESS) {
>                         pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 3caae7f2cf56..00b00a2562aa 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -260,11 +260,11 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
>  }
>
>  /*
> - * Allocate at the lowest possible address.
> + * Allocate at the lowest possible address that is not below 'min'.
>   */
>  efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>                            unsigned long size, unsigned long align,
> -                          unsigned long *addr)
> +                          unsigned long *addr, unsigned long min)
>  {
>         unsigned long map_size, desc_size, buff_size;
>         efi_memory_desc_t *map;
> @@ -311,6 +311,9 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>                 start = desc->phys_addr;
>                 end = start + desc->num_pages * EFI_PAGE_SIZE;
>
> +               if (start < min)
> +                       start = min;
> +
>                 /*
>                  * Don't allocate at 0x0. It will confuse code that
>                  * checks pointers against NULL. Skip the first 8
> @@ -698,7 +701,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
>                                  unsigned long image_size,
>                                  unsigned long alloc_size,
>                                  unsigned long preferred_addr,
> -                                unsigned long alignment)
> +                                unsigned long alignment,
> +                                unsigned long min_addr)
>  {
>         unsigned long cur_image_addr;
>         unsigned long new_addr = 0;
> @@ -732,7 +736,7 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
>          */
>         if (status != EFI_SUCCESS) {
>                 status = efi_low_alloc(sys_table_arg, alloc_size, alignment,
> -                                      &new_addr);
> +                                      &new_addr, min_addr);
>         }
>         if (status != EFI_SUCCESS) {
>                 pr_efi_err(sys_table_arg, "Failed to allocate usable memory for kernel.\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index f87fabea4a85..cc947c0f3e06 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1587,7 +1587,7 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
>
>  efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>                            unsigned long size, unsigned long align,
> -                          unsigned long *addr);
> +                          unsigned long *addr, unsigned long min);
>
>  efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
>                             unsigned long size, unsigned long align,
> @@ -1598,7 +1598,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
>                                  unsigned long image_size,
>                                  unsigned long alloc_size,
>                                  unsigned long preferred_addr,
> -                                unsigned long alignment);
> +                                unsigned long alignment,
> +                                unsigned long min_addr);
>
>  efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
>                                   efi_loaded_image_t *image,
> --
> 2.21.0
>
