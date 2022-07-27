Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE07582743
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jul 2022 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiG0NA4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jul 2022 09:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiG0NAx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jul 2022 09:00:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DFA237DC;
        Wed, 27 Jul 2022 06:00:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l4so2421763wrm.13;
        Wed, 27 Jul 2022 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fChMX8GlPFpKqzi4SSOEluwQflXzCDYt0HZSmFL88cw=;
        b=TI9dPJPm/HpiQsHlphg/YL2wRkFXK5o2L1VWNsm3YuOPu/uaeuXzWubEt1IJdi2YWh
         dLtqcluYdMGh1ni1LQ4u3BDGS1Mof7UsgbD9KZrw2bZE/Op8TnFaXoQdrYjzzTH3aE+O
         y3P1DADbJgqYfjwZWiK6F0NLcbGmsu3V2Kh2igJwVGH6LOFgrlTP9m4+y6N4cBrGe43m
         8CY0HT82y5VFAahtgyfvmWPk8KkSsrSMGAdRdsDchkY1c8fY7b0N8s5ySGaGoGV+vq5s
         uOy7Dd336WX4jG2uX9sIVfMSIlKbSiB4CkV8sqsOrcAe9AYVyXDPNcNwJSVN6EEd4926
         LkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fChMX8GlPFpKqzi4SSOEluwQflXzCDYt0HZSmFL88cw=;
        b=gT7/ocdnRgVNoVlpnRg3prTWC+IxibOHFxZeHV/BJqai2Aaf2i2pnwY9CLAEZcyUt7
         xVZlvJ6rciU5ZFjliwTJ4plzcoT4nlWo9McARrnbF4L8xMhpvbidzIs0ZBc5vklw4YpT
         vrA1WMwaWdgT5/BsQSVaARMUX1TFSJuVlPCuYZcdPtnkViuazQKblazXxfvgXUv1hGyA
         jMvWDvu1KPRUgwlcQYEWwFY05HfJnhGSlHUy85ffL4hYvlbB7VckXDII/UFX+urssww7
         XBr6PJTlb3cVL+V2ijpC5c4v1cY5bGz15ak7pV59KYIGIqjGvG+wZN+ddbsGRSyAT80e
         UfPQ==
X-Gm-Message-State: AJIora8yzVilZJYOUckTJTfDDlU9YuN5ijUsi5NoWpkbziqie0j34QK8
        sQYsb7fNtU03tQJgkUdW/ZI=
X-Google-Smtp-Source: AGRyM1tEzGhCruRkjJVU5gjish1059DIrNaG6+E54/YE8pOwR9FmSESMOW3+/Q3toQ03lqPIoAYhag==
X-Received: by 2002:adf:f04e:0:b0:21e:48df:a13d with SMTP id t14-20020adff04e000000b0021e48dfa13dmr14057488wro.278.1658926850635;
        Wed, 27 Jul 2022 06:00:50 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea3316.dip0.t-ipconnect.de. [217.234.51.22])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6811000000b0021e6effef8bsm11713642wru.50.2022.07.27.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:00:49 -0700 (PDT)
Message-ID: <acd7b231-3167-e35c-5cdf-8b3127a7d710@gmail.com>
Date:   Wed, 27 Jul 2022 15:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <53a602e2-0590-6c6a-597b-fd55faa3a4ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/27/22 13:24, Krzysztof Kozlowski wrote:
> On 26/07/2022 17:00, Maximilian Luz wrote:
>> On 7/26/22 15:25, Krzysztof Kozlowski wrote:
>>> On 26/07/2022 13:15, Maximilian Luz wrote:
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: qcom,tee-uefisecapp
>>>>>
>>>>> Isn't this SoC-specific device? Generic compatibles are usually not
>>>>> expected.
>>>>
>>>> This is essentially software (kernel driver) talking to software (in the
>>>> TrustZone), so I don't expect there to be anything SoC specific about it.
>>>
>>> You are documenting here firmware in TZ (not kernel driver). Isn't this
>>> a specific piece which might vary from device to device?
>>>
>>> IOW, do you expect the same compatible to work for all possible Qualcomm
>>> boards (past and future like in 10 years from now)?
>>
>> I'm not sure if Qualcomm will still use the "uefisecapp" approach in 10
>> years, but I don't expect the interface of uefisecapp to change. The
>> interface is modeled after the respective UEFI functions, which are spec
>> and thus I don't expect those to change. Also, it seems to have been
>> around for a couple of generations and it hasn't changed. The oldest
>> tested is sdm850 (Lenovo Yoga C630), and the latest is sc8280xp
>> (Thinkpad X13s).
> 
> Expectation is not the same as having a specification saying it will not
> change.
>>
>> Why not make this behave like a "normal" third-party device? If the
>> interface ever changes use qcom,tee-uefisecapp-v2 or something like
>> that? Again, this does not seem to be directly tied to the SoC.
> 
> Such approach is not "normal" for third-party devices. Compatible for
> devices has model number. If the block has specification, then v2 would
> have sense, otherwise you would invent own versioning...
> 
> I would say that firmware implementation can easily change. How much of
> your code is tied to it, I don't know, but argument "I don't expect
> Qualcomm to change something in their firmware" is not the correct argument.

