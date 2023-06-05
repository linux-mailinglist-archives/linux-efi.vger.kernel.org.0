Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FBC722495
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jun 2023 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjFELaA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Jun 2023 07:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjFEL37 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Jun 2023 07:29:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE4AF2;
        Mon,  5 Jun 2023 04:29:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FBFC5C0866;
        Mon,  5 Jun 2023 07:29:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Jun 2023 07:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685964592; x=
        1686050992; bh=zgVsSkml0ZUf+diwF/IpmlB7ThuEx5ZK6dyS0WOuZhc=; b=u
        Nelz/e7YezKXbywQQ2b71oMdGIOrcGoL+JFwssctWl/20kzYCmDdRJVpI1PKSsrj
        qt9Yw35eAQSJUMtmQWZbjfCiizrA0fCD0yUq2hNyAZCQHxcS9FxQ2MNsx4pAh19u
        hROrufh7XZG7pN+sFBtvrR3RYdYBw2+4d8ptdODtIleUwQAYWQY2Jc90tGiyifMH
        RgxSnWDAZPBE/pHC3G8MjakN9/qct526KlbEIBtVmhViAb4HOpQf6s/AbFTCwqN/
        AhIBBJov944f2t5IRQFLDo3/r8E3htF4A+UF7/ZWlVj4k5zlbGn8LStmVNxwVqii
        S1uIuYh7p/lxtcUX8ynAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685964592; x=1686050992; bh=zgVsSkml0ZUf+
        diwF/IpmlB7ThuEx5ZK6dyS0WOuZhc=; b=n2WICb7jXp+FZW9iG2flG12lraqHJ
        TKLE4i7QGQMcpBQXEGR8daMNhGQcUX8O7SQeXS1xY8OIqVpZG9Y9sFlHHK48fDjp
        90Ht79JTt5sjcKLALPsyK49VpPyasGG3nUkbgKzwqtmWn3H6qcGXr3AupOkIfUM8
        61ySHtkYkBD0znWa0/a/GrdPy/lgU2ivzaxn8IfvrB4xXdjNLYzff6egXZB3SV6g
        TKzHJKu6v1u/ZzveN9wpdcEMtswv+mpU7QjZzmc1G7Ld4aPjnuzxiWQVVtPNiNbt
        T9LkobpL7VxMVPcYgwgzlJGv/Y9Dwuc0CKrDiU0fvdq4DVSf7+Gz6uAwA==
X-ME-Sender: <xms:L8d9ZBH-LO_bL4TSCvTiu1Pz9lJZa3fX0gi-kaEcY4Y2C9K9uHIhHA>
    <xme:L8d9ZGWPDYBgHXPN493QDx5iNPHLmj4hTpqbnKnWvG1q6yuwGNLCD3PP8egIPO_yT
    MsnEZXFowIC7e53pmo>
X-ME-Received: <xmr:L8d9ZDIkF3P3maeKdVCFOAo9cOJTpH7OnD7pZT6C1JTM0wkAVYr9JPyCDjiToyINiWOZNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetvdehffelffeiveeikeduffetudeuheeiiefg
    ueduvdevtdejhedvhfffffehfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:L8d9ZHHBWspnh3RQUhZWD3LsoWqO_nB4tqRaWLrMJkcISAPXeOkwhw>
    <xmx:L8d9ZHWn30B9KG4RDbAT6Av4nchuLj6iup_kaXwhkf-EfN19iokhiw>
    <xmx:L8d9ZCMHcOby6NBNAVV4BDe8NwSN9W-xE75vS7toXxN26Te8WrScgA>
    <xmx:MMd9ZGzOb1IfBinm5H_ZQ3AsalRrwWQJ75j3dHxK9H-AWvDqst6SBQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 07:29:50 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CF9CA10CB17; Mon,  5 Jun 2023 14:29:47 +0300 (+03)
Date:   Mon, 5 Jun 2023 14:29:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCHv13 4/9] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20230605112947.wp7tefv3s3e72vm6@box.shutemov.name>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-5-kirill.shutemov@linux.intel.com>
 <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Borislav,

Below is updated patch that suppose to address all your concerns.

I also adjusted 3/9 to remove the setter and make the variable globally
visible.

All changes, including fixup for 9/9 has been pushed to the branch

https://github.com/intel/tdx.git guest-unaccepted-memory

Let me know if you see more problems with the patchset.

From ddb1c92d33217b5acd2ec3278f7ed751afd15bd1 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 25 Aug 2021 21:42:51 +0300
Subject: [PATCH] x86/boot/compressed: Handle unaccepted memory

The firmware will pre-accept the memory used to run the stub. But, the
stub is responsible for accepting the memory into which it decompresses
the main kernel. Accept memory just before decompression starts.

