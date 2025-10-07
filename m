Return-Path: <linux-efi+bounces-4976-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF752BC06E0
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A16A3B3F3C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C925F994;
	Tue,  7 Oct 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaW6s9Qx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA02586C2;
	Tue,  7 Oct 2025 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820050; cv=none; b=DArBFPhpDJbpTntBQWdDL58+9Uxg29PLorZ3dMCCYy0OQiOogYKmSFF2yNjN4sZ8FgvXlAbWHVZXKv8LQM8RZzEKF0Yn2Es3CXTfkX9zEq2bWUHnePBfdzCJ9JRFMe8q65k4reNl5whStnabW0tjhz+catfafx9DQ3b/UVmaDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820050; c=relaxed/simple;
	bh=jO/CITRZpotiM7BR0pycN3I+eaS0MSM1mW3jR69WgKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Teir/OEZs2ebpyFQ+R/x4D/qE/y5puZMnBFVm3nImwPYjvBAoqNV1tQBQJj/sqGGmDlh+ej4vapV1ZdICXmHlIEiubB9eQF/QAOzcbD3qWPF44rgfYw5CcXEk2+whqsET7SjohQxzUFtlMDVSvKQMmb0YYbvhOUB1v4EIKgnExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaW6s9Qx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820048; x=1791356048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jO/CITRZpotiM7BR0pycN3I+eaS0MSM1mW3jR69WgKQ=;
  b=ZaW6s9QxQuP2O5TtMorwFvjGrgfBbkgQKiglyxf6OI4/R0TpSAJEmI7M
   Zc+916ORkRAMwaTeaf7AdUGJVXUUmbPvACvofTguokJTIE8NR42+0JaoR
   PnUCO3iwtDBXho+rbu1duOYJcDWBJkRoHLovJPlJVsDRiaznfI1iTYxGO
   1D0F1fM5M3HTlcRyiEosqqa5sMIzGOWRGUjEcGWjqyexvDk1EbjuV1i0Q
   g8SMH2YRsQhGbj/eeXwOiKgRjGqXOTvtoBXiDz/iuMKi/IK72h0iABxHO
   OY5HSuJf1TNrjKSVvYtBDeZhXMoQ0i9OfIJF/Lf1sk+xfGAJHcFw154fw
   Q==;
X-CSE-ConnectionGUID: QbQ8/xqKSmiJMSmF5zn9FQ==
X-CSE-MsgGUID: e7rQdQc0RcayQzZUhQT1VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254595"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254595"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:07 -0700
X-CSE-ConnectionGUID: kSpwjkZBS4egwnjDdYeLNQ==
X-CSE-MsgGUID: F5tz/hZmR4Omncq0SUAkqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354532"
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
Subject: [PATCH v10 15/15] x86/cpu: Enable LASS by default during CPU initialization
Date: Mon,  6 Oct 2025 23:51:19 -0700
Message-ID: <20251007065119.148605-16-sohil.mehta@intel.com>
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

Linear Address Space Separation (LASS) mitigates a class of side-channel
attacks that rely on speculative access across the user/kernel boundary.
Enable it by default if the platform supports it.

While at it, remove the comment above the SMAP/SMEP/UMIP/LASS setup
instead of updating it, as the whole sequence is quite self-explanatory.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10
 - No change.
---
 arch/x86/kernel/cpu/common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 57d5824465b0..7f0f1b56cbe7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -401,6 +401,12 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
+{
+	if (cpu_feature_enabled(X86_FEATURE_LASS))
+		cr4_set_bits(X86_CR4_LASS);
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED |
@@ -2019,10 +2025,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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


