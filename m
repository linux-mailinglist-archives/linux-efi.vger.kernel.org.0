Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F949BBC6
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 20:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiAYTJE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 14:09:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbiAYTJD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Jan 2022 14:09:03 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 604A21EC0441;
        Tue, 25 Jan 2022 20:08:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643137737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5dre2/Xoj69vksLt8aXgzTbDFCPxTScJvpBPEiFuIbQ=;
        b=IHzJITh+VdU95Z41M40ydSHyrkALBX7HVqwjLxp4UiekH8GB0N5/xLb5qCknqNI8wtf9pr
        fo0NzV4rRS8gd3piweS+CnBXWxnaxks6r3gInZaMFULNRZk1ovT7fYgdI9ansMvlSuR1CS
        tygs6LXYUSaeqh1d+PEEGciwvosrc1E=
Date:   Tue, 25 Jan 2022 20:08:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v4 1/2] efi/cper: add cper_mem_err_status_str to decode
 error description
Message-ID: <YfBKxGFbRozNdJiD@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220125024939.30635-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125024939.30635-2-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 25, 2022 at 10:49:38AM +0800, Shuai Xue wrote:
> Introduce a new helper function cper_mem_err_status_str() which is used to
> decode the description of error status, and the cper_print_mem() will call
> it and report the details of error status.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/firmware/efi/cper.c | 29 ++++++++++++++++++++++++++++-
>  include/linux/cper.h        |  1 +
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 6ec8edec6329..7f08d4ea906e 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -211,6 +211,31 @@ const char *cper_mem_err_type_str(unsigned int etype)
>  }
>  EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
>  
> +const char *cper_mem_err_status_str(u64 status)
> +{
> +	switch ((status >> 8) & 0xff) {
> +	case  1:	return "Error detected internal to the component";
> +	case  4:	return "Storage error in DRAM memory";
> +	case  5:	return "Storage error in TLB";
> +	case  6:	return "Storage error in cache";
> +	case  7:	return "Error in one or more functional units";
> +	case  8:	return "component failed self test";

Well, at least start them all with capital letters: "Component... " And
yes, I know this is how it is in the spec but the spec has typos and
other problems - doesn't mean we have to copy them too.

> +	case  9:	return "Overflow or undervalue of internal queue";
> +	case 16:	return "Error detected in the bus";
> +	case 17:	return "Virtual address not found on IO-TLB or IO-PDIR";
> +	case 18:	return "Improper access error";
> +	case 19:	return "Access to a memory address which is not mapped to any component";
> +	case 20:	return "Loss of Lockstep";
> +	case 21:	return "Response not associated with a request";
> +	case 22:	return "Bus parity error - must also set the A, C, or D Bits";
> +	case 23:	return "Detection of a PATH_ERROR ";

Trailing space here. Also what is PATH_ERROR?

That "PATH_ERROR" is nowhere else explained in that big fat UEFI spec.
2558 pages and they can't explain *that*. Geez.

> +	case 25:	return "Bus operation timeout";
> +	case 26:	return "A read was issued to data that has been poisoned";
> +	default:	return "reserved";
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err_status_str);
> +
>  static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>  {
>  	u32 len, n;
> @@ -334,7 +359,9 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>  		return;
>  	}
>  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> +		printk("%s""error_status: %s (0x%016llx)\n",

Why do you insist on having two back-to-back strings instead of one
here?

(And don't tell me it is because the other function calls here do it
too.)

FWIW, even checkpatch complains here:

WARNING: Consecutive strings are generally better as a single string
#87: FILE: drivers/firmware/efi/cper.c:362:
+               printk("%s""error_status: %s (0x%016llx)\n",

Btw, please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
