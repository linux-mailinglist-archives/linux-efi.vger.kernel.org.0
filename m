Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092E1635C55
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 13:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiKWMFI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 07:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiKWMFI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 07:05:08 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749A215FE2;
        Wed, 23 Nov 2022 04:05:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vv4so33002323ejc.2;
        Wed, 23 Nov 2022 04:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdkN33eqdBW8OFqoAkyIS40FmG3oWWH+dzPo/Vz7+AA=;
        b=IwVLuZWWCilVb/mBFTdCkpJ/FyKCtl9qhLxekbfU3z6dSIbpf5HaE5M7yhDhpHR+Tl
         Phudcd9OSkRwijiEw/baWROlfEKW9FdwH6B7Syq014lQMA54GfmjMV+AOXvds7sbuWf3
         Zuaki/kU7fiFL2Z8Dj36y+wQBuxN/uC80aHsISXdWCzF6DSRxMQsu7sYq/5oM+t+G/Jm
         p2lfngOI3XWaqkJyzgFvxkiOJxObGbiLTt2UNRqXOV4lL69TuMcSVgmjCqNj1YRFJ6Sa
         t69NBYYsQdWuLVZhegvYJdSYa8m+8npCWow47ilp0RyKpnlTFmSvCk+iqxGQTxJgCGUy
         vyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdkN33eqdBW8OFqoAkyIS40FmG3oWWH+dzPo/Vz7+AA=;
        b=M+fKECkUrYo/8u8f8HPu13Yd2vA0bOy2tLPHTonzzvVGJbyqKxNp2Hd1WQnXZG8JF/
         PZp8xzM7HN9xnHHPRQwq4HVSrT3kpipEH0iBeJvhyQ5DSNy5JhZdQIdkpohjLywMN6pV
         W3Vv5CBGksQntBoThf8EwktXf+UQXqqUtbWjIInpISHG/zP/3eky9iQb9i/p3vx0DtLZ
         By/MesNTBg5JSfV52O/6r8AeYnvDQnl1huwcLwnPrnsC9VjA4gsY0ujG22TzGzywm0Vm
         y+M2niEUfkNCaP5Lmf3Y0/61eO/sSyaC0Ffon2JGrbUlIF7fKNrcuSxG4YqoJPKS+Paj
         Au5A==
X-Gm-Message-State: ANoB5plTQ94MhntdzP9aG8gUoBx/hOccYSpVOL7JIWObMTYBpTmpsv0g
        DiSo9oyXruCaYDekjCu/YdM=
X-Google-Smtp-Source: AA0mqf52SQi4DYO4SRXhGUeSpqmBH7rHMNwq6edg3z6Jqk+RvDG0nj7w9SzccS7/ZLjWV4Gkkes7sg==
X-Received: by 2002:a17:907:98ea:b0:7ae:c1af:89af with SMTP id ke10-20020a17090798ea00b007aec1af89afmr7595669ejc.550.1669205104775;
        Wed, 23 Nov 2022 04:05:04 -0800 (PST)
Received: from [10.20.0.7] ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090636ce00b007a8de84ce36sm7166227ejc.206.2022.11.23.04.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 04:05:04 -0800 (PST)
Message-ID: <33348300-b3a7-af67-5729-8d0471aff2dc@gmail.com>
Date:   Wed, 23 Nov 2022 13:05:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
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
 <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
 <1085c75e-fd12-f432-8893-b58f7c3a7cab@linaro.org>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <1085c75e-fd12-f432-8893-b58f7c3a7cab@linaro.org>
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

Hi,

On 11/23/22 12:22, Srinivas Kandagatla wrote:
> Hi Max,
> 
> On 02/08/2022 14:22, Maximilian Luz wrote:
>>
>>
>> On 8/2/22 13:51, Srinivas Kandagatla wrote:

[...]

>>> I think its worth exploring if uefisecapp can talk smcinvoke.
>>> I can ping Qualcomm engineers to see if that is doable.
>>
>> I think that would be great! Thanks!
> Sorry for such a long delay to reply to this,
> 
> here is what I have.
> 
> Access to TA using SCM calls remain valid and it will continue to work till SM8550 and probably after that if the TA is *NOT* loaded using smcinvoke for some reasons.
> 
> But overall by default on all new SoCs after sm8550 all the access to TA is only done via smcinvoke, and the underlying scm call that are used in this patchset will not be supported anymore.
> 
>  From SM8550, we will need to move this driver to a proper TEE client kernel driver.
> 
> So, with that in mind, I would suggest that we carefully name the compatibles based on SoC rather than generic ones.

Thanks! That makes sense.

Regards,
Max
