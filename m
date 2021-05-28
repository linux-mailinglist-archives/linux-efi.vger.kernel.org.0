Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C5A393E5D
	for <lists+linux-efi@lfdr.de>; Fri, 28 May 2021 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhE1IEp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 May 2021 04:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhE1IEo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 May 2021 04:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622188989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IXbcSm8mT+lhuVdC+CT+mjkkm7+PBeCbiBVe/0dKys=;
        b=Hmqw1AX7S4zXvvDEq7bHmAyX0gvtM9YfkZOYDL0Mv6CnmA16va4hEKEh4/DTTx8wjAQDSO
        68OR8uw+M607F+nmDTTjpn5VWgQiJtp4fbpsk/5q7YzHn7CuoCyYmZLil7Nm4B+DJR6cXq
        pQx6k9qng0oApZpQE8HhGd7OsLs2h6o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-f1sxWlCgO8Ohk0fxeShpng-1; Fri, 28 May 2021 04:03:07 -0400
X-MC-Unique: f1sxWlCgO8Ohk0fxeShpng-1
Received: by mail-wm1-f69.google.com with SMTP id u203-20020a1cddd40000b029016dbb86d796so2328835wmg.0
        for <linux-efi@vger.kernel.org>; Fri, 28 May 2021 01:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0IXbcSm8mT+lhuVdC+CT+mjkkm7+PBeCbiBVe/0dKys=;
        b=QpiAT8xCy2mtmNnfmn33+xeeGJr03Qqg7Hg4XwvYDOVDPYD4NqEROsdRsUvdbQo4EE
         nsbDsZiEFvTMJCNTxF138F+93Rb9wudOoOYUS6125C+drITeOObY2NqCoFH0dghbxm5i
         JmpGNPvty6Jrz+4MGlPx1WPEtMJIBCGuHQFg2HVWdidS/hPX+R3+xq6scm/YK1TE6Dgf
         XkW009JPBrZw+gLfxrkqvIpoXLK7AcYlbS6XzEGlEOyzM5SlZQYr4uRo67wltrmvmBws
         RAq59n3Qz1xxHIgeJN/AnBhSnY4n2Ic1HQC24A1rsW7h99pjQhJVyFn18lcgCEieZ1uc
         GgUg==
X-Gm-Message-State: AOAM530+w2/U/AecjiAx4K2jrzqTVCOtIKFVtSRe6ca+egP3XXV3TRba
        YgbZDkeyBAvmahwLgCf37yTc81Qc5xyr7BZc5gRnWv1gMyVEdTgLPfJUPmDOQ5fIAIc71az+dOZ
        mrIplK6R0xW9b0Xlwo6pO
X-Received: by 2002:adf:fdce:: with SMTP id i14mr7029836wrs.303.1622188986614;
        Fri, 28 May 2021 01:03:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+e8iRBOPicMDS91UKoWmjw1Ow4Oln/9p2aaPMHWdMTZ3KKJsPjuaTgqaOu1DwibvjoXOU8Q==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr7029814wrs.303.1622188986368;
        Fri, 28 May 2021 01:03:06 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q20sm2949464wrf.45.2021.05.28.01.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 01:03:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] drivers/firmware: consolidate EFI framebuffer setup
 for all arches
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>, David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210521193704.3042024-1-javierm@redhat.com>
 <e23a44ba-5e9d-d27b-b5e8-0cce3b158ed7@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c6c6b686-6e13-2f1a-0310-b558428304c1@redhat.com>
Date:   Fri, 28 May 2021 10:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e23a44ba-5e9d-d27b-b5e8-0cce3b158ed7@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Thomas,

On 5/22/21 7:14 AM, Thomas Zimmermann wrote:

[snip]

>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -127,6 +127,7 @@ config ARM
>>   	select PERF_USE_VMALLOC
>>   	select RTC_LIB
>>   	select SET_FS
>> +	select SYSFB
> 
> Don't select this as part of the architecture. Rather make an option for 
> SYSFB that depends in the architectures that supports it.
>

Thanks a lot for the suggestion! I did this by making SYSFB's Kconfig option
to be default y and depends on the supported architectures as you mentioned.

This not only is a cleaner approach but also will allow to not touch all the
architectures platform code.

I'll wait for a few more days in case someone else has feedback and post a v2.
 
> Best regards
> Thomas
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

