Return-Path: <linux-efi+bounces-5247-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65694C1D5F2
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133F03AA974
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2C35A927;
	Wed, 29 Oct 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkNFSSjW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2B320CD6;
	Wed, 29 Oct 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771979; cv=none; b=q6sh9Zpq6bO80KzgBtCUpmR5V32ehb/Tgf0julnhs5Uq+pEzqkQ4bEM01Pn1pBcp+bjz0sqvTdZSed8Fp1PAPLNO+7PgT2nhKXcUTomPr69Hr+dJhvfWQH54D6wr9fZ3dz4CkGAzIG5AqcDmqqqP/FlznZAsaUoHpPZAv7Y5KjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771979; c=relaxed/simple;
	bh=Np5CMFbWfUmbU6MayjZ40pxjcZnyi9oeks/j+smFIbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxfMikhN5zJ+5bkMPaocslvTYFDqsxvdlbx3EeboTb6iSe3WUc8qSXq4p7WftutoIdPEERu0Ytm1FAVKYfUAVaFrZPqdXV+SunaDdQqd6RYlqaVFJeYXDGt45G8H2G0CG+ThiSNTA5izwhLUoqhtomlkwTTK2BLTVkAIhDbB9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkNFSSjW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771978; x=1793307978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Np5CMFbWfUmbU6MayjZ40pxjcZnyi9oeks/j+smFIbo=;
  b=OkNFSSjWU5/kAdKnvf6VcexPVvKd8c1x8IaYy65x74JcKpAu/c0LHtGU
   jOAZ+uWlJsyksipomavlXUlGXByn3NGtakCEKojIbBDKBoewJSuiap4KW
   MWzzSMNjdSo6aAN9xi1oyqP5LK+Lmglqta6Db05npUsgmZz6LtEHcdu5Q
   QUawcDnv8hultVtZuwh/WJMab8n+q11zvsrB7IO8bLOmyV8ZyCwQPBhy3
   aNSFFPwTXlJNga5E5oCN+E9mV5ERT/c84DWgKnTXXzahCAxvzEc9TowQr
   p2gsdaXkKCD4k7g2bDsrbl14wlcfsN1B/+iTL/ojCi7WOx842AHbFilZH
   Q==;
X-CSE-ConnectionGUID: 9prTzSlOS1+C5aakqn1MAw==
X-CSE-MsgGUID: 0yND17ZeSRC2/VOi+EPefQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002745"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002745"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:16 -0700
X-CSE-ConnectionGUID: hzvYjJXbTG6vTHQfvsUQgA==
X-CSE-MsgGUID: cmBIxFr2RDCHUhRKjX2Oog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216432021"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:16 -0700
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
Subject: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU initialization
Date: Wed, 29 Oct 2025 14:03:10 -0700
Message-ID: <20251029210310.1155449-10-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029210310.1155449-1-sohil.mehta@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linear Address Space Separation (LASS) mitigates a class of side-channel
attacks that rely on speculative access across the user/kernel boundary.

Enable LASS by default if the platform supports it. While at it, remove
the comment above the SMAP/SMEP/UMIP/LASS setup instead of updating it,
as the whole sequence is quite self-explanatory.

The legacy vsyscall page is mapped at 0xffffffffff60?000. Prior to LASS,
vsyscall page accesses would always generate a #PF. The kernel emulates
the accesses in the #PF handler and returns the appropriate values to
userspace.

With LASS, these accesses are intercepted before the paging structures
are traversed triggering a #GP instead of a #PF. To avoid breaking user
applications, equivalent emulation support is required in the #GP
handler. However, the #GP provides limited error information compared to
the #PF, making the emulation more complex.

For now, keep it simple and disable LASS if vsyscall emulation is
compiled in. This restricts LASS usability to newer environments where
legacy vsyscalls are absolutely not needed. In future, LASS support can
be expanded by enhancing the #GP handler.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v11:
 - Disable LASS if vsyscall emulation support is compiled in.
 - Drop Rick's review tag because of the new changes.

v10
 - No change.
---
 arch/x86/kernel/cpu/common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512914ca..71e89859dfb4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -401,6 +401,25 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
+{
+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
+		/*
+		 * Legacy vsyscall page access causes a #GP when LASS is
+		 * active. However, vsyscall emulation isn't supported
+		 * with #GP. To avoid breaking userspace, disable LASS
+		 * if the emulation code is compiled in.
+		 */
+		if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION)) {
+			pr_info_once("x86/cpu: Disabling LASS due to CONFIG_X86_VSYSCALL_EMULATION=y\n");
+			setup_clear_cpu_cap(X86_FEATURE_LASS);
+			return;
+		}
+
+		cr4_set_bits(X86_CR4_LASS);
+	}
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
@@ -2011,10 +2030,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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


