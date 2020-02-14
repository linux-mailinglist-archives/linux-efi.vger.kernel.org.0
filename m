Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DF15D7CF
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2020 13:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgBNM4A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Feb 2020 07:56:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729246AbgBNMz7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Feb 2020 07:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581684958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uc3HW2s+A+nqIINnkUywDqrVNge9+qWZZoEL5muBZk8=;
        b=J5P0Kb3ZNuVzJmkLCd71hNKJQs9TCtlZJ+ZBzh0x3raVRNW66/xv95dASUcKoxnuRI5vhj
        83d0EbtYBgNqCxnfxjjSUKz0HIilMDeB8MezhQEToi+JMLAp4mnAZuT0cgOmbyXBXelQgy
        wdl2XoCECYfXB3OkPuRUpMmr2exD/78=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-mJssFp7lN2yTMIQMzyDZDA-1; Fri, 14 Feb 2020 07:55:57 -0500
X-MC-Unique: mJssFp7lN2yTMIQMzyDZDA-1
Received: by mail-wm1-f72.google.com with SMTP id w12so3424117wmc.3
        for <linux-efi@vger.kernel.org>; Fri, 14 Feb 2020 04:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uc3HW2s+A+nqIINnkUywDqrVNge9+qWZZoEL5muBZk8=;
        b=EthfLnjCSxtW0VZZGr4543JurPHLgrEXFM02hzhzXnT9r9mj5Uvcdus9Q7GJidGQ3q
         bLTCn4IfnZ4tKpM5CWJRgKvzQ4FptRPnlzBXsybco1nmfY96hFqcRBCcbw0WNBYR7lil
         CcCb3xpi2lE2YMmOqSuNbTxbM5EPSD3FzCuYRiwHQYLSubYcp+cQd84h3MDyxQegDXcN
         URHbba+YINo5POeDLqy5vMWpO3IMCzA/NW96LZ4IKl7GhXxvsPnHzgopwVpykzc+tFH+
         15QDQ5BeKTaPrydYy2FwXiH/ikP3NGydFcfbzuc89bogTJLpHcNE5vN/hhUTTUcuOeqz
         fMng==
X-Gm-Message-State: APjAAAVsx/Ju/plZfPe+2vCQ6PZVJsDKggygqQ5U3oCyHZnuCyN54583
        xkfWQnLvLaK6FzekRp4f8bcCukvnWowa3mP7O9zuSYcCcC+E+3vB9eH3y7i3KUOdhkUfJWVS94/
        llDCNmFKsPwR9p9LNqMpk
X-Received: by 2002:a1c:2786:: with SMTP id n128mr4455355wmn.47.1581684955563;
        Fri, 14 Feb 2020 04:55:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJ6dvguYXFYFq96vqiRZFwGNHeGVjRgPK/bC89iqapMziKQFFp8Uw7XnFd8uosFfP3sdpKzg==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr4455343wmn.47.1581684955339;
        Fri, 14 Feb 2020 04:55:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id e22sm7481102wme.45.2020.02.14.04.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 04:55:54 -0800 (PST)
Subject: Re: [PATCH 1/3] efi/x86: align GUIDs to their size in the mixed mode
 runtime wrapper
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@amacapital.net>
References: <20200213102102.30170-1-ardb@kernel.org>
 <20200213102102.30170-2-ardb@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <116eb62a-8067-b4f1-171a-2659bcaa94bf@redhat.com>
