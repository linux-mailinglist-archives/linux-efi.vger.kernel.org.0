Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541912F517B
	for <lists+linux-efi@lfdr.de>; Wed, 13 Jan 2021 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbhAMRww (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Jan 2021 12:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbhAMRww (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 13 Jan 2021 12:52:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AE8F23444;
        Wed, 13 Jan 2021 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610560331;
        bh=DlYHZfCCpmtKD2iA6iFDDmBTIg4oFcFxKoR31k+rmT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cd2LEA8JLCiaW87SV/HkvynYXNoBxc2A9QLFkSMJtQBqkut6/Zj18uD3G2Y0uMdcF
         Bo5uL8StWQKJeA1t6lJ45/VlIypGlE5AF3TQ05o/vxlDb7g/Z+Fnpf8jvYcjUdwy0S
         j0kLXZRNoDD9zS7wboi1EAe9PoNeXwwEBaNVBdKMTO6r+/JYFtAv4mpDJ4w6+ThHkh
         FiF4Qx94em0NlqC+Rtgjl7qvqe8fxOiXX9WQs3oYvNDOP2LVEISd5CHr71ZDOGrXP5
         H9ax/LxX9orjkeUORnh6E3/EX16H45lRfCcHrMErjdutXehKj69C272uh/dZX9ya7R
         iSfwz9pM6l1/Q==
Received: by mail-oi1-f177.google.com with SMTP id d189so2990288oig.11;
        Wed, 13 Jan 2021 09:52:11 -0800 (PST)
X-Gm-Message-State: AOAM533UcbCS2kdiFGi0BQaMSAI6xrIhq1EMOwt6eh33+qZjFiQNSlm5
        hvaAg1qBqUR5FeDFkjKfTonpIIqZykVA6T+V040=
X-Google-Smtp-Source: ABdhPJzzvtcIKBlmebJ+RPFNOL6VH7OwwahKaSDopkWZ8XRgq/3f31wHNIqnED4Q2va6+gbrWfLNGEdlzOy2HD3vNhg=
X-Received: by 2002:aca:210f:: with SMTP id 15mr263013oiz.174.1610560330694;
 Wed, 13 Jan 2021 09:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20210107223424.4135538-1-arnd@kernel.org>
In-Reply-To: <20210107223424.4135538-1-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Jan 2021 18:51:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGLO3TxH8oVYq+iT1f_kdunobY9C7a6dmFNmFQoSnzQcQ@mail.gmail.com>
Message-ID: <CAMj1kXGLO3TxH8oVYq+iT1f_kdunobY9C7a6dmFNmFQoSnzQcQ@mail.gmail.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 7 Jan 2021 at 23:34, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():
>
> x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
>
> Use the same method as in commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT
> and PTRS_PER_P4D variable") and change it to MAYBE_BUILD_BUG_ON(),
> so it only triggers for constant input.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/256
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

This can go via the x86 tree directly, IMO

> ---
>  arch/x86/platform/efi/efi_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..62bb1616b4a5 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -137,8 +137,8 @@ void efi_sync_low_kernel_mappings(void)
>          * As with PGDs, we share all P4D entries apart from the one entry
>          * that covers the EFI runtime mapping space.
>          */
> -       BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> +       MAYBE_BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> +       MAYBE_BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
>
>         pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>         pgd_k = pgd_offset_k(EFI_VA_END);
> --
> 2.29.2
>
