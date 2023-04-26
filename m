Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331706EF80A
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 17:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbjDZP6x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjDZP6w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 11:58:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27C204495
        for <linux-efi@vger.kernel.org>; Wed, 26 Apr 2023 08:58:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15141FB;
        Wed, 26 Apr 2023 08:59:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 189353F587;
        Wed, 26 Apr 2023 08:58:49 -0700 (PDT)
Date:   Wed, 26 Apr 2023 16:58:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH 1/2] efi/zboot: arm64: Inject kernel code size symbol
 into the zboot payload
Message-ID: <ZElKHGu2Xd/mAvoo@FVFF77S0Q05N>
References: <20230426141103.2464423-1-ardb@kernel.org>
 <20230426141103.2464423-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426141103.2464423-2-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 26, 2023 at 04:11:02PM +0200, Ard Biesheuvel wrote:
> The EFI zboot code is not built as part of the kernel proper, like the
> ordinary EFI stub, but still needs access to symbols that are defined
> only internally in the kernel, and are left unexposed deliberately to
> avoid creating ABI inadvertently that we're stuck with later.
> 
> So capture the kernel code size of the kernel image, and inject it as an
> ELF symbol into the object that contains the compressed payload, where
> it will be accessible to zboot code that needs it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/boot/Makefile                    | 3 +++
>  arch/arm64/kernel/image-vars.h              | 4 ++++
>  drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
>  drivers/firmware/efi/libstub/zboot.lds      | 7 +++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index ae645fda90bca574..1761f5972443fc50 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -44,4 +44,7 @@ EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE	:= ARM64
>  EFI_ZBOOT_FORWARD_CFI	:= $(CONFIG_ARM64_BTI_KERNEL)
>  
> +EFI_ZBOOT_OBJCOPY_FLAGS	= --add-symbol zboot_code_size=0x$(shell \
> +				$(NM) vmlinux|grep _kernel_codesize|cut -d' ' -f1)
> +
>  include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 8309197c0ebd4a8e..35f3c79595137354 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -108,4 +108,8 @@ KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
>  
>  #endif /* CONFIG_KVM */
>  
> +#ifdef CONFIG_EFI_ZBOOT
> +_kernel_codesize = ABSOLUTE(__inittext_end - _text);
> +#endif
> +
>  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> index 0a9dcc2b13736519..1b101d9076fd49e5 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -40,7 +40,7 @@ quiet_cmd_compwithsize = $(quiet_cmd_$(zboot-method-y))
>  $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,compwithsize)
>  
> -OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
> +OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
>  			  --rename-section .data=.gzdata,load,alloc,readonly,contents
>  $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
>  	$(call if_changed,objcopy)
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index 93d33f68333b2b68..ac8c0ef851581f5d 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -2,6 +2,8 @@
>  
>  ENTRY(__efistub_efi_zboot_header);
>  
> +PROVIDE(zboot_code_size = ABSOLUTE(0));
> +
>  SECTIONS
>  {
>  	.head : ALIGN(4096) {
> @@ -17,6 +19,11 @@ SECTIONS
>  		*(.gzdata)
>  		__efistub__gzdata_end = .;
>  		*(.rodata* .init.rodata* .srodata*)
> +
> +		. = ALIGN(4);
> +		__efistub_code_size = .;
> +		LONG(zboot_code_size);
> +
>  		_etext = ALIGN(4096);
>  		. = _etext;
>  	}
> -- 
> 2.39.2
> 
