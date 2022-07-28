Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A452D583DEB
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 13:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiG1LqD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 07:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiG1LqB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 07:46:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131CABF64;
        Thu, 28 Jul 2022 04:46:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e15so1848241edj.2;
        Thu, 28 Jul 2022 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jb4sTwGYudzeMZpzODVtElAjSD+BHCr3smpqZiVPtPg=;
        b=F0dIY41MUWVtomDbuOASiczdY4epsBOlIPUMk+Zx+JfWceMdB8Z6+w2BKeCMmMIT0J
         dqskrP7CEUTTxjXsiJe74b5dSNN1Hdy2WM/V/YATqFyOZ0MZDstsQ1iingE5DUyZyBJ8
         J3dGQjsNcQY9BiK+Bjkr7Zpy2U1B9x5/pWA1p4R0jzhU/eCZOeEyhlbp7KFQYcrf7ySF
         BT6orMmij+SjdA+ZCXzw8J7dAEbrCu8K3rR0fXVkrvw18iIRlFKqYXe4NoDkl/MDiS+7
         I+PH3+2DM++iUMdB6prHX+c3LSakjSgYy6KwcNGjEfNDqqukpTiRZWigsFEpnWQ91fV9
         9svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jb4sTwGYudzeMZpzODVtElAjSD+BHCr3smpqZiVPtPg=;
        b=koxIRPdrU4QcbD0kxr2MN9GWOhyD5CG+72GEsNNLcCRUo5GMEl9/Kq/96AL/mLqI2r
         B5gE/WDk7Uv81foUahVPxxDR5BDrXZistSUe4IKDwwZjDkbTp7YBNfVg5JbzBrIyRbnc
         uoEPGFzObnaZwev0vTXiU01aOUGyU5G6hWli6hMHh1R8LMHeVqLu9gCY5JE0BLtKUKTa
         QAi9nrRya2SZjBuhj7anqv7bZIJO8UVF7A9p94XLxS0+NjF9CdK5iiWZbkqWOQymjpZE
         +0cg2zkCw0N5PyF3amHoHVpjoOFaQ+CE7u+utfmgE9eB3EnlhXa6Ao9oNjy5nkCUpmdh
         5GZQ==
X-Gm-Message-State: AJIora9rgCiKCkOi0NcFg35Cj8DGLznrx0b3hNU4lbvgDi4ApmZ6OuIn
        rP3nHFwuOem5+fn1FJJ/BBg=
X-Google-Smtp-Source: AGRyM1vrOHrrFrYpoR24V9fFtx+QZaGulCsCxDHPCEgwzqdNXtWLr8jrUU1xnICMv86CFeggnRIOBQ==
X-Received: by 2002:aa7:db8a:0:b0:43b:75b1:92e9 with SMTP id u10-20020aa7db8a000000b0043b75b192e9mr27041815edt.223.1659008759613;
        Thu, 28 Jul 2022 04:45:59 -0700 (PDT)
Received: from [10.31.0.4] ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b0072b2ffc662esm324560ejh.156.2022.07.28.04.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 04:45:59 -0700 (PDT)
Message-ID: <b018e909-e371-fd57-2790-9f0a37b63f29@gmail.com>
Date:   Thu, 28 Jul 2022 13:45:57 +0200
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
 <4e777590-616a-558a-031e-3ef1f1e492b4@gmail.com>
 <20220728112150.hs5el6wufljeoqyy@bogus>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220728112150.hs5el6wufljeoqyy@bogus>
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

On 7/28/22 13:21, Sudeep Holla wrote:
> On Thu, Jul 28, 2022 at 12:05:15PM +0200, Maximilian Luz wrote:
>> On 7/28/22 10:23, Sudeep Holla wrote:
> 
> [...]
> 
>>> Worst case I am fine with that as this needs to be one of and future
>>> platforms must get their act right in designing their f/w interface.
>>
>> Again, I fully agree with you that this situation shouldn't exist. But
>> reality is sadly different.
>>
> 
> As I mentioned I don't have final authority to say yes or no to DT bindings.
> I have expressed my opinion and I thing allowing this to be generic via DT
> bindings gives no incentive to get the firmware story right. Hence I am happy
> to see this as one-off driver change and then we more changes are added to
> the driver or similar drivers get added in the future, we have a change to
> demand what action has been taken to fix the firmware story.
> 
> Just adding DT support(which I disagree) will make future platform to just
> use it and not get improvements in areas of discovery or query from the
> firmware.

Okay, that is a good point. Although it's probably debatable how much
control we have over what goes on with WoA devices.

Would something like this work for you: Add a compatible for the TrEE
interface (e.g. qcom,sc8180x-tee) but not for the specific apps running
in that and then instantiate the app-specific sub-devices from that. We
would still have to hard-code app-names in the driver (i.e. shift the
problem from DT to driver and potentially create soc-specific lists),
but they're no longer in DT (again, I'm not a particular fan of this but
I could live with that, if needed).

We can then look for a solution for apps that need to be manually loaded
or vendor/device specific apps once those becomes an issue.

Regards,
Max
