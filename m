Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684111ABA47
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 09:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439648AbgDPHuw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 03:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439438AbgDPHut (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 03:50:49 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134A52076A;
        Thu, 16 Apr 2020 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023449;
        bh=OFHqz9GYYZNwc+I9swBEm5dzUhRk5QACD1V1CxcDFlo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZcD59NIBi3fSTJa9R3dm9SUE41lbsKpYBdDP7DYKp2lCFhz+WVORehUZFIWPY6cj
         0vgcsAVA8xIEXgiwx8uUO3ae0nXXWMHi0nDPOF8S5JPQCg391UW8ZSfOp4iYiysmLv
         Xl/X7Mvexhs6KXq+jLXS8bmun/3zNDOV3gU6qZec=
Received: by mail-il1-f177.google.com with SMTP id e4so6031637ils.4;
        Thu, 16 Apr 2020 00:50:49 -0700 (PDT)
X-Gm-Message-State: AGi0PuZzqNK4DwGc65TDZeUaD8FldjrbRkB0xvDH0lS/QEleM/koTiyL
        cIOiFGHBL+4NKfMUFLL83jfZJ0nlcVQUH3vVzSo=
X-Google-Smtp-Source: APiQypI5ojUj0Vjwe5ylB1JFpUhtyPIygOqNmKrjZ41jxKYyJbInoum3YZtcRuho0AfeBevcdVTm443eRLyhFE/uFFQ=
X-Received: by 2002:a92:aa0f:: with SMTP id j15mr9438871ili.211.1587023448452;
 Thu, 16 Apr 2020 00:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200415221520.2692512-1-nivedita@alum.mit.edu> <20200415221520.2692512-2-nivedita@alum.mit.edu>
In-Reply-To: <20200415221520.2692512-2-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 09:50:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE7aNm5XWrB2PkEedXA02gGmpcPW7rjziAXeTSPL_786A@mail.gmail.com>
Message-ID: <CAMj1kXE7aNm5XWrB2PkEedXA02gGmpcPW7rjziAXeTSPL_786A@mail.gmail.com>
Subject: Re: [PATCH 1/5] efi/arm: Remove __efistub_global annotation
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 16 Apr 2020 at 00:15, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Instead of using __efistub_global to force variables into the .data
> section, leave them in the .bss but pull the EFI stub's .bss section
> into .data in the linker script for the compressed kernel.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/boot/compressed/vmlinux.lds.S | 2 +-
>  drivers/firmware/efi/libstub/Makefile  | 7 ++++---
>  drivers/firmware/efi/libstub/efistub.h | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index b247f399de71..b6793c7932a9 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -78,7 +78,7 @@ SECTIONS
>       * The EFI stub always executes from RAM, and runs strictly before the
>       * decompressor, so we can make an exception for its r/w data, and keep it
>       */
> -    *(.data.efistub)
> +    *(.data.efistub .bss.efistub)
>      __pecoff_data_end = .;
>
>      /*
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 094eabdecfe6..45ffe0822df1 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -100,8 +100,9 @@ quiet_cmd_stubcopy = STUBCPY $@
>
>  #
>  # ARM discards the .data section because it disallows r/w data in the
> -# decompressor. So move our .data to .data.efistub, which is preserved
> -# explicitly by the decompressor linker script.
> +# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
> +# which are preserved explicitly by the decompressor linker script.
>  #
> -STUBCOPY_FLAGS-$(CONFIG_ARM)   += --rename-section .data=.data.efistub
> +STUBCOPY_FLAGS-$(CONFIG_ARM)   += --rename-section .data=.data.efistub \
> +                                  --rename-section .bss=.bss.efistub,load,alloc
>  STUBCOPY_RELOC-$(CONFIG_ARM)   := R_ARM_ABS
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index bd0b86b63936..a92d42ffd9f7 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,7 +25,7 @@
>  #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
>  #endif
>
> -#if defined(CONFIG_ARM) || defined(CONFIG_X86)
> +#if defined(CONFIG_X86)
>  #define __efistub_global       __section(.data)
>  #else
>  #define __efistub_global
> --
> 2.24.1
>
