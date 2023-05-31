Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03C717FE0
	for <lists+linux-efi@lfdr.de>; Wed, 31 May 2023 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjEaMZW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 May 2023 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjEaMZV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 31 May 2023 08:25:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F278E;
        Wed, 31 May 2023 05:25:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6D3B232009F4;
        Wed, 31 May 2023 08:25:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 31 May 2023 08:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685535915; x=
        1685622315; bh=RCkiAhPNkiHxNcIqRz+FlZ8GS8uzSW8unvPg4Gol6/I=; b=q
        yU/YD1c1JkrhGUF9/QfcvY1VoBfU+3jZO96fadM613KcMlDo9JI6blWGwDQ1vJPu
        w+9gIMbogMmC6DBOIga0oBJG/mFqKYYaF52EGmPsJ//sV8c8HrgfGhMgH/IMH52Z
        RGm9UsmYiMJImuEczvSdyVvyi2uqHeogHI+0l45m4ee1FiyJxgCgNslapa52akAW
        KRYJOftCehPNfZRN+vNiJlUv8WZjTa4BTvLWtyWKaDAMqGMJJixIOKgQtfz6xm1+
        Qoo4LNpSEEJQLxnnIpTdKm9Ws+tUerenJVcTZd57oxl4FoEbXbtpJyed8Bw0hmAl
        0tI+M2Azg4N6X2fcc1myA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685535915; x=1685622315; bh=RCkiAhPNkiHxN
        cIqRz+FlZ8GS8uzSW8unvPg4Gol6/I=; b=DWITZqpVPj5+wbHuQAOHDvPCf3AJt
        vGGIUitDpuhCzYSAQStJ8htvPbYdcdXA8OSANcmPNLyYKooWzEquOkteg1c45bHV
        XE1W1qLdRANuaXsPicdvLUl9Kyvnh34Y3PDRjE1z/hyhHWMUu7T4GfGaboViH5+M
        JOm92PyLKMt5/p+GcnHXp/+hzcBIkLHSUhPl44kD00Y9hrgamADB/uMKKrdEnvwM
        aizsdVeaxWfxMEfZY1bElYck9tT4js8pNtbuHyZYZRIcLOKVRLIeE/u5OYG/Xu+W
        2RZHQq5frlf/U6cs2NgNuAihG24toyZS3KQlUbH1jYEW4YvwwdBUxt4Tg==
X-ME-Sender: <xms:qTx3ZIwIHhmFjCk0T06_wrn7TKFSQJlD3NahcCmrxt_kMnf76fwyQg>
    <xme:qTx3ZMSHfT70tNz7D8efEmGPV2hJZOqQsJg4sdQEAS8-JaOXb0uD0u8EozG9PSBfs
    rF-g4rh-Jsv3mL1968>
X-ME-Received: <xmr:qTx3ZKU-fXv57XOQ67pojhlv6EakJPECJlUMVB3aBNbG5j5JcDvr7PhNBxb4KV36FgQ82A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:qjx3ZGhWmzWyNQaGX0pU7YzJVGEgG-fvsctmeJxE-c_UvyU5iP-eLw>
    <xmx:qjx3ZKD-6HZeBgDHdT1kH1-tmfKO6ekUAIdjTJH6uy0XEJdGxf9ouw>
    <xmx:qjx3ZHLGXvL_LCNwZvcn3uqhdmmZ2XY1_6fgWOHmTuZWTMRD-c6_bQ>
    <xmx:qzx3ZCtfG50WsfyRd9coAJ2Iaa8d32A8AOV1OAHWRSGfiUF4KeKUNQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 08:25:13 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 75BE310BD95; Wed, 31 May 2023 15:25:10 +0300 (+03)
Date:   Wed, 31 May 2023 15:25:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCHv12 9/9] x86/tdx: Add unaccepted memory support
Message-ID: <20230531122510.3vthiyearwkyqrwf@box.shutemov.name>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-10-kirill.shutemov@linux.intel.com>
 <20230531005837.GA1808127@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531005837.GA1808127@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 30, 2023 at 05:58:37PM -0700, Isaku Yamahata wrote:
> On Fri, May 19, 2023 at 02:14:34AM +0300,
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > Hookup TDX-specific code to accept memory.
> > 
> > Accepting the memory is the same process as converting memory from
> > shared to private: kernel notifies VMM with MAP_GPA hypercall and then
> > accept pages with ACCEPT_PAGE module call.
> > 
> > THE implementation in core kernel uses tdx_enc_status_changed(). It
> > already used for converting memory to shared and back for I/O
> > transactions.
> 
> Because unaccepted memory reported in e820 means private[1], MAP_GPA isn't
> needed to accept memory. (Or are you seeing TDX KVM/qemu issue?)
> 
> [1]TDX Virtual Firmware Design Guide.
> 7.2.1 Memroy Type in TD Resrouce HOB. Table 7-1: Mmeory Typein TD Resource HOB.

