Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E258221FC2
	for <lists+linux-efi@lfdr.de>; Fri, 17 May 2019 23:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfEQVj2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 May 2019 17:39:28 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:43531 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbfEQVj2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 May 2019 17:39:28 -0400
Received: by mail-ua1-f73.google.com with SMTP id j11so1334056uap.10
        for <linux-efi@vger.kernel.org>; Fri, 17 May 2019 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u5d38xV1/N4AabcTeBkfnMUCDeM0LLry/8W1Ndww4PM=;
        b=jktypvyi+XvERDRyRE+hAMJcHjuLJ2ZyOvvplIkF8aOlJyqMbGiabscWyDl9eHIWuu
         vbfRv4CGSPX5CmT2/37RDF++3lXNJRniQijznMlFiKTzNsNWOzgvWnTnzFvZ69/6i5rI
         SAb0vzfJPp/qKZmRCIAfLQ0cmWBWHlqQ4s8uejwj3RWwaGAJ8hzjy5BD2z41n92oy/h6
         wFlemYw/9m6Dopg19xVeLWaTc2pSraAPe2s331/alVo6TmfDiqzasznMC6ih/8ZLFBgc
         RiwdrptPw3rUkpe4SoGqfAmdkGWPOK/9QyNfsH+CDGWaIZZSohSfVq9AxoN3dUMP+z3/
         +zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u5d38xV1/N4AabcTeBkfnMUCDeM0LLry/8W1Ndww4PM=;
        b=qweao3tmctsiyu5ZaOAaZYsWI+/Zb2+NqJA9ZYq0sLLB6W3yjJKa/5TzvcoP5+ZC4w
         kNFeldzbVGqkv5lQbAeA0kqXclojEmznI8xwBjBbdCQkb5vlKE9SCY92PU8oMCXCDL2k
         WpUwRT29Zk//x/Om9cOVIb00nxvHUnp767NQik++iuhpCiJiXLs5IVUT9PaXUfUOp3QY
         KxDM8r+DAbqovr4wTrep1HiXLCXj9EZ0KBKsFvR7mT/V6x5pYL4njP7R00CrEslRTWxi
         co9vGUH9K4lsx3HEjiXdSeggwZxjqP1XxwEFoZ4cMWQS9j/AUdBHYJWtyo++XPMXlr4+
         0v0Q==
X-Gm-Message-State: APjAAAWW0KIF+uZeXUFJvt5Oa+luhQQ3LxQHxou0Xky77QJYyv4VbSEV
        UNiKodwjMdFoaczBie1P6JW9U7DpIJta5QaJNsEFBA==
X-Google-Smtp-Source: APXvYqxoD79iE0+5ChKU3X3fJj6+rZ3qpRP1y0q73JngnK3U5S41iydiPnO/0ZPtbZFwQxLBbU8gVqdvKV4bIASaF9bWiw==
X-Received: by 2002:a1f:174d:: with SMTP id 74mr653278vkx.39.1558129166697;
 Fri, 17 May 2019 14:39:26 -0700 (PDT)
Date:   Fri, 17 May 2019 14:39:16 -0700
In-Reply-To: <20190517213918.26045-1-matthewgarrett@google.com>
Message-Id: <20190517213918.26045-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517213918.26045-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V6 2/4] tpm: Reserve the TPM final events table
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

UEFI systems provide a boot services protocol for obtaining the TPM
event log, but this is unusable after ExitBootServices() is called.
Unfortunately ExitBootServices() itself triggers additional TPM events
that then can't be obtained using this protocol. The platform provides a
mechanism for the OS to obtain these events by recording them to a
separate UEFI configuration table which the OS can then map.

Unfortunately this table isn't self describing in terms of providing its
length, so we need to parse the events inside it to figure out how long
it is. Since the table isn't mapped at this point, we need to extend the
length calculation function to be able to map the event as it goes
along.

(Fixes by Bartosz Szczepanek <bsz@semihalf.com>)

