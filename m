Return-Path: <linux-efi+bounces-5606-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D757C6B3D8
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 19:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4D99365CE7
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF402E22A3;
	Tue, 18 Nov 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMp1R5tY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB12E11D7;
	Tue, 18 Nov 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490909; cv=none; b=XaQFT+ucWTxvx3YHnMPJD5TFT/rh5Phw9Ll9nlHA3rMsTdzNm8CeOeCVG2X0XuLqPmq2G/1RunlKG3q9JhqY7Tc7GCNjeO4Vn/sUrLOAtjodWDezFSu2StgNDBFp2LmO5KilhLtAMpZkc7Fpq1L/KEUE28FdnCZaI6dBNxwxT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490909; c=relaxed/simple;
	bh=kBdXhc+A+wT4FZp9yNpWWziklK2/ynCoRGDow6mU3dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQoX2StaDL7W/+pwn5bK0eC+CwLQtkNBFJXqI43rSe/i9AHTBwcYv/u+PxvwWtZxHMKtV6Jn9HM2Gpu8T4y+Pxfl8tiIS/X8DZK4I/qAx/g9dtH+z8MRQI1Y3yIXFPKIJPDQH9tiZ1Cg4zHIGstUNjTIYZlO0LuYfJrx4WkctBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMp1R5tY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490908; x=1795026908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kBdXhc+A+wT4FZp9yNpWWziklK2/ynCoRGDow6mU3dw=;
  b=aMp1R5tYnZSf3mPIEBhicKwWFk0dQ7+EF2TEbWxpl0KNM4GPzv3TE7JE
   dOsQ5YitfrrKOwsbq102llwuqdk8M/7iKUunPEor8Lfwy3KuoNOpF6aWx
   vtxrNX5CLxXlAsX2r4Uay3aybvsVreqU5bJ6VR3dYGTLu94InRDdwyZz7
   8FgPpki+QCrGnZ2R5oxetzhdUrOBwMuinhNQrQC8HWW9ank2fj97Jx4j9
   M3MaJC2uPVcmd1nIjmix5v0D0UJJO0Eo+YkU4kSELBNXHBLioxQvjcbAl
   PKvzTQ0QLT9eN8hsrAQacg81CptEikeU07eXSu1Vz+G5T2y8ZpZ0WIBdm
   w==;
X-CSE-ConnectionGUID: 0z5tgAobQaWMF+RjVAdhiw==
X-CSE-MsgGUID: Uw6YAPTsS1uccyWX1hTiVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76979999"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76979999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:58 -0800
X-CSE-ConnectionGUID: Gf76gajzT92lT0TA/wE9Sw==
X-CSE-MsgGUID: jtqyMQBPQUiAnhI9pJqeKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190088965"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 10:31:58 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v13 8/8] x86/cpu: Enable LASS during CPU initialization
Date: Tue, 18 Nov 2025 10:29:10 -0800
Message-ID: <20251118182911.2983253-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118182911.2983253-1-sohil.mehta@intel.com>
References: <20251118182911.2983253-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linear Address Space Separation (LASS) mitigates a class of side-channel
attacks that rely on speculative access across the user/kernel boundary.
Enable LASS along with similar security features if the platform
supports it.

While at it, remove the comment above the SMAP/SMEP/UMIP/LASS setup
instead of updating it, as the whole sequence is quite self-explanatory.

Some EFI runtime and boot services may rely on 1:1 mappings in the lower
half during early boot and even after SetVirtualAddressMap(). To avoid
tripping LASS, the initial CR4 programming would need to be delayed
until EFI has completely finished entering virtual mode (including
efi_free_boot_services()). Also, LASS would need to be temporarily
disabled while switching to efi_mm to avoid potential faults on stray
runtime accesses.

Similarly, legacy vsyscall page accesses are flagged by LASS resulting
in a #GP (instead of a #PF). Without LASS, the #PF handler emulates the
accesses and returns the appropriate values. Equivalent emulation
support is required in the #GP handler with LASS enabled. In case of
vsyscall XONLY (execute only) mode, the faulting address is readily
available in the RIP which would make it easier to reuse the #PF
emulation logic.

For now, keep it simple and disable LASS if either of those are compiled
in. Though not ideal, this makes it easier to start testing LASS support
in some environments. In future, LASS support can easily be expanded to
support EFI and legacy vsyscalls.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
For reference, here are the relevant discussion links regarding EFI and
legacy vsyscalls:

https://lore.kernel.org/lkml/CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com/
https://lore.kernel.org/lkml/bbb68600-eea9-45d8-90d1-bc4619186a4d@intel.com/
https://lore.kernel.org/lkml/CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com/
https://lore.kernel.org/lkml/d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com/

v12:
 - Disable LASS when EFI support is compiled in.
 - Pick up review tag.

v11:
 - Disable LASS if vsyscall emulation support is compiled in.
 - Drop Rick's review tag because of the new changes.
---
 arch/x86/kernel/cpu/common.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 02d97834a1d4..8afcbfd48a8a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -405,6 +405,28 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return;
+
+	/*
+	 * Legacy vsyscall page access causes a #GP when LASS is active.
+	 * Disable LASS because the #GP handler doesn't support vsyscall
+	 * emulation.
+	 *
+	 * Also disable LASS when running under EFI, as some runtime and
+	 * boot services rely on 1:1 mappings in the lower half.
+	 */
+	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION) ||
+	    IS_ENABLED(CONFIG_EFI)) {
+		setup_clear_cpu_cap(X86_FEATURE_LASS);
+		return;
+	}
+
+	cr4_set_bits(X86_CR4_LASS);
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
@@ -2015,10 +2037,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_lass(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-- 
2.43.0


