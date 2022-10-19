Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05C603A8E
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJSHX4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSHX4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:23:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49AE7696D;
        Wed, 19 Oct 2022 00:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52855B82266;
        Wed, 19 Oct 2022 07:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C65C43143;
        Wed, 19 Oct 2022 07:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666164232;
        bh=hgqD0beQq9QjxZviSw17NMTnIJpChFspfu4pFk2kPPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tcaZoFIWN9nmZNMjYn6mEaoTLGrfETJ1uzmjvghLJr51+100QDRL8mMcMdJRxqO0A
         1qWxY9m+8xP2jt+WiJzBAarXvOs1qMZUDrBpoB1isK4R9Zzbd8IBlRV7w5PGw2Y3/C
         EWJueFTHApdagsf8+W0tBVcon9E0g9NDMMH1ZelnzA1QXgLkktjQTE+fdenA4OQU1h
         HEgbMpceM1//6VjznEF8GH6uHc7ycIQmfARtRL0Z0C11s29VtSV7oUb2coOkpjq27M
         5jxFwQywkjnNeOukwht+lrpiR+LCDJF3GSVtdJmX2KviDeCM13LIczv4FpcUv8E56w
         EKB0v+TKAJ4uQ==
Received: by mail-lf1-f47.google.com with SMTP id p8so452979lfu.11;
        Wed, 19 Oct 2022 00:23:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf0p89H0GFEYFuqBWx4HLV7COJlq3hTA9VggYmTTv+NIuZPv1Cc/
        E+X3O8Ofv+aq62aeJuRnAC4/h+XouOqEo+ENObI=
X-Google-Smtp-Source: AMsMyM54ycTgfCf3Q+bBoCy0i1Xk2xAGjIG65QprA86hcchuWgW+RBmbbQ1VEcswrsGrBkdgHdEYN3pyBDgjihvvPDY=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr2469550lfb.637.1666164229901; Wed, 19
 Oct 2022 00:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <7a4b8d6827503ae0e30745014504c72f0c5d6316.1662459668.git.baskov@ispras.ru>
In-Reply-To: <7a4b8d6827503ae0e30745014504c72f0c5d6316.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:23:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE5g7=CuHvEj0Z4F9Y91W-5K0OzorC_Z1-JL-vvc9kksQ@mail.gmail.com>
Message-ID: <CAMj1kXE5g7=CuHvEj0Z4F9Y91W-5K0OzorC_Z1-JL-vvc9kksQ@mail.gmail.com>
Subject: Re: [PATCH 10/16] x86/boot: Make console interface more abstract
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
> To be able to extract kernel from EFI, console output functions
> need to be replaceable by alternative implementations.
>
> Make all of those functions pointers.
> Move serial console code to separate file.
>

What does kernel_add_identity_map() have to do with the above? Should
that be a separate patch?

> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/Makefile       |   2 +-
>  arch/x86/boot/compressed/ident_map_64.c |  15 ++-
>  arch/x86/boot/compressed/misc.c         | 109 +--------------------
>  arch/x86/boot/compressed/misc.h         |  13 ++-
>  arch/x86/boot/compressed/putstr.c       | 124 ++++++++++++++++++++++++
>  5 files changed, 146 insertions(+), 117 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/putstr.c
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 35ce1a64068b..29411864bfcd 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -92,7 +92,7 @@ $(obj)/misc.o: $(obj)/../voffset.h
>
>  vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o \
>         $(obj)/misc.o $(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
> -       $(obj)/piggy.o $(obj)/cpuflags.o
> +       $(obj)/piggy.o $(obj)/cpuflags.o $(obj)/putstr.o
>
>  vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
>  vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index c20cd31e665f..c39373687e50 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -89,12 +89,20 @@ phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>  static struct x86_mapping_info mapping_info;
>  int has_nx;
>
> +/*
> + * This points to actual implementation of mapping function.
> + * Either the one down below or the UEFI API wrapper.
> + */
> +unsigned long (*kernel_add_identity_map)(unsigned long start,
> +                                        unsigned long end,
> +                                        unsigned int flags);
> +
>  /*
>   * Adds the specified range to the identity mappings.
>   */
> -unsigned long kernel_add_identity_map(unsigned long start,
> -                                     unsigned long end,
> -                                     unsigned int flags)
> +unsigned long kernel_add_identity_map_(unsigned long start,
> +                                      unsigned long end,
> +                                      unsigned int flags)
>  {
>         int ret;
>
> @@ -136,6 +144,7 @@ void initialize_identity_maps(void *rmode)
>         struct setup_data *sd;
>
>         boot_params = rmode;
> +       kernel_add_identity_map = kernel_add_identity_map_;
>
>         /* Exclude the encryption mask from __PHYSICAL_MASK */
>         physical_mask &= ~sme_me_mask;
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index d377e434c4e3..e2c0d05ac293 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -53,13 +53,6 @@ struct port_io_ops pio_ops;
>  memptr free_mem_ptr;
>  memptr free_mem_end_ptr;
>
> -static char *vidmem;
> -static int vidport;
> -
> -/* These might be accessed before .bss is cleared, so use .data instead. */
> -static int lines __section(".data");
> -static int cols __section(".data");
> -
>  #ifdef CONFIG_KERNEL_GZIP
>  #include "../../../../lib/decompress_inflate.c"
>  #endif
> @@ -92,95 +85,6 @@ static int cols __section(".data");
>   * ../header.S.
>   */
>
> -static void scroll(void)
> -{
> -       int i;
> -
> -       memmove(vidmem, vidmem + cols * 2, (lines - 1) * cols * 2);
> -       for (i = (lines - 1) * cols * 2; i < lines * cols * 2; i += 2)
> -               vidmem[i] = ' ';
> -}
> -
> -#define XMTRDY          0x20
> -
> -#define TXR             0       /*  Transmit register (WRITE) */
> -#define LSR             5       /*  Line Status               */
> -static void serial_putchar(int ch)
> -{
> -       unsigned timeout = 0xffff;
> -
> -       while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
> -               cpu_relax();
> -
> -       outb(ch, early_serial_base + TXR);
> -}
> -
> -void __putstr(const char *s)
> -{
> -       int x, y, pos;
> -       char c;
> -
> -       if (early_serial_base) {
> -               const char *str = s;
> -               while (*str) {
> -                       if (*str == '\n')
> -                               serial_putchar('\r');
> -                       serial_putchar(*str++);
> -               }
> -       }
> -
> -       if (lines == 0 || cols == 0)
> -               return;
> -
> -       x = boot_params->screen_info.orig_x;
> -       y = boot_params->screen_info.orig_y;
> -
> -       while ((c = *s++) != '\0') {
> -               if (c == '\n') {
> -                       x = 0;
> -                       if (++y >= lines) {
> -                               scroll();
> -                               y--;
> -                       }
> -               } else {
> -                       vidmem[(x + cols * y) * 2] = c;
> -                       if (++x >= cols) {
> -                               x = 0;
> -                               if (++y >= lines) {
> -                                       scroll();
> -                                       y--;
> -                               }
> -                       }
> -               }
> -       }
> -
> -       boot_params->screen_info.orig_x = x;
> -       boot_params->screen_info.orig_y = y;
> -
> -       pos = (x + cols * y) * 2;       /* Update cursor position */
> -       outb(14, vidport);
> -       outb(0xff & (pos >> 9), vidport+1);
> -       outb(15, vidport);
> -       outb(0xff & (pos >> 1), vidport+1);
> -}
> -
> -void __puthex(unsigned long value)
> -{
> -       char alpha[2] = "0";
> -       int bits;
> -
> -       for (bits = sizeof(value) * 8 - 4; bits >= 0; bits -= 4) {
> -               unsigned long digit = (value >> bits) & 0xf;
> -
> -               if (digit < 0xA)
> -                       alpha[0] = '0' + digit;
> -               else
> -                       alpha[0] = 'a' + (digit - 0xA);
> -
> -               __putstr(alpha);
> -       }
> -}
> -
>  #ifdef CONFIG_X86_NEED_RELOCS
>  static void handle_relocations(void *output, unsigned long output_len,
>                                unsigned long virt_addr)
> @@ -407,17 +311,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>
>         sanitize_boot_params(boot_params);
>
> -       if (boot_params->screen_info.orig_video_mode == 7) {
> -               vidmem = (char *) 0xb0000;
> -               vidport = 0x3b4;
> -       } else {
> -               vidmem = (char *) 0xb8000;
> -               vidport = 0x3d4;
> -       }
> -
> -       lines = boot_params->screen_info.orig_video_lines;
> -       cols = boot_params->screen_info.orig_video_cols;
> -
>         init_default_io_ops();
>
>         /*
> @@ -428,7 +321,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>          */
>         early_tdx_detect();
>
> -       console_init();
> +       init_bare_console();
>
>         /*
>          * Save RSDP address for later use. Have this after console_init()
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a4f99516f310..39dc3de50268 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -53,8 +53,8 @@ extern memptr free_mem_end_ptr;
>  void *malloc(int size);
>  void free(void *where);
>  extern struct boot_params *boot_params;
> -void __putstr(const char *s);
> -void __puthex(unsigned long value);
> +extern void (*__putstr)(const char *s);
> +extern void (*__puthex)(unsigned long value);
>  #define error_putstr(__x)  __putstr(__x)
>  #define error_puthex(__x)  __puthex(__x)
>
> @@ -124,6 +124,9 @@ static inline void console_init(void)
>  { }
>  #endif
>
> +/* putstr.c */
> +void init_bare_console(void);
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  void sev_enable(struct boot_params *bp);
>  void sev_es_shutdown_ghcb(void);
> @@ -172,9 +175,9 @@ static inline int count_immovable_mem_regions(void) { return 0; }
>  extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
>  #endif
>  #ifdef CONFIG_X86_64
> -extern unsigned long kernel_add_identity_map(unsigned long start,
> -                                            unsigned long end,
> -                                            unsigned int flags);
> +extern unsigned long (*kernel_add_identity_map)(unsigned long start,
> +                                               unsigned long end,
> +                                               unsigned int flags);
>  #else
>  static inline unsigned long kernel_add_identity_map(unsigned long start,
>                                                     unsigned long end,
> diff --git a/arch/x86/boot/compressed/putstr.c b/arch/x86/boot/compressed/putstr.c
> new file mode 100644
> index 000000000000..accba0de8be9
> --- /dev/null
> +++ b/arch/x86/boot/compressed/putstr.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "misc.h"
> +
> +/* These might be accessed before .bss is cleared, so use .data instead. */
> +static char *vidmem __section(".data");
> +static int vidport __section(".data");
> +static int lines __section(".data");
> +static int cols __section(".data");
> +
> +void (*__putstr)(const char *s);
> +void (*__puthex)(unsigned long value);
> +
> +static void putstr(const char *s);
> +static void puthex(unsigned long value);
> +
> +void init_bare_console(void)
> +{
> +       __putstr = putstr;
> +       __puthex = puthex;
> +
> +       if (boot_params->screen_info.orig_video_mode == 7) {
> +               vidmem = (char *) 0xb0000;
> +               vidport = 0x3b4;
> +       } else {
> +               vidmem = (char *) 0xb8000;
> +               vidport = 0x3d4;
> +       }
> +
> +       lines = boot_params->screen_info.orig_video_lines;
> +       cols = boot_params->screen_info.orig_video_cols;
> +
> +       console_init();
> +}
> +
> +static void scroll(void)
> +{
> +       int i;
> +
> +       memmove(vidmem, vidmem + cols * 2, (lines - 1) * cols * 2);
> +       for (i = (lines - 1) * cols * 2; i < lines * cols * 2; i += 2)
> +               vidmem[i] = ' ';
> +}
> +
> +#define XMTRDY          0x20
> +
> +#define TXR             0       /*  Transmit register (WRITE) */
> +#define LSR             5       /*  Line Status               */
> +
> +static void serial_putchar(int ch)
> +{
> +       unsigned int timeout = 0xffff;
> +
> +       while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
> +               cpu_relax();
> +
> +       outb(ch, early_serial_base + TXR);
> +}
> +
> +static void putstr(const char *s)
> +{
> +       int x, y, pos;
> +       char c;
> +
> +       if (early_serial_base) {
> +               const char *str = s;
> +
> +               while (*str) {
> +                       if (*str == '\n')
> +                               serial_putchar('\r');
> +                       serial_putchar(*str++);
> +               }
> +       }
> +
> +       if (lines == 0 || cols == 0)
> +               return;
> +
> +       x = boot_params->screen_info.orig_x;
> +       y = boot_params->screen_info.orig_y;
> +
> +       while ((c = *s++) != '\0') {
> +               if (c == '\n') {
> +                       x = 0;
> +                       if (++y >= lines) {
> +                               scroll();
> +                               y--;
> +                       }
> +               } else {
> +                       vidmem[(x + cols * y) * 2] = c;
> +                       if (++x >= cols) {
> +                               x = 0;
> +                               if (++y >= lines) {
> +                                       scroll();
> +                                       y--;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       boot_params->screen_info.orig_x = x;
> +       boot_params->screen_info.orig_y = y;
> +
> +       pos = (x + cols * y) * 2;       /* Update cursor position */
> +       outb(14, vidport);
> +       outb(0xff & (pos >> 9), vidport+1);
> +       outb(15, vidport);
> +       outb(0xff & (pos >> 1), vidport+1);
> +}
> +
> +static void puthex(unsigned long value)
> +{
> +       char alpha[2] = "0";
> +       int bits;
> +
> +       for (bits = sizeof(value) * 8 - 4; bits >= 0; bits -= 4) {
> +               unsigned long digit = (value >> bits) & 0xf;
> +
> +               if (digit < 0xA)
> +                       alpha[0] = '0' + digit;
> +               else
> +                       alpha[0] = 'a' + (digit - 0xA);
> +
> +               putstr(alpha);
> +       }
> +}
> --
> 2.35.1
>
