Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624481ABA50
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439549AbgDPHvq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 03:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439430AbgDPHvn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 03:51:43 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD2E21569;
        Thu, 16 Apr 2020 07:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023502;
        bh=Rhq0sXe0rapQY1I4b51ZXWHI+oTRXpSADqJAZ1zCJDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PHzPYlOaVusKITn6qyAoRQQkdFx6kW8qZfzbLk0ZHMG1WiWWVE73R5MoAES9aeiCU
         zuDi8WbleFKlLzeHTdGwWk/OoSXwbzD30WsdWyWspjHMgBbIu2xKDZ2o9wBmUqXlsL
         nOE8KqzXKNVRoPt2ItVX6EkO0m26ccYNBBA5CZZs=
Received: by mail-il1-f182.google.com with SMTP id u5so6033012ilb.5;
        Thu, 16 Apr 2020 00:51:42 -0700 (PDT)
X-Gm-Message-State: AGi0Pub8n4mSLLFRswhBTcBTBohQOA7i3YBH9YOmBlPV94tF7UeycY6I
        fUB9pq55MUh796sK8rxDrSFZ93I7WJYlPChgyPQ=
X-Google-Smtp-Source: APiQypKlHXExqQH/4hwdLFRRNK2M1tNb1TH7BKiSbrxgh5AJxC3pKBem/1iU8ycNKPWLjCHi/u/a08YKoKSHNQmisp0=
X-Received: by 2002:a92:5a4c:: with SMTP id o73mr8748153ilb.218.1587023502144;
 Thu, 16 Apr 2020 00:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200415221520.2692512-1-nivedita@alum.mit.edu> <20200415221520.2692512-4-nivedita@alum.mit.edu>
In-Reply-To: <20200415221520.2692512-4-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 09:51:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFMgrj8POtc0UQ6D-dbDKU+RmuHjUH-bAkMBAqjL_p+mg@mail.gmail.com>
Message-ID: <CAMj1kXFMgrj8POtc0UQ6D-dbDKU+RmuHjUH-bAkMBAqjL_p+mg@mail.gmail.com>
Subject: Re: [PATCH 3/5] efi/x86: Remove __efistub_global annotation
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

With the R_386_32/R_X86_64_64 check folded in:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
>  drivers/firmware/efi/libstub/Makefile  | 12 ++++++++++--
>  drivers/firmware/efi/libstub/efistub.h |  4 ----
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 508cfa6828c5..0dc5c2b9614b 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -52,6 +52,7 @@ SECTIONS
>                 _data = . ;
>                 *(.data)
>                 *(.data.*)
> +               *(.bss.efistub)
>                 _edata = . ;
>         }
>         . = ALIGN(L1_CACHE_BYTES);
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index e5e76677f2da..0bb2916eb12b 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -73,8 +73,8 @@ CFLAGS_arm64-stub.o           := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  # a verification pass to see if any absolute relocations exist in any of the
>  # object files.
>  #
> -extra-$(CONFIG_EFI_ARMSTUB)    := $(lib-y)
> -lib-$(CONFIG_EFI_ARMSTUB)      := $(patsubst %.o,%.stub.o,$(lib-y))
> +extra-y        := $(lib-y)
> +lib-y  := $(patsubst %.o,%.stub.o,$(lib-y))
>
>  STUBCOPY_FLAGS-$(CONFIG_ARM64) += --prefix-alloc-sections=.init \
>                                    --prefix-symbols=__efistub_
> @@ -89,6 +89,14 @@ STUBCOPY_FLAGS-$(CONFIG_ARM) += --rename-section .data=.data.efistub \
>                                    --rename-section .bss=.bss.efistub,load,alloc
>  STUBCOPY_RELOC-$(CONFIG_ARM)   := R_ARM_ABS
>
> +#
> +# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> +# .bss section, so the .bss section of the EFI stub needs to be included in the
> +# .data section of the compressed kernel to ensure initialization. Rename the
> +# .bss section here so it's easy to pick out in the linker script.
> +#
> +STUBCOPY_FLAGS-$(CONFIG_X86)   += --rename-section .bss=.bss.efistub,load,alloc
> +
>  $(obj)/%.stub.o: $(obj)/%.o FORCE
>         $(call if_changed,stubcopy)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index a92d42ffd9f7..49651e20bb9f 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,11 +25,7 @@
>  #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
>  #endif
>
> -#if defined(CONFIG_X86)
> -#define __efistub_global       __section(.data)
> -#else
>  #define __efistub_global
> -#endif
>
>  extern bool __pure nochunk(void);
>  extern bool __pure nokaslr(void);
> --
> 2.24.1
>
