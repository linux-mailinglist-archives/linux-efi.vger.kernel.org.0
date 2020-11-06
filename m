Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46E2A95F5
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 13:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKFMJm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 07:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMJl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Nov 2020 07:09:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF0C0613CF;
        Fri,  6 Nov 2020 04:09:41 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d1f002c83f8cfec6c8cbe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1f00:2c83:f8cf:ec6c:8cbe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DFACC1EC0472;
        Fri,  6 Nov 2020 13:09:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604664580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3Ci7oTqucUEYbCOxujDfl/9l+12eKuq8wK76UMHgU9Y=;
        b=MvI/6O8ql2JPvklh62TEq6HDldWkesRPzhwI2utlOiEmi7ukBo1NKFoJkSL/GYa7OAes+g
        MDo1gDgwVVhZXH1LIcqpK/M4uenUh4Vq+DQHgMYuX895azCn/xh/b+Ef3a3Py0OJbhP/x7
        pJRd5mD+SiELlRHYootUvkBRJHkorWE=
Date:   Fri, 6 Nov 2020 13:09:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20201106120923.GB14914@zn.tnic>
References: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 03, 2020 at 10:49:52AM -0600, Smita Koralahalli wrote:
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index af8d37962586..f56f0bc147e2 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -51,6 +51,62 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  }
>  EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>  
> +int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> +{
> +	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
> +	unsigned int cpu;
> +	struct mce m;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SMCA))
> +		return -EINVAL;
> +
> +	/*
> +	 * The starting address of the Register Array extracted from BERT
> +	 * must match with the first expected register in the register
> +	 * layout of MCAX address space. In SMCA systems this address
> +	 * corresponds to banks's MCA_STATUS register.

So which is it "MCAX" or "SMCA"? They both denote the same thing but
let's stick to one to avoid unnecessary confusion. I'm guessing to
"SMCA" because it is more wide-spread in the kernel...

> +	 *
> +	 * The Register array size must be large enough to include all
> +	 * the SMCA registers which we want to extract.
> +	 *
> +	 * The number of registers in the Register Array is determined
> +	 * by Register Array Size/8 as defined in UEFI spec v2.8, sec
> +	 * N.2.4.2.2. The register layout is fixed and currently the raw
> +	 * data in the register array includes 6 SMCA registers which the
> +	 * kernel can extract.
> +	 */
> +
> +	if ((ctx_info->msr_addr & MSR_AMD64_SMCA_MC0_STATUS) !=
> +	    MSR_AMD64_SMCA_MC0_STATUS || ctx_info->reg_arr_size < 48)
> +		return -EINVAL;

Split that if in two consecutive if-statements.

Also, why the ANDing and not simply do:

	if (ctx_info->msr_addr == MSR_AMD64_SMCA_MC0_STATUS)

?

I'm guessing you wanna match *all* MCi_STATUS MSRs - not only MC0, yes?

If so, document that with in the comment above it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
