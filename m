Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA247603AA1
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJSH1y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSH1x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C378234;
        Wed, 19 Oct 2022 00:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C076178F;
        Wed, 19 Oct 2022 07:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22947C43144;
        Wed, 19 Oct 2022 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666164471;
        bh=pGPI1VonJk44Iy0khkI0QWgWbFngP2/rYrSQDZouHMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MR6h4QEvzaJwW0kqjEKjavjVzDswWIzcYEixctncuY5rxHNKkh4iIeTFGDobKK8Zp
         qkcBxUumVaG5+XkMSkbgl4hyPX6IbaPP0BTK7kZ+THgDlEQ9+864fphh1pRcR2n9CQ
         Fyp/hpvQvjy4pRGLZbAAkxwSWfBqlVOmx9v5gySFS4/KVMVvt6dkpEn/bze4viCkUb
         /50p/2KFeujBwUJj0qfm0mNYa4YmBJeha89xfcsE1mPMemVPTe8lF842SSRTcIo5/7
         /Tag73V0Sz4GFY4FDhWI2wgxwa/P647zGHIbO1YWGwrZw3Q4qqbldtb4K1hJy5BJKU
         5iQ3BO5w4OrLg==
Received: by mail-lj1-f180.google.com with SMTP id i17so20047948lja.3;
        Wed, 19 Oct 2022 00:27:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Cbfu/fjW/R3JoulNua2CZl1VhEaPOZbmXNPnz/M+FWhraWlFn
        OndzXlztVioiY4Cb4w9soUpDuoVXbwK/HxF3HOg=
X-Google-Smtp-Source: AMsMyM5KqMZZalLdv8eWflzr5XlT3SelnofHVaCYNtXESG1d/cKpOmBMnXbiBf0tPM9FNdOjNpJFploGY9RLgaF22lg=
X-Received: by 2002:a05:651c:4d0:b0:26f:cd9b:419f with SMTP id
 e16-20020a05651c04d000b0026fcd9b419fmr2262920lji.415.1666164469004; Wed, 19
 Oct 2022 00:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <8e9f2d7b0645e17efaa9eec0423f6d2c4a55fc16.1662459668.git.baskov@ispras.ru>
