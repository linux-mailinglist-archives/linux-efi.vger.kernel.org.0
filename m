Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB211E392
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 13:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLMM31 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 07:29:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726421AbfLMM30 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 07:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576240165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqVLMg58AWM0FHkQWIy9RvlTKD3WIjyT+jsbkRT2D/Y=;
        b=BQgsaIImfL3JU3nusNIrNCIKKcqYwJI8ITtwixb4DHnDhtoU3w2w9nd10P7ANaYzOHQxi3
        OoLbXe36TqToNA1RYABTER5gTH3JKihc1J3h16+tjEuopbDihlQHRysXnH4SIvSAokcmzg
        wikPpTZMlBc4IPAzee6Q7A4lnCPswuA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-UFUnV0XENxGU86b0T0damQ-1; Fri, 13 Dec 2019 07:29:21 -0500
X-MC-Unique: UFUnV0XENxGU86b0T0damQ-1
Received: by mail-wr1-f70.google.com with SMTP id y7so2538352wrm.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 04:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqVLMg58AWM0FHkQWIy9RvlTKD3WIjyT+jsbkRT2D/Y=;
        b=a3ibWy6rJlHojyQD3vbZX4QvvEc3LWyw0o0P5mPYpV6fQ2SwiiuBsyQ5XlUYQX3uJb
         sY28bYVpbMx+iZ5QAh8ARhK+BGIp8WIS8Be6njRlFe5vVZ1+bPmd4EE4Joi1UGw7h08A
         Me81ENCy8V7joGJvkuuoTm5DUhN1jfkId/195XcmdWj6agXfGPgoQfFrOkkAht45HBoU
         1raWEtXUL7noR2fVKN6LVzVAAc8lru2i+OjvOPzlJGz/drk2nE/TOxXmkM4OKYzaaFdd
         4LbP9U175s0z1ZU7qFh6ifhaG6/0ohhoFGS9rmQL9nx+IcMN7ryZhzq5gX5dBEhqnZCf
         VpfQ==
X-Gm-Message-State: APjAAAUXrUEpV9pGSaG5bBA4m9Mkvz0614iIUYVBBuTb/erTRhv2XNIw
        CwBW3tGFkk7hlDbOVXRqbocV3lvpguP5kBiZ7SLnZSXJqiJyjCP5KjLxs0gXRCdABbNAK3Pesrm
        N4e2u5L3uGmPuA4KjDOgF
X-Received: by 2002:a1c:984f:: with SMTP id a76mr12603640wme.64.1576240160049;
        Fri, 13 Dec 2019 04:29:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcJpG5oJR2r9q5vsB1cCcLPkRXWQctUaiOR9s1SZlGyNj4gQUHCmMv72sDjQQNoM1xnjatgw==
X-Received: by 2002:a1c:984f:: with SMTP id a76mr12603625wme.64.1576240159805;
        Fri, 13 Dec 2019 04:29:19 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id z6sm9286036wmz.12.2019.12.13.04.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 04:29:19 -0800 (PST)
Subject: Re: [PATCH] efi/libstub: disable file loading and page deallocation
 in mixed mode
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     matthewgarrett@google.com
References: <20191213091115.567-1-ardb@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
Date:   Fri, 13 Dec 2019 13:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213091115.567-1-ardb@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 13-12-2019 10:11, Ard Biesheuvel wrote:
> EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
> on low end x86_64 machines that shipped with 32-bit UEFI as they were
> built to run 32-bit Windows only.
> 
> Mixed mode relies on the ability to convert calls made using the
> 64-bit calling convention into calls using the 32-bit one. This
> involves pushing a 32-bit word onto the stack for each argument
> passed in a 64-bit register, relying on the fact that all quantities
> that are the native size or smaller (including pointers) can be safely
> truncated to 32 bits. (In the pointer case, we rely on the fact that
> we are still executing in the firmware context, which uses a 1:1
> mapping that can only access the lower 4 GB of the address space)
> 
> For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
> or UINT64, this assumption doesn't hold. The correct way to marshall
> such a call would be to push two consecutive 32-bit words onto the
> stack, but given that the naive thunking code has no knowledge
> whatsoever of the prototype of the function it is invoking, all we can
> do is avoid calling such functions altogether.
> 
> The FreePages() boot service is affected by this, so we should not call
> that at all in mixed mode. In practice, this doesn't change much, since
> in the past, these calls would have been made with a bogus address, and
> so we were leaking this memory already. Note that the scope of this leak
> is the EFI execution context only, so it makes no difference for Linux.
> 
> The other piece of functionality that we need to disable is loading files
> passed via file=xxxx on the command line, given that the Open() method
> takes two UINT64s as well.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Just ignoring the file= arguments is fine with me, as you say this has
been broken on mixed-mode since forever so likely no-one is using it:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   .../firmware/efi/libstub/efi-stub-helper.c    | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 0f3dbfed6306..f1f316e96819 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -353,7 +353,12 @@ void efi_free(efi_system_table_t *sys_table_arg, unsigned long size,
>   {
>   	unsigned long nr_pages;
>   
> -	if (!size)
> +	/*
> +	 * Mixed mode does not support calling firmware routines that take
> +	 * explicit 64-bit wide arguments. So all we can do is leak the
> +	 * allocation.
> +	 */
> +	if (!size || (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_is_64bit()))
>   		return;
>   
>   	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
> @@ -536,6 +541,18 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
>   	char *str;
>   	int i, j, k;
>   
> +	/*
> +	 * Using firmware services to load files is not supported in mixed mode
> +	 * systems, because it involves calling functions that have 64-bit wide
> +	 * parameters in their prototypes, which are not marshalled correctly
> +	 * by the thunking code.
> +	 */
> +	if (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_is_64bit()) {
> +		pr_efi(sys_table_arg,
> +		       "Ignoring file= arguments on mixed mode system\n");
> +		return EFI_SUCCESS;
> +	}
> +
>   	file_addr = 0;
>   	file_size_total = 0;
>   
> 

