Return-Path: <linux-efi+bounces-3602-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1193AA99C3
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF27117DC2A
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D826AA8D;
	Mon,  5 May 2025 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZUizA55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ziQ9SsQA"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6E26A083;
	Mon,  5 May 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464055; cv=none; b=T44Sinu3YwaBbhHb+SM6HOdDtUCOuqZYTK71fugj36D2RIlnF1+/bMOfSqmZmSZM5M1QfOWl9zdSx0k0u9K2KFT5oAg8MQ5+avahc/uB1M2zeM57rSLigeygbtML0LavuqhVIXila3GdinNBP6VQ9kpER7imsPLFbrQ4EwcXQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464055; c=relaxed/simple;
	bh=ttqHVDDDHkBY5vhptujKheHjTcF5u2BkFKS/tkcNWhk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KOGUpe8wV8i+r8qb55j4v6WLVJdCTw/e7ESWZ9ZNAzzbSSYLA8P4LPODPdNwihvapACEeN30KKceXnk71Hfr70CU6ZhuCc8Rj34ObXZ1Rwm6Q6bsL4Gq9M066tYArHSyzTzqkESJ19TSvMtHol7FrtrFxEh3v6Du/d320jgCOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZUizA55; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ziQ9SsQA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 16:54:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746464051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep/elUp+vcOIOApnlluNfdGIMIfcz9HW14oEBAc8nNc=;
	b=KZUizA553FkSk23iJXTBpMXQwBUIoNVr/CRLMrK9cFpa8NAF/090h/fnKvk+iN4c1M+hry
	WY+HaGXO1nqYzyLYIA9Qax8IgZnJsziJx2XmL4w/FhgARMWEBXWTbB+J+tti6UmsZsIE2R
	XBj1H7P47qP8c/yRrkk5NWvr+9ShUSHjzJYNwsArjIlgV3ZGKgepPoYBsJOQFHxmYI/zZI
	hLNkLoh7MHQ7ry58w1rOg0MIBOVWkpN8uIiM5KbDl6nsQMzDtPiIsU7iFKdWEsW++eclhH
	dbk69/J0qtcNVpeRLMiHlD9zeH1ZHSsGD93uuG1/WbB8Bs/ShFcP13+GQ/bqsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746464051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep/elUp+vcOIOApnlluNfdGIMIfcz9HW14oEBAc8nNc=;
	b=ziQ9SsQAqkJYQGq7ONXXqLQ4nJmGzTj8TqpYpgd34PnWUkGfDsyBUVLUgshzatPzd4nlMq
	7MDMyxyANxggO4Dw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Provide __pti_set_user_pgtbl() to startup code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
 David Woodhouse <dwmw@amazon.co.uk>,
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
Message-ID: <174646405074.406.11902047835715348370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     f92d3fe32874e83986b9edc330ccc9bc9faaa92a
Gitweb:        https://git.kernel.org/tip/f92d3fe32874e83986b9edc330ccc9bc9faaa92a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:45 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 May 2025 18:48:58 +02:00

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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

