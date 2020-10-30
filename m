Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262EE2A04C7
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 12:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJ3Lww (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 07:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJ3Lwv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 30 Oct 2020 07:52:51 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF4B22227;
        Fri, 30 Oct 2020 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604058757;
        bh=a2P2yJXerbf+BStG2FxqbjJ8wAhWTITOLQDhr7Hmh3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t5aHrghmpzjeM/9/si8n4dGoZIODp982zCoJECUd4xSO0OiO8nS9O2m/Cm0q580h1
         AfFLCFBWh2XNVxRMn/XClEUBFzYXhx4xu+pT0WdeE/K2NwJFKMvf09T+E4MG3DFFIS
         foFIM/WU3nNA4hWIdR4Z8MM2ajQGd8F8qUeS0VXQ=
Received: by mail-oi1-f177.google.com with SMTP id x1so6325620oic.13;
        Fri, 30 Oct 2020 04:52:37 -0700 (PDT)
X-Gm-Message-State: AOAM532xzF+KC3v/fdemBq7vSJrvEe5SEw/x3eQOygpIyH72rJHIwbu7
        v/a1biZYGgYK8h+icPp02uXOI0jicaK14yW96L8=
X-Google-Smtp-Source: ABdhPJyDqHCtTxdAyD28M//rHLe/L8BOwQ2hQT48DxxewoMsBO92i0mJB3CrDMAPcCrrboNjBna1svpvK0MMmcwrcPg=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr1314195oib.33.1604058756433;
 Fri, 30 Oct 2020 04:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201030060840.1810-1-clin@suse.com> <20201030060840.1810-3-clin@suse.com>
In-Reply-To: <20201030060840.1810-3-clin@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Oct 2020 12:52:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHtRhD6vuAcnuQkXCfxHduZ8j2vPJFMT6Y5WDQ14OhQ_g@mail.gmail.com>
Message-ID: <CAMj1kXHtRhD6vuAcnuQkXCfxHduZ8j2vPJFMT6Y5WDQ14OhQ_g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ima: replace arch-specific get_sb_mode() with a
 common helper ima_get_efi_secureboot()
To:     Chester Lin <clin@suse.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, X86 ML <x86@kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Oct 2020 at 07:09, Chester Lin <clin@suse.com> wrote:
>
> remove the get_sb_mode() from x86/kernel/ima_arch.c and create a common
> helper ima_get_efi_secureboot() in IMA so that all EFI-based architectures
> can refer to the same procedure.
>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/x86/kernel/ima_arch.c       | 69 +++++++-------------------------
>  include/linux/ima.h              | 10 +++++
>  security/integrity/ima/Makefile  |  1 +
>  security/integrity/ima/ima_efi.c | 26 ++++++++++++
>  4 files changed, 51 insertions(+), 55 deletions(-)
>  create mode 100644 security/integrity/ima/ima_efi.c
>
> diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> index 7dfb1e808928..2c773532ff0a 100644
> --- a/arch/x86/kernel/ima_arch.c
> +++ b/arch/x86/kernel/ima_arch.c
> @@ -8,69 +8,28 @@
>
>  extern struct boot_params boot_params;
>
> -static enum efi_secureboot_mode get_sb_mode(void)
> -{
> -       efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> -       efi_status_t status;
> -       unsigned long size;
> -       u8 secboot, setupmode;
> -
> -       size = sizeof(secboot);
> -
> -       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> -               pr_info("ima: secureboot mode unknown, no efi\n");
> -               return efi_secureboot_mode_unknown;
> -       }
> -
> -       /* Get variable contents into buffer */
> -       status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> -                                 NULL, &size, &secboot);
> -       if (status == EFI_NOT_FOUND) {
> -               pr_info("ima: secureboot mode disabled\n");
> -               return efi_secureboot_mode_disabled;
> -       }
> -
> -       if (status != EFI_SUCCESS) {
> -               pr_info("ima: secureboot mode unknown\n");
> -               return efi_secureboot_mode_unknown;
> -       }
> -
> -       size = sizeof(setupmode);
> -       status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> -                                 NULL, &size, &setupmode);
> -
> -       if (status != EFI_SUCCESS)      /* ignore unknown SetupMode */
> -               setupmode = 0;
> -
> -       if (secboot == 0 || setupmode == 1) {
> -               pr_info("ima: secureboot mode disabled\n");
> -               return efi_secureboot_mode_disabled;
> -       }
> -
> -       pr_info("ima: secureboot mode enabled\n");
> -       return efi_secureboot_mode_enabled;
> -}
> -
>  bool arch_ima_get_secureboot(void)
>  {
> -       static enum efi_secureboot_mode sb_mode;
> -       static bool initialized;
> -
> -       if (!initialized && efi_enabled(EFI_BOOT)) {
> -               sb_mode = boot_params.secure_boot;
> +       static bool sb_enabled, initialized;
>
> -               if (sb_mode == efi_secureboot_mode_unset)
> -                       sb_mode = get_sb_mode();
> +       if (initialized) {
> +               return sb_enabled;
> +       } else if (efi_enabled(EFI_BOOT)) {
>                 initialized = true;
> +
> +               if (boot_params.secure_boot == efi_secureboot_mode_unset) {
> +                       sb_enabled = ima_get_efi_secureboot();
> +                       return sb_enabled;
> +               }
>         }
>
> -       if (sb_mode == efi_secureboot_mode_enabled)
> -               return true;
> -       else
> -               return false;
> +       if (boot_params.secure_boot == efi_secureboot_mode_enabled)
> +               sb_enabled = true;
> +
> +       return sb_enabled;
>  }
>
> -/* secureboot arch rules */
> +/* secure and trusted boot arch rules */
>  static const char * const sb_arch_rules[] = {
>  #if !IS_ENABLED(CONFIG_KEXEC_SIG)
>         "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 8fa7bcfb2da2..9f9699f017be 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -50,6 +50,16 @@ static inline const char * const *arch_get_ima_policy(void)
>  }
>  #endif
>
> +#if defined(CONFIG_EFI) && defined(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)
> +extern bool ima_get_efi_secureboot(void);
> +#else
> +static inline bool ima_get_efi_secureboot(void)
> +{
> +       return false;
> +}
> +#endif
> +
> +
>  #else
>  static inline int ima_bprm_check(struct linux_binprm *bprm)
>  {
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 67dabca670e2..32076b3fd292 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -14,3 +14,4 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> +ima-$(CONFIG_EFI) += ima_efi.o
> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
> new file mode 100644
> index 000000000000..a78f66e19689
> --- /dev/null
> +++ b/security/integrity/ima/ima_efi.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 SUSE LLC
> + *
> + * Author:
> + * Chester Lin <clin@suse.com>
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/ima.h>
> +
> +#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
> +bool ima_get_efi_secureboot(void)
> +{
> +       enum efi_secureboot_mode sb_mode;
> +
> +       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> +               pr_info("ima: secureboot mode unknown, no efi\n");
> +               return false;
> +       }
> +
> +       sb_mode = efi_get_secureboot(efi.get_variable);
> +

As I mentioned in the other patch, these are not equivalent - you are
introducing a MokSbState check which doesn't make sense at runtime (or
at all perhaps)

> +       return (sb_mode == efi_secureboot_mode_enabled) ? true : false;
> +}
> +#endif
> --
> 2.28.0
>
