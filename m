Return-Path: <linux-efi+bounces-3583-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96DAA86B9
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762D81898782
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F71DEFD6;
	Sun,  4 May 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EosNyHYi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HYpWjX7e"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297F1AA1F4;
	Sun,  4 May 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368434; cv=none; b=meyW1faSxVDJF2MElwsTcuHf01rny4O/sfNmR3+My/XRXgcO9T7uav9h1EtQzsifAfPOY5PCztWkxUf58SEmSvKaUhZRY8ib0ufqzOdz7baOEZ1ieod1lHaRH58Wy/6KKGaiDi0X5MI1Xfj/bK+oztSBvwZ6u82HGk1GC+zl/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368434; c=relaxed/simple;
	bh=QoYSJWKTYm9gL4vTRwc8py3WN5kV5+2lkc6QnbHULEQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lz8u+kBHgGbosxLlsLJ9UdNVdSJzBAg+I8i1dWWlPG6GpW7cY7ASN6cRc3PDQ6ukqeso2hs7MhG2J4Fm5ebqKnbpzvmMAAdcY/rlVqi+TDmo4mB+apgzMiiqWOvHE0Okgojwh8HkPbcT5ugGnzj5B4N7cF3cRIhhchA8QVvAxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EosNyHYi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HYpWjX7e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 14:20:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746368430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR/Woi/EJbTSDCuKb8HPly9rablXX/lDWXC5K3PAw/8=;
	b=EosNyHYiE7AWIyrPfdL2C98//bjIwtsRrQ8zbNlEYUXHvkd5s5+xrjdT1uAFTuRik6nrd/
	THHNpJeF2c3MLjUyFTaXmrcopNsHJFTTaQd6kjYPYwHgh9Mr9YjqKok+98EY2B/zfeVx8E
	NXwEUmcCDrI15dniepcNAzzHoYX6+I/aYlcRb27iszuY6q7uZkYXC7TuruenBGkSS/0kDt
	dhdsSOXS5/DSpJ4kX5uBFY/BEXO/+dc216CYwqowD4DdepiZrPQUdoRhG2QJ7zBLm9nAW5
	GZPCEo9UQiuCY8SU/nlhiXoztCWgHT1g7lVnBP4nK3cvHYI3A3mio0XIZMZ7Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746368430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR/Woi/EJbTSDCuKb8HPly9rablXX/lDWXC5K3PAw/8=;
	b=HYpWjX7eUe+dxbcb58WqU92PCtDD1PKpHWiq+54WnqwuljLn89/X9Iq1l+Kn0fsQrdMCWQ
	4MHAdqLi6zH+TpDA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Move early_setup_gdt() back into head64.c
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-26-ardb+git@google.com>
References: <20250504095230.2932860-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174636842987.22196.4991784786092668294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     bd4a58beaaf1f4aff025282c6e8b130bdb4a29e4
Gitweb:        https://git.kernel.org/tip/bd4a58beaaf1f4aff025282c6e8b130bdb4a29e4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:27:23 +02:00

x86/boot: Move early_setup_gdt() back into head64.c

Move early_setup_gdt() out of the startup code that is callable from the
1:1 mapping - this is not needed, and instead, it is better to expose
the helper that does reside in __head directly.

This reduces the amount of code that needs special checks for 1:1
execution suitability. In particular, it avoids dealing with the GHCB
page (and its physical address) in startup code, which runs from the
1:1 mapping, making physical to virtual translations ambiguous.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250504095230.2932860-26-ardb+git@google.com
---
 arch/x86/boot/startup/gdt_idt.c | 15 +--------------
 arch/x86/include/asm/setup.h    |  1 +
 arch/x86/kernel/head64.c        | 12 ++++++++++++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/startup/gdt_idt.c b/arch/x86/boot/startup/gdt_idt.c
index 7e34d0b..a3112a6 100644
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
index ad9212d..6324f4c 100644
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
index 6b68a20..29226f3 100644
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

