Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6555815D6
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiGZPAu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiGZPAt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 11:00:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C222BD2;
        Tue, 26 Jul 2022 08:00:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id oy13so26675569ejb.1;
        Tue, 26 Jul 2022 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KXwks4U0bf08TlIwVOpXBx4c7TuLqBhqZnpO6daZqYo=;
        b=Sh7qNY+kJv8+cDt+1q4uHQ5Ti3AHrhrhzbfbajKjQp/9vdOO7AIzcSANWRgOw46kCr
         5ERIz0uklAnNmgUWHvVZhxxTdIIYlEbQn0Z5hLivPWTScSOJGsD8zW95uEzLtKYZhJ/T
         0LoKATxykYGdnjuCEoa5AO7W8at2ezytfKPaIjbI23k5x8KYQpENvGqt9Ehd9/rH4KUe
         5r+osbu8EfeZG6LUZDg/29osIvaPKdol21q0+LBEXHqITJ8T1MwGmA8xewDvVfLQn00I
         iIKfA5bbfA3nYCEVbRW8fF4SNV9huDfzWN2ufI+M5pwyQh9UX61C6RAkobVya1i2tSBO
         R26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KXwks4U0bf08TlIwVOpXBx4c7TuLqBhqZnpO6daZqYo=;
        b=M8ggu2jnnGTW+7lz//U5sYzdf3NDQiqQXwBZ/xGS1sQ5WCFBGFaKeYfM5W2tO7Mxia
         e0HZ2wl3sf/rRUh/WFZ5SLBlJJqF6AAmwpDQoiw9jsIed5KRyrbRfvc/KnfJ6cL1KlfY
         xrLOHZY+OrMhxKkwNtoff/aS0nRSMOW487fD1mpSd7u2yRCsfOoLS0L39yTo2SkVpk+h
         fMR8w0aAR92zKu2k1M3PlXugJEvRfE1KOjyq0GRr6sNtig9fDsUXtOoxDjGDIAaaEBYx
         DTdR6IYaFBLTY/2XqoXlFS35vvKaNwH5+BOXYbkqHlFpXRIolhBScaQnnGwuI/e41d0P
         wSug==
X-Gm-Message-State: AJIora9O1OYEH1LIvurZbA8ZfovyJcV3Klv2sagEXTnYdiFbSzKz/QxD
        edWi9Oz4n4ePKxcQl1VIj90=
X-Google-Smtp-Source: AGRyM1vRtocosg8JVRjgrQC/nJP8vPkOTsq97SrpEIEnttjWfPmMtRul49X1rpyuGj0Ao/UiDFEbTA==
X-Received: by 2002:a17:906:93e8:b0:72b:6923:a0b9 with SMTP id yl8-20020a17090693e800b0072b6923a0b9mr14028141ejb.244.1658847646919;
        Tue, 26 Jul 2022 08:00:46 -0700 (PDT)
Received: from [10.30.0.4] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id b20-20020a170906195400b0072aa38d768esm6592234eje.64.2022.07.26.08.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:00:45 -0700 (PDT)
Message-ID: <2e522bcd-5d55-e87f-126c-514f5edaa560@gmail.com>
Date:   Tue, 26 Jul 2022 17:00:43 +0200
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <11e5c369-c0da-7756-b9e2-ac375dc78e9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/26/22 15:25, Krzysztof Kozlowski wrote:
> On 26/07/2022 13:15, Maximilian Luz wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,tee-uefisecapp
>>>
>>> Isn't this SoC-specific device? Generic compatibles are usually not
>>> expected.
>>
>> This is essentially software (kernel driver) talking to software (in the
>> TrustZone), so I don't expect there to be anything SoC specific about it.
> 
> You are documenting here firmware in TZ (not kernel driver). Isn't this
> a specific piece which might vary from device to device?
> 
> IOW, do you expect the same compatible to work for all possible Qualcomm
> boards (past and future like in 10 years from now)?

