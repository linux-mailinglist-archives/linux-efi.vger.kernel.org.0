Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820886FFEB2
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 03:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbjELB76 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 May 2023 21:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbjELB7o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 May 2023 21:59:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69C900B;
        Thu, 11 May 2023 18:59:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A15C65C10B4;
        Thu, 11 May 2023 21:59:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 May 2023 21:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1683856754; x=
        1683943154; bh=bRuUV9JqkiufeVNNrZ63Ft7psvjWV3KGXfSRdaG88Ns=; b=T
        fyALRmHWHl+0oIj+NKFeg97HTRF8tLE4162kZobH1zFe21VbmXM8KWx/wQKU9Sdc
        BHJcqzsdrboAXDb13kqX0twjx3T40exl4tRE1vLB+nkSJehEYgEwXlGPOvj3H6cp
        fuHPShYER8iNs9NOSr1BGsNuuPo5K/pqHlotnZeDXytNGQha/P8nxRFVMXAr43PX
        d196+xZHYWhx3p/o2H+ilfLWJ75bNjob/to6vpFdnnh5EbcUzRAMibAKyxu6IQWZ
        lNxF3+biB+CRcOc7kXY82dHjZRNwp86o603zpfGUSEO4/WnU2sH31NsY+zVWwqVv
        7jJk/BAgefA2QfcvfDlPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683856754; x=1683943154; bh=bRuUV9Jqkiufe
        VNNrZ63Ft7psvjWV3KGXfSRdaG88Ns=; b=PlKPCb4W4dK6UbFs9rp3bpecwph4J
        YWRH7hNv6GPBJtA7ZeY1+LOylSLFvzQLPTgwi2lKw9Li+MOuVTwIiwR5CN/ee5FR
        RaiWKnxh+g6XX3t3bVrGnLideK/uryU4uMdn68ACiIpnpYT9Aftj6mk3JrWPjENl
        1tCb9WS7Vg1HiackPJCIgH4jdkimP/v5CgLjq9X4vwZtmzsXSyEGKKh3TtBdUH0e
        TYiRtdRWqZIZP0cUft+pI2fTTmEktxpZCZyBSwYDhSiwRbNJ2WlosS0lyl2+gnKm
        UNvwIH7DoCMKtGfVULibvaSix7a28LfGVtukieGTrETdtjnwaHJlidiug==
X-ME-Sender: <xms:cZ1dZBzSWdWHN4w484OVn8-XUjZCIlYatJrAl12dKr-vLfY3EGgnqA>
    <xme:cZ1dZBS6yctfcM4FZJ47zjwft6fzW7dWJvaVFEWxJhsOwAY-X2X_UnBkTSBPitHH3
    GzL3z7WSq6SFJK2QPg>
X-ME-Received: <xmr:cZ1dZLWK4tuxzDz2RNHepPsNsdWdHMlcgZNoCL37CltiklQfeqA9BbNuEhmN7cbCM0dn8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeeulefgteeukeeihfffveeukefhudehvdegvdeh
    lefhvdduffegheegffeifeelveenucffohhmrghinhepthhhihhnghhsrdhhmhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:cZ1dZDgZ00G0xTgbz_cWoAjhn6pmGCX56QCt4huT4E634clHbR4Zdg>
    <xmx:cZ1dZDDRbbtSixgUXmR65QwJRv0Mf9qgFy8k58iaarUjQYVsI2CnpA>
    <xmx:cZ1dZMLN2XCB8Oz7xf-GNz774Kj5IgF7HTNZ2hRNh38fh0uMG7vMuA>
    <xmx:cp1dZAOVAAJ5QoD1xIUqrtTEy1_1hVLOnJc9l0SCBrFLr6FIIY-oqg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 May 2023 21:59:12 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4945710CD92; Fri, 12 May 2023 04:59:09 +0300 (+03)
Date:   Fri, 12 May 2023 04:59:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 04/11] efi/x86: Implement support for unaccepted memory
Message-ID: <20230512015909.2fj7bmp3ejc3owhs@box.shutemov.name>
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
 <20230507234618.18067-5-kirill.shutemov@linux.intel.com>
 <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
 <20230508190043.ouauzbghn27khdy4@box.shutemov.name>
 <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
 <20230509005634.qtuiodpirexbxu2k@box.shutemov.name>
 <CAMj1kXGZ4j7nShGPoJzTZNa4NDvHnj_arY8XDXzW8cd6G==8Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGZ4j7nShGPoJzTZNa4NDvHnj_arY8XDXzW8cd6G==8Jg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 09, 2023 at 08:47:38AM +0200, Ard Biesheuvel wrote:
