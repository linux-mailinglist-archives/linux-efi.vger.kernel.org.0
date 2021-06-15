Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B4B3A7A5D
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jun 2021 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhFOJXV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Jun 2021 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhFOJXV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Jun 2021 05:23:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56777C061574
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y7so17491672wrh.7
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ioIvs9kzobkkAHLcK97KuxhTtDxwmJispZo4nSy/tU=;
        b=Ca9BuDcxiH3gVC4ECG8WrMxCy8B5dTYf9YGyy0jR1AaugshUYwZ0lcrZVYd4rSiIuB
         rbDgLcoEkvo+dLbjKGlFjYZAOss7zdsnOTYtn+oPfUYQIkrv+EnwOhs4EQ7jOqjaTeXR
         01PhEQ21MQNpn0EdPN3CumaXN0BH2OuGIHnB7cpUgA9VBqA0mwu/uFPa60crDuq1a01i
         HJ5Mqg5bc44eNPYgl9d8BPfqhWWdrOiSulpIPG6WNR/e0iMJGhHkwsn7SQgt27jnzvKi
         QG/mOy4KVOxGUgz+H4a2IMR/qt064VXbvUoyoXKRcQLszaNrb2f2rYPXLRKJ7MZlYcXZ
         xqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ioIvs9kzobkkAHLcK97KuxhTtDxwmJispZo4nSy/tU=;
        b=ednBr8au426RXN8HOXyZ93llVpQB6zzD0N1XsHIw798bQiR9dLCazXez4gaejjOfNC
         QysKpBr4KODaztX3Abjm0YFOB1EYCmv+d5Z8CrkwlU2NH0w4bMKsJy8xKHnxI+XXMG3P
         smdbZQjc6YXJN/RQBEn9iYyz+7R7IZlxehrel1z1n9uTK1qwwi39CkqmFnLUNPsbfNxV
         dPZmN6VfiIWrV8YLUDk88NbTD0ihosPfbhZ0I0tY2+zv6CFx8Vit5/EhYDMv7wDZTuoy
         bNm/LwKMvuTZf7NTJodenwkSBidJddCil1TGecktprmR2X+fVn6t8OoPlPY9YDLkRJUo
         GilQ==
X-Gm-Message-State: AOAM53211GYpfgKK/S8mxC1dq0+9n8nRaobBjziFnXsbyTUT30dXYvUL
        wiFAQGpzqDsqNNfx54TI5XWe6gbpbheYpA==
X-Google-Smtp-Source: ABdhPJy+lUxM0LO+bjpIiI3CIAeaD9MhF8zo78bGRMJDlhce59MO1lhksB79jH8NEefKfona7+sh/g==
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr24254524wri.290.1623748874995;
        Tue, 15 Jun 2021 02:21:14 -0700 (PDT)
Received: from apalos.home ([2a02:587:4680:7ec2:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id h15sm18280113wrq.88.2021.06.15.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:21:14 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 4/4] efi/libstub: measure loaded initrd info into the TPM
Date:   Tue, 15 Jun 2021 12:21:05 +0300
Message-Id: <20210615092105.288331-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
References: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
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