Fair points.

>> Then again, if you prefer to name everything based on
>> "qcom,<device>-<soc>" I don't have any strong arguments against it and
>> I'm happy to change that. I just think it will unnecessarily introduce
>> a bunch of compatibles and doesn't reflect the interface "versioning"
>> situation as I see it.
> 
> Why bunch? All devices could bind to one specific compatible, as they
> are compatible.

Ah, I think I misunderstood you there. I thought you were advocating for
creating compatibles for each SoC just because it's a new SoC and things
might be different. I'm not at all against naming this something like
qcom,tee-uefisecapp-sc8180x then using that on all platforms that work.
I just didn't like the idea of having a bunch of different
qcom,tee-uefisecapp-<soc> pointing to the exact same thing without any
difference at all.

>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +
>>>>>> +additionalProperties: false
>>>>>> +
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    firmware {
>>>>>> +        scm {
>>>>>> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
>>>>>> +        };
>>>>>> +        tee-uefisecapp {
>>>>>> +            compatible = "qcom,tee-uefisecapp";
>>>>>
>>>>> You did not model here any dependency on SCM. This is not full
>>>>> description of the firmware/hardware
>>>>
>>>> How would I do that? A lot of other stuff also depends on SCM being
>>>> present (e.g. qcom_q6v5_pas for loading mdt files) and I don't see them
>>>> declare this in the device tree. As far as I can tell, SCM is pretty
>>>> much expected to be there at all times (i.e. can't be unloaded) and
>>>> drivers check for it when probing via qcom_scm_is_available(),
>>>> deferring probe if not.
>>>
>>> It seems this will be opening a can of worms...
>>
>> Indeed.
>>
>>> The problem with existing approach is:
>>> 1. Lack of any probe ordering or probe deferral support.
>>> 2. Lack of any other dependencies, e.g. for PM.
>>
>> I'm not entirely sure what you mean by "lack of probe deferral support".
>> We have qcom_scm_is_available() and defer probe if that fails. So
>> deferral works, unless I'm misunderstanding something.
> 
> And how do you differentiate that qcom_scm_is_available() failed because
> it is not yet available (defer probe) or it is broken and will never
> load? All regular consumer-provider interfaces have it sorted out.

Fair point. By shifting that to device links you'll at least know what
it's waiting for and the driver won't attempt to probe until that's
resolved. But your question applies to that then as well: How do you
differentiate between the device link or supplier being broken somehow
and the supplier being just not ready yet?

>> But yes, correct on the other points.
>>
>>> Unloading is "solved" only by disallowing the unload, not by proper
>>> device links and module get/put.
>>>
>>> I understand that SCM must be there, but the same for several other
>>> components and for these others we have ways to pass reference around
>>> (e.g. syscon regmap, PHYs handles).
>>>
>>>>
>>>> Don't take this as an excuse as in "I want to leave that out", it's just
>>>> that I don't know how one would declare such a dependency explicitly. If
>>>> you can tell me how to fix it, I'll include that for v2.
>>>
>>> I think there are no dedicated subsystem helpers for this (like for
>>> provider/consumer of resets/power domains/clocks etc), so one way would
>>> be something like nvidia,bpmp is doing.
>>
>> I assume you're referring to tegra_bpmp_get()? Does this correctly
>> handle PM dependencies? At least as far as I can tell it doesn't
>> explicitly establish a device link, it only gets a reference to the
>> device, which doesn't guarantee the presence of a driver. Nor correct PM
>> ordering. Please correct me if I'm wrong. As far as I know automatic
>> creation of device links only works with certain props defined in
>> of_supplier_bindings, right?
> 
> The Tegra choice is not complete, but it implements at least parts of it
> and firmware dependencies are modeled in DTS. Other way would be to add
> your device as child of SMC firmware and then you do not need bindings
> at all...

Looking at the TrEE driver in [1] and thinking of future additions
(re-entrant calls, callbacks/listeners, ..., all of which would require
some state), combining both might be the best option: Have a TrEE main
device for the interface that links up with SCM and then define the apps
as children under that TrEE device.

Regards,
Max

[1]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/auto-kernel.lnx.4.14.c34/drivers/misc/qseecom.c
