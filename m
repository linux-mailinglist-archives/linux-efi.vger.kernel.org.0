Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440ABDFD9C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Oct 2019 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfJVGOG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Oct 2019 02:14:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33881 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbfJVGOF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Oct 2019 02:14:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so11378049wrr.1
        for <linux-efi@vger.kernel.org>; Mon, 21 Oct 2019 23:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5evoy8xnNoaQB+XLeUTtF36TLCnuCIuN9lobaj1jooE=;
        b=XzPuJ0Fjy0V5L4h9mM2cAiKpwTo83TMCdhkGXy4cEDDj7smJBvovSRFnAGO2fF4uw+
         +g61vhWlVnceM4npBm+zMJ7lm5quIu/S4BU6iXfM8fis2ViDLgH4FNI4MP8+6ou/A9jV
         uOtCM/2POkj2JlCt26hOG0EVHHUX80dTPdSfyQi09BF7G5t1BHeiYmOzMZ1JNeLzxrzT
         FNRdlk+1GIosMAKAbl1ZiEg3wcoW6rSS2FsWr8wsq7d8zMo76zb4kr8UlU42k6aAiQgL
         oh0eA+1AHA+WHExyYI075gbzzk26mUGNi3rWKg5dWsLPRTju6N9F2Cv81lUbruuJQqgm
         SF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5evoy8xnNoaQB+XLeUTtF36TLCnuCIuN9lobaj1jooE=;
        b=acQPt5YPU6uatCzB/Rjn0LP+uoxZxD7qom+GKCDouN/zr1JNUCBK5SUmxB0gXiz63y
         76yBEnclB9yZCGZtjxdFi2Kb6AdIgFlTZ/HeLqdfdqkJlJYVnu3pDX6oqJB1kfpwjEK4
         0L1toz6ZbNEMKEHTCP++U+k+9hn34dLH2NNGaoX7gbnWCiIwUEpeEeNisyVih8YJDOoR
         nZP9O6YYK0nSlUdJaqdukPWqlsHaS5YQ3/fOhl1nWmiMQZt0STzMZ3IGATZdMCiYRFoP
         RkRSj8gLFEQ3D0MTVf2IK/OuFtNqzljmZObJ+88nAhQxKLUG8sf/49h7+gu9ky5jPcsS
         bt/w==
X-Gm-Message-State: APjAAAWjNUq599p6uFXvNFIhJCf4UmAiMzQ7oUQScwlfmCUPb9udhQtY
        4c94mE34Ky5jCFUYw6Rsh9x54iAeIiOjq8ahEXLjjQ==
X-Google-Smtp-Source: APXvYqwQEknzYKOQvHSxWaj9PouA3wn69HXv0Mx1MHKr1IT3iMoNNwecSpm4/1pvwVo8L2pHqXpSzCM1jwV2yIHMSUY=
X-Received: by 2002:adf:fd88:: with SMTP id d8mr1702530wrr.200.1571724840576;
 Mon, 21 Oct 2019 23:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191017093020.28658-1-kasong@redhat.com>
In-Reply-To: <20191017093020.28658-1-kasong@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 22 Oct 2019 08:13:56 +0200
Message-ID: <CAKv+Gu8nJ0uDn0G9s5N1ZM=FE4JB5c2Kjs=mKpatTFkwF0WaaQ@mail.gmail.com>
Subject: Re: [PATCH v4] x86, efi: never relocate kernel below lowest
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

On Thu, 17 Oct 2019 at 11:30, Kairui Song <kasong@redhat.com> wrote:
>
> Currently, kernel fails to boot on some HyperV VMs when using EFI.
> And it's a potential issue on all platforms.
>
> It's caused by broken kernel relocation on EFI systems, when below three
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
> EFI stub will perform a kernel relocation when condition 1 is met. But
> due to condition 2, EFI stub can't relocate kernel to the preferred
> address, so it fallback to ask EFI firmware to alloc lowest usable memory
> region, got the low region mentioned in condition 3, and relocated
> kernel there.
>
> It's incorrect to relocate the kernel below LOAD_PHYSICAL_ADDR. This
> is the lowest acceptable kernel relocation address.
>
> The first thing goes wrong is in arch/x86/boot/compressed/head_64.S.
> Kernel decompression will force use LOAD_PHYSICAL_ADDR as the output
> address if kernel is located below it. Then the relocation before
> decompression, which move kernel to the end of the decompression buffer,
> will overwrite other memory region, as there is no enough memory there.
>
> To fix it, just don't let EFI stub relocate the kernel to any address
> lower than lowest acceptable address.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Ingo, Boris, could you please comment on this?

Apologies for not responding with review comments until now, but I was
waiting for someone from team-x86 to acknowledge the issue and confirm
a fix is needed.

Some comments below.


> ---
> Update from V3:
>  - Update commit message.
>
> Update from V2:
>  - Update part of the commit message.
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
> index d6662fdef300..e89e84b66527 100644
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
> @@ -413,7 +414,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
>         }
>
>         status = efi_low_alloc(sys_table, 0x4000, 1,
> -                              (unsigned long *)&boot_params);
> +                              (unsigned long *)&boot_params, 0);

Instead of changing the calls to efi_low_alloc() everywhere, could you
please only update the implementation to take a 'min' argument, and
rename it to something like ' ()', Then, the original extern
declaration of efi_low_alloc() can be converted into a static inline
that calls efi_low_alloc_above. That also allows us to pull the 'alloc
at 0x0' logic out of the loop, e.g.,

efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
                           unsigned long size, unsigned long align,
                           unsigned long *addr, unsigned long min);

static inline
efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
                           unsigned long size, unsigned long align,
                           unsigned long *addr)
{
    /*
     * Don't allocate at 0x0. It will confuse code that
     * checks pointers against NULL. Skip the first 8
     * bytes so we start at a nice even number.
     */
    return efi_low_alloc_above(sys_table_arg, size, align, addr, 8);
}

(and drop the same logic from the function implementation)

>         if (status != EFI_SUCCESS) {
>                 efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
>                 return NULL;
> @@ -798,7 +799,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>
>         gdt->size = 0x800;
>         status = efi_low_alloc(sys_table, gdt->size, 8,
> -                          (unsigned long *)&gdt->address);
> +                              (unsigned long *)&gdt->address, 0);
>         if (status != EFI_SUCCESS) {
>                 efi_printk(sys_table, "Failed to allocate memory for 'gdt'\n");
>                 goto fail;
> @@ -813,7 +814,8 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
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
> index bd3837022307..a5144cc44e54 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1581,7 +1581,7 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
>
>  efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>                            unsigned long size, unsigned long align,
> -                          unsigned long *addr);
> +                          unsigned long *addr, unsigned long min);
>
>  efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
>                             unsigned long size, unsigned long align,
> @@ -1592,7 +1592,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
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
