Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41F9635B7D
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 12:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiKWLWT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 06:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiKWLWS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 06:22:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C78657EC
        for <linux-efi@vger.kernel.org>; Wed, 23 Nov 2022 03:22:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d1so16786266wrs.12
        for <linux-efi@vger.kernel.org>; Wed, 23 Nov 2022 03:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNglsK4+/iip/Tdvq3qRkWjn1wP+WYSOSH+/chHxROE=;
        b=OJhkeN0ePg+bL5YO/tnj62hFLU9N+gj9+WOdC8CuOqgqkCkH4xyStZAjTbJhEEMd0J
         nvi0CquQM6I91s+eN6GWpXvVtnYOVg2UgrbSo8ZY3uBV2ZP5IjL1yeD3b7hrvnoF04x1
         n7EipWkPA6kfSjNy9I6pdpzpaCRo8jIpdeOD08tsT+dErTadJlL6PYRgW78DdXyrvHQf
         KgYbFYepclO7T5syTv/9I4VQqo9PXaxWGD2r5G3zKzxSHniYqMQIdLS/0mLyN0VWV3oI
         okqt9zYbOIJ4TRzRDxRVYtT4CA3QSA3rmQpwEFyPlVEROa5iE2FogdgBrRJTYwdo+yTT
         IK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNglsK4+/iip/Tdvq3qRkWjn1wP+WYSOSH+/chHxROE=;
        b=3xqFlhYJiPfjlNLMjqWvBEn+Siapqxbv/pREaR4MPmePX6sikyHeSEf2XsbEAKFIWP
         WI5PnKZ1xhy71itUbPynnyYf0FUOkXPQxC4u9tukIHCoDDAIlQ3s4h5DoGYm0r9rmRQ5
         lKzktnrjKY/4PSv0NOjNKv5Im1oi0XBr3Zqi1BI4IfwzXQT8jf1+BLaxUjSJ7u1InleK
         GJDRzEFbq4AbyFelp3QNoN71qmzkUSlAj5Z1unGeSSCv+gxCD/gbu3RRaTGSr8afd4NS
         /MkWeKDfmQ3np1ZiPj42Vle4UJNnzL90lr27XsJgglDrnNd4i2YWJJNXsWlO2c6bjT0E
         C9dQ==
X-Gm-Message-State: ANoB5pkv4qX7XJoFcVvW9fgHbXaWThTf8A9KJNaZuOB9jagd8P0zhXZ6
        PJQlyJuS1Stn+v0sZFjA0lJ1gg==
X-Google-Smtp-Source: AA0mqf7hr367nAUVa9igwAtZ4K7DD6B/xC6ioylGPhZdSWf5jiMGuYa/X8qp1Cyggyiaf+DbK7HviA==
X-Received: by 2002:a05:6000:104c:b0:23a:5a31:29eb with SMTP id c12-20020a056000104c00b0023a5a3129ebmr10151892wrx.679.1669202535626;
        Wed, 23 Nov 2022 03:22:15 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q2-20020adff502000000b00241cfa9333fsm10259640wro.5.2022.11.23.03.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 03:22:14 -0800 (PST)
Message-ID: <1085c75e-fd12-f432-8893-b58f7c3a7cab@linaro.org>
Date:   Wed, 23 Nov 2022 11:22:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
To:     Maximilian Luz <luzmaximilian@gmail.com>,
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
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Max,

