Return-Path: <linux-efi+bounces-4563-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E42B28652
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4253B87C1
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D7292B38;
	Fri, 15 Aug 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="IPSf+y9d"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170B220F22
	for <linux-efi@vger.kernel.org>; Fri, 15 Aug 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285777; cv=none; b=pICwt2ChDQ92hUcP6cWs9G1c6EW6+6+UigeQiD8AUve8380Ac6vAM1NR1en6E/CgQKJKnCSU7pFH74lKXmZciUP1wubmWzOyAD3heKTELrMtpxI//5kTTrdqpNsSoA91rdVtghKe0OrMlM8HIqkCD3fTXG70H0iviaQFnNnCQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285777; c=relaxed/simple;
	bh=WzGu0vkiWxurZhjxNWxXiL8wXMkA0Krs3vEf+B93y/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZj0E3a26evN3H6XoooUHfYDuHwScUxiPYwAVOvTxjq53cDgqU7PdjUhAAFPIR/hzV1LKGBMDnLGzfjli/hJrv9CuhIdMBZGlA6cm75YWe1rm3tSoDryHEqbOiaMPVtpIDqzRaSqvgBExkx6AnTKupMB+PW3LFZX/nVui4hH/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=IPSf+y9d; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250815191242a2c8a49a727c7c4ae3
        for <linux-efi@vger.kernel.org>;
        Fri, 15 Aug 2025 21:12:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zAcR7qNUqu2BVY+5qNzpxP47Zaao6Yqb3FymgBZ/xr0=;
 b=IPSf+y9dTc573fZiVeJ4w3qo0pkWfTVD0xdMnLP6qifHIwVaL33swWDl5JMxXa6O32RoTN
 XJs4OoGTXUa7JMV/mOvqC/dmw30bEsW/mXqSaIDIeDHUuCt3QdFJCPqvOZNs8UYroPwufu2P
 kSX1gpYipxutw5yqQrKM4+yyUs7CauLMDA1tZqaNhC0A5+ieiE5dcw6Kcg6KlYRRBzJ0TuXT
 zv2+CG+5tcTL3HGyxN5HdvgGFYkOuNqQje7/7xK0qUI7eA9XYPfZvBcha+YMSLB1q2C+l1PL
 t0dex2/YLj6p1FAiySYSPSzgxA0p8Iw2++fV8Yrg1IgBIumzvdDpAsAw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/3] efi: stmm: Fix incorrect buffer allocation method
Date: Fri, 15 Aug 2025 21:12:39 +0200
Message-ID: <37ba67b97d55c49a7c6a1597f104b30b31a4a395.1755285161.git.jan.kiszka@siemens.com>
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

The communication buffer allocated by setup_mm_hdr is later on passed to
tee_shm_register_kernel_buf. The latter expects those buffers to be
contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
was broken before as well.

Fix this by using alloc_pages_exact instead of kmalloc.

Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 44 +++++++++++++++---------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index f741ca279052..706ba095a4ba 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -148,13 +148,14 @@ static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
  *			header data.
  *
  * @dptr:		pointer address to store allocated buffer
+ * @nr_pages:		pointer address to store number of allocated pages
  * @payload_size:	payload size
  * @func:		standAloneMM function number
  * @ret:		EFI return code
  * Return:		pointer to corresponding StandAloneMM function buffer or NULL
  */
-static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
-			  efi_status_t *ret)
+static void *setup_mm_hdr(u8 **dptr, size_t *nr_pages, size_t payload_size,
+			  size_t func, efi_status_t *ret)
 {
 	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
 	struct efi_mm_communicate_header *mm_hdr;
@@ -173,9 +174,12 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
 		return NULL;
 	}
 