> On Tue, 9 May 2023 at 02:56, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Tue, May 09, 2023 at 12:11:41AM +0200, Ard Biesheuvel wrote:
> > > > @@ -1324,13 +1325,15 @@ void __init e820__memblock_setup(void)
> > > >          * e820_table is not finalized and e820__end_of_ram_pfn() cannot be
> > > >          * used to get correct RAM size.
> > > >          */
> > > > -       if (boot_params.unaccepted_memory) {
> > > > +       if (efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
> > > > +               struct efi_unaccepted_memory *unaccepted;
> > > >                 unsigned long size;
> > > >
> > > > -               /* One bit per 2MB */
> > > > -               size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > > > -                                   PMD_SIZE * BITS_PER_BYTE);
> > > > -               memblock_reserve(boot_params.unaccepted_memory, size);
> > > > +               unaccepted = __va(efi.unaccepted);
> > > > +
> > > > +               size = sizeof(struct efi_unaccepted_memory);
> > > > +               size += unaccepted->size;
> > > > +               memblock_reserve(efi.unaccepted, size);
> > > >         }
> > > >
> > >
> > > This could be moved to generic code (but we'll need to use early_memremap())
> >
> > I don't understand why early_memremap() is needed. EFI_LOADER_DATA already
> > mapped into direct mapping. We only need to reserve the memory so it
> > could not be reallocated for other things. Hm?
> >
> 
> *If* we move this to generic code, we have to ensure that we don't
> rely on x86 specific semantics. When parsing the EFI configuration
> tables, other architectures don't have a complete direct map yet, as
> they receive the memory description from EFI not from a translated
> E820 map.
> 
> Note that this is only for getting the size of the reservation. Later
> on, when we actually consume the contents of the bitmap, generic or
> non-x86 code will need to use the ordinary memremap() API to map this
> memory, and this amounts to a __va() call when the memory is already
> mapped. But I am not suggesting changing that part for this series.
> And even the hunk above can remain as you suggest - we can revisit it
> once other architectures gain support for this.
> 
> The main thing I would like to avoid at this point in time is to add
> new fields to struct bootparams that loaders such as GRUB may start to
> populate as well - I don't think there is a very strong case for
> pseudo-EFI boot [where GRUB calls ExitBootServices()] on confidential
> VMs (as it prevents the EFI stub and the kernel from accessing the
> measurement and attestation APIs), but let's not create more struct
> bootparams based API if we can avoid it.

Below is updated version of the fixup. I believed I addressed all your
feedback.

I moved most of unaccepted memory code into generic EFI and EFI stub. I
hope it looks fine.

early_memremap() for reservation works fine, but when I tried to use
memremap() as you suggested to get the mapping of the table instead of
__va() it failed. I didn't found the root cause. I guess I tried to use
too early for memremap() to be functional. I made arch provide
arch-specific way to get the mapping, which is implemented as __va() on
x86.

While I move code from decompressor to the EFI stub, I removed few headers
as, it *seems*, EFI stub has different policy about re-using headers from
the main kernel image.

Borislav, is it okay with you or EFI stub also has to carry own copy of
the headers?

If everything is fine, I will fold the fixup properly and prepare v11 of
the patchset.

 Documentation/arch/x86/zero-page.rst             |   1 -
 arch/x86/boot/bitops.h                           |  40 ----
 arch/x86/boot/compressed/Makefile                |   2 +-
 arch/x86/boot/compressed/bitmap.c                |  43 -----
 arch/x86/boot/compressed/bitmap.h                |  49 -----
 arch/x86/boot/compressed/bits.h                  |  36 ----
 arch/x86/boot/compressed/find.c                  |  54 ------
 arch/x86/boot/compressed/find.h                  |  79 --------
 arch/x86/boot/compressed/math.h                  |  37 ----
 arch/x86/boot/compressed/mem.c                   |  81 +--------
 arch/x86/boot/compressed/minmax.h                |  61 -------
 arch/x86/boot/compressed/misc.c                  |   2 +-
 arch/x86/include/asm/page.h                      |   2 -
 arch/x86/include/asm/unaccepted_memory.h         |  24 ++-
 arch/x86/include/uapi/asm/bootparam.h            |   2 +-
 arch/x86/kernel/e820.c                           |  17 --
 arch/x86/mm/Makefile                             |   2 -
 arch/x86/mm/unaccepted_memory.c                  | 101 -----------
 drivers/firmware/efi/Makefile                    |   1 +
 drivers/firmware/efi/efi.c                       |  25 +++
 drivers/firmware/efi/libstub/Makefile            |   2 +
 drivers/firmware/efi/libstub/efistub.h           |   6 +
 drivers/firmware/efi/libstub/find.c              |  43 +++++
 drivers/firmware/efi/libstub/unaccepted_memory.c | 221 +++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c          |  62 +------
 drivers/firmware/efi/unaccepted_memory.c         | 138 ++++++++++++++
 include/linux/efi.h                              |  12 ++
 mm/internal.h                                    |   9 +-
 28 files changed, 480 insertions(+), 672 deletions(-)

diff --git a/Documentation/arch/x86/zero-page.rst b/Documentation/arch/x86/zero-page.rst
index f21905e61ade..45aa9cceb4f1 100644
--- a/Documentation/arch/x86/zero-page.rst
+++ b/Documentation/arch/x86/zero-page.rst
@@ -20,7 +20,6 @@ Offset/Size	Proto	Name			Meaning
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
 070/008		ALL	acpi_rsdp_addr		Physical address of ACPI RSDP table
-078/008		ALL	unaccepted_memory	Bitmap of unaccepted memory (1bit == 2M)
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 38badf028543..8518ae214c9b 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -41,44 +41,4 @@ static inline void set_bit(int nr, void *addr)
 	asm("btsl %1,%0" : "+m" (*(u32 *)addr) : "Ir" (nr));
 }
 
