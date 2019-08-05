Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF181E12
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2019 15:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfHENxF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Aug 2019 09:53:05 -0400
Received: from foss.arm.com ([217.140.110.172]:49686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfHENxF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 5 Aug 2019 09:53:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F8A337;
        Mon,  5 Aug 2019 06:53:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B5233F706;
        Mon,  5 Aug 2019 06:53:03 -0700 (PDT)
Date:   Mon, 5 Aug 2019 14:53:01 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/efi: fix variable 'si' set but not used
Message-ID: <20190805135301.GB10425@arm.com>
References: <1564521828-4528-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564521828-4528-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 30, 2019 at 05:23:48PM -0400, Qian Cai wrote:
> GCC throws out this warning on arm64.
> 
> drivers/firmware/efi/libstub/arm-stub.c: In function 'efi_entry':
> drivers/firmware/efi/libstub/arm-stub.c:132:22: warning: variable 'si'
> set but not used [-Wunused-but-set-variable]
> 
> Fix it by making free_screen_info() a static inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/include/asm/efi.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 8e79ce9c3f5c..76a144702586 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -105,7 +105,11 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
>  	((protocol##_t *)instance)->f(instance, ##__VA_ARGS__)
>  
>  #define alloc_screen_info(x...)		&screen_info
> -#define free_screen_info(x...)
> +
> +static inline void free_screen_info(efi_system_table_t *sys_table_arg,
> +				    struct screen_info *si)
> +{
> +}

Is this issue caused by the EFI stub being built with non-default
CFLAGS?

The toplevel Makefile specifies -Wno-unused-but-set-variable, which
would silence this warning.

It's debatable whether calling an empty inline function "uses" the
arguments, so I think your patch only silences the warning by accident:
different GCC versions, or clang, might still warn.


I wonder if we're missing any other options that would make sense for
the EFI stub.

[...]

Cheers
---Dave
