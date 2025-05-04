Return-Path: <linux-efi+bounces-3552-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998FAA859C
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7071894EB7
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68D1A08AB;
	Sun,  4 May 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0d611bLO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432019DF66
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352389; cv=none; b=P8dncO3cdnFMAovlrcHtuN3qKeofsrrvxO5N4Lfy6U+gLr6Ha49rkg0LJdvrOIBvoP8rUY639H06c6LpACNdsRf7kSHsZUiIanrnGoOY/6g6ZHVkz51vW7Mb2h7Hzxj6tLuyH4AKHIWvk1FjTlWmAFz5HjTEkK4qgWaEHy2g9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352389; c=relaxed/simple;
	bh=+FyIvsPsWVXVLkDD32Yax8szrjhp6N3YAfdKHzYClww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ixX83UEBUM1HMH4TeYeqMb0bXM4WfIyODGtOf8rAdN5coPsHTOYBMX5HUnmGmG/JkccdVHqBHk3XXhMIL1b8ofQoML6R/DRrNHY7UTcd+iS4fy6pI8voRTVQ8+ciN24AgoCKYosxzBRcnUjKnlNqjKqEW03lVNurRM6LslwMOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0d611bLO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so24969325e9.2
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352386; x=1746957186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=edyQoTvfRG8x1DOua7oEfmK1XYQ+Ovhdt7C5cZkBAXA=;
        b=0d611bLOwIGwb+rkyLn67HBGwaRaCShLUW/TxHloM0So4v4VlG+ux+8D2HtSDwTfxH
         8hxvQ0j6f5itAy2CwDnlE6SPNPDvx5X8g86FZBwwdkzipRsn9CLTGHyg96rAj6DkbhRa
         Ye9sdOlajN0XjTe4Di/BStTjJyoiUkVcqFy55fHMKs386Rx715aR8rMM66GeKP1thx86
         KVYdkUL3+3G4MqcuoG8PYTiNRBYuVeTXE1k0HQtSdWQS94WNh1z3VJ5Wal90Pl7r9h3A
         g1E9nkZM9y92rQe7Z5rIUOaMC2PUXhVNrImVNorCmmh93OYy25x88vO12SdbutRo6uyo
         UbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352386; x=1746957186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edyQoTvfRG8x1DOua7oEfmK1XYQ+Ovhdt7C5cZkBAXA=;
        b=Z4jwvxNR6rkJpPtNYupOib1Z+x9qbC757gaT+pmxKcdBjxH0bKc9BGb547vg4XBQEj
         16WJJFqW6hHLC0LwhDvAxJ7WlnPvwXI6z5q0obk1SXcgUlzoicTsgk4XyTrzj8OM4Orb
         gOoWNxGrQc8lqfcGWTEG9r7E01QdrxZIjXF9bSmkO0ojg66Uuw85z5nXCL6xkeAwxiA0
         QazkjDaL5JrLXEA9CKcg6tJffhdD67GbvjldyxQOCkgc+GJ3cHu8jq0mCrHiiEWqMSLo
         0WMrgd1jeSkUMLvjAjmEG2i76GEaC/gzhxLitf/Yp4V+HzmsgjTKJyKf7QJnmKAasd55
         fuJw==
X-Gm-Message-State: AOJu0Yxif/v9lF93gWZy06YxZBZQBq3jf0VFrtFzH3Pfv0zQkl3BdQ1s
	VzJeHqSNkQAZCP6ZpTdqsLDWIq1Ce5lvudhYDxkx+uHpcjqCGIpZtkGhWEc1Bm0zwLnAwA==
X-Google-Smtp-Source: AGHT+IGUfyOfLV6G6UR2fsX+wLERnuEA+YabEo3i5wYRA1IwhxBQ8DRNG3LYswYRLLnc5hLaEzfYvnCv
X-Received: from wmbbi7.prod.google.com ([2002:a05:600c:3d87:b0:441:b3f0:c46])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5027:b0:441:b698:3431
 with SMTP id 5b1f17b1804b1-441c4948315mr24664205e9.28.1746352386480; Sun, 04
 May 2025 02:53:06 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:31 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2866; i=ardb@kernel.org;
 h=from:subject; bh=RC+wmdw3k8C0pDFZiD1ezLCeDtzkHNknaU3PXMx+JFM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4sH3NckcFxmUDsnu3X5/w/TPj30UpGdFM3gEvDD+2
 HZQkf12RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIKhVGhv4XX1anOf22nWb5
 JvE6285joe1FHdwnymx9LiX/9lh2JI7hv6+I3Ean3bMyV3IVdv6Z5G00jzPYmqln412xPu3XbaY fOQA=
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-26-ardb+git@google.com>
Subject: [RFT PATCH v2 01/23] x86/boot: Move early_setup_gdt() back into head64.c
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move early_setup_gdt() out of the startup code that is callable from the
1:1 mapping - this is not needed, and instead, it is better to expose
the helper that does reside in __head directly. This reduces the amount
of code that needs special checks for 1:1 execution suitability. In
particular, it avoids dealing with the GHCB page (and its physical
address) in startup code, which runs from the 1:1 mapping, making
physical to virtual translations ambiguous.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/gdt_idt.c | 15 +--------------
 arch/x86/include/asm/setup.h    |  1 +
 arch/x86/kernel/head64.c        | 12 ++++++++++++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/startup/gdt_idt.c b/arch/x86/boot/startup/gdt_idt.c
index 7e34d0b426b1..a3112a69b06a 100644
--- a/arch/x86/boot/startup/gdt_idt.c
+++ b/arch/x86/boot/startup/gdt_idt.c
@@ -24,7 +24,7 @@
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
 /* This may run while still in the direct mapping */
-static void __head startup_64_load_idt(void *vc_handler)
+void __head startup_64_load_idt(void *vc_handler)
 {
 	struct desc_ptr desc = {
 		.address = (unsigned long)rip_rel_ptr(bringup_idt_table),
@@ -43,19 +43,6 @@ static void __head startup_64_load_idt(void *vc_handler)
 	native_load_idt(&desc);
 }
 
-/* This is used when running on kernel addresses */
-void early_setup_idt(void)
-{
-	void *handler = NULL;
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		setup_ghcb();
-		handler = vc_boot_ghcb;
-	}
-
-	startup_64_load_idt(handler);
-}
-
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ad9212df0ec0..6324f4c6c545 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -52,6 +52,7 @@ extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
+extern void startup_64_load_idt(void *vc_handler);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 6b68a206fa7f..29226f3ac064 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -303,3 +303,15 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
 
 	start_kernel();
 }
+
+void early_setup_idt(void)
+{
+	void *handler = NULL;
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		setup_ghcb();
+		handler = vc_boot_ghcb;
+	}
+
+	startup_64_load_idt(handler);
+}
-- 
2.49.0.906.g1f30a19c02-goog


