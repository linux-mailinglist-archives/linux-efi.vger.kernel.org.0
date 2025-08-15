Return-Path: <linux-efi+bounces-4562-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D541B2864D
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 21:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DA8B62B1C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B7285061;
	Fri, 15 Aug 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Bp+lJA6J"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CA22F75C
	for <linux-efi@vger.kernel.org>; Fri, 15 Aug 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285776; cv=none; b=ZsM5otVMZwX39Zv7O6E9nokFKR3SoSJzJxWD5QtO47KqLj8ZZ6SOut/X4GdZb6NWysdqOo0VHzSvz6uOLVtKOKs0Mo1l2T/lr+llcRQO2WrzcQebPdKtebs+BtAcjp8oM84vQJUCBneWj5t3pU5iJa9FYMTdY166pwFnLwS7dQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285776; c=relaxed/simple;
	bh=x92zVQNMZzDOH2cvOB+047T4zZpTmVv+/3XQay17u4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMas7oIizlkHj6NyB8cdCVWf8g0J3cZJjdS9HneLmw7csqAa3PDt+puxpGPLkFtX+SbQrRyexKNn2Ubulj7IGQUhPL/a7l+Muu3Wd/maZn3wIgEMdpkpnjnGobPBO5SBDnqZL228LfXJZSRsevyquxbJnOgm8gwwZH0QBm1CN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Bp+lJA6J; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202508151912438baa758180d800ec6d
        for <linux-efi@vger.kernel.org>;
        Fri, 15 Aug 2025 21:12:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B5JIt8JUCWyoCLiiDyVPQuDaUtKXoi8UQzuy3UgNRf0=;
 b=Bp+lJA6JCPtntWDmrUIPaNasoO198Xrz3XAG+ebELqAxryy64IHMHOH0cj1g+KsRWRI9Ex
 sekUoNIGTT3skdIhI9oVuqEHn5WGyoq/MCALpM/4a5cND3Spv694IBPPZk6x6WVlilCa1pHW
 k4jtenDY2rhZp0PWSKTc3QfU6log535N/2ma5oal2624C9VJXvkP6Cn2vmQ6rgjgO4pQtKGJ
 N6FoTAFcwd5E8EdCJms7JmyRZs93TFgneB5pEnQONKn5wAZZKUsNgX4LCjQloxLTdsVZxPFr
 mD6TbGS9di3v5XgXyqk23lD2JfU/ZooIh+az9Ruq/4NeWH7bwvOXSdTw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
Date: Fri, 15 Aug 2025 21:12:40 +0200
Message-ID: <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1755285161.git.jan.kiszka@siemens.com>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

If a too large payload_size is passed to setup_mm_hdr, callers will
returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
passed down via ret. No need to fold errors here.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index 706ba095a4ba..bf992b42be70 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -220,7 +220,7 @@ static efi_status_t get_max_payload(size_t *size)
 				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
 				   &ret);
 	if (!var_payload)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	ret = mm_communicate(comm_buf, payload_size);
 	if (ret != EFI_SUCCESS)
@@ -267,7 +267,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 		&comm_buf, &nr_pages, payload_size,
 		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
 	if (!smm_property)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
 	smm_property->name_size = name_size;
@@ -324,7 +324,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
 	if (!var_acc)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	/* Fill in contents */
 	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
@@ -391,7 +391,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
 				   &ret);
 	if (!var_getnext)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	/* Fill in contents */
 	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
@@ -448,7 +448,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
 	if (!var_acc)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	/*
 	 * The API has the ability to override RO flags. If no RO check was
@@ -505,7 +505,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
 				&ret);
 	if (!mm_query_info)
-		return EFI_OUT_OF_RESOURCES;
+		return ret;
 
 	mm_query_info->attr = attributes;
 	ret = mm_communicate(comm_buf, payload_size);
-- 
2.43.0


