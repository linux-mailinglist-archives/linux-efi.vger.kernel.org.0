Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156E216789E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 09:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgBUItZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 03:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgBUItJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 03:49:09 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E822073A;
        Fri, 21 Feb 2020 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582274948;
        bh=HgwKMUg7AzFdprudduJfFZZhALobPBBE0qFbG220VFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkeqJZiV3Sy+obWiFVhV/jF3H8zqAGhFN8Rqv1xZiNapNOs3bPsq/E8xEWSSc7BMo
         BgF0HL4qoTTSWttmJhkEuHWyzCt6FRgGYGTMUsel+l6LakdpcQ58Q+ulaG+xoyMtAI
         qychDX5r9Pud/70zi3bf+YZdaPhYWR7i+wSCqdo8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] efi/x86: align GUIDs to their size in the mixed mode runtime wrapper
Date:   Fri, 21 Feb 2020 09:48:46 +0100
Message-Id: <20200221084849.26878-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221084849.26878-1-ardb@kernel.org>
References: <20200221084849.26878-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hans reports that his mixed mode systems running v5.6-rc1 kernels hit
the WARN_ON() in virt_to_phys_or_null_size(), caused by the fact that
efi_guid_t objects on the vmap'ed stack happen to be misaligned with
respect to their sizes. As a quick (i.e., backportable) fix, copy GUID
pointer arguments to the local stack into a buffer that is naturally
aligned to its size, so that it is guaranteed to cover only one
physical page.

Note that on x86, we cannot rely on the stack pointer being aligned
the way the compiler expects, so we need to allocate an 8-byte aligned
buffer of sufficient size, and copy the GUID into that buffer at an
offset that is aligned to 16 bytes.

Fixes: f6697df36bdf0bf7 ("x86/efi: Prevent mixed mode boot corruption with CONFIG_VMAP_STACK=y")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index fa8506e76bbe..543edfdcd1b9 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -658,6 +658,8 @@ static efi_status_t
 efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 		       u32 *attr, unsigned long *data_size, void *data)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	efi_status_t status;
 	u32 phys_name, phys_vendor, phys_attr;
 	u32 phys_data_size, phys_data;
@@ -665,8 +667,10 @@ efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 
 	spin_lock_irqsave(&efi_runtime_lock, flags);
 
+	*vnd = *vendor;
+
 	phys_data_size = virt_to_phys_or_null(data_size);
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
 	phys_attr = virt_to_phys_or_null(attr);
 	phys_data = virt_to_phys_or_null_size(data, *data_size);
@@ -683,14 +687,18 @@ static efi_status_t
 efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 		       u32 attr, unsigned long data_size, void *data)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	u32 phys_name, phys_vendor, phys_data;
 	efi_status_t status;
 	unsigned long flags;
 
 	spin_lock_irqsave(&efi_runtime_lock, flags);
 
+	*vnd = *vendor;
+
 	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
 	/* If data_size is > sizeof(u32) we've got problems */
@@ -707,6 +715,8 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 				   u32 attr, unsigned long data_size,
 				   void *data)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	u32 phys_name, phys_vendor, phys_data;
 	efi_status_t status;
 	unsigned long flags;
@@ -714,8 +724,10 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	if (!spin_trylock_irqsave(&efi_runtime_lock, flags))
 		return EFI_NOT_READY;
 
+	*vnd = *vendor;
+
 	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
 	/* If data_size is > sizeof(u32) we've got problems */
@@ -732,14 +744,18 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 			    efi_char16_t *name,
 			    efi_guid_t *vendor)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	efi_status_t status;
 	u32 phys_name_size, phys_name, phys_vendor;
 	unsigned long flags;
 
 	spin_lock_irqsave(&efi_runtime_lock, flags);
 
+	*vnd = *vendor;
+
 	phys_name_size = virt_to_phys_or_null(name_size);
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_name = virt_to_phys_or_null_size(name, *name_size);
 
 	status = efi_thunk(get_next_variable, phys_name_size,
@@ -747,6 +763,7 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
+	*vendor = *vnd;
 	return status;
 }
 
-- 
2.17.1

