Return-Path: <linux-efi+bounces-5792-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E4CA29F9
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 08:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AE23032127
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6A72FE568;
	Thu,  4 Dec 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGOGcGuG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C12E3AEA;
	Thu,  4 Dec 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833027; cv=none; b=X1AbBTKv8w+Cj5YthPcvuCTmrQUvc0DRgQNICkF5FtrWB6W3IPHo13OsG+fb+412xDb070tTIWmvEyS+IcQgEsJCbULAJ+PNKLae8e7pGCS9YFscNOje8fNdUVDD7/bvKzSMsNguZsbYTjkuBD18+g/AVw65adHNFK82Kb9ty8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833027; c=relaxed/simple;
	bh=BCg5BJPI4vrnJwZy/cBOahzk0FqyRAmssJmqoFadaVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEbn07r6Ev3Iqeq0s8YwYjpnPGGuBiN7gXD6y0QUGRESOjbbWPys953DjRKxDhQ60QuYzPGWVJv8gEALkJCLmp1mzKl72ArUXdv905lHY67MEo8X6asnFbxpbckdze0zJNO/y8kcmjx9lWxgQSAN3ACqPOvWWhelE6r/wfC5Bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGOGcGuG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764833026; x=1796369026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCg5BJPI4vrnJwZy/cBOahzk0FqyRAmssJmqoFadaVg=;
  b=JGOGcGuGzkfTGfdoxvdsxeWNeVrDBWeC/BDEhFbq6b9peCE7RfFR/5kd
   xLa2o5drPnyO7H25VdcO0ZNOZ3Awfttr9pifL6JF65SHjgULnSYuttgVq
   F5wXaXKDZqNcIFYWerMu4YXbHZVNGhxMUxAe8urqqoudGSElJq5vLYzSR
   /u1yGvEWSQ6szxiTTU+HnhRCj+0G6kEx6gbyTHM5R+WAjav3eMAf4C8eK
   xOVqM0GHUmwo0RTE+jCKRNYO0e2VUBlZLsqr2HTtFb50D/eUmWcIK3lIE
   Hv5UrC1NpNPbqG4sCxnRCJAI5srD8S9YrmzMGBkfMcRPw6Mgjai4x/0DY
   Q==;
X-CSE-ConnectionGUID: Vc4yXEdCTJKd5wUd7dmDYA==
X-CSE-MsgGUID: 6I4bY018R5+mybC6x5H2VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66804580"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66804580"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 23:23:44 -0800
X-CSE-ConnectionGUID: vQiroWzBTkOAGXDI37uy8Q==
X-CSE-MsgGUID: xeCy5wQeRFSFTkpUbC3Tug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="199861628"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 03 Dec 2025 23:23:43 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 1/3] x86/cpu: Defer LASS enabling until userspace comes up
Date: Wed,  3 Dec 2025 23:21:41 -0800
Message-ID: <20251204072143.3636863-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204072143.3636863-1-sohil.mehta@intel.com>
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LASS blocks any kernel access to the lower half of the virtual address
space. Unfortunately, some EFI accesses happen during boot with bit 63
cleared, which causes a #GP fault when LASS is enabled.

Notably, the SetVirtualAddressMap() call can only happen in EFI physical
mode. Also, EFI_BOOT_SERVICES_CODE/_DATA could be accessed even after
ExitBootServices(). For example, efi_check_for_embedded_firmwares()
accesses this memory even after SetVirtualAddressMap().

At a minimum, LASS enabling must be deferred until EFI has completely
finished entering virtual mode (including freeing boot services memory).
Moving setup_lass() to arch_cpu_finalize_init() would do the trick, but
it would make the implementation fragile. Something else might come in
the future that needs the LASS enabling to be moved again.

In general, security features such as LASS provide limited value before
userspace is up. They aren't necessary during early boot while only
trusted ring0 code is executing. Introduce a generic late initcall to
defer activating some CPU features until userspace is enabled.

For now, only move the LASS CR4 programming to this initcall. As APs are
already up by the time late initcalls run, some extra steps are needed
to enable LASS on all CPUs. Use a CPU hotplug callback instead of
on_each_cpu() or smp_call_function(). This ensures that LASS is enabled
on every CPU that is currently online as well as any future CPUs that
come online later. Note, even though hotplug callbacks run with
preemption enabled, cr4_set_bits() would disable interrupts while
updating CR4.

Keep the existing logic in place to clear the LASS feature bits early.
setup_clear_cpu_cap() must be called before boot_cpu_data is finalized
and alternatives are patched. Eventually, the entire setup_lass() logic
can go away once the restrictions based on vsyscall emulation and EFI
are removed.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/cpu/common.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e7ab22fce3b5..c6835a04d734 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -422,12 +422,27 @@ static __always_inline void setup_lass(struct cpuinfo_x86 *c)
 	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION) ||
 	    IS_ENABLED(CONFIG_EFI)) {
 		setup_clear_cpu_cap(X86_FEATURE_LASS);
-		return;
 	}
+}
 
+static int enable_lass(unsigned int cpu)
+{
 	cr4_set_bits(X86_CR4_LASS);
+
+	return 0;
 }
 
+static int cpu_finalize_pre_userspace(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return 0;
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/lass:enable", enable_lass, NULL);
+
+	return 0;
+}
+late_initcall(cpu_finalize_pre_userspace);
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
-- 
2.43.0


