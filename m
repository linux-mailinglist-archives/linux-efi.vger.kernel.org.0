Return-Path: <linux-efi+bounces-5600-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A84C6B3AE
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 19:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C4AB365A81
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AA2DC32E;
	Tue, 18 Nov 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djy2KStH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF112BD582;
	Tue, 18 Nov 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490881; cv=none; b=ldn7Y/VlWESyTVz2L86clTCuUHJYoZOPivGO+51wNAlyjGHF4I/a8KuhJNkkva2WJXYBvenFE45vtbHjh0m0d38zOtvZo2CUMHMf6OdZtlIVMKi089vY8TTU9ccWMgMwKQC+gjxzRV+KZwZc251v9bdRNOxFhs+5dS4RdWz5G+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490881; c=relaxed/simple;
	bh=m0p/Fqdj/eRp0iccSvGc99dMObdenY1CDe3HNWqJxKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSc3CJm+LTiVmecHlinL2YzAkEEzHxOX9RdAjRwGtLxtcQWnx/XGFVY7JIIt3t5GV6/CCj/6WyHCS+ym3njRnib6jWHIkXHKDZkGPvo5swSWHJMtHp+znhkru+eaYSEbrEwAxQLSfdpOPzVxNJq75acKVkDKgUj1pkOURi5emBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djy2KStH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490879; x=1795026879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m0p/Fqdj/eRp0iccSvGc99dMObdenY1CDe3HNWqJxKw=;
  b=djy2KStHEnJehU/QY8TfnSqxZy0fLM2LV+wBihRQyO+iTllB2mFvy3lP
   uSS5Sji7RXEDdBW7uxD4gUSig/p4jgXX6l81Dn9HGQC453r9DVYwGj33J
   pl8aKG2/ep95Je7cxW286TezyeeR/Z9TT+NyBSS1d2q+ftHjJ+o3v239o
   3gSstZMj0n7qXwx4tn0a6IEHLQivKRoJqtVaTPAfNSPO8qByapunmzrPH
   GZTo0y0F9G7i4ajE17OsDvJG4pKWu7wj0FsCJzTq/lZAZ7kCio0I6IkeE
   PM8xPNb7wOpFwQg/NUeSJoVlfuVCCHialHt2AoELVQyDYuxN8gRs+eFd2
   w==;
X-CSE-ConnectionGUID: WCoaotBaSAmKLf+UZhqfxA==
X-CSE-MsgGUID: hqmNDr+aQFicoVN/HRCgpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76979781"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76979781"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:53 -0800
X-CSE-ConnectionGUID: SF+xF0xrRi2E4PnlOTD3mQ==
X-CSE-MsgGUID: Oa01vVCPTa6am3bGN5J5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190088925"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 10:31:53 -0800
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
Subject: [PATCH v13 2/8] x86/cpu: Add an LASS dependency on SMAP
Date: Tue, 18 Nov 2025 10:29:04 -0800
Message-ID: <20251118182911.2983253-3-sohil.mehta@intel.com>
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

With LASS enabled, any kernel data access to userspace typically results
in a #GP, or a #SS in some stack-related cases. When the kernel needs to
access user memory, it can suspend LASS enforcement by toggling the
RFLAGS.AC bit. Most of these cases are already covered by the
stac()/clac() pairs used to avoid SMAP violations.

Even though LASS could potentially be enabled independently, it would be
very painful without SMAP and the related stac()/clac() calls. There is
no reason to support such a configuration because all future hardware
with LASS is expected to have SMAP as well. Also, the STAC/CLAC
instructions are architected to:
	#UD - If CPUID.(EAX=07H, ECX=0H):EBX.SMAP[bit 20] = 0.

So, make LASS depend on SMAP to conveniently reuse the existing AC bit
toggling already in place.

Note: Additional STAC/CLAC would still be needed for accesses such as
text poking which are not flagged by SMAP. This is because such mappings
are in the lower half but do not have the _PAGE_USER bit set which SMAP
uses for enforcement.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v12:
 - Pick up review tag.

v11:
 - New patch (split from patch 1).
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 46efcbd6afa4..98d0cdd82574 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -89,6 +89,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
+	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
 	{}
 };
 
-- 
2.43.0