Date:   Fri, 14 Feb 2020 13:55:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213102102.30170-2-ardb@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 2/13/20 11:21 AM, Ard Biesheuvel wrote:
> The mixed mode runtime wrappers are fragile when it comes to how the
> memory referred to by its pointer arguments are laid out in memory,
> due to the fact that it translates these addresses to physical addresses
> that the runtime services can dereference when running in 1:1 mode.
> 
> As a quick (i.e., backportable) fix, copy GUID pointer arguments to
> the local stack into a buffer that is naturally aligned to its size,
> so that is guaranteed to cover only one physical page.
> 
> Note that on x86, we cannot rely on the stack pointer being aligned
> the way the compiler expects, so we need to allocate an 8-byte aligned
> buffer of sufficient size, and copy the GUID into that buffer at an
> offset that is aligned to 16 bytes.
> 
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I can confirm that this fixes the WARN_ON triggering I was seeing,
thanks:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   arch/x86/platform/efi/efi_64.c | 25 ++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index fa8506e76bbe..543edfdcd1b9 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -658,6 +658,8 @@ static efi_status_t
>   efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
>   		       u32 *attr, unsigned long *data_size, void *data)
>   {
> +	u8 buf[24] __aligned(8);
> +	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
>   	efi_status_t status;
>   	u32 phys_name, phys_vendor, phys_attr;
>   	u32 phys_data_size, phys_data;
> @@ -665,8 +667,10 @@ efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
>   
>   	spin_lock_irqsave(&efi_runtime_lock, flags);
>   
> +	*vnd = *vendor;
> +
>   	phys_data_size = virt_to_phys_or_null(data_size);
> -	phys_vendor = virt_to_phys_or_null(vendor);
> +	phys_vendor = virt_to_phys_or_null(vnd);
>   	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
>   	phys_attr = virt_to_phys_or_null(attr);
>   	phys_data = virt_to_phys_or_null_size(data, *data_size);
> @@ -683,14 +687,18 @@ static efi_status_t
>   efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>   		       u32 attr, unsigned long data_size, void *data)
>   {
> +	u8 buf[24] __aligned(8);
> +	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
>   	u32 phys_name, phys_vendor, phys_data;
>   	efi_status_t status;
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&efi_runtime_lock, flags);
>   
> +	*vnd = *vendor;
> +
>   	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
> -	phys_vendor = virt_to_phys_or_null(vendor);
> +	phys_vendor = virt_to_phys_or_null(vnd);
>   	phys_data = virt_to_phys_or_null_size(data, data_size);
>   
>   	/* If data_size is > sizeof(u32) we've got problems */
> @@ -707,6 +715,8 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
>   				   u32 attr, unsigned long data_size,
>   				   void *data)
>   {
> +	u8 buf[24] __aligned(8);
> +	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
>   	u32 phys_name, phys_vendor, phys_data;
>   	efi_status_t status;
>   	unsigned long flags;
> @@ -714,8 +724,10 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
>   	if (!spin_trylock_irqsave(&efi_runtime_lock, flags))
>   		return EFI_NOT_READY;
>   
> +	*vnd = *vendor;
> +
>   	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
> -	phys_vendor = virt_to_phys_or_null(vendor);
> +	phys_vendor = virt_to_phys_or_null(vnd);
>   	phys_data = virt_to_phys_or_null_size(data, data_size);
>   
>   	/* If data_size is > sizeof(u32) we've got problems */
> @@ -732,14 +744,18 @@ efi_thunk_get_next_variable(unsigned long *name_size,
>   			    efi_char16_t *name,
>   			    efi_guid_t *vendor)
>   {
> +	u8 buf[24] __aligned(8);
> +	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
>   	efi_status_t status;
>   	u32 phys_name_size, phys_name, phys_vendor;
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&efi_runtime_lock, flags);
>   
> +	*vnd = *vendor;
> +
>   	phys_name_size = virt_to_phys_or_null(name_size);
> -	phys_vendor = virt_to_phys_or_null(vendor);
> +	phys_vendor = virt_to_phys_or_null(vnd);
>   	phys_name = virt_to_phys_or_null_size(name, *name_size);
>   
>   	status = efi_thunk(get_next_variable, phys_name_size,
> @@ -747,6 +763,7 @@ efi_thunk_get_next_variable(unsigned long *name_size,
>   
>   	spin_unlock_irqrestore(&efi_runtime_lock, flags);
>   
> +	*vendor = *vnd;
>   	return status;
>   }
>   
> 

