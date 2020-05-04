Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7BE1C33FD
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgEDIFf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 04:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgEDIFf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 4 May 2020 04:05:35 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C2420643
        for <linux-efi@vger.kernel.org>; Mon,  4 May 2020 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588579534;
        bh=MNNjjTY3ITACw4LyIUM96tc6eesaFB3rBgFQjRjQbxE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lbhUheSKvyjeQz5c4FfGNEVuNcnUge130fAGuA3zHQ+X9Pn009o2tFi1n88RYykZ0
         HE7HSmxRDimCoHTKOYLIBGCGBV/tA8nTX2JppoYvlg66x9WUok9TT9grHzrx3mV4fC
         m+W2rLoBSqigM+R4xXm7ih+3kXagULMugu32ireE=
Received: by mail-il1-f182.google.com with SMTP id i16so10387385ils.12
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 01:05:34 -0700 (PDT)
X-Gm-Message-State: AGi0PuYgIsGD/V7Tf1e3kKAOJltGQJj+uT14pvV4zjz2zaYYlI27MFLD
        FN7fOSlRr/6oMGMhVDhgonDMPIr/SqkuFVnZWis=
X-Google-Smtp-Source: APiQypLt9H9dJT8AeHyVY/AEooZaZr815lF/KeGap/EAMIuekpMoZgbpiEI/Shc9jObrlcUjj1D8ipyLdtPBV+TF3pw=
X-Received: by 2002:a92:39dd:: with SMTP id h90mr15185567ilf.80.1588579534171;
 Mon, 04 May 2020 01:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200503154507.82880-1-ardb@kernel.org> <20200504003852.1096018-1-nivedita@alum.mit.edu>
 <20200504003852.1096018-2-nivedita@alum.mit.edu>
In-Reply-To: <20200504003852.1096018-2-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 4 May 2020 10:05:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqt2h+6EUoQ4qquX5zUJDKpg5MhXaGQcdVguNcOHrZ+A@mail.gmail.com>
Message-ID: <CAMj1kXHqt2h+6EUoQ4qquX5zUJDKpg5MhXaGQcdVguNcOHrZ+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: Fix mixed mode boot issue after macro refactor
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 4 May 2020 at 02:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
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
> Fix this by conditioning the generic macro definitions on
> CONFIG_EFI_MIXED, and removing the wrapper definitions on x86 if
> CONFIG_EFI_MIXED is not enabled.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks Arvind.

Currently, CONFIG_EFI_MIXED is never referenced outside of arch/x86,
and I prefer to keep it that way.

Also, I fail to see where the definition of efi_is_native() comes from
after applying this patch.



> ---
>  arch/x86/include/asm/efi.h             | 17 +++++++++++++----
>  drivers/firmware/efi/libstub/efistub.h | 14 ++++----------
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index cd0c3fbf6156..88f29f84a4d0 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -225,13 +225,13 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
>
>  /* arch specific definitions used by the stub code */
>
> -extern const bool efi_is64;
> +#ifdef CONFIG_EFI_MIXED
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
> @@ -356,6 +356,15 @@ static inline u32 efi64_convert_status(efi_status_t status)
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
> index 874233cf8820..37ca286a40c6 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -33,20 +33,14 @@ extern bool efi_novamap;
>
>  extern const efi_system_table_t *efi_system_table;
>
> -#ifndef efi_bs_call
> +#ifndef CONFIG_EFI_MIXED
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
