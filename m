Return-Path: <linux-efi+bounces-5240-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1BC1D5B8
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1A5403DE7
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED03191CC;
	Wed, 29 Oct 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6VqMoD7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD93164DB;
	Wed, 29 Oct 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771975; cv=none; b=Lme84lAEpim8fBsR5vr0GqLwJmYo4JvhOa3cuH2t6nFZg1UyeYPgp4KA4rkQlmd1UVecRH/Qo1Aw1/ZT5YtI9Os60328sulI/r9yBXXojCEwaub43fS4qugrTDtJL3h3xrPVAjVr5lc+YdvVKr6nC4esMsMQdMSGkyVQTtnDDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771975; c=relaxed/simple;
	bh=LXJVFUz2Qv2IBhxWy4eXgdpAinFwIk1V8yZkKyzmCX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIkCImAlDMXOT1HINwPrSRnaXr/tJ5C4O3UGoQlypc41ATOKcNkPcSJ6f8VDUSwAJAmeFsnQ+ptQcK8m+r62OOvXbvOJLsjCcFEGCNDY+R/yaH+EzM/X02MprlM1rEzRl3m7o196r/tuTdg9G02RsUeJ08yVDz/LpN4vxjCSGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6VqMoD7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771974; x=1793307974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXJVFUz2Qv2IBhxWy4eXgdpAinFwIk1V8yZkKyzmCX0=;
  b=L6VqMoD7purJ+ESrZ8TUVna8LgcDWPQcewoeBQ90zw44vwKjPgipAJUG
   i4h2zLwZAUJXtK8DRcB5LS2PqhLFIdwkIujZ167Ewuu6czSjfVyJm6A/q
   ozSQ6KFQSmaNKVqJqaPehREvI8jS64ZJ3Jv3ntQBvEdE2BN9GkE1uW2k+
   XSefINDFngVAGElzBWL5uaiPN9iL97ypPMY568fK5I2PteZcKkkx2kiV9
   UJIeKtQBfPlhAGTF16h3lf5L7JQAgdvTY0UVYZhjR7aCqPL5MO/MWyeSH
   ddhpPGvKXBXV0wom6enaLrKJ0UT3AJU9Ow4+JF6OsiuoEhFQEdngAeUjX
   A==;
X-CSE-ConnectionGUID: 4IYNbB4bRm+mRM2zeTDOmw==
X-CSE-MsgGUID: diQ1DWiCRzGkdhSr0NCu/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002736"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002736"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:12 -0700
X-CSE-ConnectionGUID: lVTJqVoxSKq9OA2xJn5s3g==
X-CSE-MsgGUID: IRyOuMI7Roq0H6VNJxnqlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216431974"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:11 -0700
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
Subject: [PATCH v11 2/9] x86/cpu: Add an LASS dependency on SMAP
Date: Wed, 29 Oct 2025 14:03:03 -0700
Message-ID: <20251029210310.1155449-3-sohil.mehta@intel.com>
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
---
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


