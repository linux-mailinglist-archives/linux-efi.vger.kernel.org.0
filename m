Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB41583C7C
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiG1Kt1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiG1KtV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 06:49:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BE81CB2F;
        Thu, 28 Jul 2022 03:49:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w5so1631030edd.13;
        Thu, 28 Jul 2022 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1netyXqxN8LoQutKcJoVO+jDbqbk0SXq/iCrpa5tJis=;
        b=S7iooPA9SW/rWe0Vw/8nRSfGfhPN7ZrTceGOAkLKY+o+YF5WeIRcD9IleGdX3BMyiA
         hnh6NoDGtjgWJ7THpfiJBi38l0OukqxI3p90Lh/4juvvPZfZ/kOvRGkcLX9SWtaHrYhw
         ONZDPRYwcQ6PGMpuUh35R+vPkbNxT4k+OD7a/BUX3V1G1HuQaEqTXLlis0TXEBgaQzdQ
         KVF9wYu3GPwx/Ky8EuuxSPfxcsypHGgOilbBtalA8TURf6y0nTtGatyUjkPxmoIxSODA
         VTj0OQDfdi2SekzMVglNd3m79Kb7uc/8uvhczq0q0rGhFdQaSAWXcG2pJcyzBz6XHmpB
         8lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1netyXqxN8LoQutKcJoVO+jDbqbk0SXq/iCrpa5tJis=;
        b=h1kI9U12dibW/w03viVLUdnH/QJIZyaHKrEXj3Bad6paLzs0EM/8BIOk4dowI1URbe
         09IBtnKaPwQBx5i7syg+iyBoFPwkWpFsLCt/Eoxo0qCIaxFQo6TNn/P5kWd3jayepKsJ
         fGtGmHX4m9PXrBwdIhbd/TdYdnYzBWL1oiY2/+y1eLMJrvwqOsVxklYYNQBwVa50D5iC
         qHoDDQbVOklSKmIHHQQDPYGXpb7EUSZttgLQWPfDp3B29xr2AU+7/VJ8PmG2y9ViN1Ut
         8m1ppLWUPmrOdXun0Rt2R20kL7PBvD7spCQmRsI2jYCPH8H4FbsBP0wtd7TTYM3Igab2
         WuUw==
X-Gm-Message-State: AJIora/bA1GbS/dP1ZMorRUR9s/2vADeeWxNHvxz3kbN+ZIQ5qHjJO1O
        sIVFHuqLwucENtutq75Yf+I=
X-Google-Smtp-Source: AGRyM1s2Tyc60OcmMpIwUQW6VJAW25PxwvECWEIpLZdp9ffQnRO3HXtDAaFK8j5PDJ1FaC37ERLEQA==
X-Received: by 2002:a05:6402:1859:b0:43c:b0db:3f9a with SMTP id v25-20020a056402185900b0043cb0db3f9amr7638223edy.120.1659005359007;
        Thu, 28 Jul 2022 03:49:19 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea36f8.dip0.t-ipconnect.de. [217.234.54.248])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7d287000000b0043bc19efc15sm446272edq.28.2022.07.28.03.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:49:18 -0700 (PDT)
Message-ID: <5ec2dae9-39ca-f3d3-f9ae-11ad9fb59f2f@gmail.com>
Date:   Thu, 28 Jul 2022 12:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <e88d1036-dc58-3fc8-c388-edba9b2d62a7@linaro.org>
 <87c19c5a-d7f4-7183-1322-f62267e01b3b@gmail.com>
 <11e5c369-c0da-7756-b9e2-ac375dc78e9d@linaro.org>
 <2e522bcd-5d55-e87f-126c-514f5edaa560@gmail.com>
 <53a602e2-0590-6c6a-597b-fd55faa3a4ab@linaro.org>
 <acd7b231-3167-e35c-5cdf-8b3127a7d710@gmail.com>
 <95cbcda8-d1bc-376c-b338-92d1b923f04a@linaro.org>
 <fe2b820b-9f3b-814b-4792-e6685b13ede6@gmail.com>
 <d8510e53-673a-7913-32be-1be691a79511@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <d8510e53-673a-7913-32be-1be691a79511@linaro.org>
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

On 7/28/22 12:38, Krzysztof Kozlowski wrote:
> On 28/07/2022 12:25, Maximilian Luz wrote:
>> On 7/28/22 09:48, Krzysztof Kozlowski wrote:
>>
>> [...]
>>
>>>
>>> For example like tegra_bpmp_get() is doing.
>>
>> But tegra_bpmp_get() can also not differentiate whether the supplier driver is
>> ever going to be successfully probed or not. I'm not sure you can ever really
>> solve that. The only thing it does in addition is check whether the phandle and
>> device is there. Or do you mean those not being present by "broken"? That's a
>> point I agree should be improved with SCM.
> 
> Yes, at least it checks if phandles points to proper device and device
> is there. That's what we want.
> 
> We are not solving here case of providing being in a module which never
> gets loaded (thus endless EPROBE_DEFER). Such case is ok.

Got it, thanks for that clarification!

Regards,
Max
