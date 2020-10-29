Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E414229F3BD
	for <lists+linux-efi@lfdr.de>; Thu, 29 Oct 2020 19:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJ2SCO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Oct 2020 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJ2SCN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 29 Oct 2020 14:02:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768EC0613CF
        for <linux-efi@vger.kernel.org>; Thu, 29 Oct 2020 11:02:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p7so4496356ioo.6
        for <linux-efi@vger.kernel.org>; Thu, 29 Oct 2020 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUoX/gtJf99Q+ymsn+KTjmF2FAz+ytoGOdcy378qWr8=;
        b=tOhSjtJQlFfnQJzPQZiJzLJduuTHLm3KfbZ0f1wP6rWxezkgd2Y87hC/GI96JNZ7Rr
         0LqPI4obldry1Ez5PGk4GncUt5FKx0AjNz1bOh7bC76OJqq0oy/3yVhx88gr63bJJv2J
         wK30sdiRYNw9mYnM5N9+e9FQ91MPV4E1/MouQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUoX/gtJf99Q+ymsn+KTjmF2FAz+ytoGOdcy378qWr8=;
        b=qYrRhtrcOb3na8dNC+wr6Mp14nliI7YRy0rxjRSfP5q/tHlG4061oGf2kYehatT0HJ
         MWRsbuAbMxI09hzufwA+8LpnQvtyt8bilfZd9Te+dLoanCHOCtPy8TpsRopYL56wdJkI
         9SPnxaNcnAbFfWVU7iv2bWBU4xa/Z9ieYJfzw/oW4mThlCFEDq2tRCRB36llOFRFS8Eo
         dOMVbz1zYouXwJdlLEymvmYo2gMSZlhPe/0exlAsuhOC8BIzHwesL1DYee5tOwk1MRMV
         HlehEkSGBoPKUqpC4yCTUFVSfcogerpO69iL/KzjbPEZIIROzGOazkZZ2dBc/V/1c3bW
         RnhA==
X-Gm-Message-State: AOAM5324i8ppzxqvNqtHGAHVccE6c7V5sM8XaUAV6G0WsGtJARkdn6j/
        j1llkT1jN3B6BTSjisBEbx3PCbcgdHvI6LrJxi+2
X-Google-Smtp-Source: ABdhPJxtE2WTdVTlU56v6Dmk0NL0nyOqjSJFDtxiARyXJaIOmYVHO3iLxBy+7agCaD847Rp147aJEAQk/01iqBQpz7U=
X-Received: by 2002:a02:c80a:: with SMTP id p10mr4433627jao.114.1603994530851;
 Thu, 29 Oct 2020 11:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201029134901.9773-1-ardb@kernel.org>
In-Reply-To: <20201029134901.9773-1-ardb@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 29 Oct 2020 11:01:59 -0700
Message-ID: <CAOnJCU+ACXDAaRY5yfSjOo31dwPkS7jS1KM7Fi_jwwuGjQ8YAA@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: get rid of efi_get_max_fdt_addr()
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 29, 2020 at 6:49 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Now that ARM started following the example of arm64 and RISC-V, and
> no longer imposes any restrictions on the placement of the FDT in
> memory at boot, we no longer need per-arch implementations of
> efi_get_max_fdt_addr() to factor out the differences. So get rid of
> it.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/include/asm/efi.h              | 6 ------
>  arch/arm64/include/asm/efi.h            | 6 ------
>  arch/riscv/include/asm/efi.h            | 6 ------
>  drivers/firmware/efi/libstub/efi-stub.c | 1 -
>  drivers/firmware/efi/libstub/efistub.h  | 1 -
>  drivers/firmware/efi/libstub/fdt.c      | 3 +--
>  6 files changed, 1 insertion(+), 22 deletions(-)
>
> diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> index 3ee4f4381985..0496bc96a092 100644
> --- a/arch/arm/include/asm/efi.h
> +++ b/arch/arm/include/asm/efi.h
> @@ -74,12 +74,6 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
>   */
>  #define EFI_PHYS_ALIGN         SZ_16M
>
> -/* on ARM, the FDT should be located in a lowmem region */
> -static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
> -{
> -       return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
> -}
> -
>  /* on ARM, the initrd should be loaded in a lowmem region */
>  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
>  {
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 973b14415271..01446a073b2e 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -64,12 +64,6 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
>  #define EFI_KIMG_ALIGN \
>         (SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
>
> -/* on arm64, the FDT may be located anywhere in system RAM */
> -static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
> -{
> -       return ULONG_MAX;
> -}
> -
>  /*
>   * On arm64, we have to ensure that the initrd ends up in the linear region,
>   * which is a 1 GB aligned region of size '1UL << (VA_BITS_MIN - 1)' that is
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> index 7542282f1141..6d98cd999680 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -27,12 +27,6 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
>
> -/* on RISC-V, the FDT may be located anywhere in system RAM */
> -static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
> -{
> -       return ULONG_MAX;
> -}
> -
>  /* Load initrd at enough distance from DRAM start */
>  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
>  {
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 914a343c7785..ec2f3985bef3 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -273,7 +273,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         install_memreserve_table();
>
>         status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr,
> -                                               efi_get_max_fdt_addr(image_addr),
>                                                 initrd_addr, initrd_size,
>                                                 cmdline_ptr, fdt_addr, fdt_size);
>         if (status != EFI_SUCCESS)
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 2d7abcd99de9..c1c63e847481 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -750,7 +750,6 @@ efi_status_t efi_exit_boot_services(void *handle,
>
>  efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                                             unsigned long *new_fdt_addr,
> -                                           unsigned long max_addr,
>                                             u64 initrd_addr, u64 initrd_size,
>                                             char *cmdline_ptr,
>                                             unsigned long fdt_addr,
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 368cd60000ee..365c3a43a198 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -238,7 +238,6 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
>
>  efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                                             unsigned long *new_fdt_addr,
> -                                           unsigned long max_addr,
>                                             u64 initrd_addr, u64 initrd_size,
>                                             char *cmdline_ptr,
>                                             unsigned long fdt_addr,
> @@ -275,7 +274,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>         efi_info("Exiting boot services and installing virtual address map...\n");
>
>         map.map = &memory_map;
> -       status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
> +       status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
>         if (status != EFI_SUCCESS) {
>                 efi_err("Unable to allocate memory for new device tree.\n");
>                 goto fail;
> --
> 2.17.1
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
