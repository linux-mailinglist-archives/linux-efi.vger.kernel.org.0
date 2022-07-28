Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40A584439
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiG1Qe7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 12:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiG1Qe6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 12:34:58 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jul 2022 09:34:57 PDT
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF42439BB4
        for <linux-efi@vger.kernel.org>; Thu, 28 Jul 2022 09:34:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi232.neoplus.adsl.tpnet.pl [83.9.2.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E13361F888;
        Thu, 28 Jul 2022 18:24:55 +0200 (CEST)
Message-ID: <ef8f8b68-1a21-6984-8373-4bf6f1d7ad72@somainline.org>
Date:   Thu, 28 Jul 2022 18:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
 <20220727132437.pjob3z2nyxsuxgam@bogus>
 <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com>
 <20220728113347.ver6argevzmlsc2c@bogus>
 <CAMj1kXHYb-zrKOS_titU79c487ab9WPyKwJBXuj7pdqum=ygaA@mail.gmail.com>
 <20220728161611.qc6ksoecg64rkov5@bogus>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220728161611.qc6ksoecg64rkov5@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 28.07.2022 18:16, Sudeep Holla wrote:
> On Thu, Jul 28, 2022 at 08:05:58AM -0700, Ard Biesheuvel wrote:
>> On Thu, 28 Jul 2022 at 04:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On Thu, Jul 28, 2022 at 12:48:19PM +0200, Maximilian Luz wrote:
>>>
>>> [...]
>>>
>>>>
>>>> I would very much like to avoid the need for special bootloaders. The
>>>> devices we're talking about are WoA devices, meaning they _should_
>>>> ideally boot just fine with EFI and ACPI.
>>>>
>>>
>>> Completely agreed.
>>>
>>>> From an end-user perspective, it's annoying enough that we'll have to
>>>> stick with DTs for the time being due to the use of PEPs in ACPI.
>>>
>>> But have we explored or investigated what it takes to rewrite ACPI f/w
>>> to just use standard methods ? Does it require more firmware changes or
>>> new firmware entities or impossible at any cost ?
>>>
>>> For me that is more important than just getting this one on DT. Because
>>> if you take that path, we will have to keep doing that, with loads of
>>> unnecessary drivers if they are not shared with any other SoC with DT
>>> support upstream. We might also miss chance to get things added to the ACPI
>>> spec as we don't care which means that we never be able to use ACPI on
>>> similar future platforms even though they get shipped with ACPI.
>>>
>>> It will be a loop where we constantly keep converting this ACPI shipped
>>> platform into DT upstream. IMHO we don't want to be there.
>>>
>>
>> Supporting these devices in Linux in ACPI mode would involve
>> reimplementing the PEP subsystem, and reimplementing PEP drivers for
>> all these QCOM peripherals to manage the probing and the power states.
>> I don't think this is realistic at all, and a huge waste of
>> engineering effort otherwise.
>>
> 
> I am aware of that and hence I am happy to see these as one off drivers
> if needed. But if we don't stop that or keep converting them to DT,
> IMO we will be in vicious circle of this conversion and will never be
> able to support ACPI natively on these platforms. 
I think that people have given up on ACPI on Snapdragon, as it was not
providing enough information in some cases (such as TLMM pins that are
not accessible from the AP due to being marked 'secure') that needed to
be hardcoded.

New WoA laptop support is added using FDT and I haven't seen any patches
even adding ACPI matchlists for a long long time.

Konrad
I know it is huge
> effort and not expecting that to be done here, but we need to convey the
> message to use ACPI standards or improve it if there is a need. Using
> PEP is not helpful to run Linux in the long run. Also we may hit a point
> when it may not be trivial to do that ACPI<->DT conversion.
> 
>> It is also orthogonal to the discussion, as far as I understand: ACPI
>> is not telling the system whether or not these TZ services should be
>> used instead of EFI runtime calls.
>>
> 
> Agreed and I don't want to block any such discussions. Sorry if I derailed
> the discussion, that was not my intentions.
> 
> --
> Regards,
> Sudeep
