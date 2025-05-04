Return-Path: <linux-efi+bounces-3577-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DF7AA86A7
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7749C18967AB
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567291A8401;
	Sun,  4 May 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HmIDLIPk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R9HftZut"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479B17AE11;
	Sun,  4 May 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368419; cv=none; b=c6+EgRkhx/Ed1yeJyoCngLLIqg8kzcJ85qkmsuKjYsw378bZ4cRNeI4u0X0voxu4CtkPUYVFmqJ1u2qh/mnV7W/7C7XXQXTMKGwct+B8dxn++y/GIv1obZ8863FQ7WH+r19nIHRbmenEosoIIiM6nG46Uv79tc+1byHMcfXqM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368419; c=relaxed/simple;
	bh=NmBSIIh35swFPddAA22ySNoE84Myoghy6XL6FxqZz8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SVIyye+goEE3JM6xN0t1TqSZN0UPdMJbQM0FYzX2ZUmr2gGs6tLIEO0mt7p0BfEF6HFQDLy1xoPolP7uiaO8LrnSi/QxlH1NP0No8qLnrpCQaxsnHQibzhTPUj06A5myOAyQALRTzeKtBnhpbeTXdY+ArZeb0imqWSCUmLKfH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HmIDLIPk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R9HftZut; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 14:20:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746368415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xz9w3HOdZL6VG/+mxNd2V4HpGaZRNHBpH4tHyoHjH8=;
	b=HmIDLIPkOv646+VLFb8grqa41HIQyvKQm4PH6y0sMWHY2mb+GARedq8WyoaBuMTDga+L9m
	IkHpZqMslzRCQgT8y0EKpoQaP6TKvKffLUnffnkwTenF5AfCe1W68qt0kh1JgmHdYysEO2
	8Y+0j9fdEdCveV26zZMD4eKyOzjmpKJFrk9A3CLEUHHKTV61P9KSg2NboTMP7Vp33VWLGu
	IKdq7Pi9MffbHdHAt9kSOt0qPp3irDE3sQe7ZriOrcyt6DIvFYf0q1Rkz1qySUObTH8J7l
	fib32kBiUVFy4Gm4Fq6rzRe+9/Qsad6rf0mgGj2HQxtwgWcAhC0skd+gou6J7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746368415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xz9w3HOdZL6VG/+mxNd2V4HpGaZRNHBpH4tHyoHjH8=;
	b=R9HftZut5VWvWHTolGGWI7yKwlBNtOL1ivnsAR3LFI7vJMH+BqFyqqa5TwE0iikjPf+myY
	N4SjL8gYLQl2PECA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Provide __pti_set_user_pgtbl() to startup code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-40-ardb+git@google.com>
References: <20250504095230.2932860-40-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174636840512.22196.14007684119604658714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5297886f0cc45db5f4a804caf359e6e7874ee864
Gitweb:        https://git.kernel.org/tip/5297886f0cc45db5f4a804caf359e6e7874ee864
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:59:43 +02:00

x86/boot: Provide __pti_set_user_pgtbl() to startup code

The SME encryption startup code populates page tables using the ordinary
set_pXX() helpers, and in a PTI build, these will call out to
__pti_set_user_pgtbl() to manipulate the shadow copy of the page tables
for user space.

This is unneeded for the startup code, which only manipulates the
swapper page tables, and so this call could be avoided in this
particular case. So instead of exposing the ordinary
__pti_set_user_pgtblt() to the startup code after its gets confined into
its own symbol space, provide an alternative which just returns pgd,
which is always correct in the startup context.

Annotate it as __weak for now, this will be dropped in a subsequent
patch.

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
Link: https://lore.kernel.org/r/20250504095230.2932860-40-ardb+git@google.com
---
 arch/x86/boot/startup/sme.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 5738b31..753cd20 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -564,3 +564,12 @@ void __head sme_enable(struct boot_params *bp)
 	cc_vendor	= CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
+
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
+/* Local version for startup code, which never operates on user page tables */
+__weak
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
+{
+	return pgd;
+}
+#endif

