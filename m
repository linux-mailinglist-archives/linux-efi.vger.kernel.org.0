Return-Path: <linux-efi+bounces-4186-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92046AFC4CC
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F23A3A4E03
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E9298CCD;
	Tue,  8 Jul 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jZr7KQoJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE09221F02;
	Tue,  8 Jul 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961391; cv=none; b=qGUMfxMsJMy8+U5CLAcCDZafPbtHLLS5pM0vhdvC2XOz2xCDOn9y8DMq349wxEDNMsoS2a/PTfaPsTFdKsgjeDElRCk7ATiOtOt/GDYWApI6WUG+b748lBwjf0LkbUC4Xckutom3rnXHbrZaboMqIwUxbF979AyPkwxzrmRV4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961391; c=relaxed/simple;
	bh=dZyzQBIMqiq0pYKOY8WlmZpFoaKKpKrqKimjRYGLVPE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KoBpi/ib67hmGOkO9TOyV75HRtvJMAibXZa/OE+Bfhhbbkwi/lsLtigFhLnuCYraNHxdJXVKKUdIOZ0pGzHUmQQYsNM/ObgYt7je0QNZJARocuAjxL9JTJ4jngmSgqzDDVN6IlICWIDqMuEvvI2rtu68jPALHz3SZf19lEM+65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jZr7KQoJ; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=Plhb3+GAJDN9/RH
	FHPMi9csGKHBSLiSibnIhdh5+24c=; b=jZr7KQoJR8kw30nF06M6UaLnuMlzyLA
	WJ50MMvgn+xkARA45gAC/l2TNrHCbAVQqrap2nkNnQ5HvmnRWRtWrt1pLPsjJEHb
	EijiXnjx7qvOrV2PJjbIkI1UThXM+UQ8xEbBMpOJuvhwyVs8LopUqaN0X/TUJLPB
	TMVVjsHvaGz8=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnjx3MzmxopPIpAA--.45984S2;
	Tue, 08 Jul 2025 15:54:52 +0800 (CST)
From: yangge1116@126.com
To: ardb@kernel.org
Cc: jarkko@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org,
	jgg@ziepe.ca,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: [PATCH V4] efi/tpm: Fix the issue where the CC platforms event log header can't be correctly identified
Date: Tue,  8 Jul 2025 15:54:49 +0800
Message-Id: <1751961289-29673-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnjx3MzmxopPIpAA--.45984S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfGr4fCrWDKryDWw43XrykGrg_yoW8JF1kKo
	W3Cr45X3yUXwn3urWY9ryDGF1DZryvkr1SyrWYyws8Xa4qvrW3ArWxJws3XF4avr1jyF12
	q3s8t3W8AF43JFZ3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RX_-PUUUUU
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgOEG2hsyJSf0wAAsy
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

From: Ge Yang <yangge1116@126.com>

Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
for CC platforms") reuses TPM2 support code for the CC platforms, when
launching a TDX virtual machine with coco measurement enabled, the
following error log is generated:

[Firmware Bug]: Failed to parse event in TPM Final Events Log

Call Trace:
efi_config_parse_tables()
  efi_tpm_eventlog_init()
    tpm2_calc_event_log_size()
      __calc_tpm2_event_size()

The pcr_idx value in the Intel TDX log header is 1, causing the function
__calc_tpm2_event_size() to fail to recognize the log header, ultimately
leading to the "Failed to parse event in TPM Final Events Log" error.

According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM PCR
0 maps to MRTD, so the log header uses TPM PCR 1 instead. To successfully
parse the TDX event log header, the check for a pcr_idx value of 0
must be skipped.

According to Table 6 in Section 10.2.1 of the TCG PC Client
Specification, the index field does not require the PCR index to be
fixed at zero. Therefore, skipping the check for a pcr_idx value of
0 for CC platforms is safe.

Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf
Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
Signed-off-by: Ge Yang <yangge1116@126.com>
Cc: stable@vger.kernel.org
---

V4:
- remove cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) suggested by Ard

V3:
- fix build error

