Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031756729A3
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 21:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjARUpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 15:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjARUpX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 15:45:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A055F3AC;
        Wed, 18 Jan 2023 12:45:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk16so35187427wrb.11;
        Wed, 18 Jan 2023 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgIgSN11rEd8/t7p92lzCdZRCM1txWSCMaslInNbKCo=;
        b=c0vu0i0WjNE2ZEaE4AK/7wjM7vXc9Hah4fdN6SqEkrSy/kAMPhVrwsffQmrdNGQl5l
         GFbQW7t0/oXXHXUgeSx6yzAGFXwURiTmJKSnQgCFyygDeXoCOr3eySU+kqhfnwqTrZRE
         7esI7IfQlxzPF36qE9WGQvM023KOLBSiYG/cCpmCBbBx2ckzjHKP+eE3pBCewXSJv7eP
         enf3YAfWjozH4Zq4+GZD7RwFvuCJv4C/EQBBUMMDKEX+9R1nPcp3wmMY08yYkWA14XGv
         eGkJvfDlLlSetrbW4C+Y9oUL3yX9HUnz4ySsHhboWxcLZUV+JmT9cBm3+Ro+s/FlDD8x
         87CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgIgSN11rEd8/t7p92lzCdZRCM1txWSCMaslInNbKCo=;
        b=iZyjLSZRAYr09/uJ9pdpGrX/mybM7EgW2DxCf+dPrVxO8apcpr3j34w8xshzCqj1UD
         uWeOyPCLzIOUOkDFEUEYTK0w++cv82HP071g3AFbNBsyQ4j+8AfviRYtlQ4OtSI+pNCK
         wbxovAlEBHxPcY9pDGTa3A+molZnvGKOfTJsZJZ9ka8wrkuovOavz5sFK7FfQQEAw4e7
         foVFFZthWVGdfsx/y1lQnjOQdSNkL112f01k7EPKlJb+XMjM6ihS++/PQbO+b7egyQ5b
         f/kmb3sU9NUYvSMiVig7Tj4/T6opfVDru0KxbNR7NeE8eJbi9wf6t+ao5SwHccS09DWe
         ml9g==
X-Gm-Message-State: AFqh2kq8xDwn/IF3PGyTC12M2al6ouPLFwwB2gMdvi+qHwIo51AcOblL
        3tWtZsRDcaBS9qDZ2ls4pZ4=
X-Google-Smtp-Source: AMrXdXuhv4CroI7UB3QJWrNv2/LetE7M7cz5upNyBmPvrGLBiJvq45o0CFeb+Rdnys9W28IJQzmXlA==
X-Received: by 2002:adf:ed0c:0:b0:2be:f21:6b02 with SMTP id a12-20020adfed0c000000b002be0f216b02mr7175864wro.70.1674074720705;
        Wed, 18 Jan 2023 12:45:20 -0800 (PST)
Received: from [10.27.0.4] ([217.138.207.228])
        by smtp.gmail.com with ESMTPSA id by12-20020a056000098c00b002bdd8f12effsm16743332wrb.30.2023.01.18.12.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 12:45:20 -0800 (PST)
Message-ID: <2b0fdc2d-6457-059b-bbdf-27e7de59abeb@gmail.com>
Date:   Wed, 18 Jan 2023 21:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
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

So I've had another look and I'm not sure this will work reliably:

First, you are correct in case the RT_PROP table is cleared. In that
case, using subsys_initcall() will move the efivar registration before
the efivarfs_init() call.

However, in case EFI indicates support for variables, we will then have
generic_ops_register() and the uefisecapp's driver call running both in
subsys_initcall(). So if I'm not mistaken, this could cause the generic
ops to be registered after the uefisecapp ones, which we want to avoid.

One solution is bumping uefisecapp to fs_initcall(). Or do you have any
other suggestions?

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