Signed-off-by: Matthew Garrett <mjg59@google.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/eventlog/tpm2.c |   2 +-
 drivers/firmware/efi/efi.c       |   2 +
 drivers/firmware/efi/tpm.c       |  62 ++++++++++++++++++-
 include/linux/efi.h              |   9 +++
 include/linux/tpm_eventlog.h     | 102 ++++++++++++++++++++++++++++---
 5 files changed, 164 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 1a977bdd3bd2..de1d9f7e5a92 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,7 +40,7 @@
 static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				   struct tcg_pcr_event *event_header)
 {
-	return __calc_tpm2_event_size(event, event_header);
+	return __calc_tpm2_event_size(event, event_header, false);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..6b11c41e0575 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -53,6 +53,7 @@ struct efi __read_mostly efi = {
 	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
 	.rng_seed		= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
+	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
 	.mem_reserve		= EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
@@ -485,6 +486,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table},
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
+	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
 	{NULL_GUID, NULL, NULL},
 };
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 3a689b40ccc0..2c912ea08166 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -4,34 +4,90 @@
  *     Thiebaud Weksteen <tweek@google.com>
  */
 
+#define TPM_MEMREMAP(start, size) early_memremap(start, size)
+#define TPM_MEMUNMAP(start, size) early_memunmap(start, size)
+
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
+#include <linux/tpm_eventlog.h>
 
 #include <asm/early_ioremap.h>
 
+int efi_tpm_final_log_size;
+EXPORT_SYMBOL(efi_tpm_final_log_size);
+
+static int tpm2_calc_event_log_size(void *data, int count, void *size_info)
+{
+	struct tcg_pcr_event2_head *header;
+	int event_size, size = 0;
+
+	while (count > 0) {
+		header = data + size;
+		event_size = __calc_tpm2_event_size(header, size_info, true);
+		if (event_size == 0)
+			return -1;
+		size += event_size;
+		count--;
+	}
+
+	return size;
+}
+
 /*
  * Reserve the memory associated with the TPM Event Log configuration table.
  */
 int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
+	struct efi_tcg2_final_events_table *final_tbl;
 	unsigned int tbl_size;
+	int ret = 0;
 
-	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR)
+	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
+		/*
+		 * We can't calculate the size of the final events without the
+		 * first entry in the TPM log, so bail here.
+		 */
 		return 0;
+	}
 
 	log_tbl = early_memremap(efi.tpm_log, sizeof(*log_tbl));
 	if (!log_tbl) {
 		pr_err("Failed to map TPM Event Log table @ 0x%lx\n",
-			efi.tpm_log);
+		       efi.tpm_log);
 		efi.tpm_log = EFI_INVALID_TABLE_ADDR;
 		return -ENOMEM;
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
+
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
+		goto out;
+
+	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
+
+	if (!final_tbl) {
+		pr_err("Failed to map TPM Final Event Log table @ 0x%lx\n",
+		       efi.tpm_final_log);
+		efi.tpm_final_log = EFI_INVALID_TABLE_ADDR;
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
+					    + sizeof(final_tbl->version)
+					    + sizeof(final_tbl->nr_events),
+					    final_tbl->nr_events,
+					    log_tbl->log);
+	memblock_reserve((unsigned long)final_tbl,
+			 tbl_size + sizeof(*final_tbl));
+	early_memunmap(final_tbl, sizeof(*final_tbl));
+	efi_tpm_final_log_size = tbl_size;
+
+out:
 	early_memunmap(log_tbl, sizeof(*log_tbl));
