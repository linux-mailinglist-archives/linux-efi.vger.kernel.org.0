Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9B44D27C
	for <lists+linux-efi@lfdr.de>; Thu, 11 Nov 2021 08:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhKKHeF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Nov 2021 02:34:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhKKHeE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Nov 2021 02:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636615875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYQEw5GVtmhIImAbCeB41t1wheO6mxsaCZLTEEKlNIY=;
        b=PM1u03IepqiSYIaUbg7hJZ9CQJJBbWvS4ihd8QgNNEJrFICkoYvnRz69d70Dk1/zSqw5z0
        xW4XgMBYh7mlkNDbCqXqAgwl1tModw3tDFVrPMAmRmwGWUHXRYMpaPay9w5Y7zwfxcAVL3
        DwcVbc+l0DvetzkdBUCM28Fl4TBky7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-snjhYiAyPJWYI_1GLGJ85A-1; Thu, 11 Nov 2021 02:31:14 -0500
X-MC-Unique: snjhYiAyPJWYI_1GLGJ85A-1
Received: by mail-wr1-f70.google.com with SMTP id u4-20020a5d4684000000b0017c8c1de97dso830349wrq.16
        for <linux-efi@vger.kernel.org>; Wed, 10 Nov 2021 23:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZYQEw5GVtmhIImAbCeB41t1wheO6mxsaCZLTEEKlNIY=;
        b=S/RndYR2NNC8nfRpjNpjLCMc9CV8C4euY3iUx7zrtDa+m4Ltw6KmeHQNwi1WXq5fYR
         pOeJ4jXxPqk3zSS7Ybd+bQ9Mam7N1uIErb7fKgYbY8GiR6mxmFH3+8SdwUp7RxudQbEI
         waN4/d9aDq0iLHcI27ZEdF+VER9SQkYyyfnm7YI7t4e9WX5k9Eb7lfdinXUE4dJJw/8t
         i5X6Am6qzf+vDjXpOf+LwntgbU58Q8WRBZ87j5raB6LNLKgzyy7DljZIGXtO+VtIhX/C
         s7L5hEXBubaGy6Ad3VJF2dXaWdD1mdAqKJvYmANH+QfyDWjZv7IoWo5/VkkA6sGrRDFk
         fk2w==
X-Gm-Message-State: AOAM531rLLCDD7N0i6jLFW6AaRces4PP+Vr3h0Luae4y6uZpUO5C+tK5
        eDJDX6FVkjjq67QTgd0h1wZiHppVC7cn598+oYZhMCAWuwpFUr3829ZqFqkMDECFBD754cou7Kf
        OiCnR0qp+09dlIMQObIlb
X-Received: by 2002:adf:ee04:: with SMTP id y4mr6361295wrn.0.1636615873229;
        Wed, 10 Nov 2021 23:31:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1JLpDvD1ipMwjqp3XjHqiTZwSRafDcbKcys/CZyMEO92UHHU3jo67AkcjMz8ueVY4Z8KreA==
X-Received: by 2002:adf:ee04:: with SMTP id y4mr6361266wrn.0.1636615873037;
        Wed, 10 Nov 2021 23:31:13 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h1sm1962703wmb.7.2021.11.10.23.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 23:31:12 -0800 (PST)
Message-ID: <af0552fb-5fb5-acae-2813-86c32e008e58@redhat.com>
Date:   Thu, 11 Nov 2021 08:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [REGRESSION]: drivers/firmware: move x86 Generic System
 Framebuffers support
Content-Language: en-US
To:     Ilya Trukhanov <lahvuun@gmail.com>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-pm@vger.kernel.org,
        tzimmermann@suse.de, ardb@kernel.org, rafael@kernel.org,
        len.brown@intel.com, pavel@ucw.cz,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20211110200253.rfudkt3edbd3nsyj@lahvuun>
 <627b6cd1-3446-5e55-ea38-5283a186af39@redhat.com>
 <20211111004539.vd7nl3duciq72hkf@lahvuun>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211111004539.vd7nl3duciq72hkf@lahvuun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ilya,

On 11/11/21 01:45, Ilya Trukhanov wrote:

[snip]

>> Can you please share the kernel boot log for any of these cases too ?
>

Thanks a lot for the testing and providing the info!
 
>> This is just a guess though. Would be good if you could test following cases:
>>
>> 1) CONFIG_FB_EFI not set
> 
> /proc/fb:
> 0 amdgpu
> 
> dmesg: https://pastebin.com/c1BcWLEh
> 
> Suspend-to-RAM works.
> 
>> 2) CONFIG_FB_EFI=y and CONFIG_DRM_AMDGPU=m
> 
> /proc/fb before `modprobe amdgpu`:
> 0 EFI VGA
> 
> after:
> 0 amdgpu
> 
> dmesg: https://pastebin.com/vSsTw2Km
> 
> Suspend-to-RAM works.
> 
>> 3) CONFIG_SYSFB_SIMPLEFB=y and CONFIG_FB_SIMPLE=y
> 
> /proc/fb:
> 0 amdgpu
> 1 simple
> 
> dmesg: https://pastebin.com/ZSXnpLqQ
> 
> Suspend-to-RAM fails.
> 
>>
>> And for each check /proc/fb, the kernel boot log, and if Suspend-to-RAM works.
>>
>> If the explanation above is correct, then I would expect (1) and (2) to work and
>> (3) to also fail.
>>

Your testing confirms my assumptions. I'll check how this could be solved to
prevent the efifb driver to be probed if there's already a framebuffer device.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

