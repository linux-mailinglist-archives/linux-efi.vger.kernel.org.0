Return-Path: <linux-efi+bounces-5241-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79800C1D5BC
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AF7234D32B
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777BB3195F0;
	Wed, 29 Oct 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTSVAEqW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8731691D;
	Wed, 29 Oct 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771975; cv=none; b=VHW5M1IwEMKpAk4AVUcvoqsfwLyUIL0vpXmirzqmrRG+Zjb5A08elzqWtZowmO2EEySiT0z2obDpTXIET4AAn1mfq0qYbyh48yinAhQszKoS3SkmYXNN6sCK/OtZjyF/fMyeoxP8IxahHgybPlHbVXb5DhI90+WRUyaleLbODcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771975; c=relaxed/simple;
	bh=uSGyq6NaJAJWKU0OwXuVARSCw8j3QBWt7UGMaozfQNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuPVuJ/1ZVpkoupsleDmOqzPNB2iwl1tLTSNN0LG1SuEKJ8/n3yiTzA8ZLpb6r2nq2QBOR590aXZ/o5Xj58aSTLzf+KqFSWam2F9qNMelBNK8e33SflFAj9dnhOoD+SXw1HWo7yvk8ZQ/uEUUp06/jpjG2APPEkH+gOO1krW5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTSVAEqW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771974; x=1793307974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSGyq6NaJAJWKU0OwXuVARSCw8j3QBWt7UGMaozfQNc=;
  b=hTSVAEqWZz0C/ymJ5R83QSq58mLAQixISOxfad7rLdSn4JRsPB3Tc8KU
   LNkCdmsjScw7dFtdtwD60Yn6guU6aeJn4PgU9dCcn80MYBUf6z2q/pNjN
   SrJbDHJKd1SmW73yMbWJH8pxKeP1PLFRw7qg9pfOmCA/lYDgzz5ra08o2
   zjJS8mqHuv4UoEG2p7m6V0fjUv8Jc3Aqd+RzfbBz9DIRfqRQPmK0hbKoA
   HVHZ0ESUigG9s35EplX2fDU/7gFj/5r/GaMNjdclfLW4HvSLIg50CpVp9
   mR6HAcV4qYhVR9X2SigdjIyem7T77ZI5LaW0mgd78IREpWikfgs8U8VhQ
   A==;
X-CSE-ConnectionGUID: 77q1L+efRo+x2ak/v4LjdQ==
X-CSE-MsgGUID: XkRg1IKvRb+sqOf9my9eoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002738"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002738"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:13 -0700
X-CSE-ConnectionGUID: dMuee8NeRHmc2KZn3Dqlyw==
X-CSE-MsgGUID: DrKtsqttS6SjIDHiYErX1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216431981"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:12 -0700
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
Subject: [PATCH v11 3/9] x86/asm: Introduce inline memcpy and memset
Date: Wed, 29 Oct 2025 14:03:04 -0700
Message-ID: <20251029210310.1155449-4-sohil.mehta@intel.com>
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Provide inline memcpy and memset functions that can be used instead of
the GCC builtins when necessary. The immediate use case is for the text
poking functions to avoid the standard memcpy()/memset() calls because
objtool complains about such dynamic calls within an AC=1 region. See
tools/objtool/Documentation/objtool.txt, warning #9, regarding function
calls with UACCESS enabled.

Some user copy functions such as copy_user_generic() and __clear_user()
have similar rep_{movs,stos} usages. But, those are highly specialized
and hard to combine or reuse for other things. Define these new helpers
for all other usages that need a completely unoptimized, strictly inline
version of memcpy() or memset().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v11:
 - Improve commit log.

v10:
 - Reintroduce the simpler inline patch (dropped in v8).
---
 arch/x86/include/asm/string.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index c3c2c1914d65..9cb5aae7fba9 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -1,6 +1,32 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_STRING_H
+#define _ASM_X86_STRING_H
+
 #ifdef CONFIG_X86_32
 # include <asm/string_32.h>
 #else
 # include <asm/string_64.h>
 #endif
+
+static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
+{
+	void *ret = to;
+
+	asm volatile("rep movsb"
+		     : "+D" (to), "+S" (from), "+c" (len)
+		     : : "memory");
+	return ret;
+}
+
+static __always_inline void *__inline_memset(void *s, int v, size_t n)
+{
+	void *ret = s;
+
+	asm volatile("rep stosb"
+		     : "+D" (s), "+c" (n)
+		     : "a" ((uint8_t)v)
+		     : "memory");
+	return ret;
+}
+
+#endif /* _ASM_X86_STRING_H */
-- 
2.43.0


