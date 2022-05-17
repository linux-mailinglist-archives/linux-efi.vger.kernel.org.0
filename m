Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA152A6E6
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350174AbiEQPfD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350034AbiEQPfB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA804132D;
        Tue, 17 May 2022 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801699; x=1684337699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cjIhhBNmMg3rAyBhnGeB4/sD2KLKXglIHIAjstpNJxM=;
  b=gCw1jYe9SbHSJ+gY2YbptAmgSE8LbObuEiHlypA2odv2SV8nnInSMQw4
   3sB3XEtQU1zBLVjtvFM8PAipXKnxROks3atQlrk4csdUbBmGFY6i1fAZB
   InefF+wxOWBnrNtFSlRGmLx7ZxF2GkXb/F5gGq9hoPUus6SEaGfmVt4ED
   C5LRNTNoJjLHBnPy3EyrDpeN5+SoXIxBkivmUcrtXYguovs6ctrr5FS+R
   DYz37kGLUEtSdxd4xltgpS6f6QzbDb6zXR6G0A5KhQIQWYc2yeZVVg/Wk
   HM7WMDw5FqVhCIJ+ZPu3uu3Mm+GYCzgwTIoBP5H66m8ZOiDr4uPNR42IC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270911573"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270911573"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="700105197"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 08:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7028618B; Tue, 17 May 2022 18:34:50 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 04/15] x86/boot: Add infrastructure required for unaccepted memory support
Date:   Tue, 17 May 2022 18:34:33 +0300
Message-Id: <20220517153444.11195-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Pull functionality from the main kernel headers and lib/ that is
required for unaccepted memory support.

This is preparatory patch. The users for the functionality will come in
following patches.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/bitops.h                   | 40 ++++++++++++
 arch/x86/boot/compressed/align.h         | 14 +++++
 arch/x86/boot/compressed/bitmap.c        | 43 +++++++++++++
 arch/x86/boot/compressed/bitmap.h        | 49 +++++++++++++++
 arch/x86/boot/compressed/bits.h          | 36 +++++++++++
 arch/x86/boot/compressed/compiler.h      |  9 +++
 arch/x86/boot/compressed/find.c          | 54 ++++++++++++++++
 arch/x86/boot/compressed/find.h          | 80 ++++++++++++++++++++++++
 arch/x86/boot/compressed/math.h          | 37 +++++++++++
 arch/x86/boot/compressed/minmax.h        | 61 ++++++++++++++++++
 arch/x86/boot/compressed/pgtable_types.h | 25 ++++++++
 11 files changed, 448 insertions(+)
 create mode 100644 arch/x86/boot/compressed/align.h
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/bitmap.h
 create mode 100644 arch/x86/boot/compressed/bits.h
 create mode 100644 arch/x86/boot/compressed/compiler.h
 create mode 100644 arch/x86/boot/compressed/find.c
 create mode 100644 arch/x86/boot/compressed/find.h
 create mode 100644 arch/x86/boot/compressed/math.h
 create mode 100644 arch/x86/boot/compressed/minmax.h
 create mode 100644 arch/x86/boot/compressed/pgtable_types.h

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 02e1dea11d94..61eb820ee402 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -41,4 +41,44 @@ static inline void set_bit(int nr, void *addr)
 	asm("btsl %1,%0" : "+m" (*(u32 *)addr) : "Ir" (nr));
 }
 
+static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
+{
+	asm volatile(__ASM_SIZE(bts) " %1,%0" : : "m" (*(volatile long *) addr),
+		     "Ir" (nr) : "memory");
+}
+
+static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
+{
+	asm volatile(__ASM_SIZE(btr) " %1,%0" : : "m" (*(volatile long *) addr),
+		     "Ir" (nr) : "memory");
+}
+
+/**
+ * __ffs - find first set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static __always_inline unsigned long __ffs(unsigned long word)
+{
+	asm("rep; bsf %1,%0"
+		: "=r" (word)
+		: "rm" (word));
+	return word;
+}
+
+/**
+ * ffz - find first zero bit in word
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+static __always_inline unsigned long ffz(unsigned long word)
+{
+	asm("rep; bsf %1,%0"
+		: "=r" (word)
+		: "r" (~word));
+	return word;
+}
+
 #endif /* BOOT_BITOPS_H */
