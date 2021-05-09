Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3037767E
	for <lists+linux-efi@lfdr.de>; Sun,  9 May 2021 13:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhEILqP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 May 2021 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhEILqO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 May 2021 07:46:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60276C061573
        for <linux-efi@vger.kernel.org>; Sun,  9 May 2021 04:45:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d4so13683037wru.7
        for <linux-efi@vger.kernel.org>; Sun, 09 May 2021 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ioIvs9kzobkkAHLcK97KuxhTtDxwmJispZo4nSy/tU=;
        b=OcesdDDrcM8IxrHPK95o4/hwnzpdS4D+SIj3fxNOd2/7iqBZ5HmK694tJuA7kFmQPF
         F+/H2V/B/clG2WV5zQA5Gk8B/C7rvrMWq3kDn85R0Yql6KEd1TAjRGNzwqDUcetGNzD+
         VEijp4TLZRnHtWpaeTe3Zu4bQkIqgtZgMdn0gagcOLny+EggQ9P/U2yChLR47MzDge0u
         FX3IdumwT0wtUoX/gWLnEWJsYHLyd6whfmz36O2n+PRM7QOx+A916K+M76Geoat5cNxY
         pYuk+oa3Oj1Vgtov3yuhf2pjw/K6p8qwKYKX4W5w/7FqzOBWj7UwFSXS4inFOzK9/scg
         kioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ioIvs9kzobkkAHLcK97KuxhTtDxwmJispZo4nSy/tU=;
        b=aRjehX0MCB0KwzwgvzDvSGx9otkXLIwlaXxPlA3EhfHnDIuqyNR0ZJMCUxPbcLs44b
         lX5J1xx8YJZ4mGVr8KfJdAWtW4ZCNER4eYNf/HO5NtV75E4Kp9ihTK6tcTrAM4sbQzLR
         1FtfB95IoyDvkq7MzIGhu7L9MSGBr3I3qTOM92Qw426DD3QeBjf6ig5K0dfAUa3d2ph4
         uvBhOi8BBYH71BgyXDfnX4xsLb2H7TjHMK2sDzFHx+IlovkMKnre2ZAUwOk2pdJ4jFHR
         X6shfNO4CYDhe29rNXgx2BJ8tjh/Mo7bj1KlqICb812nI72RZ+y4uxwxbxrVRaegnOrs
         rjLg==
X-Gm-Message-State: AOAM5307ACevEIzxVivakZ+BcefIfMEfnOqARdb3BfJtq5pj2yxnmkaC
        CrZA1lZrbmPs+WCrFNzuqx82Ed85JLORXA==
X-Google-Smtp-Source: ABdhPJzn8C69bOc20gkiBElBQ8SBT75JDCiw+HTmJOMwtPxNaS6ufAZAi1/T8GJA8qhf9o38TByzEQ==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr24409059wrw.127.1620560710184;
        Sun, 09 May 2021 04:45:10 -0700 (PDT)
Received: from apalos.home ([2a02:587:466e:1389:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c8sm17650244wrx.4.2021.05.09.04.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 04:45:09 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 4/4] efi/libstub: measure loaded initrd info into the TPM
Date:   Sun,  9 May 2021 14:44:54 +0300
Message-Id: <20210509114454.185583-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
References: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In an effort to ensure the initrd observed and used by the OS is
the same one that was meant to be loaded, which is difficult to
guarantee otherwise, let's measure the initrd if the EFI stub and
specifically the newly introduced LOAD_FILE2 protocol was used.

Modify the initrd loading sequence so that the contents of the initrd
are measured into PCR9.  Note that the patch is currently using
EV_EVENT_TAG to create the eventlog entry instead of EV_IPL.  According
to the TCP PC Client specification this is used for PCRs defined for OS
and application usage.

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 72 +++++++++++++++----
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 72a7e7c4d403..c1d415bb534b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -625,6 +625,47 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				    load_addr, load_size);
 }
 
+static const struct {
+	efi_tcg2_event_t	event_data;
+	efi_tcg2_tagged_event_t tagged_event;
+	u8			tagged_event_data[];
+} initrd_tcg2_event = {
+	{
+		sizeof(initrd_tcg2_event) + sizeof("Linux initrd"),
+		{
+			sizeof(initrd_tcg2_event.event_data.event_header),
+			EFI_TCG2_EVENT_HEADER_VERSION,
+			9,
+			EV_EVENT_TAG,
+		},
+	},
+	{
+		INITRD_EVENT_TAG_ID,
+		sizeof("Linux initrd"),
+	},
+	"Linux initrd",
+};
+
+void efi_measure_initrd(unsigned long load_addr, unsigned long load_size)
+{
+	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	efi_tcg2_protocol_t *tcg2 = NULL;
+	efi_status_t status;
+
+	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
+	if (tcg2) {
+		status = efi_call_proto(tcg2, hash_log_extend_event,
+					0, load_addr, load_size,
+					&initrd_tcg2_event.event_data);
+		if (status != EFI_SUCCESS)
+			efi_warn("Failed to measure initrd data: 0x%lx\n",
+				 status);
+		else
+			efi_info("Measured initrd data into PCR %d\n",
+				 initrd_tcg2_event.event_data.event_header.pcr_index);
+	}
+}
+
 /**
  * efi_load_initrd() - Load initial RAM disk
  * @image:	EFI loaded image protocol
@@ -645,22 +686,25 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 
 	if (efi_noinitrd) {
 		*load_addr = *load_size = 0;
-		return EFI_SUCCESS;
+		status = EFI_SUCCESS;
+	} else {
+		status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
+		if (status == EFI_SUCCESS) {
+			efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+			if (*load_size > 0)
+				efi_measure_initrd(*load_addr, *load_size);
+		} else if (status == EFI_NOT_FOUND) {
+			status = efi_load_initrd_cmdline(image, load_addr, load_size,
+							 soft_limit, hard_limit);
+			if (status == EFI_SUCCESS && *load_size > 0)
+				efi_info("Loaded initrd from command line option\n");
+		}
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to load initrd: 0x%lx\n", status);
+			*load_addr = *load_size = 0;
+		}
 	}
 
-	status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
-	if (status == EFI_SUCCESS) {
-		efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-	} else if (status == EFI_NOT_FOUND) {
-		status = efi_load_initrd_cmdline(image, load_addr, load_size,
-						 soft_limit, hard_limit);
-		if (status == EFI_SUCCESS && *load_size > 0)
-			efi_info("Loaded initrd from command line option\n");
-	}
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to load initrd: 0x%lx\n", status);
-		*load_addr = *load_size = 0;
-	}
 	return status;
 }
 
-- 
2.31.0

