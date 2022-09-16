Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E825BA7EA
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIPIPQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIPIPN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 04:15:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5474E4661F
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 01:15:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e17so30392947edc.5
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=p5xVR5XHdV8YeSAdx670VuL1IIfCA2uRS4x1Xjtb0eo=;
        b=C1QPCv1QKAlfPMTZjjpcY24Wr40mP8XHmMp8xA5sW84doGt9SJCco39z5UVCNi6+n8
         uLX8ZG5Bp8OJkiYUQ7Gn+owyvG1aheWaw6R5OmPKZIZW7gQQY5OA0R1jklbamXnBalHQ
         NsF3ZgzTOkP7v+dqfXvM4/LhoHK3jt+e6fyjprzdBexPyvCaqkl9uUVihZdBJSWidDMY
         lGboEmXUkDsdI4E+Bo5lSXxWpM/b+s0652FaO9Ou6DPBNxpY2a8mkkhiOgPKJ4g9W141
         eNx9xMkHTkydu5tR3uR4tM2mSB3sLc99GubN3pAnvtUpdTXuuuqGGMF6baWxDgIEtWX2
         v/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=p5xVR5XHdV8YeSAdx670VuL1IIfCA2uRS4x1Xjtb0eo=;
        b=aa+uS/cg5H10MqX56ppU/we4HYse56w+u35KsQ4Uka7kIyafWIv8fmR7zEaLFi3or1
         mN4tSgGs/5i5f3qXNXcmY9csdHaFDCL+bIJWVTCBE8QgtD4j2OZo+q9masWieAUhDP1K
         Hz4te5NvUTHRG0XrQnuLuSxc6Gr6E8uR6iam5D8ir8kWPed+tkslnjleJ7excoQj0Sb5
         It4kjoOeA/MHd2AYEoZVQa5c1XjOaFhz/ALDqd4GWN4Zwkwem0H3Dmg7j0hHvytkzb8U
         OUQFTHEvNYGTRUlSMHs9kD3GtfJc/fcvd/rXho2iXSWyvwkEshOcSvhpgXdF+6TjkvfS
         F/Ng==
X-Gm-Message-State: ACrzQf1EAcooHLaqwJunENvy3Vr0NLb1yar6gN0uJYfHaz0VcavjkzjC
        yzmgIy8HmSWgP8/+uvRPAON4Hg==
X-Google-Smtp-Source: AMsMyM4f1MTX2JL/+o3n8qPUXJdq2gVILe0xgSKx59y4OKS3aku/5dYS8Lzxb5leZFr5WJcdFHrzLg==
X-Received: by 2002:a05:6402:90e:b0:443:ec4b:2b03 with SMTP id g14-20020a056402090e00b00443ec4b2b03mr2919832edz.71.1663316106867;
        Fri, 16 Sep 2022 01:15:06 -0700 (PDT)
Received: from hades.. ([46.103.15.185])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090676ca00b0072ed9efc9dfsm10060464ejn.48.2022.09.16.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:15:06 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     ardb@kernel.org
Cc:     pjones@redhat.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Baskov Evgeniy <baskov@ispras.ru>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] efi/libstub: refactor the initrd measuring functions
Date:   Fri, 16 Sep 2022 11:14:34 +0300
Message-Id: <20220916081441.1993492-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, from the efi-stub, we are only measuring the loaded initrd.
A following patch is introducing measurements of extra components.

The current functions are limited in measuring an initrd only, so swap
the code around a bit,  move the struct into the stub header files and
add an extra argument containing the tagged event we are about to measure

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 82 +++++++++----------
 drivers/firmware/efi/libstub/efistub.h        |  6 ++
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3d972061c1b0..3ef4867344b9 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -334,6 +334,28 @@ void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_si
 	*load_options_size = load_option_unpacked.optional_data_size;
 }
 
