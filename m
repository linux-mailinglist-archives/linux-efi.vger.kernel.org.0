Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAAA332817
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhCIOFk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Mar 2021 09:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhCIOFd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Mar 2021 09:05:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F345651BC;
        Tue,  9 Mar 2021 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615298733;
        bh=TXFyWZPHheQTfjIK2kd6LjPJ24kLhlnsvHPduOP6/pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljqk/HLJGPqAhnbVLxuJBVYmpA3a/gpakTeq2jSnDfJ4ODGdfxPGQoZkLaRF8sLkX
         Z9LdSoLOdtnXDqR/YOsaNmyVl/a9Gm2EpeYcDjd2aKANAEDAz64S491ZBim6sE9dBf
         0wNnv/yVQBXxniz3XssTBHpJvwPZlZbu6cz4ELcWDx2sBT7MnVLvr1JJGfBNr0hb4S
         xEz6zMdOtFIVEZul/a/vuR7ctRHq5TVbcAo/Ds5L9eReHIYgYFIRRgfxXHbQbWflkQ
         CtG6CXy7+VFTozFwYVmqvfuLSm97ATpF+MEqLyZDRHG+75XuXt3BEnBAV1RfIhtNR2
         58HMKLQGgb50w==
Date:   Tue, 9 Mar 2021 14:05:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix __enable_mmu() for new TGRAN range values
Message-ID: <20210309140527.GB28395@willie-the-truck>
References: <1614954969-14338-1-git-send-email-anshuman.khandual@arm.com>
 <8735x5zozr.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735x5zozr.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 08, 2021 at 02:42:00PM +0000, Marc Zyngier wrote:
> On Fri, 05 Mar 2021 14:36:09 +0000,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> > -	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
> > -	default:
> > -	case 1:
> > +	tgran_2 = cpuid_feature_extract_unsigned_field(mmfr0, tgran_2_shift);
> > +	if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE) {
> >  		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
> >  		return -EINVAL;
> > -	case 0:
> > +	} else if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT) {
> >  		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
> > -		break;
> > -	case 2:
> > +	} else if (tgran_2 >= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN &&
> > +		   tgran_2 <= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX) {
> >  		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
> > -		break;
> > +	} else {
> > +		kvm_err("Unsupported value, giving up\n");
> > +		return -EINVAL;
> 
> nit: this doesn't say *what* value is unsupported, and I really
> preferred the switch-case version, such as this:
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 1f22b36a0eff..d267e4b1aec6 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -312,15 +312,18 @@ int kvm_set_ipa_limit(void)
>  
>  	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
>  	default:
> -	case 1:
> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE:
>  		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
>  		return -EINVAL;
> -	case 0:
> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT:
>  		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
>  		break;
> -	case 2:
> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN ... ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX:
>  		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
>  		break;
> +	default:
> +		kvm_err("Unsupported value for TGRAN_2, giving up\n");
> +		return -EINVAL;
>  	}
>  
>  	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
> 
> 
> Otherwise:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

Anshuman -- please can you spin a v2 with the switch syntax as suggested
above by Marc?

Will
