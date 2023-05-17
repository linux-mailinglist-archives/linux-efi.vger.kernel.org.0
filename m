Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F487070E0
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEQSgY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQSgY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 14:36:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03CD7EC3;
        Wed, 17 May 2023 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684348571; x=1715884571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+aKSL6q9dJPEJobrP6WeOyJ2dGBu6HVTyqo3g6dYjw=;
  b=BoT4kKjzNXiDtH895qdVWdDPL5xjKe6mChqJS/UDYSm4x98fknJmY6Oj
   vIUD14xrEsZZ5lxJLf2knZPtD4aSL+PNnOKwU1/99zSXSpy2nUU2vsFqR
   Fb9Etn/gN0/8EMrzPM3qdtOxce97g+ZNJcBwqceePbSWBkHGNI0MUkhR3
   f//hdP7llicRqobT0NXhPiwisCQLAfRR8rbvJ5l2n0ZvushfgWt8Da/3H
   ejh5469KkE1w6o+5OZHzTNMplVmLMZmZjb+H+f4uMMkmX92xaazOV7Tq2
   BIUhi8WMqHUyxPpbpcHUkFdoo8C/yiSs9Dto9KIftejcNe4hyYM12Fgb9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349351042"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="349351042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 11:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="1031840277"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="1031840277"
Received: from bruennej-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.43.52])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 11:36:04 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8BD4710C8C1; Wed, 17 May 2023 21:36:01 +0300 (+03)
Date:   Wed, 17 May 2023 21:36:01 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCHv11 0/9] mm, x86/cc, efi: Implement support for unaccepted
 memory
Message-ID: <20230517183601.vgdnuchw3we2abua@box.shutemov.name>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <aa35a445-f410-b11f-bf21-3e482647faae@amd.com>
 <20230516232204.3k53vh6pdnimdrhi@box.shutemov.name>
 <fe62b3a6-2c28-a069-d880-772fe6c13125@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe62b3a6-2c28-a069-d880-772fe6c13125@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 17, 2023 at 09:32:27AM -0500, Tom Lendacky wrote:
