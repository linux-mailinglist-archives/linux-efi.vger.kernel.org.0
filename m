Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38D178B27
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 08:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgCDHPA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 02:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgCDHPA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 02:15:00 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6FEF2166E
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583306100;
        bh=y/uI56ETxOiF6to8G8JqcU7y5zIAtMZUIPSNK75yQaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=frLZ0cOjqoDMu/nKrqwr5M/2S0Lg54WCLE57WKjKfgOG4t8G2LcgVlMX8j6p634LX
         dnYDdohb3/f5iLpotWSgwS1JYAQxqB7eXsDCFLauTYZ55KdQM2AIrhB9CCbO6CK+mc
         uMtxUrMe7/de//Ec3ztgKeH/3lwWnQtU2/xq+juY=
Received: by mail-wr1-f47.google.com with SMTP id v4so986893wrs.8
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 23:14:59 -0800 (PST)
X-Gm-Message-State: ANhLgQ2kwYng2oY7UYUDnKWeJ2q1vwa2pVIqFPOd9D0wcfnQfgNYt51R
        e/nQZgrrXd8SNnBP1LYEeYCSLPS4glmt5Xn9deh5BA==
X-Google-Smtp-Source: ADFU+vsGlLQvbg2b4VyvIhLZsuwvT9bOKvkSVXVxtjdU8xD0muWLXxDg79EArj7HfEYPCjiH5EOmTfKn41X99UZ6YzE=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr2585836wrq.208.1583306093565;
 Tue, 03 Mar 2020 23:14:53 -0800 (PST)
MIME-Version: 1.0
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
In-Reply-To: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 08:14:42 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu831SRo+Di6WgKTex40TcOVqNQAdeNLtfQpPdgnvrxucw@mail.gmail.com>
Message-ID: <CAKv+Gu831SRo+Di6WgKTex40TcOVqNQAdeNLtfQpPdgnvrxucw@mail.gmail.com>
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific policies
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 03:34, Nayna Jain <nayna@linux.ibm.com> wrote:
>
> Every time a new architecture defines the IMA architecture specific
> functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> include file needs to be updated. To avoid this "noise", this patch
> defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> the different architectures to select it.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

for the x86 bits, but I'm not an x86 maintainer. Also, you may need to
split this if you want to permit arch maintainers to pick up their
parts individually.


> ---
> v2:
> * Fixed the issue identified by Mimi. Thanks Mimi, Ard, Heiko and Michael for
> discussing the fix.
>
>  arch/powerpc/Kconfig           | 1 +
>  arch/s390/Kconfig              | 1 +
>  arch/x86/Kconfig               | 1 +
>  include/linux/ima.h            | 3 +--
>  security/integrity/ima/Kconfig | 9 +++++++++
>  5 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 497b7d0b2d7e..a5cfde432983 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -979,6 +979,7 @@ config PPC_SECURE_BOOT
>         bool
>         depends on PPC_POWERNV
>         depends on IMA_ARCH_POLICY
> +       select IMA_SECURE_AND_OR_TRUSTED_BOOT
>         help
>           Systems with firmware secure boot enabled need to define security
>           policies to extend secure boot to the OS. This config allows a user
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8abe77536d9d..4a502fbcb800 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -195,6 +195,7 @@ config S390
>         select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>         select SWIOTLB
>         select GENERIC_ALLOCATOR
> +       select IMA_SECURE_AND_OR_TRUSTED_BOOT if IMA_ARCH_POLICY
>
>
>  config SCHED_OMIT_FRAME_POINTER
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..7f5bfaf0cbd2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -230,6 +230,7 @@ config X86
>         select VIRT_TO_BUS
>         select X86_FEATURE_NAMES                if PROC_FS
>         select PROC_PID_ARCH_STATUS             if PROC_FS
> +       select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY
>
>  config INSTRUCTION_DECODER
>         def_bool y
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 1659217e9b60..aefe758f4466 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
>
> -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
> -       || defined(CONFIG_PPC_SECURE_BOOT)
> +#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
>  extern bool arch_ima_get_secureboot(void);
>  extern const char * const *arch_get_ima_policy(void);
>  #else
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 3f3ee4e2eb0d..d17972aa413a 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>         depends on IMA_MEASURE_ASYMMETRIC_KEYS
>         depends on SYSTEM_TRUSTED_KEYRING
>         default y
> +
> +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> +       bool
> +       depends on IMA
> +       depends on IMA_ARCH_POLICY

Doesn't the latter already depend on the former?

> +       default n
> +       help
> +          This option is selected by architectures to enable secure and/or
> +          trusted boot based on IMA runtime policies.
> --
> 2.13.6
>
