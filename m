Return-Path: <linux-efi+bounces-766-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D332F87541E
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C382836FD
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC031E878;
	Thu,  7 Mar 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/pAEaxA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA512BF3B
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828550; cv=none; b=W6QVZkV+QOrTDGpQVUtAV3XdBS9HH+i5VhCiLP4oYvl99ELVgykAzl2O8MxmCfUPuqke2jemD/OPUHRMN7DCOaEY0HqZPinyZo2OS0eicwmI90jbOfWIZfGTC3JY3mJaYuRaB1mfsv5XytirwQwwzkmlWVAY8qqDURUvlC5zwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828550; c=relaxed/simple;
	bh=vx6gy63bvKwEcZKAJOMT4vamJcfs5j218q6IeLLsKmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qcQYeQH6ytYYufR4zNJs8RvgKqRSNXIiUWdvHzFfwIqUWilZQT9qQ3VCwfDdWs3xF+/keIChklQQNIGwCrMxHFQ+sdYe4jii45ar8i3l0WLFMf2ogfeaiS5RjvLbgXwt1cqtKjR7D6WcLsjqxOQ+lQPX+22PkHoCBnjI60rnPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/pAEaxA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so1838321276.0
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709828548; x=1710433348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIPwglx+vpLGh3Clnv1DsOBYHxPQ5NB3VMfnxKm7TDg=;
        b=R/pAEaxAEdD1sc7O8/3YEeQVZFfoSt1oi4/9NkU1KOedxtvqrIpiIfkxjYdyYCUbhq
         5jmTHNeXxzpvAP29h3ZwSfOpW7+cpgQRb5dyaQTYdb/0d6RNCKM+6EyS+dEUWIEt4XKK
         Oanwh7Unbxu75gBnxi1EaUEkbf93v1OYakxLcMS7CPmmunqA6sk64XZK64OvRpzwggak
         b+x+O1Cl1puxORw/Wqs5X93x/gtddqdb4r62cLGyrbTdHKzBARPqNb7yFKzUM8lZBivq
         ycWlWnj97V+/SReSlIoPNGbOp5j4/ADtaeeU1verpRgzw6V5y/WwKceV/9iwltPVRcO6
         rxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828548; x=1710433348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIPwglx+vpLGh3Clnv1DsOBYHxPQ5NB3VMfnxKm7TDg=;
        b=M1pRYvCDFM1UQRcD1r8Kr2gELX27dUoBVJkkSecrH7N5pLCB2v8+srjP/Gif6KBM+L
         lMFKp+mhho4EuHqO6QAv937+gUaGrP5z2O+1EZ5uunSg3M3/O6jjL8+BP7IoOLpj734z
         C7wyMCdB+orogtMRsp2ct8FYz4r92gL8q1cvy50ZLdsE/pQFLTEHsdZ8lNK4dwcM+6pb
         cJ4qZ51mcYQLkVHaEQevYscOKjNDoodX2UF7ZlBCjRR3m2h0mWDawquP1qLcscW5YCWC
         01XcNVojltS9zLZHWAAa32CxQ1qFfFeB7ENTUaWI1TQPCr/6SXqDBQ4/6b+jxPPlM5ZJ
         r2bw==
X-Gm-Message-State: AOJu0Yzlf/eMOi/cE7dp4c6d+YkLvQYbxmV096ZV5D2CA3znrMmUqp1y
	HEz1+ZIZFWy2YD+lb/RvvSwynkK3pao6eqMy+xtee18F3xmr0rl4GOFiljAWQJLseVomQJXoYPw
	hsy9R5W60fZ+g8EvcYtNnCQXw3DE2lhgQHuZet4af5uA8XKJ2hh5Xxh4/fmn5SMqSDatF3d7dLA
	5SUmJKOKr3ICrU6PJ9B5ZnNXOhXw==
X-Google-Smtp-Source: AGHT+IGBkbaDLEA8X6Cjwf7LKdHd/BuwHE4A3vMIBnYcw5h1dlxgzanmSobPx3kCNvYTCaIXxnQ+CVqd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1823:b0:dc6:e8a7:fdba with SMTP id
 cf35-20020a056902182300b00dc6e8a7fdbamr4665957ybb.4.1709828547777; Thu, 07
 Mar 2024 08:22:27 -0800 (PST)