diff --git a/arch/x86/boot/compressed/align.h b/arch/x86/boot/compressed/align.h
new file mode 100644
index 000000000000..7ccabbc5d1b8
--- /dev/null
+++ b/arch/x86/boot/compressed/align.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BOOT_ALIGN_H
+#define BOOT_ALIGN_H
+#define _LINUX_ALIGN_H /* Inhibit inclusion of <linux/align.h> */
+
+/* @a is a power of 2 value */
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
+#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif
diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
new file mode 100644
index 000000000000..789ecadeb521
--- /dev/null
+++ b/arch/x86/boot/compressed/bitmap.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "bitmap.h"
+
+void __bitmap_set(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_set >= 0) {
+		*p |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_LONG;
+		mask_to_set = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		*p |= mask_to_set;
+	}
+}
+
+void __bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
diff --git a/arch/x86/boot/compressed/bitmap.h b/arch/x86/boot/compressed/bitmap.h
new file mode 100644
index 000000000000..35357f5feda2
--- /dev/null
+++ b/arch/x86/boot/compressed/bitmap.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BOOT_BITMAP_H
+#define BOOT_BITMAP_H
+#define __LINUX_BITMAP_H /* Inhibit inclusion of <linux/bitmap.h> */
+
+#include "../bitops.h"
+#include "../string.h"
+#include "align.h"
+
+#define BITMAP_MEM_ALIGNMENT 8
+#define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
+
+#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
+
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+
+void __bitmap_set(unsigned long *map, unsigned int start, int len);
+void __bitmap_clear(unsigned long *map, unsigned int start, int len);
+
+static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
+		unsigned int nbits)
+{
+	if (__builtin_constant_p(nbits) && nbits == 1)
+		__set_bit(start, map);
+	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
+		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
+		memset((char *)map + start / 8, 0xff, nbits / 8);
+	else
+		__bitmap_set(map, start, nbits);
+}
+
+static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
+		unsigned int nbits)
+{
+	if (__builtin_constant_p(nbits) && nbits == 1)
+		__clear_bit(start, map);
+	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
+		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
+		memset((char *)map + start / 8, 0, nbits / 8);
+	else
+		__bitmap_clear(map, start, nbits);
+}
+
+#endif
diff --git a/arch/x86/boot/compressed/bits.h b/arch/x86/boot/compressed/bits.h
new file mode 100644
index 000000000000..b0ffa007ee19
--- /dev/null
+++ b/arch/x86/boot/compressed/bits.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BOOT_BITS_H
+#define BOOT_BITS_H
+#define __LINUX_BITS_H /* Inhibit inclusion of <linux/bits.h> */
+
+#ifdef __ASSEMBLY__
+#define _AC(X,Y)	X
+#define _AT(T,X)	X
+#else
+#define __AC(X,Y)	(X##Y)
+#define _AC(X,Y)	__AC(X,Y)
+#define _AT(T,X)	((T)(X))
+#endif
+
+#define _UL(x)		(_AC(x, UL))
+#define _ULL(x)		(_AC(x, ULL))
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#define BIT(nr)			(UL(1) << (nr))
+#define BIT_ULL(nr)		(ULL(1) << (nr))
+#define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
+#define BITS_PER_BYTE		8
+
+#define GENMASK(h, l) \
+	(((~UL(0)) - (UL(1) << (l)) + 1) & \
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+
+#define GENMASK_ULL(h, l) \
+	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+
+#endif
diff --git a/arch/x86/boot/compressed/compiler.h b/arch/x86/boot/compressed/compiler.h
new file mode 100644
index 000000000000..452c4c0844b9
--- /dev/null
+++ b/arch/x86/boot/compressed/compiler.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BOOT_COMPILER_H
+#define BOOT_COMPILER_H
+#define __LINUX_COMPILER_H /* Inhibit inclusion of <linux/compiler.h> */
+
+# define likely(x)	__builtin_expect(!!(x), 1)
+# define unlikely(x)	__builtin_expect(!!(x), 0)
+
+#endif
diff --git a/arch/x86/boot/compressed/find.c b/arch/x86/boot/compressed/find.c
new file mode 100644
index 000000000000..839be91aae52
--- /dev/null
+++ b/arch/x86/boot/compressed/find.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "bitmap.h"
+#include "find.h"
+#include "math.h"
+#include "minmax.h"
+
+static __always_inline unsigned long swab(const unsigned long y)
+{
+#if __BITS_PER_LONG == 64
+	return __builtin_bswap32(y);
+#else /* __BITS_PER_LONG == 32 */
+	return __builtin_bswap64(y);
+#endif
+}
+
+unsigned long _find_next_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long nbits,
+		unsigned long start, unsigned long invert, unsigned long le)
+{
+	unsigned long tmp, mask;
+
+	if (unlikely(start >= nbits))
+		return nbits;
+
+	tmp = addr1[start / BITS_PER_LONG];
+	if (addr2)
+		tmp &= addr2[start / BITS_PER_LONG];
+	tmp ^= invert;
+
+	/* Handle 1st word. */
+	mask = BITMAP_FIRST_WORD_MASK(start);
+	if (le)
+		mask = swab(mask);
+
+	tmp &= mask;
+
+	start = round_down(start, BITS_PER_LONG);
+
+	while (!tmp) {
+		start += BITS_PER_LONG;
+		if (start >= nbits)
+			return nbits;
+
+		tmp = addr1[start / BITS_PER_LONG];
+		if (addr2)
+			tmp &= addr2[start / BITS_PER_LONG];
+		tmp ^= invert;
+	}
+
+	if (le)
+		tmp = swab(tmp);
+
+	return min(start + __ffs(tmp), nbits);
+}
diff --git a/arch/x86/boot/compressed/find.h b/arch/x86/boot/compressed/find.h
new file mode 100644
index 000000000000..799176972ebc
--- /dev/null
+++ b/arch/x86/boot/compressed/find.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BOOT_FIND_H
+#define BOOT_FIND_H
+#define __LINUX_FIND_H /* Inhibit inclusion of <linux/find.h> */
+
+#include "../bitops.h"
+#include "align.h"
+#include "bits.h"
+#include "compiler.h"
+
+unsigned long _find_next_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long nbits,
+		unsigned long start, unsigned long invert, unsigned long le);
+
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+			    unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+}
+
+/**
+ * find_next_zero_bit - find the next cleared bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number of the next zero bit
+ * If no bits are zero, returns @size.
+ */
+static inline
+unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+				 unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr | ~GENMASK(size - 1, offset);
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+}
+
+/**
+ * for_each_set_bitrange_from - iterate over all set bit ranges [b; e)
+ * @b: bit offset of start of current bitrange (first set bit); must be initialized
+ * @e: bit offset of end of current bitrange (first unset bit)
+ * @addr: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
+#define for_each_set_bitrange_from(b, e, addr, size)		\
+	for ((b) = find_next_bit((addr), (size), (b)),		\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
+	     (b) < (size);					\
+	     (b) = find_next_bit((addr), (size), (e) + 1),	\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
+#endif
diff --git a/arch/x86/boot/compressed/math.h b/arch/x86/boot/compressed/math.h
new file mode 100644
index 000000000000..f7eede84bbc2
--- /dev/null
+++ b/arch/x86/boot/compressed/math.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BOOT_MATH_H
+#define BOOT_MATH_H
+#define __LINUX_MATH_H /* Inhibit inclusion of <linux/math.h> */
+
+/*
+ *
+ * This looks more complex than it should be. But we need to
+ * get the type for the ~ right in round_down (it needs to be
+ * as wide as the result!), and we want to evaluate the macro
+ * arguments just once each.
+ */
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+
+/**
+ * round_up - round up to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round up to (must be a power of 2)
+ *
+ * Rounds @x up to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding up, use roundup() below.
+ */
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+
+/**
+ * round_down - round down to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round down to (must be a power of 2)
+ *
+ * Rounds @x down to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding down, use rounddown() below.
+ */
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
+#endif
diff --git a/arch/x86/boot/compressed/minmax.h b/arch/x86/boot/compressed/minmax.h
new file mode 100644
index 000000000000..4efd05673260
--- /dev/null
+++ b/arch/x86/boot/compressed/minmax.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BOOT_MINMAX_H
+#define BOOT_MINMAX_H
+#define __LINUX_MINMAX_H /* Inhibit inclusion of <linux/minmax.h> */
+
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+/*
+ * min()/max()/clamp() macros must accomplish three things:
+ *
+ * - avoid multiple evaluations of the arguments (so side-effects like
+ *   "x++" happen only once) when non-constant.
+ * - perform strict type-checking (to generate warnings instead of
+ *   nasty runtime surprises). See the "unnecessary" pointer comparison
+ *   in __typecheck().
+ * - retain result as a constant expressions when called with only
+ *   constant expressions (to avoid tripping VLA warnings in stack
+ *   allocation usage).
+ */
+#define __typecheck(x, y) \
+	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
+
+#define __no_side_effects(x, y) \
+		(__is_constexpr(x) && __is_constexpr(y))
+
+#define __safe_cmp(x, y) \
+		(__typecheck(x, y) && __no_side_effects(x, y))
+
+#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
+
+#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
+		typeof(x) unique_x = (x);		\
+		typeof(y) unique_y = (y);		\
+		__cmp(unique_x, unique_y, op); })
+
+#define __careful_cmp(x, y, op) \
+	__builtin_choose_expr(__safe_cmp(x, y), \
+		__cmp(x, y, op), \
+		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
+
+/**
+ * min - return minimum of two values of the same or compatible types
+ * @x: first value
+ * @y: second value
+ */
+#define min(x, y)	__careful_cmp(x, y, <)
+
+/**
+ * max - return maximum of two values of the same or compatible types
+ * @x: first value
+ * @y: second value
+ */
+#define max(x, y)	__careful_cmp(x, y, >)
+
+#endif
diff --git a/arch/x86/boot/compressed/pgtable_types.h b/arch/x86/boot/compressed/pgtable_types.h
new file mode 100644
index 000000000000..8f1d87a69efc
--- /dev/null
+++ b/arch/x86/boot/compressed/pgtable_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BOOT_COMPRESSED_PGTABLE_TYPES_H
+#define BOOT_COMPRESSED_PGTABLE_TYPES_H
+#define _ASM_X86_PGTABLE_DEFS_H /* Inhibit inclusion of <asm/pgtable_types.h> */
+
+#define PAGE_SHIFT	12
+
+#ifdef CONFIG_X86_64
+#define PTE_SHIFT	9
+#elif defined CONFIG_X86_PAE
+#define PTE_SHIFT	9
+#else /* 2-level */
+#define PTE_SHIFT	10
+#endif
+
+enum pg_level {
+	PG_LEVEL_NONE,
+	PG_LEVEL_4K,
+	PG_LEVEL_2M,
+	PG_LEVEL_1G,
+	PG_LEVEL_512G,
+	PG_LEVEL_NUM
+};
+
+#endif
-- 
2.35.1

