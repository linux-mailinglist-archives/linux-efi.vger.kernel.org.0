Return-Path: <linux-efi+bounces-6025-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAjnKsQXcGkEVwAAu9opvQ
	(envelope-from <linux-efi+bounces-6025-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 01:03:16 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775A4E413
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 01:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE14F0940
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jan 2026 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF5413242;
	Tue, 20 Jan 2026 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJq9io/D"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443643D3CEB;
	Tue, 20 Jan 2026 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952973; cv=none; b=fwvlPbUb/dBxpISycK5Pl28DvvPQBAdK6yhpajFu0OYsU4O8BVSvYNgWf8QVR9gIQOnvX3B9L5pTMKQXo5KrE/bxq3bkb04dLFdJVjQDXpOxvCZMp2vjgVZUC3dHGhH2bIgtYqsr4yI4CGSZkE3FTsWsjcs+5QWwv+DE9fllQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952973; c=relaxed/simple;
	bh=zNmBho9MasUBWyYqXc5abaClEA1oHFkqJ35gb6EKTtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFu1govO6Z+OQmOe+EGS9XmE7chfBwKjbouOY74LkBp57Qw6JOLaWixxwmq6XV3RA6wRS7KZd+GjlN7HuF8AJ/k9C45MfeZZHIH95/49qLUXeLo9tPx6JqrusIENtxnghHgZaVp2rGaRY2WzZNLLAtAsBHkc9tvHyUWXGarVUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJq9io/D; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768952971; x=1800488971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zNmBho9MasUBWyYqXc5abaClEA1oHFkqJ35gb6EKTtA=;
  b=kJq9io/DUO9t+B5/qRw9fL4hdbV5u7TFVtC6rsdc93W9JHnnzJnyZpHh
   D1wvnLvwEA9kUlsP/8lri2mWphm5ikAyoqYYn2T16oYuWN0rFp434HiAh
   VlqiucQgvPr9pu9UgCTEZXkGXRPrVGdIeRGJkS5ayGckoz46AYUrDQlvp
   prThDpnEQwGjrAKbXm8lgslRmVDgDLxUcb2/qVDgeA5cYiAjHssdb43yK
   Ue9CY9kONq95YGFhnWmUvknmJonj9uJIJaV5Im88UhsopFQm+rbRjyYM7
   Kn7wNmqfikakh9sb0qpn3ALi5JMuNVxKXaTtG+pZjPYlIMhxYyVWhLzTh
   A==;
X-CSE-ConnectionGUID: hkiQB+fRTv6Rz7GG7WKT0g==
X-CSE-MsgGUID: kv2EyQfITp+s0kPrFeMkbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87752949"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="87752949"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 15:49:30 -0800
X-CSE-ConnectionGUID: 93eYZDFIQPy67lqUY1Fl2w==
X-CSE-MsgGUID: JlocmBeUQn+fZ54btWH/rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236932644"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 15:49:29 -0800
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
	"Kirill A . Shutemov" <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 1/3] x86/cpu: Defer LASS enabling until userspace comes up
Date: Tue, 20 Jan 2026 15:47:28 -0800
Message-ID: <20260120234730.2215498-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120234730.2215498-1-sohil.mehta@intel.com>
References: <20260120234730.2215498-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6025-lists,linux-efi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,linux-efi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 4775A4E413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

LASS blocks any kernel access to the lower half of the virtual address
space. Unfortunately, some EFI accesses happen during boot with bit 63
cleared, which causes a #GP fault when LASS is enabled.

Notably, the SetVirtualAddressMap() call can only happen in EFI physical
mode. Also, EFI_BOOT_SERVICES_CODE/_DATA could be accessed even after
ExitBootServices(). The boot services memory is truly freed during
efi_free_boot_services() after SVAM has completed.

To prevent EFI from tripping LASS, at a minimum, LASS enabling must be
deferred until EFI has completely finished entering virtual mode
(including freeing boot services memory). Moving setup_lass() to
arch_cpu_finalize_init() would do the trick, but that would make the
implementation very fragile. Something else might come in the future
that would need the LASS enabling to be moved again.

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
v2:
 - Add code comments for clarity.
---
 arch/x86/kernel/cpu/common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e7ab22fce3b5..cefd0722e6cc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -422,12 +422,33 @@ static __always_inline void setup_lass(struct cpuinfo_x86 *c)
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
 
+/*
+ * Finalize features that need to be enabled just before entering
+ * userspace. Note that this only runs on a single CPU. Use appropriate
+ * callbacks if all the CPUs need to reflect the same change.
+ */
+static int cpu_finalize_pre_userspace(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return 0;
+
+	/* Runs on all online CPUs and future CPUs that come online. */
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


