Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38A33C0C0
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 03:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbfFKBAv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jun 2019 21:00:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42944 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbfFKBAv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jun 2019 21:00:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so17240391edq.9
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2019 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MpTcf2dGU6Up+9YKsTQko4V1d1bIIofdRcq05RBwejs=;
        b=C5rnD9joPDwPRS8tvoFCyWyqamt7ci+rWjII9yd5x36+9rKJjZfbrEldZCUsOe7Stq
         yJfPKyCcx/cuLRrWtPjGjr11+DIZ7eyd81evSeMhFmFF6rJuH/1Fb9QlRKGD7He/Kfuh
         I6ukBGCJye13QZqE8yaF3o0udjefVBte21Y8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MpTcf2dGU6Up+9YKsTQko4V1d1bIIofdRcq05RBwejs=;
        b=UjcY8eBjmevHgz06giwZLKKVCwZwXvQp9ntUiaMmpfTzBsFx43NL5XYvPLqhV8tuXD
         ZMbfn812kvXIEDlu/GrVi3oNO0O4q9NCchbVKCbj271K3thisqwVZPzYsEX7ykrcv6IW
         xL7SjCOwqbzrshfuBrkhz01AL+RscFHuAnPYVrDQ9bYfCEgYxE7PyrO4vx0G8jFe8Mjd
         GdZR7jEWUSySTmK+PhbNeGXNhHirEcJNG/tMXjopjVyLjFmjusSdrZ+dCkOxdOl3jeZj
         8/MELLgIFpKb3YuGyBxoNMwpMqESjsGtsMgF7snz66CTPxPFQob6wNXe6JHG1thF8Mk8
         lZ9w==
X-Gm-Message-State: APjAAAUMr44CiXnExpDz7YaSN7BEAFEYMtNDbnidwpxp4ZPNpBUytixa
        Eye+UeHsDL5VCJ0+ULopj11EE5yJwdAp8Q==
X-Google-Smtp-Source: APXvYqyjAUeHoNicBgrqNGPB7enKfhpwcmWTkvUeKeyKtWa/DGctlYip+lQ4O6b8QKlIqvmykgLsmQ==
X-Received: by 2002:a50:987a:: with SMTP id h55mr37042106edb.108.1560214849274;
        Mon, 10 Jun 2019 18:00:49 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f3sm2009104ejc.15.2019.06.10.18.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 18:00:48 -0700 (PDT)
Subject: Re: [PATCH] efi/memreserve: deal with memreserve entries in unmapped
 memory
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        bhsharma@redhat.com, ray.jui@broadcom.com
References: <20190610150530.10306-1-ard.biesheuvel@linaro.org>
From:   Jonathan Richardson <jonathan.richardson@broadcom.com>
Message-ID: <6d51db76-c8d0-aaaa-02a8-0c62058e5c2d@broadcom.com>
Date:   Mon, 10 Jun 2019 18:00:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190610150530.10306-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06/10/2019 08:05 AM, Ard Biesheuvel wrote:
> Ensure that the EFI memreserve entries can be accessed, even if they
> are located in memory that the kernel (e.g., a crashkernel) omits from
> the linear map.
> 
> Reported-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 16b2137d117c..4b7cf7bc0ded 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -1009,14 +1009,16 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  
>  	/* first try to find a slot in an existing linked list entry */
>  	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
> -		rsv = __va(prsv);
> +		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
>  		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
>  		if (index < rsv->size) {
>  			rsv->entry[index].base = addr;
>  			rsv->entry[index].size = size;
>  
> +			memunmap(rsv);
>  			return 0;
>  		}
> +		memunmap(rsv);
>  	}
>  
>  	/* no slot found - allocate a new linked list entry */
> @@ -1024,7 +1026,13 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  	if (!rsv)
>  		return -ENOMEM;
>  
> -	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
> +	/*
> +	 * The memremap() call above assumes that a linux_efi_memreserve entry
> +	 * never crosses a page boundary, so let's ensure that this remains true
> +	 * even when kexec'ing a 4k pages kernel from a >4k pages kernel, by
> +	 * using SZ_4K explicitly in the size calculation below.
> +	 */
> +	rsv->size = EFI_MEMRESERVE_COUNT(SZ_4K);
>  	atomic_set(&rsv->count, 1);
>  	rsv->entry[0].base = addr;
>  	rsv->entry[0].size = size;
> 

Thanks for the fix. Tested and reviewed.

Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
