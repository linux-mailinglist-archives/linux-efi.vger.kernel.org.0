Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A97697EFD
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 16:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBOPAF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBOO77 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 09:59:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6740F1
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676473136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCH9Ie5efCRLrr5Blktmi2E+S3guM/w0k32BhUsRy+Y=;
        b=NKpVcv29OZ6AA7+s0gXcz16Gv3NCvVhmkY1k9hgkL+qmaNVa3/hKd70NyV2IvmmAzO4yNw
        a6rBvmhIPKYZJXr9vBvzWZZ9OWgC9+NYjTUXnsJVhtk9wmyHguzKU9CExwLAgFowQ2zlCw
        fg+vOvjlI+DqlQ5vN4f03dnAHEOqACA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-b8STnJq_Pqu7cXOMIcu7Bg-1; Wed, 15 Feb 2023 09:58:55 -0500
X-MC-Unique: b8STnJq_Pqu7cXOMIcu7Bg-1
Received: by mail-ej1-f70.google.com with SMTP id re5-20020a170906d8c500b0087bd94a505fso4352596ejb.16
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCH9Ie5efCRLrr5Blktmi2E+S3guM/w0k32BhUsRy+Y=;
        b=Mjls8nHnU+8TOXVR9SqSUGoM468CEnaLLNxasDGs1xxe5FofZxXWbV97RCLFCyHiSj
         gu3tkDjGLgw6hOMG8Oe01p/9f3G0vftvuv6sjgutmmZ3v0ax6OQXxT8M+E/SCtq+tz8r
         XGbVqzZVR+0x3s79nafcbtbJxlmYPI2vkNzuBfOcv2eolJl1lUquVmQ66GJH59kgrIdr
         UZ3D6GvH046swJPLerJGMfr7kfpEGn/a8Wicwd+7gKgO9hTPSZJGYt43mhAh0WerQD2a
         D07Zpqv3Hlgd0KQ5zS+J2GLKlUR/yDBsI+pFfmbGSymnwBsfpw3YmNcI31/H+sAViFax
         UZgQ==
X-Gm-Message-State: AO0yUKWBaefWpc3xznU9ugbLJSawMVK4QjOmE1IEQBsETlibtYxst+5I
        AipDaBn57hLBEPXoibZkTiDO0/0V0RtKGL8x87sM+IaJ//gwAgEboylpTY+4ZPamGNoGAtD8STq
        dTKoczLTZzI6anY/EQjN0wlczvQ==
X-Received: by 2002:aa7:df99:0:b0:4ac:c5c1:e1ed with SMTP id b25-20020aa7df99000000b004acc5c1e1edmr2266488edy.12.1676473133216;
        Wed, 15 Feb 2023 06:58:53 -0800 (PST)
X-Google-Smtp-Source: AK7set9cvEwNt3/9YpvXvSuG9+rFV/ErMCKJwaLmjaNLeLFCyLw3vCllWqIS9G65SWj7rBRC9uYUPQ==
X-Received: by 2002:aa7:df99:0:b0:4ac:c5c1:e1ed with SMTP id b25-20020aa7df99000000b004acc5c1e1edmr2266475edy.12.1676473132969;
        Wed, 15 Feb 2023 06:58:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7cb08000000b004acd9a3afb3sm2760690edt.63.2023.02.15.06.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 06:58:52 -0800 (PST)
Message-ID: <fca0366b-fa32-b756-b149-876976f3a5da@redhat.com>
Date:   Wed, 15 Feb 2023 15:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad
 Duet 3
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>, ardb@kernel.org,
        linux-efi@vger.kernel.org, maxime@cerno.tech
References: <20230215115045.9396-1-darrell.kavanagh@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230215115045.9396-1-darrell.kavanagh@gmail.com>
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

On 2/15/23 12:50, Darrell Kavanagh wrote:
> Another Lenovo convertable which reports a landscape resolution of
> 1920x1200 with a pitch of (1920 * 4) bytes, while the actual framebuffer
> has a resolution of 1200x1920 with a pitch of (1200 * 4) bytes.
> 
> Signed-off-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> ---
> Changes in v2:
> 	- Improve commit message

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



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

