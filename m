Return-Path: <linux-efi+bounces-3579-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41155AA86AC
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C38A1896981
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8641C84DC;
	Sun,  4 May 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kGbzYxbG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Yvcautk"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9A19CC3D;
	Sun,  4 May 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368420; cv=none; b=V3Rbqef1wpAStF5aumXwSSHsce1Cwb00gGeU5Ntyks6NmcdkjDUiF86OEAt6peWiYOQfX4kMvk/PaF1q6hu68C6NuYp+vAD2OTxwwAdbrMrwnbldemrtdxVUto7Yg8VjgNzWmtcN3dkImzfEB5wTWyNT363mSmfB45zkBi5BsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368420; c=relaxed/simple;
	bh=DpzwIdbxQVJNaQb1u9aYhMrmwm09UasnI8BwV+/kocU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IFObfN8sdUmnl0C7Mj9PfdzoOH7DkgoAhIvP2Yw0WMFEBZpwuFPfDG6Q3TcqXz0STAeHYDv6iN+IB+F/zHE0F4EGaeQSBBaDpIwpuGZja6cCFDISUxpJVIMNK7TufxrDycQEkbXy8l32MxwnE8WvH3pupayDBj6UdMiBohy/41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kGbzYxbG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Yvcautk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 14:20:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746368416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRgdnpRkLNVpgGrZBUxe1q6YDHH5fAXqhv6jdJxiXPA=;
	b=kGbzYxbGj1iHXrRdKUVSA3DMV+bWGyJ69uNILnGLQ6Q2EmBzxkCG06V7fKkoXJFIGia9wk
	tBOvWH0LvneGCRdUMJKIbkUIxYK/6mjUXJ9IvYBtE6nOtcOXDM29r4Ry4wzBrUdpb4j/8f
	gSsb4TlVeLYRWkc48aWNdHtwmYZs4J08Bk7jHeVv8E7jQrCmf7CN04SNxvWo7MEEmER8vo
	273PAu7RxELFlOvoCKgYCBTLKjVjt39QHyrH2+zqJG7Wq2YdxE61fFBWMHU6FefNE1/po9
	UT4pBdYZ0O+1/HKvyW2j5kH5Z1lbQxJ6dOWkL/T/9wX8y4CWFglo3m9cmEAeKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746368416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRgdnpRkLNVpgGrZBUxe1q6YDHH5fAXqhv6jdJxiXPA=;
	b=1YvcautkyWoYQDDU3UdlGRsBKi/6kofmvjQrDfehOQodKR/2AAxv2CWy2dwpiRy4O4xpof
	OyQfsPw71IUDrgAQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit
 symbol aliases
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-38-ardb+git@google.com>
References: <20250504095230.2932860-38-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174636841571.22196.12713984367878648321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     f932adcc8650eb169efd0fd19f2a450c260d306c
Gitweb:        https://git.kernel.org/tip/f932adcc8650eb169efd0fd19f2a450c260d306c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:59:43 +02:00

x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases

Startup code that may execute from the early 1:1 mapping of memory will
be confined into its own address space, and only be permitted to access
ordinary kernel symbols if this is known to be safe.

Introduce a macro helper SYM_PIC_ALIAS() that emits a __pi_ prefixed
alias for a symbol, which allows startup code to access it.

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
Link: https://lore.kernel.org/r/20250504095230.2932860-38-ardb+git@google.com
---
 arch/x86/include/asm/linkage.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index b51d8a4..9d38ae7 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -141,5 +141,15 @@
 #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
 
+/*
+ * Expose 'sym' to the startup code in arch/x86/boot/startup/, by emitting an
+ * alias prefixed with __pi_
+ */
+#ifdef __ASSEMBLER__
+#define SYM_PIC_ALIAS(sym)	SYM_ALIAS(__pi_ ## sym, sym, SYM_L_GLOBAL)
+#else
+#define SYM_PIC_ALIAS(sym)	extern typeof(sym) __PASTE(__pi_, sym) __alias(sym)
+#endif
+
 #endif /* _ASM_X86_LINKAGE_H */
 

