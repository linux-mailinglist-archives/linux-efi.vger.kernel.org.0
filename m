Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE5583BB2
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiG1KFW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiG1KFV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 06:05:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9112084;
        Thu, 28 Jul 2022 03:05:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u5so1551653wrm.4;
        Thu, 28 Jul 2022 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dWlkcKxZ/jS1fvdg+IOxwtUsS5FS2QYlkdZZEqT1QMc=;
        b=hyGik4gSM24BRmFurXeXH+YFWoNR6Q2CZ5C0exR0BakP/Mr++Htqf6TXWPI3tbLheL
         DLz2flfQY3b82VstHLrylN1GbAgvw5HY5obOiFMf6cqsix4m5lIHfHYsNf0y2uSUs+RH
         q8GDanVkOqqg6AGs3Dc1Zec2xkH+JS19Y2M3FisP4otHZ47NrCsXVgV7RCqydhx4qEJz
         UtsYss3ctyifFHlGtwi5v/l2uSfkLCPCUyk7G9g7RU1OcMYG1h+vlrAkmyi4QkFEk1mE
         iFJ7mZP9X4bVt/4ZIVGrKAAB2MCmEB745/EZFGjttFV4G8CfaGrzoRkE+j/LB/PBrQp/
         6UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dWlkcKxZ/jS1fvdg+IOxwtUsS5FS2QYlkdZZEqT1QMc=;
        b=qWkJvqw76U4X4kpdicnn34cL6s3LAeYhZAptoyxFrpg/Fd3J60RxKjAFYs0uGkajjC
         rAfDZSh9TIQy/8iR8LyljxFB5AD2GzqGzPv8KcObRAjMvLiyyjKUmO2Cz2nNzagupwFy
         z/j76ejppNMeB8XstXgpMVBAJtmMRiQpDAjdPF7tsxgJ75Br0htRnvVJN04rbKrUB8NA
         cx2y9GpZG5knDx8Cg2Ql55WLf/fwaBK6F/ax3edU6QdtVUnZ8BDXgjm0ax3BIbhDvmpw
         h+2SNCQiPaaRsP4RtSPqzPf43gQTP6Jk8lZ2n5jmGY+yUAZ3RDgxjYMpH2ovBjDn+Vom
         JaNg==
X-Gm-Message-State: AJIora+ex49Qa8okSDqpPY2ZARHrDFKDMjLNeiQ2rAfB1bAKOyXoNSyM
        ZfLPYACMcQyTYDsN0DeXo5g=
X-Google-Smtp-Source: AGRyM1t0iA7TPfcqYYgpFlRXePVpOn+sJssKxjGrJTwqD8Q0XR9BDUqt1ipPUuJW6ULIyrFN9kOWuA==
X-Received: by 2002:a5d:6d8f:0:b0:21d:b7d0:a913 with SMTP id l15-20020a5d6d8f000000b0021db7d0a913mr16483662wrs.462.1659002717317;
        Thu, 28 Jul 2022 03:05:17 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea36f8.dip0.t-ipconnect.de. [217.234.54.248])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm804016wmb.22.2022.07.28.03.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:05:16 -0700 (PDT)
Message-ID: <4e777590-616a-558a-031e-3ef1f1e492b4@gmail.com>
Date:   Thu, 28 Jul 2022 12:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Andy Gross <agross@kernel.org>,
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
 <20220728082330.w4ppmzvjaeywsglu@bogus>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220728082330.w4ppmzvjaeywsglu@bogus>
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

On 7/28/22 10:23, Sudeep Holla wrote:
> On Tue, Jul 26, 2022 at 07:01:28PM +0200, Maximilian Luz wrote:
>> On 7/26/22 17:41, Sudeep Holla wrote:
>>> On Tue, Jul 26, 2022 at 05:15:41PM +0200, Maximilian Luz wrote:
>>>>
>>>> So ultimately I think it's better to add a DT entry for it.
>>>
>>> I disagree for the reason that once you discover more apps running on the
>>> secure side, you want to add more entries and update DT on the platform
>>> every time you discover some new firmware entity and you wish to interact
>>> with it from the non-secure side.
>>
>> Just as you'll have to add a driver to the kernel and update whatever is
>> probing the TrEE interface and add those strings to that interface. If
>> you then start doing SoC-specific lists, I think you'd be pretty much
>> re-implementing a DT in the kernel driver...
>>
> 
> Yes at the cost of DT being dumping ground for all the SoC specific firmware
> crap. Firmware can be and must be discoverable, no point in dumping it in
> DT as it forces DT upgrade every time something changes in the firmware i.e.
> it can go out of sync quite quickly.

I fully agree with you here on the design level. Firmware _should_ be
discoverable. Unfortunately, in this case it really isn't.

