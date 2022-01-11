Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFCA48AC83
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 12:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349544AbiAKLdR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 06:33:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:11112 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349532AbiAKLdO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 06:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900794; x=1673436794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5dqBdfMq7ze0AdxX7ODzhLdYdgNTaNVDweYGFgnO8Es=;
  b=fqoEHlDCCQe2QHOEKfRvAvLrrnb97qnJafGb/6KgtNaRISYqwnlAmOno
   5NDqUuBvwT349+DIDVrE7bLqfe5cbvlox7hGnyrSyAr2PB6eHG9VG0X2i
   vmZ0SvpulU2Ik9Kt1I8Mwyhs5YnQO3muRq2cAkFpVlAUhTl/g37W8DjVl
   BMAf7HQjgaZ676qazBoboKqBG61fQNhO0SLa53+BfeQlvXoX3Drr++O55
   lyoGDS9833NSdqOrO7nYSitTAtqA3OsTZpFDYZxoNPFiRyhfe2u077UWw
   GoOAMQSNOrH3mEd0FSBwjs3ZtmUql5ZtPU00vyW6CQPs2r95smEIEYXXa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242277580"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="242277580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="472431125"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 11 Jan 2022 03:33:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5228C346; Tue, 11 Jan 2022 13:33:19 +0200 (EET)
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 4/7] x86/boot/compressed: Handle unaccepted memory
Date:   Tue, 11 Jan 2022 14:33:11 +0300
Message-Id: <20220111113314.27173-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Firmware is responsible for accepting memory where compressed kernel
image and initrd land. But kernel has to accept memory for decompression
buffer: accept memory just before decompression starts.

KASLR is allowed to use unaccepted memory for the output buffer.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/bitmap.c            | 62 ++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c             | 14 ++++-
 arch/x86/boot/compressed/misc.c              |  9 +++
 arch/x86/boot/compressed/unaccepted_memory.c | 13 ++++
 arch/x86/include/asm/unaccepted_memory.h     |  2 +
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
index bf58b259380a..ba2de61c0823 100644
--- a/arch/x86/boot/compressed/bitmap.c
+++ b/arch/x86/boot/compressed/bitmap.c
@@ -2,6 +2,48 @@
 /* Taken from lib/string.c */
 
 #include <linux/bitmap.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
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
 
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
@@ -22,3 +64,23 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
 		*p |= mask_to_set;
 	}
 }
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
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 411b268bc0a2..59db90626042 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -725,10 +725,20 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 		 * but in practice there's firmware where using that memory leads
 		 * to crashes.
 		 *
-		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
+		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
+		 * supported) are guaranteed to be free.
 		 */
-		if (md->type != EFI_CONVENTIONAL_MEMORY)
+
+		switch (md->type) {
+		case EFI_CONVENTIONAL_MEMORY:
+			break;
+		case EFI_UNACCEPTED_MEMORY:
+			if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+				break;
 			continue;
+		default:
+			continue;
+		}
 
 		if (efi_soft_reserve_enabled() &&
 		    (md->attribute & EFI_MEMORY_SP))
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index d8373d766672..1e3efd0a8e11 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -18,6 +18,7 @@
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <asm/unaccepted_memory.h>
 
 /*
  * WARNING!!
@@ -446,6 +447,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    boot_params->unaccepted_memory) {
+		debug_putstr("Accepting memory... ");
+		accept_memory((phys_addr_t)output,
+			      (phys_addr_t)output + needed_size);
+	}
+
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
 	parse_elf(output);
diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
index d8081cde0eed..91db800d5f5e 100644
--- a/arch/x86/boot/compressed/unaccepted_memory.c
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -43,3 +43,16 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
 	bitmap_set((unsigned long *)params->unaccepted_memory,
 		   start / PMD_SIZE, (end - start) / PMD_SIZE);
 }
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long *unaccepted_memory;
+	unsigned int rs, re;
+
+	unaccepted_memory = (unsigned long *)boot_params->unaccepted_memory;
+	bitmap_for_each_set_region(unaccepted_memory, rs, re,
+				   start / PMD_SIZE, end / PMD_SIZE) {
+		__accept_memory(rs * PMD_SIZE, re * PMD_SIZE);
+		bitmap_clear(unaccepted_memory, rs, re - rs);
+	}
+}
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index cbc24040b853..f1f835d3cd78 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -9,4 +9,6 @@ struct boot_params;
 
 void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
 
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif
-- 
2.34.1

