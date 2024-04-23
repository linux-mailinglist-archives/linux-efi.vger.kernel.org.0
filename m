Return-Path: <linux-efi+bounces-965-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226038AE851
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60C51F24E26
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA962136655;
	Tue, 23 Apr 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OB7MF+1r"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDF18E28;
	Tue, 23 Apr 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879445; cv=none; b=Nk/+eIZj65NO31IqTiMbLb/pWQVZcmD0w/gEE6tFl9axJGnoyaKftHYs/Q3GliJojMD/LX2kMp+IAqxin8ubcmpCiHZJajDcYOsHVwVeYLHFFezcXm0MGSBav/7cJvTucyr6rdEj2lZ2NmU3UCWMjkQoahRvGso0dDxj5t94i0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879445; c=relaxed/simple;
	bh=dsVKS75rk/XJ1PdxuK8KFQuKjzQDb/YS3gKI282VATA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIcPlJaTuecphgYN33QcYIgn8yLTZ7z22gKdg6IhqcAuH8q12FvZ5bpbB483uWUG8j3SyORb5AQvevpvSYB3YLIsDPdVbMc7coZ6wnegUk9DwAuOHD6e3xkJ2XOpJxaJJf0vgNBau2RsuHtWOmdvQJF5LbAX4LGuqMYAAGpCLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OB7MF+1r; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713879444; x=1745415444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QNgZ08cu6G7jRe5L0bfia3hVc4v0QPDb5H9DVfDn474=;
  b=OB7MF+1rpTQrSRAlt1oqA8CN5W/fG10eNUQSGUKmC6zJSs8MMcaafpdu
   iwvUMLE38w3SfmlXSBXTttfvQaGwmxj460GFnzoW5K5GIkkokQo2G66yj
   IGu0h099DXeHcncMlF6M7lth5Q1Yl21vRF1iSqyctbp7VqfNFcuN/qRTx
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="391891265"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:37:21 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:14814]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.110:2525] with esmtp (Farcaster)
 id 99e54c7e-3d8e-4df9-a177-c498b08e7836; Tue, 23 Apr 2024 13:37:20 +0000 (UTC)
X-Farcaster-Flow-ID: 99e54c7e-3d8e-4df9-a177-c498b08e7836
Received: from EX19D002EUC001.ant.amazon.com (10.252.51.219) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 13:37:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002EUC001.ant.amazon.com (10.252.51.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 13:37:19 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 23 Apr 2024 13:37:19
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id BCAB820D4A; Tue, 23 Apr 2024 13:37:18 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Pratyush Yadav <ptyadav@amazon.de>,
	Norbert Manthey <nmanthey@amazon.de>, <stable@vger.kernel.org>, Hagar Hemdan
	<hagarhem@amazon.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] efi: libstub: only free priv.runtime_map when allocated
Date: Tue, 23 Apr 2024 13:36:33 +0000
Message-ID: <20240423133635.19679-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

priv.runtime_map is only allocated when efi_novamap is not set.
Otherwise, it is an uninitialized value.
In the error path, it is freed unconditionally.
Avoid passing an uninitialized value to free_pool.
Free priv.runtime_map only when it was allocated.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: f80d26043af9 ("efi: libstub: avoid efi_get_memory_map() for allocating the virt map")
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 drivers/firmware/efi/libstub/fdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 70e9789ff9de..6a337f1f8787 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -335,8 +335,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 fail:
 	efi_free(fdt_size, fdt_addr);
-
-	efi_bs_call(free_pool, priv.runtime_map);
+	if (!efi_novamap)
+		efi_bs_call(free_pool, priv.runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
-- 
2.40.1


