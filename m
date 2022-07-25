Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18C58055C
	for <lists+linux-efi@lfdr.de>; Mon, 25 Jul 2022 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiGYURW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Jul 2022 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbiGYUQ7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Jul 2022 16:16:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADCF21AA;
        Mon, 25 Jul 2022 13:16:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id tk8so22565369ejc.7;
        Mon, 25 Jul 2022 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1LB4h7RUeI5nyKeiuIHX5PjhDQREhdZ4FNcrFfCB7U4=;
        b=U4OLlypiRRhseDmkFOYxXhlv21DUsTfdZT0gzQa9a/CypKhfO8CjtutobNBEoBSdgN
         x4O5bFDoV1U/gNu5n5uUwd7iMUruJfmHUogB5CT7Y1aquQpSUQqUC2ZErI3YnueL3zOA
         NAjAQv1hXQrMQtE6C2LxkBXxTrfdiIrzQUs2ql53rwRNZMwMriKB9IZZmKtA0/l9CshK
         fYVg37d+2b8BHQOkADVRCdR2jxcQBo17gHWzHt79m+yeubPofJlL6+InWI6v9jZVOPXR
         ZOeViLq4yLBQ31qGf8uL5XdItG1/G8Zg7T4ZgSc57FAsQacSOkoreo1yP18bfG4BOWp3
         /FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1LB4h7RUeI5nyKeiuIHX5PjhDQREhdZ4FNcrFfCB7U4=;
        b=KSymtLHCyt9gX2kGPca2E1uNErYMJa233x+Ra/zzviO2br+4gCRvVHSk7p5T8pAXJz
         PMyQTTEQyYi85hGwpoCnV6fz3o8UqYU5+k+ZhY/MY/PlfoLndF6K0tdmpwo/L1dCpGL8
         JgfOwyCcdRE/vFyr+1U9U7EOB4/dIjXA1eAJMMP7oyHZMsov6VFJQc1BSn3BNk8qMul1
         rfr/AOYV3HQpxUuG1KNWjN4VahaDOhT4cyJtVlYKgJFF6iG+RSN8kVshPWTRHtOku1TT
         Nbv02jBLpCzYLYxP7nkMrHQ7HCCx6SKyYJJFz51Rl8G+pSxY0WI02PbyMuZAb5NDk2Bp
         8/HQ==
X-Gm-Message-State: AJIora+NR0Ewtvo6e/gpkd/w3hkPLSHd8uvfrmQDj8ocoKHm5ix/kHjI
        1FxSMB+k0mc1/Qea4Pzk8Xc=
X-Google-Smtp-Source: AGRyM1vN7nmZYHuc+Fid++W6GdFXS/blopSWsF3pVAWf8XCAMdv0NgolnVD3P5v9dqDv3gq5n7OvbA==
X-Received: by 2002:a17:907:d1f:b0:72f:5d89:d08 with SMTP id gn31-20020a1709070d1f00b0072f5d890d08mr11510881ejc.231.1658780216121;
        Mon, 25 Jul 2022 13:16:56 -0700 (PDT)
Received: from [10.31.0.14] ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id d3-20020a170906370300b006fed062c68esm5603651ejc.182.2022.07.25.13.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:16:55 -0700 (PDT)
Message-ID: <468b6e00-5d77-da64-164d-149bb640e902@gmail.com>
Date:   Mon, 25 Jul 2022 22:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220725192705.GA2536409-robh@kernel.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220725192705.GA2536409-robh@kernel.org>
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

On 7/25/22 21:27, Rob Herring wrote:
> On Sun, Jul 24, 2022 at 12:49:45AM +0200, Maximilian Luz wrote:
>> On modern Qualcomm platforms, access to EFI variables is restricted to
>> the secure world / TrustZone, i.e. the Trusted Execution Environment
>> (TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
>> therefore need to talk to the UEFI Secure Application (uefisecapp),
>> residing in the TrEE.
> 
> The whole point of UEFI is providing a standard interface. Why can't the
> UEFI implementation call the TEE itself?
> 
> I'm not sure custom interfaces is something we want.

Unfortunately, I'm not a Qualcomm engineer and in no way affiliated with
them. So I probably can't convince them otherwise. Believe me, I'd like
to :/

First: The uefisecapp-driver is based on reverse-engineering. So please
take things below with a grain of salt, I may be wrong. I've tried to
lay this out in a bit more detail in patch 3, but I'll try to be more
precise here:

For some reason unknown to me, Qualcomm decided to lock away UEFI
variable access via their TrEE framework for applications running in the
TrustZone (or whatever that is exactly). To call to TrEE applications
(like uefisecapp), they use SCM calls. Those SCM calls unfortunately can
be a bit more complex. As far as I can tell, you essentially call to
some hypervisor in the TrustZone which redistributes them (if necessary)
to the respective application. Their downstream driver for that is at
[1] and supports callbacks and re-entrant calls. As far as I can tell,
the latter means that you can't run multiple SCM calls in parallel (at
least not to that TzOS/TrEE interface) and can only ever have one
"client" performing them.

And as you can only ever have one entity performing those SCM calls, you
cannot have both UEFI and the kernel doing them. To me, it seems to be a
deliberate decision by Qualcomm to return EFI_UNSUPPORTED from the
GetVariable etc. calls after exiting boot services. They do work just
fine before that. Essentially exiting boot services transfers ownership
of that SCM interface from UEFI to the kernel.

Note: uefisecapp is also not the only TrEE application in use by those
kinds of devices. For example, on the SC8180X based Surface Pro X that
I'm using, there are at least an app for the TPM, a bunch of apps for
HDCP, some winsecapp, and as far as I can tell also other cryptographic
interfaces. I've tried to collect my findings about those in [2].

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
> 
> What does Windows do on these devices? I'm surprised something like this
> would fly with Microsoft.

It looks like Microsoft accepts this. They even seem to have some sort
of interface for EFI variables via trusted execution environments: [3].
This is essentially what the QcTrEE8180.sys driver I've reverse
engineered this from seems to provide.

So unless there's some way to make EFI variables work via the standard
functions that I've missed, I don't see any alternatives. I think it's
fairly unlikely that we can convince Qualcomm to make their UEFI
implementation behave properly (variables are not the only issue, it
seems that other functions are either partially or completely broken in
some way or another...) and then also push updates for a bunch of
devices (e.g. the Lenovo C630 also using this stuff is discontinued, as
far as I can tell).

I am open to suggestions though...

Note that this series also doesn't really introduce a new interface for
EFI variables themselves to the kernel. It relies on the existing
efivars_register() / efivars_unregister() functions and the interface
provided by them to enable access to EFI variables. So we already do
have a "workaround" for broken UEFI variable access in the kernel.

Regards,
Max

[1]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/auto-kernel.lnx.4.14.c34/drivers/misc/qseecom.c
[2]: https://github.com/linux-surface/surface-pro-x/issues/37
[3]: https://github.com/tpn/winsdk-10/blob/9b69fd26ac0c7d0b83d378dba01080e93349c2ed/Include/10.0.16299.0/km/treevariableservice.h#L11-L12
