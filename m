Return-Path: <linux-efi+bounces-549-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAB855915
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 04:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69589B2429A
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 03:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FB610E;
	Thu, 15 Feb 2024 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xn7fx0Iu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95F46AD;
	Thu, 15 Feb 2024 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966130; cv=none; b=MreiDOHp6kHZwEIczcCJw97nOA7wEDdNgehoTAq2Nb/6BfsodP0/l5Ar6531x3yNLRUf+DaxbmjgoQ6MGqkvt6qxtqsURAmu2lnNv6b+BUjXkNhChXdT3ADlNWslkthD4lgD9CReMPFKR+gTg1GTx02B2BMHymXJ6CL0SZXkmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966130; c=relaxed/simple;
	bh=xepH7kuDTbl1jM+GezkHpLWtjVo5w/fjmezvf9LH5Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cv8E+izGYyPK99zUHhBNhiKrrG2r1/AZgqmxYj83X9v89vaNXivgdBoxELj45Id8b1S0C3JDgU4t6D/DdDdMrTP9oOQ4P8mWOVAXFck3q4ioPLwbwbIo+VtgfiV0XUF6rowjAO7zIZVo9EhSg0OS8BHjFx5jSa+wc686yeCvVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xn7fx0Iu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966129; x=1739502129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xepH7kuDTbl1jM+GezkHpLWtjVo5w/fjmezvf9LH5Zg=;
  b=Xn7fx0Iu/YU6y2SWOX4cGhLKwrz9PS0X3WCpp4bYbjJa+rim8+OGF9Vh
   GibrH2G56qpSbWpbRyTNgj223/Vg5zs42oHWN8YVpNMOjVm4w16fSMwqG
   62BR8RGf2KVKVZwCuHHtUSU7MlmERpL+TgHMvc1jRFlfPLBRedYF8OHR1
   Lx6xxq+cWn6+M7vU8x6JEZK/IP/Ogn3CessEMiz1dXvFeqoWJ73/VZyRZ
   9REKnSMXSooNL4Qsf6XQiaLRSLwS0Y4xQ3sEHYTl3FZSSkyoEb/Jn1gz9
   eExltpmLZZNfwVdxKu1QBL1c0UAf25tcR0hru968ZFGXuMdLxrqOwpGwy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5007280"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5007280"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8010509"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:02:05 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 2/2] efi/libstub: Add get_event_log() support for CC platforms
Date: Thu, 15 Feb 2024 03:00:02 +0000
Message-Id: <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow event log info access after boot, EFI boot stub extracts
the event log information and installs it in an EFI configuration
table. Currently, EFI boot stub only supports installation of event
log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
support code as much as possible.

Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/firmware/efi/libstub/efi-stub.c |  2 +-
 drivers/firmware/efi/libstub/efistub.h  |  4 +-
 drivers/firmware/efi/libstub/tpm.c      | 78 +++++++++++++++++--------
 drivers/firmware/efi/libstub/x86-stub.c |  2 +-
 include/linux/efi.h                     |  3 +
 5 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f9c1e8a2bd1d..958a680e0660 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -167,7 +167,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	si = setup_graphics();
 
