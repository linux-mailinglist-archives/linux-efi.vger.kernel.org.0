Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFC28DF82
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgJNLA6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 07:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgJNLA6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Oct 2020 07:00:58 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46972222F;
        Wed, 14 Oct 2020 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602673257;
        bh=UAicbC8Manxoolo8W7mfy4Wt2NU3mR6k0HSvVzJy6Wg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZiZdJhHA1gDKsRqfL0nlW9VmDSBlJoG3F3XN9VysGizmH+pgYTylleus6H/UDdfLe
         B/KZpmkRyv6Q1CJ0Q1dM9khOrRM6T2y5mSusEaxxK33AQRr6hfAzz5SFEwL6gcaFZM
         hXKkpNGoEFjX3pI5GnVNYglVeJoVhRcl1UoMv/Rw=
Received: by mail-oo1-f52.google.com with SMTP id w7so669555oow.7;
        Wed, 14 Oct 2020 04:00:56 -0700 (PDT)
X-Gm-Message-State: AOAM533zsQP26UTWEmEgTxQjuyZHP0j85WQPhEVNJZYlKruOtZqg9XGB
        ra293c30FPwkRbkeg6dYg3Ygv4hcrDwM7Xc+slI=
X-Google-Smtp-Source: ABdhPJxPXpUg8zrW0K+njo+stclAzJd7g2wXzKIOKx97YKd84RLnr/V7grfdOui6LYKR6kmynkp8jCVAzGJd2NQtQ50=
X-Received: by 2002:a4a:b443:: with SMTP id h3mr2947134ooo.45.1602673255841;
 Wed, 14 Oct 2020 04:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201014104032.9776-1-clin@suse.com> <20201014104032.9776-2-clin@suse.com>
In-Reply-To: <20201014104032.9776-2-clin@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 14 Oct 2020 13:00:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGacnj=uh9WFh1+YBVXxzZbxeN==Y_f-rhJZ=3385B68g@mail.gmail.com>
Message-ID: <CAMj1kXGacnj=uh9WFh1+YBVXxzZbxeN==Y_f-rhJZ=3385B68g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi: add secure boot get helper
To:     Chester Lin <clin@suse.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Chester,

Thanks for looking into this.

Some comments below.

On Wed, 14 Oct 2020 at 12:41, Chester Lin <clin@suse.com> wrote:
>
> Separate the get_sb_mode() from arch/x86 and treat it as a common function
> [rename to efi_get_secureboot_mode] so all EFI-based architectures can
> reuse the same logic.
>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/x86/kernel/ima_arch.c | 47 ++------------------------------------
>  drivers/firmware/efi/efi.c | 43 ++++++++++++++++++++++++++++++++++
>  include/linux/efi.h        |  5 ++++
>  3 files changed, 50 insertions(+), 45 deletions(-)
>
> diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> index 7dfb1e808928..ed4623ecda6e 100644
> --- a/arch/x86/kernel/ima_arch.c
> +++ b/arch/x86/kernel/ima_arch.c
> @@ -8,49 +8,6 @@
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
>         static enum efi_secureboot_mode sb_mode;
> @@ -60,7 +17,7 @@ bool arch_ima_get_secureboot(void)
>                 sb_mode = boot_params.secure_boot;
>
>                 if (sb_mode == efi_secureboot_mode_unset)
> -                       sb_mode = get_sb_mode();
> +                       sb_mode = efi_get_secureboot_mode();
>                 initialized = true;
>         }
>
> @@ -70,7 +27,7 @@ bool arch_ima_get_secureboot(void)
>                 return false;
>  }
>
> -/* secureboot arch rules */
> +/* secure and trusted boot arch rules */
>  static const char * const sb_arch_rules[] = {
>  #if !IS_ENABLED(CONFIG_KEXEC_SIG)
>         "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5e5480a0a32d..68ffa6a069c0 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -1022,3 +1022,46 @@ static int __init register_update_efi_random_seed(void)
>  }
>  late_initcall(register_update_efi_random_seed);
>  #endif
> +
> +enum efi_secureboot_mode efi_get_secureboot_mode(void)
> +{
> +       efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> +       efi_status_t status;
> +       unsigned long size;
> +       u8 secboot, setupmode;
> +
> +       size = sizeof(secboot);
> +
> +       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> +               pr_info("ima: secureboot mode unknown, no efi\n");

These prints don't belong here anymore.

Also, it would be useful if we could reuse this logic in the EFI stub
as well, which is built as a separate executable, and does not provide
efi.get_variable().

So, you could you please break this up into

static inline
enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
{
}

placed into include/linux/efi.h, which encapsulates the core logic,
but using get_var(), and without the prints.

Then, we could put something like

bool efi_ima_get_secureboot(void)
{
}

in drivers/firmware/efi/efi.c (guarded by #ifdef CONFIG_IMA_xxx),
which performs the
efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) check, calls
efi_get_secureboot_mode(efi.get_variable), and implements the logic.

And actually, if the logic is identical between x86 and arm64, I
wonder if it wouldn't be better to put the whole thing into

drivers/firmware/efi/efi-ima.c

or

security/integrity/ima/ima-efi.c

with the only difference being the boot_params->secure_boot access for
x86, which we can factor out to a static inline helper.

Mimi, any thoughts here?



> +               return efi_secureboot_mode_unknown;
> +       }
> +
> +       /* Get variable contents into buffer */
> +       status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> +                                 NULL, &size, &secboot);
> +       if (status == EFI_NOT_FOUND) {
> +               pr_info("ima: secureboot mode disabled\n");
> +               return efi_secureboot_mode_disabled;
> +       }
> +
> +       if (status != EFI_SUCCESS) {
> +               pr_info("ima: secureboot mode unknown\n");
> +               return efi_secureboot_mode_unknown;
> +       }
> +
> +       size = sizeof(setupmode);
> +       status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> +                                 NULL, &size, &setupmode);
> +
> +       if (status != EFI_SUCCESS)      /* ignore unknown SetupMode */
> +               setupmode = 0;
> +
> +       if (secboot == 0 || setupmode == 1) {
> +               pr_info("ima: secureboot mode disabled\n");
> +               return efi_secureboot_mode_disabled;
> +       }
> +
> +       pr_info("ima: secureboot mode enabled\n");
> +       return efi_secureboot_mode_enabled;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index d7c0e73af2b9..a73e5ae04672 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1076,8 +1076,13 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
>
>  #ifdef CONFIG_EFI
>  extern bool efi_runtime_disabled(void);
> +extern enum efi_secureboot_mode efi_get_secureboot_mode(void);
>  #else
>  static inline bool efi_runtime_disabled(void) { return true; }
> +static inline enum efi_secureboot_mode efi_get_secureboot_mode(void)
> +{
> +       return efi_secureboot_mode_disabled;
> +}
>  #endif
>
>  extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
> --
> 2.26.1
>
