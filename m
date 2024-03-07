Return-Path: <linux-efi+bounces-769-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD12875422
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5931C1F23082
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDF312F5B3;
	Thu,  7 Mar 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7d2RKLW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACC1E878
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828557; cv=none; b=cc2DNtg4ZnJ6XjfkzG2W0j8quWP6J736B5p673VkzMy5SkLd3bvVhKAr3P8zUc/9t15n90lXGseOqmPa6keRfQrg0QtT+l//x/U7bSclYQBkZhWT8praNN4J93H+eqe3urM1c2QY4mafB58vGWG3crHbKR/L0u4O/HV6SojFupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828557; c=relaxed/simple;
	bh=SoIaXrJGI2TPdCnYEbQBmioks4lWKOS+7GEz43YxA7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LuLYcK0AxN6RelQjYD3uqaF7MY0ld2z0/HSksdaalJC939yDuJlNSD7vVhEpmmqTqJ8Te1EUxOu9IEt8yuokeM8YS3BoKPe7u2l5d+wwmOVKUn0ETb+SoYuF2LCFZKbCw2NP4/xBjSuxYQPWuLNOYVvIJcQhr5GWKpsIPK8guWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7d2RKLW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso1783894276.1
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709828555; x=1710433355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuv7R6J6cPZcnSD1YmsTMTUsB4usMCYn74Y3UHhuK9A=;
        b=m7d2RKLWAat327eo+XT6UX+af1XU5hxLkfInllzSSQu6+qfGtFPxzZwI8X0LkHkI+S
         xoaOItQfrlOWqzhHEiq5HILOhMF8tQhodOEGncGeP41bChFwL33O2ZX6wzl6sYapVnRV
         x2JKtUVyVWUFk1J/8t5H1HrEJBSe8Y2G9XwkDAT1VvkO3B3cw+6lm2C+Tb0+wd5xOJc0
         XGjOIjTYRm/J+tSvCE8Ol7meAtI91IahLw5ehy2IQ9zqsqt/AnbI89b+7/8AJUewhvb3
         OQ/hXo1IK8eOU6EqT3JsiRaHz/hnOMkUdCare+/0RdJF/uylkcdrVjL7SgRnwXlf88nL
         9J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828555; x=1710433355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuv7R6J6cPZcnSD1YmsTMTUsB4usMCYn74Y3UHhuK9A=;
        b=Gx7EqdUOR/P/eKXduJbaogrBDFVFhzIvCJ9ksqCiInse013BT9Qj0igm/1QuMR1woF
         fby1ciWP0vOjszB1lQQ2AMEUZgUeqZFBllj1r5Mh041siKAAuM+rrRg1yjJARtzSaGk5
         eTC973WbhEh636IETXjeoImeSdYg71JH+HYtVvEf/V4Fv2lMuCOYzQYRJxgv/dnru0iX
         1h6CoCVOXNuas17j/hGS9VPAxudDqrs/jmby83c5SzjhynEHnMUlUOOE3klvrVAfOZjH
         88SkrBVFP4bceAP2vs7yvzlfTCm8Jk4806Zj5HPqaqy7AScoPbVLPD6CrT8D4g/H/+oi
         leQg==
X-Gm-Message-State: AOJu0Yx8WZ4vehqVtGriiwur3XnCXCmdaZgJ5vnXYatH9/1iO+ZrlHxU
	SVEcY23L6ycyxvtfeqZ8vPLJ6j4OPlTgBozjmZZ4Ulv2srps5r2B+EhNVbcRLZbFPOuUjNWfaKi
	jaetel+tGzZyaX0vnSVRB/eRzAj+AfmHbsyhIIDDTjXjNmmmi6MZ02NmxKF9PUDnerk7z5woC+0
	llEitQ7veCQEpBiQHG/c7V4PTDXg==
X-Google-Smtp-Source: AGHT+IElobcdMYwnKdcXBTJUv05H8jBKow+I07kzaRwdKB0ENl7Vu0DnWj8fShy3foUsQrI2H7HeXV2Z
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:100d:b0:dcc:8be2:7cb0 with SMTP id
 w13-20020a056902100d00b00dcc8be27cb0mr673231ybt.0.1709828554981; Thu, 07 Mar
 2024 08:22:34 -0800 (PST)
Date: Thu,  7 Mar 2024 17:22:19 +0100
In-Reply-To: <20240307162214.272314-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4576; i=ardb@kernel.org;
 h=from:subject; bh=TNQf4Yorjyby48cRqVB4XsLdQEf+HzREUwZZ+kg0fYA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXlyz0Xso6cW53/R4uP5YuZ/4Kzcxg+2L38mC42oefs4
 /87boZs7ihlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATCX7AyDA7u/l21cTsf4vj
 XSxeaafce3PF70uzMsfzew1v9pRttbnH8L923r+pe7K6DcszpY+qByjJun69m6HL1u+wik109au pf1kA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307162214.272314-11-ardb+git@google.com>
Subject: [PATCH v2 4/5] efi/libstub: Measure into CC protocol if TCG2 protocol
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
 drivers/firmware/efi/libstub/efi-stub-helper.c | 70 +++++++++++++++-----
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 186ced8371ac..993c58e2221b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -220,8 +220,11 @@ static const struct {
 	},
 };
 
+static_assert(sizeof(efi_tcg2_event_t) == sizeof(efi_cc_event_t));
+
 union efistub_event {
 	efi_tcg2_event_t	tcg2_data;
+	efi_cc_event_t		cc_data;
 };
 
 struct efistub_measured_event {
@@ -235,44 +238,77 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 					     unsigned long load_size,
 					     enum efistub_event_type event)
 {
+	union {
+		efi_status_t
+		(__efiapi *hash_log_extend_event)(void *, u64, efi_physical_addr_t,
+						  u64, const union efistub_event *);
+		struct { u32 hash_log_extend_event; } mixed_mode;
+	} method;
 	struct efistub_measured_event *evt;
 	int size = struct_size(evt, tagged_event_data,
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
-		evt->event_data.tcg2_data = (struct efi_tcg2_event){
+		ev.tcg2_data = (struct efi_tcg2_event){
 			.event_size			= size,
-			.event_header.header_size	= sizeof(evt->event_data.tcg2_data.event_header),
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
 
-		evt->tagged_event_id		= events[event].event_id;
-		evt->tagged_event_data_size	= events[event].event_data_len;
-
-		memcpy(evt->tagged_event_data, events[event].event_data,
-		       events[event].event_data_len);
+		efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
+		if (!cc)
+			return EFI_UNSUPPORTED;
 
-		status = efi_call_proto(tcg2, hash_log_extend_event, 0,
-					load_addr, load_size, &evt->event_data.tcg2_data);
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
+	evt->tagged_event_id		= events[event].event_id;
+	evt->tagged_event_data_size	= events[event].event_data_len;
+
+	memcpy(evt->tagged_event_data, events[event].event_data,
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


