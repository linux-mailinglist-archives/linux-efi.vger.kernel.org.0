Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A3D2A04CE
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJ3Lxj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 07:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgJ3Lxj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 30 Oct 2020 07:53:39 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930B022245;
        Fri, 30 Oct 2020 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604058817;
        bh=d3fuMxWlzDmtJJrL2Md7MIp8HAK24XJci5Rj9/IXNek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P639Eq7j8YcRl1gPHu3NalkhSdzAgeREjxAHYFtNfZ7GJFEfqabKpISxNCUeguPj7
         tZgHFaKIfT87mpWK9ZLJoqfZWoOyDjXLApMaO+AwJEcDLRVR5Bf8F3bmwtOxa2bZpB
         8xT/YuQW+hpuGxNSXYwIqPBoBUrv0dLxFI5amGD0=
Received: by mail-oi1-f173.google.com with SMTP id l62so716474oig.1;
        Fri, 30 Oct 2020 04:53:37 -0700 (PDT)
X-Gm-Message-State: AOAM5339tVq8wMSQN7Jm0IkReW1ohWt1p1aVl8Nu5UplDPBmRl0JS2Xv
        iqn02xnjhuaXrOr11DsVhLUyUpQ/Bx1GW8zMRHg=
X-Google-Smtp-Source: ABdhPJzgiMhx0rV2JinMkA8Ww1A1B72xR8FBexBi9QJsDuwAWFMOSjFL8BwlpiIHRIAnVKfRfajVNQgJV1+RiQPhRDo=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr1316465oib.33.1604058816714;
 Fri, 30 Oct 2020 04:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201030060840.1810-1-clin@suse.com> <20201030060840.1810-4-clin@suse.com>
In-Reply-To: <20201030060840.1810-4-clin@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Oct 2020 12:53:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFhZEHP37_tkzzHHhkk-Ej+eRcCinMv-tOdp7vvb1d1mQ@mail.gmail.com>
Message-ID: <CAMj1kXFhZEHP37_tkzzHHhkk-Ej+eRcCinMv-tOdp7vvb1d1mQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64/ima: add ima_arch support
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
> Add arm64 IMA arch support. The code and arch policy is mainly inherited
> from x86.
>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/kernel/Makefile   |  2 ++
>  arch/arm64/kernel/ima_arch.c | 43 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 arch/arm64/kernel/ima_arch.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a42e8d13cc88..496a4a26afc6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -201,6 +201,7 @@ config ARM64
>         select SWIOTLB
>         select SYSCTL_EXCEPTION_TRACE
>         select THREAD_INFO_IN_TASK
> +       imply IMA_SECURE_AND_OR_TRUSTED_BOOT if EFI
>         help
>           ARM 64-bit (AArch64) Linux support.
>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index bbaf0bc4ad60..0f6cbb50668c 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -69,3 +69,5 @@ extra-y                                       += $(head-y) vmlinux.lds
>  ifeq ($(CONFIG_DEBUG_EFI),y)
>  AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
>  endif
> +
> +obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)   += ima_arch.o
> diff --git a/arch/arm64/kernel/ima_arch.c b/arch/arm64/kernel/ima_arch.c
> new file mode 100644
> index 000000000000..564236d77adc
> --- /dev/null
> +++ b/arch/arm64/kernel/ima_arch.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 IBM Corporation
> + */
> +#include <linux/efi.h>
> +#include <linux/module.h>
> +#include <linux/ima.h>
> +
> +bool arch_ima_get_secureboot(void)
> +{
> +       static bool sb_enabled;
> +       static bool initialized;
> +
> +       if (!initialized & efi_enabled(EFI_BOOT)) {
> +               sb_enabled = ima_get_efi_secureboot();
> +               initialized = true;
> +       }
> +
> +       return sb_enabled;
> +}
> +
> +/* secure and trusted boot arch rules */
> +static const char * const sb_arch_rules[] = {
> +#if !IS_ENABLED(CONFIG_KEXEC_SIG)
> +       "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> +#endif /* CONFIG_KEXEC_SIG */
> +       "measure func=KEXEC_KERNEL_CHECK",
> +#if !IS_ENABLED(CONFIG_MODULE_SIG)
> +       "appraise func=MODULE_CHECK appraise_type=imasig",
> +#endif
> +       "measure func=MODULE_CHECK",
> +       NULL
> +};
> +
> +const char * const *arch_get_ima_policy(void)
> +{
> +       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> +               if (IS_ENABLED(CONFIG_MODULE_SIG))
> +                       set_module_sig_enforced();
> +               return sb_arch_rules;
> +       }
> +       return NULL;
> +}
> --
> 2.28.0
>

Can we move all this stuff into security/integrity/ima/ima_efi.c instead?