-	return 0;
+	return ret;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 54357a258b35..e33c70a52a9d 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -689,6 +689,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
+#define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 
 typedef struct {
@@ -996,6 +997,7 @@ extern struct efi {
 	unsigned long mem_attr_table;	/* memory attributes table */
 	unsigned long rng_seed;		/* UEFI firmware random seed */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
+	unsigned long tpm_final_log;	/* TPM2 Final Events Log table */
 	unsigned long mem_reserve;	/* Linux EFI memreserve table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
@@ -1707,6 +1709,13 @@ struct linux_efi_tpm_eventlog {
 
 extern int efi_tpm_eventlog_init(void);
 
+struct efi_tcg2_final_events_table {
+	u64 version;
+	u64 nr_events;
+	u8 events[];
+};
+extern int efi_tpm_final_log_size;
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 6a86144e13f1..63238c84dc0b 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -112,10 +112,35 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
 } __packed;
 
+struct tcg_algorithm_size {
+	u16 algorithm_id;
+	u16 algorithm_size;
+};
+
+struct tcg_algorithm_info {
+	u8 signature[16];
+	u32 platform_class;
+	u8 spec_version_minor;
+	u8 spec_version_major;
+	u8 spec_errata;
+	u8 uintn_size;
+	u32 number_of_algorithms;
+	struct tcg_algorithm_size digest_sizes[];
+};
+
+#ifndef TPM_MEMREMAP
+#define TPM_MEMREMAP(start, size) NULL
+#endif
+
+#ifndef TPM_MEMUNMAP
+#define TPM_MEMUNMAP(start, size) do{} while(0)
+#endif
+
 /**
  * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
  * @event:        Pointer to the event whose size should be calculated
  * @event_header: Pointer to the initial event containing the digest lengths
+ * @do_mapping:   Whether or not the event needs to be mapped
  *
  * The TPM2 event log format can contain multiple digests corresponding to
  * separate PCR banks, and also contains a variable length of the data that
@@ -131,10 +156,13 @@ struct tcg_pcr_event2_head {
  */
 
 static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
-					 struct tcg_pcr_event *event_header)
+					 struct tcg_pcr_event *event_header,
+					 bool do_mapping)
 {
 	struct tcg_efi_specid_event_head *efispecid;
 	struct tcg_event_field *event_field;
+	void *mapping = NULL;
+	int mapping_size;
 	void *marker;
 	void *marker_start;
 	u32 halg_size;
@@ -148,16 +176,49 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
 		+ sizeof(event->count);
 
+	/* Map the event header */
+	if (do_mapping) {
+		mapping_size = marker - marker_start;
+		mapping = TPM_MEMREMAP((unsigned long)marker_start,
+				       mapping_size);
+		if (!mapping) {
+			size = 0;
+			goto out;
+		}
+	} else {
+		mapping = marker_start;
+	}
+
+	event = (struct tcg_pcr_event2_head *)mapping;
+
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs)
-		return 0;
+	if (event->count > efispecid->num_algs) {
+		size = 0;
+		goto out;
+	}
 
 	for (i = 0; i < event->count; i++) {
 		halg_size = sizeof(event->digests[i].alg_id);
-		memcpy(&halg, marker, halg_size);
+
+		/* Map the digest's algorithm identifier */
+		if (do_mapping) {
+			TPM_MEMUNMAP(mapping, mapping_size);
+			mapping_size = halg_size;
+			mapping = TPM_MEMREMAP((unsigned long)marker,
+					     mapping_size);
+			if (!mapping) {
+				size = 0;
+				goto out;
+			}
+		} else {
+			mapping = marker;
+		}
+
+		memcpy(&halg, mapping, halg_size);
 		marker = marker + halg_size;
+
 		for (j = 0; j < efispecid->num_algs; j++) {
 			if (halg == efispecid->digest_sizes[j].alg_id) {
 				marker +=
@@ -166,18 +227,41 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 			}
 		}
 		/* Algorithm without known length. Such event is unparseable. */
-		if (j == efispecid->num_algs)
-			return 0;
+		if (j == efispecid->num_algs) {
+			size = 0;
+			goto out;
+		}
+	}
+
+	/*
+	 * Map the event size - we don't read from the event itself, so
+	 * we don't need to map it
+	 */
+	if (do_mapping) {
+		TPM_MEMUNMAP(mapping, mapping_size);
+		mapping_size += sizeof(event_field->event_size);
+		mapping = TPM_MEMREMAP((unsigned long)marker,
+				       mapping_size);
+		if (!mapping) {
+			size = 0;
+			goto out;
+		}
+	} else {
+		mapping = marker;
 	}
 
-	event_field = (struct tcg_event_field *)marker;
+	event_field = (struct tcg_event_field *)mapping;
+
 	marker = marker + sizeof(event_field->event_size)
 		+ event_field->event_size;
 	size = marker - marker_start;
 
 	if ((event->event_type == 0) && (event_field->event_size == 0))
-		return 0;
-
+		size = 0;
+out:
+	if (do_mapping)
+		TPM_MEMUNMAP(mapping, mapping_size);
 	return size;
 }
+
 #endif
-- 
2.21.0.1020.gf2820cf01a-goog

