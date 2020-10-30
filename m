Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672EA2A04ED
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJ3MCN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 08:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJ3MCK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 30 Oct 2020 08:02:10 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0EB222241;
        Fri, 30 Oct 2020 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604058683;
        bh=iAlwuTdtaIWHAl/BzByU2/AHOTw8WNQf01j7i+WfeTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a+Hus/IAXtz6Y0C7bc2/VW4IC2S75Usph/HU0NsgKNAO79sTCVe/Bv1LxFnfMibHO
         +tfvm9uXIfxcFUGdCiPAjG1xwSBkIc1klLG0S9fygtxlDNSyN8UY5kDiAUrwTPxZiu
         LxDeo5GrEkxfE4gtzCiXpAxusxZ8Z2fHNpEd59Ks=
Received: by mail-oi1-f177.google.com with SMTP id m128so6360958oig.7;
        Fri, 30 Oct 2020 04:51:22 -0700 (PDT)
X-Gm-Message-State: AOAM532dRz8YaIEnIcVq9SDX8maJRSM/VpFjnEwxli7Jlh9I/fSsuqRB
        4VCQeQ5+b+gDxkaLct4ZPkwQmCZb41uOoUViGj0=
X-Google-Smtp-Source: ABdhPJxIeLsTOfSSrXskv1BVND+IRksJHTYNIXmsLhSPevTBgNsUNCa+yGIYO+eV7Mi8Vsn/9SuBRAbBcBLXm7WDkRo=
X-Received: by 2002:aca:2310:: with SMTP id e16mr1215934oie.47.1604058681854;
 Fri, 30 Oct 2020 04:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201030060840.1810-1-clin@suse.com> <20201030060840.1810-2-clin@suse.com>
In-Reply-To: <20201030060840.1810-2-clin@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Oct 2020 12:51:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFaARnhvnSKSFvAXXY1TKfv=_hG3z=B2j=G3p7qLeQaYw@mail.gmail.com>
Message-ID: <CAMj1kXFaARnhvnSKSFvAXXY1TKfv=_hG3z=B2j=G3p7qLeQaYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] efi: generalize efi_get_secureboot
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

Hello Chester,

Thanks again for looking into this.

On Fri, 30 Oct 2020 at 07:09, Chester Lin <clin@suse.com> wrote:
>
> Generalize the efi_get_secureboot() function so not only efistub but also
> other subsystems can use it.
>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  drivers/firmware/efi/libstub/Makefile     |  2 +-
>  drivers/firmware/efi/libstub/efi-stub.c   |  2 +-
>  drivers/firmware/efi/libstub/efistub.h    | 22 ++++---
>  drivers/firmware/efi/libstub/secureboot.c | 76 -----------------------
>  drivers/firmware/efi/libstub/x86-stub.c   |  2 +-
>  include/linux/efi.h                       | 41 +++++++++++-
>  6 files changed, 57 insertions(+), 88 deletions(-)
>  delete mode 100644 drivers/firmware/efi/libstub/secureboot.c
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 8a94388e38b3..88e47b0ca09d 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -49,7 +49,7 @@ OBJECT_FILES_NON_STANDARD     := y
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>  KCOV_INSTRUMENT                        := n
>
> -lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
> +lib-y                          := efi-stub-helper.o gop.o tpm.o \
>                                    file.o mem.o random.o randomalloc.o pci.o \
>                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
>                                    alignedmem.o relocate.o vsprintf.o
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 914a343c7785..ad96f1d786a9 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -196,7 +196,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         /* Ask the firmware to clear memory on unclean shutdown */
>         efi_enable_reset_attack_mitigation();
>
> -       secure_boot = efi_get_secureboot();
> +       secure_boot = efi_get_secureboot(get_efi_var);
>
>         /*
>          * Unauthenticated device tree data is a security hazard, so ignore
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 2d7abcd99de9..b1833b51e6d6 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -91,14 +91,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         fdt_setprop((fdt), (node_offset), (name), &(var), sizeof(var))
>  #endif
>
> -#define get_efi_var(name, vendor, ...)                         \
> -       efi_rt_call(get_variable, (efi_char16_t *)(name),       \
> -                   (efi_guid_t *)(vendor), __VA_ARGS__)
> -
> -#define set_efi_var(name, vendor, ...)                         \
> -       efi_rt_call(set_variable, (efi_char16_t *)(name),       \
> -                   (efi_guid_t *)(vendor), __VA_ARGS__)
> -
>  #define efi_get_handle_at(array, idx)                                  \
>         (efi_is_native() ? (array)[idx]                                 \
>                 : (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
> @@ -112,6 +104,20 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>                 ((handle = efi_get_handle_at((array), i)) || true);     \
>              i++)
>
> +static inline
> +efi_status_t get_efi_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
> +                        unsigned long *size, void *data)
> +{
> +       return efi_rt_call(get_variable, name, vendor, attr, size, data);
> +}
> +
> +static inline
> +efi_status_t set_efi_var(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
> +                        unsigned long size, void *data)
> +{
> +       return efi_rt_call(set_variable, name, vendor, attr, size, data);
> +}
> +
>  static inline
>  void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
>  {
> diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
> deleted file mode 100644
> index 5efc524b14be..000000000000
> --- a/drivers/firmware/efi/libstub/secureboot.c
> +++ /dev/null

Please keep this file (see below)

> @@ -1,76 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Secure boot handling.
> - *
> - * Copyright (C) 2013,2014 Linaro Limited
> - *     Roy Franz <roy.franz@linaro.org
> - * Copyright (C) 2013 Red Hat, Inc.
> - *     Mark Salter <msalter@redhat.com>
> - */
> -#include <linux/efi.h>
> -#include <asm/efi.h>
> -
> -#include "efistub.h"
> -
> -/* BIOS variables */
> -static const efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> -static const efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
> -static const efi_char16_t efi_SetupMode_name[] = L"SetupMode";
> -
> -/* SHIM variables */
> -static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> -static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
> -
> -/*
> - * Determine whether we're in secure boot mode.
> - *
> - * Please keep the logic in sync with
> - * arch/x86/xen/efi.c:xen_efi_get_secureboot().
> - */
> -enum efi_secureboot_mode efi_get_secureboot(void)
> -{
> -       u32 attr;
> -       u8 secboot, setupmode, moksbstate;
> -       unsigned long size;
> -       efi_status_t status;
> -
> -       size = sizeof(secboot);
> -       status = get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
> -                            NULL, &size, &secboot);
> -       if (status == EFI_NOT_FOUND)
> -               return efi_secureboot_mode_disabled;
> -       if (status != EFI_SUCCESS)
> -               goto out_efi_err;
> -
> -       size = sizeof(setupmode);
> -       status = get_efi_var(efi_SetupMode_name, &efi_variable_guid,
> -                            NULL, &size, &setupmode);
> -       if (status != EFI_SUCCESS)
> -               goto out_efi_err;
> -
> -       if (secboot == 0 || setupmode == 1)
> -               return efi_secureboot_mode_disabled;
> -
> -       /*
> -        * See if a user has put the shim into insecure mode. If so, and if the
> -        * variable doesn't have the runtime attribute set, we might as well
> -        * honor that.
> -        */
> -       size = sizeof(moksbstate);
> -       status = get_efi_var(shim_MokSBState_name, &shim_guid,
> -                            &attr, &size, &moksbstate);
> -

