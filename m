Return-Path: <linux-efi+bounces-1261-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1404911184
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 20:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF74DB24CA4
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1B1B29D5;
	Thu, 20 Jun 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4mzUIph"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55C1AAE17;
	Thu, 20 Jun 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908715; cv=none; b=P0M4egX1rTD0YtY70/CsRoVFDaUHwyK5BTZuhtrHozavVhNiVfkLCkbxkdeSac6y5MIHm65sLOoG6D1SVWYLqZm0JB+cafID16kQ81F2lj/y3jOYQEUWcLQVP35bEcgwwkNWWIsGC54AiRhYy2nCkJY6+5CbGtklDB/iotciYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908715; c=relaxed/simple;
	bh=bt0gQE1+V2HRT08t/BZzlfDOsm+kbAKYPtp191A9SSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWjW8FW/m5N+oju4yRv43jL1cQHGIJja+aF9ijcMFy7MdHnMN6iuLuvFPqeDYQLr2Y3jmdOQZJo5wV1DNuOERX1/sD/PHNZUfEk62PEow7ey1wvR9uMSo9LdjxgtFNwtMyU5GcSLuZHoSbcH14C1H9pchzYK38ZsYxA4p7vsWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4mzUIph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46471C2BD10;
	Thu, 20 Jun 2024 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718908715;
	bh=bt0gQE1+V2HRT08t/BZzlfDOsm+kbAKYPtp191A9SSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4mzUIphC+bsGyWWVINjJ+zyi2TYr+n1ojFGjsI8XWbK2zNhXlv1Nx8qG243WOG1j
	 SP+qRwr/3cCBXWOZJyJ5jtDpC9RymL1zO+H8oGQZMTN9HwTMKzmWkG4Bdo7uwrN4fc
	 Ksfxhz7OZtJi542XD73eeU5TCJha8pxUCpw8QzPr6BT6PGiDwvbYk6wGHaq88zc0Nu
	 g2GYoUzzlpjTWzYWwandJUjit9KugI72A6XPga/pvfKAeZ9/4SKLgUNWuDuNmaGzzB
	 rmi1hv1JFv1nNx9XhhT5Clg0dC4YMIwFit8yctnF0ZOnlBofbCqae/5n+6OKjM+Dq0
	 l+k19n0IFRmbw==
Date: Thu, 20 Jun 2024 11:38:34 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, ardb@kernel.org, arnd@arndb.de, afd@ti.com,
	akpm@linux-foundation.org, rmk+kernel@armlinux.org.uk,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	masahiroy@kernel.org, palmer@rivosinc.com, samitolvanen@google.com,
	xiao.w.wang@intel.com, alexghiti@rivosinc.com, nathan@kernel.org,
	jan.kiszka@siemens.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH] ARM: Add support for STACKLEAK gcc plugin
Message-ID: <202406201136.A441E0B7@keescook>
References: <20240620131649.886995-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620131649.886995-1-ruanjinjie@huawei.com>

On Thu, Jun 20, 2024 at 09:16:49PM +0800, Jinjie Ruan wrote:
> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
> stackleak common code: on_thread_stack(). It initialize the stack with the
> poison value before returning from system calls which improves the kernel
> security. Additionally, this disables the plugin in EFI stub code and
> decompress code, which are out of scope for the protection.

Oh very cool! Thanks for sending this!

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
> ---
>  arch/arm/Kconfig                      | 1 +
>  arch/arm/boot/compressed/Makefile     | 1 +
>  arch/arm/include/asm/stacktrace.h     | 5 +++++
>  arch/arm/kernel/entry-common.S        | 3 +++
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  5 files changed, 12 insertions(+), 1 deletion(-)
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
> index 360f0d2406bf..a9b4b72ed241 100644
> --- a/arch/arm/include/asm/stacktrace.h
> +++ b/arch/arm/include/asm/stacktrace.h
> @@ -26,6 +26,11 @@ struct stackframe {
>  #endif
>  };
>  
> +static inline bool on_thread_stack(void)
> +{
> +	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
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

This looks very straight forward! If an ARM person can Ack this, I could
carry it via the hardening tree. Otherwise, it should probably go via
rmk's patch tracker?

-Kees

-- 
Kees Cook

