Return-Path: <linux-efi+bounces-5793-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8BCA29FF
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 08:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 258F830413E1
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212B301032;
	Thu,  4 Dec 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elhOdQhx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7942F9998;
	Thu,  4 Dec 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833027; cv=none; b=LV4N9pce+eJGa2RvDrWiLre+b4t/lFXeWuGBz8y+PbJE1YFvBB1gcYrTVlmXhgu/GpLBgQjJpLfkF4tChTZUGdv4145YnCfycopwactiCrwqZ8qiu5qYBllRfvnPWs1crDexsIj6yq8U6hfpgRy1W9Nkwmqd2U7CmNZODYSXE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833027; c=relaxed/simple;
	bh=yIyxQXuaRahR7U9KfaUjZE2DFbPFjXN0cVWD6cHkLok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArjLcdlDvAJ3+hKZo2R14M23x1/bZHbKbmDwbUNFWGs088bULsHGgBx70hdqv1pzGZmfLBZCSPXW/pf9F0s4DpJoRQW+ALsh6ivTZyYz3PzlPIiqMnYVQHzVXXMQ3ycStXHFF7w8qsj0gnnuXFZatt1/GyNOgcYHPp3iSKBPNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elhOdQhx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764833027; x=1796369027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIyxQXuaRahR7U9KfaUjZE2DFbPFjXN0cVWD6cHkLok=;
  b=elhOdQhxTwIFK7F6bWdTzAdnDj3BnWyQYM+LrSKgFHAwPrQO3n3z76+l
   AkcZ05p53SHbJtrUS40vMUijxc0OK7ZkaJONqyHMdnjv4h5Pn36goagt6
   FtpduEkCK8xu63mN+1W2cO6aZCzz0R+4gbQwKqezgpSADt1p9WYm6onHi
   Kxnyqn20uHJSl9Qfjgo6g+IzemPqN1hf1EsF6TaJfFrMb8EsfzQNXwWUw
   eCCDSBQ6QU1kND6QlM7BUYkwWkTGBzrrk+TlQ5JYix5KrOKKf8DjIVg7O
   xZwDJW4RCko9WvbrUqRieXisVwNQj3rWYuiXdE6c74wntpiixCfk9BTl3
   A==;
X-CSE-ConnectionGUID: RMMayjAhTRusLTu2CyjiKQ==
X-CSE-MsgGUID: YyDomUCGQIeKQWmjgQ7QtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66804589"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66804589"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 23:23:44 -0800
X-CSE-ConnectionGUID: i50frKhHTv+EESPOUQfkhQ==
X-CSE-MsgGUID: m+p96y9TT3GVDPgmmhA7VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="199861633"
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
Subject: [PATCH 2/3] x86/efi: Make runtime services compatible with LASS
Date: Wed,  3 Dec 2025 23:21:42 -0800
Message-ID: <20251204072143.3636863-3-sohil.mehta@intel.com>
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

Ideally, EFI runtime services should switch to kernel virtual addresses
after SetVirtualAddressMap(). However, firmware implementations are
known to be buggy in this regard and continue to access physical
addresses. The kernel maintains a 1:1 mapping of all runtime services
code and data regions to avoid breaking such firmware.

LASS enforcement relies on bit 63 of the virtual address, which would
block such accesses to the lower half. Unfortunately, not doing anything
could lead to #GP faults when users update to a kernel with LASS
enabled.

One option is to use a STAC/CLAC pair to temporarily disable LASS data
enforcement. However, there is no guarantee that the stray accesses
would only touch data and not perform instruction fetches. Also, relying
on the AC bit would depend on the runtime calls preserving RFLAGS, which
is highly unlikely in practice.

Instead, use the big hammer and switch off the entire LASS mechanism
temporarily by clearing CR4.LASS. Do this right after switching to
efi_mm (as userspace is not mapped) to minimize the security impact.

Some runtime services can be invoked during boot when LASS isn't active.
Use a global variable (similar to efi_mm) to save and restore the
correct CR4.LASS state. The runtime calls are serialized with the
efi_runtime_lock, so no concurrency issues are expected.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/platform/efi/efi_64.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index b4409df2105a..3d0593d6d54c 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -55,6 +55,7 @@
  */
 static u64 efi_va = EFI_VA_START;
 static struct mm_struct *efi_prev_mm;
+static unsigned long efi_cr4_lass;
 
 /*
  * We need our own copy of the higher levels of the page tables
@@ -443,16 +444,46 @@ static void efi_leave_mm(void)
 	unuse_temporary_mm(efi_prev_mm);
 }
 
+/*
+ * Toggle LASS to allow EFI to access any 1:1 mapped region in the lower
+ * half.
+ *
+ * Disable LASS after switching to EFI-mm, as userspace is not mapped in
+ * it. Similar to EFI-mm, they rely on preemption being disabled and the
+ * calls being serialized.
+ */
+
+static void efi_disable_lass(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return;
+
+	/* Save current CR4.LASS state */
+	efi_cr4_lass = cr4_read_shadow() & X86_CR4_LASS;
+	cr4_clear_bits(efi_cr4_lass);
+}
+
+static void efi_enable_lass(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return;
+
+	/* Reprogram CR4.LASS only if it was set earlier */
+	cr4_set_bits(efi_cr4_lass);
+}
+
 void arch_efi_call_virt_setup(void)
 {
 	efi_sync_low_kernel_mappings();
 	efi_fpu_begin();
 	firmware_restrict_branch_speculation_start();
 	efi_enter_mm();
+	efi_disable_lass();
 }
 
 void arch_efi_call_virt_teardown(void)
 {
+	efi_enable_lass();
 	efi_leave_mm();
 	firmware_restrict_branch_speculation_end();
 	efi_fpu_end();
-- 
2.43.0


