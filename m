Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A639F21
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jun 2019 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfFHLyO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jun 2019 07:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfFHLkc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 8 Jun 2019 07:40:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3D1421670;
        Sat,  8 Jun 2019 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994030;
        bh=AU78Glg8yGgI2HjvXfqR0mHx9gGz2oJZlxUmfeLBagU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dp1+O9iGWfaarH1eTaXNdMbF9ahUpLSkf3gWjLMhIKFp/xBHkoEdlPQp80rSvzKJb
         tLZvvPA8izILBElufyBjznNanhkhpYnqMaQdj5mZGXs8J1wkC8KjYTFRNZfwUuoo6X
         VmYN/HMjLr2bxBtl6hebZXHRabkTjz4/7TDKWp54=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gen Zhang <blackgod016574@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Bradford <robert.bradford@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 25/70] efi/x86/Add missing error handling to old_memmap 1:1 mapping code
Date:   Sat,  8 Jun 2019 07:39:04 -0400
Message-Id: <20190608113950.8033-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>

[ Upstream commit 4e78921ba4dd0aca1cc89168f45039add4183f8e ]

The old_memmap flow in efi_call_phys_prolog() performs numerous memory
allocations, and either does not check for failure at all, or it does
but fails to propagate it back to the caller, which may end up calling
into the firmware with an incomplete 1:1 mapping.

So let's fix this by returning NULL from efi_call_phys_prolog() on
memory allocation failures only, and by handling this condition in the
caller. Also, clean up any half baked sets of page tables that we may
have created before returning with a NULL return value.

Note that any failure at this level will trigger a panic() two levels
up, so none of this makes a huge difference, but it is a nice cleanup
nonetheless.

[ardb: update commit log, add efi_call_phys_epilog() call on error path]

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Bradford <robert.bradford@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190525112559.7917-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/efi.c    | 2 ++
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a22fa8..a7189a3b4d70 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 	pgd_t *save_pgd;
 
 	save_pgd = efi_call_phys_prolog();
+	if (!save_pgd)
+		return EFI_ABORTED;
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f61b21..08ce8177c3af 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -84,13 +84,15 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_switch_mm(&efi_mm);
-		return NULL;
+		return efi_mm.pgd;
 	}
 
 	early_code_mapping_set_exec(1);
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
@@ -138,10 +140,11 @@ pgd_t * __init efi_call_phys_prolog(void)
 		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
 	}
 
-out:
 	__flush_tlb_all();
-
 	return save_pgd;
+out:
+	efi_call_phys_epilog(save_pgd);
+	return NULL;
 }
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
-- 
2.20.1

