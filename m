Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2793FEA60
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbhIBIGa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbhIBIFk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 04:05:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A50C061760
        for <linux-efi@vger.kernel.org>; Thu,  2 Sep 2021 01:04:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf2so2325947ejb.9
        for <linux-efi@vger.kernel.org>; Thu, 02 Sep 2021 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8maSlXDpYERJw6UOL+RiwtHzep+cI9f9tKiwdyBJAFY=;
        b=IwZvCtCqZdLoWYyw9rVO/a2y1lt8vOPEdBrbiliUOtyqajravul6qPpMJdabGMGXCT
         aI7ldrP3a6KNvaInziobgZEMRa5a8FTzQgtLPvuDZyzuyMe9qDeRWq+t81gb8cUHgvDE
         pnKeePFHBggS3acziEJWMYtSTg4Z2qHSNy9b5mS2GmyxoRXpHhaH3HHAAEoEOjl9uh35
         +NYKxK7ENWM3BYv2M3nPZ2jzRHGxGVRxTJ06eGOKmkas88rl8Ks0l+s13uWmgBjzT9g0
         4LfyWUfwMXAqP4Wj1+bjRZJ5nvZinIqUVmWn8PzN7fOJ7WFrPziDSz9xmcESIX2KZ8Jt
         i/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8maSlXDpYERJw6UOL+RiwtHzep+cI9f9tKiwdyBJAFY=;
        b=NEIdoSujg9shk4cSvuu2ZeeWqRJwGb3pi1ZDlPzUp/Z2Z/6ABLOPF6cEuQ7hUmLPQq
         nrAITzePymXKG+3y3LwCv7dqzI+d3NTvjQ6KlssaSYHDzee04Wk7HBBfJrU5qw1yoF9x
         CRemAZQVKCfLgxneUauk7y8wKi7/IUTfABPZw02oEFQUYKMo65M0hNcSQ7hlGXIOPF+u
         pVeREyQuFzVR6T1oliCfC2H/r4rtT6I6V0Lor4uK1liXvKHKcqfz9jb5ZAL/5xILFhHK
         gCp3FYMLIClejzykKHEZqS5aOdnVcYbHSzKn+1NL0uP8Lhh1I/PALZDeh55FCh0Gf+kI
         WEeQ==
X-Gm-Message-State: AOAM531c23zixODtz8I9vDKA5MtpXn7ac+nyQAxmyYFdvLKRQs/8G/bL
        o80C9VE8o7iCa43OfQgMMRhDV4TckiueeA==
X-Google-Smtp-Source: ABdhPJyrVO0YHAWnL8Ju76Gwf6QLjZq5484joPJO/d7uywnCaZSA53dmbb7LpgO7L0V6bdFjtzVL0A==
X-Received: by 2002:a17:906:2c14:: with SMTP id e20mr2461701ejh.46.1630569880658;
        Thu, 02 Sep 2021 01:04:40 -0700 (PDT)
Received: from localhost.localdomain (ppp-94-66-220-137.home.otenet.gr. [94.66.220.137])
        by smtp.gmail.com with ESMTPSA id m12sm537105ejd.21.2021.09.02.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:04:40 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com
Cc:     pjones@redhat.com, nivedita@alum.mit.edu, mjg59@google.com,
        daniel.kiper@oracle.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 4/4 v2] efi/libstub: measure loaded initrd info into the TPM
Date:   Thu,  2 Sep 2021 11:04:16 +0300
Message-Id: <20210902080416.5461-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
References: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
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
2.32.0.rc0

