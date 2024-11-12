Return-Path: <linux-efi+bounces-2146-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A39C63DD
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 22:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D0AB3CC32
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031CE21833A;
	Tue, 12 Nov 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k5bLdzc4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E942178EE;
	Tue, 12 Nov 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437581; cv=none; b=D0hCDkygQ5too9/g8x2lnmRn/0N18NUy5kfIIA+gft+fXUrT1XK4Oums3tZYh12UAt/rlbdpQJk7elXnHldE7b+IPgD+I7thO4DPOR3fAVXtAj7QfPc3G7D2pI5RfD5K7Ox2dh2MTHcbVcE1qIR7ZxajX65C4q+g1X8P7JQVYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437581; c=relaxed/simple;
	bh=soKdLg6m2StKZPAIkHLlrKFJ6LJ8jdKERb4khRLnf5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjn2igTDatPFDlZCl5yg8pQAyhDllyIK4c+N0eOGI4dkJpgDw8I6wztxGuAbzHWihHa4RbEUTFMq8mYfAEfRSZWX/tyzM7GkDfk8Atoo+T5OSvqmyQ4filPNDvjTUoFdNyxNwRz186LDB4zMS7VViZSBN2clb1gR0QrHHIYQsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k5bLdzc4; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731437580; x=1762973580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HqiESkiyPRctv1Z5UNmLRjLfERKPs9Ag5PX7DOU980=;
  b=k5bLdzc4LMvV7dq/Z6uyBDE/3nopwlWSOgbO+jd6f5aO7X1rYbf1u/ca
   slWyDu7gYac0xEKJq1cOcwy/Mv4RBUVAb9m2KJbMoyDrq21GqX2ArT6Y0
   7kOnZ4F3WEcu8XYlGxjlk+jQcj4xFqHXj/d1bDrvr0EK3oPuzFnH1GheJ
   k=;
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
   d="scan'208";a="439046312"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 18:52:59 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:12017]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.250:2525] with esmtp (Farcaster)
 id d25e43a4-f818-4195-acb7-15156c42b891; Tue, 12 Nov 2024 18:52:58 +0000 (UTC)
X-Farcaster-Flow-ID: d25e43a4-f818-4195-acb7-15156c42b891
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 18:52:57 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 18:52:53 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Matt Fleming
	<matt@codeblueprint.co.uk>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stanspas@amazon.de>,
	<nh-open-source@amazon.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
Date: Tue, 12 Nov 2024 18:52:17 +0000
Message-ID: <20241112185217.48792-2-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241112185217.48792-1-nsaenz@amazon.com>
References: <20241112185217.48792-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
routine, kexec_enter_virtual_mode(), which replays the mappings made by
the original kernel. Unfortunately, that function fails to reinstate
EFI's memory attributes, which would've otherwise been set after
entering virtual mode. Remediate this by calling
efi_runtime_update_mappings() within kexec's routine.

Cc: stable@vger.kernel.org
Fixes: 18141e89a76c ("x86/efi: Add support for EFI_MEMORY_ATTRIBUTES_TABLE")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

---

Notes:
- Tested with QEMU/OVMF.

 arch/x86/platform/efi/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 375ebd78296a..a7ff189421c3 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -765,6 +765,7 @@ static void __init kexec_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 	efi_native_runtime_setup();
+	efi_runtime_update_mappings();
 #endif
 }
 
-- 
2.40.1


