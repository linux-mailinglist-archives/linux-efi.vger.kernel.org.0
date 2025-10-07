Return-Path: <linux-efi+bounces-4971-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5EBBC06F9
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 714014F5289
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C34C254AE1;
	Tue,  7 Oct 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gl9Dn709"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545A244670;
	Tue,  7 Oct 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820046; cv=none; b=hQIsBbBKyE6uaJf5FWFcqINjjVn1XlXBBl+CzP4otbmrAXQg+YYVFMQ/ebUY0sdk4M9x7L1uDBXQ5XuudoogBsELDXgsHZCCJg+AZ9EEed1i4luiMVl0Tonau6Ak+renh5iwVLpZZxHLCc/U/eLMnYoVwDeJA5pz6IzVB0X9kYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820046; c=relaxed/simple;
	bh=Q7agOSCAERHWB5so+wxbqMf9sjQ0R+iLN74s/s56CAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl7l/enI1Z9YZCKTeT72HFnbq8xPnz0GhUs5initlOqktRPXDUTDv+hub6/HACf8G5nZebuLjbEsk+PJ7ihYAUIMsP7hPICuIAOz1HGisfIx8bxwFVlRodlv7IAeCESuih8lorV8j8M0yanh6LPjphdlPyicWx786lXJZZBVu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gl9Dn709; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820044; x=1791356044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7agOSCAERHWB5so+wxbqMf9sjQ0R+iLN74s/s56CAk=;
  b=gl9Dn709b5P/MaWjrWewxXDM6wJaSW3jtu5YOmjV00DqL2ZBkD9vcUZL
   No3n8d3P5At/uDlVl2fkof4/VCVGhC8VHGD9eWvcyHzAhmjOfIbWSVAU1
   BJydH876yip6cA/RjmnbmnluzQbdDWZzg6dtWZqtyjBzByanzsV8od6th
   EvYhb5zJC0fDRJWAl3/Bi+YnOPdw9GlQUuTjA9kqspiFwUhCn829DL1wA
   OfqqhfvN4yI6geefayf7Q1Jtyk1xfqoVqHihJXVy/WhjW3KkuVU6LhI0/
   bkIOMi7YUwRkZ2nUimeOPbeQ9EY6ruhd8JhEmat7vNSFNggmdhrP5lRBm
   Q==;
X-CSE-ConnectionGUID: +BbQqzGdQ4+kt+9TEmH2Tw==
X-CSE-MsgGUID: qwyayd3oTjKgshbzMYsu7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254521"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254521"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:03 -0700
X-CSE-ConnectionGUID: yLXKUA1+S5qtfzLq6a5LLw==
X-CSE-MsgGUID: DH8lp9h+RfyypJg5xm6YTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354498"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:02 -0700
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
Subject: [PATCH v10 10/15] x86/vsyscall: Add vsyscall emulation for #GP
Date: Mon,  6 Oct 2025 23:51:14 -0700
Message-ID: <20251007065119.148605-11-sohil.mehta@intel.com>
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

The legacy vsyscall page is mapped at a fixed address in the kernel
address range 0xffffffffff600000-0xffffffffff601000. Prior to LASS, a
vsyscall page access from userspace would always generate a #PF. The
kernel emulates the execute (XONLY) accesses in the #PF handler and
returns the appropriate values to userspace.

With LASS, these accesses are intercepted before the paging structures
are traversed triggering a #GP instead of a #PF. However, the #GP
doesn't provide much information in terms of the error code.

Emulate the vsyscall access without going through complex instruction
decoding. Use the faulting RIP which is preserved in the user registers
to determine if the #GP was triggered due to a vsyscall access.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - No change.
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 14 +++++++++++++-
 arch/x86/include/asm/vsyscall.h       |  6 ++++++
 arch/x86/kernel/traps.c               |  4 ++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4c3f49bf39e6..ff319d7e778c 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -23,7 +23,7 @@
  * soon be no new userspace code that will ever use a vsyscall.
  *
  * The code in this file emulates vsyscalls when notified of a page
- * fault to a vsyscall address.
+ * fault or a general protection fault to a vsyscall address.
  */
 
 #include <linux/kernel.h>
@@ -282,6 +282,18 @@ bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
 	return __emulate_vsyscall(regs, address);
 }
 
+bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return false;
+
+	/* Emulate only if the RIP points to the vsyscall address */
+	if (!is_vsyscall_vaddr(regs->ip))
+		return false;
+
+	return __emulate_vsyscall(regs, regs->ip);
+}
+
 /*
  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index f34902364972..538053b1656a 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -15,6 +15,7 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  * Returns true if handled.
  */
 bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs, unsigned long address);
+bool emulate_vsyscall_gp(struct pt_regs *regs);
 #else
 static inline void map_vsyscall(void) {}
 static inline bool emulate_vsyscall_pf(unsigned long error_code,
@@ -22,6 +23,11 @@ static inline bool emulate_vsyscall_pf(unsigned long error_code,
 {
 	return false;
 }
+
+static inline bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	return false;
+}
 #endif
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 25b45193eb19..59bfbdf0a1a0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -69,6 +69,7 @@
 #include <asm/tdx.h>
 #include <asm/cfi.h>
 #include <asm/msr.h>
+#include <asm/vsyscall.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -817,6 +818,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_umip_exception(regs))
 			goto exit;
 
+		if (emulate_vsyscall_gp(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.43.0


