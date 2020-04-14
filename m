Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEA1A8F44
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 01:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634389AbgDNXqk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634364AbgDNXqf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Apr 2020 19:46:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9BC061A0E
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 16:46:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h2so15116725wmb.4
        for <linux-efi@vger.kernel.org>; Tue, 14 Apr 2020 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXYDrBej33dmGnBCE6UOmo/cofXtLGBYbbUIxq4jAbk=;
        b=GGiPCHR6ZJWnPyf+TAR/Vc5kNRc6Tg5Yfsn+UnhnT1ZUapU1FmLe+vQ3/A/Qz18MBE
         p/GX9uaWUBXh5qXYxtP6wnfYsqJv4denLe5M1O++qqPdg80e4hlpVrw2r6DgpDtKZZCN
         CVz/e5/+8i98zzycVSBJ2KRhdC3TIY1JsKEUFPlXcEjtDIu+Eq6eSPzlzSyRvlTcFZ/6
         +nmKb8IEdYNpm8EJmuYBPC8H0x4gP7s0qxDe+r2Vm/DbXPiZKw8DTZk/jf1I3ccEf6km
         0NXDHPlFGYHADZ95ZodQxGisDrYDeDvvNQoYQDJ/jnqT30V8MVRtr33+jMU4nlig5Vyx
         rHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXYDrBej33dmGnBCE6UOmo/cofXtLGBYbbUIxq4jAbk=;
        b=Vz4fTBn2icKhIWLS4zg0sdvq8sQRlwInj/O9r9jgiwsSMxz0M5xouPcVtUZbx7y9T0
         j6CpIrAWXFqN4xNVkK4P/B5NQ+BGnEdqdQV5sIrsvlQEUmYFikWdDcfI/tr2hISZMdVv
         IX1Y/Keseg8SrviYJFbYDWwYp1yACMQ/6wQSBpO6+EuHrJukVoOvYb5ftKGxSi/Jbq08
         61YxW4mAvo3JoncCE7mtqC/oQ+O+ENpk1MVgIn+bk7Kckg5HLQZHPiW8jGYdtSjrtHj0
         w0YgEbflI+6HbQjm0evVeG/3HFzmTCFgpLM0x6I537gJBE8Gm5w8L+4qdqROtmps5a3s
         oKVA==
X-Gm-Message-State: AGi0Pua9qDIMa5IuFVsX869OZBITMIsz28kznSaZ6BIiQmKYT8xiWnOF
        vx1qwAFj5CgI4KzNsDoaKgoeGLZqWg6zwd1PRsPx
X-Google-Smtp-Source: APiQypIdMlJqLQ4/Npa7mGSrmyhgnu/UHkZcEwsc4q22DsvwXxnTPyOzmE67wFq8SQHiO/umnA134qIUJY1TbSlWcIU=
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr2234591wmj.186.1586907993587;
 Tue, 14 Apr 2020 16:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200413155521.24698-1-ardb@kernel.org> <20200413155521.24698-7-ardb@kernel.org>
In-Reply-To: <20200413155521.24698-7-ardb@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 14 Apr 2020 16:46:22 -0700
Message-ID: <CAOnJCU+iBmTHL0PiNeUyOvQcrNJCc864ijCXjY7XCKLtyqcoNQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] efi/libstub: add API function to allocate aligned memory
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Jonathan.Cameron@huawei.com,
        nivedita@alum.mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 13, 2020 at 8:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Break out the code to create an aligned page allocation from mem.c