-	efi_retrieve_tpm2_eventlog();
+	efi_retrieve_eventlog();
 
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation();
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2c43d04e2b86..a47d226b632e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -928,6 +928,8 @@ typedef struct {
 
 #define EFI_CC_BOOT_HASH_ALG_SHA384     0x00000004
 
+#define EFI_CC_EVENT_LOG_FORMAT_TCG_2	0x00000002
+
 typedef union efi_cc_protocol efi_cc_protocol_t;
 
 union efi_cc_protocol {
@@ -1134,7 +1136,7 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
 
-void efi_retrieve_tpm2_eventlog(void);
+void efi_retrieve_eventlog(void);
 
 struct screen_info *alloc_screen_info(void);
 struct screen_info *__alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 7acbac16eae0..bcea7d520dad 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -47,39 +47,18 @@ void efi_enable_reset_attack_mitigation(void)
 
 #endif
 
-void efi_retrieve_tpm2_eventlog(void)
+static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
+				       efi_physical_addr_t log_last_entry,
+				       efi_bool_t truncated)
 {
-	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
 	efi_status_t status;
-	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
 	struct efi_tcg2_final_events_table *final_events_table = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
-	efi_bool_t truncated;
-	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
-	efi_tcg2_protocol_t *tcg2_protocol = NULL;
 	int final_events_size = 0;
 
-	status = efi_bs_call(locate_protocol, &tcg2_guid, NULL,
-			     (void **)&tcg2_protocol);
-	if (status != EFI_SUCCESS)
-		return;
-
-	status = efi_call_proto(tcg2_protocol, get_event_log, version,
-				&log_location, &log_last_entry, &truncated);
-
-	if (status != EFI_SUCCESS || !log_location) {
-		version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
-		status = efi_call_proto(tcg2_protocol, get_event_log, version,
-					&log_location, &log_last_entry,
-					&truncated);
-		if (status != EFI_SUCCESS || !log_location)
-			return;
-
-	}
-
 	first_entry_addr = (unsigned long) log_location;
 
 	/*
@@ -93,8 +72,11 @@ void efi_retrieve_tpm2_eventlog(void)
 		 * get_event_log only returns the address of the last entry.
 		 * We need to calculate its size to deduce the full size of
 		 * the logs.
+		 *
+		 * CC Event log also uses TCG2 format, handle it same as TPM2.
 		 */
-		if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 ||
+		    version == EFI_CC_EVENT_LOG_FORMAT_TCG_2) {
 			/*
 			 * The TCG2 log format has variable length entries,
 			 * and the information to decode the hash algorithms
@@ -129,6 +111,8 @@ void efi_retrieve_tpm2_eventlog(void)
 	 */
 	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
 		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
+	else if (version == EFI_CC_EVENT_LOG_FORMAT_TCG_2)
+		final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
@@ -165,3 +149,47 @@ void efi_retrieve_tpm2_eventlog(void)
 err_free:
 	efi_bs_call(free_pool, log_tbl);
 }
+
+void efi_retrieve_eventlog(void)
+{
+	efi_physical_addr_t log_location = 0, log_last_entry = 0;
+	efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
+	efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
+	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	efi_tcg2_protocol_t *tpm2 = NULL;
+	efi_cc_protocol_t *cc = NULL;
+	efi_bool_t truncated;
+	efi_status_t status;
+
+	status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
+	if (status == EFI_SUCCESS) {
+		status = efi_call_proto(tpm2, get_event_log, version, &log_location,
+					&log_last_entry, &truncated);
+
+		if (status != EFI_SUCCESS || !log_location) {
+			version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+			status = efi_call_proto(tpm2, get_event_log, version,
+						&log_location, &log_last_entry,
+						&truncated);
+			if (status != EFI_SUCCESS || !log_location)
+				return;
+		}
+
+		efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
+					   truncated);
+		return;
+	}
+
+	status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
+	if (status == EFI_SUCCESS) {
+		version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
+		status = efi_call_proto(cc, get_event_log, version, &log_location,
+					&log_last_entry, &truncated);
+		if (status != EFI_SUCCESS || !log_location)
+			return;
+
+		efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
+					   truncated);
+		return;
+	}
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..22641146970a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -918,7 +918,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	efi_random_get_seed();
 
-	efi_retrieve_tpm2_eventlog();
+	efi_retrieve_eventlog();
 
 	setup_graphics(boot_params);
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2f57fec2e629..a69c08b90e74 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -440,6 +440,9 @@ void efi_native_runtime_setup(void);
 /* OVMF protocol GUIDs */
 #define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID	EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
 
+/* CC GUIDs */
+#define LINUX_EFI_CC_FINAL_LOG_GUID		EFI_GUID(0xdd4a4648, 0x2de7, 0x4665, 0x96, 0x4d, 0x21, 0xd9, 0xef, 0x5f, 0xb4, 0x46)
+
 typedef struct {
 	efi_guid_t guid;
 	u64 table;
-- 
2.25.1


