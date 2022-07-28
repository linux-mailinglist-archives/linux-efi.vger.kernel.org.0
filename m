Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3975844FE
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 19:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiG1R11 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiG1R1Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 13:27:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900D71CFDD;
        Thu, 28 Jul 2022 10:27:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a11so1375832wmq.3;
        Thu, 28 Jul 2022 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p8H7++t8ftKfTvOlpkNosWtAmLTtWUxzqMuF2tdMZhw=;
        b=YTTMSvgdG59kjlcPUWX7wA8ApAIAYn1IKen/z+HPWAQRWxi3ctqa4zItpB//3Md4E4
         rtjTNM8nNEypJlyKBG5Mdgtp7ELIoqj6EEgqktFeXxU9GuqwY1XpduGHXfXLZfWsrz1G
         TdeMWRUvi3q66XWy2lm9RXQZHTeiLrJ3uiLr1lfuVmKd2FVQKDDBkKoQIxfilJTuga7P
         7BTcRbzUBVnQJ1tqfO1FAE9xAM61TNsMf37VUKeYq7IgX4qqGKXLgcdMcNykophjl8J1
         9q8yaBvcukfzq/hlWstqB9bSP7D8yqYx7GmYUKtVK6/ZAZTt0nqiVBsD5TE8tm6rU786
         +0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p8H7++t8ftKfTvOlpkNosWtAmLTtWUxzqMuF2tdMZhw=;
        b=5MkWJeKcvfMXT30b9fSJH06wSWw1eYD2zxxFqp+Si3IdyAw4y7foY1nnmH6vfaxy1a
         LnYmxaCdsUegc3ElZc1Yrs43lM7ODgUfSFhN+aWeBdD4p7A1vc46aYcTyuBf2LMwU72d
         Rco1NLQp0kQoI5rbai4FEub6wrNPbSQ8/ZgtTqyEjcZpvd3M854AxJDZgw4VI5KFmLnf
         TzzUr/WygY8dzT8XSgwiM+NqlUiwVxItRNQkomHF/Ep/jNJbkHxzdnzdD68Rahfp3aIF
         moJ09CD5E0883hOAEVIoy8kkYp/QKcLzVIO+2NKN221VF8SRBlsm/bcN//h7st2hGI1Y
         MfIg==
X-Gm-Message-State: AJIora8HYL8mvR2mbsYQvZt2TDprmpQzc8qyCu0jBOCymIWLVFW5s6kb
        QmaQl92LZMR2DBEnOII2jjA=
X-Google-Smtp-Source: AGRyM1sjwJAwrhX4M82lO2xOXIoUp9QZLYH4Zc4guiZ95/I1wZbXjDHr0O1QWEUkaXUImodYJ6a76A==
X-Received: by 2002:a05:600c:ad2:b0:3a3:181e:e228 with SMTP id c18-20020a05600c0ad200b003a3181ee228mr283217wmr.139.1659029241968;
        Thu, 28 Jul 2022 10:27:21 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea36f8.dip0.t-ipconnect.de. [217.234.54.248])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a31d200a7dsm2142425wmq.9.2022.07.28.10.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 10:27:21 -0700 (PDT)
Message-ID: <d5a19e17-08eb-8bd6-ea18-5da638d13622@gmail.com>
Date:   Thu, 28 Jul 2022 19:27:19 +0200
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAC_iWjLrntWuJUzVuRi0ZOtG6JXNwz7SbS2mrqpuTgU5TV6rQA@mail.gmail.com>
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