In-Reply-To: <8e9f2d7b0645e17efaa9eec0423f6d2c4a55fc16.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:27:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFNhayBgXSaHxKpdnWbmQsoG5WpT9U6FhOXqJ0dsHHp4w@mail.gmail.com>
Message-ID: <CAMj1kXFNhayBgXSaHxKpdnWbmQsoG5WpT9U6FhOXqJ0dsHHp4w@mail.gmail.com>
Subject: Re: [PATCH 12/16] x86/boot: Add EFI kernel extraction interface
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> To enable extraction of kernel image from EFI stub code directly
> extraction code needs to have separate interface that avoid part
> of low level initialization logic, i.e. serial port setup.
>
> Add kernel extraction function callable from libstub as a part
> of preparation for extracting the kernel directly from EFI environment.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/head_32.S |  3 +-
>  arch/x86/boot/compressed/head_64.S |  2 +-
>  arch/x86/boot/compressed/misc.c    | 85 +++++++++++++++++++++---------
>  arch/x86/boot/compressed/misc.h    |  2 +
>  arch/x86/boot/compressed/putstr.c  |  9 ++++
>  5 files changed, 73 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 3b354eb9516d..b46a1c4109cf 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -217,8 +217,7 @@ SYM_DATA(image_offset, .long 0)
>   */
>         .bss
>         .balign 4
> -boot_heap:
> -       .fill BOOT_HEAP_SIZE, 1, 0
> +SYM_DATA(boot_heap,    .fill BOOT_HEAP_SIZE, 1, 0)
>  boot_stack:
>         .fill BOOT_STACK_SIZE, 1, 0
>  boot_stack_end:
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 889ca7176aa7..37ce094571b5 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -1007,7 +1007,7 @@ SYM_FUNC_END(startup32_check_sev_cbit)
>   */
>         .bss
>         .balign 4
> -SYM_DATA_LOCAL(boot_heap,      .fill BOOT_HEAP_SIZE, 1, 0)
> +SYM_DATA(boot_heap,    .fill BOOT_HEAP_SIZE, 1, 0)
>
>  SYM_DATA_START_LOCAL(boot_stack)
>         .fill BOOT_STACK_SIZE, 1, 0
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index e2c0d05ac293..8016cc5c300e 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -293,11 +293,11 @@ static void parse_elf(void *output, unsigned long output_len,
>   *             |-------uncompressed kernel image---------|
>   *
>   */
> -asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> -                                 unsigned char *input_data,
> -                                 unsigned long input_len,
> -                                 unsigned char *output,
> -                                 unsigned long output_len)
> +static void *do_extract_kernel(void *rmode,
> +                              unsigned char *input_data,
> +                              unsigned long input_len,
> +                              unsigned char *output,
> +                              unsigned long output_len)
>  {
>         const unsigned long kernel_total_size = VO__end - VO__text;
>         unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
> @@ -311,18 +311,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>
>         sanitize_boot_params(boot_params);
>
> -       init_default_io_ops();
> -
> -       /*
> -        * Detect TDX guest environment.
> -        *
> -        * It has to be done before console_init() in order to use
> -        * paravirtualized port I/O operations if needed.
> -        */
> -       early_tdx_detect();
> -
> -       init_bare_console();
> -
>         /*
>          * Save RSDP address for later use. Have this after console_init()
>          * so that early debugging output from the RSDP parsing code can be
> @@ -330,11 +318,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>          */
>         boot_params->acpi_rsdp_addr = get_rsdp_addr();
>
> -       debug_putstr("early console in extract_kernel\n");
> -
> -       free_mem_ptr     = heap;        /* Heap */
> -       free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
> -
>         /*
>          * The memory hole needed for the kernel is the larger of either
>          * the entire decompressed kernel plus relocation table, or the
> @@ -387,12 +370,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>         if (virt_addr & (MIN_KERNEL_ALIGN - 1))
>                 error("Destination virtual address inappropriately aligned");
>  #ifdef CONFIG_X86_64
> -       if (heap > 0x3fffffffffffUL)
> +       if (phys_addr > 0x3fffffffffffUL)
>                 error("Destination address too large");
>         if (virt_addr + max(output_len, kernel_total_size) > KERNEL_IMAGE_SIZE)
>                 error("Destination virtual address is beyond the kernel mapping area");
>  #else
> -       if (heap > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
> +       if (phys_addr > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
>                 error("Destination address too large");
>  #endif
>  #ifndef CONFIG_RELOCATABLE
> @@ -406,12 +389,64 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>         parse_elf(output, output_len, virt_addr);
>         debug_putstr("done.\nBooting the kernel.\n");
>
> +       return output;
> +}
> +
> +asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> +                                 unsigned char *input_data,
> +                                 unsigned long input_len,
> +                                 unsigned char *output,
> +                                 unsigned long output_len)
> +{
> +       void *entry;
> +
> +       init_default_io_ops();
> +
> +       /*
> +        * Detect TDX guest environment.
> +        *
> +        * It has to be done before console_init() in order to use
> +        * paravirtualized port I/O operations if needed.
> +        */
> +       early_tdx_detect();
> +
> +       init_bare_console();
> +
> +       debug_putstr("early console in extract_kernel\n");
> +
> +       free_mem_ptr     = heap;        /* Heap */
> +       free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
> +
> +       entry = do_extract_kernel(rmode, input_data,
> +                                 input_len, output, output_len);
> +
>         /* Disable exception handling before booting the kernel */
>         cleanup_exception_handling();
>
> -       return output;
> +       return entry;
>  }
>
> +void *efi_extract_kernel(struct boot_params *rmode,
> +                        struct efi_iofunc *iofunc,
> +                        unsigned char *input_data,
> +                        unsigned long input_len,
> +                        unsigned char *output,
> +                        unsigned long output_len)
> +{
> +       extern char boot_heap[BOOT_HEAP_SIZE];
> +
> +       free_mem_ptr     = (unsigned long)boot_heap;    /* Heap */
> +       free_mem_end_ptr = (unsigned long)boot_heap + BOOT_HEAP_SIZE;
> +
> +       init_efi_console(iofunc);
> +
> +       return do_extract_kernel(rmode, input_data,
> +                                input_len, output, output_len);
> +}
> +
> +
> +
> +
>  void fortify_panic(const char *name)
>  {
>         error("detected buffer overflow");
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 39dc3de50268..b5aa0af6c59e 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -26,6 +26,7 @@
>  #include <asm/boot.h>
>  #include <asm/bootparam.h>
>  #include <asm/desc_defs.h>
> +#include <asm/shared/extract.h>
>
>  #include "tdx.h"
>
> @@ -126,6 +127,7 @@ static inline void console_init(void)
>
>  /* putstr.c */
>  void init_bare_console(void);
> +void init_efi_console(struct efi_iofunc *iofunc);
>
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  void sev_enable(struct boot_params *bp);
> diff --git a/arch/x86/boot/compressed/putstr.c b/arch/x86/boot/compressed/putstr.c
> index accba0de8be9..238d9677df61 100644
> --- a/arch/x86/boot/compressed/putstr.c
> +++ b/arch/x86/boot/compressed/putstr.c
> @@ -32,6 +32,15 @@ void init_bare_console(void)
>         console_init();
>  }
>
> +void init_efi_console(struct efi_iofunc *iofunc)

struct efi_iofunc does not exist yet

> +{
> +       __putstr = iofunc->putstr;
> +       __puthex = iofunc->puthex;
> +#ifdef CONFIG_X86_64
> +       kernel_add_identity_map = iofunc->map_range;
> +#endif
> +}
> +
>  static void scroll(void)
>  {
>         int i;
> --
> 2.35.1
>
