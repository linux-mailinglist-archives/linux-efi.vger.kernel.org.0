Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE35828EF
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jul 2022 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiG0OtN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jul 2022 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiG0OtH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jul 2022 10:49:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842631F2D9;
        Wed, 27 Jul 2022 07:49:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w5so9271893edd.13;
        Wed, 27 Jul 2022 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LPaTuaFLmOEbvjKAXJoZqNhvaMcLCTVz2uTxxpaOLT4=;
        b=IpQvEM5IglDTK4hAIv8rSOsoPmWxlqFrhka50slFaDm522pphQTqkRRrvZi93Dj3rw
         FbXbFIDuMr5F6QqH8l3Y0wjnfYVEj/+iyCC/wpZV5zpwM1qhVoWjY9Mdvde1ZO4x3MBc
         /OOZLkgzvF5NDtZtV8omSW3HeeLJPpnceD3iniuqHf535QgOzD7Eujhv/uH5S5XpT8Ah
         dmzQxEGYWtrCHh6IG7S6khuGaGWNrHncNfxgc2a01gaT50VWl9f9Tzg4pwDxIj8EKHbh
         ynZzvwyhC3lqxPT/YTB1IweGAX8tgVejCbJSZQnGhRI7OouNtjg4QBH5VqstAxHX24pj
         KX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LPaTuaFLmOEbvjKAXJoZqNhvaMcLCTVz2uTxxpaOLT4=;
        b=g6ZngTpTskpsXotS5z63oqw7k+4pF8WW2v5im+u4BU5uRunYtUB4clDn+rm0b7KPQg
         0QuEpz4i5nSsUKlYRKnpBx116fDWaI5agzLUdXmG0g0jS0pqT10go4LOhaFY+E2j1+ow
         ueF7dVX8zZkULTIu+y0o5WqKFy6IUgIDOzk+4SO858XUNO51ZzsGMtumXNtP+NihSh0E
         IrxlblMoXMghX38zVaplxzy+B6hwx3JAut+NLAkCJtdKHDJxiQjo+KdyJ7IyM6VHJPti
         XOuH0QIwVkBQ180ERB8QJxB4AN6wYe4t8ZX9U6EI8nU4/waBJ1fc9gdr8dl1lyGMAfb5
         7mBg==
X-Gm-Message-State: AJIora/KVfX8gHdlh1t62NefL/DFuqyKwdS6/T6TARAsbOfeq2zYstCY
        42Fy+u6jEHKYj5W73z3WxmU=
X-Google-Smtp-Source: AGRyM1shuKmZUHOkozD8SxT5PDgQ2V3xwex/Ty5Pm1tskXeLPr52wvprybERDmBArchv7c9JzDvLIw==
X-Received: by 2002:a05:6402:518:b0:43c:a863:55b with SMTP id m24-20020a056402051800b0043ca863055bmr4478615edv.127.1658933345043;
        Wed, 27 Jul 2022 07:49:05 -0700 (PDT)
Received: from [10.20.0.4] ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id nc19-20020a1709071c1300b00722d5b26ecesm7751494ejc.205.2022.07.27.07.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 07:49:04 -0700 (PDT)
Message-ID: <7adebeff-a335-8331-bb22-32229f96281e@gmail.com>
Date:   Wed, 27 Jul 2022 16:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220727132437.pjob3z2nyxsuxgam@bogus>
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

On 7/27/22 15:24, Sudeep Holla wrote:
> On Wed, Jul 27, 2022 at 03:03:49PM +0200, Maximilian Luz wrote:
>>
>> Is there really a good way around it?
> 
> Yes rely on the firmware preferably auto discover, if that is not an option,
> how about query. It seem to be working in your case.
> 
>> As far as I can see the alternative (especially for the apps that
>> need to be loaded manually) is hard-coding everything in the driver.
>> Which IMHO just spreads device specific information everywhere.
>>
> 
> It may not be too bad compared to putting loads of firmware details
> in the DT. What happens if you get a firmware upgrade with changed
> number of firmware entities or even if the names are changed.
> 
> Are these name user ABI in a way that they won't be changed ? Generally
> these entities tend to use UUID and the name you have might get changed.

I am pretty certain that these names do not change for a device once it's
been released. The full ID of the uefisecapp is "qcom.tz.uefisecapp". The
built-in firmware parts here are core components. So I really do not expect
them to just remove or rename things. If they would do that, that would
mean that, on Windows, access to things like the TPM or UEFI variables
would be broken if both the driver and Registry are not updated in parallel
with the firmware. So while I can't myself guarantee that this is a stable
name and interface, it's very much in MS/Qualcomm's interest to keep it
stable.

Also, I'm not advocating on putting loads of details in the DT. I'm (in
this series) advocating for a DT compatible that says "this device stores
EFI variables via that firmware interface". I'd be very surprised if
MS/Qualcomm suddenly decided to change that out for another interface,
potentially breaking their own software and devices.

> I would ideally prefer even the name to be supplied from the userspace.
> In this particular case, make this a driver and have the name as the
> parameter. If the secure side services are used by some non-secure
> applications, then you will need to have a user-interface which means
> you can get the named from the userspace. No need to change the driver
> in either case. Please let me know if I am missing anything to consider
> here.

 From userspace? For access to EFI variables and (hopefully in the future
if I've managed to reverse-engineer that) the TPM? Those are things that
should work out-of-the-box and not require the user to first have to
configure something... Also, those are things that the kernel might want
to use (e.g. EFI variables as pstore for crashdumps) before the user is
even able to configure something (unless we now want to specify things
on the kernel command line...).

If this were something that only userspace would use then sure, let
userspace load it and do all the work. But it isn't.

> 
>> Also: Let's use the TPM app as example. If that would be a SPI or I2C
>> device, you'd model it in the DT. Just because it's a hardware device
>> that's accessible via SCM/firmware you now don't?
>>
> 
> Not sure if I understand the comparison here. But if there is some device
> that is access restricted but needs to be accessed and has mechanism to
> access, then you would model it as device in DT.
> 
> But the one $subject is addressing looks pure software and doesn't make
> sense to model in DT IMO.

So as soon as access runs via some firmware mechanism, it should not be
in the DT? The TPM in the example above would also be accessed via some
firmware API. EFI variables are stored on some SPI flash that is managed
by the TrustZone. So in both cases kernel calls to firmware calls to
device. Where do you draw the line?

>> If I were absolutely certain that there is a reliable mechanism to
>> detect these apps, I'd agree with having a driver to instantiate those
>> devices. But I am not.
>>
> 
> You did say you use some query API to check this. I haven't seen the driver,
> so relying on what you said earlier.

I did say that there is an API that turns a unique identifying string ID
of a secure application into a runtime-dependent integer ID of the
running application, returning an error if the application is not
running. I very much doubt that is supposed to be used for checking
support of certain applications. It could _maybe_ be used that way, but
the Windows driver doesn't, which makes me not very comfortable doing
that either.

Further: As far as I can tell, there is also no way of checking whether
that lookup failure is due to the application not being present or whether
something internal to the firmware failed. the respective results that the
call can (as far as I can tell) return are:

	QCTEE_OS_RESULT_SUCCESS			= 0,
	QCTEE_OS_RESULT_INCOMPLETE		= 1,
	QCTEE_OS_RESULT_BLOCKED_ON_LISTENER	= 2,
	QCTEE_OS_RESULT_FAILURE			= 0xFFFFFFFF,

And it will return QCTEE_OS_RESULT_FAILURE when the app name is wrong.

Again, while it _might_ be possible to use that, I don't think it makes a
very sound approach and I would really prefer not using it in that way.

Regards,
Max
