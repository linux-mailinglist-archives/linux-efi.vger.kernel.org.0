Return-Path: <linux-efi+bounces-779-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5652876075
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107CDB21C1C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030C152F6B;
	Fri,  8 Mar 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJS8NfJQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AF5103F
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888296; cv=none; b=a0CY9VcZQOqRuD3Jc1w5Tl67Rd7cJpEa/a329vl+iSZ4lcTR2cbWxr3de5M9rcd91LJ0ZPT+5+5ZJTUuF7prgZLnLyvTy7Sgb7hi7/uS0mI8dF919WOTn1HtzIiR4NrilsDigmeZxk9I4YILzFn9NgXEifImO1als8RJM7gXtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888296; c=relaxed/simple;
	bh=b8ivDDjtF1p3LyYlCNRZWGf35Ky0K7fkV+0dsPl5AJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q0POf6aef/QI118I3WJWh0D5eeYxaQ/booTcIpeS/XXzjRqbGDSdK8xaNW/RyzU3c9Kx8GOTAnFQ9313OGyN0XxORjfGEXxaD6rXw4G8BtybJIOojx48BH7luq7lZMbVUvSluWaNV52U1fRLcB8MwgeRLzcD6GtVpngqWq+IL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJS8NfJQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so2774280276.2
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709888294; x=1710493094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6z+zN9ImE4xwUb7/dRfou4mLormWnKZkZKNlSdeP+c=;
        b=IJS8NfJQI6WIdGxFqClvd9wGW2nN041H5pvaCT9Z66mgAdIP87Dai2ZG6hmmhydQv9
         aO5GDX3eXjsnUzWhCd9snBFaYrfcl7RSDYCabdeXWyv9lWt/z14r4enuww7bVkVExI5A
         4P9yDR8VfSpg8it/fo+Em5QX2mCFDi77TCrazterMhrXu/vHtkemI5QOZCRqOUTApVxe
         q8NXmojMtrha137YHLnMWcEPEIDUrZJAIF6ZtLulApThIiXdCZLfGAD6CQBxNn3yK2Ph
         qnSF/SeCtxiBmAqAcbSzOj5gOGw7PeA7Gpe6GnVPsyHqJHJgKQ1GtTyihHxugZt/WEVO
         1deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888294; x=1710493094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6z+zN9ImE4xwUb7/dRfou4mLormWnKZkZKNlSdeP+c=;
        b=HTGj32q9aEOgqVUJz3E3d5IYmaixn06nRqiZW0QRiO6rqaHvW3Ft8Atm1F5XVwaNIU
         g/6FiqJAtEh8cJMnXVITme5ft2EsxeQPfzUdAq9yT0OO/w5QnaZ69JmsztaHFJDEr0KP
         xHzLLl9Iqu8X4NuV9lTstLLXTpHEJ55LW+i3gqgZwzhBnvwA3axJX0UprTbY9PLxWOkH
         KFPU15AUcQnMwkJ9teI59PY1GhaPitJ6HL6DC+0UN7w/uBZwhnoH9IU/fLoJXglDnune
         So+nFAZzvSDA1J6uGUDnu7KJFs9u0m6vvFNJl66OUG730f0M5a6BtQWtfERC1ISogUgi
         PIIg==
X-Gm-Message-State: AOJu0YwINhC+7QggkSdoySx+AVL6o8G8X1XneYZgXjBQgRCZdqcrQKxR
	rCq9kRL0vLDSProMDcEDY7p+JZPLnyS9xMZRvcNnS4LNS/+E4WW46f7rKe5DzULknqvBndXr1Iu
	m7C+boUJ3GwF/mvq/3R/5TD/q0fNBSDMn43GJ6G50AV4h2zeNM1kMuXYg9iH87G4DNTVcrCz4sL
	yLx91PBh42OsYjmRn8QIdtFeal5g==
