Return-Path: <linux-efi+bounces-3959-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF2AE6A16
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF3F18988BE
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4562C1590;
	Tue, 24 Jun 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyJv4hqX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD92C15A6;
	Tue, 24 Jun 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777175; cv=none; b=gEOvk/zRl73N+1Opl2OfIM8WdDKeLxNNkSgaCEOtaTKzcdwzT3mIhPfqDhJtZnYNKI7uU4JZmhPBpc3U1zhTMudOYHAc3q2wU66CvvPO2/d9QLTcpFYwKAuFE8nCC1hE+VQcf0JFw5Sy6g+waNn9IqoashrwFqQ6CYB8y43IE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777175; c=relaxed/simple;
	bh=gSrgyF7nkaMy9jgn9VB3Vel47cqINKRy4i1jm+eFhC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBRjZ7qehAVscQ/GB8mPupSJode605yRo8stBJHGBHa58QYOOgGt5fSdfeasuHcqimi9p9fnOclivyoUpp3yK8qBvQ7NyfRdEy9Ko0vwXFInWUakAQ62JLR2vf5F267btynKxvyiH0chGwslYgNxy0AsROzMzB626K9uFIfEK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyJv4hqX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750777174; x=1782313174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gSrgyF7nkaMy9jgn9VB3Vel47cqINKRy4i1jm+eFhC4=;
  b=nyJv4hqX/s29oTdFDmRKiK+mBNGrOlQPXPaiwQElZPpoV0FIJwuXatS+
   P7DfnLY4XZU9M+dCzTXLU/qut5iXWrZfj4JvbD7tt/z6tA1HUOSOY02Pr
   FZkEMyQDwZO9Baxg8ad28qrlbw68T+W7p9lmuMEmanCfu2pKz2tVI0tlv
   D1SDI04ICER/QVSvZQiYsuRk8WZbjwAE+HmyU0RGjHOHYhv79zGvaSMSq
   W9Jm5ZK2kjUsaQMgR1Ik/ql2Kho7qNikj8uPNaOpw7DExSBtcQGF5io6q
   8fVsUve18Tzm0SB4Bt0JaNFGWh216uiEQg8zWGn6OdxGJNyjnCdg60ltH
   A==;
X-CSE-ConnectionGUID: ukEm/ZceTCmB0pdDf+Musw==
X-CSE-MsgGUID: em1l6HfsTr2T6YMUhj+Puw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64080101"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64080101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:59:33 -0700
X-CSE-ConnectionGUID: IBEM0H0CSQuj9mNcu/owmg==
X-CSE-MsgGUID: gbza5MI9RF2ZS2wYu+XWZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="152435086"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 24 Jun 2025 07:59:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 71D81224; Tue, 24 Jun 2025 17:59:20 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: dave.hansen@intel.com
Cc: acme@redhat.com,
	aik@amd.com,
	akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com,
	andrew.cooper3@citrix.com,
	ardb@kernel.org,
	ast@kernel.org,
	bp@alien8.de,
	brijesh.singh@amd.com,
	changbin.du@huawei.com,
	christophe.leroy@csgroup.eu,
	corbet@lwn.net,
	daniel.sneddon@linux.intel.com,
	dave.hansen@linux.intel.com,
	ebiggers@google.com,
	geert+renesas@glider.be,
	houtao1@huawei.com,
	hpa@zytor.com,
	jgg@ziepe.ca,
	jgross@suse.com,
	jpoimboe@kernel.org,
	kai.huang@intel.com,
	kees@kernel.org,
	kirill.shutemov@linux.intel.com,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux@rasmusvillemoes.dk,
	luto@kernel.org,
	mcgrof@kernel.org,
	mhiramat@kernel.org,
	michael.roth@amd.com,
	mingo@kernel.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	paulmck@kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	rppt@kernel.org,
	sandipan.das@amd.com,
	shijie@os.amperecomputing.com,
	sohil.mehta@intel.com,
	tglx@linutronix.de,
	tj@kernel.org,
	tony.luck@intel.com,
	vegard.nossum@oracle.com,
	x86@kernel.org,
	xin3.li@intel.com,
	xiongwei.song@windriver.com,
	ytcoode@gmail.com
Subject: [PATCH] x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall
Date: Tue, 24 Jun 2025 17:59:18 +0300
Message-ID: <20250624145918.2720487-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <265eef27-aecb-479e-a293-c2e88d69e6ec@intel.com>
References: <265eef27-aecb-479e-a293-c2e88d69e6ec@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emulate_vsyscall() expects to see X86_PF_INSTR in PFEC on a vsyscall
page fault, but the CPU does not report X86_PF_INSTR if neither
X86_FEATURE_NX nor X86_FEATURE_SMEP are enabled.

X86_FEATURE_NX should be enabled on nearly all 64-bit CPUs, except for
early P4 processors that did not support this feature.

Instead of explicitly checking for X86_PF_INSTR, compare the fault
address to RIP.

On machines with X86_FEATURE_NX enabled, issue a warning if RIP is equal
to fault address but X86_PF_INSTR is absent.

Originally-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/all/bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index c9103a6fa06e..0b0e0283994f 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -124,7 +124,8 @@ bool emulate_vsyscall(unsigned long error_code,
 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
 		return false;
 
-	if (!(error_code & X86_PF_INSTR)) {
+	/* Avoid emulation unless userspace was executing from vsyscall page: */
+	if (address != regs->ip) {
 		/* Failed vsyscall read */
 		if (vsyscall_mode == EMULATE)
 			return false;
@@ -136,13 +137,16 @@ bool emulate_vsyscall(unsigned long error_code,
 		return false;
 	}
 
+
+	/* X86_PF_INSTR is only set when NX is supported: */
+	if (cpu_feature_enabled(X86_FEATURE_NX))
+		WARN_ON_ONCE(!(error_code & X86_PF_INSTR));
+
 	/*
 	 * No point in checking CS -- the only way to get here is a user mode
 	 * trap to a high address, which means that we're in 64-bit user code.
 	 */
 
-	WARN_ON_ONCE(address != regs->ip);
-
 	if (vsyscall_mode == NONE) {
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall attempted with vsyscall=none");
-- 
2.47.2


