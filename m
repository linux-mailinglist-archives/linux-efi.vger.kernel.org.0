Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340451704ED
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 17:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBZQzW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 11:55:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZQzS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 11:55:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6zxq-0002EU-Di; Wed, 26 Feb 2020 17:55:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EB6911C215D;
        Wed, 26 Feb 2020 17:55:13 +0100 (CET)
Date:   Wed, 26 Feb 2020 16:55:13 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Align GUIDs to their size in the mixed
 mode runtime wrapper
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200221084849.26878-2-ardb@kernel.org>
References: <20200221084849.26878-2-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <158273611370.28353.2746320720123528166.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     63056e8b5ebf41d52170e9f5ba1fc83d1855278c
Gitweb:        https://git.kernel.org/tip/63056e8b5ebf41d52170e9f5ba1fc83d1855278c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 21 Feb 2020 09:48:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2020 15:31:41 +01:00

efi/x86: Align GUIDs to their size in the mixed mode runtime wrapper

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
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Cc: linux-efi@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200221084849.26878-2-ardb@kernel.org
---
 arch/x86/platform/efi/efi_64.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index fa8506e..543edfd 100644
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
 
