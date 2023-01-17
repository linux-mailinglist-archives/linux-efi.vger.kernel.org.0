Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0266D86F
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjAQIms (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 03:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbjAQImq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 03:42:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7C2CFE0;
        Tue, 17 Jan 2023 00:42:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r30so5354510wrr.10;
        Tue, 17 Jan 2023 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgdFG0TckMNNtSrMy3gzQpNweLlGgAmlRt/iXd54yE0=;
        b=nTvxXqXF+OTl+nZ4SQJQp1kdtrb7VRE2jEfuP1rSxga5U9lbjSmzu2/eONA2xCo8sy
         3ab5qp4NIaAxf+bbUjVL5A2MZbKVQ7jtMp2RU8XE8GGscq5WEBjzxLlIM90cnu7s2v+d
         1QVtEAj8k8i+LTQhFjp8FYIATzrxlAdBrIfqtUySTRTel+YCJUFd3X0EZViNCTTZ3c79
         afnXxirAzLqteFVUH9mpjdrhqSZ59Cofsjpnv+3G7BmMA8B6Du4vaBfI/XbmXH/nDR21
         oggECKb40T8uVGos0DNVJqUj/AnK+34vpRBYdA1ENtZnrzW1MzpRFUDkcmh0MZD6lLoZ
         +rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgdFG0TckMNNtSrMy3gzQpNweLlGgAmlRt/iXd54yE0=;
        b=dzUm3GwWO90ommqcm9hv3AOCe9nZJZbv4CVCzo62mwuAgUTDbvc5EZN2aE3Z7CKrmP
         bAPDMIJSB4N6oJNrAvykrfU5TfQ4qOUDMA8Z/nNLDX6yrgYEMtvrJNA+P7zpplNnrQ1G
         9icpkwLfBTew7xgw7SHNUImfrYIgrXgFWLZQAVXXY2HQW997l15dKFz4F0Ws3m7Fdx4i
         zKtacy8jeXrsLJ25H5yyfWZ8kzu/9AOalSfCuYYBqSfoY8YRHRs4qorQe1aN5dZxqEB9
         hEZtgjMDzJAdvXMfuHYpniExgsTqwCcjaiR3px3G2An9cKIG9u0CjHf3ypEuHGX6T+47
         hmnw==
X-Gm-Message-State: AFqh2kqYen609CPRQq4/5hfboxEbzZ8KDQO2M5jfFeo9pGrfaifbChDV
        Vl1mgFiGkjNCPqjg7Dq+EBw=
X-Google-Smtp-Source: AMrXdXtShFi7g5M0+i35bby1+o6PPYiAiyxYRzenLTwkiB1lrFf0uhSPMYP5qNW4Ccc41g3ITBLDQg==
X-Received: by 2002:a5d:6a51:0:b0:2bb:e7ac:af73 with SMTP id t17-20020a5d6a51000000b002bbe7acaf73mr2327828wrw.42.1673944963342;
        Tue, 17 Jan 2023 00:42:43 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3141.dip0.t-ipconnect.de. [217.234.49.65])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d526e000000b0028e55b44a99sm10584676wrc.17.2023.01.17.00.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 00:42:42 -0800 (PST)
Message-ID: <2107892a-0b9c-cb30-312a-54e4d8702e1f@gmail.com>
Date:   Tue, 17 Jan 2023 09:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] firmware: Add support for Qualcomm UEFI Secure
 Application
To:     Johan Hovold <johan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-4-luzmaximilian@gmail.com>
 <Y8ZbN5LNn2fk0/xi@hovoldconsulting.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <Y8ZbN5LNn2fk0/xi@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/17/23 09:24, Johan Hovold wrote:
