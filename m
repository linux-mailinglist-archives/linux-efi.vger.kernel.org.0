Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F181857F1E4
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 00:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGWWuT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 Jul 2022 18:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiGWWuS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 Jul 2022 18:50:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D605FF7;
        Sat, 23 Jul 2022 15:50:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so7195278wme.0;
        Sat, 23 Jul 2022 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+SGmh+zQFQNeqS1nDQMpNKAHLBf8ILAcQLa/iYZ68w=;
        b=I6zZngK3VVgtj67O2D5LjmT+jF8X+BMMukA7BCYamHgUJ8AvTIMrz53CKg0wpvK/3a
         sNl6U/bDUcqN6z8l+3d4MK/ARRO8iM/DYSLuss7o7T0hfx3aYB6zR18ZbrCd/83KntJA
         0donLFzZHADhxPKFgsdpejxV1A5M1efs/UHpMy78nmCP3oHPh9BqeWwkomtjxkWLG0/U
         XV4o2NsxozeZDe7t+E5Z0cMhvVtgN67lxFfLrzHO3KPM/wbVUeWseGEnMSxPU16psKVZ
         2VvpPX/nVJ8CZ5MlwjdAbRm2/FsY5cU+7y+46XS5pSFSckGNIIp42bmZsISm6xBdXkJN
         svyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+SGmh+zQFQNeqS1nDQMpNKAHLBf8ILAcQLa/iYZ68w=;
        b=tiCKd21Or54cCFq6bE6EvU7y4CzukRmCLgSViNqOkSsa8U0qNKCLsXiYgvXNywwXlf
         r98agPfOd9N2kVn8tJKYx/d3piyLHg9s1aH/7n70G7MDTKyACdtZJoGaIzC7DP+msunl
         vo9qLvJ5hN58vatBoJ0P3K/xCND+7r/UCL9k6mXGQv0aKrdinYWuOkWHPp/ja6IHi8zA
         ZlBqetx6ea5XjcfZPtfOBS/zX4xcQI3NsPIWS198V3ZJ1cB6UZOqsnufCvy4qEoH77IK
         2NCUxS4sPb4rs1WY8/bXX65VT0h9A+Ao5/oDlxb9oW1RIqm8GhRrGGYryVOvS7RPOiub
         56JA==
X-Gm-Message-State: AJIora8GvR5Flnhfb2bdPNswVvjNxtEXqrfKnGxXk+tcFTdcCvv5ngiG
        1fl0xNXWKi0EYSyv7bJUf2kBs2tHIdQ=
X-Google-Smtp-Source: AGRyM1tb6ICS759gCOl045iJoxWtM+A1P/mUHsqx0egO5+irjQhLPHn2BqpnifLH1FH0OmR9U2Wbng==
X-Received: by 2002:a7b:cd15:0:b0:3a3:1d69:5201 with SMTP id f21-20020a7bcd15000000b003a31d695201mr3909731wmj.10.1658616614468;
        Sat, 23 Jul 2022 15:50:14 -0700 (PDT)
Received: from xws.localdomain (pd9ea3743.dip0.t-ipconnect.de. [217.234.55.67])
        by smtp.gmail.com with ESMTPSA id x3-20020adff0c3000000b0021deba99142sm7799284wro.40.2022.07.23.15.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 15:50:14 -0700 (PDT)
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
Subject: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Sun, 24 Jul 2022 00:49:45 +0200
Message-Id: <20220723224949.1089973-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
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

On modern Qualcomm platforms, access to EFI variables is restricted to
the secure world / TrustZone, i.e. the Trusted Execution Environment
(TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
therefore need to talk to the UEFI Secure Application (uefisecapp),
residing in the TrEE.

This series adds support for accessing EFI variables on those platforms.

To do this, we first need to add some SCM call functions used to manage
and talk to Secure Applications. A very small subset of this interface
is added in the second patch (whereas the first one exports the required
functions for that). Interface specifications are extracted from [1].
While this does not (yet) support re-entrant SCM calls (including
callbacks and listeners), this is enough to talk to the aforementioned
uefisecapp on a couple of platforms (I've tested this on a Surface Pro X
and heard reports from Lenovo Flex 5G, Lenovo Thinkpad x13s, and Lenovo
Yoga C630 devices).

The third patch adds a client driver for uefisecapp, installing the
respective efivar operations. The application interface has been reverse
engineered from the Windows QcTrEE8180.sys driver.

Apart from uefisecapp, there are more Secure Applications running that
we might want to support in the future. For example, on the Surface Pro
X (sc8180x-based), the TPM is also managed via one.

I'm not sure whether this should go to drivers/firmware or to
drivers/soc/qcom. I've put this into firmware as all of this is
essentially an interface to the secure firmware running in the TrustZone
(and SCM stuff is handled here already), but please let me know if I
should move this.

Regards,
Max

[1]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/auto-kernel.lnx.4.14.c34/drivers/misc/qseecom.c

Maximilian Luz (4):
  firmware: qcom_scm: Export SCM call functions
  firmware: Add support for Qualcomm Trusted Execution Environment SCM
    calls
  firmware: Add support for Qualcomm UEFI Secure Application
  dt-bindings: firmware: Add Qualcomm UEFI Secure Application client

 .../firmware/qcom,tee-uefisecapp.yaml         |  38 +
 MAINTAINERS                                   |  14 +
 drivers/firmware/Kconfig                      |  20 +
 drivers/firmware/Makefile                     |   2 +
 drivers/firmware/qcom_scm.c                   | 118 ++-
 drivers/firmware/qcom_scm.h                   |  47 --
 drivers/firmware/qcom_tee.c                   | 213 +++++
 drivers/firmware/qcom_tee_uefisecapp.c        | 761 ++++++++++++++++++
 include/linux/qcom_scm.h                      |  49 ++
 include/linux/qcom_tee.h                      | 179 ++++
 10 files changed, 1355 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,tee-uefisecapp.yaml
 create mode 100644 drivers/firmware/qcom_tee.c
 create mode 100644 drivers/firmware/qcom_tee_uefisecapp.c
 create mode 100644 include/linux/qcom_tee.h

-- 
2.37.1