V2:
- limit the fix for CC only suggested by Jarkko and Sathyanarayanan 

 drivers/char/tpm/eventlog/tpm2.c   |  6 +++++-
 drivers/firmware/efi/efi.c         |  8 ++++++--
 drivers/firmware/efi/libstub/tpm.c | 13 +++++++++----
 drivers/firmware/efi/tpm.c         | 36 ++++++++++++++++++++----------------
 include/linux/efi.h                |  4 +++-
 include/linux/tpm_eventlog.h       | 14 +++++++++++---
 6 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 37a0580..e9484fd 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -36,7 +36,11 @@
 static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				   struct tcg_pcr_event *event_header)
 {
-	return __calc_tpm2_event_size(event, event_header, false);
+	/*
+	 * This function is only used by TPM2 and will not be used by CC.
+	 * Therefore, the argument is_cc_event is set to 0.
+	 */
+	return __calc_tpm2_event_size(event, event_header, false, 0);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e57bff7..954b8f7 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -45,6 +45,7 @@ struct efi __read_mostly efi = {
 	.esrt			= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
 	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
+	.cc_final_log		= EFI_INVALID_TABLE_ADDR,
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	.mokvar_table		= EFI_INVALID_TABLE_ADDR,
 #endif
@@ -613,7 +614,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID,	&efi_rng_seed,		"RNG"		},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID,		&efi.tpm_log,		"TPMEventLog"	},
 	{EFI_TCG2_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"TPMFinalLog"	},
-	{EFI_CC_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"CCFinalLog"	},
+	{EFI_CC_FINAL_EVENTS_TABLE_GUID,	&efi.cc_final_log,	"CCFinalLog"	},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
 	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
 	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
@@ -752,7 +753,10 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 	if (!IS_ENABLED(CONFIG_X86_32) && efi_enabled(EFI_MEMMAP))
 		efi_memattr_init();
 
-	efi_tpm_eventlog_init();
+	if (efi.tpm_final_log != EFI_INVALID_TABLE_ADDR)
+		efi_tcg2_eventlog_init(&efi.tpm_log, &efi.tpm_final_log, 0);
+	else if (efi.cc_final_log != EFI_INVALID_TABLE_ADDR)
+		efi_tcg2_eventlog_init(&efi.tpm_log, &efi.cc_final_log, 1);
 
 	if (mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = mem_reserve;
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index a5c6c4f..9728060 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -50,7 +50,8 @@ void efi_enable_reset_attack_mitigation(void)
 static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
 				       efi_physical_addr_t log_last_entry,
 				       efi_bool_t truncated,
-				       struct efi_tcg2_final_events_table *final_events_table)
+				       struct efi_tcg2_final_events_table *final_events_table,
+				       bool is_cc_event)
 {
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
 	efi_status_t status;
@@ -87,7 +88,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 			last_entry_size =
 				__calc_tpm2_event_size((void *)last_entry_addr,
 						    (void *)(long)log_location,
-						    false);
+						    false,
+						    is_cc_event);
 		} else {
 			last_entry_size = sizeof(struct tcpa_event) +
 			   ((struct tcpa_event *) last_entry_addr)->event_size;
@@ -123,7 +125,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 			header = data + offset + final_events_size;
 			event_size = __calc_tpm2_event_size(header,
 						   (void *)(long)log_location,
-						   false);
+						   false,
+						   is_cc_event);
 			/* If calc fails this is a malformed log */
 			if (!event_size)
 				break;
@@ -157,6 +160,7 @@ void efi_retrieve_eventlog(void)
 	efi_tcg2_protocol_t *tpm2 = NULL;
 	efi_bool_t truncated;
 	efi_status_t status;
+	bool is_cc_event = false;
 
 	status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
 	if (status == EFI_SUCCESS) {
@@ -186,11 +190,12 @@ void efi_retrieve_eventlog(void)
 
 		final_events_table =
 			get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
+		is_cc_event = true;
 	}
 
 	if (status != EFI_SUCCESS || !log_location)
 		return;
 
 	efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
-				   truncated, final_events_table);
+				   truncated, final_events_table, is_cc_event);
 }
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index cdd4310..d79291d 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -16,14 +16,16 @@
 int efi_tpm_final_log_size;
 EXPORT_SYMBOL(efi_tpm_final_log_size);
 
