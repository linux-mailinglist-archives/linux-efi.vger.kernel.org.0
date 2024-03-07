Return-Path: <linux-efi+bounces-770-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B4875423
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6501F226C7
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7701EB40;
	Thu,  7 Mar 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PI7MPIFX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5D12FB07
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828561; cv=none; b=e/Hmu0agXKicn/rzpeak51uzy60VxqF1JME2oasF3K74C5ss4wxeGIxkVNY2iTN6Dl1Fb+lje8NmoJVyrWY8doTIqnP4vuk476DAXZXiuHNHhD25lulvyU6qy9crZY5ieFzIERyZBD1Fp5uxOu6ayKEx7+DnVb4zIizEkpqYggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828561; c=relaxed/simple;
	bh=iOKGmoiAtyaNEfPspMbGXngumI1iLOe4JU6F3yUH0X4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LEFE1AbmUIN8Ekdc8eRMrBdVjZ/V5s2SgWas4vcENBRelx8KSOqMfFbcEAz62CqqUwD6WPYPL0VeagQcdD2NH1u/90Na2oU43r5SB9+uRcUXe53K8mwAe+aP4avA7n0qp5fWbMc5Czg/OGNdA6u1WZm1yXMNnVLx2ciHCgs3lKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PI7MPIFX; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33d60ac6781so453691f8f.0
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709828557; x=1710433357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eey6UyU1uwGR1Imal6YxDk1CY4N/8kV8iyzGripb3QY=;
        b=PI7MPIFXXAh/bz4VqioPZLc5H3x5Ht7yGvZlxgaU6+FjPgvI8ijTWif8pK3waaU2DS
         lJCsQXYXq+h069gPf9WExiM+KUnT+HR9nHQWfFeucerOvR+DhpjM75aSKRYwsTlIuVKu
         ukuiEXsvVx7uJ9WajGSZF6Aj3HNzVMzbzeK9g0947GJyIRmWEJyU2myiYOPG7ahGDSRk
         cbb6QK5rNWdj9KU472fwraJupXpbLn0iLWajoy5nZb5IYEyTImipD4MLTwQ73K1MTWXc
         2Yb89+kQ4B8Mo00Dlm1dA6Rv73fc/rsfE6ry0RsNnne/boAuyftAlbb4Ri3dWq+MDtsA
         MV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828557; x=1710433357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eey6UyU1uwGR1Imal6YxDk1CY4N/8kV8iyzGripb3QY=;
        b=aWtNGEmBkQyW2tsZ2o4gVqsXV0sK5U3st+7Uo386QLq0LRBpJFVnHwhl5URDrwQb04
         8IavVesxxvv/kBM+y29Zs+COHvntU538NiWNj8IRV+v7QyQcHkHOSYoej+CW9lV9Oami
         exBdFtTPhcStQbjcLCTs3JgdzvkP1DrecvuXSnzF/XKm/3tZcBIxtYIGkL0/RWL/WFiJ
         vRk0mRl20bcq/yNA/jbvnIvVN1wASuFdo7tD8gWIcmk4ItoUqg7vm3zAPpYaQoT9znMx
         xmDKHq8zMtlnaKUnNYvJbUpNGzmvyruKav2nJnciqJL0hyGXOVOB3kK6ymDEnLmYlFKT
         GdBg==
X-Gm-Message-State: AOJu0YybV6H6m2Gp2ah7iVNY7iApSUOIoHuRlmM8aFejoI8q5ZIeyQbK
	vLiSXNPC8eMiYgvlKhFXQuka6Z2jw6txazJ8IqKeOHPPZYzdjwxPZHfOHJToqIQhNBJ3ulcnRrF
	xvu0vexE9WZQzbLW9+Fj4P10X4ikUs9/eMb/mUR3oVrMo2DPYX0LCjJ2zCUxpqTvtC3nhYCkVz4
	W4eJT0dv/kCFKwriHMhzVbc4mPng==
X-Google-Smtp-Source: AGHT+IGRPtIfr2iqOrNdUj7DjFQwFRWxX9RydrlLCGUt/kdGkLkB71s9kU8j/RMRgNywZw0GsQ7WxsNq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4fcd:0:b0:33e:40fc:3f8e with SMTP id
 h13-20020a5d4fcd000000b0033e40fc3f8emr31745wrw.9.1709828557363; Thu, 07 Mar
 2024 08:22:37 -0800 (PST)
