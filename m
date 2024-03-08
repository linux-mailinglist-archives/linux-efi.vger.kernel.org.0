Return-Path: <linux-efi+bounces-782-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB761876077
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D60A1C2155D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10690CA78;
	Fri,  8 Mar 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9PX41Mo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B1524CC
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888304; cv=none; b=U7Tl7IfT8EsUoR05dHvfSTKHdcRAmbk19lIa/5LCn2r7o7/zY1YSOQR2/YR35Oc1arCvd5vZJtcXIC5GJ71ijlwnMoVy1tQ3vifrYUIt0EaApvGUBvp5allcmbjmhQSkKSgzu9w1zrIaFVFSciznIhcgQbPXuCeeFj++RHxWyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888304; c=relaxed/simple;
	bh=w5y43qPg8YnMMrJVBpbFejVMqsHD8dMGg5hdRZozaSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b5wQykJGtPJsxyle2XZStq0N+o6Xb37qBX396j0V/IfEi1JdZ1N5Lu4it3cpc0Lu4n+3wZhk9EqqbFKasBMdL0s8FDE07I+sqKFdBSVVW2y1ei19S1RVWpeWMMKdHmo3woIdYIxewDdyPJPlWEsJdK5fPQmlN+fMvWnDT+SUvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9PX41Mo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso3340410276.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 00:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709888301; x=1710493101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAON+hsrBCvAR5DHyDyw9512R5nsi91Nq+pxTAKDv+g=;
        b=H9PX41MosIkd9S6ZOdszdBaaZou+7ECzymyJIOouvqttno5v3qdqLzObLdaKOFVC+R
         BZ5p9kQki8Hd3wMD/6Rs+rBQPt7YyZn0G2N8MPl2LOXYsbCedNDTlLvPJ5yVzbMtOSmI
         gvePLpEyZOm43Ld4+DHYF51DxTBJ6f3/koLTLjCtkUPgTOgvs7ASRhGRsvDutdsEwDQA
         SKP3Kqrx7KdSRZ0DoPChUjVwhgT06bMVjzUSD1NjanOoaTXzx3/2nuHKTfbOQVZ2i+H0
         xyqaDs5cnUQKWqKAk4ejiOBsi3G9F8PdmwO3yN1amPn/8ysl8JIWXt56z8685lJbn7ep
         Bxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888301; x=1710493101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAON+hsrBCvAR5DHyDyw9512R5nsi91Nq+pxTAKDv+g=;
        b=KkbAFXm86guxuxFAbDet7pLGrW0FyPz95JwgF6fmDiBj3E/aCOBRY0pMvWTRr13kGY
         1mTQiP+8f3SVZLLwKz4icIWfSkq3k8/THkAm7mha5oTrjzc25+QOwhiIT5dmG6mjURUG
         0zBHnn3ppcDCMkaptrN5nSrp8nFiRHkYGK0vXaS3WorsXUue2V6cHyuYTAE1RSfxFE+X
         6l2hIUVYhDSkDtjEHR3QZih6fomSa62z4DET1mSwQbfZD1l7x770b8dYZw330xMKthPx
         zXOk0rVY+7w0OzQZtXZut7+/vbm/stPtR/AjdEWgY9unM2cDjkJ4B2U3oYwJmXeZRRRV
         fUZQ==
X-Gm-Message-State: AOJu0Ywvhk6+xKndgkhbO7Simz4wl2zGHzzOnzYtQNRbuo9uNpFUvy7p
	tRtxn1nzYl/KPtVR56p+w4uIaPAeDrNpJB+QrS4ss6yCsmbc6mB4x/F+/S3GVi9yD6dvZZ6/nLe
	0teper1lIJN8Pihp2P049kpSJXiEaDntMWDl6Ld5W45SqQ7Vx5R98bZx0wGoX1GSAnQ8lOR0/+i
	KgpZKunNRsJ5KH2aHKYJMoZwaQeQ==
X-Google-Smtp-Source: AGHT+IFI6mcrAIKW+ad49FGRWgCf7jiIRHg2PfoqLIvcXLbTYSr+uwZdJuzJPH52ElNHO4nkrq2ts4b2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:2688:0:b0:dc6:eea0:1578 with SMTP id
 m130-20020a252688000000b00dc6eea01578mr5080852ybm.13.1709888301200; Fri, 08
 Mar 2024 00:58:21 -0800 (PST)
Date: Fri,  8 Mar 2024 09:57:59 +0100
In-Reply-To: <20240308085754.476197-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5132; i=ardb@kernel.org;
 h=from:subject; bh=DKRTY0+O5JJp1haoOHXDgu0pCOw0dcBoZV2QBt3Ss1g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXVZfH65Q7Oj04V7NY0MReu51SeJcFQeHJiRU6kRIGKm
 f+vR70dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCLeOxn+exu2HLW/tuejkmn/
 f2E/n+PNlm2CBh/yGzYaK+bZeHY8Y2RoFezglDG+qu/qcshv8r2/P+ymRlo6L6r07Q1L+DRz1wI mAA==
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308085754.476197-11-ardb+git@google.com>
Subject: [PATCH v3 4/5] efi/libstub: Measure into CC protocol if TCG2 protocol
 is absent
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

