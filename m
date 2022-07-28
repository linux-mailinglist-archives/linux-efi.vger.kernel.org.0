Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11D583BFA
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 12:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiG1KZp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 06:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiG1KZo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 06:25:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC2148CBB;
        Thu, 28 Jul 2022 03:25:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q18so1593780wrx.8;
        Thu, 28 Jul 2022 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C2NORPL69rdS/U3sQy8SH5nhaMctHSblMz/j5TFc1qU=;
        b=RVllnvZbKqvxgjkF8jZ3dNEwDhUbJv2ZQCgSl+Dk70BceDMHGABft7XwtNRjqe8prt
         gWcQxWJXxkA+DJIkxNRltxYYmEaLp8IvvW5dKn+rhmxcZWjgKuOZQe6xzoCKkMw9fXjR
         Set/zPeq7GoMUlSO7A5LBiKq595meQNyo27pghVYBZ8uOqtAy4HSIT7BKU7uN61l2ttC
         3FZmyltrUSiQQ7oZV9yix5geqjca2TUffOvlbeJ078rPR8/Xl8vIvAs7epY52X+1sGh9
         e+lxzcbu4gXiSfzPDZ9XMlIzaJfGUCWJkOqQibKA+CvR4ciJvg+9OUdNn7lF5DzQazkC
         RFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C2NORPL69rdS/U3sQy8SH5nhaMctHSblMz/j5TFc1qU=;
        b=C/FxVJK5rKNGssa3qx7jjHcsJKh8Achzkdxf97VqBaWBoCeoFAc8p5JD6kcqInXhNf
         uYuaYNX3rjrLVsrqxSmy8qgyV3fSCdFIJWOg2OIJF/kDigKdXcPJjeixC7zMJVyXA9a2
         Sy05SPIjA50oVM78RLGRu2WPoxy9ICP8ITirMCKq4VM0WVyKB9+qxksERs/VyKc+p6sO
         4k+A5ow8zhGnWN0iEHT3qZrcHO2VRuUh1lJOOnFpioP2nVguPbvzM0peM+2erVZ7J34g
         wIWfjrOBBKijXxDbtFmJbr8BOPVOFqmPugYO75E2L6OnMeZWOcNFbzKGwLb1FzwGH/0p
         PM7Q==
X-Gm-Message-State: AJIora+x8e/GREz+BvIYkR/TKnXTcnuj3Ue/mJJkoVi3o7IEM5UsXaZj
        kSqelVlHKvN2N1SqTzfxDxTZKkYWXk8=
X-Google-Smtp-Source: AGRyM1s3dbTxWhkFSBBq6ctU/0Q/tLg5Q9T6wj12SY3gymJlFn2blUAW+DLpnpAg2SNksr6Ci+ZK4A==
X-Received: by 2002:adf:fbc4:0:b0:21e:bd8d:be09 with SMTP id d4-20020adffbc4000000b0021ebd8dbe09mr6207738wrs.216.1659003941111;
        Thu, 28 Jul 2022 03:25:41 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea36f8.dip0.t-ipconnect.de. [217.234.54.248])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003a31673515bsm6038414wmq.7.2022.07.28.03.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:25:40 -0700 (PDT)
Message-ID: <fe2b820b-9f3b-814b-4792-e6685b13ede6@gmail.com>
Date:   Thu, 28 Jul 2022 12:25:39 +0200
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <95cbcda8-d1bc-376c-b338-92d1b923f04a@linaro.org>
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

On 7/28/22 09:48, Krzysztof Kozlowski wrote:

[...]

>>>>> The problem with existing approach is:
>>>>> 1. Lack of any probe ordering or probe deferral support.
>>>>> 2. Lack of any other dependencies, e.g. for PM.
>>>>
>>>> I'm not entirely sure what you mean by "lack of probe deferral support".
>>>> We have qcom_scm_is_available() and defer probe if that fails. So
>>>> deferral works, unless I'm misunderstanding something.
>>>
>>> And how do you differentiate that qcom_scm_is_available() failed because
>>> it is not yet available (defer probe) or it is broken and will never
>>> load? All regular consumer-provider interfaces have it sorted out.
>>
>> Fair point. By shifting that to device links you'll at least know what
>> it's waiting for and the driver won't attempt to probe until that's
>> resolved. But your question applies to that then as well: How do you
>> differentiate between the device link or supplier being broken somehow
>> and the supplier being just not ready yet?
> 
> For example like tegra_bpmp_get() is doing.

But tegra_bpmp_get() can also not differentiate whether the supplier driver is
ever going to be successfully probed or not. I'm not sure you can ever really
solve that. The only thing it does in addition is check whether the phandle and
device is there. Or do you mean those not being present by "broken"? That's a
point I agree should be improved with SCM.

Regards,
Max
