Return-Path: <linux-efi+bounces-691-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3042786FF57
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F88B20BA9
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135237179;
	Mon,  4 Mar 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2RCP/JY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE97364CF
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549069; cv=none; b=V/F1PuiQdQiXo2a2AfOwkOU7JXTz5aJtX6cQlo6D11QesX/Kp2+L8mMe8N/yfQ7tWKc1cPt1yILgEdlfS9U1Lw1i/i6ov7OfUcOmZAXQKlOCxsV5VTFuZCN9sUuYEyeNyxkgWW58LWUOL25JmX9C9NAkZ6jWx04Md1TgwY21yKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549069; c=relaxed/simple;
	bh=yKk7DgcgzXFZiUmFOwLqLLIsHe1XDQot/WyBU4BCRg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jk8PBIqzJyhWv+GudND35LWzEu812du/3+ArGlFzD9T5Ha2z5MhoO16bNfXtwTKkdb0qenXUVw5d2l7D+NkFYmuNJL/aG5eEPz/757WAKs6+tvBqolOgjwzUzlUkk/CqcgUcDNDwbz0orxR7jaEnNrejvDjVlcopTP/3QbmAX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2RCP/JY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4128defb707so21485345e9.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 02:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709549066; x=1710153866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jO2xNPIVNjLVhvHwuXBWw/Z0nGFsjqfUoNUcFbTuDs=;
        b=g2RCP/JYQBcxA2MWOSZUN3vcrR14jgq9NXeQMKKuK7fDJhecF6iiqcj0IdeFd1Sk8B
         nX+lY7nV1Gs9qOzqrORoLIjz4T3jY5NmRYdTTX/AyCiIIC45QziCBcjm4ng97zwvv8Nc
         8Q8quRqUPOqIod0M7CqJwM/JEl+tVV3iaOOwtt+62UFTQdDUOz5Agwe0YfhgulX4cS3K
         Dm+uxmFst97QPlVo5yzK0Mn0yRwPfOOefeloylTTFQHC+b8bLsJtC7i598tRnEh+iJvF
         HXmVKpObV+skAm23dDZqMxtdh86Hk8u3pMjJUH9Ytu8v6yQXtSz+a43StTuO2UxLak/j
         gqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549066; x=1710153866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jO2xNPIVNjLVhvHwuXBWw/Z0nGFsjqfUoNUcFbTuDs=;
        b=SHZooN7ctA0OH562VqI03/yksWACAvi9e87ML6rftpynJmgEGo7NM2t+zrE9G0/WOO
         s7Hz8cSBzwGhEnOYu6bXNVjZUubYAE8GSwXD10YoJkvTDbeKKAwJok7DcH2qJeH7m1Gj
         jpGzcPALIuZa+6Lu7pPn96uuEyHsV/RJxuOS30GQAOmdxaMQYYZEz53wsgE3Nrli3dJh
         ca7EEYkPSxarIaOihV89iJOxS8VGXTMVeRZK8MCxJEHoJcEYDz8vmjugypeqD0d4t2HP
         ee/FYXS6BHXZu2QKAavipM1LAR5+SZmjLXw1WZzqiRXBEAvr7lOmH1FX/+tJHQtYAWw0
         9eFg==
X-Gm-Message-State: AOJu0YzCnhRHPAvV/B1+9y1CVygW/lKFiGBErLzljOqlny5XUDdaCuk2
	FQymFH35XleQlBdgnE3kj5mxbEe0RYwQISXohwvagGGNYP4vL2BBALLalhzO96+orBQqxrKkZ5G
	qfu9deIDmS3cX6Bgx3I/qak4FEEMPxGmz87Zu7VHotlGC2nDFVI85kyRqTtbeQl7xMMDLgACmMR
	WKuoH9uKIYdHvTVVHBApDVaq8MPw==
X-Google-Smtp-Source: AGHT+IEErJd24A/Y+Cv23GzYzUip41zWKdz6AJfeyJ5OivLH9WaLXb8sa+PD7mMpPczGu8bDWsD6QHMj
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5024:b0:412:e6de:1b87 with SMTP id
 n36-20020a05600c502400b00412e6de1b87mr21791wmr.4.1709549066271; Mon, 04 Mar
 2024 02:44:26 -0800 (PST)
Date: Mon,  4 Mar 2024 11:44:14 +0100
In-Reply-To: <20240304104409.2326422-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7368; i=ardb@kernel.org;
 h=from:subject; bh=5UEzyMfXx1/Eo1U2xzRcfiH7tP4avZMenbC8OCUzQgg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXp0n9zn7DoC6iG5/49Zv5cbNJF9fsvuPYlS7413nXx0
 M7ndWvPdZSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJfM5l+J/zXL3656fzj//r
 WS+rCTkfKZv+7cwp8dcvb80PZJzu8KySkWHmvzQf3S+Ki0vua6pcMni0vjl8+ieWmd75UdYVE+X /WTEDAA==
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304104409.2326422-10-ardb+git@google.com>
Subject: [PATCH 4/4] efi/libstub: Add get_event_log() support for CC platforms
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

To allow event log info access after boot, EFI boot stub extracts
the event log information and installs it in an EFI configuration
table. Currently, EFI boot stub only supports installation of event
log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
support code as much as possible.

Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
[ardb: reorganize logic slightly to share more code]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c |  2 +-
 drivers/firmware/efi/libstub/efistub.h  |  4 +-
 drivers/firmware/efi/libstub/tpm.c      | 74 +++++++++++++-------
 drivers/firmware/efi/libstub/x86-stub.c |  2 +-
 include/linux/efi.h                     |  3 +
 5 files changed, 57 insertions(+), 28 deletions(-)

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
index 4bf9a76796b7..e0a2766a70c0 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -922,6 +922,8 @@ typedef struct {
 
 #define EFI_CC_BOOT_HASH_ALG_SHA384	0x00000004
 
+#define EFI_CC_EVENT_LOG_FORMAT_TCG_2	0x00000002
+
 typedef union efi_cc_protocol efi_cc_protocol_t;
 
 union efi_cc_protocol {
@@ -1147,7 +1149,7 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
 
-void efi_retrieve_tpm2_eventlog(void);
+void efi_retrieve_eventlog(void);
 
 struct screen_info *alloc_screen_info(void);
 struct screen_info *__alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 7acbac16eae0..c35f99f259c1 100644
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
@@ -165,3 +149,43 @@ void efi_retrieve_tpm2_eventlog(void)
 err_free:
 	efi_bs_call(free_pool, log_tbl);
 }
+
+void efi_retrieve_eventlog(void)
+{
+	efi_physical_addr_t log_location = 0, log_last_entry = 0;
+	efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
+	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	efi_tcg2_protocol_t *tpm2 = NULL;
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
+		}
+	} else {
+		efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
+		efi_cc_protocol_t *cc = NULL;
+
+		status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
+		if (status != EFI_SUCCESS)
+			return;
+
+		version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
+		status = efi_call_proto(cc, get_event_log, version, &log_location,
+					&log_last_entry, &truncated);
+	}
+
+	if (status != EFI_SUCCESS || !log_location)
+		return;
+
+	efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
+				   truncated);
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 99429bc4b0c7..d09aa13c7ff0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -923,7 +923,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
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
2.44.0.278.ge034bb2e1d-goog


