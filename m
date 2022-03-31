Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FB24EDC8F
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbiCaPTX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiCaPTW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 11:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A545221C70B
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648739854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BEwAR/Gni372j/P0y7tdDtZZz8h0mfxsCzY2qJx8CsE=;
        b=BquADy6YeZqDvG0S+fd0z0Kfw8XeuyKzRJ2ePWNakXWmFPqpINO0FUdubkkCY1aWnRsf2z
        tkPp7BAGIAOTqIVLCFKYQc2lKnt9J1+/c7cSajfYVj9Yc+cVakTjJpwzPxuJQcOdLiYbU8
        1FSFL93LqlYPZnXicbH7xylbFTdkMLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-WHOBePpLPQ6Z8b9zSM6nQQ-1; Thu, 31 Mar 2022 11:17:33 -0400
X-MC-Unique: WHOBePpLPQ6Z8b9zSM6nQQ-1
Received: by mail-wm1-f72.google.com with SMTP id t124-20020a1c4682000000b0038c8e8f8212so13073wma.2
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEwAR/Gni372j/P0y7tdDtZZz8h0mfxsCzY2qJx8CsE=;
        b=QKnIknSvGkgY9C0236jzs1Pi/dpdE6XqaUz3moMZWZf4YMILLnd+JVTMvBj1rexo2o
         OCQiFTZUfyfQ5iZPuqxW/Q8mmSiWKgmiHN+X8FR7woQHGI7A+oslanyudObbSju4VsUW
         EIIwvfYOh5rVmLhWIqFzAqpWa0044FsG/+DOSr7WmMdp6FW1HwVImtQgwqALrgPZkKNy
         NpUqc4buQyq+p3P9cbglSx6kJ8LtL3PznaeepEg87LPpBizPR1/H0eIdB7AzLH00HEeA
         BK6ai7uHV7Fy/f6YLkrGNxWVZKvZHB9/Dv1YM1o0b4KX5m5ZEVHeg7DnXZiLHvAXdcuh
         8Wbg==
X-Gm-Message-State: AOAM533mXmHIJcdEWeoFz58pTIpYjAZA52O9QbQt0cbrKG3K3hQHL2G1
        JEGiERgr35KbkqMCI0272/cOPUaYaRXinNLEieIVGiH0WBnB/iszmz5xGCOaZ+oxGK1Q0BQmvMD
        hmwqLIN+CEA0sbD234ATp
X-Received: by 2002:a5d:6d07:0:b0:205:7ac5:1453 with SMTP id e7-20020a5d6d07000000b002057ac51453mr4370701wrq.149.1648739851197;
        Thu, 31 Mar 2022 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJhChN55fH7X2HEAxHVoQGnah1Wmstv88kgk0/7wUZe4HVN1l0k6LzKh54kulNxCCIYkmEcA==
X-Received: by 2002:a5d:6d07:0:b0:205:7ac5:1453 with SMTP id e7-20020a5d6d07000000b002057ac51453mr4370689wrq.149.1648739850906;
        Thu, 31 Mar 2022 08:17:30 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm25721795wry.32.2022.03.31.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:17:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] efi: Allow to enable EFI runtime services by default on RT
Date:   Thu, 31 Mar 2022 17:16:54 +0200
Message-Id: <20220331151654.184433-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit d9f283ae71af ("efi: Disable runtime services on RT") disabled EFI
runtime services by default when the CONFIG_PREEMPT_RT option is enabled.

The rationale for that commit is that some EFI calls could take too much
time, leading to large latencies which is an issue for Real-Time kernels.

But a side effect of that change was that now is not possible anymore to
enable the EFI runtime services by default when CONFIG_PREEMPT_RT is set,
without passing an efi=runtime command line parameter to the kernel.

Instead, let's add a new EFI_DISABLE_RUNTIME boolean Kconfig option, that
would be set to n by default but to y if CONFIG_PREEMPT_RT is enabled.

That way, the current behaviour is preserved but gives users a mechanism
to enable the EFI runtimes services in their kernels if that is required.
For example, if the firmware could guarantee bounded time for EFI calls.

Also, having a separate boolean config could allow users to disable the
EFI runtime services by default even when CONFIG_PREEMPT_RT is not set.

Reported-by: Alexander Larsson <alexl@redhat.com>
Fixes: d9f283ae71af ("efi: Disable runtime services on RT")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Improve commit description to make clear the motivation for the change
  (Sebastian Andrzej Siewior).

 drivers/firmware/efi/Kconfig | 15 +++++++++++++++
 drivers/firmware/efi/efi.c   |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..243882f5e5f9 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -284,3 +284,18 @@ config EFI_CUSTOM_SSDT_OVERLAYS
 
 	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
 	  information.
+
+config EFI_DISABLE_RUNTIME
+	bool "Disable EFI runtime services support by default"
+	default y if PREEMPT_RT
+	help
+	  Allow to disable the EFI runtime services support by default. This can
+	  already be achieved by using the efi=noruntime option, but it could be
+	  useful to have this default without any kernel command line parameter.
+
+	  The EFI runtime services are disabled by default when PREEMPT_RT is
+	  enabled, because measurements have shown that some EFI functions calls
+	  might take too much time to complete, causing large latencies which is
+	  an issue for Real-Time kernels.
+
+	  This default can be overridden by using the efi=runtime option.
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5502e176d51b..ff57db8f8d05 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -66,7 +66,7 @@ struct mm_struct efi_mm = {
 
 struct workqueue_struct *efi_rts_wq;
 
-static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT);
+static bool disable_runtime = IS_ENABLED(CONFIG_EFI_DISABLE_RUNTIME);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;
-- 
2.35.1

