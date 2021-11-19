Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACF456E74
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 12:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKSLvQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 06:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSLvP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Nov 2021 06:51:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6440C061574
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so17653582wru.13
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiO21zSqE5ENxg4llYKgkKic/silz8q1gk5tkTFY9/0=;
        b=XB/2BKbJk+Vu0+q1OYePVA/F97FMtwkwemqg6Gs3xxVh4okVFp8BDnVW5p8T+6I/ZP
         vC3rYxBFuKZ5Q1xQ/AFvPiRztmEZYv7c1ncgqekMB85FLrJr8xNYtq/Y+yUQDnnnMj7p
         XoDSJMtGrJ0qE7inxOwbkSRj8f7nBAv+wX0EQfYgrt0dH0X4HC+Mut+VTiPi6ozq9y5X
         jeJLp8oMBt2zUQV1kPQ0G35sj6j65X/SGF6t5r65Erzugn/k/4yPQZzbWSAHnKgxfcNi
         qnm+0e/jDMvY4spF7YEaTqJjMIj34rCHjz+IiUSu3ZIR023yLx/MdALosRH8ivav+bJN
         x0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiO21zSqE5ENxg4llYKgkKic/silz8q1gk5tkTFY9/0=;
        b=eqoEsNv6xDFuzOmIclOYgKSxC+NX+Lco/UDjGxFbQye00g0u8hUVr6IfxwhKWNucmJ
         dfXtS5VeCSe8/l8OQcNhqE5hozqZWkm2kO8BMCCNrvjYX5okVRybWUavfucsjQYlW7qC
         GYJkH7oVg9yXqgsBqEPwPWAvtxPUGQS+VDV0Fq9ImLeUP3LlCfR3kFcb2ltxDEBKFoVh
         Mp2bNYSai/gsHwt/mq4y8aSQIDocpT8Nw7CL8zg2zpMmTgePZuuUdpiEvlbhPqk0KyrQ
         VAwLwTBmgO/uaxIfLTqXdC6m94ZR8JUHeUZ8NsrYbFZxvsvFW/6pCYFgBZ2hYwUaaX6g
         vnKQ==
X-Gm-Message-State: AOAM530Zw+suLhecx4AxgRzONiEg1GZcHNra6siwgH7XNLB3iLyC1XOj
        eKBQhviCQ50yUCoam9fMMC01dzYaaf/cFg==
X-Google-Smtp-Source: ABdhPJy2OfT881a+0Ih+DBV2/HUb9ux48DGUYvvuEMoUVbpZZYb58mWevABkdYoiXYmW4ZAXQCojQg==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr6811780wrw.396.1637322488344;
        Fri, 19 Nov 2021 03:48:08 -0800 (PST)
Received: from apalos.home ([2a02:587:4627:18c0:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c4sm2688039wrr.37.2021.11.19.03.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:48:07 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 4/4 v3] efi/libstub: measure loaded initrd info into the TPM
Date:   Fri, 19 Nov 2021 13:47:45 +0200
Message-Id: <20211119114745.1560453-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
References: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
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
Changes since v1,2:
- None
 .../firmware/efi/libstub/efi-stub-helper.c    | 72 +++++++++++++++----
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 01677181453d..0bd01da1f0df 100644
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
2.33.1

