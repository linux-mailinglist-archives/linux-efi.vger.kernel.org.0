Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A91583F33
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 14:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiG1Mto (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiG1Mtn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 08:49:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CCB2B269;
        Thu, 28 Jul 2022 05:49:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v17so2068020edc.1;
        Thu, 28 Jul 2022 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S8iemc+Dee2LMXXfSDk04gG8NQ+lhhgD/kgDAwC7Ads=;
        b=OVroWaLBfwi4INQPt1GS+eroFAx7I+wOomWEzBXzDNg88sbfYjzDY2D3xJGkm6vuJV
         B/DPPWqXBWQGOzLBNcrzwWD1tyTlCAV/oSKUcn8p+h1A4K4pZw2kFnU28YZJDFAWVK3O
         kvVIyiyEKafE3X3i6VXXmugEu4ilOLNRripWPwQw9DrjmKMRImbHz82RcxGzwWAg8w9r
         XZ0TiCZziz6ZoBPYcz8+97lXd2KhZa1nB8DobWc4CCkwqpj5ibN6+9x3JblOzU3Ny8k3
         p+cU7sGD1o2CToXMC4e8Dy9Hj3MNpAzLmhpn4++An0ZeaBTGsdf+fy4lSjDW1/YYBXKl
         1N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S8iemc+Dee2LMXXfSDk04gG8NQ+lhhgD/kgDAwC7Ads=;
        b=FeiPvaOaHRpy07pArBy/i9LIC+jMCYaZsp04ocZydswotIMZWUjGH1oEaygyXbDDLY
         DwwTBkYM4o3z2jpfD8GbUribMq4be/HfzQJkHXKySvKoOnLcz+dlgazYFygBcP7jxg0v
         Y66CYB/4Jc7U6Xbf7j4YSZ3b63WC/3CbZh+mm+iywzzMHImBUodxWHeoqaT3tfbCeFlX
         U1gs3clApIrA59+zT1eNn7L8o0BmwIpkumMeuz6OJ4Y+h/TdNw3b0gvVualQ/2LTDOoy
         5jXqSLEiCPwNguVVZK10aKAnkJWhLZ2UZBfhGfkfRhyYL+b/ihuzZ8mW465OHflOvsQJ
         NmqA==
X-Gm-Message-State: AJIora86j9sr7sqDB1TP1w0NjCofJ7nwyLCslvxbox/s0gmOfoi5UH2Z
        4Qf+lMJMZFogHwFRZn1DtHQ=
X-Google-Smtp-Source: AGRyM1tOy/Gd8npujdup3qJIK0tbEeb+re5ppKvmymOOw2EnJvTYfEV3jozLHJVxCL0BC8zVEnYx3g==
X-Received: by 2002:a05:6402:40d2:b0:43c:5a4d:c3b4 with SMTP id z18-20020a05640240d200b0043c5a4dc3b4mr12016462edb.95.1659012580444;
        Thu, 28 Jul 2022 05:49:40 -0700 (PDT)
Received: from [10.31.0.4] ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id s21-20020aa7cb15000000b0043cfda1368fsm463107edt.82.2022.07.28.05.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 05:49:39 -0700 (PDT)
Message-ID: <b703f678-b2c5-cdeb-ac40-9646e043d1c3@gmail.com>
Date:   Thu, 28 Jul 2022 14:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
 <20220727132437.pjob3z2nyxsuxgam@bogus>
 <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com>
 <CAC_iWjLWBJLth26ifFfHvimProHZu_w5SjQNWSH_D2Fs_JXjbA@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAC_iWjLWBJLth26ifFfHvimProHZu_w5SjQNWSH_D2Fs_JXjbA@mail.gmail.com>
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

On 7/28/22 14:35, Ilias Apalodimas wrote:
> Hi Maximilian
> 
> On Thu, 28 Jul 2022 at 13:48, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> On 7/28/22 08:03, Ilias Apalodimas wrote:
>>> Hi all,
>>>
>>> On Wed, 27 Jul 2022 at 16:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>
>>>> On Wed, Jul 27, 2022 at 03:03:49PM +0200, Maximilian Luz wrote:
>>>>>
>>>>> Is there really a good way around it?
>>>>
>>>> Yes rely on the firmware preferably auto discover, if that is not an option,
>>>> how about query. It seem to be working in your case.
>>>
>>> That's a good point.  We have a similar situation with some Arm
>>> devices and U-Boot.  Let me try to explain a bit.
>>>
>>> There's code plugged in in OP-TEE and U-Boot atm which allows you to
>>> store EFI variables on an RPMB.  This is a nice alternative if your
>>> device doesn't have any other secure storage,  however it presents
>>> some challenges after ExitBootServices, similar to the ones you have
>>> here.
>>>
>>> The eMMC controller usually lives in the non-secure world.  OP-TEE
>>> can't access that, so it relies on a userspace supplicant to perform
>>> the RPMB accesses.  That supplicant is present in U-Boot and
>>> Get/SetVariable works fine before ExitBootServices.  Once Linux boots,
>>>    the 'U-Boot supplicant' goes away and we launch the linux equivalent
>>> one from userspace.  Since variable accessing is a runtime service and
>>> it still has to go through the firmware we can't use those anymore
>>> since U-Boot doesn't preserve the supplicant, the eMMC driver and the
>>> OP-TEE portions needed in the runtime section(and even if it did we
>>> would now have 2 drivers racing to access the same hardware).  Instead
>>> U-Boot copies the variables in runtime memory and
>>> GetVariable/GetNextVariable still works, but SetVariable returns
>>> EFI_UNSUPPORTED.
>>>
>>> I've spent enough time looking at available solutions and although
>>> this indeed breaks the EFI spec, something along the lines of
>>> replacing the runtime services with ones that give you direct access
>>> to the secure world, completely bypassing the firmware is imho our
>>> least bad option.
>>
>> This sounds very similar to what Qualcomm may be doing on some devices.
>> The TrEE interface allows for callbacks and there are indications that
>> one such callback-service is for RPMB. I believe that at least on some
>> platforms, Qualcomm also stores UEFI variables in RPMB and uses the same
>> uefisecapp interface in combination with RPMB listeners installed by the
>> kernel to access them.
>>
>>> I have an ancient branch somewhere that I can polish up and send an
>>> RFC [1],  but the way I enabled that was to install an empty config
>>> table from the firmware.  That empty table is basically an indication
>>> to the kernel saying "Hey I can't store variables, can you do that for
>>> me".
>>>
>>> Is there any chance we can do something similar on that device (or
>>> find a reasonable way of inferring that we need to replace some
>>> services).  That way we could at least have a common entry point to
>>> the kernel and leave out the DT changes.
>>>
>>> [1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3
>>
>> I would very much like to avoid the need for special bootloaders. The
>> devices we're talking about are WoA devices, meaning they _should_
>> ideally boot just fine with EFI and ACPI.
> 
> I've already responded to following email, but I'll repeat it here for
> completeness. It's not a special bootloader.  It's the opposite, it's
> a generic UEFI compliant bootloader which takes advantage of the fact
> EFI is extensible. We are doing something very similar in how we load
> our initrd via the EFI_LOAD_FILE2 protocol.  Whether Qualcomm can add
> that to their bootloaders is a different topic though.  But at some
> point we need to draw a line than keep overloading the DT because a
> vendor decided to go down it's own path.

But still, you're asking users to install an extra thing in the boot
chain. That's what I mean by "special". So the situation would then be
this: User needs a) GRUB (or something similar) for booting the kernel
(or dual-booting, ...), b) DTBLoader for loading the device-tree because
we don't support the ACPI Qualcomm provided, and c) your thing for EFI
variables and potentially other firmware fix-ups. b) and c) are both
things that "normal" users don't expect. IMHO we should try to get rid
of those "non-standard" things, not add more.

>>   From an end-user perspective, it's annoying enough that we'll have to
>> stick with DTs for the time being due to the use of PEPs in ACPI. I
>> really don't want to add some special bootloader for fixups to that.
>> Also, this would just move the problem from kernel to bootloader.
> 
> But it *is* a bootloader problem.  The bootloader is aware of the fact
> that it can't provide runtime services for X reasons and that's
> exactly why we are trying to set EFI_RT_PROPERTIES_TABLE correctly
> from the firmware.  All we are doing is install a config table to tell
> the OS "I can't do that, can you find a way around it?".

Sure, but is making the Linux installation process more device
dependent and complicated really the best way to solve this?

Regards,
Max
