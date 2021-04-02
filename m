Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28ED352E85
	for <lists+linux-efi@lfdr.de>; Fri,  2 Apr 2021 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhDBRhA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Apr 2021 13:37:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57595 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234361AbhDBRg7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 2 Apr 2021 13:36:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBnKy4WWlz9v3qS;
        Fri,  2 Apr 2021 19:36:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jNzMP97qRsnX; Fri,  2 Apr 2021 19:36:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBnKy36stz9v3qR;
        Fri,  2 Apr 2021 19:36:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95F468BB77;
        Fri,  2 Apr 2021 19:36:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AmiRaLq6LC2w; Fri,  2 Apr 2021 19:36:56 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D381B8BB6F;
        Fri,  2 Apr 2021 19:36:55 +0200 (CEST)
Subject: Re: [PATCH 6/8] drivers: firmware: efi: libstub: enable generic
 commandline
To:     Daniel Walker <danielwa@cisco.com>, Will Deacon <will@kernel.org>,
        ob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     xe-linux-external@cisco.com, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <41021d66db2ab427c14255d2a24bb4517c8b58fd.1617126961.git.danielwa@cisco.com>
 <e5d98d566c38d6f8516b8d9d1fd603ec1f131037.1617126961.git.danielwa@cisco.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <72fbd293-1d83-a558-4d7a-141576371864@csgroup.eu>
Date:   Fri, 2 Apr 2021 19:36:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <e5d98d566c38d6f8516b8d9d1fd603ec1f131037.1617126961.git.danielwa@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



Le 30/03/2021 à 19:57, Daniel Walker a écrit :
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
>   .../firmware/efi/libstub/efi-stub-helper.c    | 35 +++++++++++++++++++
>   drivers/firmware/efi/libstub/efi-stub.c       |  7 ++++
>   drivers/firmware/efi/libstub/efistub.h        |  1 +
>   drivers/firmware/efi/libstub/x86-stub.c       | 13 +++++--
>   4 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index aa8da0a49829..c155837cedc9 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -13,6 +13,7 @@
>   #include <linux/efi.h>
>   #include <linux/kernel.h>
>   #include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> +#include <linux/cmdline.h>
>   #include <asm/efi.h>
>   #include <asm/setup.h>
>   
> @@ -172,6 +173,40 @@ int efi_printk(const char *fmt, ...)
>   	return printed;
>   }
>   
> +/**
> + * efi_handle_cmdline() - handle adding in building parts of the command line
> + * @cmdline:	kernel command line
> + *
> + * Add in the generic parts of the commandline and start the parsing of the
> + * command line.
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_handle_cmdline(char const *cmdline)
> +{
> +	efi_status_t status;
> +
> +	status = efi_parse_options(CMDLINE_PREPEND);
> +	if (status != EFI_SUCCESS) {
> +		efi_err("Failed to parse options\n");
> +		return status;
> +	}
> +
> +	status = efi_parse_options(IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ? "" : cmdline);
> +	if (status != EFI_SUCCESS) {
> +		efi_err("Failed to parse options\n");
> +		return status;
> +	}
> +
> +	status = efi_parse_options(CMDLINE_APPEND);
> +	if (status != EFI_SUCCESS) {
> +		efi_err("Failed to parse options\n");
> +		return status;
> +	}
> +
> +	return EFI_SUCCESS;
> +}

I think we can refactor to first build the final command line, then call efi_parse_options() only 
once after that.

The big advantage of GENERIC_CMDLINE should be to not address anymore CONFIG_CMDLINE_XXX options at 
all outside of linux/cmdline.h

> +
>   /**
>    * efi_parse_options() - Parse EFI command line options
>    * @cmdline:	kernel command line
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 26e69788f27a..760480248adf 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -172,6 +172,12 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>   		goto fail;
>   	}
>   
> +#ifdef CONFIG_GENERIC_CMDLINE
> +	status = efi_handle_cmdline(cmdline_ptr);
> +	if (status != EFI_SUCCESS) {
> +		goto fail_free_cmdline;
> +	}
> +#else

Why an alternative ?

>   	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
>   	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
>   	    cmdline_size == 0) {
> @@ -189,6 +195,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>   			goto fail_free_cmdline;
>   		}
>   	}
> +#endif
>   
>   	efi_info("Booting Linux Kernel...\n");
>   
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index cde0a2ef507d..07c7f9fdfffc 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -800,6 +800,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
>   				 unsigned long alignment,
>   				 unsigned long min_addr);
>   
> +efi_status_t efi_handle_cmdline(char const *cmdline);
>   efi_status_t efi_parse_options(char const *cmdline);
>   
>   void efi_parse_option_graphics(char *option);
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index f14c4ff5839f..30ad8fb7122d 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -673,6 +673,8 @@ unsigned long efi_main(efi_handle_t handle,
>   	unsigned long bzimage_addr = (unsigned long)startup_32;
>   	unsigned long buffer_start, buffer_end;
>   	struct setup_header *hdr = &boot_params->hdr;
> +	unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> +				       ((u64)boot_params->ext_cmd_line_ptr << 32));
>   	efi_status_t status;
>   
>   	efi_system_table = sys_table_arg;
> @@ -735,6 +737,14 @@ unsigned long efi_main(efi_handle_t handle,
>   		image_offset = 0;
>   	}
>   
> +#ifdef CONFIG_GENERIC_CMDLINE
> +	status = efi_handle_cmdline((char *)cmdline_paddr);
> +	if (status != EFI_SUCCESS) {
> +		efi_err("Failed to parse options\n");
> +		goto fail;
> +	}
> +#else /* CONFIG_GENERIC_CMDLINE */
> +
>   #ifdef CONFIG_CMDLINE_BOOL
>   	status = efi_parse_options(CONFIG_CMDLINE);
>   	if (status != EFI_SUCCESS) {
> @@ -743,8 +753,6 @@ unsigned long efi_main(efi_handle_t handle,
>   	}
>   #endif
>   	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> -		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> -					       ((u64)boot_params->ext_cmd_line_ptr << 32));
>   		status = efi_parse_options((char *)cmdline_paddr);
>   		if (status != EFI_SUCCESS) {
>   			efi_err("Failed to parse options\n");
> @@ -752,6 +760,7 @@ unsigned long efi_main(efi_handle_t handle,
>   		}
>   	}
>   
> +#endif
>   	/*
>   	 * At this point, an initrd may already have been loaded by the
>   	 * bootloader and passed via bootparams. We permit an initrd loaded
> 
