Return-Path: <linux-efi+bounces-5244-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15312C1D5CB
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E29F189ABC9
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242C320A05;
	Wed, 29 Oct 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjBYlB7t"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E187319609;
	Wed, 29 Oct 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771977; cv=none; b=F5nC37pMGNjMktY6NqngpSGOICFRwUNvuPo96LLtep5rI/A3NbK7hgLutpLUyNDXVQDH+loE5J6I5wZdoI4UXa6nWWVYYCOjzj1Eo8GlzI4oh8vlcjMUmPthO9wB+ScO2ZcVkN1R69wSJr8Q/ghm7BqYys7JfWNIZjwwqAxnB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771977; c=relaxed/simple;
	bh=RWXHUqY7TWZ+J1qtks3FVxDXc89CRjSLve0F0cWVWj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwjiYoBD+WyFO4qVBSh9XZ9Y5N3zdG7NIV4T/dNBBarSq6MFRPV6q8BYHIDjCuGtAks+oYG1dDT8+VUCKACLhBtrhZMmi5OAOyKACgIBUVuT+mAOQ16YHNXM8Qg3YxwInAfjuXL8YVvH1AgO2RNak16CtR3OfhPVWjp1z+xQvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjBYlB7t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771976; x=1793307976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RWXHUqY7TWZ+J1qtks3FVxDXc89CRjSLve0F0cWVWj8=;
  b=cjBYlB7t3G7oSfGPc7megZT+KI2y7O0snaNDJPzMSzJ0w/Ir/mftrKiT
   sbaQBsfvrjt4q3vyCEXH+0+OWDsmHEJxKM8uTGh1+J6ng7FoiV5b5Jt7F
   TGyBt858I8mI7+YVY94telsEFWSVVftu1QGMSOhowqZyrfGqjrq63rTac
   VYGB8fAQctcNdD1lmj2zlb1yAdCq9q5WVRW2siFzhAi+Pc5l2ah2VAqYj
   S9muQDX8qCYVofU6Q0Sf2YePU72cfWinwKKa9c9Hn7R4X7uBxwHP6VNXd
   jN97jOPHdLofX0qKFVE2y3Iamd0d0vjV8sdrHpABWEWTyQDtNGPOSZluN
   w==;
X-CSE-ConnectionGUID: 038CFlQBS8um0nlK/7L8Gg==
X-CSE-MsgGUID: 2Jv29ZqSSim1vEG0V/z1nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002742"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002742"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:14 -0700
X-CSE-ConnectionGUID: hMP5CQsBRr2dAuMSbnMhFA==
X-CSE-MsgGUID: MbtjtTbmR1uC0TqlHkfhjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216431999"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:14 -0700
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
Subject: [PATCH v11 6/9] x86/kexec: Disable LASS during relocate kernel
Date: Wed, 29 Oct 2025 14:03:07 -0700
Message-ID: <20251029210310.1155449-7-sohil.mehta@intel.com>
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

The relocate kernel mechanism uses an identity mapping to copy the new
kernel, which leads to a LASS violation when executing from a low
address.

LASS must be disabled after the original CR4 value is saved because
kexec paths that preserve context need to restore CR4.LASS. But,
disabling it along with CET during identity_mapped() is too late. So,
disable LASS immediately after saving CR4, along with PGE, and before
jumping to the identity-mapped page.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v11:
 - Improve commit message.

v10:
 - New patch to fix an issue detected during internal testing.
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