Again, in Windows, this information is stored via the Registry and set
when the driver is installed. An example:

     ; UEFIVAR SECURE APP SERVICE
     HKR,%EFIVarService.RegKey%,Enabled,%REG_DWORD%,1
     HKR,%EFIVarService.RegKey%,MajorVersion,%REG_DWORD%,1
     HKR,%EFIVarService.RegKey%,MinorVersion,%REG_DWORD%,0
     
     ; WINSECAPP SECURE APP SERVICE
     HKR,%WinSecAppService.RegKey%,Enabled,%REG_DWORD%,1
     HKR,%WinSecAppService.RegKey%,SecureApp,%REG_DWORD%,1
     HKR,%WinSecAppService.RegKey%,LoadApp,%REG_DWORD%,0
     HKR,%WinSecAppService.RegKey%,AppName,,"qcom.tz.winsecapp"
     HKR,%WinSecAppService.RegKey%,MajorVersion,%REG_DWORD%,1
     HKR,%WinSecAppService.RegKey%,MinorVersion,%REG_DWORD%,0
     HKR,%WinSecAppService.RegKey%,OSDependencies,%REG_MULTI_SZ%,%RpmbOsService%
     
     ; HDCP v2.2 SECURE APP SERVICE
     HKR,%Hdcp2p2Service.RegKey%,Enabled,%REG_DWORD%,1
     HKR,%Hdcp2p2Service.RegKey%,SecureApp,%REG_DWORD%,1
     HKR,%Hdcp2p2Service.RegKey%,LoadApp,%REG_DWORD%,1
     HKR,%Hdcp2p2Service.RegKey%,AppName,,"qcom.tz.hdcp2p2"
     HKR,%Hdcp2p2Service.RegKey%,FileName,,"hdcp2p2.mbn"
     HKR,%Hdcp2p2Service.RegKey%,MajorVersion,%REG_DWORD%,1
     HKR,%Hdcp2p2Service.RegKey%,MinorVersion,%REG_DWORD%,0
     HKR,%Hdcp2p2Service.RegKey%,OSDependencies,%REG_MULTI_SZ%,%RpmbOsService%,%TzAppsOsService%

The '.RegKey' contains a GUID that specifies the _driver_ interface that
is registered by the driver to the kernel (i.e. is not related to the
specific firmware and firmware version), e.g. [1]. For uefisecapp, the
driver also maps this GUID to the name-string.

[1]: https://github.com/tpn/winsdk-10/blob/9b69fd26ac0c7d0b83d378dba01080e93349c2ed/Include/10.0.16299.0/km/treevariableservice.h#L35

>> I don't quite understand why this is a problem. I think per device,
>> there's a reasonably limited set of apps that we would want to interact
>> with from the kernel. And for one single device, that set doesn't change
>> over time. So what's the difference to, say, an I2C device?
>>
> 
> As I said we don't want DT to be dumping ground for all the not well designed
> firmware interface. The whole point of firmware being another piece of
> software that can be change unlike hardware makes it fragile to present any
> more that what you need in the DT. I see this as one of the example.

I can see your point. But this interface has apparently been around
since at least sdm850 (e.g. Lenovo C630) and hasn't changed. As I've
argued elsewhere: All parties involved have a vested interest that this
interface doesn't change in a breaking way. The interface is modeled
similar to syscalls, so I very much expect them to extend it if needed,
instead of changing/breaking it.

Sure, it _could_ be changed in a breaking way. But again, I believe that
to be _very_ unlikely.

> Anyways I don't have the final say, I leave it to the DT maintainers.
> 
>>> As along as get this application ID can handle any random name, I prefer
>>> to use that as the discover mechanism and not have this DT.
>>
>> Apart from the above, some apps must also be loaded from the system. And
>> those you can't detect: If an app isn't running, it doesn't have an ID
>> (uefisecapp and the tpm app are loaded by the firmware at boot). Those
>> are mostly vendor-specific things as far as I can tell, or HDCP stuff.
>> So you'd need to specify those as firmware somehow, and since (as far as
>> I can tell) those are signed specifically by/for that vendor and
>> potentially device (similar to the GPU zap shader or remoteproc
>> firmware), you'll need to use per-device paths.
>>
> 
> Sounds to me like more can be pushed to user space as it gets loaded at
> runtime.

If we have user-space available at the time when these things should be
loaded or if they are more or less optional, sure.

>> That means you either hard-code them in the driver and have a compatible
>> per model, do DMI matching, or something similar (again, essentially
>> baking DTs into the kernel driver...), or just store them in the DT
>> (like we already do for GPU/remoteprocs). While you could hard-code some
>> known loaded-by-firmware apps and use the DT for others, I think we
>> should keep everything in the same place.
>>
> 
> Worst case I am fine with that as this needs to be one of and future
> platforms must get their act right in designing their f/w interface.

Again, I fully agree with you that this situation shouldn't exist. But
reality is sadly different.

Regards,
Max
