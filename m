Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC99D76CFFC
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjHBO0z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjHBO0y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 10:26:54 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585F26B6;
        Wed,  2 Aug 2023 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690986413; x=1722522413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAkMfBLjH6OHhuJX89q7OXvIIHFbEaP66QKPHvFFEG0=;
  b=SQK9dqQ+TD72v/FJDvczI+OKoCM1iPbq9ZBJUGuddSPR7+EnVwwLPSmJ
   zzXAa29WKRyAUElGnNVqsc/C9XLKI48lyFDvz+KUruhaquhEYj+vhiHGf
   ed3SBT/FAFaFvkpYJq1WHdgx8FStXAOs7x+X4SFbPcURMwbA/z2UkEw7U
   9gTP7WWf7M0p1r+7E9kVthtEDeFAmnfBT/OjPB/+Qm7YAo0FZNwo84Zfz
   MyiMLT9So68412bazqPWik7KABH3mH5Y7Q2Ht/pTpx4fRF+EfBji0sKwP
   WOKDRignyX68+kMGKyrXqdc5465BEZ2T0I5Ejd1W47gkoG8YvJKb31VBZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349196991"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349196991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 07:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794587008"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="794587008"
Received: from dustindi-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 07:25:26 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C2ABA10A112; Wed,  2 Aug 2023 17:25:23 +0300 (+03)
Date:   Wed, 2 Aug 2023 17:25:23 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
Message-ID: <20230802142523.t5o36uy3z366jh27@box.shutemov.name>
References: <20230802133704.2146580-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802133704.2146580-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 02, 2023 at 03:37:04PM +0200, Ard Biesheuvel wrote:
> CONFIG_EFI_RUNTIME_MAP needs to be enabled in order for kexec to be able
> to provide the required information about the EFI runtime mappings to
> the incoming kernel, regardless of whether kexec_load() or
> kexec_file_load() is being used. Without this information, kexec boot in
> EFI mode is not possible.
> 
> The CONFIG_EFI_RUNTIME_MAP option is currently directly configurable if
> CONFIG_EXPERT is enabled, so that it can be turned on for debugging
> purposes even if KEXEC is. However, the upshot of this is that it can
> also be disabled even when it shouldn't.
> 
> So tweak the Kconfig declarations to avoid this situation.
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

With the patch 'make oldconfig' updates config to enable
EFI_NEED_RUNTIME_MAP.

Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks.
> ---
>  arch/x86/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7422db4097701c96..616498cdc91e8f01 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2027,10 +2027,14 @@ config EFI_MAX_FAKE_MEM
>  	  Ranges can be set up to this value using comma-separated list.
>  	  The default value is 8.
>  
> +config EFI_NEED_RUNTIME_MAP
> +	def_bool y
> +	depends on EFI && KEXEC_CORE
> +	select EFI_RUNTIME_MAP
> +

Just curious, why not extend 'config EFI' with 'select EFI_RUNTIME_MAP if KEXEC_CORE'?
It seems functionally equivalent, but more concise.

>  config EFI_RUNTIME_MAP
>  	bool "Export EFI runtime maps to sysfs" if EXPERT
>  	depends on EFI
> -	default KEXEC_CORE
>  	help
>  	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
>  	  That memory map is required by the 2nd kernel to set up EFI virtual
> -- 
> 2.39.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
