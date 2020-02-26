Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C662D1704F4
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgBZQzS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 11:55:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBZQzR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 11:55:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6zxq-0002Do-33; Wed, 26 Feb 2020 17:55:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9E18F1C215C;
        Wed, 26 Feb 2020 17:55:13 +0100 (CET)
Date:   Wed, 26 Feb 2020 16:55:13 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Remove support for EFI time and counter
 services in mixed mode
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200221084849.26878-3-ardb@kernel.org>
References: <20200221084849.26878-3-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <158273611338.28353.1400239606002867191.tip-bot2@tip-bot2>
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

Commit-ID:     f80c9f6476db6c0802545aaa44eb9a38e751786a
Gitweb:        https://git.kernel.org/tip/f80c9f6476db6c0802545aaa44eb9a38e751786a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 21 Feb 2020 09:48:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2020 15:31:42 +01:00

efi/x86: Remove support for EFI time and counter services in mixed mode

Mixed mode calls at runtime are rather tricky with vmap'ed stacks,
as we can no longer assume that data passed in by the callers of the
EFI runtime wrapper routines is contiguous in physical memory.

We need to fix this, but before we do, let's drop the implementations
of routines that we know are never used on x86, i.e., the RTC related
ones. Given that UEFI rev2.8 permits any runtime service to return
EFI_UNSUPPORTED at runtime, let's return that instead.

As get_next_high_mono_count() is never used at all, even on other
architectures, let's make that return EFI_UNSUPPORTED too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200221084849.26878-3-ardb@kernel.org
---
 arch/x86/platform/efi/efi_64.c | 81 ++-------------------------------
 1 file changed, 5 insertions(+), 76 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 543edfd..ae39858 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -568,85 +568,25 @@ efi_thunk_set_virtual_address_map(unsigned long memory_map_size,
 
 static efi_status_t efi_thunk_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
-	efi_status_t status;
-	u32 phys_tm, phys_tc;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_tm = virt_to_phys_or_null(tm);
-	phys_tc = virt_to_phys_or_null(tc);
-
-	status = efi_thunk(get_time, phys_tm, phys_tc);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static efi_status_t efi_thunk_set_time(efi_time_t *tm)
 {
-	efi_status_t status;
-	u32 phys_tm;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_tm = virt_to_phys_or_null(tm);
-
-	status = efi_thunk(set_time, phys_tm);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static efi_status_t
 efi_thunk_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
 			  efi_time_t *tm)
 {
-	efi_status_t status;
-	u32 phys_enabled, phys_pending, phys_tm;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_enabled = virt_to_phys_or_null(enabled);
-	phys_pending = virt_to_phys_or_null(pending);
-	phys_tm = virt_to_phys_or_null(tm);
-
-	status = efi_thunk(get_wakeup_time, phys_enabled,
-			     phys_pending, phys_tm);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static efi_status_t
 efi_thunk_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 {
-	efi_status_t status;
-	u32 phys_tm;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_tm = virt_to_phys_or_null(tm);
-
-	status = efi_thunk(set_wakeup_time, enabled, phys_tm);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static unsigned long efi_name_size(efi_char16_t *name)
@@ -770,18 +710,7 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 static efi_status_t
 efi_thunk_get_next_high_mono_count(u32 *count)
 {
-	efi_status_t status;
-	u32 phys_count;
-	unsigned long flags;
-
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_count = virt_to_phys_or_null(count);
-	status = efi_thunk(get_next_high_mono_count, phys_count);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static void
