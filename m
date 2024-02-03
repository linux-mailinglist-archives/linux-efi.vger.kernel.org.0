Return-Path: <linux-efi+bounces-462-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12132848470
	for <lists+linux-efi@lfdr.de>; Sat,  3 Feb 2024 08:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9124B1F279F5
	for <lists+linux-efi@lfdr.de>; Sat,  3 Feb 2024 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3086E4EB3F;
	Sat,  3 Feb 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0AZEgBM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC164F21D;
	Sat,  3 Feb 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706947132; cv=none; b=UCuPRXJfjtRZwxuNBqTZUnJquis5rVOS83pV5GvS2Y6SSURnSZgzxZSW0EY4HbP/AukgCAn47KIebIEVMRohjWChnKOq4LPZvgqOtYx3aSoYqoPf6N44nZuB1+iWnFFUwcr+61dZACh/OQEfxKGUKc+ZjCHFuhdp+jn1v4Rz+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706947132; c=relaxed/simple;
	bh=LqtwNB5TrQQP0r6P8ZwmxdbV/UAo42ouI+fBXwihtEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dWzYt5anPs+3OztJKJo841fJdZNh0R2WjjiSgJVos7jq8DljEyaNmvtVGE5xTWe20HGLhOxNd/Z9+VLPX2mAmEh3mCpx4Bu/oKZfgtt4ZtPwwxCbd4TIQ4DIZHnYzjmCPldUpS6bhINAbt+QXXmEFPs1+kX1myiypVjAbgKL+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0AZEgBM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706947128; x=1738483128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LqtwNB5TrQQP0r6P8ZwmxdbV/UAo42ouI+fBXwihtEo=;
  b=i0AZEgBMNf5x75mQvRg4al/wC6o+Tyk/mua0yTrm5waA22LSMqu1ahFf
   gl2VJqYEXT71s9l7HE23PeaidIJIO7ZP/Hq2f4hQahErLMRUJbrtGE8CX
   CTwFLWtuRrbvaLodkD1EAtxFHGQsER+Jz4AMWxpfw1rW2xPtKDgGJ9P16
   hOGXvFRFbBlh4AiVU4Pp/p0ifJ8nOvDU8+QlJnKVzJnh63XD6G9iZ0i/l
   q44X0pUX5nM6JhXwhyNDKSzavf3vNnt1jycoOiNFe1ArstckLiChR4Yuj
   aXQq91mBoeNvCtzZ1zLzjh+5nJ3F84NFli1HKsvArU5zBR5PnG6w4p9Qi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11043069"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="11043069"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 23:58:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="5029124"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 23:58:43 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v1] efi/libstub: Add Confidential Computing (CC) measurement support
Date: Sat,  3 Feb 2024 07:57:36 +0000
Message-Id: <20240203075736.3982371-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the virtual firmware implements TPM support, TCG2 protocol will be
used for kernel measurements and event logging support. But in CC
environment, not all platforms support or enable the TPM feature. UEFI
specification [1] exposes protocol and interfaces used for kernel
measurements in CC platforms without TPM support.

Currently, the efi-stub only supports the kernel related measurements
for the platform that supports TCG2 protocol. So, extend it add
CC measurement protocol (EFI_CC_MEASUREMENT_PROTOCOL) and event logging
support. Event logging format in the CC environment is the same as
TCG2.

More details about the EFI CC measurements and logging can be found
in [1].

Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 113 +++++++++++++-----
 drivers/firmware/efi/libstub/efistub.h        |  73 +++++++++++
 include/linux/efi.h                           |   1 +
 3 files changed, 159 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..e323b768048f 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -219,50 +219,107 @@ static const struct {
 	},
 };
 
+static efi_status_t tcg2_efi_measure(efi_tcg2_protocol_t *tcg2,
+				     unsigned long load_addr,
+				     unsigned long load_size,
+				     enum efistub_event event)
+{
+	struct efi_measured_event {
+		efi_tcg2_event_t	event_data;
+		efi_tcg2_tagged_event_t tagged_event;
+		u8			tagged_event_data[];
+	} *evt;
+	int size = sizeof(*evt) + events[event].event_data_len;
+	efi_status_t status;
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+			     (void **)&evt);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	evt->event_data = (struct efi_tcg2_event){
+		.event_size			= size,
+		.event_header.header_size	= sizeof(evt->event_data.event_header),
+		.event_header.header_version	= EFI_TCG2_EVENT_HEADER_VERSION,
+		.event_header.pcr_index		= events[event].pcr_index,
+		.event_header.event_type	= EV_EVENT_TAG,
+	};
+
+	evt->tagged_event = (struct efi_tcg2_tagged_event){
+		.tagged_event_id		= events[event].event_id,
+		.tagged_event_data_size		= events[event].event_data_len,
+	};
+
+	memcpy(evt->tagged_event_data, events[event].event_data,
+	       events[event].event_data_len);
+
+	status = efi_call_proto(tcg2, hash_log_extend_event, 0,
+				load_addr, load_size, &evt->event_data);
+	efi_bs_call(free_pool, evt);
+
+	return status;
+}
+
+static efi_status_t cc_efi_measure(efi_cc_protocol_t *cc,
+				   unsigned long load_addr,
+				   unsigned long load_size,
+				   enum efistub_event event)
+{
+	efi_cc_mr_index_t mr;
+	efi_cc_event_t *evt;
+	efi_status_t status;
+	size_t size;
+
+	status = efi_call_proto(cc, map_pcr_to_mr_index, events[event].pcr_index, &mr);
+	if (status != EFI_SUCCESS) {
+		efi_err("CC_MEASURE: PCR to MR mapping failed\n");
+		return status;
+	}
+
+	size = sizeof(*evt) + events[event].event_data_len;
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
+	if (status != EFI_SUCCESS) {
+		efi_err("CC_MEASURE: Allocating event struct failed\n");
+		return status;
+	}
+
+	evt->event_size = size;
+	evt->event_header.header_size = sizeof(evt->event_header);
+	evt->event_header.header_version = EFI_CC_EVENT_HEADER_VERSION;
+	evt->event_header.mr_index = mr;
+	evt->event_header.event_type = EV_EVENT_TAG;
+	memcpy(evt->event_data, events[event].event_data, events[event].event_data_len);
+
+	status = efi_call_proto(cc, hash_log_extend_event, 0, load_addr, load_size, evt);
+	efi_bs_call(free_pool, evt);
+
+	return status;
+}
 static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 					     unsigned long load_size,
 					     enum efistub_event event)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