Date: Thu,  7 Mar 2024 17:22:16 +0100
In-Reply-To: <20240307162214.272314-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=ardb@kernel.org;
 h=from:subject; bh=HowsP3Xpey7zNPaFKSGnjwc0I59oEtS2s4G34jdbb+U=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXly53fdURN/1c0yJv2Op7Ysdjsac0kCaZJrLd3eS2Pn
 J/m2cXRUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSL8Hwh+fVzQnfHJ/J1rXY
 y/C9y1X5u+APW7HkpOecr0tTOnqnXmf4w/lloVj9nejrNQyF21/MrT715N9Lrt9Sb55/4e77V8U 1kwEA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307162214.272314-8-ardb+git@google.com>
Subject: [PATCH v2 1/5] efi/libstub: Fold efi_tcg2_tagged_event into efi_measured_event
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In spite of the efi_ prefix, struct efi_tcg2_tagged_event is specific to
the EFI stub, and so we can tweak it to our liking if needed, e.g., to
accommodate the TDX variant of the TCG2 measurement protocol.

In preparation for that, get rid of it entirely, and combine it with the
efi_measured_event struct used by the measurement code.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 38 +++++++++++---------
 drivers/firmware/efi/libstub/efistub.h         |  7 ----
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..186ced8371ac 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -11,6 +11,7 @@
 
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
@@ -193,7 +194,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
 	*load_options_size = load_option_unpacked.optional_data_size;
 }
 
-enum efistub_event {
+enum efistub_event_type {
 	EFISTUB_EVT_INITRD,
 	EFISTUB_EVT_LOAD_OPTIONS,
 	EFISTUB_EVT_COUNT,
@@ -219,46 +220,51 @@ static const struct {
 	},
 };
 
+union efistub_event {
+	efi_tcg2_event_t	tcg2_data;
+};
+
+struct efistub_measured_event {
+	union efistub_event	event_data;
+	u32			tagged_event_id;
+	u32			tagged_event_data_size;
+	u8			tagged_event_data[];
+} __packed;
+
 static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 					     unsigned long load_size,
-					     enum efistub_event event)
+					     enum efistub_event_type event)
 {
+	struct efistub_measured_event *evt;
+	int size = struct_size(evt, tagged_event_data,
+			       events[event].event_data_len);
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
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
 		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
 				     (void **)&evt);
 		if (status != EFI_SUCCESS)
 			goto fail;
 
-		evt->event_data = (struct efi_tcg2_event){
+		evt->event_data.tcg2_data = (struct efi_tcg2_event){
 			.event_size			= size,
-			.event_header.header_size	= sizeof(evt->event_data.event_header),
+			.event_header.header_size	= sizeof(evt->event_data.tcg2_data.event_header),
 			.event_header.header_version	= EFI_TCG2_EVENT_HEADER_VERSION,
 			.event_header.pcr_index		= events[event].pcr_index,
 			.event_header.event_type	= EV_EVENT_TAG,
 		};
 
-		evt->tagged_event = (struct efi_tcg2_tagged_event){
-			.tagged_event_id		= events[event].event_id,
-			.tagged_event_data_size		= events[event].event_data_len,
-		};
+		evt->tagged_event_id		= events[event].event_id;
+		evt->tagged_event_data_size	= events[event].event_data_len;
 
 		memcpy(evt->tagged_event_data, events[event].event_data,
 		       events[event].event_data_len);
 
 		status = efi_call_proto(tcg2, hash_log_extend_event, 0,
-					load_addr, load_size, &evt->event_data);
+					load_addr, load_size, &evt->event_data.tcg2_data);
 		efi_bs_call(free_pool, evt);
 
 		if (status != EFI_SUCCESS)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c04b82ea40f2..dae635cc3d4f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -843,14 +843,7 @@ struct efi_tcg2_event {
 	/* u8[] event follows here */
 } __packed;
 
-struct efi_tcg2_tagged_event {
-	u32 tagged_event_id;
-	u32 tagged_event_data_size;
-	/* u8  tagged event data follows here */
-} __packed;
-
 typedef struct efi_tcg2_event efi_tcg2_event_t;
-typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
 typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 
 union efi_tcg2_protocol {
-- 
2.44.0.278.ge034bb2e1d-goog


