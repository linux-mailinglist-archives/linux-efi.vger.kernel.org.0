Return-Path: <linux-efi+bounces-2132-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867719C4867
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238FA2880EE
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7D1AC89A;
	Mon, 11 Nov 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bb51wzHW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D338F83;
	Mon, 11 Nov 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361556; cv=none; b=A5Nbs7Gp/h5xdOBgITuSx5mzBVrUCeDvbKje5Si0vBXHpAppDSYxxCXQA0qtMJQuVhFJxtNGD3BqUV+ncHwnnsVuK1mZ7NPkdvyRLosV45BWGQxQdnevVL0Gvyq3gPXmX4P8LlZg49JdVfajh3xXZTyh5UT/6vTCpVfeSfkyfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361556; c=relaxed/simple;
	bh=/QcdVL9/s6BJAFtlQB1eSf6sVXEKx5ReS/QVGGoAkRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/8orrvxhq7BNBvoVXIGqG0LWIPkg9KlxYHZ3kteXOGThKppy8VxAlsoT9RDhvpt94rfo1DVakGIK5HfFAsG//l9+3vhLxOPcNpJmm4pDQ9tS6jiswt6n1BXOjGutOxpnZLZaNHd9lo0iZaNqMtMZCsv1/P0VkxIJB5ZXvkaOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bb51wzHW; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731361555; x=1762897555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+lvJGqbZfbvBaaWJTX53EKmiKD/WU9HXAriXSxhtuk4=;
  b=bb51wzHWdbwTk4v/WBm8jpWmO/riVrMTtrJu0aX0dpSLaPaC7kZBJp01
   14xoAxzl7aSACQuzEURNIq4UbqC/qe1uP/GxLe4EGg/giJzsHZtivJOwb
   /d9qg5OaKZe/3fYpbQESrd+CbZdfLwlOLtv9MMQsN0X7T5W0VLZ4TV88m
   w=;
X-IronPort-AV: E=Sophos;i="6.12,146,1728950400"; 
   d="scan'208";a="384348002"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 21:45:49 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:53463]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.184:2525] with esmtp (Farcaster)
 id 2e9b8229-e7d4-477c-9a5f-375d0e157a4e; Mon, 11 Nov 2024 21:45:47 +0000 (UTC)
X-Farcaster-Flow-ID: 2e9b8229-e7d4-477c-9a5f-375d0e157a4e
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 21:45:47 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 21:45:42 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Sai Praneeth
	<sai.praneeth.prakhya@intel.com>, Matt Fleming <matt@codeblueprint.co.uk>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stanspas@amazon.de>, <nh-open-source@amazon.com>, Nicolas Saenz Julienne
	<nsaenz@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] x86/efi: Apply EFI Memory Attributes after kexec
Date: Mon, 11 Nov 2024 21:45:27 +0000
Message-ID: <20241111214527.18289-1-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
routine, kexec_enter_virtual_mode(), that replays the mappings made by
the original kernel. Unfortunately, the function fails to reinstate
EFI's memory attributes and runtime memory protections, which would've
otherwise been set after entering virtual mode. Remediate this by
calling efi_runtime_update_mappings() from it.

Cc: stable@vger.kernel.org
Fixes: 18141e89a76c ("x86/efi: Add support for EFI_MEMORY_ATTRIBUTES_TABLE")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

---

Notes:
- I tested the Memory Attributes path using QEMU/OVMF.

- Although care is taken to make sure the memory backing the EFI Memory
  Attributes table is preserved during runtime and reachable after kexec
  (see efi_memattr_init()). I don't see the same happening for the EFI
  properties table. Maybe it's just unnecessary as there's an assumption
  that the table will fall in memory preserved during runtime? Or for
  another reason? Otherwise, we'd need to make sure it isn't possible to
  set EFI_NX_PE_DATA on kexec.

 arch/x86/platform/efi/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 88a96816de9a..b9b17892c495 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -784,6 +784,7 @@ static void __init kexec_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 	efi_native_runtime_setup();
+	efi_runtime_update_mappings();
 #endif
 }
 
-- 
2.40.1