Okay. Fair enough. We can avoid a MAP_GPA and cut cost of memory
acceptance.

Here's an updated patch:

From 8b3deddeef639ab7e05d3359dd97ee7994978751 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 25 Aug 2021 21:42:53 +0300
Subject: [PATCHv12.1 9/9] x86/tdx: Add unaccepted memory support

Hookup TDX-specific code to accept memory.

Accepting the memory is done with ACCEPT_PAGE module call on every page
in the range. MAP_GPA hypercall is not required as the unaccepted memory
is considered private already.

Extract the part of tdx_enc_status_changed() that does memory acceptance
in a new helper. Move the helper tdx-shared.c. It is going to be used by
both main kernel and decompressor.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                         |  2 +
 arch/x86/boot/compressed/Makefile        |  2 +-
 arch/x86/boot/compressed/error.c         | 19 +++++++
 arch/x86/boot/compressed/error.h         |  1 +
 arch/x86/boot/compressed/mem.c           | 35 +++++++++++-
 arch/x86/boot/compressed/tdx-shared.c    |  2 +
 arch/x86/coco/tdx/Makefile               |  2 +-
 arch/x86/coco/tdx/tdx-shared.c           | 71 ++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c                  | 70 +----------------------
 arch/x86/include/asm/shared/tdx.h        |  2 +
 arch/x86/include/asm/unaccepted_memory.h | 24 ++++++++
 11 files changed, 160 insertions(+), 70 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdx-shared.c
 create mode 100644 arch/x86/coco/tdx/tdx-shared.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..5c72067c06d4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,9 +884,11 @@ config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
+	depends on EFI_STUB
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
+	select UNACCEPTED_MEMORY
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index cc4978123c30..b13a58021086 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -106,7 +106,7 @@ ifdef CONFIG_X86_64
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
-vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
 vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
diff --git a/arch/x86/boot/compressed/error.c b/arch/x86/boot/compressed/error.c
index c881878e56d3..5313c5cb2b80 100644
--- a/arch/x86/boot/compressed/error.c
+++ b/arch/x86/boot/compressed/error.c
@@ -22,3 +22,22 @@ void error(char *m)
 	while (1)
 		asm("hlt");
 }
+
+/* EFI libstub  provides vsnprintf() */
+#ifdef CONFIG_EFI_STUB
+void panic(const char *fmt, ...)
+{
+	static char buf[1024];
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	if (len && buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+
+	error(buf);
+}
+#endif
diff --git a/arch/x86/boot/compressed/error.h b/arch/x86/boot/compressed/error.h
index 1de5821184f1..86fe33b93715 100644
--- a/arch/x86/boot/compressed/error.h
+++ b/arch/x86/boot/compressed/error.h
@@ -6,5 +6,6 @@
 
 void warn(char *m);
 void error(char *m) __noreturn;
+void panic(const char *fmt, ...) __noreturn __cold;
 
 #endif /* BOOT_COMPRESSED_ERROR_H */
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 4ecf26576a77..d2b6948a7801 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -2,11 +2,44 @@
 
 #include "error.h"
 #include "misc.h"
+#include "tdx.h"
+#include <asm/shared/tdx.h>
+
+/*
+ * accept_memory() and process_unaccepted_memory() called from EFI stub which
+ * runs before decompresser and its early_tdx_detect().
+ *
+ * Enumerate TDX directly from the early users.
+ */
+static bool early_is_tdx_guest(void)
+{
+	static bool once;
+	static bool is_tdx;
+
+	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
+		return false;
+
+	if (!once) {
+		u32 eax, sig[3];
+
+		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
+			    &sig[0], &sig[2],  &sig[1]);
+		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
+		once = true;
+	}
+
+	return is_tdx;
+}
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
-	error("Cannot accept memory");
+	if (early_is_tdx_guest()) {
+		if (tdx_accept_memory(start, end))
+			return;
+	}
+
+	error("Cannot accept memory: unknown platform\n");
 }
 
 void init_unaccepted_memory(void)
