Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B8415BCA3
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgBMKVP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 05:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKVP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 05:21:15 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282DB24649;
        Thu, 13 Feb 2020 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581589274;
        bh=pum15wROF25YvfjoPY0ad3eoaspEGhpksVWQVRu9HL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9XRGKRPo8YlULNW5vhjnTNi/S5gdppEAN3NEV9wfd7gEHbXAKgQNLEU/ssaUUV/z
         qlUFAtQMZuHiO6Zk/NAJk0BsXGtK+9SP0OQMgAk4czedqwlC3+UDZjqaT0ah5GFzE7
         +xRCpZ0xNAKusz7NDDySAXIMphFfmuNbqbeP8Myg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 2/3] efi/x86: remove support for EFI time and counter services in mixed mode
Date:   Thu, 13 Feb 2020 11:21:01 +0100
Message-Id: <20200213102102.30170-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213102102.30170-1-ardb@kernel.org>
References: <20200213102102.30170-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Mixed mode calls at runtime are rather tricky with vmap'ed stack, as
we can no longer assume that data passed in by the callers of the
EFI runtime wrapper routines is contiguous in physical memory.

We need to fix this, but before we do, let's drop the implementations
of routines that we know are never used on x86, i.e., the RTC related
ones. Given that UEFI rev2.8 permits any runtime service to return
EFI_UNSUPPORTED at runtime, let's return that instead.

As get_next_high_mono_count() is never used at all, even on other
architectures, let's make that return EFI_UNSUPPORTED as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 81 ++------------------
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

