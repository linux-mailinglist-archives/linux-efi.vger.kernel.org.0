Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31A18543E
	for <lists+linux-efi@lfdr.de>; Sat, 14 Mar 2020 04:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgCNDXk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Mar 2020 23:23:40 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38386 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCNDXk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Mar 2020 23:23:40 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so4684087pje.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Mar 2020 20:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rfdOz8mHYBRUomVk15RzHjMTiFUq9xKO13xgLgIv0XA=;
        b=craGocgehlme7am/VOSIck8j0h/Fo6fJ2K+c+lafI7yDiPYy7qfoRnxmy96n5NvPJm
         c0smWFIdFvCK8fd8LWhIJWWjeGW6PZkhg+iWO8X2UcTeeq+sTGhXI4NX57fHDqJDywiY
         i8YiQ65plSuUnpyGjV36xL8WIjtRAnxdp/Bhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rfdOz8mHYBRUomVk15RzHjMTiFUq9xKO13xgLgIv0XA=;
        b=TmtQVxF09YWK5hBntqAN660vbMIpxXLpNPbW3QYTa2A5f3wLCkKg47fRc6cXnFzOr1
         cRESr4pMYA1v3muEzKkWRPh6vPx+xUyBRy5hxvjh8x89vLMaSFVltJYja4anH1B2nSjc
         kvuL5a5Q/o2oUoKc5wVvkRpmfIrY4SRR661CYPu70EoxT/UkJeImz2i2fnA0/eTn+t8f
         ykaRo/ZduIw8cF/PXeG9Otoem4VXvy0FiMxmH7gtj+fNu9GcQAgP4nuySdp2HFodAQX5
         SJ8j/RwOMjSOykg3GBTW60gws/sFp49OH1V53yPSoRnICDwBI0rQYtkRQ1J+7VwJraXm
         SXuA==
X-Gm-Message-State: ANhLgQ2woCLowPg3mm+9Fu9PTE023Or4+e4AGFQxX/fO2i9fKJpwyYYG
        bCxjWc4nB9kthN2z6bv4X4aClw==
X-Google-Smtp-Source: ADFU+vtqhny53+UwKx0kI/rxGpW3RocBkKNvILOn/f4BjoCfsdT765v8Ax+3V0NOKKSQK+JcSK+PiA==
X-Received: by 2002:a17:90b:344:: with SMTP id fh4mr12401643pjb.126.1584156219439;
        Fri, 13 Mar 2020 20:23:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm20623109pgx.63.2020.03.13.20.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 20:23:37 -0700 (PDT)
Date:   Fri, 13 Mar 2020 20:23:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     ardb@kernel.org, tony.luck@intel.com, matt@codeblueprint.co.uk,
        liming.gao@intel.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 1/2] efi: Add 'nr_config_table' variable in efi
 structure
Message-ID: <202003132023.68BFCB0@keescook>
References: <20200312011324.70701-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312011324.70701-1-qiuxu.zhuo@intel.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 12, 2020 at 09:13:24AM +0800, Qiuxu Zhuo wrote:
> The 'nr_config_table' and 'config_table' (already in efi structure)
> in efi structure provide a way for some driver(e.g. capsule-pstore
> goes through the configuration table to extract crash capsules to
> aid in debugging) to iterate over the EFI configuration table array.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  arch/x86/platform/efi/efi.c     | 1 +
>  drivers/firmware/efi/arm-init.c | 4 +++-
>  drivers/firmware/efi/efi.c      | 1 +
>  include/linux/efi.h             | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index ae923ee8e2b4..2f3065905e8a 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -456,6 +456,7 @@ void __init efi_init(void)
>  		return;
>  
>  	efi.config_table = (unsigned long)efi.systab->tables;
> +	efi.nr_config_table = (unsigned long)efi.systab->nr_tables;
>  	efi.fw_vendor	 = (unsigned long)efi.systab->fw_vendor;
>  	efi.runtime	 = (unsigned long)efi.systab->runtime;
>  
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index d99f5b0c8a09..f2e2e1c1624b 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -143,8 +143,10 @@ static int __init uefi_init(void)
>  					 sizeof(efi_config_table_t),
>  					 arch_tables);
>  
> -	if (!retval)
> +	if (!retval) {
>  		efi.config_table = (unsigned long)efi.systab->tables;
> +		efi.nr_config_table = (unsigned long)efi.systab->nr_tables;
> +	}
>  
>  	early_memunmap(config_tables, table_size);
>  out:
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 621220ab3d0e..1b599941bad3 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -46,6 +46,7 @@ struct efi __read_mostly efi = {
>  	.fw_vendor		= EFI_INVALID_TABLE_ADDR,
>  	.runtime		= EFI_INVALID_TABLE_ADDR,
>  	.config_table		= EFI_INVALID_TABLE_ADDR,
> +	.nr_config_table	= 0,
>  	.esrt			= EFI_INVALID_TABLE_ADDR,
>  	.properties_table	= EFI_INVALID_TABLE_ADDR,
>  	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7efd7072cca5..13b3fe069f1f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -913,6 +913,7 @@ extern struct efi {
>  	unsigned long fw_vendor;	/* fw_vendor */
>  	unsigned long runtime;		/* runtime table */
>  	unsigned long config_table;	/* config tables */
> +	unsigned long nr_config_table; /* the number of config tables */

nit: please use a tab character before the comment to get correct
alignemnt.

>  	unsigned long esrt;		/* ESRT table */
>  	unsigned long properties_table;	/* properties table */
>  	unsigned long mem_attr_table;	/* memory attributes table */
> -- 
> 2.17.1
> 

-- 
Kees Cook
