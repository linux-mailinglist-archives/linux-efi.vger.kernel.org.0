Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76157F1EE
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 00:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiGWWuX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 Jul 2022 18:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiGWWuV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 Jul 2022 18:50:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF22B4B0;
        Sat, 23 Jul 2022 15:50:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q18so615811wrx.8;
        Sat, 23 Jul 2022 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGCbFdlBTzAuiBGLOtwTpT2WdPgCLGwr/LKBh4mT2I8=;
        b=mlj0vCbMggjKmdckuFteu4WQcrbibul3YZBYK8HL9sttdJ1gDBWBDNMQist5ZSxsYz
         4S0wi/uLjNJDj73xB0cKcXSLiV4rv3lwx5DvhRfMPTPPbRVBhYbA947nyiTTbhRAQkhJ
         AA9tU7EQLQJp2bGZBMO5kbK8pjzI6jdJC/jgqNPoOHAybWS9cftB15fhGcvR7g4At6gu
         aCWzPRpqFK2/0T7dNIxxOboUH4kLyhAjov+2U+55dB2LrS8B4HpGXo+FiWItKZG+qpB3
         Me7JLJPdl/E/LB+yOuAXy9felk0a6GQKLij3dOs11CVU8pxRkQwF+xhlXoYDKrqH+e6M
         rqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGCbFdlBTzAuiBGLOtwTpT2WdPgCLGwr/LKBh4mT2I8=;
        b=xo7oCxdx6sF9Crj4krXLZ4UaGX/lmMspN0jwuDPCrMWyGuAOuOD9bWIBu6SRjRREF7
         a2HwOE3E9KEq/NqSQ2HdmxvnTIE6SqvSZ9LjK/3B7DReM07+/hrIOA8OL2QlG8Hn3FEa
         nnWoDZqq2nkpIPNtxFg+G3HAYCi9IFusmZfqWf77RAnhYca09XrBbf0bUlB0nkSDZUXe
         cSwGS7uYOiPV3OzLwnGrL1tUrbCumj14vazAR+LDVBSs/E3g0HaKdxS6KoTCCfosS1rX
         ZNyUarLNefXt57wph+ItzRYN0fmj7HcVobwdALogvDJ10aX+M8F4LjjBGeTBibdWT02F
         S/FQ==
X-Gm-Message-State: AJIora9hWd7cpvEvWubv4oAQrt6gYhKN5e+dhtVMB5XsperGGqlVKQB8
        I2L8hAdZn9TH3HSj79Eczdk=
X-Google-Smtp-Source: AGRyM1tj2MlgygKXGsCijkuqc0TQtNkGbbEiGabYkENtsgS0baDWgdinbdWZE8N6fVTzYagIOVijxA==
X-Received: by 2002:a5d:64cc:0:b0:21d:a4bd:fdbe with SMTP id f12-20020a5d64cc000000b0021da4bdfdbemr3692388wri.580.1658616619030;
        Sat, 23 Jul 2022 15:50:19 -0700 (PDT)
Received: from xws.localdomain (pd9ea3743.dip0.t-ipconnect.de. [217.234.55.67])
        by smtp.gmail.com with ESMTPSA id x3-20020adff0c3000000b0021deba99142sm7799284wro.40.2022.07.23.15.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 15:50:18 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
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
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure Application client
Date:   Sun, 24 Jul 2022 00:49:49 +0200
Message-Id: <20220723224949.1089973-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220723224949.1089973-1-luzmaximilian@gmail.com>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add bindings for the Qualcomm Trusted Execution Environment (TrEE) UEFI
Secure application (uefisecapp) client.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../firmware/qcom,tee-uefisecapp.yaml         | 38 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml

diff --git a/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml b/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
new file mode 100644
index 000000000000..9e5de1005d5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Trusted Execution Environment UEFI Secure Application
+
+maintainers:
+  - Maximilian Luz <luzmaximilian@gmail.com>
+
+description: |
+  Various Qualcomm SoCs do not allow direct access to UEFI variables. Instead,
+  these need to be accessed via the UEFI Secure Application (uefisecapp),
+  residing in the Trusted Execution Environment (TrEE). These bindings mark the
+  presence of uefisecapp and allow the respective client driver to load and
+  install efivar operations, providing the kernel with access to UEFI
+  variables.
+
+properties:
+  compatible:
+    const: qcom,tee-uefisecapp
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        scm {
+            compatible = "qcom,scm-sc8180x", "qcom,scm";
+        };
+        tee-uefisecapp {
+            compatible = "qcom,tee-uefisecapp";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e014e16fc82..00436245189d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16607,6 +16607,7 @@ QUALCOMM UEFISECAPP DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
 F:	drivers/firmware/qcom_tee_uefisecapp.c
 
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
-- 
2.37.1

