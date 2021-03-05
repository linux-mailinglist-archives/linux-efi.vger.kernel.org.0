Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C9D32E2AC
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhCEHBP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 02:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHBP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 02:01:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D24EE65014;
        Fri,  5 Mar 2021 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614927674;
        bh=eXkrZkJ98MHNE6BvmwiOljMvfAc93gK82Qwlwqej264=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tmS0V+qaY90TpmSgnLz+1hKkmfVMPWgkcfvckt4c5/Lyyja0IRKqMWSslr/SAliyS
         YZFjJ9h4Bbfi7/fAucyKH+cRVYMIUNpbhTtPsAy4FRB0Sda3h+UVJAb16e0gpjbAqW
         XKerD/q660D0l0m9z++oQMu6csEgYa40zxqmVEFGdXlScBFZmM37Wu9M9d+gAL4tqL
         84y0kHt+zA6MlGC2XYwOsh8mtarBYiF0YL3FcTSkcwhfdzWQqzI+VL+K16ng5jf3h2
         KlTyosTHp543B+vtGFK4PT4AjQseMeRZRB+mH8AFPRy/gDiaQ7cDQVatZ6YHOVBkwm
         O8tOZ2dQFMPLA==
Received: by mail-oi1-f179.google.com with SMTP id i21so1464899oii.2;
        Thu, 04 Mar 2021 23:01:14 -0800 (PST)
X-Gm-Message-State: AOAM532QCVNNvrLYCFgolvdIx3M6Kdk3+zXGGHSH2wyAWKzxvxmplBon
        NUJytvnwtTSQbgY1PqodQOZjgpwvA7P6sMIqDMM=
X-Google-Smtp-Source: ABdhPJxpF/tAkdurycugCv3x/Oht9U9JosAvtaHXk6yC2SfnhJEMcNRrhD3wr+nlWySke1BZAi00K7PYfsyGu/tnD7s=
X-Received: by 2002:aca:538c:: with SMTP id h134mr5916199oib.174.1614927674146;
 Thu, 04 Mar 2021 23:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20210305065120.11355-1-shawn.guo@linaro.org>
In-Reply-To: <20210305065120.11355-1-shawn.guo@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Mar 2021 08:01:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
Message-ID: <CAMj1kXHOXOX6V735tLPxcVUAAM0AeZkLKyOUDKTPvazLjjrQ6Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: add check for broken efi poweroff
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 5 Mar 2021 at 07:51, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> Poweroff via UEFI Runtime Services doesn't always work on every single
> arm64 machine.  For example, on Lenovo Flex 5G laptop, it results in
> a system reboot rather than shutdown.  Add a DMI check to keep such
> system stay with the original poweroff method (PSCI).
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

What is the point of using EFI runtime services on this machine if
poweroff doesn't work either? Can't we just boot this thing with
efi=noruntime?


> ---
>  arch/arm64/kernel/efi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index fa02efb28e88..8ae0002c72f1 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2013, 2014 Linaro Ltd.
>   */
>
> +#include <linux/dmi.h>
>  #include <linux/efi.h>
>  #include <linux/init.h>
>
> @@ -113,12 +114,26 @@ int __init efi_set_mapping_permissions(struct mm_struct *mm,
>                                    set_permissions, md);
>  }
>
> +static const struct dmi_system_id efi_reboot_broken_table[] = {
> +       {
> +               .ident = "Lenovo Flex 5G",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_FAMILY, "Flex 5G"),
> +               },
> +       },
> +       { } /* terminator */
> +};
> +
>  /*
>   * UpdateCapsule() depends on the system being shutdown via
>   * ResetSystem().
>   */
>  bool efi_poweroff_required(void)
>  {
> +       if (dmi_check_system(efi_reboot_broken_table))
> +               return false;
> +
>         return efi_enabled(EFI_RUNTIME_SERVICES);
>  }
>
> --
> 2.17.1
>
