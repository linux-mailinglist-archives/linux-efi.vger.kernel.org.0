Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EAA581634
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiGZPPt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 11:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiGZPPs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 11:15:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3E17E37;
        Tue, 26 Jul 2022 08:15:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ss3so26638446ejc.11;
        Tue, 26 Jul 2022 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=30GuoeOYEvgEQlnD0yosJbbGlRpqnBP8ZH8v0N+fbbM=;
        b=WA9cp6J4DMRCi6V/ZUoDCx4Wggz6MkNUhuqxfezjLmF1FgU6HooYR4VlbHI5bN4y/T
         lRAMp473cFVjMzq94EeSV4cpMBtm1y4if9fWoNBlHo07PQX7DAIXqJbqCoOc3KxxIjFA
         h7ogDzORqjuCRbY/nmNRbRD7yo1gLtv0MTGRONdv7Q3qGHODXCIcex/kqrgOUyJNqvVd
         FjglzRRvUN47zp6G1o/8S+y05ziKBuHHbTCaUKaYIVbJ2Og3nxQERpV+KjTjpdXFZ8T6
         XX6RrTF7agiS4WETWDVOrKzoNdosM1AIsGmIs/noTZmB8+p6fKpc2FAoz/WiHLYijCnS
         7FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=30GuoeOYEvgEQlnD0yosJbbGlRpqnBP8ZH8v0N+fbbM=;
        b=TDgd96YvW+qLdIbESibZZUA/ovaoY9+mhRO6OPNd2GVUOpVrv6KXk0JmLoFC/4Wsfi
         NE7JRfP1fAyi8d8AueKZIrBvO9IblVyKhRYBBrcBHre+4XWwWwX4Ec+4dW41oba3YAA7
         Wr/4uNwo9pkZ+94+FfD3ildfRAVxIKMQel188aUECjDqU6t7sn7MaBiboRxF+/6cn6dx
         eMHWJrgU8vcr8A7WwhZloWvV0v/CNrnfaPf4otUK55WOgA3eg6+2peE6h8C6eVCGsAaY
         bth0wUkysxIh/z4OXETSQi5PdYJ9sooDNXXYdgBvJNdqJF0kRynzoj+sMkEty6hyPK07
         31zA==
X-Gm-Message-State: AJIora/cnG4rT8p6tiGnH2aeAsRuQDOmmcgbeHvIYT/wJZCXprrdeLQy
        sLjccca+UyvN/Tt3/ovX3P4=
X-Google-Smtp-Source: AGRyM1t3w6HTBhhoGB8HDsuc1By/1sTlXh3Y1sOyLWo7gXako1oA99HHAoo8isN8KKOguO0yWOgcVA==
X-Received: by 2002:a17:907:7ba9:b0:72f:2994:74aa with SMTP id ne41-20020a1709077ba900b0072f299474aamr14486870ejc.85.1658848543107;
        Tue, 26 Jul 2022 08:15:43 -0700 (PDT)
Received: from [10.30.0.4] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id ca17-20020aa7cd71000000b0043c92c44c53sm193645edb.93.2022.07.26.08.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 08:15:42 -0700 (PDT)
Message-ID: <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
Date:   Tue, 26 Jul 2022 17:15:41 +0200
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220726143005.wt4be7yo7sbd3xut@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/26/22 16:30, Sudeep Holla wrote:
> On Sun, Jul 24, 2022 at 12:49:49AM +0200, Maximilian Luz wrote:
>> Add bindings for the Qualcomm Trusted Execution Environment (TrEE) UEFI
>> Secure application (uefisecapp) client.
>>

[...]

>> +examples:
>> +  - |
>> +    firmware {
>> +        scm {
>> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
>> +        };
>> +        tee-uefisecapp {
>> +            compatible = "qcom,tee-uefisecapp";
>> +        };
> 
> Do you expect some issues using the scm driver APIs without the
> any additions in the DT ? I mean can't you auto-discover by using the
> APIs. I haven't looked at the driver or any other patches in the series,
> but I would like to know if we can avoid adding any new bindings if it
> can be discovered via those SCM driver APIs.

Not at scale, at least as far as I can tell.

Part of the setup-process of this driver is to query an "application ID"
from a unique string identifying the application (in this case
"qcom.tz.uefisecapp"). If that call fails, we know the app is not there.

But: If we'd want to support more than just "uefisecapp" we'd have to
query each app in some predefined list. As far as I can tell, there's no
method to enumerate all present/loaded ones. The Windows driver seems to
use a hard-coded list of apps that are present on some specific SoC.

It might be possible that there exists such a method, but if it does, the
Windows driver doesn't seem to use it and I don't know about it.

Also, there would need to be at least some type of compatible to
indicate the presence of that TrEE / Secure Application interface used by
uefisecapp. Unless you want to send some potentially unsupported SCM
commands on every platform with qcom,scm and see what comes back.

So ultimately I think it's better to add a DT entry for it. That also
(hopefully) ensures that someone tested and (at least in some way)
validated this. Again, It's a reverse engineered driver.

Regards,
Max