-static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
-{
-	asm volatile(__ASM_SIZE(bts) " %1,%0" : : "m" (*(volatile long *) addr),
-		     "Ir" (nr) : "memory");
-}
-
-static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
-{
-	asm volatile(__ASM_SIZE(btr) " %1,%0" : : "m" (*(volatile long *) addr),
-		     "Ir" (nr) : "memory");
-}
-
-/**
- * __ffs - find first set bit in word
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static __always_inline unsigned long __ffs(unsigned long word)
-{
-	asm("rep; bsf %1,%0"
-		: "=r" (word)
-		: "rm" (word));
-	return word;
-}
-
-/**
- * ffz - find first zero bit in word
- * @word: The word to search
- *
- * Undefined if no zero exists, so code should check against ~0UL first.
- */
-static __always_inline unsigned long ffz(unsigned long word)
-{
-	asm("rep; bsf %1,%0"
-		: "=r" (word)
-		: "r" (~word));
-	return word;
-}
-
 #endif /* BOOT_BITOPS_H */
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 71d9f71c13eb..09d57937640a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,7 +107,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdx-shared.o $(obj)/tdcall.o
-vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/find.o $(obj)/mem.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
deleted file mode 100644
index 789ecadeb521..000000000000
--- a/arch/x86/boot/compressed/bitmap.c
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include "bitmap.h"
-
-void __bitmap_set(unsigned long *map, unsigned int start, int len)
-{
-	unsigned long *p = map + BIT_WORD(start);
-	const unsigned int size = start + len;
-	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
-
-	while (len - bits_to_set >= 0) {
-		*p |= mask_to_set;
-		len -= bits_to_set;
-		bits_to_set = BITS_PER_LONG;
-		mask_to_set = ~0UL;
-		p++;
-	}
-	if (len) {
-		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
-		*p |= mask_to_set;
-	}
-}
-
-void __bitmap_clear(unsigned long *map, unsigned int start, int len)
-{
-	unsigned long *p = map + BIT_WORD(start);
-	const unsigned int size = start + len;
-	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
-
-	while (len - bits_to_clear >= 0) {
-		*p &= ~mask_to_clear;
-		len -= bits_to_clear;
-		bits_to_clear = BITS_PER_LONG;
-		mask_to_clear = ~0UL;
-		p++;
-	}
-	if (len) {
-		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
-		*p &= ~mask_to_clear;
-	}
-}
diff --git a/arch/x86/boot/compressed/bitmap.h b/arch/x86/boot/compressed/bitmap.h
deleted file mode 100644
index 35357f5feda2..000000000000
--- a/arch/x86/boot/compressed/bitmap.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef BOOT_BITMAP_H
-#define BOOT_BITMAP_H
-#define __LINUX_BITMAP_H /* Inhibit inclusion of <linux/bitmap.h> */
-
-#include "../bitops.h"
-#include "../string.h"
-#include "align.h"
-
-#define BITMAP_MEM_ALIGNMENT 8
-#define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-
-#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
-
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-
-void __bitmap_set(unsigned long *map, unsigned int start, int len);
-void __bitmap_clear(unsigned long *map, unsigned int start, int len);
-
-static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
-		unsigned int nbits)
-{
-	if (__builtin_constant_p(nbits) && nbits == 1)
-		__set_bit(start, map);
-	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
-		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
-		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
-		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0xff, nbits / 8);
-	else
-		__bitmap_set(map, start, nbits);
-}
-
-static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
-		unsigned int nbits)
-{
-	if (__builtin_constant_p(nbits) && nbits == 1)
-		__clear_bit(start, map);
-	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
-		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
-		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
-		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0, nbits / 8);
-	else
-		__bitmap_clear(map, start, nbits);
-}
-
-#endif
diff --git a/arch/x86/boot/compressed/bits.h b/arch/x86/boot/compressed/bits.h
deleted file mode 100644
index b0ffa007ee19..000000000000
--- a/arch/x86/boot/compressed/bits.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef BOOT_BITS_H
-#define BOOT_BITS_H
-#define __LINUX_BITS_H /* Inhibit inclusion of <linux/bits.h> */
-
-#ifdef __ASSEMBLY__
-#define _AC(X,Y)	X
-#define _AT(T,X)	X
-#else
-#define __AC(X,Y)	(X##Y)
-#define _AC(X,Y)	__AC(X,Y)
-#define _AT(T,X)	((T)(X))
-#endif
-
-#define _UL(x)		(_AC(x, UL))
-#define _ULL(x)		(_AC(x, ULL))
-#define UL(x)		(_UL(x))
-#define ULL(x)		(_ULL(x))
-
-#define BIT(nr)			(UL(1) << (nr))
-#define BIT_ULL(nr)		(ULL(1) << (nr))
-#define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
-#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
-#define BITS_PER_BYTE		8
-
-#define GENMASK(h, l) \
-	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
-
-#define GENMASK_ULL(h, l) \
-	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
-	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
-
-#endif
diff --git a/arch/x86/boot/compressed/find.c b/arch/x86/boot/compressed/find.c
deleted file mode 100644
index b97a9e7c8085..000000000000
--- a/arch/x86/boot/compressed/find.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include "bitmap.h"
-#include "find.h"
-#include "math.h"
-#include "minmax.h"
-
-static __always_inline unsigned long swab(const unsigned long y)
-{
-#if __BITS_PER_LONG == 64
-	return __builtin_bswap32(y);
-#else /* __BITS_PER_LONG == 32 */
-	return __builtin_bswap64(y);
-#endif
-}
-
-unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
-{
-	unsigned long tmp, mask;
-
-	if (start >= nbits)
-		return nbits;
-
-	tmp = addr1[start / BITS_PER_LONG];
-	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
-
-	/* Handle 1st word. */
-	mask = BITMAP_FIRST_WORD_MASK(start);
-	if (le)
-		mask = swab(mask);
-
-	tmp &= mask;
-
-	start = round_down(start, BITS_PER_LONG);
-
-	while (!tmp) {
-		start += BITS_PER_LONG;
-		if (start >= nbits)
-			return nbits;
-
-		tmp = addr1[start / BITS_PER_LONG];
-		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
-	}
-
-	if (le)
-		tmp = swab(tmp);
-
-	return min(start + __ffs(tmp), nbits);
-}
diff --git a/arch/x86/boot/compressed/find.h b/arch/x86/boot/compressed/find.h
deleted file mode 100644
index 903574b9d57a..000000000000
--- a/arch/x86/boot/compressed/find.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef BOOT_FIND_H
-#define BOOT_FIND_H
-#define __LINUX_FIND_H /* Inhibit inclusion of <linux/find.h> */
-
-#include "../bitops.h"
-#include "align.h"
-#include "bits.h"
-
-unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
-
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The bitmap size in bits
- *
- * Returns the bit number for the next set bit
- * If no bits are set, returns @size.
- */
-static inline
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-			    unsigned long offset)
-{
-	if (small_const_nbits(size)) {
-		unsigned long val;
-
-		if (offset >= size)
-			return size;
-
-		val = *addr & GENMASK(size - 1, offset);
-		return val ? __ffs(val) : size;
-	}
-
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
-}
-
-/**
- * find_next_zero_bit - find the next cleared bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The bitmap size in bits
- *
- * Returns the bit number of the next zero bit
- * If no bits are zero, returns @size.
- */
-static inline
-unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset)
-{
-	if (small_const_nbits(size)) {
-		unsigned long val;
-
-		if (offset >= size)
-			return size;
-
-		val = *addr | ~GENMASK(size - 1, offset);
-		return val == ~0UL ? size : ffz(val);
-	}
-
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
-}
-
-/**
- * for_each_set_bitrange_from - iterate over all set bit ranges [b; e)
- * @b: bit offset of start of current bitrange (first set bit); must be initialized
- * @e: bit offset of end of current bitrange (first unset bit)
- * @addr: bitmap address to base the search on
- * @size: bitmap size in number of bits
- */
-#define for_each_set_bitrange_from(b, e, addr, size)		\
-	for ((b) = find_next_bit((addr), (size), (b)),		\
-	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
-	     (b) < (size);					\
-	     (b) = find_next_bit((addr), (size), (e) + 1),	\
-	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
-#endif
diff --git a/arch/x86/boot/compressed/math.h b/arch/x86/boot/compressed/math.h
deleted file mode 100644
index f7eede84bbc2..000000000000
--- a/arch/x86/boot/compressed/math.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef BOOT_MATH_H
-#define BOOT_MATH_H
-#define __LINUX_MATH_H /* Inhibit inclusion of <linux/math.h> */
-
-/*
- *
- * This looks more complex than it should be. But we need to
- * get the type for the ~ right in round_down (it needs to be
- * as wide as the result!), and we want to evaluate the macro
- * arguments just once each.
- */
-#define __round_mask(x, y) ((__typeof__(x))((y)-1))
-
-/**
- * round_up - round up to next specified power of 2
- * @x: the value to round
- * @y: multiple to round up to (must be a power of 2)
- *
- * Rounds @x up to next multiple of @y (which must be a power of 2).
- * To perform arbitrary rounding up, use roundup() below.
- */
-#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
-
-/**
- * round_down - round down to next specified power of 2
- * @x: the value to round
- * @y: multiple to round down to (must be a power of 2)
- *
- * Rounds @x down to next multiple of @y (which must be a power of 2).
- * To perform arbitrary rounding down, use rounddown() below.
- */
-#define round_down(x, y) ((x) & ~__round_mask(x, y))
-
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-
-#endif
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index e6b92e822ddd..8138f4bd1959 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -1,19 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "../cpuflags.h"
-#include "bitmap.h"
+#include "../string.h"
 #include "error.h"
-#include "find.h"
-#include "math.h"
-#include "tdx.h"
 #include <asm/shared/tdx.h>
 
 #define PMD_SHIFT	21
 #define PMD_SIZE	(_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE - 1))
 
-extern struct boot_params *boot_params;
-
 /*
  * accept_memory() and process_unaccepted_memory() called from EFI stub which
  * runs before decompresser and its early_tdx_detect().
@@ -40,7 +35,7 @@ static bool early_is_tdx_guest(void)
 	return is_tdx;
 }
 
-static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
+void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest())
@@ -48,75 +43,3 @@ static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 	else
 		error("Cannot accept memory: unknown platform\n");
 }
-
-/*
- * The accepted memory bitmap only works at PMD_SIZE granularity.  Take
- * unaligned start/end addresses and either:
- *  1. Accepts the memory immediately and in its entirety
- *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
- *
- * The function will never reach the bitmap_set() with zero bits to set.
- */
-void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
-{
-	/*
-	 * Ensure that at least one bit will be set in the bitmap by
-	 * immediately accepting all regions under 2*PMD_SIZE.  This is
-	 * imprecise and may immediately accept some areas that could
-	 * have been represented in the bitmap.  But, results in simpler
-	 * code below
-	 *
-	 * Consider case like this:
-	 *
-	 * | 4k | 2044k |    2048k   |
-	 * ^ 0x0        ^ 2MB        ^ 4MB
-	 *
-	 * Only the first 4k has been accepted. The 0MB->2MB region can not be
-	 * represented in the bitmap. The 2MB->4MB region can be represented in
-	 * the bitmap. But, the 0MB->4MB region is <2*PMD_SIZE and will be
-	 * immediately accepted in its entirety.
-	 */
-	if (end - start < 2 * PMD_SIZE) {
-		__accept_memory(start, end);
-		return;
-	}
-
-	/*
-	 * No matter how the start and end are aligned, at least one unaccepted
-	 * PMD_SIZE area will remain to be marked in the bitmap.
-	 */
-
-	/* Immediately accept a <PMD_SIZE piece at the start: */
-	if (start & ~PMD_MASK) {
-		__accept_memory(start, round_up(start, PMD_SIZE));
-		start = round_up(start, PMD_SIZE);
-	}
-
-	/* Immediately accept a <PMD_SIZE piece at the end: */
-	if (end & ~PMD_MASK) {
-		__accept_memory(round_down(end, PMD_SIZE), end);
-		end = round_down(end, PMD_SIZE);
-	}
-
-	/*
-	 * 'start' and 'end' are now both PMD-aligned.
-	 * Record the range as being unaccepted:
-	 */
-	bitmap_set((unsigned long *)params->unaccepted_memory,
-		   start / PMD_SIZE, (end - start) / PMD_SIZE);
-}
-
-void accept_memory(phys_addr_t start, phys_addr_t end)
-{
-	unsigned long range_start, range_end;
-	unsigned long *bitmap, bitmap_size;
-
-	bitmap = (unsigned long *)boot_params->unaccepted_memory;
-	range_start = start / PMD_SIZE;
-	bitmap_size = DIV_ROUND_UP(end, PMD_SIZE);
-
-	for_each_set_bitrange_from(range_start, range_end, bitmap, bitmap_size) {
-		__accept_memory(range_start * PMD_SIZE, range_end * PMD_SIZE);
-		bitmap_clear(bitmap, range_start, range_end - range_start);
-	}
-}
diff --git a/arch/x86/boot/compressed/minmax.h b/arch/x86/boot/compressed/minmax.h
deleted file mode 100644
index 4efd05673260..000000000000
--- a/arch/x86/boot/compressed/minmax.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef BOOT_MINMAX_H
-#define BOOT_MINMAX_H
-#define __LINUX_MINMAX_H /* Inhibit inclusion of <linux/minmax.h> */
-
-/*
- * This returns a constant expression while determining if an argument is
- * a constant expression, most importantly without evaluating the argument.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
- */
-#define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-
-/*
- * min()/max()/clamp() macros must accomplish three things:
- *
- * - avoid multiple evaluations of the arguments (so side-effects like
- *   "x++" happen only once) when non-constant.
- * - perform strict type-checking (to generate warnings instead of
- *   nasty runtime surprises). See the "unnecessary" pointer comparison
- *   in __typecheck().
- * - retain result as a constant expressions when called with only
- *   constant expressions (to avoid tripping VLA warnings in stack
- *   allocation usage).
- */
-#define __typecheck(x, y) \
-	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
-
-#define __no_side_effects(x, y) \
-		(__is_constexpr(x) && __is_constexpr(y))
-
-#define __safe_cmp(x, y) \
-		(__typecheck(x, y) && __no_side_effects(x, y))
-
-#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
-
-#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
-		typeof(x) unique_x = (x);		\
-		typeof(y) unique_y = (y);		\
-		__cmp(unique_x, unique_y, op); })
-
-#define __careful_cmp(x, y, op) \
-	__builtin_choose_expr(__safe_cmp(x, y), \
-		__cmp(x, y, op), \
-		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
-
-/**
- * min - return minimum of two values of the same or compatible types
- * @x: first value
- * @y: second value
- */
-#define min(x, y)	__careful_cmp(x, y, <)
-
-/**
- * max - return maximum of two values of the same or compatible types
- * @x: first value
- * @y: second value
- */
-#define max(x, y)	__careful_cmp(x, y, >)
-
-#endif
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 186bfd53e042..eb8df0d4ad51 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -456,7 +456,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	debug_putstr("\nDecompressing Linux... ");
 
-	if (boot_params->unaccepted_memory) {
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
 		debug_putstr("Accepting memory... ");
 		accept_memory(__pa(output), __pa(output) + needed_size);
 	}
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 4bab2bb2c9c0..92f27d67408f 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -20,8 +20,6 @@ struct page;
 
 #include <linux/range.h>
 
-#include <asm/unaccepted_memory.h>
-
 extern struct range pfn_mapped[];
 extern int nr_pfn_mapped;
 
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index 89fc91c61560..32aff182fd67 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -3,14 +3,24 @@
 #ifndef _ASM_X86_UNACCEPTED_MEMORY_H
 #define _ASM_X86_UNACCEPTED_MEMORY_H
 
-struct boot_params;
+#include <linux/efi.h>
+#include <asm/tdx.h>
 
-void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
+static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		tdx_accept_memory(start, end);
+	} else {
+		panic("Cannot accept memory: unknown platform\n");
+	}
+}
 
