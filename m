Return-Path: <linux-efi+bounces-6026-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHp1N6sUcGlyUwAAu9opvQ
	(envelope-from <linux-efi+bounces-6026-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 00:50:03 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C62634E1E4
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 00:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 576B59A575A
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jan 2026 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66A41B343;
	Tue, 20 Jan 2026 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSf2NYIo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461913D3311;
	Tue, 20 Jan 2026 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952974; cv=none; b=ElrEoiGV4FsDwP90WtVVleXelRM4vU/akOhcbIGvE/dizKuRGcZxUbYIANxK6xE0gQAGq6JO4I4rAhlqlr1AvxmqxUC95Iv2eX+fuOhx77I22j4KVtoy7Eu404YJyTDvknvgAv99GEZU0HtZ1nUQ9KjErZdTaF0qGrsZ6aImwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952974; c=relaxed/simple;
	bh=tr5aqXtXqDIqs/AOyqWvJ4kVK8DQjii3mFT06ss72IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhwXHLJY2ET/C28NKOhDJoHXvCDnnzdQgo/CmpgyfPYESCOk02WDRbRo2fk4+Rkd+qXYbBEoIgCjSOh2LTru3ks9T804jCSmK5h7ede9f/muW7M+gDx6Cd/7RS7+/wgXnTMHOPpMkPaTFPr7T45US+2iwOsbcEXyEiDWMQjCOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSf2NYIo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768952972; x=1800488972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tr5aqXtXqDIqs/AOyqWvJ4kVK8DQjii3mFT06ss72IY=;
  b=KSf2NYIoDvg2rwjGVg9Ldy+i76AXobt5BzAviqwaq2OzSRo73t1fgkwL
   +HAPieS13Xi0U9zUAXeHJWOaFmgU6GX45CmwB1+q13vuaHFlHYLrIou53
   dPfXy/LLGVQ4Me+uECGKGPmChy7oxCqGCO2Ex/1Sd1idPBbW6PsGow+fD
   qgHcABEPG7DOJvzkLDTZL4VACLL1LOArIGYjoQbFdEofCZpT/ioHBBC8E
   7GXYUa7ijVQQO26vwzKk1xYB3MF/ZpGTsxybx7awbdfhrstr/4aCQHJF6
   jRlNWEeQ4TRgwT6ynIhDXSg0J7LcbnkgXGG1C+EXOBjF1Yi35l4mZ/zgV
   g==;
X-CSE-ConnectionGUID: oECmQO4KSN6sHOJw6dEb1w==
X-CSE-MsgGUID: jBVJevYORBeyDs/ef6Lfdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87752958"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="87752958"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 15:49:31 -0800
X-CSE-ConnectionGUID: BiVEscOqRI2FUHD8Tc5RpQ==
X-CSE-MsgGUID: 1HeeOkkzQOCYPiSIpNC7Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236932647"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 15:49:30 -0800
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
Subject: [PATCH v2 2/3] x86/efi: Disable LASS while executing runtime services
Date: Tue, 20 Jan 2026 15:47:29 -0800
Message-ID: <20260120234730.2215498-3-sohil.mehta@intel.com>
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
	TAGGED_FROM(0.00)[bounces-6026-lists,linux-efi=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C62634E1E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
temporarily by clearing CR4.LASS. Runtime services are called in the
context of efi_mm, which has explicitly unmapped any memory EFI isn't
allowed to touch (including userspace). So, do this right after
switching to efi_mm to avoid any security impact.

Some runtime services can be invoked during boot when LASS isn't active.
Use a global variable (similar to efi_mm) to save and restore the
correct CR4.LASS state. The runtime calls are serialized with the
efi_runtime_lock, so no concurrency issues are expected.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v2:
 - Improve commit message and code comments.
---
 arch/x86/platform/efi/efi_64.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index b4409df2105a..5861008eab22 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -55,6 +55,7 @@
  */
 static u64 efi_va = EFI_VA_START;
 static struct mm_struct *efi_prev_mm;
+static unsigned long efi_cr4_lass;
 
 /*
  * We need our own copy of the higher levels of the page tables
@@ -443,16 +444,50 @@ static void efi_leave_mm(void)
 	unuse_temporary_mm(efi_prev_mm);
 }
 
+/*
+ * Toggle LASS to allow EFI to access any 1:1 mapped region in the lower
+ * half.
+ *
+ * Disable LASS only after switching to EFI-mm, as userspace is not
+ * mapped in it. Similar to EFI-mm, these rely on preemption being
+ * disabled and the calls being serialized.
+ */
+
+static void efi_disable_lass(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return;
+
+	lockdep_assert_preemption_disabled();
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
+	lockdep_assert_preemption_disabled();
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


