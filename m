Return-Path: <linux-efi+bounces-5603-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F96C6B3DC
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 19:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 635464E7410
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15172E03EA;
	Tue, 18 Nov 2025 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoyV7cRw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3DF2DBF4B;
	Tue, 18 Nov 2025 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490895; cv=none; b=e+XajmXV/Kjs9g1z9RgKiW1lzaimQeVUwTx2Yt35UBd6YjocNMqaHh2G6Ha149CeCPu7vmeMzNjvRTh3aP3TzntBnOYB4xZh3+6c/n6JV9fi1vTn4iGkYbH171iOIPQHmFMVd40df4ynMPldJGnhBmDMBwtZOmF2+Z/AiDD0OMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490895; c=relaxed/simple;
	bh=8d3y0tuH+JUD4QfSiQiDm9n5LoaQCNgr1flLLNl4hIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVU8bBEXrE1dPKKR3wEOHFJx7uF9agxAwMUXlCZume2UGvQmcJleHKraWiKAkWuxUeYjB/d6PK8CD7hAfoq0u4WYFluexbFWMvMShYKFo5grqXgd3JJz9RyfLWWqJgTG9aRcH5Zvch7q2tMK25lTgqxGxSMaoZz2O1OLY+ZZwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoyV7cRw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490894; x=1795026894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8d3y0tuH+JUD4QfSiQiDm9n5LoaQCNgr1flLLNl4hIs=;
  b=QoyV7cRwB73rjVeuTHZY6oIo0hju5HsfcMug/VbLnBaiojmNzm257V68
   z2URUzseIVx3A4FozrTHb2c1DAnFBH9SwQjp8mElGRvURA0dJ8Dp/RiYb
   tK6GZuMu8HOB7U7KZ5Ewt1sSKzm/E6RaVIptxNqVOM4zpHdxpRJ9UfF7q
   OuEke+/fRJlH5o54slptsCJ3qubrV3GEOCVynC10CylaKjmuQGoh4223J
   ALlbbIdLuv2QOPdcqgQqo5Fj86cW4fPwpdGzGuEdMMqIHApVt/fZ2k4zf
   UvOWr4CXpsKnD0SA9tObSlj7388E7zAHEf/cY7i99JAIWA0NZRge6MlEu
   w==;
X-CSE-ConnectionGUID: IZ272lcBQ72aqHVxGjnXsQ==
X-CSE-MsgGUID: 7I7DHdf6QFy6SVYQaQjDpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76979883"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76979883"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:56 -0800
X-CSE-ConnectionGUID: PRQHp1SLT8+yYXwzNhEANg==
X-CSE-MsgGUID: wG00PbBiQtq7a5pnFZwRcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190088946"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 10:31:55 -0800
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
Subject: [PATCH v13 5/8] x86/kexec: Disable LASS during relocate kernel
Date: Tue, 18 Nov 2025 10:29:07 -0800
Message-ID: <20251118182911.2983253-6-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118182911.2983253-1-sohil.mehta@intel.com>
References: <20251118182911.2983253-1-sohil.mehta@intel.com>
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