I'm not sure if Qualcomm will still use the "uefisecapp" approach in 10
years, but I don't expect the interface of uefisecapp to change. The
interface is modeled after the respective UEFI functions, which are spec
and thus I don't expect those to change. Also, it seems to have been
around for a couple of generations and it hasn't changed. The oldest
tested is sdm850 (Lenovo Yoga C630), and the latest is sc8280xp
(Thinkpad X13s).

Why not make this behave like a "normal" third-party device? If the
interface ever changes use qcom,tee-uefisecapp-v2 or something like
that? Again, this does not seem to be directly tied to the SoC.

Then again, if you prefer to name everything based on
"qcom,<device>-<soc>" I don't have any strong arguments against it and
I'm happy to change that. I just think it will unnecessarily introduce
a bunch of compatibles and doesn't reflect the interface "versioning"
situation as I see it.

>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    firmware {
>>>> +        scm {
>>>> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
>>>> +        };
>>>> +        tee-uefisecapp {
>>>> +            compatible = "qcom,tee-uefisecapp";
>>>
>>> You did not model here any dependency on SCM. This is not full
>>> description of the firmware/hardware
>>
>> How would I do that? A lot of other stuff also depends on SCM being
>> present (e.g. qcom_q6v5_pas for loading mdt files) and I don't see them
>> declare this in the device tree. As far as I can tell, SCM is pretty
>> much expected to be there at all times (i.e. can't be unloaded) and
>> drivers check for it when probing via qcom_scm_is_available(),
>> deferring probe if not.
> 
> It seems this will be opening a can of worms...

Indeed.

> The problem with existing approach is:
> 1. Lack of any probe ordering or probe deferral support.
> 2. Lack of any other dependencies, e.g. for PM.

I'm not entirely sure what you mean by "lack of probe deferral support".
We have qcom_scm_is_available() and defer probe if that fails. So
deferral works, unless I'm misunderstanding something.

But yes, correct on the other points.

> Unloading is "solved" only by disallowing the unload, not by proper
> device links and module get/put.
> 
> I understand that SCM must be there, but the same for several other
> components and for these others we have ways to pass reference around
> (e.g. syscon regmap, PHYs handles).
> 
>>
>> Don't take this as an excuse as in "I want to leave that out", it's just
>> that I don't know how one would declare such a dependency explicitly. If
>> you can tell me how to fix it, I'll include that for v2.
> 
> I think there are no dedicated subsystem helpers for this (like for
> provider/consumer of resets/power domains/clocks etc), so one way would
> be something like nvidia,bpmp is doing.

I assume you're referring to tegra_bpmp_get()? Does this correctly
handle PM dependencies? At least as far as I can tell it doesn't
explicitly establish a device link, it only gets a reference to the
device, which doesn't guarantee the presence of a driver. Nor correct PM
ordering. Please correct me if I'm wrong. As far as I know automatic
creation of device links only works with certain props defined in
of_supplier_bindings, right?

So unless I'm wrong there is also a bunch of other stuff that may be
subtly broken. (Again, not a justification to include these changes,
just wondering whether there should be a conscious approach to find and
fix these things... rather than discover them patch-by-patch).

> meson_sm_get is a bit similar - looking by compatible. This is less
> portable and I would prefer the bpmp way (just like syscon phandles).

I have another example (that could be improved via a phandle in DT): For
the Surface System Aggregator (in ACPI-land), we have ssam_client_bind().
This function 1) checks if the controller is available and ready, 2) if
it is gets a reference to it, and 3) establishes a device link for
PM-ordering, before 4) returning the reference to that controller to the
client. This combined with deferring probe ensures that we will always
have a valid reference. And since we're in DT-land, we could hook that
up with a phandle reference to SCM and load that instead of having to
use a global static.

> The qcom_q6v5_pas could be converted later to use similar approach and
> eventually the "tatic struct qcom_scm *__scm;" can be entirely removed.
> 
> Any comments on this approach from Konrad, Bjorn, Dmitry, Vinod and
> anyone else?

Regards,
Max
