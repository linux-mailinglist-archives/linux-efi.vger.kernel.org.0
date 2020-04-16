Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09421ABA56
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439758AbgDPHwE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 03:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439799AbgDPHwD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 03:52:03 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0199E2076A;
        Thu, 16 Apr 2020 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023521;
        bh=NzufprrHci2GBeQE1qpA00pu7UAi24+J7DgAw5oPGZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oRSdIqNWm9ATCg8yqzgmrw8l8CYbf65jBu9uZKgq+iwZxJIcwTSulmjsHzpf8OUHL
         nyhyNAGv/MNGwIn5osMdBAXk5EkSuESUkiCS0DihTRypaMsvMSEBXbMB5q6R0voiaT
         jbRchVAXmycHMWvCrDmXbbZhmfXFzORo9QrvaRis=
Received: by mail-il1-f172.google.com with SMTP id f82so6003563ilh.8;
        Thu, 16 Apr 2020 00:52:00 -0700 (PDT)
X-Gm-Message-State: AGi0PubrifpXlDPtWhBHuCj/Cny1Iktc6Vr7SDFXYUQ0PxPwibsMdWVF
        1D4Jy4RTnrl5e9dg4khCt1JTBNMCme08fW5/n5s=
X-Google-Smtp-Source: APiQypL8wZ1+/gPrARSHoOw22uYvZMX8vTjJfW+r7Ld7iynuANQPH2+X6T4B9lPgKHbp8eTj+URL23FOS6APKKT7dXY=
X-Received: by 2002:a92:991c:: with SMTP id p28mr4998325ili.258.1587023520423;
 Thu, 16 Apr 2020 00:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200415221520.2692512-1-nivedita@alum.mit.edu> <20200415221520.2692512-5-nivedita@alum.mit.edu>
In-Reply-To: <20200415221520.2692512-5-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 09:51:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERKP2x6=wgdgyRtr5Rh-116bwwvVy4zgHAH=Hy9QsOew@mail.gmail.com>
Message-ID: <CAMj1kXERKP2x6=wgdgyRtr5Rh-116bwwvVy4zgHAH=Hy9QsOew@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi: Kill __efistub_global
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
> Now that both arm and x86 are using the linker script to place the EFI
> stub's global variables in the correct section, remove __efistub_global.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/libstub/arm-stub.c        |  4 ++--
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 15 +++++++--------
>  drivers/firmware/efi/libstub/efistub.h         |  2 --
>  drivers/firmware/efi/libstub/gop.c             |  2 +-
>  drivers/firmware/efi/libstub/x86-stub.c        |  2 +-
>  5 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index 99a5cde7c2d8..bf42d6c742a8 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -36,9 +36,9 @@
>  #endif
>
>  static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
> -static bool __efistub_global flat_va_mapping;
> +static bool flat_va_mapping;
>
> -static efi_system_table_t *__efistub_global sys_table;
> +static efi_system_table_t *sys_table;
>
>  __pure efi_system_table_t *efi_system_table(void)
>  {
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index c6092b6038cf..14e56a64f208 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -12,14 +12,13 @@
>
>  #include "efistub.h"
>
> -static bool __efistub_global efi_nochunk;
> -static bool __efistub_global efi_nokaslr;
> -static bool __efistub_global efi_noinitrd;
> -static bool __efistub_global efi_quiet;
> -static bool __efistub_global efi_novamap;
> -static bool __efistub_global efi_nosoftreserve;
> -static bool __efistub_global efi_disable_pci_dma =
> -                                       IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
> +static bool efi_nochunk;
> +static bool efi_nokaslr;
> +static bool efi_noinitrd;
> +static bool efi_quiet;
> +static bool efi_novamap;
> +static bool efi_nosoftreserve;
> +static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
>
>  bool __pure nochunk(void)
>  {
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 49651e20bb9f..f96c56596034 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,8 +25,6 @@
>  #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
>  #endif
>
> -#define __efistub_global
> -
>  extern bool __pure nochunk(void);
>  extern bool __pure nokaslr(void);
>  extern bool __pure noinitrd(void);
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index fa05a0b0adfd..216327d0b034 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -32,7 +32,7 @@ static struct {
>                         u8 depth;
>                 } res;
>         };
> -} cmdline __efistub_global = { .option = EFI_CMDLINE_NONE };
> +} cmdline = { .option = EFI_CMDLINE_NONE };
>
>  static bool parse_modenum(char *option, char **next)
>  {
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 7583e908852f..aedac3af4b5c 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -20,7 +20,7 @@
>  /* Maximum physical address for 64-bit kernel with 4-level paging */
>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
>
> -static efi_system_table_t *sys_table __efistub_global;
> +static efi_system_table_t *sys_table;
>  extern const bool efi_is64;
>  extern u32 image_offset;
>
> --
> 2.24.1
>
