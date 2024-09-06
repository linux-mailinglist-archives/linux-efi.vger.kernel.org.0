Return-Path: <linux-efi+bounces-1672-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A396FCB9
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE07FB219A7
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475C1DC1AF;
	Fri,  6 Sep 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BrTOkalO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A31DA0F5
	for <linux-efi@vger.kernel.org>; Fri,  6 Sep 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654504; cv=none; b=uKPlrt/2B/BNgit9L4MkLuCtQSc2BPMaedTxihwAmsjgO0PZqcuVpcCLr2xaD/Tr6u7Mtsn5qpLMowTiLPdkD7DC9cxibM/c8ZqovF1xvmp84Dj0lZyqrZxvYQUx2ZJWXsXfOF8TyGfPb6gaisdNIO2s/cMsPNHRDoAL5HnEcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654504; c=relaxed/simple;
	bh=XE1DPqvy7FxpeqLadro2KUo9m1LL/0BkzBaHwilluhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv1jfCag0+9mChQ0mTNNOpf6lUT9SvGmdANIhmfBh3zd8ILzc7ceZJxL8Koo9EIfo0MOIGZCi9qi19CTBmJOj+lFms30USWD8e4SEtJNxRdS30i0ZdYW/YE+dG2KC/ecKYsTy0oO40BnlR4Glh3ni8DL6ex7doL3RdbDn+UKf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BrTOkalO; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-709346604a7so1641238a34.1
        for <linux-efi@vger.kernel.org>; Fri, 06 Sep 2024 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654502; x=1726259302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A02dTNZID78REVwXn2oyGTRvfad558GuxUE/iRRivQs=;
        b=BrTOkalOYwCzXgg/P9ZUP2Y3J5R27P5nH4Dg1UtHYqvwv5cyLcfaTTEIPM693NIMMk
         CyLhptdSVIkd+ObCZwtCYSCDZ2yX+WluVazqY/RQlES6IbYL/kC5z5+cX1mG4Mey4BCr
         BPB3xgnXI9ZqlFVdbxsCwavcGDjCA3LJeq8ze0bW6C9I5W4fzsz6JRRc2E+ky2JkaCJz
         kE4uDLEvgUBIxp7e81sk7vM1ZRnqIeNoHOfWX5aE0EuoElsnYwf/tDPUQTueSs7nZ2JT
         9tf139+UoxtsCkikLTLjAlWVOyTeTBY3mAukNIQ+YfWqTeba/J/E4c5/nSHnQf+Wbx99
         elpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654502; x=1726259302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A02dTNZID78REVwXn2oyGTRvfad558GuxUE/iRRivQs=;
        b=de8rzod4DWJIRMdCf6LtpS46mL112nuUbxXFQ9qcKxgN5FT6l1G3ysmxgYeTc0S3kG
         MYZnAqqsOyu1yDmCX+Nlim+gOzrHCmbsNLiLQkYZH+C2NsZHaDS1NOAFnlZ6OkeCShNk
         sfYzO1/hzcqzi1LoCPAzWqHT7LjrCIkAwa0WRw/hCpfP2ph+dHVAbLnxwIMNVxWA5wyo
         JDQK6aLJIAKKrxeb5iJAeEYRzG3bw8BW8GLTBXtsrhcolvePSCBXLEDW3Kr5K+f0/GNR
         vwExtJW0Sb+p12bPqbItwXJ8LcG4PWMFoa2RtHGofdnQ+VvHFJGNPexk/VCXzUkRX34p
         lRoQ==
X-Gm-Message-State: AOJu0YxqyGINDKbF1X23HQkZbgmLDvXUj6KXKQl7CjUYAnP1wrxCPrr1
	CXKdf4Fa6bkJS+RUkTuI6Bm8a3C/mKZ4guoNUbGTUAdGGlHSBAjfDpgmURseqGEwNi/GAuXuKJd
	D
X-Google-Smtp-Source: AGHT+IHMKBTOuPM+P+e6Ggmk8kf5Wxmw6zLzgTDlsCLWT0LO88jBX8ugAR5TeZND93bpHJwoa1Ix3w==
X-Received: by 2002:a05:6359:4127:b0:1b8:34a3:11b7 with SMTP id e5c5f4694b2df-1b8386e6514mr427253555d.22.1725654501791;
        Fri, 06 Sep 2024 13:28:21 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:21 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 2/6] tpm: do not ignore memblock_reserve return value
Date: Fri,  6 Sep 2024 16:27:41 -0400
Message-ID: <20240906202745.11159-3-gourry@gourry.net>
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

tpm code currently ignores a relevant failure case silently.
Add an error to make this failure non-silent.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/tpm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 9c3613e6af15..6e03eed0dc6f 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	memblock_reserve(efi.tpm_log, tbl_size);
+	if (memblock_reserve(efi.tpm_log, tbl_size)) {
+		pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
+		       efi.tpm_log, tbl_size);
+		goto out;
+	}
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
-- 
2.43.0


