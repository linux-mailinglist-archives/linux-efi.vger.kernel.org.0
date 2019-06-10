Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E093B99C
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2019 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfFJQfv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jun 2019 12:35:51 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41168 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfFJQfv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jun 2019 12:35:51 -0400
Received: by mail-vk1-f194.google.com with SMTP id l73so1797798vkl.8
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2019 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rL21jzm4DEy1xDUiIII7jAF0C5px68rHf/bpk3oGjp4=;
        b=S8kaOjTUfDdlO8OaUujI//RWD+C3cbVhauwBAfu8YDyUlFTQFQFYxhqFpy6eBlY+nY
         Bdn3l5y35YylzY0lwR8myOdaKcN9xol6ZwXKUWN1/bnn/yTfDy8CG29E0FPHODWAGEnn
         j9bNMMjkw7sM51UBzCZKMcXzQzyJNJ1v+SG+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rL21jzm4DEy1xDUiIII7jAF0C5px68rHf/bpk3oGjp4=;
        b=eTc2ihcORZV2I6cOYOeCjdNetbfKx1cuQNzsH42SaEEU2wrBFocvMl4Bx4cfmAB66l
         Yc097B7hzhj58CwzzNkFaIS5X7mFxyndKhtlxkIn09obtlm9WZt91a+JaeQLvuMTUpEV
         jwlLxPeGDqexW4ILcGwOc8v7RX1EOX8IRZsfzXNqSQGXDGbLGH49nasHNjeTsWUYYZNP
         1nfDmd7FHh8+QhJpYkwOpqa0DlEnFUid6sLi4GvjHFRRrvpPzE3pA0vrHBTqtgfB+nEh
         qBl8GdrM3jn5CURKC5BTffvqn6N4ep6Y3tQFNaP12ZF4IbNhr/r/NaVjm1X3OkBXhg3G
         e43A==
X-Gm-Message-State: APjAAAUcRYlXQ/pmjdXPWmvpGteUdEOLWoYqJh8MnfKHfQVV3WkdRnty
        cC981x6t9rMZ1aV0158LKQT4JtNxlHbZAQ==
X-Google-Smtp-Source: APXvYqxt+PdkwJbUxDxYRnQSU6veQPQ2lMLu1XqZIDTkIOcAGtpZ5ul24t2buihpdmHON+nQ77dKfw==
X-Received: by 2002:a63:e304:: with SMTP id f4mr16240248pgh.187.1560184079575;
        Mon, 10 Jun 2019 09:27:59 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p23sm2797pjo.4.2019.06.10.09.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:27:58 -0700 (PDT)
Subject: Re: [PATCH] efi/memreserve: deal with memreserve entries in unmapped
 memory
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        bhsharma@redhat.com,
        Jonathan Richardson <jonathan.richardson@broadcom.com>
References: <20190610150530.10306-1-ard.biesheuvel@linaro.org>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <76a0336c-31b1-11fe-11d5-a7971a9e44f8@broadcom.com>
Date:   Mon, 10 Jun 2019 09:27:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610150530.10306-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On 6/10/2019 8:05 AM, Ard Biesheuvel wrote:
> Ensure that the EFI memreserve entries can be accessed, even if they
> are located in memory that the kernel (e.g., a crashkernel) omits from
> the linear map.
> 
> Reported-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Does it make sense to add a Fixes tag?

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
