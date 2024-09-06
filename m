Return-Path: <linux-efi+bounces-1671-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5F96FCB5
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 22:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7FE28284F
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 20:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A51DA0F8;
	Fri,  6 Sep 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I3gKFhm5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75421D9346
	for <linux-efi@vger.kernel.org>; Fri,  6 Sep 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654503; cv=none; b=Mn7aM53vnWfKhxp0CJvLZ5bGVLHJ94OPW1v5Zfa99fiz3kbluOxeuvChg+iBpUJGY1ddBH7ps+SBGGWaT8z21S9D4NELQCUl6XNFTYEV1FAQtNQNuyiN83OeoNFra7Z9XBffB/pKwLmJWduNgI329TdHCpdkYF+NUA9wxNw93sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654503; c=relaxed/simple;
	bh=uC7TJ50a7SgbOtivAxR2KdbHsbIyQdSdr5oMF9F4ufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAsiG7Ft/8GmpqK4+RagonzUcM4LqipjiWnUlDJGVMBBd1ylUAtlwq1HlDo+Ldq4RDHJEeGH76+RKl5nBreVJGvuAlBliUbPIDVDQ76aP73ALMZWYyi/zSk66q25q48fi2Gwd1rqjufY4DfH9fc3346J5kuu6PGYqANukRw7ctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I3gKFhm5; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7091558067eso1204041a34.3
        for <linux-efi@vger.kernel.org>; Fri, 06 Sep 2024 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654500; x=1726259300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=I3gKFhm5poPQY0pwuhl7vAyW67hzQUyzMkUvGay9jbQSmWV9BQ2qZN8yORh0XmZDzQ
         L6yW4ngmZoI6YgWZuoJtuDC1FhkBnql2CHhf1Z8kiz2KC2/GdywdKO/ogxDDRzN0lF2S
         I/eelgLan7ZqXwVQUhk7Aucd4Tcj+u/qC+TsKsE8qmtlrdmqDs3gfrl7db/60mwcMzmf
         LiHCZ8lP98U58CNBDdHfAO8GHUUTW+bOm638DbS1Sp/jfm1YTB3hsZRzYbCp2EcHS5qi
         IxMJ6s6onnHNTpTje9PfNyC4SztHTFmo8XYv2wh/Jjn3Uk43DcGE1YpIC9c/YO8cgBYs
         PFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654500; x=1726259300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=hyApJfO49O2ubLyPR23toRiBiOSHUkSv+bzJORXqjZJ+ctE5qgQd9U6RomPwAw5TSj
         s6YEwYf00b2KgouspGmj9FogZD3xtTi0x8EhyOdtL4UqDcYjotxjR13A8ju69Zyjkb2Z
         UDCi6574heqNDr0raJLwLIF53NuqHBuMa2dM2ErvTpxRaK1u+TZgiTcDJDCS5dUBIQLB
         5W9fRYMU0GHVmCwogMLVtCRQ0Ai+2+w099GTeAXlSG1rcJf3rwOs4zepk+bOh5Ns8VXx
         d58xxxXcYSok6jvMUGinPsghzAtAh6NWjgpyErTSyNwYCTORKd/PyVrBt2xk1tkxjYfZ
         YINg==
X-Gm-Message-State: AOJu0YwtIVVd7W7Dn7+vrS/w/hV6rm8YGyCaAoSXuZ/hweSI8G++cd06
	WS0Bda85TVzj3E+SZQIIkjxWsn+d3wokEIuWkHkJURBkfKKlWgfT06/i9DIRDvU87RUnEX5ftKE
	f
X-Google-Smtp-Source: AGHT+IFO7jNN/yEMP1rct1brqJ1OGNYSIYnkQ9smer8q7MIF6gg13nZKOcCXv8KpSEcVOt58+tzpXg==
X-Received: by 2002:a05:6870:35d5:b0:277:fd73:8f82 with SMTP id 586e51a60fabf-27b9dcc3a29mr557037fac.45.1725654500499;
        Fri, 06 Sep 2024 13:28:20 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:20 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 1/6] tpm: fix signed/unsigned bug when checking event logs
Date: Fri,  6 Sep 2024 16:27:40 -0400
Message-ID: <20240906202745.11159-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906202745.11159-1-gourry@gourry.net>
References: <20240906202745.11159-1-gourry@gourry.net>
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


