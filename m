Return-Path: <linux-efi+bounces-5601-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F2C6B3C0
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 19:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2C42429D0B
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A72D9EEC;
	Tue, 18 Nov 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a708jOUq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837C22DE1FA;
	Tue, 18 Nov 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490887; cv=none; b=ObGbs196rp5iC7BMT0Uvq1/vWkuYghmfFO9wJfs5IAQxD5Chx9z8l9qbcNGI/LSWhhCobcARzF63gX7M5YQdzzgIbGNJygboqtVBM6Y5zfDizVNaK9LGtflBLSERcWfXQos4zk7Lmbfk7EubMw8u8DAoLYIGfZtS6h8IjBHBdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490887; c=relaxed/simple;
	bh=3v51fqgW7yBK6B/AFGSul1SUT9hseHQhv6m1LfAlgx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwbMffl90ymfaWfp0Gr9rWvEwmg/mZiFwDKSqoasiDSfzp1ykjZJl0z/9cJBpuUWDO6HcLX0DlImrknn2PgjXkPMsLwYpvD5MT9rL5tYYZWtSaw8/E2mbIvupmGWYd2MfbwN2afJRNJr6o0jLHz3B5eWba9XPh4XA/Usbod0jPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a708jOUq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490885; x=1795026885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3v51fqgW7yBK6B/AFGSul1SUT9hseHQhv6m1LfAlgx4=;
  b=a708jOUq2CpTcX1A7BWJe4oD0yirKxuZwWS6AtWRiTYnlslqtTsm+Dw1
   oQr/aARc4+yaugjCaAjwYv6a2NaZ/S4a1W33jXjGrZlROv7hh0IUqVzn2
   0Hy2VuHofZ59RPmgM5ZJBj/EaN36c18+/jH3LABIIb0Mod5KfIW+4R9i0
   qJGyCTi81T67ySWYH6lSz6jylwBZvPldEvk2wd8b8kxX4ZPI4TtfI7oiB
   5VarpLXziVnE2W/ja7ODipIN3lySZJbIOA3hqfih1lwhqemnF8My5c+ZF
   ForkaPm8Deedohg/ofevSDdxyLAS/RVSED4iQvkzTCRfuFnMg2uMYG/AF
   Q==;
X-CSE-ConnectionGUID: IWdLTQLsQ+ODMyeqY39y6Q==
X-CSE-MsgGUID: K10pPS3tQEqpYKdhAxX+xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76979817"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76979817"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:54 -0800
X-CSE-ConnectionGUID: lBEF+gJKSU+pN+oCz5Jmaw==
X-CSE-MsgGUID: 48Mpb1TdTMyk889mUiPyKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190088931"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 10:31:54 -0800
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
Subject: [PATCH v13 3/8] x86/asm: Introduce inline memcpy and memset
Date: Tue, 18 Nov 2025 10:29:05 -0800
Message-ID: <20251118182911.2983253-4-sohil.mehta@intel.com>
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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v12:
 - Pick up review tag.

v11:
 - Improve commit log.
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