The stub is also responsible for choosing a physical address in which to
place the decompressed kernel image. The KASLR mechanism will randomize
this physical address. Since the accepted memory region is relatively
small, KASLR would be quite ineffective if it only used the pre-accepted
area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
entire physical address space by also including EFI_UNACCEPTED_MEMORY.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/efi.h   | 10 ++++++++
 arch/x86/boot/compressed/kaslr.c | 40 +++++++++++++++++++++----------
 arch/x86/boot/compressed/mem.c   | 41 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.c  |  6 +++++
 arch/x86/boot/compressed/misc.h  | 10 ++++++++
 5 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index 7db2f41b54cd..866c0af8b5b9 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -16,6 +16,7 @@ typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 #define ACPI_TABLE_GUID				EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define ACPI_20_TABLE_GUID			EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
+#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
@@ -32,6 +33,7 @@ typedef	struct {
 } efi_table_hdr_t;
 
 #define EFI_CONVENTIONAL_MEMORY		 7
+#define EFI_UNACCEPTED_MEMORY		15
 
 #define EFI_MEMORY_MORE_RELIABLE \
 				((u64)0x0000000000010000ULL)	/* higher reliability */
@@ -104,6 +106,14 @@ struct efi_setup_data {
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
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 454757fbdfe5..9193acf0e9cd 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -672,6 +672,33 @@ static bool process_mem_region(struct mem_vector *region,
 }
 
 #ifdef CONFIG_EFI
+
+/*
+ * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
+ * guaranteed to be free.
+ *
+ * Pick free memory more conservatively than the EFI spec allows: according to
+ * the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory and thus
+ * available to place the kernel image into, but in practice there's firmware
+ * where using that memory leads to crashes. Buggy vendor EFI code registers
+ * for an event that triggers on SetVirtualAddressMap(). The handler assumes
+ * that EFI_BOOT_SERVICES_DATA memory has not been touched by loader yet, which
+ * is probably true for Windows.
+ *
+ * Preserve EFI_BOOT_SERVICES_* regions until after SetVirtualAddressMap().
+ */
+static inline bool memory_type_is_free(efi_memory_desc_t *md)
+{
+	if (md->type == EFI_CONVENTIONAL_MEMORY)
+		return true;
+
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    md->type == EFI_UNACCEPTED_MEMORY)
+		    return true;
+
+	return false;
+}
+
 /*
  * Returns true if we processed the EFI memmap, which we prefer over the E820
  * table if it is available.
@@ -716,18 +743,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 	for (i = 0; i < nr_desc; i++) {
 		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
 
-		/*
-		 * Here we are more conservative in picking free memory than
-		 * the EFI spec allows:
-		 *
-		 * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also
-		 * free memory and thus available to place the kernel image into,
-		 * but in practice there's firmware where using that memory leads
-		 * to crashes.
-		 *
-		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
-		 */
-		if (md->type != EFI_CONVENTIONAL_MEMORY)
+		if (!memory_type_is_free(md))
 			continue;
 
 		if (efi_soft_reserve_enabled() &&
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 67594fcb11d9..69038ed7a310 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -1,9 +1,50 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "error.h"
+#include "misc.h"
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	error("Cannot accept memory");
 }
+
+bool init_unaccepted_memory(void)
+{
+	guid_t guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+	struct efi_unaccepted_memory *table;
+	unsigned long cfg_table_pa;
+	unsigned int cfg_table_len;
+	enum efi_type et;
+	int ret;
+
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_NONE)
+		return false;
+
+	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
+	if (ret) {
+		warn("EFI config table not found.");
+		return false;
+	}
+
+	table = (void *)efi_find_vendor_table(boot_params, cfg_table_pa,
+					      cfg_table_len, guid);
+	if (!table)
+		return false;
+
+	if (table->version != 1)
+		error("Unknown version of unaccepted memory table\n");
+
+	/*
+	 * In many cases unaccepted_table is already set by EFI stub, but it
+	 * has to be initialized again to cover cases when the table is not
+	 * allocated by EFI stub or EFI stub copied the kernel image with
+	 * efi_relocate_kernel() before the variable is set.
+	 *
+	 * It must be initialized before the first usage of accept_memory().
+	 */
+	unaccepted_table = table;
+
+	return true;
+}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff222bf4b..94b7abcf624b 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -455,6 +455,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+	if (init_unaccepted_memory()) {
+		debug_putstr("Accepting memory... ");
+		accept_memory(__pa(output), __pa(output) + needed_size);
+	}
+
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
 	entry_offset = parse_elf(output);
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 2f155a0e3041..964fe903a1cd 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -247,4 +247,14 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
 }
 #endif /* CONFIG_EFI */
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+bool init_unaccepted_memory(void);
+#else
+static inline bool init_unaccepted_memory(void) { return false; }
+#endif
+
+/* Defined in EFI stub */
+extern struct efi_unaccepted_memory *unaccepted_table;
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.39.3

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
