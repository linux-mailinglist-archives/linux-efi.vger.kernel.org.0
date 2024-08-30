Return-Path: <linux-efi+bounces-1629-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948DF9662CE
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E94F1F248D8
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA81A4AC6;
	Fri, 30 Aug 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oorTNiYu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE9199958
	for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024208; cv=none; b=eYNkkqcwvG8dwtM0UgHm0mAPDzGjW5YoSXnhHs//Pfbg1Fh8fm2kKBidrQDUATCXZhzwTR/fdfbTeP+eqrNXjlb1AKb/5EoLPSXGNJtnsENTGKTxlvaEhAORHrOOhDj5zPlkZ/I4MU9QPMA12pB7OwUUSwE6OSefAsbxNWMLWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024208; c=relaxed/simple;
	bh=uC7TJ50a7SgbOtivAxR2KdbHsbIyQdSdr5oMF9F4ufo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtobL1O9xIoEVOlC4FXdkSCp3lTuXbPUJCw7o1fRB8HeFGwUZWqQNO2BWY3YttXUhwoSxqOVCYMaQkHj94tjBI2jahkCsevcrLpQObA0BTGjhqV9To+xq1uEkTpWbgSMi+fHZnsjlnHFgfwQj9mbnaLHarkUJOqhHONJkCk4nrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oorTNiYu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf784346b9so9445056d6.2
        for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725024205; x=1725629005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=oorTNiYuGNhFL9Y7VJkaRNOm3XT8kOQEVC9nX/CRZi1poSetkpwXiIyEo/efFb5xB1
         ZFIUDsNvh8kOVvuK215k5KK3zXsn5qAf4Tj0jCCVX0CLxSiCgn4l3/Na8YUgjFP+xxuo
         kMEuEB46TZeISpOBEWqQyAZlRsjkfrmKr75l7/UV/2H9BT6yGW/6ey5DXZXTQbVi1v7X
         YYLrsxI3tlTFk+4boLnbVPji/RHH0dTkXhXwLxxcJUAx14+3GaCp9I/5Xd5A2MWbCqnF
         ovKGFm+tzmy4/R6msOOsc7FRjHznr7TEd49xXaL3HciWfNT57pG/jdnQJNkGoT/Ca3BR
         h27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024205; x=1725629005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=FphoAOqqBjeJnnR1mJ2DXKyD7S7pzQbdd4bddlqZd6IdRAMmi+Q+uZNwAIyFN0kArY
         WO9Aq84vd29ymRHUKKgUpSxklLHgjj13GVFG15DEX7HtEwXH+kOrphRnUv3pJG8O1Uix
         camzgSCarDj4HQyEpQCyUQn3NpwRCfC8GRFMHVQ1AsGAh7+Z59J+4HOg2dMkfTh5/ebc
         53guD1v83Vc5BoBgGJPy/SY3E9Bh7Y4uKOfnQxgMWJUCyKBbcTQYG1ZeSbiFdhn9MDzD
         7+3LEHBe2DfT/lgYxBhWPM+nEQYu+kLlQVXp83tyIPCD7kG+/1Q6FG3kxUokuCKA08BO
         1Uhw==
X-Gm-Message-State: AOJu0Yy71a3Wt+GwZK7UgB+40QXZEtJMn6MIoCftYfo6VBSdWhpmetmU
	u2Qrrbg+bpUT3gLiUMCfl1HWsxL46rbsLXCcrnOM4HPijezSfQ90IHAHsyNU23Dh2gA1SyIuS2G
	G
X-Google-Smtp-Source: AGHT+IEaHzqpl+MfONWBBo0IgtdlqdbyXHEhBLLGj8STXZ84uU3YBrXit/beXiQpld7iZ1pl/95sbQ==
X-Received: by 2002:a05:6214:590b:b0:6c3:515c:fedd with SMTP id 6a1803df08f44-6c3515d0180mr9494836d6.34.1725024205363;
        Fri, 30 Aug 2024 06:23:25 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c44619sm14485066d6.74.2024.08.30.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:23:24 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org
Subject: [PATCH 1/2] tpm: fix signed/unsigned bug when checking event logs
Date: Fri, 30 Aug 2024 09:23:02 -0400
Message-ID: <20240830132303.6665-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
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


