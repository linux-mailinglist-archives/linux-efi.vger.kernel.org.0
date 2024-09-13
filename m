Return-Path: <linux-efi+bounces-1773-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BF978BC9
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 01:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BF7B255FE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0659186E48;
	Fri, 13 Sep 2024 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GZvzxVyY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316551714C6
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269645; cv=none; b=Y5tDqLaHs+B/KVxU/O1VO/l15SVpG4Gtx8rkETMH8tN33t/yhJuFfifwweM/PiJhGnUoDQyZG8dQC9+dRgbEYzD7BzVz8p/NL9WBAltpD2pLaR7lHP4UZRhWvfo/YGO4q3o5KLqJpRvrMov9cuLn5LhboXZQyrzduaIsvCAcZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269645; c=relaxed/simple;
	bh=uC7TJ50a7SgbOtivAxR2KdbHsbIyQdSdr5oMF9F4ufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWWRuxOYKu477rNsauaYr7xxk8zTbssD9BYeayB7v2pPYSya4uhAqekyNu+h8ZCaZMUC63Ikc4hWXK4Rla92MXWBo8u4cvMU/+BZo1SIHzYqpjVPh5RQodx+bNRBV8Qxq+DLeS2yU0XfhSZ+2+JS2kPXnsxonWcwkchz59OT9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GZvzxVyY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4581e0ed0f2so30928311cf.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726269642; x=1726874442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=GZvzxVyYJXhxL5uhKbC4ps8nFJjYktP+SieYEpMXdAGofqEfy2y7pPRlXWnbu7lFbJ
         xZ7QRWQNe/RMeYES2A9XjgNUWmkjv7KiBFLp0qtXxEnfIcRNAV3jek5iSxIYLxdfK7YK
         hn40XYogjjCMch9KFraj/wJwYvwszGT9vFOSV8rZaGDrvo/1yzX3pdFJq7SwhntR5Xzh
         MmLGJshLfNi8vMfQcn+n3bL6wkI4i9WlHNrGyq59y843OPXdhXWlAMUr43L8spiwh6cI
         LI6ltVCT0uvBGXswcTU4KEcRUZPz5ZEN06iQeZXSgYoGrRPWmEAiXswsSKbBiG1Y2Hi/
         F+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269642; x=1726874442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=YrWJWyShhD7vjtnYR2w+u8seaAgJtJ515chgu39u5JAsWngHrRUMzC0lUWuLx4Zx0m
         zhBtyX9YLFVG92cZvLWFZUU8VR4IB1O3fbTbYEeI30+mnmoAF63v3ot80aFTZJlfo3k2
         P/VUip1ABr5nFhdnDJ34W9vTPdK2CJcnp0SABBjjuLF0PMD5U6/4cU8eLmZfFu0vWb01
         32x3CyBIlU+pMrd+4L35jk1rXbiFi+d0l5Ye7IcIgEuUtNbGUKr8XTRI/TalKyfdEFE3
         prUVdnykft7b7UpA7ThVJsSUB8paBR67N8se7AHnyXar51ThE+V1kaANWNmZd2AgADLK
         dRmA==
X-Gm-Message-State: AOJu0YwCBrLT0vckvX+yFBgpbkt0tzX2KfBG13jaUDOB/2N7oziSXvcP
	LMc49DubXPLzzdW3P2zYyiutm8DA/5rcSZ5WApPVJ15Pr3yCFv994k7Q5sYHWf0DxiszGDV8liT
	Z
X-Google-Smtp-Source: AGHT+IFp0i6BEsm6qcRfgkhhKwCvAWwpyUz8Me8bMXheogGSHuS5iPPX0ul01QpecBqdsilzODu7fQ==
X-Received: by 2002:a05:622a:418c:b0:44f:f271:af63 with SMTP id d75a77b69052e-4583c7adbcamr268220821cf.21.1726269642488;
        Fri, 13 Sep 2024 16:20:42 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm1245801cf.21.2024.09.13.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:20:42 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH v2 1/4] tpm: fix signed/unsigned bug when checking event logs
Date: Fri, 13 Sep 2024 19:19:51 -0400
Message-ID: <20240913231954.20081-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913231954.20081-1-gourry@gourry.net>
References: <20240913231954.20081-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A prior bugfix that fixes a signed/unsigned error causes
another signed unsigned error.

A situation where log_tbl->size is invalid can cause the
size passed to memblock_reserve to become negative.

log_size from the main event log is an unsigned int, and
the code reduces to the following

u64 value = (int)unsigned_value;

This results in sign extension, and the value sent to
memblock_reserve becomes effectively negative.

Fixes: be59d57f9806 ("efi/tpm: Fix sanity check of unsigned tbl_size being less than zero")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/tpm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index e8d69bd548f3..9c3613e6af15 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -40,7 +40,8 @@ int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct efi_tcg2_final_events_table *final_tbl;
-	int tbl_size;
+	unsigned int tbl_size;
+	int final_tbl_size;
 	int ret = 0;
 
 	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
@@ -80,26 +81,26 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = 0;
+	final_tbl_size = 0;
 	if (final_tbl->nr_events != 0) {
 		void *events = (void *)efi.tpm_final_log
 				+ sizeof(final_tbl->version)
 				+ sizeof(final_tbl->nr_events);
 
-		tbl_size = tpm2_calc_event_log_size(events,
-						    final_tbl->nr_events,
-						    log_tbl->log);
+		final_tbl_size = tpm2_calc_event_log_size(events,
+							  final_tbl->nr_events,
+							  log_tbl->log);
 	}
 
-	if (tbl_size < 0) {
+	if (final_tbl_size < 0) {
 		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
 		ret = -EINVAL;
 		goto out_calc;
 	}
 
 	memblock_reserve(efi.tpm_final_log,
-			 tbl_size + sizeof(*final_tbl));
-	efi_tpm_final_log_size = tbl_size;
+			 final_tbl_size + sizeof(*final_tbl));
+	efi_tpm_final_log_size = final_tbl_size;
 
 out_calc:
 	early_memunmap(final_tbl, sizeof(*final_tbl));
-- 
2.43.0


