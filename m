Return-Path: <linux-efi+bounces-4606-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1DB346BA
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AB9189EB78
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60F3002AA;
	Mon, 25 Aug 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="JWCp6glR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB51299924
	for <linux-efi@vger.kernel.org>; Mon, 25 Aug 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138045; cv=none; b=rzGsHgm8OuAgeoOMweEMoiw136lHAd1quKth8CZxl3eQq+0gRo+C2sSW7MTbr5MmIMuEv0fc7k6iS2J3AnAFadPaL8xAjW3iYzOPXkLVmwIqbVTOIpA18Xx1pNT4OsKhrfXiOj9w3U0EETf3ickHE0D0KkIUVlwGbG6wnm5JBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138045; c=relaxed/simple;
	bh=c3eOEas3QEYLyByLql5S/xo1NiuX9l+/sKHrI1/zTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+9+jzxOo6MBo2se8LH+H6nKsLp71/Ceto1fv2y+QUTBk0pmkDCrnj52V4R7CTHep2SRld17wfDxqhM6mD/DLA9SWlYYQJ7fhNxWFD1xSzjUab2uGoHfSHCAB36MnRZ91dgfUZhvQzZAn4n0miq+jXgWJ2kx00Ahj7vBHunSgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=JWCp6glR; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250825160713801d689c124c47c349
        for <linux-efi@vger.kernel.org>;
        Mon, 25 Aug 2025 18:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AWxW7K0VvnMsb2MfEMdJGSifKobVT6/MtPRHpHEA05g=;
 b=JWCp6glRetjXwFqKLiyy/8ehD1QElfZ5JlGgc9JqKJHnj6bNxDNYE+3j0YMMyjKbe6xAc/
 ZJk1M1oaJDpDr9aw/sHPJRaxc0g9GnbYyxIW3NEJJotv7l0AuGLILRU+vmZk5oxoRIsJn9CK
 Pec5+fKMcEsq3PMgCuFihI9K6ofQVzVLKeHu3yYSTsIzAT6KjQ7Uiigwd49uPkMwplwlbody
 xA1Jo1XwrRAvvvWhrbrIj9Tg6OTbgzif29viJgiCvYbe/LhW1AbIMX0a+zmdz/W7FC7TPE3+
 IJ62R/Bxv5w1tTRFWVKa5+r0yqUWNNETg87MxVztHiQGMRIxsWBOQdtg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v3 2/4] efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
Date: Mon, 25 Aug 2025 18:07:11 +0200
Message-ID: <0a5d3c3df6eff0011d20e364dd63d46a6ce11eaf.1756138033.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756138033.git.jan.kiszka@siemens.com>
References: <cover.1756138033.git.jan.kiszka@siemens.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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


