Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748C2167898
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgBUItN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 03:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbgBUItL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 03:49:11 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C45D2465D;
        Fri, 21 Feb 2020 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582274951;
        bh=2A4k/rdVTwM5hFreKmotwhwnUekDmTbxaASKb9mNb1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FaiM3aLX8upMu6NTewnxUNE+xXzwPmyJZzsyEA6R6bOpIh1wJTrIu6YlMYlbRiIpS
         r75L7B2HgNR4Et/iNaZVmKjaOk5Ce1BDVp6XcpzD4k3x3PKOKG9sMtGArLNCUDf24x
         EBe18kVS6I2ruTrE/xWXxh++4G/fjexYbRsbriuA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] efi/x86: Handle by-ref arguments covering multiple pages in mixed mode
Date:   Fri, 21 Feb 2020 09:48:48 +0100
Message-Id: <20200221084849.26878-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221084849.26878-1-ardb@kernel.org>
References: <20200221084849.26878-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The mixed mode runtime wrappers are fragile when it comes to how the
memory referred to by its pointer arguments are laid out in memory, due
to the fact that it translates these addresses to physical addresses that
the runtime services can dereference when running in 1:1 mode. Since
vmalloc'ed pages (including the vmap'ed stack) are not contiguous in the
physical address space, this scheme only works if the referenced memory
objects do not cross page boundaries.

Currently, the mixed mode runtime service wrappers require that all by-ref
arguments that live in the vmalloc space have a size that is a power of 2,
and are aligned to that same value. While this is a sensible way to
construct an object that is guaranteed not to cross a page boundary, it is
overly strict when it comes to checking whether a given object violates
this requirement, as we can simply take the physical address of the first
and the last byte, and verify that they point into the same physical page.

When this check fails, we emit a WARN(), but then simply proceed with the
call, which could cause data corruption if the next physical page belongs
to a mapping that is entirely unrelated.

Given that with vmap'ed stacks, this condition is much more likely to
trigger, let's relax the condition a bit, but fail the runtime service
call if it does trigger.

Fixes: f6697df36bdf0bf7 ("x86/efi: Prevent mixed mode boot corruption with CONFIG_VMAP_STACK=y")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 45 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ae398587f264..d19a2edd63cb 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -180,7 +180,7 @@ void efi_sync_low_kernel_mappings(void)
 static inline phys_addr_t
 virt_to_phys_or_null_size(void *va, unsigned long size)
 {
-	bool bad_size;
+	phys_addr_t pa;
 
 	if (!va)
 		return 0;
@@ -188,16 +188,13 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
 	if (virt_addr_valid(va))
 		return virt_to_phys(va);
 
-	/*
-	 * A fully aligned variable on the stack is guaranteed not to
-	 * cross a page bounary. Try to catch strings on the stack by
-	 * checking that 'size' is a power of two.
-	 */
-	bad_size = size > PAGE_SIZE || !is_power_of_2(size);
+	pa = slow_virt_to_phys(va);
 
-	WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
+	/* check if the object crosses a page boundary */
+	if (WARN_ON((pa ^ (pa + size - 1)) & PAGE_MASK))
+		return 0;
 
-	return slow_virt_to_phys(va);
+	return pa;
 }
 
 #define virt_to_phys_or_null(addr)				\
@@ -615,8 +612,11 @@ efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 	phys_attr = virt_to_phys_or_null(attr);
 	phys_data = virt_to_phys_or_null_size(data, *data_size);
 
-	status = efi_thunk(get_variable, phys_name, phys_vendor,
-			   phys_attr, phys_data_size, phys_data);
+	if (!phys_name || (data && !phys_data))
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(get_variable, phys_name, phys_vendor,
+				   phys_attr, phys_data_size, phys_data);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
@@ -641,9 +641,11 @@ efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	/* If data_size is > sizeof(u32) we've got problems */
-	status = efi_thunk(set_variable, phys_name, phys_vendor,
-			   attr, data_size, phys_data);
+	if (!phys_name || !phys_data)
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(set_variable, phys_name, phys_vendor,
+				   attr, data_size, phys_data);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
@@ -670,9 +672,11 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	/* If data_size is > sizeof(u32) we've got problems */
-	status = efi_thunk(set_variable, phys_name, phys_vendor,
-			   attr, data_size, phys_data);
+	if (!phys_name || !phys_data)
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(set_variable, phys_name, phys_vendor,
+				   attr, data_size, phys_data);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
@@ -698,8 +702,11 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_name = virt_to_phys_or_null_size(name, *name_size);
 
-	status = efi_thunk(get_next_variable, phys_name_size,
-			   phys_name, phys_vendor);
+	if (!phys_name)
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(get_next_variable, phys_name_size,
+				   phys_name, phys_vendor);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
-- 
2.17.1