+	efi_cc_protocol_t *cc = NULL;
 	efi_tcg2_protocol_t *tcg2 = NULL;
 	efi_status_t status;
 
 	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
 	if (tcg2) {
-		struct efi_measured_event {
-			efi_tcg2_event_t	event_data;
-			efi_tcg2_tagged_event_t tagged_event;
-			u8			tagged_event_data[];
-		} *evt;
-		int size = sizeof(*evt) + events[event].event_data_len;
-
-		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-				     (void **)&evt);
+		status = tcg2_efi_measure(tcg2, load_addr, load_size, event);
 		if (status != EFI_SUCCESS)
 			goto fail;
 
-		evt->event_data = (struct efi_tcg2_event){
-			.event_size			= size,
-			.event_header.header_size	= sizeof(evt->event_data.event_header),
-			.event_header.header_version	= EFI_TCG2_EVENT_HEADER_VERSION,
-			.event_header.pcr_index		= events[event].pcr_index,
-			.event_header.event_type	= EV_EVENT_TAG,
-		};
-
-		evt->tagged_event = (struct efi_tcg2_tagged_event){
-			.tagged_event_id		= events[event].event_id,
-			.tagged_event_data_size		= events[event].event_data_len,
-		};
-
-		memcpy(evt->tagged_event_data, events[event].event_data,
-		       events[event].event_data_len);
-
-		status = efi_call_proto(tcg2, hash_log_extend_event, 0,
-					load_addr, load_size, &evt->event_data);
-		efi_bs_call(free_pool, evt);
+		return EFI_SUCCESS;
+	}
 
+	efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
+	if (cc) {
+		status = cc_efi_measure(cc, load_addr, load_size, event);
 		if (status != EFI_SUCCESS)
 			goto fail;
+
 		return EFI_SUCCESS;
 	}
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..dbdeb2ad7a93 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -882,6 +882,79 @@ union efi_tcg2_protocol {
 	} mixed_mode;
 };
 
+typedef struct {
+	u8 major;
+	u8 minor;
+} efi_cc_version_t;
+
+typedef struct {
+	u8 type;
+	u8 sub_type;
+} efi_cc_type_t;
+
+/* EFI CC type/subtype defines */
+#define EFI_CC_TYPE_NONE		0
+#define EFI_CC_TYPE_AMD_SEV		1
+#define EFI_CC_TYPE_INTEL_TDX		2
+
+typedef u32 efi_cc_mr_index_t;
+
+typedef struct {
+	u32 event_size;
+	struct {
+		u32 header_size;
+		u16 header_version;
+		u32 mr_index;
+		u32 event_type;
+	} __packed event_header;
+	u8 event_data[0];
+} __packed efi_cc_event_t;
+
+typedef u32 efi_cc_event_log_bitmap_t;
+typedef u32 efi_cc_event_log_format_t;
+typedef u32 efi_cc_event_algorithm_bitmap_t;
+
+typedef struct {
+	u8 size;
+	efi_cc_version_t structure_version;
+	efi_cc_version_t protocol_version;
+	efi_cc_event_algorithm_bitmap_t hash_algorithm_bitmap;
+	efi_cc_event_log_bitmap_t supported_event_logs;
+	efi_cc_type_t cc_type;
+} efi_cc_boot_service_cap_t;
+
+#define EFI_CC_EVENT_HEADER_VERSION  1
+
+#define EFI_CC_BOOT_HASH_ALG_SHA384     0x00000004
+
+typedef union efi_cc_protocol efi_cc_protocol_t;
+
+union efi_cc_protocol {
+	struct {
+		efi_status_t (__efiapi *get_capability)(efi_cc_protocol_t *,
+							efi_cc_boot_service_cap_t *);
+		efi_status_t (__efiapi *get_event_log)(efi_cc_protocol_t *,
+						       efi_cc_event_log_format_t,
+						       efi_physical_addr_t *,
+						       efi_physical_addr_t *,
+						       efi_bool_t *);
+		efi_status_t (__efiapi *hash_log_extend_event)(efi_cc_protocol_t *,
+							       u64,
+							       efi_physical_addr_t,
+							       u64,
+							       const efi_cc_event_t *);
+		efi_status_t (__efiapi *map_pcr_to_mr_index)(efi_cc_protocol_t *,
+							     u32,
+							     efi_cc_mr_index_t *);
+	};
+	struct {
+		u32 get_capability;
+		u32 get_event_log;
+		u32 hash_log_extend_event;
+		u32 map_pcr_to_mr_index;
+	} mixed_mode;
+};
+
 struct riscv_efi_boot_protocol {
 	u64 revision;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c74f47711f0b..2f57fec2e629 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -400,6 +400,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
+#define EFI_CC_MEASUREMENT_PROTOCOL_GUID	EFI_GUID(0x96751a3d, 0x72f4, 0x41a6, 0xa7, 0x94, 0xed, 0x5d, 0x0e, 0x67, 0xae, 0x6b)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.25.1


