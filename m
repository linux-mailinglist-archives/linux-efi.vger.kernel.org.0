Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947D622E32
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiKIOms (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 09:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKIOmq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 09:42:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0403465B8
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 06:42:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D267B1FB;
        Wed,  9 Nov 2022 06:42:50 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97263F73D;
        Wed,  9 Nov 2022 06:42:43 -0800 (PST)
Date:   Wed, 9 Nov 2022 14:42:41 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH] arm64: efi: Disable only the misbehaving runtime service
 on sync exceptions
Message-ID: <Y2u8YRlOoWrirMK+@monolith.localdoman>
References: <20221108151509.2250968-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108151509.2250968-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Tue, Nov 08, 2022 at 04:15:09PM +0100, Ard Biesheuvel wrote:
> Alexandru reports that his Ampere Altra machine, whose buggy firmware
> triggers a synchronous exception in its implementation of SetTime() when
> called without SetVirtualAddressMap() having been called first, doesn't
> quite recover from this, and starts spewing error messages into the log
> that are unrelated to the buggy runtime service.
> 
> The driver in question is the EFI RTC driver, which should be fixed in
> any case, as flooding the log like that (or doing any logging to the
> kernel log at all on something whuch is not a severe issue) is not ok.
> 
> However, in this particular case, it would be beneficial for both
> ordinary use as well as diagnostics regarding broken firmware if we only
> prevent the broken runtime service from being called again, and permit
> others (such as GetTime() which triggers the logging or the variable
> services) from being used as normal.
> 
> So wire up the existing efi.runtime_supported_mask, and clear the
> service's bit in the mask if the generic runtime service wrapper
> observes a return value of EFI_ABORTED, which only happens if a service
> call is aborted due to an exception. (EFI_ABORTED is not documented as a
> valid error code for any of the EFI runtime services).

With a kernel built from v6.1-rc4, when doing efibootmgr after the EFI panic
happens (so with runtime services disabled), this is what I get:

# efibootmgr
Skipping unreadable variable "Boot0001": Interrupted system call
Skipping unreadable variable "Boot0002": Interrupted system call
show_order(): Interrupted system call

And dmesg shows:

[   55.941312] efi: EFI Runtime Services are disabled!

With this patch on top of v6.1-rc4:

# efibootmgr
Skipping unreadable variable "Boot0001": Invalid argument
Skipping unreadable variable "Boot0002": Invalid argument
show_order(): Invalid argument

Same thing happens if I cat the Boot001 efivars file. Nothing is printed
on dmesg.

Changed efi_call_rts() to print the return value, status is
0x8000_0000_0000_000f (or 15 in decimal if casted into an int). Tried to
debug further, but I'm not familiar with all the structs and what they
represent (for example, efi_call_virt(get_variable, args) calls
efi_call_virt_pointer(efi.runtime, get_variable, args), does it end up as
__efi_rt_asm_wrapper((efi.runtime)->get_variable, "get_variable", args?) As
an aside, it would be really helpful to document the arguments for
__efi_rt_asm_wrapper. Pointers here how to debug further would be very
welcome.

Thanks,
Alex

> 
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/efi.c                 |  1 -
>  arch/x86/platform/efi/quirks.c          |  2 +-
>  drivers/firmware/efi/runtime-wrappers.c |  6 ++++--
>  include/linux/efi.h                     | 24 ++++++++++++------------
>  4 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index ee53f2a0aa03f54a..a3b8852f2698d9f7 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -153,7 +153,6 @@ asmlinkage efi_status_t __efi_rt_asm_recover(void);
>  asmlinkage efi_status_t efi_handle_runtime_exception(const char *f)
>  {
>  	pr_err(FW_BUG "Synchronous exception occurred in EFI runtime service %s()\n", f);
> -	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>  	return EFI_ABORTED;
>  }
>  
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index b0b848d6933afbcf..3f48fdf42d97dc1f 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -757,9 +757,9 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
>  
>  	/* Signal error status to the efi caller process */
>  	efi_rts_work.status = EFI_ABORTED;
> +	efi.runtime_supported_mask = 0;
>  	complete(&efi_rts_work.efi_rts_comp);
>  
> -	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>  	pr_info("Froze efi_rts_wq and disabled EFI Runtime Services\n");
>  
>  	/*
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index f3e54f6616f02475..336b8bcec86d0127 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -60,8 +60,8 @@ struct efi_runtime_work efi_rts_work;
>  ({									\
>  	efi_rts_work.status = EFI_ABORTED;				\
>  									\
> -	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
> -		pr_warn_once("EFI Runtime Services are disabled!\n");	\
> +	if (!efi_rt_services_supported(efi_rts_work.efi_rts_id)) {	\
> +		pr_warn_ratelimited("EFI Runtime Service is disabled!\n");\
>  		goto exit;						\
>  	}								\
>  									\
> @@ -83,6 +83,8 @@ struct efi_runtime_work efi_rts_work;
>  	else								\
>  		pr_err("Failed to queue work to efi_rts_wq.\n");	\
>  									\
> +	if (efi_rts_work.status == EFI_ABORTED)				\
> +		efi.runtime_supported_mask &= ~efi_rts_work.efi_rts_id;	\
>  exit:									\
>  	efi_rts_work.efi_rts_id = EFI_NONE;				\
>  	efi_rts_work.status;						\
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 929d559ad41d29c6..61b252386d61cc4d 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1254,18 +1254,18 @@ extern unsigned long rci2_table_phys;
>   */
>  enum efi_rts_ids {
>  	EFI_NONE,
> -	EFI_GET_TIME,
> -	EFI_SET_TIME,
> -	EFI_GET_WAKEUP_TIME,
> -	EFI_SET_WAKEUP_TIME,
> -	EFI_GET_VARIABLE,
> -	EFI_GET_NEXT_VARIABLE,
> -	EFI_SET_VARIABLE,
> -	EFI_QUERY_VARIABLE_INFO,
> -	EFI_GET_NEXT_HIGH_MONO_COUNT,
> -	EFI_RESET_SYSTEM,
> -	EFI_UPDATE_CAPSULE,
> -	EFI_QUERY_CAPSULE_CAPS,
> +	EFI_GET_TIME			= EFI_RT_SUPPORTED_GET_TIME,
> +	EFI_SET_TIME			= EFI_RT_SUPPORTED_SET_TIME,
> +	EFI_GET_WAKEUP_TIME		= EFI_RT_SUPPORTED_GET_WAKEUP_TIME,
> +	EFI_SET_WAKEUP_TIME		= EFI_RT_SUPPORTED_SET_WAKEUP_TIME,
> +	EFI_GET_VARIABLE		= EFI_RT_SUPPORTED_GET_VARIABLE,
> +	EFI_GET_NEXT_VARIABLE		= EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME,
> +	EFI_SET_VARIABLE		= EFI_RT_SUPPORTED_SET_VARIABLE,
> +	EFI_GET_NEXT_HIGH_MONO_COUNT	= EFI_RT_SUPPORTED_GET_NEXT_HIGH_MONOTONIC_COUNT,
> +	EFI_RESET_SYSTEM		= EFI_RT_SUPPORTED_RESET_SYSTEM,
> +	EFI_UPDATE_CAPSULE		= EFI_RT_SUPPORTED_UPDATE_CAPSULE,
> +	EFI_QUERY_CAPSULE_CAPS		= EFI_RT_SUPPORTED_QUERY_CAPSULE_CAPABILITIES,
> +	EFI_QUERY_VARIABLE_INFO		= EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO,
>  };
>  
>  /*
> -- 
> 2.35.1
> 