+static
+void efi_measure_tagged_event(unsigned long load_addr, unsigned long load_size,
+			      const struct efi_measured_event *event)
+{
+	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	efi_tcg2_protocol_t *tcg2 = NULL;
+	efi_status_t status;
+
+	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
+	if (tcg2) {
+		status = efi_call_proto(tcg2, hash_log_extend_event,
+					0, load_addr, load_size,
+					&event->event_data);
+		if (status != EFI_SUCCESS)
+			efi_warn("Failed to measure data: 0x%lx\n",
+				 status);
+		else
+			efi_info("Measured %s into PCR %d\n", event->tagged_event_data,
+				 event->event_data.event_header.pcr_index);
+	}
+}
+
 /*
  * Convert the unicode UEFI command line to ASCII to pass to kernel.
  * Size of memory allocated return in *cmd_line_len.
@@ -625,47 +647,6 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				    load_addr, load_size);
 }
 
-static const struct {
-	efi_tcg2_event_t	event_data;
-	efi_tcg2_tagged_event_t tagged_event;
-	u8			tagged_event_data[];
-} initrd_tcg2_event = {
-	{
-		sizeof(initrd_tcg2_event) + sizeof("Linux initrd"),
-		{
-			sizeof(initrd_tcg2_event.event_data.event_header),
-			EFI_TCG2_EVENT_HEADER_VERSION,
-			9,
-			EV_EVENT_TAG,
-		},
-	},
-	{
-		INITRD_EVENT_TAG_ID,
-		sizeof("Linux initrd"),
-	},
-	{ "Linux initrd" },
-};
-
-static void efi_measure_initrd(unsigned long load_addr, unsigned long load_size)
-{
-	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
-	efi_tcg2_protocol_t *tcg2 = NULL;
-	efi_status_t status;
-
-	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
-	if (tcg2) {
-		status = efi_call_proto(tcg2, hash_log_extend_event,
-					0, load_addr, load_size,
-					&initrd_tcg2_event.event_data);
-		if (status != EFI_SUCCESS)
-			efi_warn("Failed to measure initrd data: 0x%lx\n",
-				 status);
-		else
-			efi_info("Measured initrd data into PCR %d\n",
-				 initrd_tcg2_event.event_data.event_header.pcr_index);
-	}
-}
-
 /**
  * efi_load_initrd() - Load initial RAM disk
  * @image:	EFI loaded image protocol
@@ -683,6 +664,22 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long hard_limit)
 {
 	efi_status_t status;
+	static const struct efi_measured_event initrd_tcg2_event = {
+		{
+			sizeof(initrd_tcg2_event) + sizeof("Linux initrd"),
+			{
+				sizeof(initrd_tcg2_event.event_data.event_header),
+				EFI_TCG2_EVENT_HEADER_VERSION,
+				9,
+				EV_EVENT_TAG,
+			},
+		},
+		{
+			INITRD_EVENT_TAG_ID,
+			sizeof("Linux initrd"),
+		},
+		{ "Linux initrd" },
+	};
 
 	if (efi_noinitrd) {
 		*load_addr = *load_size = 0;
@@ -692,7 +689,8 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 		if (status == EFI_SUCCESS) {
 			efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
 			if (*load_size > 0)
-				efi_measure_initrd(*load_addr, *load_size);
+				efi_measure_tagged_event(*load_addr, *load_size,
+							 &initrd_tcg2_event);
 		} else if (status == EFI_NOT_FOUND) {
 			status = efi_load_initrd_cmdline(image, load_addr, load_size,
 							 soft_limit, hard_limit);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b0ae0a454404..cb7eb5ed9f14 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -765,6 +765,12 @@ typedef struct efi_tcg2_event efi_tcg2_event_t;
 typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
 typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 
+struct efi_measured_event {
+	efi_tcg2_event_t	event_data;
+	efi_tcg2_tagged_event_t tagged_event;
+	u8			tagged_event_data[];
+};
+
 union efi_tcg2_protocol {
 	struct {
 		void *get_capability;
-- 
2.34.1

