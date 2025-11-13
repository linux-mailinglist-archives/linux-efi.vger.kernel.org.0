Return-Path: <linux-efi+bounces-5499-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B931BC5A5EB
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44769351DBB
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834C32720A;
	Thu, 13 Nov 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsKmTkPX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B03326D4C;
	Thu, 13 Nov 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073921; cv=none; b=cQojEki7e6PwGUxypPW4WpPAF3tuFHok19d6+KCvyJfgE6lyc/LxcQsiEftJpaQze0r60GTGM7aoI/nVlfNNPj+TK3HAteCfgL1FIV+38NfT2bPT+qgjsBzxesqsll/G3h5R7erogNRPkCAf3g/0pFysjLF7YPLkFGIzqddrmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073921; c=relaxed/simple;
	bh=3v51fqgW7yBK6B/AFGSul1SUT9hseHQhv6m1LfAlgx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT7SU9OC9lUxkDUJSbulWd/R/Ys0Y0wILDaz/ISPafIixtn8pGrSCp23+XbiKbTu+HbaDGzJomt3yapeY8puW4/l5LyGzWyj5xwRDCLtZSQGk5T95hwD8Zf0li1AGMktnZj0zgfcPYLVN8PjJOk1iHQZpFhnMv9SQufmWBaH7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsKmTkPX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073920; x=1794609920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3v51fqgW7yBK6B/AFGSul1SUT9hseHQhv6m1LfAlgx4=;
  b=OsKmTkPXvi5fpHtaT8/TX1YYQivCSllHM/X1jWYi38BDAN+pT/1XT7NP
   h2q1kaPTBGREyFY26lOFmQ0TD9XNPJq9lwCWXIJ2KwvMXXCe9eDGiUgqY
   k7eONZxQkC+jffqgYwtfm5FCswjQJ7PCsjdOx962dAXPbchJbqBU3swlF
   Rldh8ZBrNwqGIx/AVyYKHIwE+WhIzZpq/tTlbQM3lDr4V0NM3tb0/dauK
   YdP+K3BOZAH4xk5iYb0Vi9WrofD+iivkX18mGoI7D/usNBM6CsRWFAURk
   OGBx0Y0jPh0IiWsmsHKecl342V0DdkPFd0K/9s+a5Alkl5X1vf8cGEv6s
   A==;
X-CSE-ConnectionGUID: A/RvpQKVQgS2ky2XZ1A3Bw==
X-CSE-MsgGUID: QWsIBu1uQUyDqreM17eXkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051927"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051927"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:17 -0800
X-CSE-ConnectionGUID: Nm/O97BUTSuR0PH3F97WlQ==
X-CSE-MsgGUID: 8a00V92+Q4GVpFzlhcdWJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611088"
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
Subject: [PATCH v12 3/8] x86/asm: Introduce inline memcpy and memset
Date: Thu, 13 Nov 2025 14:41:59 -0800
Message-ID: <20251113224204.50391-4-sohil.mehta@intel.com>
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


