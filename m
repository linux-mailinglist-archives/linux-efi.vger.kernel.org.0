Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A959167897
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgBUItL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 03:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgBUItK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 03:49:10 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A075924650;
        Fri, 21 Feb 2020 08:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582274949;
        bh=w6FmeglHbbjQyOVeVhB1YQFs2bUzBxmdI+GXM/tT2+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riwpfHIPIcMULGmYyrkl0wTkBeHPKCmFb+zczCh1JnvTgviWzr+/fH5wxJE/pKn7c
         ZuDc5phjLlhAoNGWldDL9oKfmyS6JVgJT4NYX1lcCVVbbxnjjfAiB37IR/rjRbKo04
         K4RWmumB1x7prrghLRPf4Opg8tGev3dVB4IJVkqY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] efi/x86: remove support for EFI time and counter services in mixed mode
Date:   Fri, 21 Feb 2020 09:48:47 +0100
Message-Id: <20200221084849.26878-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221084849.26878-1-ardb@kernel.org>
References: <20200221084849.26878-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
---
 arch/x86/platform/efi/efi_64.c | 81 +++-------------------------------
 1 file changed, 5 insertions(+), 76 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 543edfdcd1b9..ae398587f264 100644
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
-- 
2.17.1

