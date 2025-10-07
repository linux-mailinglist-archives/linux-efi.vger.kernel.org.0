Return-Path: <linux-efi+bounces-4975-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4847ABC06D7
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE383BA917
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7056125A2A7;
	Tue,  7 Oct 2025 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTsv+BT5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43758247DE1;
	Tue,  7 Oct 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820049; cv=none; b=Ri3FK95Me3yD4Wg/VunhtDcxPilnGnH74evLYwJUgoPNihHl8VeaoQ1tFFzsEQHpMp/xwFRaypvKWs10RPUyDUEha3JnqCya0U4Yw3qQ5yJgo40PUd0PCt8+yi0TLB2lIsXiMyrZHS0f+0+6i5djeOSQ0LNASYg/KXccF52/t1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820049; c=relaxed/simple;
	bh=t0DAQB+KC4XHAKaSmSUqvc4zEUTHgxUgLpUaCfDvKeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9HC4Q9N5m7SDpuPqNdjXFpnm6/8ysXirjx/5qwbIqMdt6+oAc61HItiWNBKGWn3xD6GmBRCEpGy8nlhJunTWci94jI+tZwgJWGQim7aHJ7Xtzmq9CEPtC1Xp5pTCCBSw83guXgcKz25Pmnh+dR4kx41bu4sgvqt9zqXDp8I/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTsv+BT5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820047; x=1791356047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0DAQB+KC4XHAKaSmSUqvc4zEUTHgxUgLpUaCfDvKeI=;
  b=aTsv+BT5Gt+7VRmKQY37XtN/ollbootBRhcrB2nVY7XQNxvQpP917kLl
   oEyJC5QEB2itPQthgnd0GJOS+BJGhwpRTFG7LBKVBjpt0jHMWIulwI1v1
   XBcgpEdvwHpN1otKeMyI3AS9EzERVQQ7RCHKkbHuwfk6a0wu9D6NzfX5R
   8rR9DMnkm8ZlmLVu5cATu4ze43iCWPZOdAtHsSlIb80Bg5XxNLtCcdMyU
   /P1foOT5kMNi0ifGq4uIjeSdaf6U+VvIeHZm1tday3uvEHDS/Zz+ZZoWc
   3rhz6LD+iZDXprpWsd+eTl3x3MzQFKKvlssESyvZ+ftaPWESoK0jC6PSL
   Q==;
X-CSE-ConnectionGUID: /Ejnlc3STC2ZDFU+QlIl2A==
X-CSE-MsgGUID: f6J7PY9RRYChWPLAWYwqAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254578"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254578"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:06 -0700
X-CSE-ConnectionGUID: G1brpJMeQxWUcqvyPSqQlw==
X-CSE-MsgGUID: dunRP32HRl2MofOuKJdTYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354518"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:06 -0700
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
Subject: [PATCH v10 14/15] x86/traps: Provide additional hints for a kernel stack segment fault
Date: Mon,  6 Oct 2025 23:51:18 -0700
Message-ID: <20251007065119.148605-15-sohil.mehta@intel.com>
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Kernel triggered #SS exceptions are rare, and the faulting instruction
may not even have a memory operand. In cases where it does, hints about
the cause of the fault can be useful.

LASS throws a #GP for any violation except for stack register access,
which instead triggers a #SS. Handle a kernel #SS similarly to a #GP and
reuse the address decode logic to provide additional hints, such as a
non-canonical address or an LASS violation.

In case of FRED, before handling #SS as a kernel violation, check if
there's a fixup for the exception. Redirect the #SS due to invalid user
context on ERETU to userspace. See commit 5105e7687ad3 ("x86/fred: Fixup
fault on ERETU by jumping to fred_entrypoint_user") for details.

Originally-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Remove the LASS feature check to always provide hints independent of
   LASS being enabled.
 - Update printk to use KERN_DEFAULT (checkpatch warning).
 - Add code comments.
---
 arch/x86/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3ee8a36a4e6a..864c614cddab 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
 		      SIGBUS, 0, NULL);
 }
 
-DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
-{
-	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
-		      0, NULL);
-}
-
 DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 {
 	char *str = "alignment check";
@@ -873,6 +867,43 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+#define SSFSTR "stack segment fault"
+
+DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
+{
+	enum kernel_exc_hint hint;
+	unsigned long exc_addr;
+
+	if (user_mode(regs))
+		goto error_trap;
+
+	/*
+	 * With FRED enabled, an invalid user context can lead to an #SS
+	 * trap on ERETU. Fixup the exception and redirect the fault to
+	 * userspace in that case.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
+		return;
+
+	if (notify_die(DIE_TRAP, SSFSTR, regs, error_code, X86_TRAP_SS, SIGBUS) == NOTIFY_STOP)
+		return;
+
+	hint = get_kernel_exc_address(regs, &exc_addr);
+	if (hint != EXC_NO_HINT)
+		printk(KERN_DEFAULT SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint], exc_addr);
+
+	/* KASAN only cares about the non-canonical case, clear it otherwise */
+	if (hint != EXC_NON_CANONICAL)
+		exc_addr = 0;
+
+	die_addr(SSFSTR, regs, error_code, exc_addr);
+	return;
+
+error_trap:
+	do_error_trap(regs, error_code, SSFSTR, X86_TRAP_SS, SIGBUS, 0, NULL);
+}
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
-- 
2.43.0