On 7/28/22 18:56, Ilias Apalodimas wrote:
> On Thu, 28 Jul 2022 at 15:49, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
> 
> [...]
> 
>>>>
>>>>> I have an ancient branch somewhere that I can polish up and send an
>>>>> RFC [1],  but the way I enabled that was to install an empty config
>>>>> table from the firmware.  That empty table is basically an indication
>>>>> to the kernel saying "Hey I can't store variables, can you do that for
>>>>> me".
>>>>>
>>>>> Is there any chance we can do something similar on that device (or
>>>>> find a reasonable way of inferring that we need to replace some
>>>>> services).  That way we could at least have a common entry point to
>>>>> the kernel and leave out the DT changes.
>>>>>
>>>>> [1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3
>>>>
>>>> I would very much like to avoid the need for special bootloaders. The
>>>> devices we're talking about are WoA devices, meaning they _should_
>>>> ideally boot just fine with EFI and ACPI.
>>>
>>> I've already responded to following email, but I'll repeat it here for
>>> completeness. It's not a special bootloader.  It's the opposite, it's
>>> a generic UEFI compliant bootloader which takes advantage of the fact
>>> EFI is extensible. We are doing something very similar in how we load
>>> our initrd via the EFI_LOAD_FILE2 protocol.  Whether Qualcomm can add
>>> that to their bootloaders is a different topic though.  But at some
>>> point we need to draw a line than keep overloading the DT because a
>>> vendor decided to go down it's own path.
>>
>> But still, you're asking users to install an extra thing in the boot
>> chain.
> 
> Not users.  EFI firmware implementations that want to support this in
> a generic way.

The whole point here is that we don't have control over that. I'd like
to fix the firmware, but we're talking about WoA devices where, let's
face it, both device and SoC vendor don't really care about Linux. Even
if you'd convince them to implement that for future generations, you'd
still need them to push firmware updates for older generations.
Generations that are end-of-life. IMHO, we should still try support
those. Or we just say "sorry, Linux doesn't support that on your WoA
device".

>> That's what I mean by "special". So the situation would then be
>> this: User needs a) GRUB (or something similar) for booting the kernel
>> (or dual-booting, ...), b) DTBLoader for loading the device-tree because
>> we don't support the ACPI Qualcomm provided, and c) your thing for EFI
>> variables and potentially other firmware fix-ups. b) and c) are both
>> things that "normal" users don't expect. IMHO we should try to get rid
>> of those "non-standard" things, not add more.
> 
> But that's exactly why EFI is extensible .  You can have non standard
> functionality on your firmware for cases like this which doesn't need
> to land in the spec.
> 
>>
>>>>    From an end-user perspective, it's annoying enough that we'll have to
>>>> stick with DTs for the time being due to the use of PEPs in ACPI. I
>>>> really don't want to add some special bootloader for fixups to that.
>>>> Also, this would just move the problem from kernel to bootloader.
>>>
>>> But it *is* a bootloader problem.  The bootloader is aware of the fact
>>> that it can't provide runtime services for X reasons and that's
>>> exactly why we are trying to set EFI_RT_PROPERTIES_TABLE correctly
>>> from the firmware.  All we are doing is install a config table to tell
>>> the OS "I can't do that, can you find a way around it?".
>>
>> Sure, but is making the Linux installation process more device
>> dependent and complicated really the best way to solve this?
> 
> Isn't it device dependent already?  That boat has sailed already since
> we need to change the very definition of runtime services and replace
> them with OS specific ones.  If we add it on the DT, you'll end up
> with different DTs per OS and potentially per use case.  In my head
> the DTs should be part of the firmware (and authenticated by the
> firmware as well) instead of loading whatever we want each time.  By
> using a config table we can add a u64 (random thought),  that tells
> the kernel which TEE implementation will handle variable storage.  So
> we can have a common extension to boot loaders, which at least uses
> EFI interfaces to communicate the functionality.

The only thing that is making the installation-process for end-users
device dependent is installing the DTB. We can handle the device
specific stuff in the kernel, just as we already handle buggy devices.

Further, you seem to assume that these devices provide a DT in the first
place. WoA devices use ACPI, so they don't. But for the time being (as
discussed elsewhere) we unfortunately need to stick with DTs and can't
really use ACPI. I agree that we should avoid OS and use-case specific
DTs, but I don't see how this would make a DT use-case or OS specific.
Things are firmware specific, the interface doesn't change with a
different OS, and we're only indicating the presence of that interface.

My current suggestion (already sent to Sudeep earlier) is (roughly)
this: Add one compatible for the TrEE / TrustZone interface. Then decide
to load or instantiate what needs to be loaded in the driver for that.
That (depending on maybe SoC / platform / vendor) includes installing
the efivar operations. This way we don't have to fill the DT with the
specific things running in firmware.

Regards,
Max