To accommodate confidential compute VMs that expose the simplified CC
measurement protocol instead of the full-blown TCG2 one, fall back to
the former if the latter does not exist.

The CC protocol was designed to be used in this manner, which is why the
types and prototypes have been kept the same where possible. So reuse
the existing code, and only deviate from the TCG2 code path where
needed.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 84 +++++++++++++++-----
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 16843ab9b64d..4aa59088ba5f 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -194,7 +194,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
 	*load_options_size = load_option_unpacked.optional_data_size;
 }
 
-enum efistub_event {
+enum efistub_event_type {
 	EFISTUB_EVT_INITRD,
 	EFISTUB_EVT_LOAD_OPTIONS,
 	EFISTUB_EVT_COUNT,
@@ -220,55 +220,95 @@ static const struct {
 	},
 };
 
+static_assert(sizeof(efi_tcg2_event_t) == sizeof(efi_cc_event_t));
+
+union efistub_event {
+	efi_tcg2_event_t	tcg2_data;
+	efi_cc_event_t		cc_data;
+};
+
 struct efistub_measured_event {
-	efi_tcg2_event_t	event_data;
+	union efistub_event	event_data;
 	TCG_PCClientTaggedEvent tagged_event;
 } __packed;
 
 static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 					     unsigned long load_size,
-					     enum efistub_event event)
+					     enum efistub_event_type event)
 {
+	union {
+		efi_status_t
+		(__efiapi *hash_log_extend_event)(void *, u64, efi_physical_addr_t,
+						  u64, const union efistub_event *);
+		struct { u32 hash_log_extend_event; } mixed_mode;
+	} method;
 	struct efistub_measured_event *evt;
 	int size = struct_size(&evt->tagged_event, tagged_event_data,
 			       events[event].event_data_len);
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_tcg2_protocol_t *tcg2 = NULL;
+	union efistub_event ev;
 	efi_status_t status;
+	void *protocol;
 
 	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
 	if (tcg2) {
-		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-				     (void **)&evt);
-		if (status != EFI_SUCCESS)
-			goto fail;
-
-		evt->event_data = (struct efi_tcg2_event){
+		ev.tcg2_data = (struct efi_tcg2_event){
 			.event_size			= size,
-			.event_header.header_size	= sizeof(evt->event_data.event_header),
+			.event_header.header_size	= sizeof(ev.tcg2_data.event_header),
 			.event_header.header_version	= EFI_TCG2_EVENT_HEADER_VERSION,
 			.event_header.pcr_index		= events[event].pcr_index,
 			.event_header.event_type	= EV_EVENT_TAG,
 		};
+		protocol = tcg2;
+		method.hash_log_extend_event =
+			(void *)efi_table_attr(tcg2, hash_log_extend_event);
+	} else {
+		efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
+		efi_cc_protocol_t *cc = NULL;
 
-		evt->tagged_event = (TCG_PCClientTaggedEvent){
-			.tagged_event_id		= events[event].event_id,
-			.tagged_event_data_size		= events[event].event_data_len,
-		};
-
-		memcpy(evt->tagged_event.tagged_event_data, events[event].event_data,
-		       events[event].event_data_len);
+		efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
+		if (!cc)
+			return EFI_UNSUPPORTED;
 
-		status = efi_call_proto(tcg2, hash_log_extend_event, 0,
-					load_addr, load_size, &evt->event_data);
-		efi_bs_call(free_pool, evt);
+		ev.cc_data = (struct efi_cc_event){
+			.event_size			= size,
+			.event_header.header_size	= sizeof(ev.cc_data.event_header),
+			.event_header.header_version	= EFI_CC_EVENT_HEADER_VERSION,
+			.event_header.event_type	= EV_EVENT_TAG,
+		};
 
+		status = efi_call_proto(cc, map_pcr_to_mr_index,
+					events[event].pcr_index,
+					&ev.cc_data.event_header.mr_index);
 		if (status != EFI_SUCCESS)
 			goto fail;
-		return EFI_SUCCESS;
+
+		protocol = cc;
+		method.hash_log_extend_event =
+			(void *)efi_table_attr(cc, hash_log_extend_event);
 	}
 
-	return EFI_UNSUPPORTED;
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
+	if (status != EFI_SUCCESS)
+		goto fail;
+
+	evt->event_data			= ev;
+	evt->tagged_event		= (TCG_PCClientTaggedEvent){
+		.tagged_event_id	= events[event].event_id,
+		.tagged_event_data_size	= events[event].event_data_len,
+	};
+
+	memcpy(evt->tagged_event.tagged_event_data, events[event].event_data,
+	       events[event].event_data_len);
+
+	status = efi_fn_call(&method, hash_log_extend_event, protocol, 0,
+			     load_addr, load_size, &evt->event_data);
+	efi_bs_call(free_pool, evt);
+
+	if (status == EFI_SUCCESS)
+		return EFI_SUCCESS;
+
 fail:
 	efi_warn("Failed to measure data for event %d: 0x%lx\n", event, status);
 	return status;
-- 
2.44.0.278.ge034bb2e1d-goog


