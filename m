Return-Path: <linux-efi+bounces-4972-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D2BC06BA
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0AB3B9A7F
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D9B256C6C;
	Tue,  7 Oct 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhcRoHsK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FB247283;
	Tue,  7 Oct 2025 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820047; cv=none; b=JVysrHZ03ZYzPoX+jsEOW//2HqLMIYqA5xhQevgtPLKVhOkom0UlhKLjcikEHEd0UK9lsAic44wAWnJx5fT4BQqRoQNgOdU2lGpF+t7Kp5YTUMsSpCRdgwG1fmV16foZgFmW4Fpp0Uis8IW96FRM1/KWkjZtT2F6wV+CLr3oG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820047; c=relaxed/simple;
	bh=AO7ttp/5/5QVnC/MxKsk0OxVOwOWTlktVqE63h4+7Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwXkS7Aohq+3QYRteIwsHqkm9ttNKuwSLptD7oibINa2h9qlJWnLRqU4ncxvug9j/W+fRIu6FWEoMc8xfBs0bB6KJSm6XQrgVoHn8RsK4zJUZHiyDvO0bF6Z0xA+/bD9ouk0s5PSsfybVWuhZcp8S6+muKCgYslsyDnWCcixT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhcRoHsK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820045; x=1791356045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AO7ttp/5/5QVnC/MxKsk0OxVOwOWTlktVqE63h4+7Xg=;
  b=AhcRoHsKJ3yfGmPx2M7JnPn/ddkUbwKAXqd35TTG7zaVB8z1tRL/5Zsn
   FblCOxVYA2wJi45OzxylNpy02mh37/uEeqmGs8Qi0ZymJHM6DXPYQcRcH
   SfK2Zu5rBaZOJv8gjjAq07SCpTJ9iy/YdY46/Fir/NRsDicLlhMxb16Aw
   K+y2NpYYJ1HvqdnOB2HHv9p5tfOsbgMHW24g8uCZH2Q7XArfhm/mE5cyc
   ECgN2y8Dgg07WWuyrTlaKr19hTwIAT1f0DrVzhNUXsAFPbuzFeCafFKTx
   oyp6vabTppVQcYjLBivb0ZL2axbTBxXXPtnweJQSRtUc6wQv2mH0J2rwH
   w==;
X-CSE-ConnectionGUID: xwZL4OcPQE2CFQre5ntEEw==
X-CSE-MsgGUID: L2ehowAZQWqk0r/NTvEgTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254536"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:04 -0700
X-CSE-ConnectionGUID: x+zKuobOROqk+e2cR02x0w==
X-CSE-MsgGUID: Ch4nlKf7TMCIH2lUBzZYiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354505"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:03 -0700
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
Subject: [PATCH v10 11/15] x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
Date: Mon,  6 Oct 2025 23:51:15 -0700
Message-ID: <20251007065119.148605-12-sohil.mehta@intel.com>
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

The EMULATE mode of vsyscall maps the vsyscall page with a high kernel
address directly into user address space. Reading the vsyscall page in
EMULATE mode would cause LASS to trigger a #GP.

Fixing the LASS violation in EMULATE mode would require complex
instruction decoding because the resulting #GP does not include any
useful error information, and the vsyscall address is not readily
available in the RIP.

The EMULATE mode has been deprecated since 2022 and can only be enabled
using the command line parameter vsyscall=emulate. See commit
bf00745e7791 ("x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE") for
details. At this point, no one is expected to be using this insecure
mode. The rare usages that need it obviously do not care about security.

Disable LASS when EMULATE mode is requested to avoid breaking legacy
user software. Also, update the vsyscall documentation to reflect this.
LASS will only be supported if vsyscall mode is set to XONLY (default)
or NONE.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - No significant change. Minor changes to code formatting.

Eventually, we want to get rid of the EMULATE mode altogether. Linus and
AndyL seem to be okay with such a change. However, those changes are
beyond the scope of this series.
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 arch/x86/entry/vsyscall/vsyscall_64.c           | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3edc5ce0e2a3..29a2ee9e1001 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8079,7 +8079,9 @@
 
 			emulate     Vsyscalls turn into traps and are emulated
 			            reasonably safely.  The vsyscall page is
-				    readable.
+				    readable.  This disables the Linear
+				    Address Space Separation (LASS) security
+				    feature and makes the system less secure.
 
 			xonly       [default] Vsyscalls turn into traps and are
 			            emulated reasonably safely.  The vsyscall
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index ff319d7e778c..57498609b1f0 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -63,6 +63,12 @@ static int __init vsyscall_setup(char *str)
 		else
 			return -EINVAL;
 
+		if (cpu_feature_enabled(X86_FEATURE_LASS) && vsyscall_mode == EMULATE) {
+			cr4_clear_bits(X86_CR4_LASS);
+			setup_clear_cpu_cap(X86_FEATURE_LASS);
+			pr_warn_once("x86/cpu: Disabling LASS due to vsyscall=emulate\n");
+		}
+
 		return 0;
 	}
 
-- 
2.43.0


