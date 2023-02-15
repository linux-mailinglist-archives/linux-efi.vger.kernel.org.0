Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219AB6978AA
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjBOJJQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 04:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBOJJP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 04:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6034301
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 01:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676452110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ujNEG5DPcXCBA+yn0dWVmc1H8Bcp7aHqX7wDwtO/UQ=;
        b=O+fA01MPyknGt4vSRSxC1vIGn666BaxHIduMnpmeqGFsNlQw86ArguYHJ2IrlsoQVko10c
        BdIxWQ46WC/khwrYueP5XGj4bZAZX8N+ZN7gpWhplotC6rDMnxwVcEaNjTZtk4CPA6Xedk
        Gp6JiVd9f9AIq+vKl9zvyxujES7pyU4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-hoiKB7V3M6isM7M4JQ4Bdg-1; Wed, 15 Feb 2023 04:08:27 -0500
X-MC-Unique: hoiKB7V3M6isM7M4JQ4Bdg-1
Received: by mail-ej1-f70.google.com with SMTP id o5-20020a170906774500b008b1293861cdso3786262ejn.3
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 01:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ujNEG5DPcXCBA+yn0dWVmc1H8Bcp7aHqX7wDwtO/UQ=;
        b=RMtjN+UK2wH2dREj3sLaF9y3oQNdeHvQk4aCe5xuRUP/meYGWqJ+bFofJOGFlUaPyB
         UeWhh1EfKs0mk/XUFFsMYaGbmwblgAAI901ZlyNxJb0Ae+H9MpJFdnPvCWc6sikfA1Iz
         jUzhGX2GRlVH5foxbQ3SF9cGSi5X2u1N7vXEg0hhXOgynncPudj1rsFZrHmK9c/Dfy7L
         3GfCTfraFKQvmLcYkE0WUDoOKbjG2PrO1AQV8zGPKl8tYuFYzl14lNvJims24tM3FZfQ
         ogoD5/13vIYzcYwFQzz2z7riTHsKLHnPSdvyACm1E6n09Xye++yZbgNkJ0+avJ0WMybH
         9T9g==
X-Gm-Message-State: AO0yUKXP5oAdAjWoJiO0AyzZrXgGMQIp940fJiTYJ99LsBYtcmoGzxAY
        gY7Oh+MdVQz7lgfac6Ydw8deeUSaP3VgJBohT21+e3sRg6faL0GnvzySGKS16fRTGZ+FiIWD1Fk
        almwFL9kbnvOjBd/znbPX
X-Received: by 2002:a17:906:6d53:b0:872:27cb:9436 with SMTP id a19-20020a1709066d5300b0087227cb9436mr1435048ejt.43.1676452106548;
        Wed, 15 Feb 2023 01:08:26 -0800 (PST)
X-Google-Smtp-Source: AK7set/IQHnEbqGT8UnZD0/4Foss1DqegyWZ6AhLNj/Wc/9HSnGKnpsTqDLF4zyLTcA7wV+rkXWG+w==
X-Received: by 2002:a17:906:6d53:b0:872:27cb:9436 with SMTP id a19-20020a1709066d5300b0087227cb9436mr1435034ejt.43.1676452106365;
        Wed, 15 Feb 2023 01:08:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kq7-20020a170906abc700b008b12ffce953sm1973233ejb.131.2023.02.15.01.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 01:08:25 -0800 (PST)
Message-ID: <b9beba1e-abb4-f695-2a1c-313a6ece64ac@redhat.com>
Date:   Wed, 15 Feb 2023 10:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad Duet
 3
Content-Language: en-US, nl
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>, ardb@kernel.org,
        linux-efi@vger.kernel.org, maxime@cerno.tech
References: <20230214172716.4106-1-darrell.kavanagh@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230214172716.4106-1-darrell.kavanagh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 2/14/23 18:27, Darrell Kavanagh wrote:
> Another Lenovo convertable where the panel reports incorrect orientation
> to the kernel

For sysfb_efi.c the problem is not that it reports incorrect orientation
(efifb does not do anything with rotation) but that it reports the wrong
resolution and pitch.

It reports a landscape resolution of 1920x1200 with a pitch of (1920 * 4)
bytes. While the actual framebuffer has a resolution of 1200x1920 with
a pitch of (1200 * 4) bytes.

Can you please send a v2 with an updated commit message explaining this?

> Signed-off-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>

Note for v2 it is customary to add something like
the following after your S-o-b:

"""
---
Changes in v2:
- Improve commit message
"""

Regards,

Hans



> 
> ---
>  drivers/firmware/efi/sysfb_efi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 7882d4b3f2be..f06fdacc9bc8 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -264,6 +264,14 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>  					"Lenovo ideapad D330-10IGM"),
>  		},
>  	},
> +	{
> +		/* Lenovo IdeaPad Duet 3 10IGL5 with 1200x1920 portrait screen */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
> +					"IdeaPad Duet 3 10IGL5"),
> +		},
> +	},
>  	{},
>  };
>  

