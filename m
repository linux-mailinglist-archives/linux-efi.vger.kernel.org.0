Return-Path: <linux-efi+bounces-966-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C98AE8F3
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F5B25693
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C377136E38;
	Tue, 23 Apr 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BRfXEkci"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EC136E16;
	Tue, 23 Apr 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880806; cv=none; b=d7xgEuASdrduwmmVkmTj4pFl19TnLxpux7VpaxpNEJK4oDbh2v5Ns5ZMN1ZUdwFShR0IRkdeT8r1bGj7zwxE8ZdnbnL+VV5xkLqQPPW4+TvFJE/s9kxSf+6EyVCynMa5vY9BRoMh5LLEy3NcnzPb/g8Zgz5gAg/kNfJ07u9yn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880806; c=relaxed/simple;
	bh=PzEyPm3uFppccDqRRPZJsBGGE8BDKJ5eSFXRs0iXUsg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dtj9TAePa88UMZ19BkqAe9xwZt0cmsrcJDdt6gN6Ogy8JsEq/s5TnbDpLidQaoZqf2iJwx9rWCkaVnXw4Bhk8HOiEwY/nwZn+GGYRLwtZa5RYGVYnvThXge2RC8vkMR8rHEtMcrgT4qs2vym9u1V2SgTwuePYiTZ1LlGi0xvqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BRfXEkci; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713880805; x=1745416805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SyeTuxtsDsOQH6Q0op2IkDaUc7NS6Cg+L/o0qZ8cwsI=;
  b=BRfXEkcihaww6gtGRCMcy5W9z9NWwpa5WpHBCWdoxYHlO4kVrIQujAIQ
   t97+OMBdWEzTN+OQk24ZaiEo/KF2iDRBLV4CfaGOpI0z2p4khZ26TGLy7
   WyQz5xZFRO4azGbRJKVhKYPMEOzV+p6BzOdPT6Jc17GxDj8sXqWoD+YlE
   E=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="414050955"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:59:58 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:20810]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.96:2525] with esmtp (Farcaster)
 id c93c9285-09b3-43d0-9b46-423906eadf23; Tue, 23 Apr 2024 13:59:57 +0000 (UTC)
X-Farcaster-Flow-ID: c93c9285-09b3-43d0-9b46-423906eadf23
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 13:59:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 13:59:56 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 23 Apr 2024 13:59:56
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id BF09A20D4A; Tue, 23 Apr 2024 13:59:55 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Pratyush Yadav <ptyadav@amazon.de>,
	Norbert Manthey <nmanthey@amazon.de>, Hagar Hemdan <hagarhem@amazon.com>,
	<stable@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] efi: libstub: only free priv.runtime_map when allocated
Date: Tue, 23 Apr 2024 13:59:26 +0000
Message-ID: <20240423135928.1200-1-hagarhem@amazon.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
v2: added Cc stable tag to the commit message as requested by kernel
test robot.
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


