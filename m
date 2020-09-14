Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB65268C52
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 15:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgINNhk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 09:37:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62184 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgINNfu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 09:35:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64E7D8EBF9;
        Mon, 14 Sep 2020 09:35:43 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=gSnim3mvAbAq2/22ImdJ8Ncy4z0=; b=IZ1WSt
        52EikCvmW8ze9ObkgKD8H2wkwg9Imjn+eo2ubahnXKQrQiSQVtZrNbB5Bzwq9CiT
        LxvjaDXoTI/MZGsKChDkSzRNMBVS7WXJ+E00M5jTLJlV6j1q8z4nxwlqWvaMp+y2
        upkDWzLbyP9Q7dcQNPum3FqLEtT6LUU5hYRuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B16E8EBF8;
        Mon, 14 Sep 2020 09:35:43 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=IZ7EAS46+FsvRZnCXtAQuyRWQoQ1eBtWYOICABO6/G0=; b=iDbjhYF/aFjpTPdEG7b+2tOkdk5DtNkej9A5QqqUMt/KG/l2EugX6eSaWBae+hl6Rd1PdCcrYo6P7MzuWA+PLJs5/SAcczlkJaNX3YYRkOiXAb6djg4Yxukc2h/BMjY5j6RIlRgPWctAA6SItxhRbZICx1B0TY1I+CnG3pdNMjA=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4C688EBF6;
        Mon, 14 Sep 2020 09:35:42 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id CF3E62DA0C6E;
        Mon, 14 Sep 2020 09:35:41 -0400 (EDT)
Date:   Mon, 14 Sep 2020 09:35:41 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 03/12] ARM: module: add support for place relative
 relocations
In-Reply-To: <20200914095706.3985-4-ardb@kernel.org>
Message-ID: <nycvar.YSQ.7.78.906.2009140927490.4095746@knanqh.ubzr>
References: <20200914095706.3985-1-ardb@kernel.org> <20200914095706.3985-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 2F9A3A70-F68F-11EA-89BB-01D9BED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 14 Sep 2020, Ard Biesheuvel wrote:

> When using the new adr_l/ldr_l/str_l macros to refer to external symbols
> from modules, the linker may emit place relative ELF relocations that
> need to be fixed up by the module loader. So add support for these.

Just wondering if that capability requirement should be added to the 
module signature somehow...?

Maybe not. The MODULE_ARCH_VERMAGIC definition only contains things that 
are configurable for a given build.


> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/include/asm/elf.h |  5 +++++
>  arch/arm/kernel/module.c   | 20 ++++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> index b078d992414b..0ac62a54b73c 100644
> --- a/arch/arm/include/asm/elf.h
> +++ b/arch/arm/include/asm/elf.h
> @@ -51,6 +51,7 @@ typedef struct user_fp elf_fpregset_t;
>  #define R_ARM_NONE		0
>  #define R_ARM_PC24		1
>  #define R_ARM_ABS32		2
> +#define R_ARM_REL32		3
>  #define R_ARM_CALL		28
>  #define R_ARM_JUMP24		29
>  #define R_ARM_TARGET1		38
> @@ -58,11 +59,15 @@ typedef struct user_fp elf_fpregset_t;
>  #define R_ARM_PREL31		42
>  #define R_ARM_MOVW_ABS_NC	43
>  #define R_ARM_MOVT_ABS		44
> +#define R_ARM_MOVW_PREL_NC	45
> +#define R_ARM_MOVT_PREL		46
>  
>  #define R_ARM_THM_CALL		10
>  #define R_ARM_THM_JUMP24	30
>  #define R_ARM_THM_MOVW_ABS_NC	47
>  #define R_ARM_THM_MOVT_ABS	48
> +#define R_ARM_THM_MOVW_PREL_NC	49
> +#define R_ARM_THM_MOVT_PREL	50
>  
>  /*
>   * These are used to set parameters in the core dumps.
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index e15444b25ca0..beac45e89ba6 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -185,14 +185,24 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  			*(u32 *)loc |= offset & 0x7fffffff;
>  			break;
>  
> +		case R_ARM_REL32:
> +			*(u32 *)loc += sym->st_value - loc;
> +			break;
> +
>  		case R_ARM_MOVW_ABS_NC:
>  		case R_ARM_MOVT_ABS:
> +		case R_ARM_MOVW_PREL_NC:
> +		case R_ARM_MOVT_PREL:
>  			offset = tmp = __mem_to_opcode_arm(*(u32 *)loc);
>  			offset = ((offset & 0xf0000) >> 4) | (offset & 0xfff);
>  			offset = (offset ^ 0x8000) - 0x8000;
>  
>  			offset += sym->st_value;
> -			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS)
> +			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_PREL ||
> +			    ELF32_R_TYPE(rel->r_info) == R_ARM_MOVW_PREL_NC)
> +				offset -= loc;
> +			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS ||
> +			    ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_PREL)
>  				offset >>= 16;
>  
>  			tmp &= 0xfff0f000;
> @@ -283,6 +293,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  
>  		case R_ARM_THM_MOVW_ABS_NC:
>  		case R_ARM_THM_MOVT_ABS:
> +		case R_ARM_THM_MOVW_PREL_NC:
> +		case R_ARM_THM_MOVT_PREL:
>  			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
>  			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
>  
> @@ -302,7 +314,11 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  			offset = (offset ^ 0x8000) - 0x8000;
>  			offset += sym->st_value;
>  
> -			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS)
> +			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_PREL ||
> +			    ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVW_PREL_NC)
> +				offset -= loc;
> +			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS ||
> +			    ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_PREL)
>  				offset >>= 16;
>  
>  			upper = (u16)((upper & 0xfbf0) |
> -- 
> 2.17.1
> 
> 
