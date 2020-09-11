Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44203266588
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgIKREa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 13:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgIKPCf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:02:35 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F3E2244C;
        Fri, 11 Sep 2020 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599836481;
        bh=HtLkUWXhl5XAX6D7GAvZ5uZ8WYlaoexr13YPMrhinX8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m2hilndopgpM3i5Zr85FVrHoQiXHTDnClGX8KRviAY9HEr77R/8UGRPTAjCfWD7NW
         cMGT0YRkENBOhhs6s66uohG28ICbHaNthrJfjGTlIbVMtDzesDvy0svVkVT30QhP8n
         4K3pTPXwBJ8w8GP6r2X9LYf2sYI902a8P9r/9cXc=
Received: by mail-ot1-f53.google.com with SMTP id g96so8553340otb.12;
        Fri, 11 Sep 2020 08:01:21 -0700 (PDT)
X-Gm-Message-State: AOAM531UFkJjKx4XGGsA8Fggh2QAbrsh4UX3VfpK1VsPR7FmPY1WP1HR
        prZXUkXrbaLuANgMS91XxScF7K7+iZm55C/PXck=
X-Google-Smtp-Source: ABdhPJxBvUOnWvNWSxd3QQ6q9HAFDX1c50DdJzWPSuvJpfyOY08Sgy4lcuMwSkGA/qIXDW6vtgunB8B+AY4P1aKEKoo=
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr1381498oto.90.1599836480811;
 Fri, 11 Sep 2020 08:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200904072905.25332-1-clin@suse.com> <20200904072905.25332-2-clin@suse.com>
In-Reply-To: <20200904072905.25332-2-clin@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 11 Sep 2020 18:01:09 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEXvmO5mrTcKpqYUASBAQB-1=xLa0vg7KwmvOHMjaQ34w@mail.gmail.com>
Message-ID: <CAMj1kXEXvmO5mrTcKpqYUASBAQB-1=xLa0vg7KwmvOHMjaQ34w@mail.gmail.com>
Subject: Re: [PATCH 1/6] efistub: pass uefi secureboot flag via fdt params
To:     Chester Lin <clin@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 4 Sep 2020 at 10:29, Chester Lin <clin@suse.com> wrote:
>
> Add a new UEFI parameter: "linux,uefi-secure-boot" in fdt boot params
> as other architectures have done in their own boot data. For example,
> the boot_params->secure_boot in x86.
>
> Signed-off-by: Chester Lin <clin@suse.com>

Why do we need this flag? Can't the OS simply check the variable directly?

> ---
>  drivers/firmware/efi/libstub/fdt.c | 39 +++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 11ecf3c4640e..c9a341e4715f 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -136,6 +136,10 @@ static efi_status_t update_fdt(void *orig_fdt, unsigned long orig_fdt_size,
>         if (status)
>                 goto fdt_set_fail;
>
> +       status = fdt_setprop_var(fdt, node, "linux,uefi-secure-boot", fdt_val32);
> +       if (status)
> +               goto fdt_set_fail;
> +
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>                 efi_status_t efi_status;
>
> @@ -199,6 +203,24 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
>         return EFI_SUCCESS;
>  }
>
> +static efi_status_t update_fdt_secboot(void *fdt, u32 secboot)
> +{
> +       int node = fdt_path_offset(fdt, "/chosen");
> +       u32 fdt_val32;
> +       int err;
> +
> +       if (node < 0)
> +               return EFI_LOAD_ERROR;
> +
> +       fdt_val32 = cpu_to_fdt32(secboot);
> +
> +       err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-secure-boot", fdt_val32);
> +       if (err)
> +               return EFI_LOAD_ERROR;
> +
> +       return EFI_SUCCESS;
> +}
> +
>  struct exit_boot_struct {
>         efi_memory_desc_t       *runtime_map;
>         int                     *runtime_entry_count;
> @@ -208,6 +230,9 @@ struct exit_boot_struct {
>  static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
>                                    void *priv)
>  {
> +       efi_status_t status;
> +       enum efi_secureboot_mode secboot_status;
> +       u32 secboot_var = 0;
>         struct exit_boot_struct *p = priv;
>         /*
>          * Update the memory map with virtual addresses. The function will also
> @@ -217,7 +242,19 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
>         efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
>                         p->runtime_map, p->runtime_entry_count);
>
> -       return update_fdt_memmap(p->new_fdt_addr, map);
> +       status = update_fdt_memmap(p->new_fdt_addr, map);
> +
> +       if (status != EFI_SUCCESS)
> +               return status;
> +
> +       secboot_status = efi_get_secureboot();
> +
> +       if (secboot_status == efi_secureboot_mode_enabled)
> +               secboot_var = 1;
> +
> +       status = update_fdt_secboot(p->new_fdt_addr, secboot_var);
> +
> +       return status;
>  }
>
>  #ifndef MAX_FDT_SIZE
> --
> 2.26.1
>
