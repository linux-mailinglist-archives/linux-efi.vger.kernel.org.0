Return-Path: <linux-efi+bounces-1263-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9061091186C
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468BF2830CE
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6213D83CD9;
	Fri, 21 Jun 2024 02:24:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610A82886;
	Fri, 21 Jun 2024 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936699; cv=none; b=Is+Nm89EMhGkiR2QOh3AkEOtEVfJTZ9EVOy3gDGalcFNtWXfbWWojIK9V8pf66bQJBLNtbsDg6+qQYbkYxtlrV4tTw/HU485RY1CtvdDff5rEFwfBYKoaRWmmiD2kHR4wfCvUX0ZVccHbKsQGSQClxrWmbBY5v6lexxZNXYz8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936699; c=relaxed/simple;
	bh=PraBJhcoPBo5S5n6x2fO4drOmb0FI0JqOZb9NqLnUYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CpYEQ9qFKaBv+EQjn+MtKVdwbbZvQ6X5mBj3erebT7RKhUxshHtl1DyJIzeouT/Q0kuIRs6SCaEZro6tLnvqge6smOKyMJNxVldtZeHJ41JiOS9CX3icbBMtaNnVENV2gM4NHbb3o9AeaBEIK62iNili1ZStCuExvGMCNm4NlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W51K90pJpzVlQc;
	Fri, 21 Jun 2024 10:19:57 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 157591402CF;
	Fri, 21 Jun 2024 10:24:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 10:24:53 +0800
Message-ID: <bb1ea7f5-973d-54cf-36ab-fe4d55c1b5bc@huawei.com>
Date: Fri, 21 Jun 2024 10:24:52 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ARM: Add support for STACKLEAK gcc plugin
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
CC: <linux@armlinux.org.uk>, <ardb@kernel.org>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<masahiroy@kernel.org>, <palmer@rivosinc.com>, <samitolvanen@google.com>,
	<xiao.w.wang@intel.com>, <alexghiti@rivosinc.com>, <nathan@kernel.org>,
	<jan.kiszka@siemens.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>, Alexander Popov
	<alex.popov@linux.com>
References: <20240620131649.886995-1-ruanjinjie@huawei.com>
 <202406201136.A441E0B7@keescook>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <202406201136.A441E0B7@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/6/21 2:38, Kees Cook wrote:
> On Thu, Jun 20, 2024 at 09:16:49PM +0800, Jinjie Ruan wrote:
>> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
>> stackleak common code: on_thread_stack(). It initialize the stack with the
>> poison value before returning from system calls which improves the kernel
>> security. Additionally, this disables the plugin in EFI stub code and
>> decompress code, which are out of scope for the protection.
> 
> Oh very cool! Thanks for sending this!
> 
>> Before the test on Qemu versatilepb board:
>> 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>> 	lkdtm: Performing direct entry STACKLEAK_ERASING
>> 	lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)
>>
>> After:
>> 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>> 	lkdtm: Performing direct entry STACKLEAK_ERASING
>> 	lkdtm: stackleak stack usage:
>> 	  high offset: 80 bytes
>> 	  current:     280 bytes
>> 	  lowest:      696 bytes
>> 	  tracked:     696 bytes
>> 	  untracked:   192 bytes
>> 	  poisoned:    7220 bytes
>> 	  low offset:  4 bytes
>> 	lkdtm: OK: the rest of the thread stack is properly erased
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm/Kconfig                      | 1 +
>>  arch/arm/boot/compressed/Makefile     | 1 +
>>  arch/arm/include/asm/stacktrace.h     | 5 +++++
>>  arch/arm/kernel/entry-common.S        | 3 +++
>>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>>  5 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 036381c5d42f..b211b7f5a138 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -86,6 +86,7 @@ config ARM
>>  	select HAVE_ARCH_PFN_VALID
>>  	select HAVE_ARCH_SECCOMP
>>  	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
>> +	select HAVE_ARCH_STACKLEAK
>>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>>  	select HAVE_ARCH_TRACEHOOK
>>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
>> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
>> index 6bca03c0c7f0..945b5975fce2 100644
>> --- a/arch/arm/boot/compressed/Makefile
>> +++ b/arch/arm/boot/compressed/Makefile
>> @@ -9,6 +9,7 @@ OBJS		=
>>  
>>  HEAD	= head.o
>>  OBJS	+= misc.o decompress.o
>> +CFLAGS_decompress.o += $(DISABLE_STACKLEAK_PLUGIN)
>>  ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
>>  OBJS	+= debug.o
>>  AFLAGS_head.o += -DDEBUG
>> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
>> index 360f0d2406bf..a9b4b72ed241 100644
>> --- a/arch/arm/include/asm/stacktrace.h
>> +++ b/arch/arm/include/asm/stacktrace.h
>> @@ -26,6 +26,11 @@ struct stackframe {
>>  #endif
>>  };
>>  
>> +static inline bool on_thread_stack(void)
>> +{
>> +	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
>> +}
>> +
>>  static __always_inline
>>  void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>>  {
>> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
>> index 5c31e9de7a60..f379c852dcb7 100644
>> --- a/arch/arm/kernel/entry-common.S
>> +++ b/arch/arm/kernel/entry-common.S
>> @@ -119,6 +119,9 @@ no_work_pending:
>>  
>>  	ct_user_enter save = 0
>>  
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +	bl	stackleak_erase_on_task_stack
>> +#endif
>>  	restore_user_regs fast = 0, offset = 0
>>  ENDPROC(ret_to_user_from_irq)
>>  ENDPROC(ret_to_user)
>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index 06f0428a723c..20d8a491f25f 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -27,7 +27,8 @@ cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
>>  cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>>  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>>  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>> -				   $(call cc-option,-mno-single-pic-base)
>> +				   $(call cc-option,-mno-single-pic-base) \
>> +				   $(DISABLE_STACKLEAK_PLUGIN)
>>  cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
>>  cflags-$(CONFIG_LOONGARCH)	+= -fpie
> 
> This looks very straight forward! If an ARM person can Ack this, I could
> carry it via the hardening tree. Otherwise, it should probably go via
> rmk's patch tracker?

Thank you for your attention and reply.

> 
> -Kees
> 

