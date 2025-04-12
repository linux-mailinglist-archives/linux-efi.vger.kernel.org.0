Return-Path: <linux-efi+bounces-3302-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B0EA86DB6
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522234420B5
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EC1EB5DC;
	Sat, 12 Apr 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOdxOZmS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZ/dIsun"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBC13B5AE;
	Sat, 12 Apr 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468424; cv=none; b=g9s4xjZaEltI+OE0y7DQCZc9BLwUF1Zpdm5BWa6uWBdrDVE/TgNqC1kgcGIniGgfIftEI06slMWJTXd8tu29Ai0IFVHV2j0/KVL5CIfYxe4equydxdHcSFxCoA7oqbR0vqH2r1jnQjapBTXjhXc3ZeNclTKB/gWiVvDXrPUCJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468424; c=relaxed/simple;
	bh=syC7YxkRpygGjEXB0MS92WczB4/obKtlCTut81shoLA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AlN2wK+u5viacNntyfB6X93OHCCeRdTS1XRbyrLo15co3awSy4GTIznaWq9H2OTnL0b0tgLG/YMYIS+gLBSk4ceUFF+QvhwglP/wH4LQr3enhZkj55m/cDrk8gbYrRgwqAcdH/LW2NkGFR9jVqUDUGPJiTA9Vpuwtt8/MTRmhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOdxOZmS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZ/dIsun; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 14:33:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744468415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDc3vBJn+6CelFjqjUsutrOKX6TKsAHGEVQhlsFNiYQ=;
	b=TOdxOZmSTj7QZ37M8iXC0+c5SXXbrOtPThwbxaoJBYqfnLY6u4jyVFUlnIPwDxRuvethal
	+3ZS8YQzd3mWet4YH9+Qzij77rKd2d2KO7vBzxoLsLMNc/aZM77egMKubRawpvOKwr3vII
	y2zayJCuhvKDoPEG4wqOwJZAN7wFZYLQhV3bPc6RMugetHuyBfTuHku2MOvadvPPkSvaRy
	odx7/gwFxMHrQQxJh2gePtQzZzSYBBtcxWSjnrROC8VYrgn9C5t59QKw4uSK2kba6UwOJy
	jTVQQPyfFtRndbIAahQZqiXg+jkHPdZvTT5CywX+iA1vb0YUXmOmWb6sFL1j/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744468415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDc3vBJn+6CelFjqjUsutrOKX6TKsAHGEVQhlsFNiYQ=;
	b=GZ/dIsunl1OyjzIBWmKuZt5YG6VRQ3OmS7YHtr4/3N2od+vz0cJE2naKA5/0FGalgRsm+D
	pN/VV1+xqoKNxrAg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Drop RIP_REL_REF() uses from SME startup code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410134117.3713574-19-ardb+git@google.com>
References: <20250410134117.3713574-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174446841454.31282.15473515990276716118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     bee174b27e54462ef18b38f8377d27ac0ad14350
Gitweb:        https://git.kernel.org/tip/bee174b27e54462ef18b38f8377d27ac0ad14350
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:41:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 11:13:05 +02:00

x86/boot: Drop RIP_REL_REF() uses from SME startup code

RIP_REL_REF() has no effect on code residing in arch/x86/boot/startup,
as it is built with -fPIC. So remove any occurrences from the SME
startup code.

Note the SME is the only caller of cc_set_mask() that requires this, so
drop it from there as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410134117.3713574-19-ardb+git@google.com
---
 arch/x86/boot/startup/sme.c        | 11 +++++------
 arch/x86/include/asm/coco.h        |  2 +-
 arch/x86/include/asm/mem_encrypt.h |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 23d10cd..5738b31 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -297,8 +297,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
 	 * function.
 	 */
-	if (!sme_get_me_mask() ||
-	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
+	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
@@ -524,7 +523,7 @@ void __head sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	sev_status = msr = __rdmsr(MSR_AMD64_SEV);
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/*
@@ -560,8 +559,8 @@ void __head sme_enable(struct boot_params *bp)
 			return;
 	}
 
-	RIP_REL_REF(sme_me_mask) = me_mask;
-	RIP_REL_REF(physical_mask) &= ~me_mask;
-	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
+	sme_me_mask	= me_mask;
+	physical_mask	&= ~me_mask;
+	cc_vendor	= CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index e722545..e1dbf8d 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -22,7 +22,7 @@ static inline u64 cc_get_mask(void)
 
 static inline void cc_set_mask(u64 mask)
 {
-	RIP_REL_REF(cc_mask) = mask;
+	cc_mask = mask;
 }
 
 u64 cc_mkenc(u64 val);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 1530ee3..ea64946 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -61,7 +61,7 @@ void __init sev_es_init_vc_handling(void);
 
 static inline u64 sme_get_me_mask(void)
 {
-	return RIP_REL_REF(sme_me_mask);
+	return sme_me_mask;
 }
 
 #define __bss_decrypted __section(".bss..decrypted")