> and move it into a function efi_allocate_pages_aligned() in alignedmem.c.
> Update efi_allocate_pages() to invoke it unless the minimum alignment
> equals the EFI page size (4 KB), in which case the ordinary page
> allocator is sufficient. This way, efi_allocate_pages_aligned() will
> only be pulled into the build if it is actually being used (which will
> be on arm64 only in the immediate future)
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile     |  3 +-
>  drivers/firmware/efi/libstub/alignedmem.c | 57 ++++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h    |  3 ++
>  drivers/firmware/efi/libstub/mem.c        | 25 ++++-----
>  4 files changed, 71 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 094eabdecfe6..1a09b9445394 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -42,7 +42,8 @@ KCOV_INSTRUMENT                       := n
>
>  lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
>                                    file.o mem.o random.o randomalloc.o pci.o \
> -                                  skip_spaces.o lib-cmdline.o lib-ctype.o
> +                                  skip_spaces.o lib-cmdline.o lib-ctype.o \
> +                                  alignedmem.o
>
>  # include the stub's generic dependencies from lib/ when building for ARM/arm64
>  arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
> new file mode 100644
> index 000000000000..cc89c4d6196f
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/alignedmem.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +
> +#include "efistub.h"
> +
> +/**
> + * efi_allocate_pages_aligned() - Allocate memory pages
> + * @size:      minimum number of bytes to allocate
> + * @addr:      On return the address of the first allocated page. The first
> + *             allocated page has alignment EFI_ALLOC_ALIGN which is an
> + *             architecture dependent multiple of the page size.
> + * @max:       the address that the last allocated memory page shall not
> + *             exceed
> + * @align:     minimum alignment of the base of the allocation
> + *
> + * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
> + * to @align, which should be >= EFI_ALLOC_ALIGN. The last allocated page will
> + * not exceed the address given by @max.
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
> +                                       unsigned long max, unsigned long align)
> +{
> +       efi_physical_addr_t alloc_addr;
> +       efi_status_t status;
> +       int slack;
> +
> +       if (align < EFI_ALLOC_ALIGN)
> +               align = EFI_ALLOC_ALIGN;
> +
> +       alloc_addr = ALIGN_DOWN(max + 1, align) - 1;
> +       size = round_up(size, EFI_ALLOC_ALIGN);
> +       slack = align / EFI_PAGE_SIZE - 1;
> +
> +       status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
> +                            EFI_LOADER_DATA, size / EFI_PAGE_SIZE + slack,
> +                            &alloc_addr);
> +       if (status != EFI_SUCCESS)
> +               return status;
> +
> +       *addr = ALIGN((unsigned long)alloc_addr, align);
> +
> +       if (slack > 0) {
> +               int l = (alloc_addr % align) / EFI_PAGE_SIZE;
> +
> +               if (l) {
> +                       efi_bs_call(free_pages, alloc_addr, slack - l + 1);
> +                       slack = l - 1;
> +               }
> +               if (slack)
> +                       efi_bs_call(free_pages, *addr + size, slack);
> +       }
> +       return EFI_SUCCESS;
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 4844c3bd40df..5dcfadcf2bc1 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -641,6 +641,9 @@ efi_status_t efi_low_alloc(unsigned long size, unsigned long align,
>  efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>                                 unsigned long max);
>
> +efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
> +                                       unsigned long max, unsigned long align);
> +
>  efi_status_t efi_relocate_kernel(unsigned long *image_addr,
>                                  unsigned long image_size,
>                                  unsigned long alloc_size,
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 869a79c8946f..0020b0fa9587 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -93,31 +93,24 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>  efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>                                 unsigned long max)
>  {
> -       efi_physical_addr_t alloc_addr = ALIGN_DOWN(max + 1, EFI_ALLOC_ALIGN) - 1;
> -       int slack = EFI_ALLOC_ALIGN / EFI_PAGE_SIZE - 1;
> +       efi_physical_addr_t alloc_addr;
>         efi_status_t status;
>
> -       size = round_up(size, EFI_ALLOC_ALIGN);
> +       if (EFI_ALLOC_ALIGN > EFI_PAGE_SIZE)
> +               return efi_allocate_pages_aligned(size, addr, max,
> +                                                 EFI_ALLOC_ALIGN);
> +
> +       alloc_addr = ALIGN_DOWN(max + 1, EFI_ALLOC_ALIGN) - 1;
>         status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
> -                            EFI_LOADER_DATA, size / EFI_PAGE_SIZE + slack,
> +                            EFI_LOADER_DATA, DIV_ROUND_UP(size, EFI_PAGE_SIZE),
>                              &alloc_addr);
>         if (status != EFI_SUCCESS)
>                 return status;
>
> -       *addr = ALIGN((unsigned long)alloc_addr, EFI_ALLOC_ALIGN);
> -
> -       if (slack > 0) {
> -               int l = (alloc_addr % EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
> -
> -               if (l) {
> -                       efi_bs_call(free_pages, alloc_addr, slack - l + 1);
> -                       slack = l - 1;
> -               }
> -               if (slack)
> -                       efi_bs_call(free_pages, *addr + size, slack);
> -       }
> +       *addr = alloc_addr;
>         return EFI_SUCCESS;
>  }
> +
>  /**
>   * efi_low_alloc_above() - allocate pages at or above given address
>   * @size:      size of the memory area to allocate
> --
> 2.17.1
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
