Return-Path: <linux-efi+bounces-4607-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44732B346BC
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1D2A0E29
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF892299924;
	Mon, 25 Aug 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="R2QDwQu8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFD2FF64F
	for <linux-efi@vger.kernel.org>; Mon, 25 Aug 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138045; cv=none; b=GRmhmqGjCGJhbIjru2GUx+Ony+hqmsYElEC+/FRSLVGvjmj6Xa7guVwssvGuMYD/wkgEAODpzMTJeeHLkxYZHGDOjwfgUpp72gBB9I3TZAwN0XKkuRFejhR3jLSyky21jzJzN//XMW7XY7MucIlusLgmLOFR4aJm06mwVb5pQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138045; c=relaxed/simple;
	bh=kpzwl5IixJTTR7SL4KsQpvxb2UynofWpn8JGb06Evqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6G40Ltd4W9DJI4asgrLMbU3WfCSyWMrCeZnRQx02+9mCN3zUQnGnHZ/7d9uWOsOm6Uc4Qts/QBSZ2wkkcN/xZ5DkAbgHUd+Q7L5YsrL/et/NNSBIKOHok33WmL9gfrKqltRBuGtW7TjxYUuEoY4g2DJKSgNP6L2VhiPioq/RRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=R2QDwQu8; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250825160714a69799e963fd20f1dc
        for <linux-efi@vger.kernel.org>;
        Mon, 25 Aug 2025 18:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rYRCF2IHsVpvuY/p1tdPnQYMO1M8HGQtME3DH/UxGlw=;
 b=R2QDwQu8GqUnA/IRd22zMQvb4DYZA77YDsUuZly3GymMQdYOwHQzKSx8cAgsDdbhJp4wD7
 OM1Qxekm34fRKYeHcHjj49EP3MVKnW5SRVC/kadASQi/7PhL32itEoLJCbORUbnWKi/kXqEa
 t7hUpB8Mzjx2XpNC0C5JIi2nlP8PKUtKRL+YU+UyL/aI0aKFTGelxPiJB/7tQR1CPpa5U9Sg
 ulmOxxRmOEmzUpxBUfc93Ihl6akmWNeLrMdZoGNZMHD0pCsaqtB+ICUpMD871quu7HEsjzi6
 nPhlsxzBnbFwPvmDM0sJ7B2feGQLX48psd8v3rFwHaV6EkgfS6HqIOlg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v3 3/4] efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
Date: Mon, 25 Aug 2025 18:07:12 +0200
Message-ID: <f9d52ab7e41c221c0a7201a2108d16a8464cbc53.1756138033.git.jan.kiszka@siemens.com>
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

No caller ever evaluates what we return in 'ret'. They only use the
return code of the function.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 25 ++++++++----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index 8501056ade8a..c2bc8467b099 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -154,11 +154,9 @@ static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
  * @dptr:		pointer address to store allocated buffer
  * @payload_size:	payload size
  * @func:		standAloneMM function number
- * @ret:		EFI return code
  * Return:		pointer to corresponding StandAloneMM function buffer or NULL
  */
-static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
-			  efi_status_t *ret)
+static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func)
 {
 	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
 	struct efi_mm_communicate_header *mm_hdr;
@@ -173,16 +171,13 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
 	if (max_buffer_size &&
 	    max_buffer_size < (MM_COMMUNICATE_HEADER_SIZE +
 			       MM_VARIABLE_COMMUNICATE_SIZE + payload_size)) {
-		*ret = EFI_INVALID_PARAMETER;
 		return NULL;
 	}
 
 	comm_buf = alloc_pages_exact(COMM_BUF_SIZE(payload_size),
 				     GFP_KERNEL | __GFP_ZERO);
-	if (!comm_buf) {
-		*ret = EFI_OUT_OF_RESOURCES;
+	if (!comm_buf)
 		return NULL;
-	}
 
 	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
 	memcpy(&mm_hdr->header_guid, &mm_var_guid, sizeof(mm_hdr->header_guid));
@@ -192,7 +187,6 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
 	var_hdr->function = func;
 	if (dptr)
 		*dptr = comm_buf;
-	*ret = EFI_SUCCESS;
 
 	return var_hdr->data;
 }
@@ -215,8 +209,7 @@ static efi_status_t get_max_payload(size_t *size)
 
 	payload_size = sizeof(*var_payload);
 	var_payload = setup_mm_hdr(&comm_buf, payload_size,
-				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
-				   &ret);
+				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE);
 	if (!var_payload)
 		return EFI_DEVICE_ERROR;
 
@@ -262,7 +255,7 @@ static efi_status_t get_property_int(u16 *name, size_t name_size,
 
 	smm_property = setup_mm_hdr(
 		&comm_buf, payload_size,
-		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
+		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET);
 	if (!smm_property)
 		return EFI_DEVICE_ERROR;
 
@@ -318,7 +311,7 @@ static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
 
 	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
 	var_acc = setup_mm_hdr(&comm_buf, payload_size,
-			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
+			       SMM_VARIABLE_FUNCTION_GET_VARIABLE);
 	if (!var_acc)
 		return EFI_DEVICE_ERROR;
 
@@ -383,8 +376,7 @@ static efi_status_t tee_get_next_variable(unsigned long *name_size,
 
 	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
 	var_getnext = setup_mm_hdr(&comm_buf, payload_size,
-				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
-				   &ret);
+				SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME);
 	if (!var_getnext)
 		return EFI_DEVICE_ERROR;
 
@@ -440,7 +432,7 @@ static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	 * the properties, if the allocation fails
 	 */
 	var_acc = setup_mm_hdr(&comm_buf, payload_size,
-			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
+			       SMM_VARIABLE_FUNCTION_SET_VARIABLE);
 	if (!var_acc)
 		return EFI_DEVICE_ERROR;
 
@@ -495,8 +487,7 @@ static efi_status_t tee_query_variable_info(u32 attributes,
 
 	payload_size = sizeof(*mm_query_info);
 	mm_query_info = setup_mm_hdr(&comm_buf, payload_size,
-				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
-				&ret);
+				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO);
 	if (!mm_query_info)
 		return EFI_DEVICE_ERROR;
 
-- 
2.43.0


