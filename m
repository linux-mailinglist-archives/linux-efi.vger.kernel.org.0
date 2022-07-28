Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A9A583C74
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiG1Ksl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiG1KsX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 06:48:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B48F6E;
        Thu, 28 Jul 2022 03:48:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e15so1674978edj.2;
        Thu, 28 Jul 2022 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C8KL6cxgYe7G0uHCrtdi7uI1VaQQRyi8QTqpUfwwtes=;
        b=mwGhI5cSGPLWDtBZgDC2JklggdCuEyFlaRG6ts7Va85uhN/2+kNxALA6uwV4ngveSy
         IUt9qP431fvQJvsSlmgS9MUEbsTV/lQy7ZLmeztTbeM4S3i8kufL69vIfD5XOhEVNp/Y
         QV8WGn8aVHMZgdXQQRsLNXx4TIge0250UxeWAjQTGBWexckyfubfPM8KWHq6FZXc9tsN
         1C1KCkVqg5++Jmrmg5NP1oHdkQq6sh2eOT7i3bSeOcQHgEVNoCuFdvuN0/nSHg4UDqoG
         3e64nDk0rmfUpTwXWZh0VSfHATvUEUcmxLy34WMFscbpFq+86LrobOgD8t0cvZEaU8w1
         el8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C8KL6cxgYe7G0uHCrtdi7uI1VaQQRyi8QTqpUfwwtes=;
        b=1P4g8LR80/6Dy0WilQShdCwj+P9EFY9WfLZI9jgnTteDtFX+XjYF176QY/E/0TpXEY
         5nKGipIo8z1tzIqtfrxy7hbNe/41CuBpOrF/OPnYlmID1O1L4XQgoI8fUGMpva49MzWD
         j9IWbNLC3L9z79eEvX+v0a7Uo6ur59gyjvzSfmXMTCqBjxlPpXsPTgnTUTY2538pE6hS
         uDkQajfodI+n8dJFrQziZJDveDJws3X++jWwiWLjjDglYGqnFJL66kH1v0ZwrXe1UFbY
         YIk80nSBPEeUbNDQAlbTPzg57zSbako6EYuloCKnapWWwtU1t8jS7KUqNhuT2XivQVG4
         NcOQ==
X-Gm-Message-State: AJIora9gGxPRbEm2ZlCZPiJV92N6RTbzzQmv+Aj674c7+ycQUdqNAEqk
        sEJbkEMc4SkrMUe/bmSY4/U=
X-Google-Smtp-Source: AGRyM1vemlyjbuaTu2kSRks1+Go/6LlvZGV8nu6hCYqPjE1IFRelyFMOXmvySlavsduznW7sldz52w==
X-Received: by 2002:a05:6402:3907:b0:431:6776:64e7 with SMTP id fe7-20020a056402390700b00431677664e7mr26575599edb.0.1659005300826;
        Thu, 28 Jul 2022 03:48:20 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea36f8.dip0.t-ipconnect.de. [217.234.54.248])
        by smtp.gmail.com with ESMTPSA id t23-20020aa7d4d7000000b0043bbc9503ddsm456319edr.76.2022.07.28.03.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:48:20 -0700 (PDT)
Message-ID: <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com>
Date:   Thu, 28 Jul 2022 12:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
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

On 7/28/22 08:03, Ilias Apalodimas wrote:
> Hi all,
> 
> On Wed, 27 Jul 2022 at 16:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Wed, Jul 27, 2022 at 03:03:49PM +0200, Maximilian Luz wrote:
>>>
>>> Is there really a good way around it?
>>
>> Yes rely on the firmware preferably auto discover, if that is not an option,
>> how about query. It seem to be working in your case.
> 
> That's a good point.  We have a similar situation with some Arm
> devices and U-Boot.  Let me try to explain a bit.
> 
> There's code plugged in in OP-TEE and U-Boot atm which allows you to
> store EFI variables on an RPMB.  This is a nice alternative if your
> device doesn't have any other secure storage,  however it presents
> some challenges after ExitBootServices, similar to the ones you have
> here.
> 
> The eMMC controller usually lives in the non-secure world.  OP-TEE
> can't access that, so it relies on a userspace supplicant to perform
> the RPMB accesses.  That supplicant is present in U-Boot and
> Get/SetVariable works fine before ExitBootServices.  Once Linux boots,
>   the 'U-Boot supplicant' goes away and we launch the linux equivalent
> one from userspace.  Since variable accessing is a runtime service and
> it still has to go through the firmware we can't use those anymore
> since U-Boot doesn't preserve the supplicant, the eMMC driver and the
> OP-TEE portions needed in the runtime section(and even if it did we
> would now have 2 drivers racing to access the same hardware).  Instead
> U-Boot copies the variables in runtime memory and
> GetVariable/GetNextVariable still works, but SetVariable returns
> EFI_UNSUPPORTED.
> 
> I've spent enough time looking at available solutions and although
> this indeed breaks the EFI spec, something along the lines of
> replacing the runtime services with ones that give you direct access
> to the secure world, completely bypassing the firmware is imho our
> least bad option.

This sounds very similar to what Qualcomm may be doing on some devices.
The TrEE interface allows for callbacks and there are indications that
one such callback-service is for RPMB. I believe that at least on some
platforms, Qualcomm also stores UEFI variables in RPMB and uses the same
uefisecapp interface in combination with RPMB listeners installed by the
kernel to access them.

> I have an ancient branch somewhere that I can polish up and send an
> RFC [1],  but the way I enabled that was to install an empty config
> table from the firmware.  That empty table is basically an indication
> to the kernel saying "Hey I can't store variables, can you do that for
> me".
> 
> Is there any chance we can do something similar on that device (or
> find a reasonable way of inferring that we need to replace some
> services).  That way we could at least have a common entry point to
> the kernel and leave out the DT changes.
> 
> [1] https://git.linaro.org/people/ilias.apalodimas/net-next.git/log/?h=setvar_rt_optee_3

I would very much like to avoid the need for special bootloaders. The
devices we're talking about are WoA devices, meaning they _should_
ideally boot just fine with EFI and ACPI.

 From an end-user perspective, it's annoying enough that we'll have to
stick with DTs for the time being due to the use of PEPs in ACPI. I
really don't want to add some special bootloader for fixups to that.
Also, this would just move the problem from kernel to bootloader.

If you have any suggestions for another way of detecting this, please
feel free to share. I, unfortunately, don't.

Regards,
Max
