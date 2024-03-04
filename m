Return-Path: <linux-efi+bounces-690-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D586FF56
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF621C210E2
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391EC36B02;
	Mon,  4 Mar 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gu0+ZBrH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31F364C8
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549068; cv=none; b=gBvqh0othhlFWboHy6ZFO28133L9k1fSdFRSIYww+840Gdvq9DJ7Ss+TXbBDD0PZU1DOiyZZos0w/6QEAgQm5IIpDK5XDq29tgIElw9zq1zZEYwnW/vIz6lubf9kwkWIoJO72uagcLhT3wLhINRFUl4s4MmP/R86/haz7hWcz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549068; c=relaxed/simple;
	bh=J9xhqifDnYz9MiaIJkP6q3vXgzeQIiGNnswih3Z1vgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K9efpGLCodsOGqzNpkRGEyiLS+PRxiNfoJQE3YtHMJSIWNt282WKjSbzn+2fqwvKIOnkT1KINKhOJpG5/PPeW43f7IPXz0tCNA63nytnPXnl7Ot7TDmp0K6e78sZgF6XkclZZ5km3UTrbrrIMtFNpDjkJ3gumzGih1vC5qUwVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gu0+ZBrH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412b2321084so21431525e9.2
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 02:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709549064; x=1710153864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zOqtzBzdQ3hsbbykV18UWs1iRDCBoMzO5Q6nZSM61S4=;
        b=Gu0+ZBrH3YCPbV7JH8oYHoAUBF28PVGaKvBKxa8sIn7SPTIS3tOeuhaRW8scdpcnsT
         tYl5FPv+s7L3v/7nNjLj1tXWj/72dI4ZlES+XHM1sGR8SgfgujF7tN5/XBMPGvCzG1Gq
         Xs+7Zkg/4Ba52r/vmXHyynyrqHxjnJw+JkiIHSeG1dfZ7LDrjiBLpkl+VzvoJXJj15ke
         0GHwaO0X2Eoc3rixZMth2b24YzAfd0+LtX7jeJuHXQ0RZqgQ6tNLJJ7K8hce9GcZIl3L
         av6d9tK90JY6NVQl7Cp/dVLjqGB7mb0HbMjhBaYIDWN/xUjHNrI5hk5BKLXqVozj6Pna
         a34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549064; x=1710153864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOqtzBzdQ3hsbbykV18UWs1iRDCBoMzO5Q6nZSM61S4=;
        b=rhB4BFHzToH0eLgzvmzfpqHwEy5cBpoi4uGiVkJf2Bc8eI+LT4S1kkesU2sogREoQq
         g8BB6x0VD075IQFEEPqTS3ExJR2hYMleBvbU9LoPURAebFVzvF/9YwS76YYS5eEi08Rn
         xLpMelG1OjNjXTOX4a2DPwornmcJ95ZcoV7UXdKHbPMUv8XMC5GD48ldWF2iHtKt+DXW
         8znIl3VqQzwXZC54vEcYLHxZZmuRn473PRcN8ccx1KFKFLYm4pOYEU0NeYq6oZkoY4CT
         89K30N8fE2IjTBj7mOB114nR5Qmr+f0ExfOA9qiO9ETln8h/CTFDjbHJN/OS3AKZnZZ/
         GQPQ==
X-Gm-Message-State: AOJu0Yx9ESFAq/2LBtzIsE7p9VStWklpn4xOsPXtn6fw5Y5SQ3TsikE0
	ked2XsNMI3kWsush7mB/EF6hDsS+Z7sPjnFkuMgLYDtKikcF45h1pMMOh3Q/Um9nD5C+boB3Rea
	fxjiDyyUc8jmqmrapXMER9j8JIx+UIB1XTtaR/2lTEl1SsgJWhslFG3xywxGBe7CjVIfwxpzzp9
	hOgjZB1bLljYje7d6u0PrtKDu2vA==
X-Google-Smtp-Source: AGHT+IFoh3MiEbo+i5gxYuvpUFWRazSxQ0iZaiC0JSivBmzLJvi4VcOqefxHjzhS0Noyw7RS9sQlQeto
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c0a:b0:412:e84f:4e08 with SMTP id
 j10-20020a05600c1c0a00b00412e84f4e08mr8462wms.8.1709549064092; Mon, 04 Mar
 2024 02:44:24 -0800 (PST)
Date: Mon,  4 Mar 2024 11:44:13 +0100
In-Reply-To: <20240304104409.2326422-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4787; i=ardb@kernel.org;
 h=from:subject; bh=xichEWK5e4/jRYNdIPGHE18RWlrz3XDPAK0FIojpjW4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXp0r/vbbfqzTdapv79ktHamcfmVGbveOP72+vbkmuhv
 O/36hjt6yhlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATeaTHyPD+aeaHUqaORUuX
 aHOxHL5xfD97VMKJg9NXaOTrpFja15YxMnQ/Nr3+XNyai6NMUaej+p+P0WHWeW9N254aqZtknxP rYgAA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304104409.2326422-9-ardb+git@google.com>
Subject: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2 protocol is absent
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++-----
 drivers/firmware/efi/libstub/efistub.h         |  3 +
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 0dbc9d3f4abd..21f4567324f6 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
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
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d621bfb719c4..4bf9a76796b7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -954,8 +954,11 @@ union efi_cc_protocol {
 	} mixed_mode;
 };
 
+static_assert(sizeof(efi_tcg2_event_t) == sizeof(efi_cc_event_t));
+
 union efistub_event {
 	efi_tcg2_event_t	tcg2_data;
+	efi_cc_event_t		cc_data;
 };
 
 struct efistub_measured_event {
-- 
2.44.0.278.ge034bb2e1d-goog


