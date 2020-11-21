Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586B02BBE68
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 11:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgKUKPV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Nov 2020 05:15:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKUKPU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 21 Nov 2020 05:15:20 -0500
Received: from zn.tnic (p200300ec2f214500f33993f395083870.dip0.t-ipconnect.de [IPv6:2003:ec:2f21:4500:f339:93f3:9508:3870])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 915691EC0328;
        Sat, 21 Nov 2020 11:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605953718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TE+a6aaG+JBjvq9p0ZYXFgTk1C71UbM7mzgzlUWFp5Y=;
        b=FaLF2Rx/1BUJcR43S9aduurwOQi0iIatFSMkJpnT6viiIlsotOva6nKZQCDbEq12Q5axG3
        KlOhHi95OU97zbKLSpaaX4X9FANx5cOfLYq7P99iR61U5IDYDD7YMi5EL9G2ZYIzyyfmyb
        hIvdnIFxQI9NSbRd+ZKKtUPPhg8oPE4=
Date:   Sat, 21 Nov 2020 11:15:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v6] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20201121101511.GA24020@zn.tnic>
References: <20201119182938.151155-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119182938.151155-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 19, 2020 at 12:29:38PM -0600, Smita Koralahalli wrote:
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 2531de49f56c..438ed9eff6d0 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -2,6 +2,7 @@
>  // Copyright (C) 2018, Advanced Micro Devices, Inc.
>  
>  #include <linux/cper.h>
> +#include <linux/acpi.h>
>  
>  /*
>   * We don't need a "CPER_IA" prefix since these are all locally defined.
> @@ -347,9 +348,13 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  			       ctx_info->mm_reg_addr);
>  		}
>  
> -		printk("%sRegister Array:\n", newpfx);
> -		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> -			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
> +		if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
> +		    arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
> +			printk("%sRegister Array:\n", newpfx);
> +			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16,
> +				       groupsize, (ctx_info + 1),
> +				       ctx_info->reg_arr_size, 0);
> +		}
>  
>  		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
>  	}
> -- 

Ard, ack?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
