Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A45581544
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiGZOac (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiGZOaQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 10:30:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCD4AF02;
        Tue, 26 Jul 2022 07:30:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C171FB;
        Tue, 26 Jul 2022 07:30:10 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BB223F70D;
        Tue, 26 Jul 2022 07:30:07 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:30:05 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Message-ID: <20220726143005.wt4be7yo7sbd3xut@bogus>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723224949.1089973-5-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jul 24, 2022 at 12:49:49AM +0200, Maximilian Luz wrote:
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
> +        };

Do you expect some issues using the scm driver APIs without the
any additions in the DT ? I mean can't you auto-discover by using the
APIs. I haven't looked at the driver or any other patches in the series,
but I would like to know if we can avoid adding any new bindings if it
can be discovered via those SCM driver APIs.

-- 
Regards,
Sudeep
