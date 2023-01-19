Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3575C673FC2
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjASRTd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 12:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjASRTc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 12:19:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306783DB;
        Thu, 19 Jan 2023 09:19:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n7so2552047wrx.5;
        Thu, 19 Jan 2023 09:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0JG+1+vzDx+1woc5zISYYnWWHU/+tyzkwsQk+BhPQ=;
        b=HiutLUBgPNKoinxepplGwduI4t+6YJl/44EjhVyhwpIefpMjkY/j8ZBxN0L/qgCKM1
         +ZQItAVsnNU27zgEcSz38sGnz3HBKHl5SSGgEJZNrzvOvBaHNO4YZ46BoYRs97u+qqET
         AXUrXtXaDbPLj6Z4yPBh6TyMdfk15W7KsJxFTu/StnAGeSatFGSw7yG6ULv8DvRVqhOh
         dlEV1pF/2wx2c90OAClSlkYyWqIvAdnm4LEMIYLHApBkS3fUTthqSWrqUrktb7yh5Jl6
         u548RE7aoOxW/JvzvLr98mkcgWDEDH951UpcS7jlPr3pVTMLaq7wuPVNfmTJCbX1R5WP
         Kz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0JG+1+vzDx+1woc5zISYYnWWHU/+tyzkwsQk+BhPQ=;
        b=MQiRTGJL75sIka8rFhxD3EsxIfvKWmaAWV9sj+6DTFUWuuoQo8fxwcYq3oPWTEXVI9
         W6oqOVKArmRhRFYXYpDLdxYxm3hyBKHK8FStj6ADpcbPlFy+LAbZf8QMJ/nFF2/vv1sd
         a6yT1oSiHxzQ+u31yi/AQ2n5EuI7L1tWxGR+FjiPWHSsf5SgODns8IJg13CjVPoY2dhK
         dQc3/kLwiEmTLGHHhP8DxRAvPFKumlWUafH6mfPXvNW1Dq74fVdLEJ4EZNlgj/X/+tw9
         jk+8FnUR08AvXn9kR7bIEWOLkbEorqVEK1l4ztaWBZ5XAqDt128QFbZJ4UzG2aIBqNyJ
         pTeQ==
X-Gm-Message-State: AFqh2kqQl6wqz8De6EgxIgvl+szzEMB7grMwZShcPOhLCnXaX59zgw5G
        jwGiXhQJUvRtiW2cs7Vs6yp6vWpDFWEajA==
X-Google-Smtp-Source: AMrXdXtnhhV23wxbkvJ5TPod11uXEnITyMWelsTKmu03NNRfq7qQeiDNNiw0jOxkg9PrVROMM2wAAg==
X-Received: by 2002:a5d:508f:0:b0:2bd:cb39:2ca3 with SMTP id a15-20020a5d508f000000b002bdcb392ca3mr6141237wrt.59.1674148769369;
        Thu, 19 Jan 2023 09:19:29 -0800 (PST)
Received: from [10.22.0.8] ([194.126.177.40])
        by smtp.gmail.com with ESMTPSA id q12-20020adff50c000000b002be25db0b7bsm6024396wro.10.2023.01.19.09.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:19:28 -0800 (PST)
Message-ID: <f68a5ca0-3c57-2655-59ec-1bcae8050153@gmail.com>
Date:   Thu, 19 Jan 2023 18:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] firmware: Add support for Qualcomm UEFI Secure
 Application
To:     Johan Hovold <johan@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Andy Gross <agross@kernel.org>,
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
 <2b0fdc2d-6457-059b-bbdf-27e7de59abeb@gmail.com>
 <Y8l0PdZlXLym//xS@hovoldconsulting.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <Y8l0PdZlXLym//xS@hovoldconsulting.com>
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

On 1/19/23 17:47, Johan Hovold wrote:
> On Wed, Jan 18, 2023 at 09:45:18PM +0100, Maximilian Luz wrote:
>> On 1/17/23 09:24, Johan Hovold wrote:
>>> On Sun, Jul 24, 2022 at 12:49:48AM +0200, Maximilian Luz wrote:
> 
>>>> +module_platform_driver(qcom_uefisecapp_driver);
>>>
>>> I noticed that for efivarfs to work, you're currently relying on having
>>> the firmware still claim that the variable services are supported in the
>>> RT_PROP table so that efi core registers the default ops at subsys init
>>> time (which are later overridden by this driver).
>>>
>>> Otherwise efivarfs may fail to initialise when built in:
>>>
>>> 	static __init int efivarfs_init(void)
>>> 	{
>>> 		if (!efivars_kobject())
>>> 			return -ENODEV;
>>>
>>> 		return register_filesystem(&efivarfs_type);
>>> 	}
>>>
>>> 	module_init(efivarfs_init);
>>>
>>> With recent X13s firmware the corresponding bit in the RT_PROP table has
>>> been cleared so that efivarfs would fail to initialise. Similar problem
>>> when booting with 'efi=noruntime'.
>>>
>>> One way to handle this is to register also the qcom_uefisecapp_driver at
>>> subsys init time and prevent it from being built as a module (e.g. as is
>>> done for the SCM driver). I'm using the below patch for this currently.
>>
>> So I've had another look and I'm not sure this will work reliably:
>>
>> First, you are correct in case the RT_PROP table is cleared. In that
>> case, using subsys_initcall() will move the efivar registration before
>> the efivarfs_init() call.
>>
>> However, in case EFI indicates support for variables, we will then have
>> generic_ops_register() and the uefisecapp's driver call running both in
>> subsys_initcall(). So if I'm not mistaken, this could cause the generic
>> ops to be registered after the uefisecapp ones, which we want to avoid.
> 
> Good catch, I was using 'efi=noruntime' on the CRD so I did not notice
> that race.
> 
>> One solution is bumping uefisecapp to fs_initcall(). Or do you have any
>> other suggestions?
> 
> I think it would be best to avoid that if we can, but that should work.
> 
> The problem here is that the firmware claims to support the EFI variable
> services even when it clearly does not and the corresponding callbacks
> just return EFI_UNSUPPORTED. As far as I understand, this is still spec
> compliant though so we just need to handle that.
> 
> One way to address this could be to have efi core not register the
> default efivars ops in this case. That would require checking that the
> services are indeed available by making one of those calls during
> initialisation.
> 
> This would however expose the fact that the Google SMI implementation
> implicitly relies on overriding the default ops, but I think that's a
> good thing as what we have now is racy in multiple ways.
> 
> Instead I think we should move the efivarfs availability check from
> module init to mount time. That should allow the Google driver, and your
> SCM implementation, to continue to be built as modules.
> 
> Any consumers (e.g. the Qualcomm RTC driver) would instead need to
> check if efivars is available or else defer probe.
> 
> Alternatively, it seems all efivars implementation would need to be
> always-built in which is not ideal for generic kernels.
> 
> I just posted a series here as food for thought:
> 
> 	https://lore.kernel.org/r/20230119164255.28091-1-johan+linaro@kernel.org

Thanks, I agree that those checks are probably the better option.

Regards,
Max
