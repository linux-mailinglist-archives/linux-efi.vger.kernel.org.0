Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765CE587CFB
	for <lists+linux-efi@lfdr.de>; Tue,  2 Aug 2022 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiHBNWq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Aug 2022 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBNWp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Aug 2022 09:22:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5114036;
        Tue,  2 Aug 2022 06:22:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tl27so8061718ejc.1;
        Tue, 02 Aug 2022 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s3FK7mQPNn8j8Six5edf3/NjZ+hzFIigo3x+IFlhAl0=;
        b=N8NlMxJIhVZDuK1OlyajxXvsLry5BavyKbCf+XpEqtjVol9fy0DkELNK7gBn8ShSRr
         vfzpSGxhxX8MBbH1hSstoIDwXKaJDZTY3RJPiPAXSd51fIfd1HIcrwktkWcT05AUd8LV
         XLDg/gcgvExoN0N9RMsqxngACo8m0yo/SnD/ktBJk4dcsFNXXUwmp6rAO+fqsuij8J0d
         D3UQZyD4Ks6ZWHXX7XNC3IwWv46CqubQTKgUDUGAqTI8YVuBmsp3juCcJtlsLugBESVj
         4rGMaS2JG1N3txZ6XeIJhw2ScDnL/6P2KyCiA1ROWAcZUQ8BdK8z6WU+3qi5NOXRnGms
         C3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s3FK7mQPNn8j8Six5edf3/NjZ+hzFIigo3x+IFlhAl0=;
        b=5h9tDI4UaP+p4jFVHbbCKyoIVdbECcdGQJcMvOtiIe0mYvJgRwizbJTqsA1ibuS5sU
         B7JZAVRHiXKdvlUEOmUVsN7XT09yx98nZuNJu7Xnm2u1eSncohufyFHQw9ZpTSE45kku
         GrSGmdX67VAaB1vFW9r2xVkhDXKF9xvR5YBfkXuciT4f/PYf0w4vbw1i8/HF/C7+p9VE
         HzFYJ16u1I1m9RGSpeFo2pbeKuhP0rJCJIYpikZd/D/WL535N/EKbJP8RwPBK1tK1mvW
         cZOLiqA0sSwmXepDGJruvEWJKDl3lRI+TOTFIdb/S2gTQ2ubomcJz5EGqtQmJ9HOwPWq
         G5eg==
X-Gm-Message-State: ACgBeo0T3NDWjzZgLoUNDQbrB7qacWa5UAKe+8dTLQ1ll/OO5TcFYy4+
        NzpbKmX16kGgpqigeGf8dv0=
X-Google-Smtp-Source: AA6agR6lweVY6inGtYktpi3NOi1GaLn6GVF3FNPsNArznBe9UTHG+vMm0/HtuqES69pOwtYYykJseA==
X-Received: by 2002:a17:906:478d:b0:730:a5ed:1bf3 with SMTP id cw13-20020a170906478d00b00730a5ed1bf3mr1019481ejc.255.1659446562438;
        Tue, 02 Aug 2022 06:22:42 -0700 (PDT)
Received: from [10.22.0.4] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906175100b00718e4e64b7bsm6262602eje.79.2022.08.02.06.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 06:22:41 -0700 (PDT)
Message-ID: <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
Date:   Tue, 2 Aug 2022 15:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org>
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



On 8/2/22 13:51, Srinivas Kandagatla wrote:
> Hi Maximilian,
> 
> On 23/07/2022 23:49, Maximilian Luz wrote:
>> On modern Qualcomm platforms, access to EFI variables is restricted to
>> the secure world / TrustZone, i.e. the Trusted Execution Environment
>> (TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
>> therefore need to talk to the UEFI Secure Application (uefisecapp),
>> residing in the TrEE.
>>
>> This series adds support for accessing EFI variables on those platforms.
>>
>> To do this, we first need to add some SCM call functions used to manage
>> and talk to Secure Applications. A very small subset of this interface
>> is added in the second patch (whereas the first one exports the required
>> functions for that). Interface specifications are extracted from [1].
>> While this does not (yet) support re-entrant SCM calls (including
>> callbacks and listeners), this is enough to talk to the aforementioned
>> uefisecapp on a couple of platforms (I've tested this on a Surface Pro X
>> and heard reports from Lenovo Flex 5G, Lenovo Thinkpad x13s, and Lenovo
>> Yoga C630 devices).
>>
>> The third patch adds a client driver for uefisecapp, installing the
>> respective efivar operations. The application interface has been reverse
>> engineered from the Windows QcTrEE8180.sys driver.
>>
>> Apart from uefisecapp, there are more Secure Applications running that
>> we might want to support in the future. For example, on the Surface Pro
>> X (sc8180x-based), the TPM is also managed via one.
>>
>> I'm not sure whether this should go to drivers/firmware or to
>> drivers/soc/qcom. I've put this into firmware as all of this is
>> essentially an interface to the secure firmware running in the TrustZone
>> (and SCM stuff is handled here already), but please let me know if I
>> should move this.
> 
>  From what I see so far is that this is adapted from downstream qseecom driver, this approach could work for a limited usecases but not scalable, as we cannot add drivers for each Qualcomm specific TA in kernel.
> This has to be handled in much generic way using Linux TEE framework, and let the userspace side deal with TA specific bits.

I generally agree with the sentiment, however UEFI variables should IMHO be
handled by the kernel. Moving handling of those to userspace breaks things like
EFI-based pstore and efivarfs. The latter will in turn break some user-space
tools (most notably efibootmgr used by e.g. GRUB and I think fwupdmgr which
needs to set some capsule variables). Ideally, we would find a way to not break
these, i.e. have them work out-of-the-box.

A similar argumentation might apply to the TPM app.

> AFAIU, Qualcomm is moving away from qseecom interface to new smc-invoke interface, most of Qualcomm SoCs starting from SDM660 already have support to this.
> 
> This interface provides a better abstracted IPC mechanism to talk to TA. Most of these TA specific interfaces are packed in closed userspace source.
> Having said that QTEE smcinvoke driver can be modeled as a proper TEE driver with Userspace driving the TA specific bits using existing tee uapis.
> This also brings in other features like loading, Listeners aka callbacks, secure memory allocations..etc.
> 
> In the past, I have tried to do a prototype of this smcinvoke driver as a proper tee driver, incase you are interested patches are at https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-qcomtee
> Plan is to discuss with Qualcomm and send it for upstream review.

Thanks for this information! So as far as I understand it, this is currently an
interface to user-space only, i.e. does not allow in-kernel drivers for apps?
It would be great if this could then be extended to handle (the bare minimum
of) in-kernel drivers (i.e. only things that the kernel itself needs, like EFI
variables). Alternatively, I'm happy to hear suggestions on how we not break
the aforementioned things while moving handling off to userspace.

> I think its worth exploring if uefisecapp can talk smcinvoke.
> I can ping Qualcomm engineers to see if that is doable.

I think that would be great! Thanks!

Regards,
Max
