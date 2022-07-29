Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3158521F
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jul 2022 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiG2PLJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jul 2022 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiG2PLI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jul 2022 11:11:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC06175BB;
        Fri, 29 Jul 2022 08:11:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q30so1960181wra.11;
        Fri, 29 Jul 2022 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xpR3E29/A9nc5RITUNo9yzDkYexPEEQLAxJsqHGPRlM=;
        b=GjySXkZbiKSHDRXi8/iFiMbWWJUy3IxxGLhr28E6V2rGQ4FLfZzBUQs9xfOw1jSW7N
         dmaw+ZHVRqt1DXkUGxkiC2qpmefkigwbJZf9L+byvQL+7yAZbucJaRhRT8LDnQn8+hxV
         qnlIEfbX2IEg8MQfQnBvsKWcxZguQNAdrOzqSt/jNmuge9joluAClgP4LunWcKaUBOTT
         sHH7bqiMzNkxCSA9C/KYEc2uNpVMng/lVxRqR+Okar7M9VMVpgcPdTqL4L06kkJPlvG+
         ukDrThmZw+TXIpz5ktJqYjZ2KU+92ENdrTi8AFvy5RSD3TyfjIe0F3uu4c6YA7BTVgLZ
         myFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xpR3E29/A9nc5RITUNo9yzDkYexPEEQLAxJsqHGPRlM=;
        b=WxJWzvrlN/D8Ti+sViWF706SgIbQeYd8qq1xJVF18V5U2pYqG2zf6VQmni7kR9Sn40
         z1s3fiUwoy2lY5b19ceLRR2i0IzjGmVmE9WJqrA1bdvaVhgC60X5+ksaS75VLjfTs1qG
         enOBK2hzeylsBvhR1L3mgSXtbFb6rCv23hgHpSgctiAi1l0beEpT3qlY3MuGpblZe1+k
         dcauVBCoDgEZgFZBJT5050l58xtLGCwPQTUIC+16mmMhPG/y1Saaf55RpzSgVgKNwEVl
         ydBtAIKUWVs5Hg/784o7Wx/cMOkDpmiXiOtukYnljy+Gk8tcg0sCmgSnvTGJAgDY00nQ
         6hfw==
X-Gm-Message-State: ACgBeo20zUpNvM6NBz0bV/xaBOvmAcU+HHlGiCgougqVN375gjWX76el
        hev7yBd86DB2//ry3VITlzk=
X-Google-Smtp-Source: AA6agR7e2boDjM41jCQg2pq7nhx4wFbSqs4syky7BvMUTysFCiJEc7ktjZY47bTJ99nZpteZJak1BQ==
X-Received: by 2002:a5d:5c08:0:b0:21d:854a:7009 with SMTP id cc8-20020a5d5c08000000b0021d854a7009mr2670770wrb.263.1659107465544;
        Fri, 29 Jul 2022 08:11:05 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea3777.dip0.t-ipconnect.de. [217.234.55.119])
        by smtp.gmail.com with ESMTPSA id bh15-20020a05600c3d0f00b003a4a5bcd37esm1494237wmb.23.2022.07.29.08.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 08:11:05 -0700 (PDT)
Message-ID: <097eb672-ee9f-523c-d52d-79e723a7bf2c@gmail.com>
Date:   Fri, 29 Jul 2022 17:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
References: <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
 <20220727132437.pjob3z2nyxsuxgam@bogus>
 <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com>
 <CAC_iWjLWBJLth26ifFfHvimProHZu_w5SjQNWSH_D2Fs_JXjbA@mail.gmail.com>
 <b703f678-b2c5-cdeb-ac40-9646e043d1c3@gmail.com>
 <CAC_iWjLrntWuJUzVuRi0ZOtG6JXNwz7SbS2mrqpuTgU5TV6rQA@mail.gmail.com>
 <d5a19e17-08eb-8bd6-ea18-5da638d13622@gmail.com>
 <20220729085214.bh2cak5g2hcqun4i@bogus>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220729085214.bh2cak5g2hcqun4i@bogus>
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

On 7/29/22 10:52, Sudeep Holla wrote:
> On Thu, Jul 28, 2022 at 07:27:19PM +0200, Maximilian Luz wrote:
> 
> [...]
> 
>> My current suggestion (already sent to Sudeep earlier) is (roughly)
>> this: Add one compatible for the TrEE / TrustZone interface.
> 
> Still I don't understand why you need extra compatible if you know
> this laptop(with a unique compatible to identify it) always runs this
> TrEE interface.

First of all, to recap: I suggest adding a device and driver for the TrEE
interface, with a compatible for that. That then (based on platform)
instantiates devices and drivers for the applications running in TrEE. The
compatible I'm talking about is for that general TrEE interface. Not any
specific application.

a) Because this better reflects the ACPI tables on those devices. As I've said,
    there is a HID specifically for the TrEE interface. You were concerned
    earlier that we should try to add support for that, and now you want to
    create a purely artificial divide between ACPI and DT? Ideally, we can have
    the driver load via both the DT compatible and the ACPI HID depending on
    whether we use one or the other without many other changes.

    Would you equally suggest that we not load the driver by its ACPI HID and
    instead do DMI matching?

b) Qualcomm also has a DT compatible for this (qcom,qseecom), see e.g. [1].
    Note: they seem to have changed the name from Secure Execution Environment
    to Trusted Execution Environment, at least in their Windows driver. This is
    why I used "tee" instead of "see" (also their naming of things is somewhat
    confusing and seems to change randomly). Fundamentally, this is the same
    interface (they just implement a lot more things in their driver, the couple
    of functions I proposed here handle the absolute minimum required for
    uefisecapp, it can always be extended later when needed).

c) Given their naming of the DT compatible, this interface itself is pretty
    much guaranteed to be stable. It's definitely not going away with some
    firmware update. So your earlier concerns about having to update the DT in
    case of firmware changes do simply not apply here. It is a core component of
    these platforms. As far as I can see, your "let's load the TrEE driver via
    the platform compatible" suggestion is now exactly the same as a "let's load
    some PCIe controller via the platform/SoC compatible". It's an interface
    that is either present or not present, depending on the device. We're not
    encoding any firmware specifics (ie. what's running inside the TrEE) in the
    DT, we just say that it's there (the rest is decided by the driver, e.g. via
    platform compatibles or DMI matching).

d) By specifying it in the DT, we can properly link it up via a phandle to the
    SCM and properly model the supplier/client relation between them. While we
    can't do that with ACPI, I think it's still a good idea to handle this
    properly in times we can.

Regards,
Max

[1]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/auto-kernel.lnx.4.14.c34/drivers/misc/qseecom.c
