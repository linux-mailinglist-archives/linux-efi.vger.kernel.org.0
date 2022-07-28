Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541D5839CB
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiG1HsT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiG1HsT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 03:48:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B58A6170F
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 00:48:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y11so1658963lfs.6
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fCUzkrrVti+DuQ9YZ66uDbjkm2O9p7N93LSf/4Y1rqw=;
        b=FcT3HD9UuvhS0fZm//5zxRGb1EhPOh3t/FJB6OWvAfsVKWqT7XUYgKcSrCYv82NtFG
         clfqrKO3uRhEgTVGdRV1V/Xe87qmNqaL7fZmyIRmrY9XGSIyhZ7SLrWncsTLE+cVcS8o
         H2CbJ+ZeSA39R6hTegJnVjTAFXseAMScED4CPXt1byZYCJ75/2P7zx2EdpnwnvKy63Dw
         3RyTJxsZjPZIg3fKH3tvvgRXwYqcNg5JK/gdms/Kh5nLgVR9xwfrs5LpeyZSDRptlPOO
         jb3hFCCV2OvHbDPxfI5cOAV8yH4UC+1hD+WJIqhefTXbVk/6UM2RTuxQ6OssTd84hObL
         ok4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fCUzkrrVti+DuQ9YZ66uDbjkm2O9p7N93LSf/4Y1rqw=;
        b=JfGzz3XazDhbZNHfOiKZuR6XPTssYL++lPGl3ZLP1bgKTcmy1KJnAbzLhryOUFh23Z
         o8vI8kpBNuiS6GC6nl5OfB3AJ9Dj1hTFAXLNLhNrJsAoOM0bNRkQTnDkVzpYcVjzikBG
         5yzqajnu9kvqzv5cXevHCvbV/4OrUNi9is2Zg0Q/uO4mYkFb8MpqINWEn4Fpl+RsFPJI
         ojWwzjlN4M7/ngxHg2FTm1isqzFW48xzmWoCgkVMxzZJS/oieVql6LHZ8kLmj20q1emG
         TVQwssDn9pnnfnbZEL+vwsY9xLqHRWFuoJLWeXgspM+AkvC092gwTM/7HBvXT+4c+W8n
         lo8w==
X-Gm-Message-State: AJIora8JgMjtJJOC1BfhNm5+31GbJ6OfCjTIK0n938mUSimezEm3usUe
        OHq1gR4Nzh7TFvbc+1W/nGiDtQ==
X-Google-Smtp-Source: AGRyM1uXGhPeR606LsJssvTDJlC4T3k/CuVwOkQjtbV4yuWokpohwSrNa+3v0DyoVMsl7lRB4A4mrQ==
X-Received: by 2002:a05:6512:220a:b0:48a:7b14:d51c with SMTP id h10-20020a056512220a00b0048a7b14d51cmr8647513lfu.267.1658994495906;
        Thu, 28 Jul 2022 00:48:15 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b0048a7ebb3151sm68149lfb.181.2022.07.28.00.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 00:48:15 -0700 (PDT)
Message-ID: <95cbcda8-d1bc-376c-b338-92d1b923f04a@linaro.org>
Date:   Thu, 28 Jul 2022 09:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <e88d1036-dc58-3fc8-c388-edba9b2d62a7@linaro.org>
 <87c19c5a-d7f4-7183-1322-f62267e01b3b@gmail.com>
 <11e5c369-c0da-7756-b9e2-ac375dc78e9d@linaro.org>
 <2e522bcd-5d55-e87f-126c-514f5edaa560@gmail.com>
 <53a602e2-0590-6c6a-597b-fd55faa3a4ab@linaro.org>
 <acd7b231-3167-e35c-5cdf-8b3127a7d710@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <acd7b231-3167-e35c-5cdf-8b3127a7d710@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 27/07/2022 15:00, Maximilian Luz wrote:
>>> Then again, if you prefer to name everything based on
>>> "qcom,<device>-<soc>" I don't have any strong arguments against it and
>>> I'm happy to change that. I just think it will unnecessarily introduce
>>> a bunch of compatibles and doesn't reflect the interface "versioning"
>>> situation as I see it.
>>
>> Why bunch? All devices could bind to one specific compatible, as they
>> are compatible.
> 
> Ah, I think I misunderstood you there. I thought you were advocating for
> creating compatibles for each SoC just because it's a new SoC and things
> might be different. I'm not at all against naming this something like
> qcom,tee-uefisecapp-sc8180x then using that on all platforms that work.
> I just didn't like the idea of having a bunch of different
> qcom,tee-uefisecapp-<soc> pointing to the exact same thing without any
> difference at all.

You start with one specific compatible and if needed later either add
more specific upfront (qcom,sc8280x-tee-uefisecapp,
qcom,sc8180x-tee-uefisecapp) or as entirely new one if it is not compatible.

> 
>>>>>>> +
>>>>>>> +required:
>>>>>>> +  - compatible
>>>>>>> +
>>>>>>> +additionalProperties: false
>>>>>>> +
>>>>>>> +examples:
>>>>>>> +  - |
>>>>>>> +    firmware {
>>>>>>> +        scm {
>>>>>>> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
>>>>>>> +        };
>>>>>>> +        tee-uefisecapp {
>>>>>>> +            compatible = "qcom,tee-uefisecapp";
>>>>>>
>>>>>> You did not model here any dependency on SCM. This is not full
>>>>>> description of the firmware/hardware
>>>>>
>>>>> How would I do that? A lot of other stuff also depends on SCM being
>>>>> present (e.g. qcom_q6v5_pas for loading mdt files) and I don't see them
>>>>> declare this in the device tree. As far as I can tell, SCM is pretty
>>>>> much expected to be there at all times (i.e. can't be unloaded) and
>>>>> drivers check for it when probing via qcom_scm_is_available(),
>>>>> deferring probe if not.
>>>>
>>>> It seems this will be opening a can of worms...
>>>
>>> Indeed.
>>>
>>>> The problem with existing approach is:
>>>> 1. Lack of any probe ordering or probe deferral support.
>>>> 2. Lack of any other dependencies, e.g. for PM.
>>>
>>> I'm not entirely sure what you mean by "lack of probe deferral support".
>>> We have qcom_scm_is_available() and defer probe if that fails. So
>>> deferral works, unless I'm misunderstanding something.
>>
>> And how do you differentiate that qcom_scm_is_available() failed because
>> it is not yet available (defer probe) or it is broken and will never
>> load? All regular consumer-provider interfaces have it sorted out.
> 
> Fair point. By shifting that to device links you'll at least know what
> it's waiting for and the driver won't attempt to probe until that's
> resolved. But your question applies to that then as well: How do you
> differentiate between the device link or supplier being broken somehow
> and the supplier being just not ready yet?

For example like tegra_bpmp_get() is doing.

Best regards,
Krzysztof
