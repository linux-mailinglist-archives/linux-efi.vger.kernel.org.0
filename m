Return-Path: <linux-efi+bounces-4966-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AA1BC0686
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084AE3C3F7D
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2DC23D28F;
	Tue,  7 Oct 2025 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PELZYFA3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8F2367CC;
	Tue,  7 Oct 2025 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820043; cv=none; b=K7K0eOsyGupA0LyFtghl16RFRxMJkr3D9tEv8i4Lbrnl3ZOVjFCy9vhBVT62vKztH20dY7eIHPORTLNq61IKyOFC5LteggjUQDYbXx5+lZjA3BcYkqBq5Cf55VqiLPuyUsjUkXZHoPTMnHmnN60GUn98b9gOUu7bIPzib0WVgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820043; c=relaxed/simple;
	bh=He18mQTkB07VatWb7vSd19sKKa+uJJoTfhGyKuWZTIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm84rgNNuMedOhEDYGesFwX8YfXuu9p5VHoQqAb0lSuget7zVOLBsa8jN7rWjy2S8OHjUsX2Nf1WMq1S1AJkq7Jre2ZV7BKDdSjEyDEHDbvTUC0Rxuz/fI105GyCW1+w+zmEGze57gNuIgVKWo1DqdnYvD9BvoCuB9xE7GQhVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PELZYFA3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820041; x=1791356041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=He18mQTkB07VatWb7vSd19sKKa+uJJoTfhGyKuWZTIM=;
  b=PELZYFA3IUsqpwdoaqg/O5/CxSo5JRLUdEfuI4dYNMJsYgGPb4OszxXU
   1ZyJKYTbCg5DHniBC5rm6ij7GKGsgx3GZSW++EZ/M5XJmQRbc5ei20L0C
   qr9YwML6zJYKbhEf7CXSvUpNTWLiI1CR14ljchqMOS2e5M9pIOeBircdR
   hwY+iOx77BjIWVCkpGZZMt2xJosF0pxY2ALTqeebsrh2ENQMEcI0WepYt
   33Tn9geDJ4S29wxfxivBZhx4xHtooPetdpjKARh79qDLEJ7rTZheR3gTd
   Wk7MQRg0UcOPk1nXfHjEygfISjP5cpG8yXjlC/wAaZSH177J8Mx+zlW1h
   A==;
X-CSE-ConnectionGUID: cb/5hBwiRFeqOSHU2HTuLQ==
X-CSE-MsgGUID: B0s64srmREGpjKFRV2OI4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254449"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254449"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:53:59 -0700
X-CSE-ConnectionGUID: JO6wmiYGSaaBJi85QqqdHQ==
X-CSE-MsgGUID: RbnuZQ4mQBqlWW1xPblWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354480"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:53:59 -0700
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
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until late_initcall()
Date: Mon,  6 Oct 2025 23:51:09 -0700
Message-ID: <20251007065119.148605-6-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007065119.148605-1-sohil.mehta@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
-------
In order to map the EFI runtime services, set_virtual_address_map()
needs to be called, which resides in the lower half of the address
space. This means that LASS needs to be temporarily disabled around this
call.

Wrapping efi_enter_virtual_mode() with lass_stac()/clac() is not enough,
because the AC flag only gates data accesses, not instruction fetches.
Clearing the CR4.LASS bit is required to make this work.

However, pinned CR4 bits are not expected to be modified after
boot CPU init, resulting in a kernel warning.

Solution
--------
One option is to move the CR pinning setup immediately after the runtime
services have been mapped. However, that is a narrow fix that would
require revisiting if something else needs to modify a pinned CR bit.

CR pinning mainly prevents exploits from trivially modifying
security-sensitive CR bits. There is limited benefit to enabling CR
pinning before userspace comes up. Defer CR pinning enforcement until
late_initcall() to allow EFI and future users to modify the CR bits
without any concern for CR pinning.

Save the pinned bits while initializing the boot CPU because they are
needed later to program the value on APs when they come up.

Note
----
This introduces a small window between the boot CPU being initialized
and CR pinning being enforced, where any in-kernel clearing of the
pinned bits could go unnoticed. Later, when enforcement begins, a
warning is triggered as soon as any CR4 bit is modified, such as
X86_CR4_PGE during a TLB flush.

Currently, this is a purely theoretical concern. There are multiple ways
to resolve it [1] if it becomes a problem in practice.

Link: https://lore.kernel.org/lkml/c59aa7ac-62a6-45ec-b626-de518b25f7d9@intel.com/ [1]
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Split recording pinned bits and enabling pinning into two functions.
 - Defer pinning until userspace comes up.

This patch does not include any changes to harden the CR pinning
implementation, as that is beyond the scope of this series.
---
 arch/x86/kernel/cpu/common.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 61ab332eaf73..57d5824465b0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -476,8 +476,8 @@ void cr4_init(void)
 
 	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4 |= X86_CR4_PCIDE;
-	if (static_branch_likely(&cr_pinning))
-		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
+
+	cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
 
 	__write_cr4(cr4);
 
@@ -487,14 +487,21 @@ void cr4_init(void)
 
 /*
  * Once CPU feature detection is finished (and boot params have been
- * parsed), record any of the sensitive CR bits that are set, and
- * enable CR pinning.
+ * parsed), record any of the sensitive CR bits that are set.
  */
-static void __init setup_cr_pinning(void)
+static void __init record_cr_pinned_bits(void)
 {
 	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & cr4_pinned_mask;
+}
+
+/* Enables enforcement of the CR pinned bits */
+static int __init enable_cr_pinning(void)
+{
 	static_key_enable(&cr_pinning.key);
+
+	return 0;
 }
+late_initcall(enable_cr_pinning);
 
 static __init int x86_nofsgsbase_setup(char *arg)
 {
@@ -2119,7 +2126,7 @@ static __init void identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
-	setup_cr_pinning();
+	record_cr_pinned_bits();
 
 	tsx_init();
 	tdx_init();
-- 
2.43.0


