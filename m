Return-Path: <linux-efi+bounces-2779-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8EAA2F5D5
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAFD168F6F
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C478255E59;
	Mon, 10 Feb 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmormK+z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5024BD06
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209810; cv=none; b=h6fSD9giUi9p9rrmS2pyt84DtVRYDDAC/A9sA3ohOQ3IBMpNnG5b7wyW7azqLpUVcWq8L13BPWIEul7FAXq3tyI/ZDCPwxLXL7ssjGdNLlHHDma8sdEGIMfot4dGMXDiOHpVFPBucEUQznHDfBe0FT3qQHPtEkDQepsOD6YSNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209810; c=relaxed/simple;
	bh=G5bgzA1i0JexLpJUuL+udRJGEluZcdR0IcmYEAloLcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iu2+4fZwiSoqcmxDgoPF8rRP3WT6x5igDjakJ7tAXiUdE7IbjlevTEXKxii8wCzPD9DOhZ4g+iMWyk3gHDAKPBuPuehlhaA4GheoFn3AOzElch+v9IeTICJI425cPzpcDy/NZCAKjMiLEcU20OG3r0hlIYu/fyuVFU39BoXTLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmormK+z; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38de12153d4so639522f8f.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209807; x=1739814607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkAzosm8jxvfCHu0gcd5Qhm8qoV8uLpEa5VS5jM7qwI=;
        b=PmormK+zs0QTGmRefoHg3z24Pb2/ONhGw8xkyvTAhXRGqIxrheavgUtIVqVX9jo0au
         yRQnC19Tw48sTnf5IA07gAjd2KAVDvXLw2Jd6sJoPE4nmAagtvYjhHQn6ojScGETmFie
         a2PgIU52o7JLdV7dda9NBjQ5AsfOt0NPFVKIMYOav6w+EJgUyTEtAfGTY49WJ5wxfNWE
         G7vsgMUPREupA3DOxpmEUHlnuP9h4rlA2GVpu636H2siTi2e+8oq3eWweWtlltfxCWXS
         hrIp62qJKSuLm0wMzVUp7X+r2ReNcrb8VvCIje4DeqaCVbYt3aUd3vwL9qN/wEAVgAhp
         VwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209807; x=1739814607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkAzosm8jxvfCHu0gcd5Qhm8qoV8uLpEa5VS5jM7qwI=;
        b=KZNg/mg4ycTIRtl0Mf5qMXZMjHnPDaobKNVWTQEy58db7kQim+hUYtQSI1IWiRY3ab
         5K4AlmKDO6cLo3Uz68WzQ0ZdlYSidM+192qUNHsSA7ruDKNz3GZYAhCYtLGF0iuV1dHa
         Kw9UrTYD6xaBYNLdmfY5HS0mTEGbbmgmCoyCylLgeOp7oBMjNkFv9V6ZM+lRCu2Y2TrI
         7yIxSGePCX9P/f/KZZ1IkHHP3V66LG/32K6xZ5ZppKRhHtm+Zfh4/YIEBsS521wM2/VN
         iVeeYuYdKoEuUGwZxnssYbV7wZpi7YBX/kC2oVQdXfItiMWwDXjMGDJ0UVIKimjahES4
         Cu5Q==
X-Gm-Message-State: AOJu0YwLeDK2iibWy3Z6AZZlNVZev+Ccn/UMOHo6Yb8vxEx9tohNRwem
	+3zK8QfLIcI1eB69SAoSVUNvilyHAR+v+3lH0aDwH0hwT9Lt1Zi5es9pMHXHG5fS/AWJqSL0maM
	AR2RMrxdYmk/P00ah95pTztsSw1n6qxO7C4Ps0V8V9rEFqE2Gv+8rbZ339hVX9d5yt5do3INXz8
	nQysitPA+3hFSRaUhAWoAPDZMRGQ==
X-Google-Smtp-Source: AGHT+IG+VvMjqwPmxscsDUKG0E78+g6xTP/xB9+9wt/8NrZrtcQpHQnuSBRdw0akfa85CdEW0jfWOijI
X-Received: from wmbfp27.prod.google.com ([2002:a05:600c:699b:b0:436:1a60:654e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6d03:0:b0:38d:d664:67d8
 with SMTP id ffacd0b85a97d-38dd6646bddmr5499501f8f.11.1739209807039; Mon, 10
 Feb 2025 09:50:07 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:45 +0100
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=ardb@kernel.org;
 h=from:subject; bh=pDo4LLvdeMJ133Ru7rxDyvLMRfDLzKvHZSwUtXn8YcY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2VjcWe4EenT3+xuVeh0TmrQvx74c3798MPblatDgnOq
 Xv3QnFaRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIBiMjwxz/nnsXdNsnvto1
 4fuV+1Pduzaqd07L9azssPmce4xnthAjw8d502+uMCrUetwubWe4++/54/nPgiVCkzR6pMtNd// LZgMA
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-12-ardb+git@google.com>
Subject: [PATCH v2 3/7] x86/efi/mixed: Factor out and clean up long mode entry
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Entering long mode involves setting the EFER_LME and CR4.PAE bits before
enabling paging by setting CR0.PG bit.

It also involves disabling interrupts, given that the firmware's 32-bit
IDT becomes invalid as soon as the CPU transitions into long mode.

Reloading the CR3 register is not necessary at boot time, given that the
EFI firmware as well as the kernel's EFI stub use a 1:1 mapping of the
32-bit addressable memory in the system.

Break out this code into a separate helper for clarity, and so that it
can be reused in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 29 ++++++++++----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index b7886e2591fc..0b6b37b08f82 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -170,10 +170,6 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	movl	%edx, %gs
 	movl	%edx, %ss
 
-	/* Reload pgtables */
-	movl	%cr3, %eax
-	movl	%eax, %cr3
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -199,30 +195,35 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	lidtl	16(%ebx)
 	lgdtl	(%ebx)
 
+	xorl	%eax, %eax
+	lldt	%ax
+
+	call	efi32_enable_long_mode
+
+	pushl	$__KERNEL_CS
+	pushl	%ebp
+	lret
+SYM_FUNC_END(efi_enter32)
+
+SYM_FUNC_START_LOCAL(efi32_enable_long_mode)
 	movl	%cr4, %eax
 	btsl	$(X86_CR4_PAE_BIT), %eax
 	movl	%eax, %cr4
 
-	movl	%cr3, %eax
-	movl	%eax, %cr3
-
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
 	wrmsr
 
-	xorl	%eax, %eax
-	lldt	%ax
-
-	pushl	$__KERNEL_CS
-	pushl	%ebp
+	/* Disable interrupts - the firmware's IDT does not work in long mode */
+	cli
 
 	/* Enable paging */
 	movl	%cr0, %eax
 	btsl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
-	lret
-SYM_FUNC_END(efi_enter32)
+	ret
+SYM_FUNC_END(efi32_enable_long_mode)
 
 /*
  * This is the common EFI stub entry point for mixed mode.
-- 
2.48.1.362.g079036d154-goog


