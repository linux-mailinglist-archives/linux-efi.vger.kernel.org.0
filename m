Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA245DAFE
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 03:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGCBhP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 21:37:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46883 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfGCBhO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 21:37:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so733612wrw.13
        for <linux-efi@vger.kernel.org>; Tue, 02 Jul 2019 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YffUmnYIYJSGCAfaNSWP1ayns5cp2QU4CpDgCgvPRE=;
        b=efh0X4llLVWHu5Dg5iUHBFsqpiD3EAhHy0GSa4Rw1Z7MEpgWK+3Wx+qU22FGbxHH7z
         Adqbj+oS3WaHZfvWf6Z7S+kxCLU3wfHEVZrZXPQPnhxe3AiJcZlGG/GqThd7oay8i3Lu
         NEYlEK6E22/86kHuucUfo79XlxYDZKnuvzCEjbzM4HoeZPb33jKOfVMj79vrfpfqnJOk
         fZI6hEX5hOZEWVoKzAxYMsbE4rVMB/nB3/IY0ffXy+zFTvD1MZeGhq7oJIEsguBrXKfD
         uX817r4HZk99anNjIxdo0b4kaqF2C3Os/U+eWl9WkoCMVZI5nNNSfkrMJiOopDM6DQeC
         ns6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YffUmnYIYJSGCAfaNSWP1ayns5cp2QU4CpDgCgvPRE=;
        b=OB/kE61aXAySXaf8fsDkPci83WVENMYhekZM6sTo8DBIHy3VCCoIvaaGV4U/pVhPSs
         ujY6Xp3UBpnKqk/yKP4ZyuFFERjGzEgGQerN7tY9pbUNWAe7H3PZiza9bMysiPKWZMA6
         GszTa2mUGu9cMplbBIUSCW7+GeMKIF7BuDwRH+78MKwV4gPUtAkhLGpjKzTPiiLhw9Pn
         E3w9VmfQJ/p4wSeu/lcI0Oc27ZuvKrmytj9G0TPrD4y2hM2W8Cp++HG3nPTjeFWUeH5C
         j/5f0nJYALSOnYN6ipnkLzmJTRrjYUSfkLQN5PRFjQx/thLRhR+dc9X/dy7/1/sHQmak
         5uLQ==
X-Gm-Message-State: APjAAAU/iSp2CrdtVW/V7B1afz2VSA7Z12f5IYfwrypU1cb+08H+o3zz
        KM/S50Iyp8GuPzUpDw3oF6lbvIwDhp60xrVbTGzgTdNouKk=
X-Google-Smtp-Source: APXvYqzqh9h/4RdbB/jYJGIotsVwMAaDcHyyKvBN+Zzh6AUchrrkcMUDuARE9cbiaNpeM76kcPfTnmDJ1m48uONJYvY=
X-Received: by 2002:a5d:5589:: with SMTP id i9mr15370525wrv.198.1562099197663;
 Tue, 02 Jul 2019 13:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
In-Reply-To: <20190630203614.5290-3-robdclark@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Jul 2019 22:26:22 +0200
Message-ID: <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 30 Jun 2019 at 22:36, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> On snapdragon aarch64 laptops, a 'UEFIDisplayInfo' variable is provided
> to communicate some information about the display.  Crutially it has the
> panel-id, so the appropriate panel driver can be selected.  Read this
> out and stash in /chosen/panel-id so that display driver can use it to
> pick the appropriate panel.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Hi Rob,

I understand why you are doing this, but this *really* belongs elsewhere.

So we are dealing with a platform that violates the UEFI spec, since
it does not bother to implement variable services at runtime (because
MS let the vendor get away with this).

First of all, to pass data between the EFI stub and the OS proper, we
should use a configuration table rather than a DT property, since the
former is ACPI/DT agnostic. Also, I'd like the consumer of the data to
actually interpret it, i.e., just dump the whole opaque thing into a
config table in the stub, and do the parsing in the OS proper.

