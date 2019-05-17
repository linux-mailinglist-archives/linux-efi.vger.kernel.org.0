Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1202B21FB6
	for <lists+linux-efi@lfdr.de>; Fri, 17 May 2019 23:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfEQVjZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 May 2019 17:39:25 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:40289 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbfEQVjZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 May 2019 17:39:25 -0400
Received: by mail-oi1-f202.google.com with SMTP id q82so3380652oif.7
        for <linux-efi@vger.kernel.org>; Fri, 17 May 2019 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NMhZkopB0GpdYEYudYKJxS5gWiq2qdR7lapWfQjPHn0=;
        b=SVK7SiPj/V3msfc/agSdMuR9LrKkbFO1/ab3d9PXzQ9M9qUO3aPHl1n+vK96HAVeYn
         10FDapu3hsEc9f/lfnMM4yCzlTVLdAf8Io0hozKJedsHhMkFNdzRmwPLD7M5kF3BbRNh
         gZukKztYKQeYm0ODATLLWCMn5cGKaWUPFoVr4zsqqSnqFwKrNCAmlZRK0Ki3BetJfqWr
         iJzmDtWMc9m8BvjrBxCwRcD4Amc6ZjaYJV8uGUlEyxUAL86OUonvxSnbCnbt50l7ySsW
         VqPcjco2lRSQjKT5iwzITTrgLfmIRMk+DDCiZHEGs4D+o/CcMrPh79iD6v/CK6fU/DkF
         3H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NMhZkopB0GpdYEYudYKJxS5gWiq2qdR7lapWfQjPHn0=;
        b=ej891aleiheYhgnTlod5QGtTAVFjnmUrTmg5dqf4BPNxTUNxj4MW8CdBYYvqwDd5ED
         31N//oeoqI26tBRWzJrslEYNz4nRStATSyVQ5BZ33ERzuXG/a1AIjQNLJka6wjXyhXj3
         +UTywbYhXnuZRbZXtDEpkgQQoGofm+qYwrDz5VwrnJZpTRsNAwKd2rFSVT8HiZjjz7zK
         xJlUSTj8ahiTWiKXiL6kVgtFvPqvj9bpxuqN237Rpd9vokAtZYsdQ1/BXqcQmM2n9PQf
         3GzEVdGNSZV/sLBSlTPXEL3yCGeoOehZzkdimztwlzU/hngsdEOfdJNVnKi2Tw3qiLnU
         dYrA==
X-Gm-Message-State: APjAAAUb98RHKjcz4x0DmQ/uC63lwtTQP6uJpUs8YqTAVmStUCJbmLw+
        KiqZkiJ++okp/xnOybPzWRbExJWr6gJ2jb4DMeGC6g==
X-Google-Smtp-Source: APXvYqx5qlxXPSzsxfB4hCYJ9cYilyQiRVQHXdTQs11EVxGGS+4U4FmM3CEY9rrsh4jWlBe/H/N/BWdBWq09Pglde5Ca3w==
X-Received: by 2002:aca:c353:: with SMTP id t80mr15750329oif.75.1558129164259;
 Fri, 17 May 2019 14:39:24 -0700 (PDT)
Date:   Fri, 17 May 2019 14:39:15 -0700
In-Reply-To: <20190517213918.26045-1-matthewgarrett@google.com>
Message-Id: <20190517213918.26045-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517213918.26045-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V6 1/4] tpm: Abstract crypto agile event size calculations
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
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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