-static int __init tpm2_calc_event_log_size(void *data, int count, void *size_info)
+static int __init tpm2_calc_event_log_size(void *data, int count,
+					    void *size_info, bool is_cc_event)
 {
 	struct tcg_pcr_event2_head *header;
 	u32 event_size, size = 0;
 
 	while (count > 0) {
 		header = data + size;
-		event_size = __calc_tpm2_event_size(header, size_info, true);
+		event_size = __calc_tpm2_event_size(header, size_info, true,
+						    is_cc_event);
 		if (event_size == 0)
 			return -1;
 		size += event_size;
@@ -36,7 +38,8 @@ static int __init tpm2_calc_event_log_size(void *data, int count, void *size_inf
 /*
  * Reserve the memory associated with the TPM Event Log configuration table.
  */
-int __init efi_tpm_eventlog_init(void)
+int __init efi_tcg2_eventlog_init(unsigned long *log, unsigned long *final_log,
+				   bool is_cc_event)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct efi_tcg2_final_events_table *final_tbl;
@@ -44,7 +47,7 @@ int __init efi_tpm_eventlog_init(void)
 	int final_tbl_size;
 	int ret = 0;
 
-	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
+	if (*log == EFI_INVALID_TABLE_ADDR) {
 		/*
 		 * We can't calculate the size of the final events without the
 		 * first entry in the TPM log, so bail here.
@@ -52,23 +55,23 @@ int __init efi_tpm_eventlog_init(void)
 		return 0;
 	}
 
-	log_tbl = early_memremap(efi.tpm_log, sizeof(*log_tbl));
+	log_tbl = early_memremap(*log, sizeof(*log_tbl));
 	if (!log_tbl) {
 		pr_err("Failed to map TPM Event Log table @ 0x%lx\n",
-		       efi.tpm_log);
-		efi.tpm_log = EFI_INVALID_TABLE_ADDR;
+		       *log);
+		*log = EFI_INVALID_TABLE_ADDR;
 		return -ENOMEM;
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	if (memblock_reserve(efi.tpm_log, tbl_size)) {
+	if (memblock_reserve(*log, tbl_size)) {
 		pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
-		       efi.tpm_log, tbl_size);
+		       *log, tbl_size);
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
+	if (*final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
 		goto out;
 	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
@@ -76,25 +79,26 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
+	final_tbl = early_memremap(*final_log, sizeof(*final_tbl));
 
 	if (!final_tbl) {
 		pr_err("Failed to map TPM Final Event Log table @ 0x%lx\n",
-		       efi.tpm_final_log);
-		efi.tpm_final_log = EFI_INVALID_TABLE_ADDR;
+		       *final_log);
+		*final_log = EFI_INVALID_TABLE_ADDR;
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	final_tbl_size = 0;
 	if (final_tbl->nr_events != 0) {
-		void *events = (void *)efi.tpm_final_log
+		void *events = (void *)*final_log
 				+ sizeof(final_tbl->version)
 				+ sizeof(final_tbl->nr_events);
 
 		final_tbl_size = tpm2_calc_event_log_size(events,
 							  final_tbl->nr_events,
-							  log_tbl->log);
+							  log_tbl->log,
+							  is_cc_event);
 	}
 
 	if (final_tbl_size < 0) {
@@ -103,7 +107,7 @@ int __init efi_tpm_eventlog_init(void)
 		goto out_calc;
 	}
 
-	memblock_reserve(efi.tpm_final_log,
+	memblock_reserve(*final_log,
 			 final_tbl_size + sizeof(*final_tbl));
 	efi_tpm_final_log_size = final_tbl_size;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d63d1d..71efec0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -642,6 +642,7 @@ extern struct efi {
 	unsigned long			esrt;			/* ESRT table */
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
+	unsigned long			cc_final_log;		/* CC Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
 	unsigned long			coco_secret;		/* Confidential computing secret table */
 	unsigned long			unaccepted;		/* Unaccepted memory table */
@@ -1209,7 +1210,8 @@ struct linux_efi_tpm_eventlog {
 	u8	log[];
 };
 
-extern int efi_tpm_eventlog_init(void);
+extern int efi_tcg2_eventlog_init(unsigned long *log, unsigned long *final_log,
+				   bool is_cc_event);
 
 struct efi_tcg2_final_events_table {
 	u64 version;
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 891368e..b3380c9 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -143,6 +143,7 @@ struct tcg_algorithm_info {
  * @event:        Pointer to the event whose size should be calculated
  * @event_header: Pointer to the initial event containing the digest lengths
  * @do_mapping:   Whether or not the event needs to be mapped
+ * @is_cc_event:  Whether or not the event is from a CC platform
  *
  * The TPM2 event log format can contain multiple digests corresponding to
  * separate PCR banks, and also contains a variable length of the data that
@@ -159,7 +160,8 @@ struct tcg_algorithm_info {
 
 static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 					 struct tcg_pcr_event *event_header,
-					 bool do_mapping)
+					 bool do_mapping,
+					 bool is_cc_event)
 {
 	struct tcg_efi_specid_event_head *efispecid;
 	struct tcg_event_field *event_field;
@@ -201,8 +203,14 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
 	count = event->count;
 	event_type = event->event_type;
 
-	/* Verify that it's the log header */
-	if (event_header->pcr_idx != 0 ||
+	/*
+	 * Verify that it's the log header. According to the TCG PC Client
+	 * Specification, when identifying a log header, the check for a
+	 * pcr_idx value of 0 is not required. For CC platforms, skipping
+	 * this check during log header is necessary; otherwise, the CC
+	 * platform's log header may fail to be recognized.
+	 */
+	if ((!is_cc_event && event_header->pcr_idx != 0) ||
 	    event_header->event_type != NO_ACTION ||
 	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
 		size = 0;
-- 
2.7.4