> On 5/16/23 18:22, Kirill A. Shutemov wrote:
> > On Tue, May 16, 2023 at 05:41:55PM -0500, Tom Lendacky wrote:
> > > On 5/13/23 17:04, Kirill A. Shutemov wrote:
> > > > UEFI Specification version 2.9 introduces the concept of memory
> > > > acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> > > > SEV-SNP, requiring memory to be accepted before it can be used by the
> > > > guest. Accepting happens via a protocol specific for the Virtual
> > > > Machine platform.
> > > > 
> > > > Accepting memory is costly and it makes VMM allocate memory for the
> > > > accepted guest physical address range. It's better to postpone memory
> > > > acceptance until memory is needed. It lowers boot time and reduces
> > > > memory overhead.
> > > > 
> > > > The kernel needs to know what memory has been accepted. Firmware
> > > > communicates this information via memory map: a new memory type --
> > > > EFI_UNACCEPTED_MEMORY -- indicates such memory.
> > > > 
> > > > Range-based tracking works fine for firmware, but it gets bulky for
> > > > the kernel: e820 has to be modified on every page acceptance. It leads
> > > > to table fragmentation, but there's a limited number of entries in the
> > > > e820 table
> > > > 
> > > > Another option is to mark such memory as usable in e820 and track if the
> > > > range has been accepted in a bitmap. One bit in the bitmap represents
> > > > 2MiB in the address space: one 4k page is enough to track 64GiB or
> > > > physical address space.
> > > > 
> > > > In the worst-case scenario -- a huge hole in the middle of the
> > > > address space -- It needs 256MiB to handle 4PiB of the address
> > > > space.
> > > > 
> > > > Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> > > > 
> > > > The approach lowers boot time substantially. Boot to shell is ~2.5x
> > > > faster for 4G TDX VM and ~4x faster for 64G.
> > > > 
> > > > TDX-specific code isolated from the core of unaccepted memory support. It
> > > > supposed to help to plug-in different implementation of unaccepted memory
> > > > such as SEV-SNP.
> > > > 
> > > > -- Fragmentation study --
> > > > 
> > > > Vlastimil and Mel were concern about effect of unaccepted memory on
> > > > fragmentation prevention measures in page allocator. I tried to evaluate
> > > > it, but it is tricky. As suggested I tried to run multiple parallel kernel
> > > > builds and follow how often kmem:mm_page_alloc_extfrag gets hit.
> > > > 
> > > > See results in the v9 of the patchset[1][2]
> > > > 
> > > > [1] https://lore.kernel.org/all/20230330114956.20342-1-kirill.shutemov@linux.intel.com
> > > > [2] https://lore.kernel.org/all/20230416191940.ex7ao43pmrjhru2p@box.shutemov.name
> > > > 
> > > > --
> > > > 
> > > > The tree can be found here:
> > > > 
> > > > https://github.com/intel/tdx.git guest-unaccepted-memory
> > > 
> > > I get some failures when building without TDX support selected in my
> > > kernel config after adding unaccepted memory support for SNP:
> > > 
> > >    In file included from arch/x86/boot/compressed/../../coco/tdx/tdx-shared.c:1,
> > >                     from arch/x86/boot/compressed/tdx-shared.c:2:
> > >    ./arch/x86/include/asm/tdx.h: In function ?tdx_kvm_hypercall?:
> > >    ./arch/x86/include/asm/tdx.h:72:17: error: ?ENODEV? undeclared (first use in this function)
> > >       72 |         return -ENODEV;
> > >          |                 ^~~~~~
> > >    ./arch/x86/include/asm/tdx.h:72:17: note: each undeclared identifier is reported only once for each function it appears in
> > > 
> > > Adding an include for linux/errno.h gets past that error, but then
> > > I get the following:
> > > 
> > >    ld: arch/x86/boot/compressed/tdx-shared.o: in function `tdx_enc_status_changed_phys':
> > >    tdx-shared.c:(.text+0x42): undefined reference to `__tdx_hypercall'
> > >    ld: tdx-shared.c:(.text+0x7f): undefined reference to `__tdx_module_call'
> > >    ld: tdx-shared.c:(.text+0xce): undefined reference to `__tdx_module_call'
> > >    ld: tdx-shared.c:(.text+0x13b): undefined reference to `__tdx_module_call'
> > >    ld: tdx-shared.c:(.text+0x153): undefined reference to `cc_mkdec'
> > >    ld: tdx-shared.c:(.text+0x15d): undefined reference to `cc_mkdec'
> > >    ld: tdx-shared.c:(.text+0x18e): undefined reference to `__tdx_hypercall'
> > >    ld: arch/x86/boot/compressed/vmlinux: hidden symbol `__tdx_hypercall' isn't defined
> > >    ld: final link failed: bad value
> > > 
> > > So it looks like arch/x86/boot/compressed/tdx-shared.c is being
> > > built, while arch/x86/boot/compressed/tdx.c isn't.
> > 
> > Right. I think this should help:
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 78f67e0a2666..b13a58021086 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -106,8 +106,8 @@ ifdef CONFIG_X86_64
> >   endif
> > 
> >   vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> > -vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> > -vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o $(obj)/tdx-shared.o
> > +vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
> > +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
> > 
> >   vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> >   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> > 
> > > After setting TDX in the kernel config, I can build successfully, but
> > > I'm running into an error when trying to accept memory during
> > > decompression.
> > > 
> > > In drivers/firmware/efi/libstub/unaccepted_memory.c, I can see that the
> > > unaccepted_table is allocated, but when accept_memory() is invoked the
> > > table address is now zero. I thought maybe it had to do with bss, but even
> > > putting it in the .data section didn't help. I'll keep digging, but if you
> > > have any ideas, that would be great.
> > 
> > Not right away. But maybe seeing your side of enabling would help.
> 
> Let me get something pushed up where you can access it and I'll also send
> you my kernel config.
> 
> In the mean time I added the following and everything worked. But I'm not
> sure how acceptable it is to always be checking for the table when the
> value is zero is.
> 
> 
> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> index f4642c4f25dd..8c5632ab1208 100644
> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> @@ -183,8 +183,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  	unsigned long bitmap_size;
>  	u64 unit_size;
> -	if (!unaccepted_table)
> -		return;
> +	if (!unaccepted_table) {
> +		efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> +
> +		unaccepted_table = get_efi_config_table(unaccepted_table_guid);
> +		if (!unaccepted_table)
> +			return;
> +	}
>  	unit_size = unaccepted_table->unit_size;
> 

Kudos to Ard: if efi_relocate_kernel() triggered, it copies the kernel
image to the new place before the variable gets initialized, so it has to
be initialized explicitly by decompressor.

It also covers the cases when bootloader doesn't use EFI stub, including
kexec cases.

I think this fixup should work.

diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index cf475243b6d5..866c0af8b5b9 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -16,6 +16,7 @@ typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 #define ACPI_TABLE_GUID				EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define ACPI_20_TABLE_GUID			EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
+#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
@@ -105,6 +106,14 @@ struct efi_setup_data {
 	u64 reserved[8];
 };
 
+struct efi_unaccepted_memory {
+	u32 version;
+	u32 unit_size;
+	u64 phys_base;
+	u64 size;
+	unsigned long bitmap[];
+};
+
 static inline int efi_guidcmp (efi_guid_t left, efi_guid_t right)
 {
 	return memcmp(&left, &right, sizeof (efi_guid_t));
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index a4308d077885..0108c97399a5 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "../cpuflags.h"
-#include "../string.h"
 #include "error.h"
+#include "misc.h"
 #include "tdx.h"
 #include <asm/shared/tdx.h>
 
@@ -40,3 +39,25 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	else
 		error("Cannot accept memory: unknown platform\n");
 }
+
+void init_unaccepted_memory(void)
+{
+	guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+	struct efi_unaccepted_memory *unaccepted_table;
+	unsigned long cfg_table_pa;
+	unsigned int cfg_table_len;
+	int ret;
+
+	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
+	if (ret)
+		error("EFI config table not found.");
+
+	unaccepted_table = (void *)efi_find_vendor_table(boot_params,
+							 cfg_table_pa,
+							 cfg_table_len,
+							 guid);
+	if (unaccepted_table->version != 1)
+		error("Unknown version of unaccepted memory table\n");
+
+	set_unaccepted_table(unaccepted_table);
+}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index eb8df0d4ad51..36535a3753f5 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -458,6 +458,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
 		debug_putstr("Accepting memory... ");
+		init_unaccepted_memory();
 		accept_memory(__pa(output), __pa(output) + needed_size);
 	}
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9663d1839f54..e1a0b49e0ed2 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -247,10 +247,10 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
 }
 #endif /* CONFIG_EFI */
 
-#ifdef CONFIG_UNACCEPTED_MEMORY
+void init_unaccepted_memory(void);
+
+/* Implemented in EFI stub */
+void set_unaccepted_table(struct efi_unaccepted_memory *table);
 void accept_memory(phys_addr_t start, phys_addr_t end);
-#else
-static inline void accept_memory(phys_addr_t start, phys_addr_t end) {}
-#endif
 
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index f4642c4f25dd..fd6a3195c68f 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -6,6 +6,18 @@
 
 static struct efi_unaccepted_memory *unaccepted_table;
 
+/*
+ * Decompressor needs to initialize the variable to cover cases when the table
+ * is not allocated by EFI stub or EFI stub copied the kernel image with
+ * efi_relocate_kernel() before the variable is set.
+ *
+ * It must be call before the first usage of accept_memory() by decompressor.
+ */
+void set_unaccepted_table(struct efi_unaccepted_memory *table)
+{
+	unaccepted_table = table;
+}
+
 efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 					struct efi_boot_memmap *map)
 {
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
