Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F415810F5
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGZKRH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiGZKRG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 06:17:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C158286DB
        for <linux-efi@vger.kernel.org>; Tue, 26 Jul 2022 03:17:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m9so15929163ljp.9
        for <linux-efi@vger.kernel.org>; Tue, 26 Jul 2022 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=k5O4EHVtxr88sGikNEClrHBrRMv6Wt5HYjbVbFJmD00=;
        b=vJpAIwYZMErEj5rbGqQ350mc3DCwuGHIizHIV5HmshxNf4Nft1JqUJibbEaQ4UGP3g
         vw39nBSZJfIqI/XG3vZZaz2dTrpo6uIZi9xYNSTeRGR/DQif/KbWGwtkq388iwShp0gv
         mP9rVynS6uo9w6P5Jl9Rb1x2SwhDE32s8qhojzZvMBIhdENmCL9rroS/hIDTgtD+zf6z
         r2ASk5SDwigvx5mC2rkitjtqoKrBzHLSxEzgpL4MnvXE6QduyDQwm115Paei4jBS1Sw0
         pP/XZdNcsEpxhoxulbvaCJVg7WbhwAwRscys4wzpeIRejNy2KTiv0BM4aZLWBqUsLC5v
         0ijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k5O4EHVtxr88sGikNEClrHBrRMv6Wt5HYjbVbFJmD00=;
        b=oN/jU0n1lphCiWIOUwALQq301X3poGE1k7dEZ3O3KrkTA2+w/O6gas1fjcYkUhUIzH
         MsRBXUSOE7H3mR/CTgg0Lu6bnwGaYW/jSnjpI9lFg658zEHkLQ8ALZ/ARUILjqwE7ef8
         Y6Gw30pBrMeotf3ZGsSNhz1dqNf91e2EFQYtDsz8BpdqE5xhU+YV0c9OidwljR58Ww2L
         7BOrsj5H0R0EBXTfMMm49uwkx2fUit5duDXkShWzQZuArCI/yuE1IHrpSGyI0eGYG7fQ
         SXJyWV0JWKBYIQTZIs1Rl9Dh+tw1YJWVM19j8q4at7uXNa5vcAyy4l+HZRABMU6lXi8v
         z5Ew==
X-Gm-Message-State: AJIora+ps+u0rpWGdF/QndpXP8VbYMtsc9LUgk3d3sl/ppCOiuWDGYza
        J29dddLYMNh1hgkzZp1qB7r964EzPI6i3gM1
X-Google-Smtp-Source: AGRyM1uViFn/KmVHqLUDrlNUpPnN4K9sCA2Pesn1Ztt99me1kjgo9CTQ9ebdIYigb0qTu1yG/I46ZQ==
X-Received: by 2002:a2e:9d02:0:b0:25d:d6b9:b753 with SMTP id t2-20020a2e9d02000000b0025dd6b9b753mr5387184lji.344.1658830622608;
        Tue, 26 Jul 2022 03:17:02 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id q21-20020ac24a75000000b00484e9e254c4sm3142760lfp.100.2022.07.26.03.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:17:02 -0700 (PDT)
Message-ID: <e88d1036-dc58-3fc8-c388-edba9b2d62a7@linaro.org>
Date:   Tue, 26 Jul 2022 12:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
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
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220723224949.1089973-5-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 24/07/2022 00:49, Maximilian Luz wrote:
> Add bindings for the Qualcomm Trusted Execution Environment (TrEE) UEFI
> Secure application (uefisecapp) client.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  .../firmware/qcom,tee-uefisecapp.yaml         | 38 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml b/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
> new file mode 100644
> index 000000000000..9e5de1005d5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Trusted Execution Environment UEFI Secure Application
> +
> +maintainers:
> +  - Maximilian Luz <luzmaximilian@gmail.com>
> +
> +description: |
> +  Various Qualcomm SoCs do not allow direct access to UEFI variables. Instead,
> +  these need to be accessed via the UEFI Secure Application (uefisecapp),
> +  residing in the Trusted Execution Environment (TrEE). These bindings mark the
> +  presence of uefisecapp and allow the respective client driver to load and
> +  install efivar operations, providing the kernel with access to UEFI
> +  variables.
> +
> +properties:
> +  compatible:
> +    const: qcom,tee-uefisecapp

Isn't this SoC-specific device? Generic compatibles are usually not
expected.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +        scm {
> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
> +        };
> +        tee-uefisecapp {
> +            compatible = "qcom,tee-uefisecapp";

You did not model here any dependency on SCM. This is not full
description of the firmware/hardware.



Best regards,
Krzysztof