However, I am not thrilled at adding code to the stub that
unconditionally looks for some variable with some magic name on all
ARM/arm64 EFI systems, so this will need to live under a Kconfig
option that depends on ARM64 (and does not default to y)



> ---
>  drivers/firmware/efi/libstub/arm-stub.c | 49 +++++++++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h  |  2 +
>  drivers/firmware/efi/libstub/fdt.c      |  9 +++++
>  3 files changed, 60 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index 04e6ecd72cd9..999813252e0d 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -69,6 +69,53 @@ static struct screen_info *setup_graphics(efi_system_table_t *sys_table_arg)
>         return si;
>  }
>
> +/*
> + * We (at least currently) don't care about most of the fields, just
> + * panel_id:
> + */
> +struct mdp_disp_info {
> +       u32 version_info;
> +       u32 pad0[9];
> +       u32 panel_id;
> +       u32 pad1[17];
> +};
> +
> +#define MDP_DISP_INFO_VERSION_MAGIC 0xaa
> +
> +static void get_panel_id(efi_system_table_t *sys_table_arg,
> +                        unsigned long fdt_addr)
> +{
> +       efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> +       efi_status_t status;
> +       struct mdp_disp_info *disp_info;
> +       unsigned long size = 0;
> +
> +       status = efi_call_runtime(get_variable, L"UEFIDisplayInfo",
> +                                 &gop_proto, NULL, &size, NULL);
> +       if (status == EFI_NOT_FOUND)
> +               return;
> +
> +       status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size,
> +                               (void **)&disp_info);
> +       if (status != EFI_SUCCESS)
> +               return;
> +
> +       status = efi_call_runtime(get_variable, L"UEFIDisplayInfo",
> +                                 &gop_proto, NULL, &size, disp_info);
> +       if (status != EFI_SUCCESS)
> +               goto cleanup;
> +
> +       if ((disp_info->version_info >> 16) != MDP_DISP_INFO_VERSION_MAGIC)
> +               goto cleanup;
> +
> +       efi_printk(sys_table_arg, "found a panel-id!\n");
> +
> +       set_chosen_panel_id(fdt_addr, disp_info->panel_id);
> +
> +cleanup:
> +       efi_call_early(free_pool, disp_info);
> +}
> +
>  void install_memreserve_table(efi_system_table_t *sys_table_arg)
>  {
>         struct linux_efi_memreserve *rsv;
> @@ -229,6 +276,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
>         if (!fdt_addr)
>                 pr_efi(sys_table, "Generating empty DTB\n");
>
> +       get_panel_id(sys_table, fdt_addr);
> +
>         status = handle_cmdline_files(sys_table, image, cmdline_ptr, "initrd=",
>                                       efi_get_max_initrd_addr(dram_base,
>                                                               *image_addr),
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 1b1dfcaa6fb9..8832cb9a7a40 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -39,6 +39,8 @@ void efi_char16_printk(efi_system_table_t *, efi_char16_t *);
>
>  unsigned long get_dram_base(efi_system_table_t *sys_table_arg);
>
> +void set_chosen_panel_id(unsigned long fdt_addr, unsigned panel_id);
> +
>  efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
>                                             void *handle,
>                                             unsigned long *new_fdt_addr,
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 5440ba17a1c5..cb6ea160a40a 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -200,6 +200,15 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
>         return EFI_SUCCESS;
>  }
>
> +void set_chosen_panel_id(unsigned long fdt_addr, unsigned panel_id)
> +{
> +       void *fdt = (void *)fdt_addr;
> +       int node = fdt_subnode_offset(fdt, 0, "chosen");
> +       u32 fdt_val32 = cpu_to_fdt32(panel_id);
> +
> +       fdt_setprop_var(fdt, node, "panel-id", fdt_val32);
> +}
> +
>  #ifndef EFI_FDT_ALIGN
>  # define EFI_FDT_ALIGN EFI_PAGE_SIZE
>  #endif
> --
> 2.20.1
>
