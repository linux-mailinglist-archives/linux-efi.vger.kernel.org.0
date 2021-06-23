Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BA3B1893
	for <lists+linux-efi@lfdr.de>; Wed, 23 Jun 2021 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFWLP5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Jun 2021 07:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhFWLP5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Jun 2021 07:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jnl2/rIg/QPDzGy+KJkBUGcAxtR6X5tNt16GwqYV2Ik=;
        b=IKzGp+PW+29AoQ7FUcLGm6Jak7VGE8NY790c9GbmQJ69Uz9OWuMkTVLFVEiL0PiuWs4/Vl
        ZAzul1Za4VaPlzoCraoeFYQyOT7pk3LVoSdx5c4OujSHNF7drUiVWTTeu++G9NggFW04AM
        qPQY/2/6PgPOXh+9oaCbPj0eBpF+sJU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-grSXbBCAOmG6RqbCbCi-Gw-1; Wed, 23 Jun 2021 07:13:38 -0400
X-MC-Unique: grSXbBCAOmG6RqbCbCi-Gw-1
Received: by mail-wm1-f72.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so1467692wmq.0
        for <linux-efi@vger.kernel.org>; Wed, 23 Jun 2021 04:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jnl2/rIg/QPDzGy+KJkBUGcAxtR6X5tNt16GwqYV2Ik=;
        b=imd5peAZHcgLjtER1NzcnRprL1KNkIoiFAol15eYvGF6iv6ObcoNkvrUO8h1oiqGEV
         cbUcsQrJyoxhxijc1VHZ9/DLA8p8Hp4BReSz80cG/h0NhPBxmbMX3kbNLZvhMpdQP6KQ
         9I7dutZqYlOmvmpr3Bdf/2+sGeREO4WBnplKcr0mwemERMfoJLIJSoAh1aX7wApKx9OK
         arc2u7wuOtQ7H0h8MTjFytfnB3V0z2iSkb2PU7HEZb/cxhERtkj8WjcvTQEIsM4ljgW7
         y4wmUVp+kxS3h7NBXmg45jXln6SN2R0yDEntn8Q5ZObs+Bf2TONFf4VLz72s6Y3SGAj8
         EZdA==
X-Gm-Message-State: AOAM531nsCwqQvJKP3Wl18YymllWFwHkNfIRL/kQZ2IjGuohCqlUp1Uk
        Aam28lPbC/1tZu26fgOdEvcw9vF/8UcjSeIjVo4+am9fD7LHpopp18LZMqo+lRJVXYWThLH3yst
        ItAlADuOZz15iwHv0f4Vu
X-Received: by 2002:a1c:7510:: with SMTP id o16mr10132929wmc.137.1624446817643;
        Wed, 23 Jun 2021 04:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJwLzoKoz8r+R/xKXeF7Lx7jZ0y9cE2C6Y8Oc0j2T+kzzTfX0/iX0JS/L3nt4PZRaysvKkkQ==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr10132910wmc.137.1624446817467;
        Wed, 23 Jun 2021 04:13:37 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id i6sm2590861wro.12.2021.06.23.04.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 04:13:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] drivers/firmware: consolidate EFI framebuffer
 setup for all arches
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
References: <20210601150017.774363-1-javierm@redhat.com>
 <9700697f-747c-fe36-d480-69762e845f30@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <07745425-8d1b-5c0a-1622-cb08828d396c@redhat.com>
Date:   Wed, 23 Jun 2021 13:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9700697f-747c-fe36-d480-69762e845f30@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Thomas,

Thanks a lot for your feedback!

On 6/23/21 12:06 PM, Thomas Zimmermann wrote:

[snip]

>>   config SYSFB
>>   	bool
>>   	default y
>> -	depends on X86 || COMPILE_TEST
>> +	depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST
>>   
>> -config X86_SYSFB
>> +config SYSFB_SIMPLEFB
> 
> You should also update the help text for simpledrm to reflect this 
> change. See drivers/gpu/drm/tiny/Kconfig.
>

Indeed, I missed that. I'll update it in v3.

[snip]
 
>> +
>> +__init void sysfb_apply_efi_quirks(struct platform_device *pd)
>>   {
>>   	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
>>   	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
>> @@ -281,4 +348,10 @@ __init void sysfb_apply_efi_quirks(void)
>>   		screen_info.lfb_height = temp;
>>   		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
>>   	}
>> +
>> +	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
>> +	    IS_ENABLED(CONFIG_PCI)) {
> 
> We have a 100-character limit now. This should (?) fit onto a single line.
> 
> 

Oh, I didn't know the character limit was extended to 100 chars now.

[snip]

>>   
>>   	/* if the FB is incompatible, create a legacy framebuffer device */
>>   	if (si->orig_video_isVGA == VIDEO_TYPE_EFI)
>> -		name = "efi-framebuffer";
>> +		pd->name = "efi-framebuffer";
>>   	else if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
>> -		name = "vesa-framebuffer";
>> +		pd->name = "vesa-framebuffer";
>>   	else
>> -		name = "platform-framebuffer";
>> +		pd->name = "platform-framebuffer";
> 
> You're allocating the platform device with an empty name string. And 
> here you're overwriting the pointer. Can you rearrange the code to first 
> detect a proper name and then allocate the device with that name? It 
> takes a few bytes more memory, but seems in the spirit of the interface.
>

Right, I'll change that in v3 as well.
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

