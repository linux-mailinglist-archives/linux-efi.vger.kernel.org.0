Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E705861DF
	for <lists+linux-efi@lfdr.de>; Mon,  1 Aug 2022 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiGaWs0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Jul 2022 18:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiGaWsZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 31 Jul 2022 18:48:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A916361;
        Sun, 31 Jul 2022 15:48:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id id17so4989339wmb.1;
        Sun, 31 Jul 2022 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8PJQB6AzX9Z5eJMT/40cxAj41ZKmQ1uhbj+QFHTbbv4=;
        b=P6sChfgiqHwcQlXrK/oNj3DXnzDNOXodayQ9SPhypIuD5YGawZwmlUPdiP6eM5urB9
         0l8SQa2FhOTEQ0my0lpbGeDSxOERpIm21D769uTzRZXZcJ9s63j2QTmMBFDWlAB/2PBs
         pZGHY/0ltaHEy9sgeCkc5nECbNCF+tJGm6Spio2mL6SzvzgAQUEq8ifKM2dCy4XZDdeI
         dDLtV1mHMdGDrsF7K5XAuh2ujUV/MAeyEGeRD/2LTHAqfaugJ4auNmlI9GOt5DQxLN32
         K6oT+3IWCmrzkv/eVo3/caphLcso0lRc4DYBFhe0PHuCUihuQuhmMui3iheigpBZvDNR
         5aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8PJQB6AzX9Z5eJMT/40cxAj41ZKmQ1uhbj+QFHTbbv4=;
        b=00g+Fy677zvTF/EDh15oUYdRTVerIvKyD5e+ACihxqkFvzxRdcy3x0QBOcNLVvZprD
         RhFfXkfFSXn9e9qURWNWL1hqyoNFvrHVpxTZBmGG6smRUgeYaTWgJB1FDVEL24RE/otJ
         sPXGAvch6XOX4xpl5qfchMvb3zE1+PzdWYtWQjJt1PKbNKjiYoR2uoWPC8jcznCVbDuE
         WUadlQFUHqBZEdhm6ql04+H0HbI5z1uvpohzXhv0WMjPUVEfM870Iim6koM/TtpOrOox
         Haw0SBuaq14lDnO8q4ZmM0Y+dSA5Stmu5Y/Nq51p9oj8f23YUmruL/CG9+7Z2XCibOvU
         6xjQ==
X-Gm-Message-State: AJIora/uYK7XaNfP148yHVVi1Xh0ADb+I3u2sXEuryBsRuDCLqhSkzB7
        VK2J+JjsHnEkeDkRPnwmkW4=
X-Google-Smtp-Source: AGRyM1vhg1hdrEp0r6yRk84IRkELUqTXwFXu+F4P2oyBDOUiq/zxzejPPU710nUMUvKEiJYn2udr5g==
X-Received: by 2002:a05:600c:3b1f:b0:3a3:21cd:d781 with SMTP id m31-20020a05600c3b1f00b003a321cdd781mr9206394wms.183.1659307702114;
        Sun, 31 Jul 2022 15:48:22 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea3004.dip0.t-ipconnect.de. [217.234.48.4])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003a320e6f011sm12763799wmc.1.2022.07.31.15.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:48:21 -0700 (PDT)
Message-ID: <eaa455ed-2dd2-a33f-6420-a75484eccc35@gmail.com>
Date:   Mon, 1 Aug 2022 00:48:20 +0200
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
 <b703f678-b2c5-cdeb-ac40-9646e043d1c3@gmail.com>
 <CAC_iWjLrntWuJUzVuRi0ZOtG6JXNwz7SbS2mrqpuTgU5TV6rQA@mail.gmail.com>
 <d5a19e17-08eb-8bd6-ea18-5da638d13622@gmail.com>
 <CAC_iWj+mEEAVzZ-_Cn9KKw6H9sUB9sz8f16neXi-wXFXWSLycg@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAC_iWj+mEEAVzZ-_Cn9KKw6H9sUB9sz8f16neXi-wXFXWSLycg@mail.gmail.com>
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

Hi,

