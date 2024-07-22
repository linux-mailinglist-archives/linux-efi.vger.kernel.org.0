Return-Path: <linux-efi+bounces-1473-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2905938790
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jul 2024 04:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20EC2B20D06
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jul 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB76DF53;
	Mon, 22 Jul 2024 02:53:24 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77A4437;
	Mon, 22 Jul 2024 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721616804; cv=none; b=i86KnXl7WHYodfmTfk8gA3Xnyt+nvvEdBZavdyNTzjFonDc7kxP9p2EvyMgyQWAJMrrO2JnBNRSKXjE+X0SHoLj4cjwLAHR/VYoKM23WVzSSUtP8e6kOR+s1UiJlK1bSlOBNgfDTRUbt2U20ivBEGsdQLiKxe7T6fE2+aiVIGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721616804; c=relaxed/simple;
	bh=1eaSnjG8AdSQMMFrz0WaAj7CyvTggSoz+o1UQ0LfDE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FLTV233RkJ0s9w9LTyT5iOCoSvh/lZwm0t4AG0mo/Klt8qBnG9OMUBlQILvB+RGI0DvgEJcLjWm8rxaUzXFDpaIBHf973bbJTU/ITr6YFW3ek5VqwROiwB6ZtS0FU1GLLASP7xotoNkTQ6TJSOr4Zx1Rw8oFKseRuYikzXDt1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WS4YH2qK8z20lVq;
	Mon, 22 Jul 2024 10:51:31 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B29F1A0188;
	Mon, 22 Jul 2024 10:53:12 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 10:53:10 +0800
Message-ID: <b8792d9c-c2a2-6808-f94b-e3b826232f78@huawei.com>
Date: Mon, 22 Jul 2024 10:53:10 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
Content-Language: en-US
To: <linux@armlinux.org.uk>, <ardb@kernel.org>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<kees@kernel.org>, <masahiroy@kernel.org>, <palmer@rivosinc.com>,
	<samitolvanen@google.com>, <xiao.w.wang@intel.com>, <alexghiti@rivosinc.com>,
	<nathan@kernel.org>, <jan.kiszka@siemens.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240624023612.2134144-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Gentle ping.

On 2024/6/24 10:36, Jinjie Ruan wrote:
> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
> stackleak common code: on_thread_stack(). It initialize the stack with the
> poison value before returning from system calls which improves the kernel
> security. Additionally, this disables the plugin in EFI stub code and
> decompress code, which are out of scope for the protection.
> 
> Before the test on Qemu versatilepb board:
> 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
> 	lkdtm: Performing direct entry STACKLEAK_ERASING
> 	lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)
> 
> After:
> 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
> 	lkdtm: Performing direct entry STACKLEAK_ERASING
> 	lkdtm: stackleak stack usage:
> 	  high offset: 80 bytes
> 	  current:     280 bytes
> 	  lowest:      696 bytes
> 	  tracked:     696 bytes
> 	  untracked:   192 bytes
> 	  poisoned:    7220 bytes
> 	  low offset:  4 bytes
> 	lkdtm: OK: the rest of the thread stack is properly erased
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2:
> - Make on_thread_stack() more legible.
> - Add Acked-by.
> ---
>  arch/arm/Kconfig                      | 1 +
>  arch/arm/boot/compressed/Makefile     | 1 +
>  arch/arm/include/asm/stacktrace.h     | 7 +++++++
>  arch/arm/kernel/entry-common.S        | 3 +++
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  5 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 036381c5d42f..b211b7f5a138 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -86,6 +86,7 @@ config ARM
>  	select HAVE_ARCH_PFN_VALID
>  	select HAVE_ARCH_SECCOMP
>  	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
> +	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 6bca03c0c7f0..945b5975fce2 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -9,6 +9,7 @@ OBJS		=
>  
>  HEAD	= head.o
>  OBJS	+= misc.o decompress.o
> +CFLAGS_decompress.o += $(DISABLE_STACKLEAK_PLUGIN)
>  ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
>  OBJS	+= debug.o
>  AFLAGS_head.o += -DDEBUG
> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
> index 360f0d2406bf..f80a85b091d6 100644
> --- a/arch/arm/include/asm/stacktrace.h
> +++ b/arch/arm/include/asm/stacktrace.h
> @@ -26,6 +26,13 @@ struct stackframe {
>  #endif
>  };
>  
> +static inline bool on_thread_stack(void)
> +{
> +	unsigned long delta = current_stack_pointer ^ (unsigned long)current->stack;
> +
> +	return delta < THREAD_SIZE;
> +}
> +
>  static __always_inline
>  void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>  {
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 5c31e9de7a60..f379c852dcb7 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -119,6 +119,9 @@ no_work_pending:
>  
>  	ct_user_enter save = 0
>  
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	bl	stackleak_erase_on_task_stack
> +#endif
>  	restore_user_regs fast = 0, offset = 0
>  ENDPROC(ret_to_user_from_irq)
>  ENDPROC(ret_to_user)
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 06f0428a723c..20d8a491f25f 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -27,7 +27,8 @@ cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
>  cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
> -				   $(call cc-option,-mno-single-pic-base)
> +				   $(call cc-option,-mno-single-pic-base) \
> +				   $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
>  cflags-$(CONFIG_LOONGARCH)	+= -fpie
>  

