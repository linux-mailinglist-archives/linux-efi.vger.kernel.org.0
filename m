Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC42331F7A
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 07:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhCIGnU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Mar 2021 01:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhCIGnN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Mar 2021 01:43:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A59B652A4;
        Tue,  9 Mar 2021 06:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615272192;
        bh=8aTJOb41W71/iAYGorZ+HicoBt7LRkfCHw2dKRKP5H8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PsLPWBfOWhe/SUGxap6rvsZXtVzh2EiQf7EnxMZZDhpQSHp8pryRMfdjo1ePU9uGy
         4csLHWUbFWNa4SbM9RJy5TLnV8zAXHZsDPq7VibDYGiOO9WeEKpZk43SZkX2Dzscbq
         J6XlTSnbzEzvxSjunZA94vLnZZFlPy05/xBtkormCNi3dRDH0kFD4xlFRXcMezlx5c
         nKVb2CCGGlOUKlwyPdAQXKlocouJZrF+4dIrw8QP+Smis35zhLbmdw1hhheRDkoh+l
         /zlsT1zEYpG/vD1wZu7C2rqmHTUh6fkkvnFdzvAV4HiOskAlhWePGPVxORbsCM6zwi
         oZfa4b9vwf92w==
Received: by mail-ot1-f54.google.com with SMTP id h22so11832640otr.6;
        Mon, 08 Mar 2021 22:43:12 -0800 (PST)
X-Gm-Message-State: AOAM5311Ad3G5pXMwx/SeL3TI2v1wrx17gfLProVSlDl6+LObIGBm7/O
        hlhaswIYSRlGzebt47VOiPWT+YsccUAiPfB4mgA=
X-Google-Smtp-Source: ABdhPJwwErlMGgTI6W9kWVTWXyRRpA2pqUCTwdh7w26x7CXw7TkH69DIf3SOIwcUVKSsFK4w6gv5mpplcLA5Tjexcsk=
X-Received: by 2002:a9d:7512:: with SMTP id r18mr23355920otk.90.1615272191490;
 Mon, 08 Mar 2021 22:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20210309000247.2989531-8-danielwa@cisco.com>
In-Reply-To: <20210309000247.2989531-8-danielwa@cisco.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Mar 2021 07:43:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF9k2J5eZdn6R6bn4ChRVyuGYHM7bOtycf1QKrakrua_g@mail.gmail.com>
Message-ID: <CAMj1kXF9k2J5eZdn6R6bn4ChRVyuGYHM7bOtycf1QKrakrua_g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] CMDLINE: x86: convert to generic builtin command line
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, xe-linux-external@cisco.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ruslan Ruslichenko <rruslich@cisco.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 9 Mar 2021 at 01:03, Daniel Walker <danielwa@cisco.com> wrote:
>
> This updates the x86 code to use the CONFIG_GENERIC_CMDLINE
> option.
>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Ruslan Ruslichenko <rruslich@cisco.com>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  arch/x86/Kconfig                        | 44 +------------------------
>  arch/x86/kernel/setup.c                 | 18 ++--------
>  drivers/firmware/efi/libstub/x86-stub.c |  2 +-
>  3 files changed, 4 insertions(+), 60 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..3950f9bf9855 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -115,6 +115,7 @@ config X86
>         select EDAC_SUPPORT
>         select GENERIC_CLOCKEVENTS_BROADCAST    if X86_64 || (X86_32 && X86_LOCAL_APIC)
>         select GENERIC_CLOCKEVENTS_MIN_ADJUST
> +       select GENERIC_CMDLINE
>         select GENERIC_CMOS_UPDATE
>         select GENERIC_CPU_AUTOPROBE
>         select GENERIC_CPU_VULNERABILITIES
> @@ -2368,49 +2369,6 @@ choice
>
>  endchoice
>
> -config CMDLINE_BOOL
> -       bool "Built-in kernel command line"
> -       help
> -         Allow for specifying boot arguments to the kernel at
> -         build time.  On some systems (e.g. embedded ones), it is
> -         necessary or convenient to provide some or all of the
> -         kernel boot arguments with the kernel itself (that is,
> -         to not rely on the boot loader to provide them.)
> -
> -         To compile command line arguments into the kernel,
> -         set this option to 'Y', then fill in the
> -         boot arguments in CONFIG_CMDLINE.
> -
> -         Systems with fully functional boot loaders (i.e. non-embedded)
> -         should leave this option set to 'N'.
> -
> -config CMDLINE
> -       string "Built-in kernel command string"
> -       depends on CMDLINE_BOOL
> -       default ""
> -       help
> -         Enter arguments here that should be compiled into the kernel
> -         image and used at boot time.  If the boot loader provides a
> -         command line at boot time, it is appended to this string to
> -         form the full kernel command line, when the system boots.
> -
> -         However, you can use the CONFIG_CMDLINE_OVERRIDE option to
> -         change this behavior.
> -
> -         In most cases, the command line (whether built-in or provided
> -         by the boot loader) should specify the device for the root
> -         file system.
> -
> -config CMDLINE_OVERRIDE
> -       bool "Built-in command line overrides boot loader arguments"
> -       depends on CMDLINE_BOOL && CMDLINE != ""
> -       help
> -         Set this option to 'Y' to have the kernel ignore the boot loader
> -         command line, and use ONLY the built-in command line.
> -
> -         This is used to work around broken boot loaders.  This should
> -         be set to 'N' under normal conditions.
> -
>  config MODIFY_LDT_SYSCALL
>         bool "Enable the LDT (local descriptor table)" if EXPERT
>         default y
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 740f3bdb3f61..e748c3e5c1ae 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -48,6 +48,7 @@
>  #include <asm/unwind.h>
>  #include <asm/vsyscall.h>
>  #include <linux/vmalloc.h>
> +#include <linux/cmdline.h>
>
>  /*
>   * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
> @@ -162,9 +163,6 @@ unsigned long saved_video_mode;
>  #define RAMDISK_LOAD_FLAG              0x4000
>
>  static char __initdata command_line[COMMAND_LINE_SIZE];
> -#ifdef CONFIG_CMDLINE_BOOL
> -static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
> -#endif
>
>  #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
>  struct edd edd;
> @@ -884,19 +882,7 @@ void __init setup_arch(char **cmdline_p)
>         bss_resource.start = __pa_symbol(__bss_start);
>         bss_resource.end = __pa_symbol(__bss_stop)-1;
>
> -#ifdef CONFIG_CMDLINE_BOOL
> -#ifdef CONFIG_CMDLINE_OVERRIDE
> -       strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> -#else
> -       if (builtin_cmdline[0]) {
> -               /* append boot loader cmdline to builtin */
> -               strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> -               strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> -               strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> -       }
> -#endif
> -#endif
> -
> +       cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
>         strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>         *cmdline_p = command_line;
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index f14c4ff5839f..9538c9d4a0bc 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -736,7 +736,7 @@ unsigned long efi_main(efi_handle_t handle,
>         }
>
>  #ifdef CONFIG_CMDLINE_BOOL

Does this CMDLINE_BOOL check need to be dropped as well?

> -       status = efi_parse_options(CONFIG_CMDLINE);
> +       status = efi_parse_options(CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND);
>         if (status != EFI_SUCCESS) {
>                 efi_err("Failed to parse options\n");
>                 goto fail;
> --
> 2.25.1
>
