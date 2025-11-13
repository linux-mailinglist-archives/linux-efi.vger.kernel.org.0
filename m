Return-Path: <linux-efi+bounces-5498-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD109C5A5EE
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690D53B153F
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540223271E8;
	Thu, 13 Nov 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQvZAs4e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08E326956;
	Thu, 13 Nov 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073921; cv=none; b=jAaVuy6MGLlVGUA3AErmhpeJeFW1Lxtbmc+twAAqwp9LX1TP+MfVjrTqSUNpU4oYQ0btJMndJBrlVIXT3MHQMxZogU6chIPyXbTGeKqLQUYhd26HNbVHCkljkaGbsNBDUF7LZ6KsGSY0+qkivo22uqcVBgAAz5vCVrxzvwbnP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073921; c=relaxed/simple;
	bh=m0p/Fqdj/eRp0iccSvGc99dMObdenY1CDe3HNWqJxKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhFOQ2PXYEHFOyGhW8PXRuO/eG814ugcmXD5+/21eZZlTrqs85+p3GowSKPUYB3COOm6fhAI5htOasNWgVSuJKlY4SkIq8TduvnM28NboBrZ6s8ZGBlx7Xhxuwp+bbj4PeARHckaU5Fs/mqojEPfhrG09HgAjQp8QkvZL00JINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQvZAs4e; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073919; x=1794609919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m0p/Fqdj/eRp0iccSvGc99dMObdenY1CDe3HNWqJxKw=;
  b=KQvZAs4ePgBOD7OvOMAMk4Nvx9IMDmRI/+BTjSWCepK+xEmGM94q8aOd
   Jo6ewY0JwPjEs+3zEOGsD7fj89usrtWlxfOzOH6BZVpQ1SRlXNwwxo9lP
   MhGD2gVmo96XGvTPJD6H/bm5RK5Dm31Kr0Dps5ROsM13t6wHRKceZaA6O
   21r2EH45Qo4vpUNoBIIFLcm9zMaBL+Ar+2aHZVKIOPEiZoViPgoD1i2wS
   SqDpPyxNLeU+wPtEMGrsuE5wnXbHE/ezG5ZwIx2E5Cc8yJwdk6dIOULSs
   k1CMBx1bXfijZIesuZcN+xdpyVkYkeVR6JQKlQbKEc22ebWuV6Dlv4ooL
   w==;
X-CSE-ConnectionGUID: 2vR9V+1jSXWpa4o0dzFV6w==
X-CSE-MsgGUID: J2S5yswzQZO8RNa0t2mwEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051912"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051912"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:16 -0800
X-CSE-ConnectionGUID: zRFYNAJISp6EPC71UBuD5A==
X-CSE-MsgGUID: eR1d7Rp+S4ChXh+J3vWwWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611084"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2025 14:45:16 -0800
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
Subject: [PATCH v12 2/8] x86/cpu: Add an LASS dependency on SMAP
Date: Thu, 13 Nov 2025 14:41:58 -0800
Message-ID: <20251113224204.50391-3-sohil.mehta@intel.com>
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


