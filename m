Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE50324250
	for <lists+linux-efi@lfdr.de>; Mon, 20 May 2019 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfETUzS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 May 2019 16:55:18 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41518 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfETUzQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 May 2019 16:55:16 -0400
Received: by mail-pg1-f201.google.com with SMTP id d7so10487152pgc.8
        for <linux-efi@vger.kernel.org>; Mon, 20 May 2019 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2S/gHsQaO08L1k/kaLAgP/iaI6c/d06OZBDkdH1Ekx0=;
        b=bn7WHiENp+Jgwq76sRokv6v0WVMG7P/MdlQ0xYiJJeuGCup45bH514LUOM4BaBFOuw
         hIy6lnvtRfymw2xIt/dCmLB5QS6fGxTOlZYBEXpo0fOw05p1vzBfpNRMnKilxoy8UJmN
         RundMf4Zidiv5pdMqiDJvIqlfmZe4p5XNL2Bn1ZR7Dqmvkh6yYJEVYefZZAvfG0DAdhn
         WVNDbeYz1YoQ3AbvTdCoacQlkFj8rWvYmubnWoAplDxM0LIxIKMh5grd4dEY/YsLNvRf
         rvu7FgRa2sS22ddDAmespjdjtj/wHQO2czYud2euSGrg99uYS6zQvwMyGrquZxSrhL+P
         d4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2S/gHsQaO08L1k/kaLAgP/iaI6c/d06OZBDkdH1Ekx0=;
        b=c4cffT+8fhAs+xRAXFT9+/Bct8P/RcD4kKgj11Odm155C71NqxJXk1hC+qJjqr8siA
         +1FZr4s7lKHd4WXynmV5PEfIEnheK6uLvAvUF35vO4lAZnz22A9urqdCOTbOWcWBa6LY
         aCv5TOuCVHvrfp2P3Q5nsPBJXI1uWXjI6zYUuUqlzcXBCeWFCKGfLLZt6UrkE9abl1E2
         iFWg3eJMnxz6bZnbo2BRn/BZIJ0kfege1jcAwB6pRRS5za3iCnQ1SgDu/lXyOk4oZLwI
         NlkJF3XAIfTxzwKz+5nEnxxtoQjRixa/GUkDgE5BOmXeGQ179mm3HkPeLkuEmz8FKRik
         Nt0w==
X-Gm-Message-State: APjAAAVKdypynBUXlBOERt2gm/LOfJvho12gbOwLZiakde0bVRwJI/ri
        1W823R0RZrqA5roDJwGQe1UJTOnPntLRvNaoyblRkw==
X-Google-Smtp-Source: APXvYqzXluYerRenEIporaBqlL0VKRUEYZ6bb//DTlFcuJIwvPvXL8WLmsndEpl+oa5KGu6dGG7EK4vv+klAAzBgskcu3w==
X-Received: by 2002:a63:1061:: with SMTP id 33mr51272273pgq.328.1558385715691;
 Mon, 20 May 2019 13:55:15 -0700 (PDT)
Date:   Mon, 20 May 2019 13:55:01 -0700
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
Message-Id: <20190520205501.177637-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 4/4] efi: Attempt to get the TCG2 event log in the boot stub
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

Right now we only attempt to obtain the SHA1-only event log. The
protocol also supports a crypto agile log format, which contains digests
for all algorithms in use. Attempt to obtain this first, and fall back
to obtaining the older format if the system doesn't support it. This is
lightly complicated by the event sizes being variable (as we don't know
in advance which algorithms are in use), and the interface giving us
back a pointer to the start of the final entry rather than a pointer to
the end of the log - as a result, we need to parse the final entry to
figure out its length in order to know how much data to copy up to the
OS.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/firmware/efi/libstub/tpm.c | 50 ++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 5bd04f75d8d6..6b3b507a54eb 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -57,7 +57,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
 
 #endif
 
-static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
+void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
@@ -67,6 +67,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
+	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	void *tcg2_protocol = NULL;
 
 	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
@@ -74,14 +75,20 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		return;
 
-	status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
-				EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
-				&log_location, &log_last_entry, &truncated);
-	if (status != EFI_SUCCESS)
-		return;
+	status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+				tcg2_protocol, version, &log_location,
+				&log_last_entry, &truncated);
+
+	if (status != EFI_SUCCESS || !log_location) {
+		version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+		status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+					tcg2_protocol, version, &log_location,
+					&log_last_entry, &truncated);
+		if (status != EFI_SUCCESS || !log_location)
+			return;
+
+	}
 
-	if (!log_location)
-		return;
 	first_entry_addr = (unsigned long) log_location;
 
 	/*
@@ -96,8 +103,23 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 		 * We need to calculate its size to deduce the full size of
 		 * the logs.
 		 */
-		last_entry_size = sizeof(struct tcpa_event) +
-			((struct tcpa_event *) last_entry_addr)->event_size;
+		if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+			/*
+			 * The TCG2 log format has variable length entries,
+			 * and the information to decode the hash algorithms
+			 * back into a size is contained in the first entry -
+			 * pass a pointer to the final entry (to calculate its
+			 * size) and the first entry (so we know how long each
+			 * digest is)
+			 */
+			last_entry_size =
+				__calc_tpm2_event_size((void *)last_entry_addr,
+						    (void *)(long)log_location,
+						    false);
+		} else {
+			last_entry_size = sizeof(struct tcpa_event) +
+			   ((struct tcpa_event *) last_entry_addr)->event_size;
+		}
 		log_size = log_last_entry - log_location + last_entry_size;
 	}
 
@@ -114,7 +136,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 
 	memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
 	log_tbl->size = log_size;
-	log_tbl->version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	log_tbl->version = version;
 	memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
 
 	status = efi_call_early(install_configuration_table,
@@ -126,9 +148,3 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 err_free:
 	efi_call_early(free_pool, log_tbl);
 }
-
-void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
-{
-	/* Only try to retrieve the logs in 1.2 format. */
-	efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
-}
-- 
2.21.0.1020.gf2820cf01a-goog

