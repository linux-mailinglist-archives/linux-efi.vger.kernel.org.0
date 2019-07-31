Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8387C86A
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2019 18:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfGaQS5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 Jul 2019 12:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfGaQS4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 31 Jul 2019 12:18:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7DE206A3;
        Wed, 31 Jul 2019 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564589935;
        bh=m7LJ3cDXN8hWsMVQHOFhXh2IAaCcNSFO7AdnTzfmink=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHTQjj7PSrLQWiXVVgdu/bqDtHo9wdnu/reCcbSA4Ojc/21Ec3AP2DK9NlMM/UdMB
         aDywlRLRPeWFiu1Il/2qBhpBmsteNuQmh7C1wnSHzmFkxBOJ8kRifhCGya1xWPfH/X
         hrKYsr1KcoXaLFH50ccWaTzmv943SK2SjFdRMYno=
Date:   Wed, 31 Jul 2019 17:18:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/efi: fix variable 'si' set but not used
Message-ID: <20190731161851.raecunlcm4zpd3pb@willie-the-truck>
References: <1564521828-4528-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564521828-4528-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
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
>  
>  /* redeclare as 'hidden' so the compiler will generate relative references */
>  extern struct screen_info screen_info __attribute__((__visibility__("hidden")));
> -- 
> 1.8.3.1

Acked-by: Will Deacon <will@kernel.org>

Will
