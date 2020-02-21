Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1892B1674FC
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 09:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgBUIVP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 03:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388239AbgBUIVO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 03:21:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6D4206ED;
        Fri, 21 Feb 2020 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273273;
        bh=C1v+ShQ1N1QW7naAQ+oLxC/VhO0Hozp6QIKDYeQARzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OB9QJBCzhIwwV/2srxe5IbnVMqDOS6g08SdPt8sRu2iwS+zEDdMZ9T0tJp7/c7A4H
         Jq8bi9aZLL3r28pPb3NM0tViVEuG9kW5K7tROqb2F4YDkUsN5muXzbPxbhBSbDejWc
         HLiQGwdxj+nT1P7wOFuLEswZKOoA8oZjFxF1Q6/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/191] efi/x86: Dont panic or BUG() on non-critical error conditions
Date:   Fri, 21 Feb 2020 08:41:22 +0100
Message-Id: <20200221072303.986267295@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit e2d68a955e49d61fd0384f23e92058dc9b79be5e ]

The logic in __efi_enter_virtual_mode() does a number of steps in
sequence, all of which may fail in one way or the other. In most
cases, we simply print an error and disable EFI runtime services
support, but in some cases, we BUG() or panic() and bring down the
system when encountering conditions that we could easily handle in
the same way.

While at it, replace a pointless page-to-virt-phys conversion with
one that goes straight from struct page to physical.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Matthew Garrett <mjg59@google.com>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20200103113953.9571-14-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/efi.c    | 28 ++++++++++++++--------------
 arch/x86/platform/efi/efi_64.c |  9 +++++----
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 5b0275310070e..e7f19dec16b97 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -930,16 +930,14 @@ static void __init __efi_enter_virtual_mode(void)
 
 	if (efi_alloc_page_tables()) {
 		pr_err("Failed to allocate EFI page tables\n");
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
+		goto err;
 	}
 
 	efi_merge_regions();
 	new_memmap = efi_map_regions(&count, &pg_shift);
 	if (!new_memmap) {
 		pr_err("Error reallocating memory, EFI runtime non-functional!\n");
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
+		goto err;
 	}
 
 	pa = __pa(new_memmap);
@@ -953,8 +951,7 @@ static void __init __efi_enter_virtual_mode(void)
 
 	if (efi_memmap_init_late(pa, efi.memmap.desc_size * count)) {
 		pr_err("Failed to remap late EFI memory map\n");
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
+		goto err;
 	}
 
 	if (efi_enabled(EFI_DBG)) {
@@ -962,12 +959,11 @@ static void __init __efi_enter_virtual_mode(void)
 		efi_print_memmap();
 	}
 
-	BUG_ON(!efi.systab);
+	if (WARN_ON(!efi.systab))
+		goto err;
 
-	if (efi_setup_page_tables(pa, 1 << pg_shift)) {
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
-	}
+	if (efi_setup_page_tables(pa, 1 << pg_shift))
+		goto err;
 
 	efi_sync_low_kernel_mappings();
 
@@ -987,9 +983,9 @@ static void __init __efi_enter_virtual_mode(void)
 	}
 
 	if (status != EFI_SUCCESS) {
-		pr_alert("Unable to switch EFI into virtual mode (status=%lx)!\n",
-			 status);
-		panic("EFI call to SetVirtualAddressMap() failed!");
+		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
+		       status);
+		goto err;
 	}
 
 	/*
@@ -1016,6 +1012,10 @@ static void __init __efi_enter_virtual_mode(void)
 
 	/* clean DUMMY object */
 	efi_delete_dummy_variable();
+	return;
+
+err:
+	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 }
 
 void __init efi_enter_virtual_mode(void)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ee5d08f25ce45..6db8f3598c800 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -389,11 +389,12 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 		return 0;
 
 	page = alloc_page(GFP_KERNEL|__GFP_DMA32);
-	if (!page)
-		panic("Unable to allocate EFI runtime stack < 4GB\n");
+	if (!page) {
+		pr_err("Unable to allocate EFI runtime stack < 4GB\n");
+		return 1;
+	}
 
-	efi_scratch.phys_stack = virt_to_phys(page_address(page));
-	efi_scratch.phys_stack += PAGE_SIZE; /* stack grows down */
+	efi_scratch.phys_stack = page_to_phys(page + 1); /* stack grows down */
 
 	npages = (_etext - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
-- 
2.20.1