On 02/08/2022 14:22, Maximilian Luz wrote:
> 
> 
> On 8/2/22 13:51, Srinivas Kandagatla wrote:
>> Hi Maximilian,
>>
>> On 23/07/2022 23:49, Maximilian Luz wrote:
>>> On modern Qualcomm platforms, access to EFI variables is restricted to
>>> the secure world / TrustZone, i.e. the Trusted Execution Environment
>>> (TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
>>> therefore need to talk to the UEFI Secure Application (uefisecapp),
>>> residing in the TrEE.
>>>
>>> This series adds support for accessing EFI variables on those platforms.
>>>
>>> To do this, we first need to add some SCM call functions used to manage
>>> and talk to Secure Applications. A very small subset of this interface
>>> is added in the second patch (whereas the first one exports the required
>>> functions for that). Interface specifications are extracted from [1].
>>> While this does not (yet) support re-entrant SCM calls (including
>>> callbacks and listeners), this is enough to talk to the aforementioned
>>> uefisecapp on a couple of platforms (I've tested this on a Surface Pro X
>>> and heard reports from Lenovo Flex 5G, Lenovo Thinkpad x13s, and Lenovo
>>> Yoga C630 devices).
>>>
>>> The third patch adds a client driver for uefisecapp, installing the
>>> respective efivar operations. The application interface has been reverse
>>> engineered from the Windows QcTrEE8180.sys driver.
>>>
>>> Apart from uefisecapp, there are more Secure Applications running that
>>> we might want to support in the future. For example, on the Surface Pro
>>> X (sc8180x-based), the TPM is also managed via one.
>>>
>>> I'm not sure whether this should go to drivers/firmware or to
>>> drivers/soc/qcom. I've put this into firmware as all of this is
>>> essentially an interface to the secure firmware running in the TrustZone
>>> (and SCM stuff is handled here already), but please let me know if I
>>> should move this.
>>
>>  From what I see so far is that this is adapted from downstream 
>> qseecom driver, this approach could work for a limited usecases but 
>> not scalable, as we cannot add drivers for each Qualcomm specific TA 
>> in kernel.
>> This has to be handled in much generic way using Linux TEE framework, 
>> and let the userspace side deal with TA specific bits.
> 
> I generally agree with the sentiment, however UEFI variables should IMHO be
> handled by the kernel. Moving handling of those to userspace breaks 
> things like
> EFI-based pstore and efivarfs. The latter will in turn break some 
> user-space
> tools (most notably efibootmgr used by e.g. GRUB and I think fwupdmgr which
> needs to set some capsule variables). Ideally, we would find a way to 
> not break
> these, i.e. have them work out-of-the-box.
> 
> A similar argumentation might apply to the TPM app.
> 
>> AFAIU, Qualcomm is moving away from qseecom interface to new 
>> smc-invoke interface, most of Qualcomm SoCs starting from SDM660 
>> already have support to this.
>>
>> This interface provides a better abstracted IPC mechanism to talk to 
>> TA. Most of these TA specific interfaces are packed in closed 
>> userspace source.
>> Having said that QTEE smcinvoke driver can be modeled as a proper TEE 
>> driver with Userspace driving the TA specific bits using existing tee 
>> uapis.
>> This also brings in other features like loading, Listeners aka 
>> callbacks, secure memory allocations..etc.
>>
>> In the past, I have tried to do a prototype of this smcinvoke driver 
>> as a proper tee driver, incase you are interested patches are at 
>> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-qcomtee
>> Plan is to discuss with Qualcomm and send it for upstream review.
> 
> Thanks for this information! So as far as I understand it, this is 
> currently an
> interface to user-space only, i.e. does not allow in-kernel drivers for 
> apps?
> It would be great if this could then be extended to handle (the bare 
> minimum
> of) in-kernel drivers (i.e. only things that the kernel itself needs, 
> like EFI
> variables). Alternatively, I'm happy to hear suggestions on how we not 
> break
> the aforementioned things while moving handling off to userspace.
> 
>> I think its worth exploring if uefisecapp can talk smcinvoke.
>> I can ping Qualcomm engineers to see if that is doable.
> 
> I think that would be great! Thanks!
Sorry for such a long delay to reply to this,

here is what I have.

Access to TA using SCM calls remain valid and it will continue to work 
till SM8550 and probably after that if the TA is *NOT* loaded using 
smcinvoke for some reasons.

But overall by default on all new SoCs after sm8550 all the access to TA 
is only done via smcinvoke, and the underlying scm call that are used in 
this patchset will not be supported anymore.

 From SM8550, we will need to move this driver to a proper TEE client 
kernel driver.

So, with that in mind, I would suggest that we carefully name the 
compatibles based on SoC rather than generic ones.


--srini




> 
> Regards,
> Max
