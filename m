Return-Path: <linux-efi+bounces-4968-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63335BC06DD
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D064F4DF7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABE624466B;
	Tue,  7 Oct 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhpkkTgL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356E23BD17;
	Tue,  7 Oct 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820044; cv=none; b=f2sljcQjm/l7sleUKK1CjRtuHks8tyqsM0qijbU0JC1Jh80SVtaqRA1YvKhw8R0Eie+qkWstSNJQeB/TMjeqH66VKFkniBKYh3n9knTPzA2XM7mrJSwaR/9F/nrFJRv5g+K8BnqMfZ7sGXOXdxI7h1FmqO5UEoNEJJtqDb23fDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820044; c=relaxed/simple;
	bh=hIq1Gw3KtkiqpD02POfZXf3xLAd/wm5guqT+PTGj6r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC9KKKJ8ot/HP5KUV5PccHHvb9/Mv/Tu4mzOt7ycP4aHa4ejJGBgnopIMGe2Ac5zyV3mJoGCLAb3vYVB0slvgCLRsKYG+wnTZgyjEoeIfq1AwaslIS2d40OSJP6ddcaXtPAjHB8kBlJkyaFu9ZVkJ1+T/TP4QhsC/rx2BATHZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhpkkTgL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820042; x=1791356042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hIq1Gw3KtkiqpD02POfZXf3xLAd/wm5guqT+PTGj6r0=;
  b=mhpkkTgL4+AABfPbbEcgRlSWPsG+s9pAqtkFhJqRf6/u6ZB0Y5XLSa5L
   zoW1wAoYynGvrmmwqV2EeEBCBIrY8uAzDb03B0zXVdNMYWpL8cYZYFSOk
   6/MxbYs1nRzOtN5Dp7RNaicuoqHdBpAAdKBu49B4r9qQoEFxCzSSyyldI
   OcxE0wPijm9gPL0WoJvPyC+9PgTxUqMg+WzcmRCxrrMrigPbY3rfhH1c8
   5V2GlavoeN/9Hk3TO5EX2KJeGzwDhwKVgYjB1u1BAiMQhA0iFmPLUB6AH
   w8Q1QzJMnP6KVuDGk5B5YV1FN7dRVrlAfDsHuGt06Kx38QFSL69UvhtB0
   w==;
X-CSE-ConnectionGUID: uTOOz0QvRjWgEbYEsmFpMA==
X-CSE-MsgGUID: 7sUzfKCJTb+5byTcJu2gbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254478"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254478"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:01 -0700
X-CSE-ConnectionGUID: tuhU5btZS7y2fiJuYV/SCg==
X-CSE-MsgGUID: ZzewQD2lTIOQBCHmq4O71w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354487"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:00 -0700
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
Subject: [PATCH v10 07/15] x86/kexec: Disable LASS during relocate kernel
Date: Mon,  6 Oct 2025 23:51:11 -0700
Message-ID: <20251007065119.148605-8-sohil.mehta@intel.com>
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

Relocate kernel uses identity mapping to copy the new kernel which
leads to an LASS violation. To avoid issues, disable LASS after the
original CR4 value has been saved but before jumping to the identity
mapped page.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
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


