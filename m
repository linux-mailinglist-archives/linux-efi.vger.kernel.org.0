Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28FF587BCB
	for <lists+linux-efi@lfdr.de>; Tue,  2 Aug 2022 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiHBLvr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Aug 2022 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiHBLvq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Aug 2022 07:51:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7018732057
        for <linux-efi@vger.kernel.org>; Tue,  2 Aug 2022 04:51:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a9so8760657lfm.12
        for <linux-efi@vger.kernel.org>; Tue, 02 Aug 2022 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5X7O27EsbrEVXij2N4a86EZ0C/gr3WyCbXj7RYwB9Po=;
        b=SNJDh3+wc1Jhv0IgV0MOSxzggPT9Fbncs/BV1eZVLqZjoVCIXtCBKU1+LgZhu3cMie
         Qkq0bZtZEOkiHoVzsJqqpmUxyu4FqbcCT9EBXCDUOT7XglI/SRaffe68cJXZDxazLm7D
         jzvuDX3CoYccBdt5kwJaEjJ6Y8FFfPNEr76BFrBc4ZtSCOWo8jszoLNCyACpazJ4TtCS
         demH198kv33SeTNXupSa4tFT02hvdfEUkLRq+ks38jz7MhI+FNvwxInNjR+EJMdDZo2f
         4SEYXKxVEU8MnQ0M6vdNI5JkgA9bbGXZdeizo9YzB3tOWE1MTRuKjEtuK+UY9/Him4p9
         u2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5X7O27EsbrEVXij2N4a86EZ0C/gr3WyCbXj7RYwB9Po=;
        b=dlE0n5DlcOVpslAOjqX3vn/nIsydCYtJrSoHWs8rHsd6cWZ0QESc1Wrjd4i7A1KPhM
         0JMys5j2nuStp9rkDdprConcoIsHsfSPJ+qS3t2Yz6HRYNRFke5qbQWrShm4tfajF5fq
         Uvh/ldDq0DK4VRVk8QYFtWJHRXkZVfT3ITHOcI2J8Gfbt/1pX3f3vHAHwpGfn7lK0sf1
         kSxmpvFPtvUE5w/EK1uYRuCj+f4y1ogQJK0sO87HVe5UlwM42YbqpLEItcRJjmd7AJjA
         PIffnuhEB2TzfjJTWrQ/w5lmJkSUvaHF+PbQ5ZY4liorekKvpc3/3fVWVLeXW0W6F8Rz
         cTLA==
X-Gm-Message-State: AJIora87PtsW5j0VQ31i3sPEB654KRMAl3r1ByTpg5w8AIzqHs5yDfT+
        lfAZHNSGNale9dmQ/xmM4QBouXCjXRk9Zw==
X-Google-Smtp-Source: AA6agR5p02Ez5M7iERoxC/VS8zm2sk+chMafUxEIpvq6MRvmm5x9KO6OwZ+CGXcJXci74xS4WF7/Gw==
X-Received: by 2002:adf:de0f:0:b0:21e:ead4:23f5 with SMTP id b15-20020adfde0f000000b0021eead423f5mr12545590wrm.641.1659441089142;
        Tue, 02 Aug 2022 04:51:29 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id y3-20020a056000108300b0021d6d18a9f8sm15087211wrw.76.2022.08.02.04.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 04:51:28 -0700 (PDT)
Message-ID: <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org>
Date:   Tue, 2 Aug 2022 12:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220723224949.1089973-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Maximilian,

On 23/07/2022 23:49, Maximilian Luz wrote:
> On modern Qualcomm platforms, access to EFI variables is restricted to
> the secure world / TrustZone, i.e. the Trusted Execution Environment
> (TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
> therefore need to talk to the UEFI Secure Application (uefisecapp),
> residing in the TrEE.
> 
> This series adds support for accessing EFI variables on those platforms.
> 
> To do this, we first need to add some SCM call functions used to manage
> and talk to Secure Applications. A very small subset of this interface
> is added in the second patch (whereas the first one exports the required
> functions for that). Interface specifications are extracted from [1].
> While this does not (yet) support re-entrant SCM calls (including
> callbacks and listeners), this is enough to talk to the aforementioned
> uefisecapp on a couple of platforms (I've tested this on a Surface Pro X
> and heard reports from Lenovo Flex 5G, Lenovo Thinkpad x13s, and Lenovo
> Yoga C630 devices).
> 
> The third patch adds a client driver for uefisecapp, installing the
> respective efivar operations. The application interface has been reverse
> engineered from the Windows QcTrEE8180.sys driver.
> 
> Apart from uefisecapp, there are more Secure Applications running that
> we might want to support in the future. For example, on the Surface Pro
> X (sc8180x-based), the TPM is also managed via one.
> 
> I'm not sure whether this should go to drivers/firmware or to
> drivers/soc/qcom. I've put this into firmware as all of this is
> essentially an interface to the secure firmware running in the TrustZone
> (and SCM stuff is handled here already), but please let me know if I
> should move this.

 From what I see so far is that this is adapted from downstream qseecom 
driver, this approach could work for a limited usecases but not 
scalable, as we cannot add drivers for each Qualcomm specific TA in kernel.
This has to be handled in much generic way using Linux TEE framework, 
and let the userspace side deal with TA specific bits.

AFAIU, Qualcomm is moving away from qseecom interface to new smc-invoke 
interface, most of Qualcomm SoCs starting from SDM660 already have 
support to this.

This interface provides a better abstracted IPC mechanism to talk to TA. 
Most of these TA specific interfaces are packed in closed userspace source.
Having said that QTEE smcinvoke driver can be modeled as a proper TEE 
driver with Userspace driving the TA specific bits using existing tee uapis.
This also brings in other features like loading, Listeners aka 
callbacks, secure memory allocations..etc.

In the past, I have tried to do a prototype of this smcinvoke driver as 
a proper tee driver, incase you are interested patches are at 
https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-qcomtee
Plan is to discuss with Qualcomm and send it for upstream review.


I think its worth exploring if uefisecapp can talk smcinvoke.
I can ping Qualcomm engineers to see if that is doable.


thanks,
Srini


> 
> Regards,
> Max
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/auto-kernel.lnx.4.14.c34/drivers/misc/qseecom.c
> 
> Maximilian Luz (4):
>    firmware: qcom_scm: Export SCM call functions
>    firmware: Add support for Qualcomm Trusted Execution Environment SCM
>      calls
>    firmware: Add support for Qualcomm UEFI Secure Application
>    dt-bindings: firmware: Add Qualcomm UEFI Secure Application client
> 
>   .../firmware/qcom,tee-uefisecapp.yaml         |  38 +
>   MAINTAINERS                                   |  14 +
>   drivers/firmware/Kconfig                      |  20 +
>   drivers/firmware/Makefile                     |   2 +
>   drivers/firmware/qcom_scm.c                   | 118 ++-
>   drivers/firmware/qcom_scm.h                   |  47 --
>   drivers/firmware/qcom_tee.c                   | 213 +++++
>   drivers/firmware/qcom_tee_uefisecapp.c        | 761 ++++++++++++++++++
>   include/linux/qcom_scm.h                      |  49 ++
>   include/linux/qcom_tee.h                      | 179 ++++
>   10 files changed, 1355 insertions(+), 86 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
>   create mode 100644 drivers/firmware/qcom_tee.c
>   create mode 100644 drivers/firmware/qcom_tee_uefisecapp.c
>   create mode 100644 include/linux/qcom_tee.h
> 
