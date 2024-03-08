Return-Path: <linux-efi+bounces-783-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB4876078
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4C22811E8
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE545103F;
	Fri,  8 Mar 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4HWELjgo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C80524C3
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888306; cv=none; b=JqAleHN0dSTKK6BE0h/gDGOvUrTzY6M3BATqJGiC039CEYXibUK5eXmwrljIHDgsQ0RlwnpG7qtIGWrxteUbPrlfHwpPLBum0HNQf50IuC86LE3vU25Jbfm3eNOJ7feI6or3ZhBOT+2yXnH8YFAMiqM6ST3nl1SOjUGppqUSxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888306; c=relaxed/simple;
	bh=dJtCpd6uVskQBjjCpwHRWCXd6smtR30/xK+CWT9cBl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rb/sokb9liBFhiLuau52maBDUuiy+PXGCqgkP5sYv3hOP6iBX93k+RuRS5vUWJj4BEfRnzW5sk4WniWt2R2JokmO+g5hRxA8aDaVyOOiDdygMdakXN9+WfBzBzjfGwpCFZgfWbtw2zSK5ftKi5D+CfCOdNwrCc5fXBIMDq++sbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4HWELjgo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso3109015276.1
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 00:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709888303; x=1710493103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4K1rxebdavLMf+olzI6vt7zaNJvQRPSsrXiT7sFk0+A=;
        b=4HWELjgosM/My/CO1AnG3TsPIzdAZjZucHhvtwhJHshsIgZlt5zfpzZVySZvkFwi7H
         sqZ4eh4Ika6YJbr7FekbvvN8oWtQasMh3+xf8wEreyaBSkpt24mGc2gJ2VB0v7dxnjMg
         QkZYxWfIO/RkTy9LWBviujQwlg+J1ok7cEBk/ZOuxAEuQScbmgOoF/CT0SCvF6bkRIy7
         vRlwHjxO+2GyLCVGygyD2+vA7aBtXwkCLy3nwXhaBUUmHbi5EeZvqt/Xju3t5y90aJkX
         yjYcoZv6RftpSEcYcOGkKD5lBfgq3ChHSPajKVUPxqJ5wwq7M8G/K2rIunBeGtQeqN4h
         GhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888303; x=1710493103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4K1rxebdavLMf+olzI6vt7zaNJvQRPSsrXiT7sFk0+A=;
        b=DspryhG/8Spvwds5DoOtTdNL732TmxCEhG+e78m30WNrT+AcUXf33iREdUtt9BDqw3
         5ApyhOjQryGWQm8UocNoJvpO37HJ85l5KXZroAKwjfPagwJykZac8JAPeqPr1FJWo6SN
         Z3gMmi79iL6rrqqz6lTHBMbrjD37W7ymy4VQtrf3nC96/fi0AxX8XYGtUteAtWHMsbbH
         80+ieObLgDOh0uaRrO/LeCD2E/UFT2aH8zArYPyVSmB1BvFLr/9b+/+AuT492ee9LewO
         4kRCdshzDHIzXr8LaKDC+NJFPQWg/57H9rdkqf8MYVgihsB0kf2Auubo6pRZj1yd0J7y
         YEGA==
X-Gm-Message-State: AOJu0Yznkq8UAT9iO6qBBLn1Jqkd4aJ27Bztlq4NJDSE5z77/VesVamu
	VsezhTsYx8yysm9uBScyd6gK8yhrFk/WIYe60peWCs+0PwvPhcdTna/N4kE9qyA4Xu2HXI9PJ87
	UCZv19zV6Is2qCGwHeww8h2G1TuY09j1mKB/K3bA70apGaLZWU4h6RcVyXcN96YSMnGF+EQwplL
	LLuW1eWqnTcWloHeN/9oqTGNrTfg==
X-Google-Smtp-Source: AGHT+IH4PmXp/75tGPKkeLYbAJ3CVK1Z7Y0nirJ6rAr35vYgPdIvAalkJTwpmvN4qWhb86rJZiXQUGFo
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr5125054ybt.6.1709888303667; Fri, 08 Mar
 2024 00:58:23 -0800 (PST)
Date: Fri,  8 Mar 2024 09:58:00 +0100
In-Reply-To: <20240308085754.476197-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8763; i=ardb@kernel.org;
 h=from:subject; bh=l1rr6VehlGWug+Oo1IGH0MVFLA1acdmYGdPLFofuU1M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXVZYkfkv9f2sa2zfBlfvhxbUGJ0t1NSTNV2tcu55FbW
 VZZO+1mRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIwyFGhjbj85u3Tz9QnbhA
 1v1uyZyIaQ22WmvOzd3x9OzGYxf4GtQZ/kc95b5ydGGE0fcHznHs6+PrmEV/n1nCHBSbaD+pv2L VOwYA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308085754.476197-12-ardb+git@google.com>
Subject: [PATCH v3 5/5] efi/libstub: Add get_event_log() support for CC platforms
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
 include/linux/efi.h                     |  1 +
 6 files changed, 61 insertions(+), 31 deletions(-)

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
index 6b020aadcf94..df174edfc228 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -929,6 +929,8 @@ typedef struct {
 
 #define EFI_CC_BOOT_HASH_ALG_SHA384	0x00000004
 
+#define EFI_CC_EVENT_LOG_FORMAT_TCG_2	0x00000002
+
 typedef union efi_cc_protocol efi_cc_protocol_t;
 
 union efi_cc_protocol {
@@ -1140,7 +1142,7 @@ static inline void
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
index 2493d3d4429b..f0d56f106b60 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -402,6 +402,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
 #define EFI_CC_MEASUREMENT_PROTOCOL_GUID	EFI_GUID(0x96751a3d, 0x72f4, 0x41a6, 0xa7, 0x94, 0xed, 0x5d, 0x0e, 0x67, 0xae, 0x6b)
+#define EFI_CC_FINAL_EVENTS_TABLE_GUID		EFI_GUID(0xdd4a4648, 0x2de7, 0x4665, 0x96, 0x4d, 0x21, 0xd9, 0xef, 0x5f, 0xb4, 0x46)
 
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
-- 
2.44.0.278.ge034bb2e1d-goog


