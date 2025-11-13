Return-Path: <linux-efi+bounces-5501-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A42C5A636
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97C574E80B1
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A497328612;
	Thu, 13 Nov 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gG8uvZO4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510283271E6;
	Thu, 13 Nov 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073923; cv=none; b=HH0JUcckxwItoIw0dVF+2RAf2aVy9MMZ2OhQjrs7wQd+Foqeh7Sg83Il+Qev/HLpUCqsBnP1l59aNODuqd+uIeiM2Ywr6c5cU/A5+DrkRXGC6SSuCGWjVa6HpIl1eWxuPGhhG1bk/+3WEnhfgdhw4XbYA9xlZTQLDOmdJBU/xfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073923; c=relaxed/simple;
	bh=8d3y0tuH+JUD4QfSiQiDm9n5LoaQCNgr1flLLNl4hIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3OvCEygsdgVMnBy6q0o+IVKwXjXRkBy12JL+HYstLyCjBq+fgZc/g15bn7JSXjIi0qQW62Wgf5yQfyTAoI40Pu7oNAMkhkMFREo5GyzTpX/LdnJmgfvLpz94ErXZGYBOEUppDV8ww1Ycb/zm4KUVGZz+PCZgfPfDEDXXi2HATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gG8uvZO4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073921; x=1794609921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8d3y0tuH+JUD4QfSiQiDm9n5LoaQCNgr1flLLNl4hIs=;
  b=gG8uvZO4y2mKMn0bx/zyMQt0xrqD9eUKLAWpOoBlWouTL3jUcOl869KH
   AeafT6BiQqXY5XE0ZOrq3E4fy/5tjIrQbicgc5jLNab7r6TnrkVYVY4dd
   lVJD5vX2jEBrozFw1F/1wcBSi/C41CawBjKeY/5BUUQccggKnz1oeyMNg
   iqO5TVyIfFHiMF6gd3R1OFIlncNl3WEEcJPBYMJI4O2oaMDR+LOUeXxoV
   QibgBqjp8lw4rvpKzIuUNhR8fwfd8cs/uztEA7OK3+xayndxURCzqM2VH
   6abc86OJr+nuYTk8IPnzFdhvKF2DansNqsFTAy5luC7VNOjfVJGvqtFzK
   Q==;
X-CSE-ConnectionGUID: NW7lxVjNQRSSaK3Msy5dxw==
X-CSE-MsgGUID: RDir1IuQQluj3iePe43Upw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051955"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051955"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:18 -0800
X-CSE-ConnectionGUID: W9e7q+1JSKeTswLKg78olA==
X-CSE-MsgGUID: D/llQ+22SlOQa0E9bRNSQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611095"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2025 14:45:17 -0800
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
Subject: [PATCH v12 5/8] x86/kexec: Disable LASS during relocate kernel
Date: Thu, 13 Nov 2025 14:42:01 -0800
Message-ID: <20251113224204.50391-6-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113224204.50391-1-sohil.mehta@intel.com>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The relocate kernel mechanism uses an identity mapping to copy the new
kernel, which leads to a LASS violation when executing from a low
address.

LASS must be disabled after the original CR4 value is saved because
kexec paths that preserve context need to restore CR4.LASS. But,
disabling it along with CET during identity_mapped() is too late. So,
disable LASS immediately after saving CR4, along with PGE, and before
jumping to the identity-mapped page.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v12:
 - Pick up review tag.

v11:
 - Improve commit message.
---
 arch/x86/kernel/relocate_kernel_64.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 11e20bb13aca..4ffba68dc57b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -95,9 +95,12 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Leave CR4 in %r13 to enable the right paging mode later. */
 	movq	%cr4, %r13
 
-	/* Disable global pages immediately to ensure this mapping is RWX */
+	/*
+	 * Disable global pages immediately to ensure this mapping is RWX.
+	 * Disable LASS before jumping to the identity mapped page.
+	 */
 	movq	%r13, %r12
-	andq	$~(X86_CR4_PGE), %r12
+	andq	$~(X86_CR4_PGE | X86_CR4_LASS), %r12
 	movq	%r12, %cr4
 
 	/* Save %rsp and CRs. */
-- 
2.43.0