MokSBState is a boot time variable, so we cannot access it when
running under the OS. Xen also has a code flow similar to this one,
but it looks at MokSbStateRt instead (which may be a mistake but let's
forget about that for now)

So what we will need to do is factor out only the top part of this
function (which, incidentally, is the only part that IMA uses in the
first place)

> -       /* If it fails, we don't care why. Default to secure */
> -       if (status != EFI_SUCCESS)
> -               goto secure_boot_enabled;
> -       if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate == 1)
> -               return efi_secureboot_mode_disabled;
> -
> -secure_boot_enabled:
> -       efi_info("UEFI Secure Boot is enabled.\n");
> -       return efi_secureboot_mode_enabled;
> -
> -out_efi_err:
> -       efi_err("Could not determine UEFI Secure Boot status.\n");
> -       return efi_secureboot_mode_unknown;
> -}

So let's keep this file, and also, let's put a wrapper function around
get_efi_var() here, of which you can take the address and pass to the
static inline function.

> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 3672539cb96e..3f9b492c566b 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -781,7 +781,7 @@ unsigned long efi_main(efi_handle_t handle,
>          * otherwise we ask the BIOS.
>          */
>         if (boot_params->secure_boot == efi_secureboot_mode_unset)
> -               boot_params->secure_boot = efi_get_secureboot();
> +               boot_params->secure_boot = efi_get_secureboot(get_efi_var);
>
>         /* Ask the firmware to clear memory on unclean shutdown */
>         efi_enable_reset_attack_mitigation();
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index d7c0e73af2b9..cc2d3de39031 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1089,7 +1089,46 @@ enum efi_secureboot_mode {
>         efi_secureboot_mode_disabled,
>         efi_secureboot_mode_enabled,
>  };
> -enum efi_secureboot_mode efi_get_secureboot(void);
> +
> +static inline enum efi_secureboot_mode efi_get_secureboot(efi_get_variable_t *get_var)
> +{
> +       efi_guid_t var_guid = EFI_GLOBAL_VARIABLE_GUID;
> +       efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> +       efi_status_t status;
> +       unsigned long size;
> +       u8 secboot, setupmode, moksbstate;
> +       u32 attr;
> +
> +       size = sizeof(secboot);
> +       status = get_var(L"SecureBoot", &var_guid, NULL, &size, &secboot);
> +
> +       if (status == EFI_NOT_FOUND)
> +               return efi_secureboot_mode_disabled;
> +       if (status != EFI_SUCCESS)
> +               return efi_secureboot_mode_unknown;
> +
> +       size = sizeof(setupmode);
> +       status = get_var(L"SetupMode", &var_guid, NULL, &size, &setupmode);
> +
> +       if (status != EFI_SUCCESS)
> +               return efi_secureboot_mode_unknown;
> +       if (secboot == 0 || setupmode == 1)
> +               return efi_secureboot_mode_disabled;
> +

So keep until here and move the rest back into the .c file

> +       /*
> +        * See if a user has put the shim into insecure mode. If so, and if the
> +        * variable doesn't have the runtime attribute set, we might as well
> +        * honor that.
> +        */
> +       size = sizeof(moksbstate);
> +       status = get_var(L"MokSBState", &shim_guid, &attr, &size, &moksbstate);
> +       /* If it fails, we don't care why. Default to secure */
> +       if (status == EFI_SUCCESS && moksbstate == 1
> +           && !(attr & EFI_VARIABLE_RUNTIME_ACCESS))
> +               return efi_secureboot_mode_disabled;
> +
> +       return efi_secureboot_mode_enabled;
> +}
>
>  #ifdef CONFIG_RESET_ATTACK_MITIGATION
>  void efi_enable_reset_attack_mitigation(void);
> --
> 2.28.0
>
