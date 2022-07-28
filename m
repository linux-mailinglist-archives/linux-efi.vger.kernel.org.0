Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB555840B0
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiG1OKp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiG1OKB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:10:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9CC66120;
        Thu, 28 Jul 2022 07:09:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so2589401wmb.5;
        Thu, 28 Jul 2022 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ixqHRPr6e7MHs/cE0ogao0EJfks3+o9Xq3/fufygzUo=;
        b=GX9O/gveVrekkyIe1HGILQb6uOLCLpBWU/EWtJr30BOpjOUJSdJrxcKPOjH9jshgdS
         axn+o9F83Xtyk2FgV6lPzzQDfvSYMduZflssUI4i7xt/hGwfPz4dlZCYwbzPOhNW85+P
         x8vIhPNHctkTl5maKKiAk+68zirbIPK85PE+feXTixiBX8e9Cs+kPW8GCkFKLD4wLDMe
         RiVd3iIZ2r7l4KmgY1KKXWC4Pgyi0qWp5GZu7F8nn6TlycuuBDfCHX28YQy/z/lxECuy
         HRuhRyTiisc1cj0hva/FHqs2CMCSd+i9DoNqWPh/vgnCIPjUrZtMX98b76C5tqMgxipm
         LhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ixqHRPr6e7MHs/cE0ogao0EJfks3+o9Xq3/fufygzUo=;
        b=dhUQTkr2vCkKMC4JGEc5CPc6aShYEJBb5EzkMk/IMoiVH/zOgTlfOb/UtaPqOzxmwM
         NYCub7maHYGCV5aD8sws3BzdhIoL3WWiUxqvQCyEBzDw/i8QefNV3QBae6YSpWtVyd13
         2dtTW/+s+kAOUIYwLIXm3/ufa4EZapXcxjZIDjSY3V0yrAPee462S+3QhaR7I1kwTjq1
         eRfQg/sUDyQrx1mQqyorOW3H9VrZ7KQ2grgMuc8yxGeqnqrsVOttuIr1VyAwLm9S8uWB
         Pt/FhTr7O+58m1hoLvGAo3yJS3PRfE92x9HjGggf+F+eFQ+zJ8yA2pnCYTswZ28QDLto
         CUdQ==
X-Gm-Message-State: AJIora8Xsg3W4rAa1Iue9N58qU3zx/BL8BZBvR2jWMCNYtR8yoMHmG3Z
        dJIoIeNbD7PJGmQmkbK3hdE=
X-Google-Smtp-Source: AGRyM1uQ8JmKJbrJWgcUJogFvOJNGMZ7Key56sa6wlDnx+PMBxeRB0c9qy5i4aS4okzS8GvyWxQzzw==
X-Received: by 2002:a1c:288:0:b0:3a3:5332:9d16 with SMTP id 130-20020a1c0288000000b003a353329d16mr6702665wmc.168.1659017386588;
        Thu, 28 Jul 2022 07:09:46 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea36f8.dip0.t-ipconnect.de. [217.234.54.248])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a2d6f26babsm1539451wms.3.2022.07.28.07.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:09:46 -0700 (PDT)
Message-ID: <d16d14fd-3edc-32f8-d00b-23b4b8a799fa@gmail.com>
Date:   Thu, 28 Jul 2022 16:09:44 +0200
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
 <b018e909-e371-fd57-2790-9f0a37b63f29@gmail.com>
 <20220728134222.hs2v75zkxgtcctrx@bogus>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220728134222.hs2v75zkxgtcctrx@bogus>
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

On 7/28/22 15:42, Sudeep Holla wrote:
> On Thu, Jul 28, 2022 at 01:45:57PM +0200, Maximilian Luz wrote:
>>
>> Would something like this work for you: Add a compatible for the TrEE
>> interface (e.g. qcom,sc8180x-tee) but not for the specific apps running
> 
> IIUC, you would introduce a compatible for each unique production if there
> is a need. This constitutes as a strong need for that, but you need just
> that, no need to have any notion or info to indicate TrEE/TEE as you know
> this product runs those in TEE.
> 
> In short, just use the platform specific(not SoC or SoC family) specific
> compatible to initialise your driver and don't introduce any specific
> compatible for this particular firmware interface need.

As Krzysztof mentioned, it would be good to ensure proper device
ordering wrt. SCM. Having a device node for the overall TrEE interface
would allow specifying that via DT. We could then still use the platform
compatible to load the specific things inside that driver.
Alternatively, we would need to do this extra stuff in qcom_scm.

I think separating this from qcom_scm into a new driver would be better
from a code separation and maintenance point of view. Also, this
reflects what's present in ACPI: There is a QCOM040B device for SCM and
a QCOM0476 device for TrEE.

Regards,
Max
