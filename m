Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDD57F7DA
	for <lists+linux-efi@lfdr.de>; Mon, 25 Jul 2022 03:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGYBGi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Jul 2022 21:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYBGh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Jul 2022 21:06:37 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB89FD6;
        Sun, 24 Jul 2022 18:06:36 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so7670254otn.2;
        Sun, 24 Jul 2022 18:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QNCEP/Jd9p9U+kHeTNbZg9vzuQ68V1YM3OnqLNp9aiY=;
        b=ESlvsy5UyFcNEZ/mdB/h29qdxZNvN5FPQ08G0mOwYmlycN6b9ZFFd97Ewud5LdNYzy
         Y8hiFpKTj5/KzojzmLCh2RtTIdXXt5pZaflVFt0cgsxu2sskoCBwaXXO9IlQlNC1qv4i
         z2hi5cvpBNm4DnqZaxqXDiOWMoL0QfQdWQ6Urjhe9CiVqSt+Kw2q3tySPbGDdssROL10
         kW10MdgaoY35liZUB8rvG1PqV886d5XzusIIhmU9F9cKgNhnsRejUatsXkfu7JP4arSH
         QB2QSnX3KI15//FX1MNxzs4UninsTqUTQhnjDP2O0NdHoQG8sPEfU9o1mjfud45G5HvW
         /a4w==
X-Gm-Message-State: AJIora/RLb+3SsUJPkXxDfiTcvi/v7rdmLqMj/HNqPct/MBkfMXElJ9B
        uRqwcDujQbvIyOcCVw5Xog==
X-Google-Smtp-Source: AGRyM1s5XKEnlQ5my1VSNVGytH3TBZejI+JtkvAk9JTSOphfdgVAoaZgqQddJRx6BCAc/nkzgm5u6g==
X-Received: by 2002:a05:6830:d0b:b0:61c:1bc2:fbc0 with SMTP id bu11-20020a0568300d0b00b0061c1bc2fbc0mr3760368otb.348.1658711195791;
        Sun, 24 Jul 2022 18:06:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t21-20020a056870f21500b0010dc461410bsm3389440oao.38.2022.07.24.18.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 18:06:35 -0700 (PDT)
Received: (nullmailer pid 678621 invoked by uid 1000);
        Mon, 25 Jul 2022 01:06:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220723224949.1089973-5-luzmaximilian@gmail.com>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com> <20220723224949.1089973-5-luzmaximilian@gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure Application client
Date:   Sun, 24 Jul 2022 19:06:32 -0600
Message-Id: <1658711192.682597.678620.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 24 Jul 2022 00:49:49 +0200, Maximilian Luz wrote:
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/firmware/qcom,tee-uefisecapp.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml: duplicate '$id' value 'http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#'
Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.example.dtb:0:0: /example-0/firmware/scm: failed to match any schema with compatible: ['qcom,scm-sc8180x', 'qcom,scm']
Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.example.dtb:0:0: /example-0/firmware/scm: failed to match any schema with compatible: ['qcom,scm-sc8180x', 'qcom,scm']
Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb:0:0: /example-0/rsc@179c0000: failed to match any schema with compatible: ['qcom,rpmh-rsc']
Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb:0:0: /example-1/rsc@af20000: failed to match any schema with compatible: ['qcom,rpmh-rsc']
Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb:0:0: /example-2/rsc@18200000: failed to match any schema with compatible: ['qcom,rpmh-rsc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

