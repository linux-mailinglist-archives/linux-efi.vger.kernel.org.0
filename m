Return-Path: <linux-efi+bounces-4593-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9360AB32B3C
	for <lists+linux-efi@lfdr.de>; Sat, 23 Aug 2025 19:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C77AF80B
	for <lists+linux-efi@lfdr.de>; Sat, 23 Aug 2025 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443F2E92DD;
	Sat, 23 Aug 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="SMY4Yegt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA11F181F
	for <linux-efi@vger.kernel.org>; Sat, 23 Aug 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755969747; cv=none; b=EHht2FtKMr1Of7PVfsG51pL6JmQOdKbvtY1GXXAcUFsbOoc821b4k6Ntkl9sHNbDTMC2K+0oD8Np6qlqnv4fBKK0k4B5w/CZ2u2dq5t2dIKcv38rLdDlW2MD7GTezNhN93SvrtiCd+LvmAKf9YcyJyrzBdRWSEDvOYfVwXaZHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755969747; c=relaxed/simple;
	bh=gKnQ0VN6b1kFWflESUQZ35PHQivutNo3thh7mWVrYD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDFaWJRTw0PTzbxzBhtrkW35Ux9YThpVq8hrvPLe9PS9642okJeizt9hEGFh/ooBPFsMnBafdqY+MfLNJdeyCBtDi9JQTZcPuo2j2SrZjj2hNo8flX5b+wpK4w9iq0K7fwwk6cWrDJbe1fBznNq97hRkABXnA1qnuDivyS3JNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=SMY4Yegt; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202508231722164a103216ba24c0db9e
        for <linux-efi@vger.kernel.org>;
        Sat, 23 Aug 2025 19:22:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Tl6xER2al/6x47nOnSNWJ84gPoGmVSCZrLj9P6OG5EU=;
 b=SMY4YegtNf1twKWb9XXxXYYPnZQ4R/L5pghEdlhh3BMwoIyH3Kc109SmkSyKjbci9/8UbG
 7xcKL1xHeX0DXstZLvCrlaQrVCZ+PDgpK2Cojoqdoj9cWdMque9J0FjSAgg/4iZYeNjrQUxA
 tkW3qSAQG7/MlaCuLRJhz28CtXgHLek50OGBQgKzZg6n9ercKh9uzMLZ+Oayt194X9X353zI
 nr2bb2J8kAjuhveuk8jDfRJ6ZM/or/MMmzIbrYrRGrBpf2ZeA/+QfX4OPUoNPwkJCAr/Lq8b
 B6Bf7UUMvdUS1gfpc0Mkmu/bN7UHLNhuEtWOr3x+JMv8Lw34xG5KGoYA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v2 2/4] efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
Date: Sat, 23 Aug 2025 19:22:12 +0200
Message-ID: <9c9a688c91140b3a62c753f14b8d1eb1c87c51d7.1755969734.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1755969734.git.jan.kiszka@siemens.com>
References: <cover.1755969734.git.jan.kiszka@siemens.com>
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

When we are low on memory or when the internal API is violated, we
cannot return EFI_OUT_OF_RESOURCES. According to the UEFI standard, that
error code is either related to persistent storage used for the variable
or even not foreseen as possible error (GetVariable e.g.). Use the not
fully accurate but compliant error code EFI_DEVICE_ERROR in those cases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index e15d11ed165e..8501056ade8a 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -218,7 +218,7 @@ static efi_status_t get_max_payload(size_t *size)
 				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
 				   &ret);
 	if (!var_payload)
-		return EFI_OUT_OF_RESOURCES;
+		return EFI_DEVICE_ERROR;
 
 	ret = mm_communicate(comm_buf, payload_size);
 	if (ret != EFI_SUCCESS)
@@ -264,7 +264,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 		&comm_buf, payload_size,
 		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
 	if (!smm_property)
-		return EFI_OUT_OF_RESOURCES;
+		return EFI_DEVICE_ERROR;
 
 	memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
 	smm_property->name_size = name_size;
@@ -320,7 +320,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	var_acc = setup_mm_hdr(&comm_buf, payload_size,
 			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
 	if (!var_acc)
-		return EFI_OUT_OF_RESOURCES;
+		return EFI_DEVICE_ERROR;
 
 	/* Fill in contents */
 	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
@@ -386,7 +386,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
 				   &ret);
 	if (!var_getnext)
-		return EFI_OUT_OF_RESOURCES;
+		return EFI_DEVICE_ERROR;
 
 	/* Fill in contents */
 	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
@@ -442,7 +442,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	var_acc = setup_mm_hdr(&comm_buf, payload_size,
 			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
 	if (!var_acc)
-		return EFI_OUT_OF_RESOURCES;
+		return EFI_DEVICE_ERROR;
 
 	/*
 	 * The API has the ability to override RO flags. If no RO check was
@@ -498,7 +498,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
 				&ret);
 	if (!mm_query_info)
-		return EFI_OUT_OF_RESOURCES;
+		return EFI_DEVICE_ERROR;
 
 	mm_query_info->attr = attributes;
 	ret = mm_communicate(comm_buf, payload_size);
-- 
2.43.0