On 7/31/22 11:54, Ilias Apalodimas wrote:
> Hi Maximilian,
> 
> On Thu, 28 Jul 2022 at 20:27, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
> 
> [...]
> 
>>>>>>>
>>>>>>> [1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3
>>>>>>
>>>>>> I would very much like to avoid the need for special bootloaders. The
>>>>>> devices we're talking about are WoA devices, meaning they _should_
>>>>>> ideally boot just fine with EFI and ACPI.
>>>>>
>>>>> I've already responded to following email, but I'll repeat it here for
>>>>> completeness. It's not a special bootloader.  It's the opposite, it's
>>>>> a generic UEFI compliant bootloader which takes advantage of the fact
>>>>> EFI is extensible. We are doing something very similar in how we load
>>>>> our initrd via the EFI_LOAD_FILE2 protocol.  Whether Qualcomm can add
>>>>> that to their bootloaders is a different topic though.  But at some
>>>>> point we need to draw a line than keep overloading the DT because a
>>>>> vendor decided to go down it's own path.
>>>>
>>>> But still, you're asking users to install an extra thing in the boot
>>>> chain.
>>>
>>> Not users.  EFI firmware implementations that want to support this in
>>> a generic way.
>>
>> The whole point here is that we don't have control over that. I'd like
>> to fix the firmware, but we're talking about WoA devices where, let's
>> face it, both device and SoC vendor don't really care about Linux. Even
>> if you'd convince them to implement that for future generations, you'd
>> still need them to push firmware updates for older generations.
>> Generations that are end-of-life. IMHO, we should still try support
>> those. Or we just say "sorry, Linux doesn't support that on your WoA
>> device".
> 
> Yea we agree on that.  I've mentioned on a previous mail that whether
> Qualcomm wants to support this in a generic way is questionable, since
> we have no control over the firmware.  My only 'objection' is that the
> kernel has a generic way of discovering which runtime services are
> supported, which we will completely ignore based on some DT entries.

Right, sorry. That makes sense. If we have a realistic possibility, then
I agree that making it discoverable in firmware is the best option. My
point was just that we can't rely on Windows-focused vendors to
implement it.

> In any case let's find something that fits OP-TEE as well, since I can
> send those patches afterwards.

I think it's a great idea to try and find some sort of standardized
solution for OP-TEE and other interested projects similar to it, but we
still have to use a workaround for the Qualcomm WoA devices we have :(

Nevertheless, I'm happy to provide some input for a generic solution,
although I'm not sure I'm the best person to talk to about this.

>>>> That's what I mean by "special". So the situation would then be
>>>> this: User needs a) GRUB (or something similar) for booting the kernel
>>>> (or dual-booting, ...), b) DTBLoader for loading the device-tree because
>>>> we don't support the ACPI Qualcomm provided, and c) your thing for EFI
>>>> variables and potentially other firmware fix-ups. b) and c) are both
>>>> things that "normal" users don't expect. IMHO we should try to get rid
>>>> of those "non-standard" things, not add more.
>>>
>>> But that's exactly why EFI is extensible .  You can have non standard
>>> functionality on your firmware for cases like this which doesn't need
>>> to land in the spec.
>>>
>>>>
>>>>>>     From an end-user perspective, it's annoying enough that we'll have to
>>>>>> stick with DTs for the time being due to the use of PEPs in ACPI. I
>>>>>> really don't want to add some special bootloader for fixups to that.
>>>>>> Also, this would just move the problem from kernel to bootloader.
>>>>>
>>>>> But it *is* a bootloader problem.  The bootloader is aware of the fact
>>>>> that it can't provide runtime services for X reasons and that's
>>>>> exactly why we are trying to set EFI_RT_PROPERTIES_TABLE correctly
>>>>> from the firmware.  All we are doing is install a config table to tell
>>>>> the OS "I can't do that, can you find a way around it?".
>>>>
>>>> Sure, but is making the Linux installation process more device
>>>> dependent and complicated really the best way to solve this?
>>>
>>> Isn't it device dependent already?  That boat has sailed already since
>>> we need to change the very definition of runtime services and replace
>>> them with OS specific ones.  If we add it on the DT, you'll end up
>>> with different DTs per OS and potentially per use case.  In my head
>>> the DTs should be part of the firmware (and authenticated by the
>>> firmware as well) instead of loading whatever we want each time.  By
>>> using a config table we can add a u64 (random thought),  that tells
>>> the kernel which TEE implementation will handle variable storage.  So
>>> we can have a common extension to boot loaders, which at least uses
>>> EFI interfaces to communicate the functionality.
>>
>> The only thing that is making the installation-process for end-users
>> device dependent is installing the DTB. We can handle the device
>> specific stuff in the kernel, just as we already handle buggy devices.
>>
>> Further, you seem to assume that these devices provide a DT in the first
>> place. WoA devices use ACPI, so they don't. But for the time being (as
>> discussed elsewhere) we unfortunately need to stick with DTs and can't
>> really use ACPI. I agree that we should avoid OS and use-case specific
>> DTs, but I don't see how this would make a DT use-case or OS specific.
>> Things are firmware specific, the interface doesn't change with a
>> different OS, and we're only indicating the presence of that interface.
>>
>> My current suggestion (already sent to Sudeep earlier) is (roughly)
>> this: Add one compatible for the TrEE / TrustZone interface. Then decide
>> to load or instantiate what needs to be loaded in the driver for that.
>> That (depending on maybe SoC / platform / vendor) includes installing
>> the efivar operations. This way we don't have to fill the DT with the
>> specific things running in firmware.
> 
> As far as OP-TEE is concerned, I think we can make the 'feature'
> discoverable.  I'll go propose that to op-tee but if that gets
> accepted, we don't need any extra nodes (other than the existing one),
> to wire up efivars_register().

Right. I think you (either in your patches or mails) already mentioned
having an integer ID for the implementation (or maybe implementation +
vendor?). Apart from that, I think it might also make sense to have a
bit-field similar to efi.runtime_supported_mask that tells the kernel
which functions are taken over.

So with that you could call efivars_register() based on the firmware
table in the driver for linaro,optee-tz (I assume) whether for qcom,tee
(or whatever we'd call that) we'd have to hard-code it based on some
platform/model identifier.

Regards,
Max