-	comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
-				   MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
-			   GFP_KERNEL);
+	*nr_pages = roundup(MM_COMMUNICATE_HEADER_SIZE +
+			    MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
+			    PAGE_SIZE) / PAGE_SIZE;
+
+	comm_buf = alloc_pages_exact(*nr_pages * PAGE_SIZE,
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!comm_buf) {
 		*ret = EFI_OUT_OF_RESOURCES;
 		return NULL;
@@ -205,13 +209,14 @@ static efi_status_t get_max_payload(size_t *size)
 	struct smm_variable_payload_size *var_payload = NULL;
 	size_t payload_size;
 	u8 *comm_buf = NULL;
+	size_t nr_pages;
 	efi_status_t ret;
 
 	if (!size)
 		return EFI_INVALID_PARAMETER;
 
 	payload_size = sizeof(*var_payload);
-	var_payload = setup_mm_hdr(&comm_buf, payload_size,
+	var_payload = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
 				   &ret);
 	if (!var_payload)
@@ -239,7 +244,7 @@ static efi_status_t get_max_payload(size_t *size)
 	 */
 	*size -= 2;
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, nr_pages * PAGE_SIZE);
 	return ret;
 }
 
@@ -250,6 +255,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 	struct smm_variable_var_check_property *smm_property;
 	size_t payload_size;
 	u8 *comm_buf = NULL;
+	size_t nr_pages;
 	efi_status_t ret;
 
 	memset(var_property, 0, sizeof(*var_property));
@@ -258,7 +264,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 		return EFI_INVALID_PARAMETER;
 
 	smm_property = setup_mm_hdr(
-		&comm_buf, payload_size,
+		&comm_buf, &nr_pages, payload_size,
 		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
 	if (!smm_property)
 		return EFI_OUT_OF_RESOURCES;
@@ -282,7 +288,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 	memcpy(var_property, &smm_property->property, sizeof(*var_property));
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, nr_pages * PAGE_SIZE);
 	return ret;
 }
 
@@ -296,6 +302,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	size_t name_size;
 	size_t tmp_dsize;
 	u8 *comm_buf = NULL;
+	size_t nr_pages;
 	efi_status_t ret;
 
 	if (!name || !vendor || !data_size)
@@ -314,7 +321,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	}
 
 	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
-	var_acc = setup_mm_hdr(&comm_buf, payload_size,
+	var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
 	if (!var_acc)
 		return EFI_OUT_OF_RESOURCES;
@@ -347,7 +354,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 	memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
 	       var_acc->data_size);
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, nr_pages * PAGE_SIZE);
 	return ret;
 }
 
@@ -359,6 +366,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 	size_t out_name_size;
 	size_t in_name_size;
 	u8 *comm_buf = NULL;
+	size_t nr_pages;
 	efi_status_t ret;
 
 	if (!name_size || !name || !guid)
@@ -379,7 +387,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 			max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
 
 	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
-	var_getnext = setup_mm_hdr(&comm_buf, payload_size,
+	var_getnext = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
 				   &ret);
 	if (!var_getnext)
@@ -404,7 +412,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 	memcpy(name, var_getnext->name, var_getnext->name_size);
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, nr_pages * PAGE_SIZE);
 	return ret;
 }
 
@@ -418,6 +426,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	size_t payload_size;
 	size_t name_size;
 	u8 *comm_buf = NULL;
+	size_t nr_pages;
 
 	if (!name || name[0] == 0 || !vendor)
 		return EFI_INVALID_PARAMETER;
@@ -436,7 +445,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	 * so we won't need to account for any failures in reading/setting
 	 * the properties, if the allocation fails
 	 */
-	var_acc = setup_mm_hdr(&comm_buf, payload_size,
+	var_acc = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
 	if (!var_acc)
 		return EFI_OUT_OF_RESOURCES;
@@ -467,7 +476,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	ret = mm_communicate(comm_buf, payload_size);
 	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, nr_pages * PAGE_SIZE);
 	return ret;
 }
 
@@ -489,9 +498,10 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 	size_t payload_size;
 	efi_status_t ret;
 	u8 *comm_buf;
+	size_t nr_pages;
 
 	payload_size = sizeof(*mm_query_info);
-	mm_query_info = setup_mm_hdr(&comm_buf, payload_size,
+	mm_query_info = setup_mm_hdr(&comm_buf, &nr_pages, payload_size,
 				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
 				&ret);
 	if (!mm_query_info)
@@ -507,7 +517,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 	*max_variable_size = mm_query_info->max_variable_size;
 
 out:
-	kfree(comm_buf);
+	free_pages_exact(comm_buf, nr_pages * PAGE_SIZE);
 	return ret;
 }
 
-- 
2.43.0


