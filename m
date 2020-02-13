Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD515BCA4
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 11:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBMKVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 05:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKVR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 05:21:17 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3860424650;
        Thu, 13 Feb 2020 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581589276;
        bh=9cbYbm586BLe73N2VYVbhPZNibByMC7XJYTpPqJNHaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xbv2o/y7UyDFL2bCo+3s8k9J46WAGj+aW1sRfpJZKuPsxG6WVwpbFPpMT8f0iv46I
         fC+XXQ005RjeRZPjJYCPOOn66lPmaupzzplXchQLWzSw1qEXhSJmg6/Dp0gVw+ewdB
         NG9OZv9Nyx/p1XhwFWG/ajSMXnHP9Pd24hp4H30Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 3/3] efi/x86: Handle by-ref arguments covering multiple pages in mixed mode
Date:   Thu, 13 Feb 2020 11:21:02 +0100
Message-Id: <20200213102102.30170-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213102102.30170-1-ardb@kernel.org>
References: <20200213102102.30170-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We currently apply some stringent checks on the variable name and
buffer arguments passed to the EFI runtime services, and WARN()
if they are allocated in the vmalloc space and are not aligned to
their size - which must be a power of two - since in that case, it
is not guaranteed that they will not cross a page boundary.

However, we then simply proceed with the call, which could cause data
corruption if the next physical page belongs to a mapping that is
entirely unrelated.

Given that with vmap'ed stacks, this condition is much more likely
to trigger, let's relax the condition a bit, but fail the runtime
service call if it triggers.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 45 +++++++++++---------
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

