Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00122350437
	for <lists+linux-efi@lfdr.de>; Wed, 31 Mar 2021 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhCaQKg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 Mar 2021 12:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233622AbhCaQKV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 31 Mar 2021 12:10:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 672BF61040;
        Wed, 31 Mar 2021 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617207020;
        bh=/1ZfUq/hSkP8vyLmN2wN3gF/K+0R8P1I95At/e2yk3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MPCLn42gcnWhwN/zKbA8+c1PbkFnwg8YwYyuVGUM+PRQBAaqJailiFH6ekOnlpoCz
         f/gDaJ8Qq+HQLeaUhLP/jmgd9+Ue0CK/lohnrM2laPXY7/BFGINxJLz9kDlyuXG7yD
         PsUQMmNfnEhkD9y74gOqg3x+FCJQ2b7NTHEPZot9bGc6QEmDWRxdrLXrpcgJyM+VH4
         g1MFlnNSURc2Wti4P0kBL/M42y5bIj4CjxCGtcNcC5UlVKT0zrbISi6OplZuuHrQPa
         D9Sv+PSbuf1rNFDLO0ndktG+dsTlTWzCLE1OksBrdBB+UAVvYv0atkgWJVXgOp5RB9
         zwZF7FS+jZj5A==
Received: by mail-oi1-f170.google.com with SMTP id c16so20518324oib.3;
        Wed, 31 Mar 2021 09:10:20 -0700 (PDT)
X-Gm-Message-State: AOAM530qi/nxP/zvCNGTjZcXgQL0xy7w8ykd+iViOR3OfL2RbqfLmxe5
        OwgsVxhrgA9nLzqnebqPF6NoywnoJVeXu0KkRaE=
X-Google-Smtp-Source: ABdhPJzyQnLqutk8wJtGUcalgJX2yCNn0BLIq/ju4C/c+FzWFIriO7+Ss7TW+wiuTsHll9sO+01CXGbsemmBHeRSmAk=
X-Received: by 2002:aca:1a01:: with SMTP id a1mr2775869oia.33.1617207019681;
 Wed, 31 Mar 2021 09:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <41021d66db2ab427c14255d2a24bb4517c8b58fd.1617126961.git.danielwa@cisco.com>
 <e5d98d566c38d6f8516b8d9d1fd603ec1f131037.1617126961.git.danielwa@cisco.com>
In-Reply-To: <e5d98d566c38d6f8516b8d9d1fd603ec1f131037.1617126961.git.danielwa@cisco.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 31 Mar 2021 18:10:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG_rRLU2Hp_GaZyayxx6J+HaWyPHPmE-hEZawuxzZ4JXw@mail.gmail.com>
Message-ID: <CAMj1kXG_rRLU2Hp_GaZyayxx6J+HaWyPHPmE-hEZawuxzZ4JXw@mail.gmail.com>
Subject: Re: [PATCH 6/8] drivers: firmware: efi: libstub: enable generic commandline
To:     Daniel Walker <danielwa@cisco.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        ob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, xe-linux-external@cisco.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Arvind)