-#ifdef CONFIG_UNACCEPTED_MEMORY
-
-void accept_memory(phys_addr_t start, phys_addr_t end);
-bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
+static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
+{
+	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
+		return NULL;
 
-#endif
+	return __va(efi.unaccepted);
+}
 #endif
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 630a54046af0..01d19fc22346 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -189,7 +189,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u64 unaccepted_memory;			/* 0x078 */
+	__u8  _pad3[8];					/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 483c36a28d2e..fb8cf953380d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1316,23 +1316,6 @@ void __init e820__memblock_setup(void)
 	int i;
 	u64 end;
 
-	/*
-	 * Mark unaccepted memory bitmap reserved.
-	 *
-	 * This kind of reservation usually done from early_reserve_memory(),
-	 * but early_reserve_memory() called before e820__memory_setup(), so
-	 * e820_table is not finalized and e820__end_of_ram_pfn() cannot be
-	 * used to get correct RAM size.
-	 */
-	if (boot_params.unaccepted_memory) {
-		unsigned long size;
-
-		/* One bit per 2MB */
-		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
-				    PMD_SIZE * BITS_PER_BYTE);
-		memblock_reserve(boot_params.unaccepted_memory, size);
-	}
-
 	/*
 	 * The bootstrap memblock region count maximum is 128 entries
 	 * (INIT_MEMBLOCK_REGIONS), but EFI might pass us more E820 entries
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index b0ef1755e5c8..c80febc44cd2 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -67,5 +67,3 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
-
-obj-$(CONFIG_UNACCEPTED_MEMORY)	+= unaccepted_memory.o
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
deleted file mode 100644
index f61174d4c3cb..000000000000
--- a/arch/x86/mm/unaccepted_memory.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/memblock.h>
-#include <linux/mm.h>
-#include <linux/pfn.h>
-#include <linux/spinlock.h>
-
-#include <asm/io.h>
-#include <asm/setup.h>
-#include <asm/shared/tdx.h>
-#include <asm/unaccepted_memory.h>
-
-/* Protects unaccepted memory bitmap */
-static DEFINE_SPINLOCK(unaccepted_memory_lock);
-
-void accept_memory(phys_addr_t start, phys_addr_t end)
-{
-	unsigned long range_start, range_end;
-	unsigned long *bitmap;
-	unsigned long flags;
-
-	if (!boot_params.unaccepted_memory)
-		return;
-
-	bitmap = __va(boot_params.unaccepted_memory);
-	range_start = start / PMD_SIZE;
-
-	/*
-	 * load_unaligned_zeropad() can lead to unwanted loads across page
-	 * boundaries. The unwanted loads are typically harmless. But, they
-	 * might be made to totally unrelated or even unmapped memory.
-	 * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
-	 * #VE) to recover from these unwanted loads.
-	 *
-	 * But, this approach does not work for unaccepted memory. For TDX, a
-	 * load from unaccepted memory will not lead to a recoverable exception
-	 * within the guest. The guest will exit to the VMM where the only
-	 * recourse is to terminate the guest.
-	 *
-	 * There are two parts to fix this issue and comprehensively avoid
-	 * access to unaccepted memory. Together these ensure that an extra
-	 * "guard" page is accepted in addition to the memory that needs to be
-	 * used:
-	 *
-	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
-	 *    checks up to end+2M if 'end' is aligned on a 2M boundary.
-	 *
-	 * 2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
-	 *    aligned on a 2M boundary. (immediately following this comment)
-	 */
-	if (!(end % PMD_SIZE))
-		end += PMD_SIZE;
-
-	spin_lock_irqsave(&unaccepted_memory_lock, flags);
-	for_each_set_bitrange_from(range_start, range_end, bitmap,
-				   DIV_ROUND_UP(end, PMD_SIZE)) {
-		unsigned long len = range_end - range_start;
-
-		/* Platform-specific memory-acceptance call goes here */
-		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
-			tdx_accept_memory(range_start * PMD_SIZE,
-					  range_end * PMD_SIZE);
-		} else {
-			panic("Cannot accept memory: unknown platform\n");
-		}
-
-		bitmap_clear(bitmap, range_start, len);
-	}
-	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
-}
-
-bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
-{
-	unsigned long *bitmap;
-	unsigned long flags;
-	bool ret = false;
-
-	if (!boot_params.unaccepted_memory)
-		return 0;
-
-	bitmap = __va(boot_params.unaccepted_memory);
-
-	/*
-	 * Also consider the unaccepted state of the *next* page. See fix #1 in
-	 * the comment on load_unaligned_zeropad() in accept_memory().
-	 */
-	if (!(end % PMD_SIZE))
-		end += PMD_SIZE;
-
-	spin_lock_irqsave(&unaccepted_memory_lock, flags);
-	while (start < end) {
-		if (test_bit(start / PMD_SIZE, bitmap)) {
-			ret = true;
-			break;
-		}
-
-		start += PMD_SIZE;
-	}
-	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
-
-	return ret;
-}
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index b51f2a4c821e..e489fefd23da 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
+obj-$(CONFIG_UNACCEPTED_MEMORY)		+= unaccepted_memory.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7dce06e419c5..bddb5aeb0d12 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -50,6 +50,9 @@ struct efi __read_mostly efi = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	.coco_secret		= EFI_INVALID_TABLE_ADDR,
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	.unaccepted		= EFI_INVALID_TABLE_ADDR,
+#endif
 };
 EXPORT_SYMBOL(efi);
 
