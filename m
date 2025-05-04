Return-Path: <linux-efi+bounces-3581-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CBAA86B2
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F8D1775F4
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08DF1C5D72;
	Sun,  4 May 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fuSvXdgm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hi/g/bD+"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF71A2C25;
	Sun,  4 May 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368432; cv=none; b=mDOB9DXY1oOEF+Avx7YqLibGmIFUMltIgWK+Bpxi9qtG37X+VC1mjw4V61c918t8mXnQtklbBhIzM0FRhunqRecs+PQyJd1u/gdWln8lY8ahmWAgb3r4qdkIeHWcuzzQ96CT9BdKCHLC98PzJcm5+Ja50mqZDEIR1jGFJCseZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368432; c=relaxed/simple;
	bh=rXOG1P2zI2iB+m1WcXaNc8h94r7CNEjmT/2bPQYTmJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kyPqUDS3hmr39Xw2rwsUgBZKHJd8c3grym3bWf20zRvPqwNoLEpXwoWQhg+ty3anCUBaFnEG2P11i+3sRqdk6v51Pc9Hw8fXc9KRjO3awDZvskJUSQs02BrY66LyLl6U27VkYPCyaC+kiFY7jME/t4pL7zH/uz82o/uCKWous9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fuSvXdgm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hi/g/bD+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 14:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746368429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPOslDqyXpdDq6W6zD/xT+G/7G0VjZbZReDsNjePvp8=;
	b=fuSvXdgm+tyAGCCt27Oj95R3syYJrzGX80HlBEg4dbiwFIHCDEvJ/YuNDmml2ADwh0FoRC
	BfRNpAZWF7reOtNo6HY9UHd62CNSVUZBGsBH6JLNOTpRwm9pqZ3Uhl3vfc1JW6aqO78/Vn
	L5M91LY4Fc2SX2RhjFPHo9Zm2K2XrHss07fKYJ0WH7aybrmVi5QbjpS2TudT2ygtl71peW
	B026um/IurXkbBwrwS6jlQf9Cv+kx/egF2nLZA3YtgRtT0DaGCkk96dwTJOhqdzHcu6Q0Z
	WnMQL41GCuJ9ENeQqG+SQHnnTipSw+MTLM1YEo+lcYJT/DVys3OeyasJIHRRBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746368429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPOslDqyXpdDq6W6zD/xT+G/7G0VjZbZReDsNjePvp8=;
	b=hi/g/bD+n9+soNIKKMB4O9GKgAW82qzcL8wIy8TF24cN1G8ooWZmCZL+7VJwDl6OVTMXGu
	LUQdy356oy3J7YDQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/sev: Make sev_snp_enabled() a static function
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-29-ardb+git@google.com>
References: <20250504095230.2932860-29-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174636841731.22196.14042198424404966355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     fae89bbfdd9d692e3cb6eace89f4994177731b8c
Gitweb:        https://git.kernel.org/tip/fae89bbfdd9d692e3cb6eace89f4994177731b8c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:53:06 +02:00

x86/sev: Make sev_snp_enabled() a static function

sev_snp_enabled() is no longer used outside of the source file that
defines it, so make it static and drop the extern declarations.

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
Link: https://lore.kernel.org/r/20250504095230.2932860-29-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c | 2 +-
 arch/x86/boot/compressed/sev.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 2ccad0a..f4b7f17 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -164,7 +164,7 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 	return ret;
 }
 
-bool sev_snp_enabled(void)
+static bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index d390038..e87af54 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -10,14 +10,12 @@
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
-bool sev_snp_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 sev_get_status(void);
 bool early_is_sevsnp_guest(void);
 
 #else
 
-static inline bool sev_snp_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 sev_get_status(void) { return 0; }
 static inline bool early_is_sevsnp_guest(void) { return false; }

