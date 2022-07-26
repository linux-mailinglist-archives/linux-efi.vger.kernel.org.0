Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564395811BA
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiGZLPa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 07:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiGZLP3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 07:15:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657C10B0;
        Tue, 26 Jul 2022 04:15:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z15so5504722edc.7;
        Tue, 26 Jul 2022 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kd0Lf/T064htlQE+DM/jO7XCY3kQGinsE+nPB2n4oVc=;
        b=iDjd0AiKoxsM2SpAkDwtDdxX/9N7jz/q3sdvnLyicfoo8gOh1EAHZiTiYzWPj1lupZ
         ezNZmWRP6MUwWF/kvl6oBX+ps/Ixx3pX/C6lGya79lQqa7oqXxO7X751mFpFc5ImCH5V
         jMXCwYjZKbNMxvgQGb65/Q2RQ6YuQdTRQuLHeZ0QCaqTnSxjIb2HWZjRds1wMXouQYTw
         AtPDI+3Z7Xgx/T36+cDnSe/UFeniNq8IziNG/npE7xoNTwSxwTALIcZuiKZHOW1dNouK
         mcjVeUjY8+hovwzqDUworZj0u+u+4AsdImDz4Lr2XQ+nb32iJS3XtR/UliazR2D5lKvX
         6q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kd0Lf/T064htlQE+DM/jO7XCY3kQGinsE+nPB2n4oVc=;
        b=oJGeDLwsQecsRtntVEIB2IS5irxQePtcOhfmvMtcH74KmVKmIh0zlmyPOczzsLxZhY
         LcVrMByCxtWuvEYwsnoGr9tQb/gdAapieOuxgJMNn67MHe6i2oDQryc39egv6Ze5G+CD
         blNhk4gc75QW7U40gUmVYhiZNN1Hsud/CDT/nkKZoVr4A6StnCfbfoUxYD1kyezdElDx
         b0MoMIWY8iQjH6o0CF5x1r/k24iHtlAWoeJaJwPDI8aYOEkA+EbI8ak6IOKoM0BIQOWS
         5aSuIXh9XbTihoE0FIUZ4I9maddw1FwVRvKBVrpvsXnubksieF4AH5S5lsgh4lug8RTP
         Jl0g==
X-Gm-Message-State: AJIora/VxtDdgi9JoOSF4akIEnYSrJjAaIPJUIY52tXMJ0wNhqq2FCpH
        RwoKhxg3rkR3n6yT6t45i4NtdrbrY8U=
X-Google-Smtp-Source: AGRyM1uTAKCthTVSXttHf3qKy4SvMV0X8Q6yyxRv7+vGPYfTzAOnm7gpTJeNrEetbeA/Dcrh17DZcA==
X-Received: by 2002:a05:6402:268f:b0:43b:e506:a761 with SMTP id w15-20020a056402268f00b0043be506a761mr14142260edd.250.1658834126931;
        Tue, 26 Jul 2022 04:15:26 -0700 (PDT)
Received: from [10.29.0.6] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709060d4200b00722e57fa051sm6287758ejh.90.2022.07.26.04.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 04:15:26 -0700 (PDT)
Message-ID: <87c19c5a-d7f4-7183-1322-f62267e01b3b@gmail.com>
Date:   Tue, 26 Jul 2022 13:15:25 +0200
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <e88d1036-dc58-3fc8-c388-edba9b2d62a7@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <e88d1036-dc58-3fc8-c388-edba9b2d62a7@linaro.org>
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

On 7/26/22 12:17, Krzysztof Kozlowski wrote:
> On 24/07/2022 00:49, Maximilian Luz wrote:
>> Add bindings for the Qualcomm Trusted Execution Environment (TrEE) UEFI
>> Secure application (uefisecapp) client.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>   .../firmware/qcom,tee-uefisecapp.yaml         | 38 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml b/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
>> new file mode 100644
>> index 000000000000..9e5de1005d5c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).

Sorry, first time submitting a schema. Already saw the warning of Rob's
bot and Will fix this in v2.

>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Trusted Execution Environment UEFI Secure Application
>> +
>> +maintainers:
>> +  - Maximilian Luz <luzmaximilian@gmail.com>
>> +
>> +description: |
>> +  Various Qualcomm SoCs do not allow direct access to UEFI variables. Instead,
>> +  these need to be accessed via the UEFI Secure Application (uefisecapp),
>> +  residing in the Trusted Execution Environment (TrEE). These bindings mark the
>> +  presence of uefisecapp and allow the respective client driver to load and
>> +  install efivar operations, providing the kernel with access to UEFI
>> +  variables.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,tee-uefisecapp
> 
> Isn't this SoC-specific device? Generic compatibles are usually not
> expected.

This is essentially software (kernel driver) talking to software (in the
TrustZone), so I don't expect there to be anything SoC specific about it.

>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    firmware {
>> +        scm {
>> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
>> +        };
>> +        tee-uefisecapp {
>> +            compatible = "qcom,tee-uefisecapp";
> 
> You did not model here any dependency on SCM. This is not full
> description of the firmware/hardware

How would I do that? A lot of other stuff also depends on SCM being
present (e.g. qcom_q6v5_pas for loading mdt files) and I don't see them
declare this in the device tree. As far as I can tell, SCM is pretty
much expected to be there at all times (i.e. can't be unloaded) and
drivers check for it when probing via qcom_scm_is_available(),
deferring probe if not.

Don't take this as an excuse as in "I want to leave that out", it's just
that I don't know how one would declare such a dependency explicitly. If
you can tell me how to fix it, I'll include that for v2.

Regards,
Max