@@ -605,6 +608,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	{LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,	&efi.unaccepted,	"Unaccepted"	},
+#endif
 #ifdef CONFIG_EFI_GENERIC_STUB
 	{LINUX_EFI_SCREEN_INFO_TABLE_GUID,	&screen_info_table			},
 #endif
@@ -759,6 +765,25 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
+		struct efi_unaccepted_memory *unaccepted;
+
+		unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
+		if (unaccepted) {
+			unsigned long size;
+
+			if (unaccepted->version == 0) {
+				size = sizeof(*unaccepted) + unaccepted->size;
+				memblock_reserve(efi.unaccepted, size);
+			} else {
+				efi.unaccepted = EFI_INVALID_TABLE_ADDR;
+			}
+
+			early_memunmap(unaccepted, sizeof(*unaccepted));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 3abb2b357482..a09edfbd7cfc 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -96,6 +96,8 @@ CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
 lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
 
+lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o find.o
+
 extra-y				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d5a20802e0..8659a01664b8 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1133,4 +1133,10 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
 
+efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
+					struct efi_boot_memmap *map);
+void process_unaccepted_memory(u64 start, u64 end);
+void accept_memory(phys_addr_t start, phys_addr_t end);
+void arch_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/find.c b/drivers/firmware/efi/libstub/find.c
new file mode 100644
index 000000000000..4e7740d28987
--- /dev/null
+++ b/drivers/firmware/efi/libstub/find.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bitmap.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+
+/*
+ * Common helper for find_next_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
+ */
+#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
+({										\
+	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
+										\
+	if (unlikely(__start >= sz))						\
+		goto out;							\
+										\
+	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
+		if ((idx + 1) * BITS_PER_LONG >= sz)				\
+			goto out;						\
+		idx++;								\
+	}									\
+										\
+	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
+out:										\
+	sz;									\
+})
+
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+}
+
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+}
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
new file mode 100644
index 000000000000..6c19d8fa563e
--- /dev/null
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "efistub.h"
+
+static struct efi_unaccepted_memory *unaccepted_table;
+
+efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
+					struct efi_boot_memmap *map)
+{
+	efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+	u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size;
+	efi_status_t status;
+	int i;
+
+	/* Check if the table is already installed */
+	unaccepted_table = get_efi_config_table(unaccepted_table_guid);
+	if (unaccepted_table) {
+		if (unaccepted_table->version != 0) {
+			efi_err("Unknown version of unaccepted memory tatble\n");
+			return EFI_UNSUPPORTED;
+		}
+		return EFI_SUCCESS;
+	}
+
+	/* Check if there's any unaccepted memory and find the max address */
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+		unsigned long m = (unsigned long)map->map;
+
+		d = efi_early_memdesc_ptr(m, map->desc_size, i);
+		if (d->type != EFI_UNACCEPTED_MEMORY)
+			continue;
+
+		unaccepted_start = min(unaccepted_start, d->phys_addr);
+		unaccepted_end = max(unaccepted_end,
+				     d->phys_addr + d->num_pages * PAGE_SIZE);
+	}
+
+	if (unaccepted_start == ULLONG_MAX)
+		return EFI_SUCCESS;
+
+	unaccepted_start = round_down(unaccepted_start, PMD_SIZE);
+	unaccepted_end = round_up(unaccepted_end, PMD_SIZE);
+
+	/*
+	 * If unaccepted memory is present, allocate a bitmap to track what
+	 * memory has to be accepted before access.
+	 *
+	 * One bit in the bitmap represents 2MiB in the address space:
+	 * A 4k bitmap can track 64GiB of physical address space.
+	 *
+	 * In the worst case scenario -- a huge hole in the middle of the
+	 * address space -- It needs 256MiB to handle 4PiB of the address
+	 * space.
+	 *
+	 * The bitmap will be populated in setup_e820() according to the memory
+	 * map after efi_exit_boot_services().
+	 */
+	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
+				   PMD_SIZE * BITS_PER_BYTE);
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     sizeof(*unaccepted_table) + bitmap_size,
+			     (void **)&unaccepted_table);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate unaccepted memory config table\n");
+		return status;
+	}
+
+	unaccepted_table->version = 0;
+	unaccepted_table->unit_size = PMD_SIZE;
+	unaccepted_table->phys_base = unaccepted_start;
+	unaccepted_table->size = bitmap_size;
+	memset(unaccepted_table->bitmap, 0, bitmap_size);
+
+	status = efi_bs_call(install_configuration_table,
+			     &unaccepted_table_guid, unaccepted_table);
+	if (status != EFI_SUCCESS) {
+		efi_bs_call(free_pool, unaccepted_table);
+		efi_err("Failed to install unaccepted memory config table!\n");
+	}
+
+	return status;
+}
+
+/*
+ * The accepted memory bitmap only works at PMD_SIZE granularity.  Take
+ * unaligned start/end addresses and either:
+ *  1. Accepts the memory immediately and in its entirety
+ *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
+ *
+ * The function will never reach the bitmap_set() with zero bits to set.
+ */
+void process_unaccepted_memory(u64 start, u64 end)
+{
+	u64 unit_size = unaccepted_table->unit_size;
+	u64 unit_mask = unaccepted_table->unit_size - 1;
+	u64 bitmap_size = unaccepted_table->size;
+
+	/*
+	 * Ensure that at least one bit will be set in the bitmap by
+	 * immediately accepting all regions under 2*unit_size.  This is
+	 * imprecise and may immediately accept some areas that could
+	 * have been represented in the bitmap.  But, results in simpler
+	 * code below
+	 *
+	 * Consider case like this (assuming unit_size == 2MB):
+	 *
+	 * | 4k | 2044k |    2048k   |
+	 * ^ 0x0        ^ 2MB        ^ 4MB
+	 *
+	 * Only the first 4k has been accepted. The 0MB->2MB region can not be
+	 * represented in the bitmap. The 2MB->4MB region can be represented in
+	 * the bitmap. But, the 0MB->4MB region is <2*unit_size and will be
+	 * immediately accepted in its entirety.
+	 */
+	if (end - start < 2 * unit_size) {
+		arch_accept_memory(start, end);
+		return;
+	}
+
+	/*
+	 * No matter how the start and end are aligned, at least one unaccepted
+	 * unit_size area will remain to be marked in the bitmap.
+	 */
+
+	/* Immediately accept a <unit_size piece at the start: */
+	if (start & unit_mask) {
+		arch_accept_memory(start, round_up(start, unit_size));
+		start = round_up(start, unit_size);
+	}
+
+	/* Immediately accept a <unit_size piece at the end: */
+	if (end & unit_mask) {
+		arch_accept_memory(round_down(end, unit_size), end);
+		end = round_down(end, unit_size);
+	}
+
+	/*
+	 * Accept part of the range that before phys_base and cannot be recorded
+	 * into the bitmap.
+	 */
+	if (start < unaccepted_table->phys_base) {
+		arch_accept_memory(start,
+				   min(unaccepted_table->phys_base, end));
+		start = unaccepted_table->phys_base;
+	}
+
+	/* Nothing to record */
+	if (end < unaccepted_table->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	/* Accept memory that doesn't fit into bitmap */
+	if (end > bitmap_size * unit_size * BITS_PER_BYTE) {
+		unsigned long phys_start, phys_end;
+
+		phys_start = bitmap_size * unit_size * BITS_PER_BYTE +
+			     unaccepted_table->phys_base;
+		phys_end = end + unaccepted_table->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		end = bitmap_size * unit_size * BITS_PER_BYTE;
+	}
+
+	/*
+	 * 'start' and 'end' are now both unit_size-aligned.
+	 * Record the range as being unaccepted:
+	 */
+	bitmap_set(unaccepted_table->bitmap,
+		   start / unit_size, (end - start) / unit_size);
+}
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long range_start, range_end;
+	unsigned long bitmap_size;
+	u64 unit_size;
+
+	if (!unaccepted_table)
+		return;
+
+	unit_size = unaccepted_table->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted_table->phys_base)
+		start = unaccepted_table->phys_base;
+	if (end < unaccepted_table->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
+
+	range_start = start / unit_size;
+	bitmap_size = DIV_ROUND_UP(end, unit_size);
+
+	for_each_set_bitrange_from(range_start, range_end,
+				   unaccepted_table->bitmap, bitmap_size) {
+		unsigned long phys_start, phys_end;
+
+		phys_start = range_start * unit_size + unaccepted_table->phys_base;
+		phys_end = range_end * unit_size + unaccepted_table->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		bitmap_clear(unaccepted_table->bitmap,
+			     range_start, range_end - range_start);
+	}
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1afe7b5b02e1..16ea5e76907f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -621,7 +621,7 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 				continue;
 			}
 			e820_type = E820_TYPE_RAM;
