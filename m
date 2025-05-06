Return-Path: <linux-efi+bounces-3614-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E6CAAC112
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 12:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C071C272F5
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1127275114;
	Tue,  6 May 2025 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJ2Jf6l+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5UFqz3d"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A1238D42;
	Tue,  6 May 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526461; cv=none; b=d7flGBo0m6Bhq9xgvIWwtSRbC3Cr5xM9U5I1PewINjmX3UAI2yU/C87e9nSNjbpuvpJs9YI64EImkCOXbRgTOaT4J25uEYMv3IjioOHHZwgOjPWtfbMbXY5R/8zAN3hd4FxlS87WB7TQTDmTc5os9RMg9ugc4xvmhk3IGdZ/y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526461; c=relaxed/simple;
	bh=OHii1xj6q/F5zdHk24zD9OScfcV+zuskRf29yIQFnEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IqMrSHjjeDFCB0dAeK1Xo1ANdQlptFQZyw9gCywXfE/f5yd7t0acxEAas5pU3bDFxsCG47OPuL9UAsMOVZwPpFvl+AUg0SUI7dYwsxZzM4NassQhJBKSjKuj+Ng2OxqWLT5Z9RP2GSIw20xgny9AEj0VtkWUDPZ3Nl7i06q6sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJ2Jf6l+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5UFqz3d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746526456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ8WdMOnFRzNKxgDyBF0xvwiYnKnT6r3ADol9Bg/q1A=;
	b=YJ2Jf6l+BASIk2WAgzgUXFai8QAvNj4c7VhH3BiiSaqoAcx5cg0olGaLYvnfnSFIJ8L64k
	2Pn91bQbvZhKqHP/v/uBAHY0XS9CU80VV1M8H/Ied/3+Yy1FEVOhjza+cCpcA1zh5wxrXJ
	axXeYZ94IRasI+7J/0t/zQRE0gqpWUToTu3XUJ7zMbqD8s7zNHKWyQHUjZWFtOnSGuxQaB
	PdXKC4mraIzjqvWxfmkt1TEtdR2ISUthkohl5EDZjy7/RT1dIpDY4sKHxPKxkC7WerhNyP
	wOrZ4153UrWYwAO8grps45uJkYuEE5swvOiVa9i3vyO4fDfhDunvHiSE2orQjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746526456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ8WdMOnFRzNKxgDyBF0xvwiYnKnT6r3ADol9Bg/q1A=;
	b=v5UFqz3ddK035FgD3U+YSwraTs8jST+ye1fE1kPSUh2eyEEeRYaPrwAqpW4KdZw2qElBeH
	CtD630ZUxwYgjgDg==
To: Borislav Petkov <bp@alien8.de>, "Kirill A. Shutemov"
 <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Ingo
 Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Woodhouse
 <dwmw@amazon.co.uk>, Dionna Amalie Glaze <dionnaglaze@google.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Kevin
 Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 linux-efi@vger.kernel.org, x86@kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: 4067196a5227 ("mm/page_alloc: fix deadlock on cpu_hotplug_lock
 in __accept_page()") (was: Re: [tip: x86/boot] x86/boot: Provide
 __pti_set_user_pgtbl() to startup code)
In-Reply-To: <20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local>
References: <20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local>
Date: Tue, 06 May 2025 12:14:15 +0200
Message-ID: <87ecx2nj0o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 06 2025 at 11:24, Borislav Petkov wrote:
> [    1.329836] ---[ end Kernel panic - not syncing: kernel: panic_on_warn set ... ]---
>
> Fun stuff.

The only workable fix for this is:

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -894,7 +894,7 @@ config INTEL_TDX_GUEST
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
-	select UNACCEPTED_MEMORY
+	select UNACCEPTED_MEMORY if BROKEN
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
@@ -1515,7 +1515,7 @@ config AMD_MEM_ENCRYPT
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
-	select UNACCEPTED_MEMORY
+	select UNACCEPTED_MEMORY if BROKEN
 	select CRYPTO_LIB_AESGCM
 	help
 	  Say yes to enable support for the encryption of system memory.

Why?

The whole logic of this static branch _is_ completely broken. It wants to
track whether any zone has unaccepted memory, but all of that lacks any
form of global serialization.

__accept_page()
        last = list_empty(&zone->unaccepted_pages);
        spin_unlock_irqrestore(&zone->lock, *flags);
        if (last)
                static_branch_dec();

__free_unaccepted()
	spin_lock_irqsave(&zone->lock, flags);
	first = list_empty(&zone->unaccepted_pages);
	spin_unlock_irqrestore(&zone->lock, flags);
        if (first)
                static_branch_inc();

So anything which operates on the same zone after the lock was dropped
can race against the actual dec/inc operations. It's not even consistent
on the same zone, so how is that supposed to be consistent even across
different zones?

The work deferement:

__accept_page()
        last = list_empty(&zone->unaccepted_pages);
        spin_unlock_irqrestore(&zone->lock, *flags);
        if (last) {
                if (...)
                	schedule_work(...);
                else
                        static_branch_dec();

made this actually worse as the work is fully async and therefore
decrements can be lost:

__accept_page()
        schedule_work()

....

__accept_page()
        schedule_work()

    -> As the work is already scheduled, but not yet processed,
       it is not queued again, which means the second decrement
       is lost.

But that is just the tip of the iceberg as everything underneath which
"manages" and depends on that static branch is completely broken
already.

Seriously?

Thanks,

        tglx

                           

