Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAC582559
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jul 2022 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiG0LYr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jul 2022 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiG0LYr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jul 2022 07:24:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5DE326EC
        for <linux-efi@vger.kernel.org>; Wed, 27 Jul 2022 04:24:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u17so9312383lji.5
        for <linux-efi@vger.kernel.org>; Wed, 27 Jul 2022 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QfNI9S8iAQB3LbkapZoXxskcLzEsEgFs5Xu90Ufn+Fo=;
        b=tLTwBrMrF6ZS8ik80Si/OmDvu2C+ACrn00QzA+SHTgCNnCu24AizmIdW0qfLIZnvqw
         XOxnokUx1AjBV7+Ln9RIx7ab52h1FhqKU9+O8NYOf//iuE28seLWFh+oY4hECNAOBmLI
         mP0JF0TP9wjdNJ1YIv8AHv9qst1btVxwMoOuf5pthMgC50260mj8DxzMfSkYpFj//sbv
         j2GwvZjGkjkjqJDffjqTbwO4ddajYjjbHNMSpoelJ1BZXSw31CT8mPXlEUGDDjHrGa7F
         sY+IzGh0LwYxuhTm4rpx5IWyBKqdpLOzc+HSZwuG0PVjPySaYGmNulhyUcx+ZD4fPxP/
         GulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QfNI9S8iAQB3LbkapZoXxskcLzEsEgFs5Xu90Ufn+Fo=;
        b=MBYQu5DLqqlnPILOXUi86Hetpi/EGkeo6hSGFSdsTCr9NovrsUop3U9V802vyBVcb5
         t2IMvItprPIPckBrF4d+rIjFoQs+7OmgbYkYtrC/ZrVXAIIG2ZpuyF06D75Rkq8qv49F
         0JWne50mLk//zBN+ibQWe+EJbQLVCVDtLwTNnzUM8w9MlFfsiB2qb9nYNW1+eZdydedG
         CZKwxhVO3BoZtoHQ4mG0sbCkYYrdsFaJTdvUHu4zD1+m2pl1Ce+wyCZHJ1BW3PfyS++t
         5xjGKzoSJveOvnD+i0Az20T0cJRUn61XENzchd28IbHn7j3cZZPFa0D/eJ+82IvPtRaI
         YMcA==
X-Gm-Message-State: AJIora+5VTE0ia0GtRo3dTYddCcuxx2AbDxuLfNRyYJ1Wll6dbxGmvzW
        Q6J2s4tGt7m5DEXmlYczq0rIfw==
X-Google-Smtp-Source: AGRyM1vtcQcNcjpFWkWLGED3KxqGPdePSivwwXGP8h+91ivZTdwqbIZvpu2UwagnsZ6t5n50ypIJBg==
X-Received: by 2002:a05:651c:897:b0:25d:e574:b64 with SMTP id d23-20020a05651c089700b0025de5740b64mr7547002ljq.203.1658921082750;
        Wed, 27 Jul 2022 04:24:42 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id be20-20020a05651c171400b0025bf58c5338sm3876300ljb.15.2022.07.27.04.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 04:24:42 -0700 (PDT)
Message-ID: <53a602e2-0590-6c6a-597b-fd55faa3a4ab@linaro.org>
Date:   Wed, 27 Jul 2022 13:24:40 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2e522bcd-5d55-e87f-126c-514f5edaa560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 26/07/2022 17:00, Maximilian Luz wrote:
> On 7/26/22 15:25, Krzysztof Kozlowski wrote:
>> On 26/07/2022 13:15, Maximilian Luz wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: qcom,tee-uefisecapp
>>>>
>>>> Isn't this SoC-specific device? Generic compatibles are usually not
>>>> expected.
>>>
>>> This is essentially software (kernel driver) talking to software (in the
>>> TrustZone), so I don't expect there to be anything SoC specific about it.
>>
>> You are documenting here firmware in TZ (not kernel driver). Isn't this
>> a specific piece which might vary from device to device?
>>
>> IOW, do you expect the same compatible to work for all possible Qualcomm
>> boards (past and future like in 10 years from now)?
> 
> I'm not sure if Qualcomm will still use the "uefisecapp" approach in 10
> years, but I don't expect the interface of uefisecapp to change. The
> interface is modeled after the respective UEFI functions, which are spec
> and thus I don't expect those to change. Also, it seems to have been
> around for a couple of generations and it hasn't changed. The oldest
> tested is sdm850 (Lenovo Yoga C630), and the latest is sc8280xp
> (Thinkpad X13s).

