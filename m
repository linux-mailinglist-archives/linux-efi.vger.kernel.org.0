Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4EB49A484
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 03:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351716AbiAYASz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jan 2022 19:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383368AbiAXXFt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jan 2022 18:05:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F323C02980A;
        Mon, 24 Jan 2022 13:16:47 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AE631EC0441;
        Mon, 24 Jan 2022 22:16:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643059000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2NXgmmDv+ocvq+rd99D4kGdoHRWuQ11s8nfd6a2ykIk=;
        b=JeFsNaeW1bXEh73iheAO7YAnF6esRbl9JrXJU3kMpTLFhpyM/6aF9jxKDGjNW6da+Y/D6p
        xG9hcbb78SVNkZ5Azg05/V03p28IxiXtJi8hiSJcOmsn8g3q6HQTncLrJPt8lgRTN6Q2z5
        keoKJGXH8ynwl8GLF0SXWRJfVZRaUgQ=
Date:   Mon, 24 Jan 2022 22:16:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [RESEND PATCH v3 1/2] efi/cper: add cper_mem_err_status_str to
 decode error description
Message-ID: <Ye8XMvfXCetzJLTH@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220124024759.19176-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124024759.19176-2-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 24, 2022 at 10:47:58AM +0800, Shuai Xue wrote:
> Introduce a new helper function cper_mem_err_status_str() which is used to
> decode the description of error status, and the cper_print_mem() will call
> it and report the details of error status.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/firmware/efi/cper.c | 46 ++++++++++++++++++++++++++++++++++++-
>  include/linux/cper.h        |  1 +
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 6ec8edec6329..addafccecd84 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -211,6 +211,49 @@ const char *cper_mem_err_type_str(unsigned int etype)
>  }
>  EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
>  
> +const char *cper_mem_err_status_str(u64 status)
> +{
> +	switch ((status >> 8) & 0xff) {
> +	case 1:
> +		return "Error detected internal to the component";

You can make that table a lot more compact:

        switch ((status >> 8) & 0xff) {
        case  1:        return "Error detected internal to the component";
        case  4:        return "Storage error in DRAM memory";
        case  5:        return "Storage error in TLB";
        case  6:        return "Storage error in cache";
        case  7:        return "Error in one or more functional units";
        case  8:        return "component failed self test";
        case  9:        return "Overflow or undervalue of internal queue";
        case 16:        return "Error detected in the bus";
	...

> +	case 16:
> +		return "Error detected in the bus";

And yes, that 16 needs to come before 17, ofc.

> @@ -334,7 +377,8 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>  		return;
>  	}
>  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> +		printk("%s""error_status: 0x%016llx, %s\n", pfx, mem->error_status,
> +				cper_mem_err_status_str(mem->error_status));

Arguments need to be aligned at opening brace, i.e.:

                printk("%s""error_status: 0x%016llx, %s\n",
                        pfx, mem->error_status, cper_mem_err_status_str(mem->error_status));


Also, the naked error status number is not as user-friendly when we have
the decoded string. So the format should be:

                printk("%s error_status: %s (0x%016llx)\n",
                        pfx, cper_mem_err_status_str(mem->error_status), mem->error_status);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
