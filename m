Return-Path: <linux-efi+bounces-3582-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056DAA86B6
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F221E1898782
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E71C84DC;
	Sun,  4 May 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3+rd3SBF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwL8l10Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6F1A4F12;
	Sun,  4 May 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368433; cv=none; b=qfH6LyIFBFZ3XGoB5Rq2llc5cLyMuvG3Ok3416sQG9K+4PIeU64FzTc8BHHmiIRdrgvhTOI7FTDEHHFO4Kr/NLhO94Y2tJOCtjxQvOiP9a6x645FeCGZ1ai9ED8KajyGsXfwlc9cScixr1gPo6xNlfa+4f4L/qAJ3eQGW5wYDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368433; c=relaxed/simple;
	bh=1r4c0YuXa2Se8/XYGD97TBs3gDnf5NG45ONFS8FdP7s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RR+GmWy6ClEllzIse9kMA8ed1wxaoNFQNM9oZv1pwa6aojr0Ik7w4Xy8G/nPP/vK3esSg1tR3duLDQ3+mDx3Mghqg/U92GBTvHmu9NY+LGATA7kymGYdMyOS7zJxj0oGMmyM4/qV9f/o97LC1wGmCU+pNh5oFuq6IKmPBMkGt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3+rd3SBF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwL8l10Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 14:20:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746368429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+a144gmGgNd2FlOTjBV8wY1WJEEazZFgUiXmc3PSSKI=;
	b=3+rd3SBFavLj4JktG75+2tB3AtgwuwS4PjdTbsYXR0zHfy0SJKm5kLPlkzwO6f5pmT6hS6
	K2mVs5Jza/7+fbQG7oZ/240SdEUnSu/ZtPh8jhgjbpiMC9MYUShCzD7sEUARY1qB70yYhL
	DeCl7dlhA2YZ/uf2wtHie2utmwf981XPnzZK0e/ZIHQVG4/o4xT6one4RCSBInssFdO9eV
	vpN7vBv23HgYcat1GG+z8lNE6WAOMhHsmHFBXgh4D3wSUHDiIJiBeADE6cpPudDuYgNesy
	sSy1JMI2wOP8GJZ+P9UOcVA9tkWr9EXGpKjQfm5lHsce56dpvAPPiiaFDsUERQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746368429;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+a144gmGgNd2FlOTjBV8wY1WJEEazZFgUiXmc3PSSKI=;
	b=nwL8l10ZNbGrHlDWHtfOgmK+1ORuPyrkhm3JquErYGPOKRo8A69zbNpZEeSx9UCM6rQYl0
	S/BPrFqR+3gPBDDQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Disregard __supported_pte_mask in __startup_64()
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-27-ardb+git@google.com>
References: <20250504095230.2932860-27-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174636842907.22196.17764583510375832637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b3464a36f7f2499d517e8334e07ddd6eefcd67c1
Gitweb:        https://git.kernel.org/tip/b3464a36f7f2499d517e8334e07ddd6eefcd67c1
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:27:23 +02:00

x86/boot: Disregard __supported_pte_mask in __startup_64()

__supported_pte_mask is statically initialized to U64_MAX and never
assigned until long after the startup code executes that creates the
initial page tables. So applying the mask is unnecessary, and can be
avoided.

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
Link: https://lore.kernel.org/r/20250504095230.2932860-27-ardb+git@google.com
---
 arch/x86/boot/startup/map_kernel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 0eac3f1..099ae25 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -179,8 +179,6 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
-	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 