> On Sun, Jul 24, 2022 at 12:49:48AM +0200, Maximilian Luz wrote:
>> On platforms using the Qualcomm UEFI Secure Application (uefisecapp),
>> EFI variables cannot be accessed via the standard interface in EFI
>> runtime mode. The respective functions return EFI_UNSUPPORTED. On these
>> platforms, we instead need to talk to uefisecapp. This commit provides
>> support for this and registers the respective efivars operations to
>> access EFI variables from the kernel.
>>
>> Communication with uefisecapp follows the standard Qualcomm Trusted
>> Environment (TEE or TrEE) / Secure OS conventions via the respective SCM
>> call interface. This is also the reason why variable access works
>> normally while boot services are active. During this time, said SCM
>> interface is managed by the boot services. When calling
>> ExitBootServices(), the ownership is transferred to the kernel.
>> Therefore, UEFI must not use that interface itself (as multiple parties
>> accessing this interface at the same time may lead to complications) and
>> cannot access variables for us.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
> 
>> +static struct platform_driver qcom_uefisecapp_driver = {
>> +	.probe = qcom_uefisecapp_probe,
>> +	.remove = qcom_uefisecapp_remove,
>> +	.driver = {
>> +		.name = "qcom_tee_uefisecapp",
>> +		.of_match_table = qcom_uefisecapp_dt_match,
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +};
>> +module_platform_driver(qcom_uefisecapp_driver);
> 
> I noticed that for efivarfs to work, you're currently relying on having
> the firmware still claim that the variable services are supported in the
> RT_PROP table so that efi core registers the default ops at subsys init
> time (which are later overridden by this driver).
> 
> Otherwise efivarfs may fail to initialise when built in:
> 
> 	static __init int efivarfs_init(void)
> 	{
> 		if (!efivars_kobject())
> 			return -ENODEV;
> 
> 		return register_filesystem(&efivarfs_type);
> 	}
> 
> 	module_init(efivarfs_init);
> 
> With recent X13s firmware the corresponding bit in the RT_PROP table has
> been cleared so that efivarfs would fail to initialise. Similar problem
> when booting with 'efi=noruntime'.
> 
> One way to handle this is to register also the qcom_uefisecapp_driver at
> subsys init time and prevent it from being built as a module (e.g. as is
> done for the SCM driver). I'm using the below patch for this currently.
> 
> I guess the Google GSMI implementation suffers from a similar problem.

Oh right, thanks for that tip!

I'll try to include that in v2 then. I'll also try to test that case
specifically.

Regards,
Max

>  From 8fecce12d215bd8cab1b8c8f9f0d1e1fe20fe6e7 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan+linaro@kernel.org>
> Date: Sun, 15 Jan 2023 15:32:34 +0100
> Subject: [PATCH] firmware: qcom_tee_uefisecapp: register at subsys init
> 
> Register efivars at subsys init time so that it is available when
> efivarfs probes. For the same reason, also prevent building the driver
> as a module.
> 
> This is specifically needed on platforms such as the Lenovo Thinkpad
> X13s where the firmware has cleared the variable services in the RT_PROP
> table so that efi core does not register any efivar callbacks at subsys
> init time (which are later overridden).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/firmware/Kconfig               | 2 +-
>   drivers/firmware/qcom_tee_uefisecapp.c | 7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 4e9e2c227899..48e712e363da 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -231,7 +231,7 @@ config QCOM_TEE
>   	select QCOM_SCM
>   
>   config QCOM_TEE_UEFISECAPP
> -	tristate "Qualcomm TrEE UEFI Secure App client driver"
> +	bool "Qualcomm TrEE UEFI Secure App client driver"
>   	select QCOM_TEE
>   	depends on EFI
>   	help
> diff --git a/drivers/firmware/qcom_tee_uefisecapp.c b/drivers/firmware/qcom_tee_uefisecapp.c
> index 65573e4b815a..e83bce4da70a 100644
> --- a/drivers/firmware/qcom_tee_uefisecapp.c
> +++ b/drivers/firmware/qcom_tee_uefisecapp.c
> @@ -754,7 +754,12 @@ static struct platform_driver qcom_uefisecapp_driver = {
>   		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   	},
>   };
> -module_platform_driver(qcom_uefisecapp_driver);
> +
> +static int __init qcom_uefisecapp_init(void)
> +{
> +	return platform_driver_register(&qcom_uefisecapp_driver);
> +}
> +subsys_initcall(qcom_uefisecapp_init);
>   
>   MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
>   MODULE_DESCRIPTION("Client driver for Qualcomm TrEE/TZ UEFI Secure App");