diff --git a/arch/x86/boot/compressed/tdx-shared.c b/arch/x86/boot/compressed/tdx-shared.c
new file mode 100644
index 000000000000..5ac43762fe13
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx-shared.c
@@ -0,0 +1,2 @@
+#include "error.h"
+#include "../../coco/tdx/tdx-shared.c"
diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
index 46c55998557d..2c7dcbf1458b 100644
--- a/arch/x86/coco/tdx/Makefile
+++ b/arch/x86/coco/tdx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += tdx.o tdcall.o
+obj-y += tdx.o tdx-shared.o tdcall.o
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
new file mode 100644
index 000000000000..ef20ddc37b58
--- /dev/null
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -0,0 +1,71 @@
+#include <asm/tdx.h>
+#include <asm/pgtable.h>
+
+static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
+				    enum pg_level pg_level)
+{
+	unsigned long accept_size = page_level_size(pg_level);
+	u64 tdcall_rcx;
+	u8 page_size;
+
+	if (!IS_ALIGNED(start, accept_size))
+		return 0;
+
+	if (len < accept_size)
+		return 0;
+
+	/*
+	 * Pass the page physical address to the TDX module to accept the
+	 * pending, private page.
+	 *
+	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
+	 */
+	switch (pg_level) {
+	case PG_LEVEL_4K:
+		page_size = 0;
+		break;
+	case PG_LEVEL_2M:
+		page_size = 1;
+		break;
+	case PG_LEVEL_1G:
+		page_size = 2;
+		break;
+	default:
+		return 0;
+	}
+
+	tdcall_rcx = start | page_size;
+	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
+		return 0;
+
+	return accept_size;
+}
+
+bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/*
+	 * For shared->private conversion, accept the page using
+	 * TDX_ACCEPT_PAGE TDX module call.
+	 */
+	while (start < end) {
+		unsigned long len = end - start;
+		unsigned long accept_size;
+
+		/*
+		 * Try larger accepts first. It gives chance to VMM to keep
+		 * 1G/2M Secure EPT entries where possible and speeds up
+		 * process by cutting number of hypercalls (if successful).
+		 */
+
+		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
+		if (!accept_size)
+			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
+		if (!accept_size)
+			return false;
+		start += accept_size;
+	}
+
+	return true;
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0d5fe6e24e45..a9c4ba6c5c5d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -713,46 +713,6 @@ static bool tdx_cache_flush_required(void)
 	return true;
 }
 
-static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
-				    enum pg_level pg_level)
-{
-	unsigned long accept_size = page_level_size(pg_level);
-	u64 tdcall_rcx;
-	u8 page_size;
-
-	if (!IS_ALIGNED(start, accept_size))
-		return 0;
-
-	if (len < accept_size)
-		return 0;
-
-	/*
-	 * Pass the page physical address to the TDX module to accept the
-	 * pending, private page.
-	 *
-	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
-	 */
-	switch (pg_level) {
-	case PG_LEVEL_4K:
-		page_size = 0;
-		break;
-	case PG_LEVEL_2M:
-		page_size = 1;
-		break;
-	case PG_LEVEL_1G:
-		page_size = 2;
-		break;
-	default:
-		return 0;
-	}
-
-	tdcall_rcx = start | page_size;
-	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
-		return 0;
-
-	return accept_size;
-}
-
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -777,33 +737,9 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
 		return false;
 
-	/* private->shared conversion  requires only MapGPA call */
-	if (!enc)
-		return true;
-
-	/*
-	 * For shared->private conversion, accept the page using
-	 * TDX_ACCEPT_PAGE TDX module call.
-	 */
-	while (start < end) {
-		unsigned long len = end - start;
-		unsigned long accept_size;
-
-		/*
-		 * Try larger accepts first. It gives chance to VMM to keep
-		 * 1G/2M Secure EPT entries where possible and speeds up
-		 * process by cutting number of hypercalls (if successful).
-		 */
-
-		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
-		if (!accept_size)
-			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
-		if (!accept_size)
-			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
-		if (!accept_size)
-			return false;
-		start += accept_size;
-	}
+	/* shared->private conversion requires memory to be accepted before use */
+	if (enc)
+		return tdx_accept_memory(start, end);
 
 	return true;
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 1ff0ee822961..19228beb4894 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -91,5 +91,7 @@ struct tdx_module_output {
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
+bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
new file mode 100644
index 000000000000..f0ab217b566f
--- /dev/null
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -0,0 +1,24 @@
+#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
+#define _ASM_X86_UNACCEPTED_MEMORY_H
+
+#include <linux/efi.h>
+#include <asm/tdx.h>
+
+static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		if (tdx_accept_memory(start, end))
+			return;
+	}
+
+	panic("Cannot accept memory: unknown platform\n");
+}
+
+static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
+{
+	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
+		return NULL;
+	return __va(efi.unaccepted);
+}
+#endif
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
