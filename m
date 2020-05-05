Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1A1C4FBF
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgEEH6n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 May 2020 03:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEH6n (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 May 2020 03:58:43 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD81206CC
        for <linux-efi@vger.kernel.org>; Tue,  5 May 2020 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588665522;
        bh=S2S1qMx2N/dRfni497FHhatfS4mgg7vbrn0vP7VTOPM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EVBIMQ0kpWssAkAO5wW7uDbTz/2/Ly8XhNqYEe3QTRs2gHiJAgdKxoTFxhPfJenMS
         OFp5Jfzgrm8vi2axrflFTSNgnGSlhkoyOrWrJNGTGUmeCT0BJQb12GuqoC67ephwZg
         4m243gJOEF44wHCR5MCxxPyrXoga4JuDrdEqILrc=
Received: by mail-io1-f48.google.com with SMTP id i19so975128ioh.12
        for <linux-efi@vger.kernel.org>; Tue, 05 May 2020 00:58:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ7AcB4gXp/h1sLCOqxRqBSEYQeF2uiTMae+l7aJbGqloqDVY79
        diMKptH69/NKCYa3+HwbY0ptYlTG1w+w0J2kAuE=
X-Google-Smtp-Source: APiQypJ40nSjWwEgGQ78HI1Ha/t4+220r8t0sJv06u2Mh13Cu395zNLoeP6VNhWGHGLmXERZtEPPik3BuSQgtg/ynwQ=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr2131106ioh.203.1588665521836;
 Tue, 05 May 2020 00:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXES5qXEdtHCUoV8Oy6ZukWL=iQh+ppVo777LNtRG+kH6A@mail.gmail.com>
 <20200504150248.62482-1-nivedita@alum.mit.edu>
In-Reply-To: <20200504150248.62482-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 5 May 2020 09:58:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGO89BcHHzbZvDF4f_Epe98xc6-qq+3m3ZVcWNRVxG=sQ@mail.gmail.com>
Message-ID: <CAMj1kXGO89BcHHzbZvDF4f_Epe98xc6-qq+3m3ZVcWNRVxG=sQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi/libstub: Fix mixed mode boot issue after macro refactor
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 4 May 2020 at 17:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>   22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")
>
> refactored the macros that are used to provide wrappers for mixed-mode
> calls on x86, allowing us to boot a 64-bit kernel on 32-bit firmware.
>
> Unfortunately, this broke mixed mode boot due to the fact that
> efi_is_native() is not a macro on x86.
>
> All of these macros should go together, so rather than testing each one
> to see if it is defined, condition the generic macro definitions on a
> new ARCH_HAS_EFISTUB_WRAPPERS, and remove the wrapper definitions on x86
> as well if CONFIG_EFI_MIXED is not enabled.
>
> Fixes: 22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks Arvind, I've queued this up now.

> ---
>  arch/x86/include/asm/efi.h             | 19 +++++++++++++++----
>  drivers/firmware/efi/libstub/efistub.h | 14 ++++----------
>  2 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index cd0c3fbf6156..6b9ab0d8b2a7 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -225,13 +225,15 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
>
>  /* arch specific definitions used by the stub code */
>
> -extern const bool efi_is64;
> +#ifdef CONFIG_EFI_MIXED
> +
> +#define ARCH_HAS_EFISTUB_WRAPPERS
>
>  static inline bool efi_is_64bit(void)
>  {
> -       if (IS_ENABLED(CONFIG_EFI_MIXED))
> -               return efi_is64;
> -       return IS_ENABLED(CONFIG_X86_64);
> +       extern const bool efi_is64;
> +
> +       return efi_is64;
>  }
>
>  static inline bool efi_is_native(void)
> @@ -356,6 +358,15 @@ static inline u32 efi64_convert_status(efi_status_t status)
>                                                    runtime),            \
>                                     func, __VA_ARGS__))
>
> +#else /* CONFIG_EFI_MIXED */
> +
> +static inline bool efi_is_64bit(void)
> +{
> +       return IS_ENABLED(CONFIG_X86_64);
> +}
> +
> +#endif /* CONFIG_EFI_MIXED */
> +
>  extern bool efi_reboot_required(void);
>  extern bool efi_is_table_address(unsigned long phys_addr);
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 874233cf8820..4f10a09563f3 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -33,20 +33,14 @@ extern bool efi_novamap;
>
>  extern const efi_system_table_t *efi_system_table;
>
> -#ifndef efi_bs_call
> +#ifndef ARCH_HAS_EFISTUB_WRAPPERS
> +
> +#define efi_is_native()                (true)
>  #define efi_bs_call(func, ...) efi_system_table->boottime->func(__VA_ARGS__)
> -#endif
> -#ifndef efi_rt_call
>  #define efi_rt_call(func, ...) efi_system_table->runtime->func(__VA_ARGS__)
> -#endif
> -#ifndef efi_is_native
> -#define efi_is_native()                (true)
> -#endif
> -#ifndef efi_table_attr
>  #define efi_table_attr(inst, attr)     (inst->attr)
> -#endif
> -#ifndef efi_call_proto
>  #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
> +
>  #endif
>
>  #define efi_info(msg)          do {                    \
> --
> 2.26.2
>