Expectation is not the same as having a specification saying it will not
change.
> 
> Why not make this behave like a "normal" third-party device? If the
> interface ever changes use qcom,tee-uefisecapp-v2 or something like
> that? Again, this does not seem to be directly tied to the SoC.

Such approach is not "normal" for third-party devices. Compatible for
devices has model number. If the block has specification, then v2 would
have sense, otherwise you would invent own versioning...

I would say that firmware implementation can easily change. How much of
your code is tied to it, I don't know, but argument "I don't expect
Qualcomm to change something in their firmware" is not the correct argument.

> 
> Then again, if you prefer to name everything based on
> "qcom,<device>-<soc>" I don't have any strong arguments against it and
> I'm happy to change that. I just think it will unnecessarily introduce
> a bunch of compatibles and doesn't reflect the interface "versioning"
> situation as I see it.

Why bunch? All devices could bind to one specific compatible, as they
are compatible.

> 
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    firmware {
>>>>> +        scm {
>>>>> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
>>>>> +        };
>>>>> +        tee-uefisecapp {
>>>>> +            compatible = "qcom,tee-uefisecapp";
>>>>
>>>> You did not model here any dependency on SCM. This is not full
>>>> description of the firmware/hardware
>>>
>>> How would I do that? A lot of other stuff also depends on SCM being
>>> present (e.g. qcom_q6v5_pas for loading mdt files) and I don't see them
>>> declare this in the device tree. As far as I can tell, SCM is pretty
>>> much expected to be there at all times (i.e. can't be unloaded) and
>>> drivers check for it when probing via qcom_scm_is_available(),
>>> deferring probe if not.
>>
>> It seems this will be opening a can of worms...
> 
> Indeed.
> 
>> The problem with existing approach is:
>> 1. Lack of any probe ordering or probe deferral support.
>> 2. Lack of any other dependencies, e.g. for PM.
> 
> I'm not entirely sure what you mean by "lack of probe deferral support".
> We have qcom_scm_is_available() and defer probe if that fails. So
> deferral works, unless I'm misunderstanding something.

And how do you differentiate that qcom_scm_is_available() failed because
it is not yet available (defer probe) or it is broken and will never
load? All regular consumer-provider interfaces have it sorted out.

> 
> But yes, correct on the other points.
> 
>> Unloading is "solved" only by disallowing the unload, not by proper
>> device links and module get/put.
>>
>> I understand that SCM must be there, but the same for several other
>> components and for these others we have ways to pass reference around
>> (e.g. syscon regmap, PHYs handles).
>>
>>>
>>> Don't take this as an excuse as in "I want to leave that out", it's just
>>> that I don't know how one would declare such a dependency explicitly. If
>>> you can tell me how to fix it, I'll include that for v2.
>>
>> I think there are no dedicated subsystem helpers for this (like for
>> provider/consumer of resets/power domains/clocks etc), so one way would
>> be something like nvidia,bpmp is doing.
> 
> I assume you're referring to tegra_bpmp_get()? Does this correctly
> handle PM dependencies? At least as far as I can tell it doesn't
> explicitly establish a device link, it only gets a reference to the
> device, which doesn't guarantee the presence of a driver. Nor correct PM
> ordering. Please correct me if I'm wrong. As far as I know automatic
> creation of device links only works with certain props defined in
> of_supplier_bindings, right?

The Tegra choice is not complete, but it implements at least parts of it
and firmware dependencies are modeled in DTS. Other way would be to add
your device as child of SMC firmware and then you do not need bindings
at all...

> 
> So unless I'm wrong there is also a bunch of other stuff that may be
> subtly broken. (Again, not a justification to include these changes,
> just wondering whether there should be a conscious approach to find and
> fix these things... rather than discover them patch-by-patch).
> 
>> meson_sm_get is a bit similar - looking by compatible. This is less
>> portable and I would prefer the bpmp way (just like syscon phandles).
> 
> I have another example (that could be improved via a phandle in DT): For
> the Surface System Aggregator (in ACPI-land), we have ssam_client_bind().
> This function 1) checks if the controller is available and ready, 2) if
> it is gets a reference to it, and 3) establishes a device link for
> PM-ordering, before 4) returning the reference to that controller to the
> client. This combined with deferring probe ensures that we will always
> have a valid reference. And since we're in DT-land, we could hook that
> up with a phandle reference to SCM and load that instead of having to
> use a global static.

Yes, that's better example than Tegra BPMP.

>> The qcom_q6v5_pas could be converted later to use similar approach and
>> eventually the "tatic struct qcom_scm *__scm;" can be entirely removed.
>>
>> Any comments on this approach from Konrad, Bjorn, Dmitry, Vinod and
>> anyone else?
> 
> Regards,
> Max


Best regards,
Krzysztof
