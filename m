Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1A36C63B
	for <lists+linux-efi@lfdr.de>; Tue, 27 Apr 2021 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhD0Mnz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Apr 2021 08:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235501AbhD0Mny (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Apr 2021 08:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF12B613E7;
        Tue, 27 Apr 2021 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619527391;
        bh=SBMydSe5kp0Nvgawklzbas5ZKFW7/l9q/mwcw/UIYvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tcCcL8zMkgC8pv252U5tCzY3Tm3yP2HdRGj/OeMsM1bNsd18U2dl4OqwuGyAlNxj7
         024V3mj3y76NbjSso7Te5ghR9tM8mYwuKAsqT4Amte3CZMN7koTxUBlusaHVsIoi1I
         a5EfPyJYWxcR5RHAUc0BCNjI7IuEimi/GWPZJF3ahHD3aRdFbyqe7rWkZUEnPTYTCb
         qetEiZmBNTKvHguc2b/2LfKpRtCbNhKo44GrFFMpY7pSQL5R3ENf7PTZ89lMrD6ro3
         lJXI36nP6oNz6Nvv4RgKfRDr+pcUIgixZGjrTEnpTkFmxhA/avDfBM9aVU7w8eDN1I
         E+jV2A4R3joqw==
Received: by mail-ot1-f49.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso140686otn.3;
        Tue, 27 Apr 2021 05:43:11 -0700 (PDT)
X-Gm-Message-State: AOAM53171ipa5SOisc/M+av1ZxPBMDt84Wksit/qGqCu0nETq/mLgMHB
        6YzYSziKCQwECeFCclNgVk+zLJNCkQ+bY4lbFM0=
X-Google-Smtp-Source: ABdhPJyMQx/FiPIphY9VMEFj2ndPnbvhQmyfgZo7N2J+0K29BHhLG6JADN95Yku1nh8g4dEjFjn+rj6sR32e1BR8hfk=
X-Received: by 2002:a05:6830:4d1:: with SMTP id s17mr18536402otd.108.1619527390973;
 Tue, 27 Apr 2021 05:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210427120607.2646166-1-arei@altlinux.org>
In-Reply-To: <20210427120607.2646166-1-arei@altlinux.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Apr 2021 14:42:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGm9d7SdBoozEoOP4G6ETmNiZR8kum91RVc_4eUTroE2w@mail.gmail.com>
Message-ID: <CAMj1kXGm9d7SdBoozEoOP4G6ETmNiZR8kum91RVc_4eUTroE2w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Relocate the kernel relative to a DRAM base.
To:     Nikita Ermakov <arei@altlinux.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 27 Apr 2021 at 14:07, Nikita Ermakov <arei@altlinux.org> wrote:
>
> Try to get the base of the DRAM from a DTB to use it as a lowest address
> in physical memory to relocate the kernel. If it is not possible to
> obtain the base from a /memory node of the DTB let's make an assumption
> that the DRAM base at the beginning of the memory.
>

Why?

> Signed-off-by: Nikita Ermakov <arei@altlinux.org>
> ---
>  drivers/firmware/efi/libstub/riscv-stub.c | 39 ++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index 380e4e251399..1b5944276e1a 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -46,6 +46,39 @@ static u32 get_boot_hartid_from_fdt(void)
>         return fdt32_to_cpu(*prop);
>  }
>
> +static unsigned long get_dram_base_from_fdt(void)
> +{
> +       const void *fdt;
> +       int node, len;
> +       const fdt32_t *addr_cells;
> +       const void *prop;
> +
> +       fdt = get_efi_config_table(DEVICE_TREE_GUID);
> +       if (!fdt)
> +               return ULONG_MAX;
> +
> +       node = fdt_path_offset(fdt, "/");
> +       if (node < 0)
> +               return ULONG_MAX;
> +
> +       addr_cells = fdt_getprop((void *)fdt, node, "#address-cells", &len);
> +       if (!addr_cells)
> +               return ULONG_MAX;
> +
> +       node = fdt_path_offset(fdt, "/memory");
> +       if (node < 0)
> +               return ULONG_MAX;
> +
> +       prop = fdt_getprop((void *)fdt, node, "reg", &len);
> +       if (!prop)
> +               return ULONG_MAX;
> +
> +       if (fdt32_to_cpu(*addr_cells) > 1)
> +               return fdt64_to_cpu(*((fdt64_t *)prop));
> +       else
> +               return fdt32_to_cpu(*((fdt32_t *)prop));
> +}
> +
>  efi_status_t check_platform_features(void)
>  {
>         hartid = get_boot_hartid_from_fdt();
> @@ -97,7 +130,11 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>          * lowest possible memory region as long as the address and size meets
>          * the alignment constraints.
>          */
> -       preferred_addr = MIN_KIMG_ALIGN;
> +       preferred_addr = get_dram_base_from_fdt();
> +       if (preferred_addr == ULONG_MAX)
> +               preferred_addr = MIN_KIMG_ALIGN;
> +       else
> +               preferred_addr += MIN_KIMG_ALIGN;
>         status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
>                                      preferred_addr, MIN_KIMG_ALIGN, 0x0);
>
> --
> 2.29.3
>
