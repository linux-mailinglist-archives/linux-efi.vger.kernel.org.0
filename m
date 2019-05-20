Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B498724246
	for <lists+linux-efi@lfdr.de>; Mon, 20 May 2019 22:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfETUzJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 May 2019 16:55:09 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41396 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfETUzJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 May 2019 16:55:09 -0400
Received: by mail-qt1-f202.google.com with SMTP id l37so15296957qtc.8
        for <linux-efi@vger.kernel.org>; Mon, 20 May 2019 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=akrm/3bgh71I70hR0K09l3Kfzzk0aIwNcfCkA5T1H8s=;
        b=YBpxht9kl8QYDiQ4NThsO65nDKncBg5XXpPzCNuHbT4kR7k7m0qx2/e6WdDmMsY2LY
         2iLbS1wFLp6/bGp5FJa/Eo9+dJu1YFPAi9sl9XwAPRy5XI699M8FGgE45AOooLuweR6O
         gha7bK5+MQaJxFFeJAk3iPUZltWJVWxqBNLcjgfb3Cu7FLGAHh+Mgx61RYJGcEls3wcv
         ioK5P59ZLO4RWWuJe8gEgYB0SLYIr0S0drSe5DfqZ8oE9wDAy6Hq5siXjpUcd4nlvldz
         jmEdqpWaXcU0TJhsFdE6Jlqwynd771VjOkcgUnAoBRH14294GeufY8URUrFX2A7JYt4O
         sBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=akrm/3bgh71I70hR0K09l3Kfzzk0aIwNcfCkA5T1H8s=;
        b=Yra+DmZ6mTtUU+tKYwHVSzT4rbO0vaAVmRFwMrzEYRsMyAUN3SAIH4634lpLddELEC
         O90IhvqXQJDRRhD45hlz+VCtXAZEdm/N5E20GAtmEBxNJU1+46r9ko8VNVa86jBG4BCY
         Q6oQi2XnScSMBYn76wjR4qTbeICyJcx095p2/Nd5y3NzWxpabi5ptlwsfml4xz3d88m3
         3HIQyGMwxPBPa+ZtpY/7VVAVNbT23Rc8ngt089u7FQzbBi9yXcvSmcdqh0AXfuyna3DK
         RS53IWZfDlCensCGxuuptsUVuoa7bqVeHkCFcXGfHFRci83Qkupf0YXM8AP0UGvaGWNS
         e+bg==
X-Gm-Message-State: APjAAAX1rVWA5AdbIzRSuTdpm+0Br6PUngUutF0lqnFFN+eqzsTtSizt
        4cMALc8bJX6kxnhacrVjPoRN8gelwrciinydrivYhw==
X-Google-Smtp-Source: APXvYqzKTMYg8rW5jVfSQPhysQn7BFeOUlYvYPTcDiKFgnvWNRdEhRqy390LZ8ffPMPH9cPbWXbojWbOAP680fBQu19y3w==
X-Received: by 2002:aed:21ca:: with SMTP id m10mr60246543qtc.97.1558385708444;
 Mon, 20 May 2019 13:55:08 -0700 (PDT)
Date:   Mon, 20 May 2019 13:54:58 -0700
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
Message-Id: <20190520205501.177637-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 1/4] tpm: Abstract crypto agile event size calculations
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

We need to calculate the size of crypto agile events in multiple
locations, including in the EFI boot stub. The easiest way to do this is
to put it in a header file as an inline and leave a wrapper to ensure we
don't end up with multiple copies of it embedded in the existing code.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 47 +---------------------
 include/linux/tpm_eventlog.h     | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 46 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index f824563fc28d..1a977bdd3bd2 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,52 +40,7 @@
 static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				   struct tcg_pcr_event *event_header)
 {
-	struct tcg_efi_specid_event_head *efispecid;
-	struct tcg_event_field *event_field;
-	void *marker;
-	void *marker_start;
-	u32 halg_size;
-	size_t size;
-	u16 halg;
-	int i;
-	int j;
-
-	marker = event;
-	marker_start = marker;
-	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
-		+ sizeof(event->count);
-
-	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
-
-	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs)
-		return 0;
-
-	for (i = 0; i < event->count; i++) {
-		halg_size = sizeof(event->digests[i].alg_id);
-		memcpy(&halg, marker, halg_size);
-		marker = marker + halg_size;
-		for (j = 0; j < efispecid->num_algs; j++) {
-			if (halg == efispecid->digest_sizes[j].alg_id) {
-				marker +=
-					efispecid->digest_sizes[j].digest_size;
-				break;
-			}
-		}
-		/* Algorithm without known length. Such event is unparseable. */
-		if (j == efispecid->num_algs)
-			return 0;
-	}
-
-	event_field = (struct tcg_event_field *)marker;
-	marker = marker + sizeof(event_field->event_size)
-		+ event_field->event_size;
-	size = marker - marker_start;
-
-	if ((event->event_type == 0) && (event_field->event_size == 0))
-		return 0;
-
-	return size;
+	return __calc_tpm2_event_size(event, event_header);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 81519f163211..6a86144e13f1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -112,4 +112,72 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
 } __packed;
 
+/**
+ * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
+ * @event:        Pointer to the event whose size should be calculated
+ * @event_header: Pointer to the initial event containing the digest lengths
+ *
+ * The TPM2 event log format can contain multiple digests corresponding to
+ * separate PCR banks, and also contains a variable length of the data that
+ * was measured. This requires knowledge of how long each digest type is,
+ * and this information is contained within the first event in the log.
+ *
+ * We calculate the length by examining the number of events, and then looking
+ * at each event in turn to determine how much space is used for events in
+ * total. Once we've done this we know the offset of the data length field,
+ * and can calculate the total size of the event.
+ *
+ * Return: size of the event on success, <0 on failure
+ */
+
+static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+					 struct tcg_pcr_event *event_header)
+{
+	struct tcg_efi_specid_event_head *efispecid;
+	struct tcg_event_field *event_field;
+	void *marker;
+	void *marker_start;
+	u32 halg_size;
+	size_t size;
+	u16 halg;
+	int i;
+	int j;
+
+	marker = event;
+	marker_start = marker;
+	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
+		+ sizeof(event->count);
+
+	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
+
+	/* Check if event is malformed. */
+	if (event->count > efispecid->num_algs)
+		return 0;
+
+	for (i = 0; i < event->count; i++) {
+		halg_size = sizeof(event->digests[i].alg_id);
+		memcpy(&halg, marker, halg_size);
+		marker = marker + halg_size;
+		for (j = 0; j < efispecid->num_algs; j++) {
+			if (halg == efispecid->digest_sizes[j].alg_id) {
+				marker +=
+					efispecid->digest_sizes[j].digest_size;
+				break;
+			}
+		}
+		/* Algorithm without known length. Such event is unparseable. */
+		if (j == efispecid->num_algs)
+			return 0;
+	}
+
+	event_field = (struct tcg_event_field *)marker;
+	marker = marker + sizeof(event_field->event_size)
+		+ event_field->event_size;
+	size = marker - marker_start;
+
+	if ((event->event_type == 0) && (event_field->event_size == 0))
+		return 0;
+
+	return size;
+}
 #endif
-- 
2.21.0.1020.gf2820cf01a-goog