-			process_unaccepted_memory(params, d->phys_addr,
+			process_unaccepted_memory(d->phys_addr,
 						  d->phys_addr + PAGE_SIZE * d->num_pages);
 			break;
 		default:
@@ -688,64 +688,6 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 	return status;
 }
 
-static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
-					       __u32 nr_desc,
-					       struct efi_boot_memmap *map)
-{
-	unsigned long *mem = NULL;
-	u64 size, max_addr = 0;
-	efi_status_t status;
-	bool found = false;
-	int i;
-
-	/* Check if there's any unaccepted memory and find the max address */
-	for (i = 0; i < nr_desc; i++) {
-		efi_memory_desc_t *d;
-		unsigned long m = (unsigned long)map->map;
-
-		d = efi_early_memdesc_ptr(m, map->desc_size, i);
-		if (d->type == EFI_UNACCEPTED_MEMORY)
-			found = true;
-		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
-			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
-	}
-
-	if (!found) {
-		params->unaccepted_memory = 0;
-		return EFI_SUCCESS;
-	}
-
-	/*
-	 * range_contains_unaccepted_memory() may need to check one 2M chunk
-	 * beyond the end of RAM to deal with load_unaligned_zeropad(). Make
-	 * sure that the bitmap is large enough handle it.
-	 */
-	max_addr += PMD_SIZE;
-
-	/*
-	 * If unaccepted memory is present, allocate a bitmap to track what
-	 * memory has to be accepted before access.
-	 *
-	 * One bit in the bitmap represents 2MiB in the address space:
-	 * A 4k bitmap can track 64GiB of physical address space.
-	 *
-	 * In the worst case scenario -- a huge hole in the middle of the
-	 * address space -- It needs 256MiB to handle 4PiB of the address
-	 * space.
-	 *
-	 * The bitmap will be populated in setup_e820() according to the memory
-	 * map after efi_exit_boot_services().
-	 */
-	size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
-	status = efi_allocate_pages(size, (unsigned long *)&mem, ULONG_MAX);
-	if (status == EFI_SUCCESS) {
-		memset(mem, 0, size);
-		params->unaccepted_memory = (unsigned long)mem;
-	}
-
-	return status;
-}
-
 static efi_status_t allocate_e820(struct boot_params *params,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
@@ -767,7 +709,7 @@ static efi_status_t allocate_e820(struct boot_params *params,
 	}
 
 	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
-		status = allocate_unaccepted_bitmap(params, nr_desc, map);
+		status = allocate_unaccepted_bitmap(nr_desc, map);
 
 	efi_bs_call(free_pool, map);
 	return status;
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
new file mode 100644
index 000000000000..3d1ca60916dd
--- /dev/null
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <linux/memblock.h>
+#include <linux/spinlock.h>
+#include <asm/unaccepted_memory.h>
+
+/* Protects unaccepted memory bitmap */
+static DEFINE_SPINLOCK(unaccepted_memory_lock);
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long range_start, range_end;
+	unsigned long flags;
+	u64 unit_size;
+
+	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
+		return;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return;
+
+	unit_size = unaccepted->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted->phys_base)
+		start = unaccepted->phys_base;
+	if (end < unaccepted->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted->phys_base;
+	end -= unaccepted->phys_base;
+
+	/*
+	 * load_unaligned_zeropad() can lead to unwanted loads across page
+	 * boundaries. The unwanted loads are typically harmless. But, they
+	 * might be made to totally unrelated or even unmapped memory.
+	 * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
+	 * #VE) to recover from these unwanted loads.
+	 *
+	 * But, this approach does not work for unaccepted memory. For TDX, a
+	 * load from unaccepted memory will not lead to a recoverable exception
+	 * within the guest. The guest will exit to the VMM where the only
+	 * recourse is to terminate the guest.
+	 *
+	 * There are two parts to fix this issue and comprehensively avoid
+	 * access to unaccepted memory. Together these ensure that an extra
+	 * "guard" page is accepted in addition to the memory that needs to be
+	 * used:
+	 *
+	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
+	 *    checks up to end+unit_size if 'end' is aligned on a unit_size
+	 *    boundary.
+	 *
+	 * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
+	 *    'end' is aligned on a unit_size boundary. (immediately following
+	 *    this comment)
+	 */
+	if (!(end % unit_size))
+		end += unit_size;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted->size * unit_size * BITS_PER_BYTE;
+
+	range_start = start / unit_size;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
+				   DIV_ROUND_UP(end, unit_size)) {
+		unsigned long phys_start, phys_end;
+		unsigned long len = range_end - range_start;
+
+		phys_start = range_start * unit_size + unaccepted->phys_base;
+		phys_end = range_end * unit_size + unaccepted->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		bitmap_clear(unaccepted->bitmap, range_start, len);
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long flags;
+	bool ret = false;
+	u64 unit_size;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return false;
+
+	unit_size = unaccepted->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted->phys_base)
+		start = unaccepted->phys_base;
+	if (end < unaccepted->phys_base)
+		return false;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted->phys_base;
+	end -= unaccepted->phys_base;
+
+	/*
+	 * Also consider the unaccepted state of the *next* page. See fix #1 in
+	 * the comment on load_unaligned_zeropad() in accept_memory().
+	 */
+	if (!(end % unit_size))
+		end += unit_size;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted->size * unit_size * BITS_PER_BYTE;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	while (start < end) {
+		if (test_bit(start / unit_size, unaccepted->bitmap)) {
+			ret = true;
+			break;
+		}
+
+		start += unit_size;
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+	return ret;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index efbe14641638..0f4620060ed8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -418,6 +418,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
+#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
@@ -535,6 +536,16 @@ struct efi_boot_memmap {
 	efi_memory_desc_t	map[];
 };
 
+struct efi_unaccepted_memory {
+	u32 version;
+	u32 unit_size;
+	u64 phys_base;
+	u64 size;
+	unsigned long bitmap[];
+};
+
+void __init efi_unaccepted_table_init(void);
+
 /*
  * Architecture independent structure for describing a memory map for the
  * benefit of efi_memmap_init_early(), and for passing context between
@@ -637,6 +648,7 @@ extern struct efi {
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
 	unsigned long			coco_secret;		/* Confidential computing secret table */
+	unsigned long			unaccepted;		/* Unaccepted memory table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
diff --git a/mm/internal.h b/mm/internal.h
index ed042e366d49..2e70f22d1b3f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1100,7 +1100,13 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
-#ifndef CONFIG_UNACCEPTED_MEMORY
+#ifdef CONFIG_UNACCEPTED_MEMORY
+
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
+#else
+
 static inline bool range_contains_unaccepted_memory(phys_addr_t start,
 						    phys_addr_t end)
 {
@@ -1110,6 +1116,7 @@ static inline bool range_contains_unaccepted_memory(phys_addr_t start,
 static inline void accept_memory(phys_addr_t start, phys_addr_t end)
 {
 }
+
 #endif
 
 #endif	/* __MM_INTERNAL_H */
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
