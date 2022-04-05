Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B74F5403
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347990AbiDFEEC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1850049AbiDFCrJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 22:47:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1978B1E1112;
        Tue,  5 Apr 2022 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649202523; x=1680738523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vDtT5eCuwypFPjQBE9Qdn6flkyTeEBWCMmVpOI5Jnq4=;
  b=m1ioYfqC/0NhJbHqlCEEZ2b2jptaATEYJu/asjb/Ypjo+zBeye/LUtsE
   reIWK13X+PJp9/AaMvtO88/2b2pEIXgCSe6HjbukoLIAUTmzqfFdyp5Yq
   G8rmi9SU8z42f0j1e7jUJHyFpzgzzlj1JbPwHinyIBcm+jZumnMVOIvTQ
   /oTrzrDXYoBX3AvABZLc1Zhyioaa/vP15ONHkUH+PHNXcHqq6jaZAA0oU
   k3kQDBVHpm3TINCba/CqWpMdkm5rLwcHhlXCcEeSJayM1E1ldxFLfe8Ys
   k63oaM7D3hJeX8v3VKHFSnMNKOJFb/pLqbQ9PQIghaRl18XTos7LvG39V
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="243035271"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="243035271"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="608658173"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 16:48:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B42034B3; Wed,  6 Apr 2022 02:43:47 +0300 (EEST)
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 4/8] x86/boot/compressed: Handle unaccepted memory
Date:   Wed,  6 Apr 2022 02:43:39 +0300
Message-Id: <20220405234343.74045-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/boot/compressed/misc.c              | 11 ++++
 arch/x86/boot/compressed/unaccepted_memory.c | 14 +++++
 arch/x86/include/asm/unaccepted_memory.h     |  2 +
 5 files changed, 101 insertions(+), 2 deletions(-)

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
index fa8969fad011..c1d9d71a6615 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -18,6 +18,7 @@
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <asm/unaccepted_memory.h>
 
 /*
  * WARNING!!
@@ -43,6 +44,9 @@
 void *memmove(void *dest, const void *src, size_t n);
 #endif
 
+#undef __pa
+#define __pa(x)	((unsigned long)(x))
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -451,6 +455,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    boot_params->unaccepted_memory) {
+		debug_putstr("Accepting memory... ");
+		accept_memory(__pa(output), __pa(output) + needed_size);
+	}
+
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
 	parse_elf(output);
diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
index d363acf59c08..3ebab63789bb 100644
--- a/arch/x86/boot/compressed/unaccepted_memory.c
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -51,3 +51,17 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
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
+	rs = start / PMD_SIZE;
+	for_each_set_bitrange_from(rs, re, unaccepted_memory,
+				   DIV_ROUND_UP(end, PMD_SIZE)) {
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
2.35.1