On Tue, 30 Mar 2021 at 19:57, Daniel Walker <danielwa@cisco.com> wrote:
>
> This adds code to handle the generic command line changes.
> The efi code appears that it doesn't benefit as much from this design
> as it could.
>
> For example, if you had a prepend command line with "nokaslr" then
> you might be helpful to re-enable it in the boot loader or dts,
> but there appears to be no way to re-enable kaslr or some of the
> other options.
>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  .../firmware/efi/libstub/efi-stub-helper.c    | 35 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub.c       |  7 ++++
>  drivers/firmware/efi/libstub/efistub.h        |  1 +
>  drivers/firmware/efi/libstub/x86-stub.c       | 13 +++++--
>  4 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index aa8da0a49829..c155837cedc9 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -13,6 +13,7 @@
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
>  #include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> +#include <linux/cmdline.h>
>  #include <asm/efi.h>
>  #include <asm/setup.h>
>
> @@ -172,6 +173,40 @@ int efi_printk(const char *fmt, ...)
>         return printed;
>  }
>
> +/**
> + * efi_handle_cmdline() - handle adding in building parts of the command line
> + * @cmdline:   kernel command line
> + *
> + * Add in the generic parts of the commandline and start the parsing of the
> + * command line.
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_handle_cmdline(char const *cmdline)
> +{
> +       efi_status_t status;
> +
> +       status = efi_parse_options(CMDLINE_PREPEND);
> +       if (status != EFI_SUCCESS) {
> +               efi_err("Failed to parse options\n");
> +               return status;
> +       }

Even though I am not a fan of the 'success handling' pattern,
duplicating the exact same error handling three times is not great
either. Could we reuse more of the code here?

> +
> +       status = efi_parse_options(IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ? "" : cmdline);

What is the point of calling efi_parse_options() with an empty string?



> +       if (status != EFI_SUCCESS) {
> +               efi_err("Failed to parse options\n");
> +               return status;
> +       }
> +
> +       status = efi_parse_options(CMDLINE_APPEND);
> +       if (status != EFI_SUCCESS) {
> +               efi_err("Failed to parse options\n");
> +               return status;
> +       }
> +
> +       return EFI_SUCCESS;
> +}
> +
>  /**
>   * efi_parse_options() - Parse EFI command line options
>   * @cmdline:   kernel command line
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 26e69788f27a..760480248adf 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -172,6 +172,12 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>                 goto fail;
>         }
>
> +#ifdef CONFIG_GENERIC_CMDLINE
> +       status = efi_handle_cmdline(cmdline_ptr);
> +       if (status != EFI_SUCCESS) {
> +               goto fail_free_cmdline;
> +       }
> +#else
>         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
>             IS_ENABLED(CONFIG_CMDLINE_FORCE) ||

Does this mean CONFIG_GENERIC_CMDLINE does not replace CMDLINE_EXTEND
/ CMDLINE_FORCE etc, but introduces yet another variant on top of
those?

That does not seem like an improvement to me. I think it is great that
you are cleaning this up, but only if it means we can get rid of the
old implementation.

>             cmdline_size == 0) {
> @@ -189,6 +195,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>                         goto fail_free_cmdline;
>                 }
>         }
> +#endif
>
>         efi_info("Booting Linux Kernel...\n");
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index cde0a2ef507d..07c7f9fdfffc 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -800,6 +800,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
>                                  unsigned long alignment,
>                                  unsigned long min_addr);
>
> +efi_status_t efi_handle_cmdline(char const *cmdline);
>  efi_status_t efi_parse_options(char const *cmdline);
>
>  void efi_parse_option_graphics(char *option);
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index f14c4ff5839f..30ad8fb7122d 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -673,6 +673,8 @@ unsigned long efi_main(efi_handle_t handle,
>         unsigned long bzimage_addr = (unsigned long)startup_32;
>         unsigned long buffer_start, buffer_end;
>         struct setup_header *hdr = &boot_params->hdr;
> +       unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> +                                      ((u64)boot_params->ext_cmd_line_ptr << 32));
>         efi_status_t status;
>
>         efi_system_table = sys_table_arg;
> @@ -735,6 +737,14 @@ unsigned long efi_main(efi_handle_t handle,
>                 image_offset = 0;
>         }
>
> +#ifdef CONFIG_GENERIC_CMDLINE
> +       status = efi_handle_cmdline((char *)cmdline_paddr);
> +       if (status != EFI_SUCCESS) {
> +               efi_err("Failed to parse options\n");
> +               goto fail;
> +       }
> +#else /* CONFIG_GENERIC_CMDLINE */
> +
>  #ifdef CONFIG_CMDLINE_BOOL
>         status = efi_parse_options(CONFIG_CMDLINE);
>         if (status != EFI_SUCCESS) {
> @@ -743,8 +753,6 @@ unsigned long efi_main(efi_handle_t handle,
>         }
>  #endif
>         if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> -               unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> -                                              ((u64)boot_params->ext_cmd_line_ptr << 32));
>                 status = efi_parse_options((char *)cmdline_paddr);
>                 if (status != EFI_SUCCESS) {
>                         efi_err("Failed to parse options\n");
> @@ -752,6 +760,7 @@ unsigned long efi_main(efi_handle_t handle,
>                 }
>         }
>
> +#endif
>         /*
>          * At this point, an initrd may already have been loaded by the
>          * bootloader and passed via bootparams. We permit an initrd loaded
> --
> 2.25.1
>