Date: Thu,  7 Mar 2024 17:22:20 +0100
In-Reply-To: <20240307162214.272314-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8766; i=ardb@kernel.org;
 h=from:subject; bh=Ub3tRaDvB+l63Oo+C+ZOR6R+ShHznPHMO9YFSMaaOTs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXly70MR4t+aW86xLxFyGCB07+qWI0VD/6oLb0i/kldR
 vv0tr7kjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJrAhXJwCMBEfPUaG15UFrgc+dl2t28Cu
 svga83oWufp5x/13cM+79TZNfW7Ie0aGe22WNjdv7nLKfPvzU030+VcP5r9tPFVclZESnlwm80+ ZDwA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307162214.272314-12-ardb+git@google.com>
Subject: [PATCH v2 5/5] efi/libstub: Add get_event_log() support for CC platforms
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
Link: https://lkml.kernel.org/r/0229a87e-fb19-4dad-99fc-4afd7ed4099a%40collabora.com
[ardb: Split out final events table handling to avoid version confusion]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c              |  1 +
 drivers/firmware/efi/libstub/efi-stub.c |  2 +-
 drivers/firmware/efi/libstub/efistub.h  |  4 +-
 drivers/firmware/efi/libstub/tpm.c      | 82 +++++++++++++-------
 drivers/firmware/efi/libstub/x86-stub.c |  2 +-
 include/linux/efi.h                     |  2 +
 6 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index f6cfd29308d9..8859fb0b006d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -598,6 +598,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID,	&efi_rng_seed,		"RNG"		},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID,		&efi.tpm_log,		"TPMEventLog"	},
 	{EFI_TCG2_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"TPMFinalLog"	},
+	{EFI_CC_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"CCFinalLog"	},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
 	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
 	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
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
index 72181c04420c..8abd2a1195d6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -922,6 +922,8 @@ typedef struct {
 
 #define EFI_CC_BOOT_HASH_ALG_SHA384	0x00000004
 
+#define EFI_CC_EVENT_LOG_FORMAT_TCG_2	0x00000002
+
 typedef union efi_cc_protocol efi_cc_protocol_t;
 
 union efi_cc_protocol {
@@ -1133,7 +1135,7 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
 
-void efi_retrieve_tpm2_eventlog(void);
+void efi_retrieve_eventlog(void);
 
 struct screen_info *alloc_screen_info(void);
 struct screen_info *__alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index a880f7374c27..df3182f2e63a 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -47,39 +47,18 @@ void efi_enable_reset_attack_mitigation(void)
 
 #endif
 
-void efi_retrieve_tpm2_eventlog(void)
+static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
+				       efi_physical_addr_t log_last_entry,
+				       efi_bool_t truncated,
+				       struct efi_tcg2_final_events_table *final_events_table)
 {
-	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
 	efi_status_t status;
-	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
-	struct efi_tcg2_final_events_table *final_events_table = NULL;
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
@@ -93,8 +72,10 @@ void efi_retrieve_tpm2_eventlog(void)
 		 * get_event_log only returns the address of the last entry.
 		 * We need to calculate its size to deduce the full size of
 		 * the logs.
+		 *
+		 * CC Event log also uses TCG2 format, handle it same as TPM2.
 		 */
-		if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		if (version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2) {
 			/*
 			 * The TCG2 log format has variable length entries,
 			 * and the information to decode the hash algorithms
@@ -127,8 +108,6 @@ void efi_retrieve_tpm2_eventlog(void)
 	 * Figure out whether any events have already been logged to the
 	 * final events structure, and if so how much space they take up
 	 */
-	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
-		final_events_table = get_efi_config_table(EFI_TCG2_FINAL_EVENTS_TABLE_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
@@ -165,3 +144,50 @@ void efi_retrieve_tpm2_eventlog(void)
 err_free:
 	efi_bs_call(free_pool, log_tbl);
 }
+
+void efi_retrieve_eventlog(void)
+{
+	struct efi_tcg2_final_events_table *final_events_table = NULL;
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
+		} else {
+			final_events_table =
+				get_efi_config_table(EFI_TCG2_FINAL_EVENTS_TABLE_GUID);
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
+
+		final_events_table =
+			get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
+	}
+
+	if (status != EFI_SUCCESS || !log_location)
+		return;
+
+	efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
+				   truncated, final_events_table);
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
index 2493d3d4429b..a66d905caa7a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -402,6 +402,8 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
 #define EFI_CC_MEASUREMENT_PROTOCOL_GUID	EFI_GUID(0x96751a3d, 0x72f4, 0x41a6, 0xa7, 0x94, 0xed, 0x5d, 0x0e, 0x67, 0xae, 0x6b)
+#define EFI_CC_FINAL_EVENTS_TABLE_GUID		EFI_GUID(0xdd4a4648, 0x2de7, 0x4665, 0x96, 0x4d, 0x21, 0xd9, 0xef, 0x5f, 0xb4, 0x46)
+
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.44.0.278.ge034bb2e1d-goog


