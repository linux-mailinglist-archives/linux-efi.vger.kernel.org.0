Return-Path: <linux-efi+bounces-5504-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD4C5A606
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AB5F353324
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C2A32939A;
	Thu, 13 Nov 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5o2GcYR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517832825A;
	Thu, 13 Nov 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073925; cv=none; b=tSh1Wv4I6uIskZawDH7G6MOOr1/HSSUIMXLpucJy5mHn+PIdW1olLjpLedwCzVeCXnAd4o74US9kPXHpOWv0yGEnYuJY2n9f6C5TUGdeaNG1ozsMTin9Wnft6+hZbigwYyXjcTLuihW/XhA76ilv/aVNOSOkRo7tadQ2lXFxMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073925; c=relaxed/simple;
	bh=kBdXhc+A+wT4FZp9yNpWWziklK2/ynCoRGDow6mU3dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzyinBkG2pvk4w7REoXyBuo8SvoKO6tW9NFZxvnHgGL/R2gtGskwCNOdivZMpubS8wqlkmxyi7DigjVdFjmafAd0cHpXwLcAUy5AJTKgq2JgH+/DQjleR58O9oCg1thk4rshU17vIfB4wzC2PjyN4Ws13Fdm0/jW/m9oFGY3JQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5o2GcYR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073923; x=1794609923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kBdXhc+A+wT4FZp9yNpWWziklK2/ynCoRGDow6mU3dw=;
  b=U5o2GcYRZj4WbcWzFacejASsuxPhAAKhphsUTDXMdrCRQRp3xmVHrmQy
   vGQgnt3PxziiO7I9mHSZu4Zyvh74xXLz1/npGQoka/rn3IK2PqttWNP59
   csPnmtzrj8B6/RlwnFUiQNxNeVu2t1wXhY//YFXKDxua0iqwBOWyIgxau
   hGHyvlqK4tdF2qMtgOiXxEqLgNyG5PStpbia5UPgwPjDC6IOqWvs3oOrl
   zAwQnB8RaV9xLnDQN7FIdimGQXTJbB7nPqe1Fr93W1fLbeZylqA9Jx5my
   GBpncO5dv9nDYEtUCcNP5dSI3QoY0USeH78VVUuR6av+yyQNmoxuMQEj0
   w==;
X-CSE-ConnectionGUID: vv7chruJSemBiQFkk20WtQ==
X-CSE-MsgGUID: FhtaYQvORNqugYCwHgiAnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051994"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051994"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:19 -0800
X-CSE-ConnectionGUID: 4JKiUxG/Rf+LCTLpacaxMg==
X-CSE-MsgGUID: LbL2JpExQFSwUZ6RY5ku3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611110"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2025 14:45:19 -0800
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
Subject: [PATCH v12 8/8] x86/cpu: Enable LASS during CPU initialization
Date: Thu, 13 Nov 2025 14:42:04 -0800
Message-ID: <20251113224204.50391-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113224204.50391-1-sohil.mehta@intel.com>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
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