X-Google-Smtp-Source: AGHT+IH9WUFgRCwJEh32egOuauvZKhSy6ydz1UiCGIJYMPsHZHSZu6AjcwL8wxdFzKtlMNFWc7Rh69E9
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1081:b0:dcc:41ad:fb3b with SMTP id
 v1-20020a056902108100b00dcc41adfb3bmr824921ybu.10.1709888294125; Fri, 08 Mar
 2024 00:58:14 -0800 (PST)
Date: Fri,  8 Mar 2024 09:57:56 +0100
In-Reply-To: <20240308085754.476197-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3906; i=ardb@kernel.org;
 h=from:subject; bh=2xlGpPZ2KXRAhQWGXtcuPOB2hLa2jwtfBLys2womY6Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXVZeFiecFl0TG+VxhKDAqKyy1mCE88YsHy5OzPrst8O
 17+2PWoo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkdxrDXynftCPvhY7f7f7k
 knfr5QyNdXuTXJqn6u2tmSu8SX7ra25GhvM85458MXOtL+rR4imS4C0tDmjWnHn4ZERNxuyjf/Z MZAMA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308085754.476197-8-ardb+git@google.com>
Subject: [PATCH v3 1/5] efi/libstub: Use correct event size when measuring
 data into the TPM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Our efi_tcg2_tagged_event is not defined in the EFI spec, but it is not
a local invention either: it was taken from the TCG PC Client spec,
where it is called TCG_PCClientTaggedEvent.

This spec also contains some guidance on how to populate it, which
is not being followed closely at the moment; the event size should cover
the TCG_PCClientTaggedEvent and its payload only, but it currently
covers the preceding efi_tcg2_event too, and this may result in trailing
garbage being measured into the TPM.

So rename the struct and document its provenance, and fix up the use so
only the tagged event data is represented in the size field.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 20 +++++++++++---------
 drivers/firmware/efi/libstub/efistub.h         | 12 ++++++------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..16843ab9b64d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -11,6 +11,7 @@
 
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
@@ -219,23 +220,24 @@ static const struct {
 	},
 };
 
+struct efistub_measured_event {
+	efi_tcg2_event_t	event_data;
+	TCG_PCClientTaggedEvent tagged_event;
+} __packed;
+
 static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 					     unsigned long load_size,
 					     enum efistub_event event)
 {
+	struct efistub_measured_event *evt;
+	int size = struct_size(&evt->tagged_event, tagged_event_data,
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
@@ -249,12 +251,12 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 			.event_header.event_type	= EV_EVENT_TAG,
 		};
 
-		evt->tagged_event = (struct efi_tcg2_tagged_event){
+		evt->tagged_event = (TCG_PCClientTaggedEvent){
 			.tagged_event_id		= events[event].event_id,
 			.tagged_event_data_size		= events[event].event_data_len,
 		};
 
-		memcpy(evt->tagged_event_data, events[event].event_data,
+		memcpy(evt->tagged_event.tagged_event_data, events[event].event_data,
 		       events[event].event_data_len);
 
 		status = efi_call_proto(tcg2, hash_log_extend_event, 0,
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c04b82ea40f2..043a3ff435f3 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -843,14 +843,14 @@ struct efi_tcg2_event {
 	/* u8[] event follows here */
 } __packed;
 
-struct efi_tcg2_tagged_event {
-	u32 tagged_event_id;
-	u32 tagged_event_data_size;
-	/* u8  tagged event data follows here */
-} __packed;
+/* from TCG PC Client Platform Firmware Profile Specification */
+typedef struct tdTCG_PCClientTaggedEvent {
+	u32	tagged_event_id;
+	u32	tagged_event_data_size;
+	u8	tagged_event_data[];
+} TCG_PCClientTaggedEvent;
 
 typedef struct efi_tcg2_event efi_tcg2_event_t;
-typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
 typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 
 union efi_tcg2_protocol {
-- 
2.44.0.278.ge034bb2e1d-goog


