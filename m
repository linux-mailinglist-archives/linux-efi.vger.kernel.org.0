Return-Path: <linux-efi+bounces-688-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F886FF52
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733911F22379
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611EA364C8;
	Mon,  4 Mar 2024 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LR66oSP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FB36B02
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549062; cv=none; b=teuctDtelip01g70At7JZ0I6hN0WKk4CSgQcaJGLM4hjbU5GSRVBYjqAK3HG73q5oiXFuZOO4Z6CglKr3lIIpO1vnQOv97S/FmecmPfo4502EliSG3Yxi8k5CAu6DJNFTiBN0H4H146NMeWrESJCbUTv9V7F5I8PSfQ1lC4GKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549062; c=relaxed/simple;
	bh=rUoVnOWH3KhRLUKAtu1Bvtoi9WLHLAW4FJRtXzFfz+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZfQBc/sYsSU9sKfFd0k9kOvJRglhKI4WDslIjzJ1gt0tgneJdi+Q71//vmxBRXEIi2ScxQqRjlSuLh5z/gYPwm/4pPVeZXAw8nqWGbUrNwphBrcwfjddHwhO82NKqsrUkFfPQbzr3qJpUossVViAIKPyNdmTwhAQ1czjkeCmjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LR66oSP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60966f363c1so62289017b3.3
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 02:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709549059; x=1710153859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fye5J1IiDjNC2HBYOqjmRhNgF2oCbMDVZrQYExDvAzk=;
        b=1LR66oSPAalyePaBYwRvgc7qxcfovATYaFD2HZnJnqAT/WW1oZoTneZJBlmOSTtUEe
         Zo9dxxELL/bwInUvDs/SQ+1JweY0yoqxmhF8RQ0nQ1mtPC5U9CKCj+mjtRLfAinpOZbs
         WpBqIfGP2y96nPt82X9+XGae+gtDGPxY2ABCIG0I+25zA8XAJ69QIsc7OVIXcrO7ETpE
         O7LkJVQ5vS+kWI6uRK6s27WI3+poeZRLkJXu5wYiO15EOU1kIMu4RFJqJfVajwQ0z7Oz
         QRn9pihM2SueLsesTfplVOEnCgG94BCfQ6l7VfpsWKrz8wnK1Pa15MxXHv+EZwbamo5U
         W2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549059; x=1710153859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fye5J1IiDjNC2HBYOqjmRhNgF2oCbMDVZrQYExDvAzk=;
        b=nBnfVqImmPs/EAYaeg2sgHZMfEf3M4eQ4DfpOZ6hMM3BqruKRXFd0k2Tzggqri8X1R
         AHVQ5Dsg/Q4iFpV60AuzvZIb4DjFHQvvfd8Y/kfcbkIbLAa+wsGms9zJ+XTZhY85kEfB
         Jtrv/62OxNONMbSdoj30m+T3EfkstzLBObWsSLtb8vTB9CtS1VOiMh/T2vYzPt1CONbi
         +DUeGUdmeQkezcdVncvL86T1XPKOPkvfZT8zpxs/Lxi7FpDq5RNrJZOxD27MEYGWEVWe
         eI3jaRaxiGi7hC8nTdHtfWJSkwZ4no5ytf9nGXu6i9NFyXarsGh84WR0EtZTGukSyZoa
         CtZg==
X-Gm-Message-State: AOJu0YzN52IStS5bfLbrfPRzF3tNzi9j25tv+mlMcjci8clXKTFi8Nqv
	/zBvT/rQFzePs8+Yj6w3ZN5W5sBtsNJJoVzGFqIRF5lNb4zGF5S3YI/ohuA8gH1A1FYpUdfJjh7
	Nrhce3hE6PhzhIU9thZHK9hKrVLE2wCn/j02EpsegztbrjOydAOQnqncVb+cRpcsiSuAAupCHoN
	0Qnts/ZSKWqe3jX95WXq3Ijn9jyw==
X-Google-Smtp-Source: AGHT+IHXmJQ3fSGBPDoQ0htYLOQVoTJ++JV+eq2yjUmQQZRpdKsvl73/it0N89uJ+lh/IPExp8QgkL5k
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:4cc2:0:b0:608:ce01:9aa3 with SMTP id
 z185-20020a814cc2000000b00608ce019aa3mr2458238ywa.3.1709549059549; Mon, 04
 Mar 2024 02:44:19 -0800 (PST)
Date: Mon,  4 Mar 2024 11:44:11 +0100
In-Reply-To: <20240304104409.2326422-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4246; i=ardb@kernel.org;
 h=from:subject; bh=f7pGP0YQg7y2zqt1UlrYoWJvFsxXx7WoCxt8tiOGVWw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXp0t/JU+bLBu7aKFOy/66pxu0Lj0q8rBZ5FU/cvONvl
 xHbQZb5HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAibqaMDI3rbQ2LJpuuqNYR
 um2t16ogk/Hkferxol93y+dtFIx738nwz1CDp9PsVsy1wn8e4s9YjO49NBK5OOvZvBvrt75kctw fygwA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304104409.2326422-7-ardb+git@google.com>
Subject: [PATCH 1/4] efi/libstub: Fold efi_tcg2_tagged_event into efi_measured_event
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 26 ++++++++------------
 drivers/firmware/efi/libstub/efistub.h         | 18 ++++++++------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..0dbc9d3f4abd 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -193,7 +193,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
 	*load_options_size = load_option_unpacked.optional_data_size;
 }
 
-enum efistub_event {
+enum efistub_event_type {
 	EFISTUB_EVT_INITRD,
 	EFISTUB_EVT_LOAD_OPTIONS,
 	EFISTUB_EVT_COUNT,
@@ -221,44 +221,38 @@ static const struct {
 
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
index c04b82ea40f2..b2c50dce48b8 100644
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
@@ -882,6 +875,17 @@ union efi_tcg2_protocol {
 	} mixed_mode;
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
 struct riscv_efi_boot_protocol {
 	u64 revision;
 
-- 
2.44.0.278.ge034bb2e1d-goog


