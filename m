Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A33F720491
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjFBOfp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjFBOfo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 10:35:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D619B;
        Fri,  2 Jun 2023 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685716542; x=1717252542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ulFJ71WOjgzbfiC929YmWPFNrl2PajqvLUVCcU9XxmA=;
  b=Z8Ox5sTwzq3w0EHtr3hg7o7dBsVo8tzBNfNi6YN4I0f6nQNDmkrnzomq
   1rBPcBlK6/PyWA3+ZZg7XensdqDVReexlCT3h/JaiN7epPL71w1iCfQMy
   Cp1uOo9wN2I8BcLD0O467Z4GYmLMmOvJ6BleJqSe/407q+VnK3zucBzb1
   ikB8dGYrMoibLBaEyUa8udFSHvKOGoCshhbzzsXxMA0qBu0EkITI7Ot0C
   c0WnPRWccZbzdG5eI8dOlmxTHDuUuvk0LJBmnZ3GgNOnCYIJcIKoZCHTn
   2QLg4xE7tMKS5GNR8TVNYVzZKKVJ2kU6jfTZF+8vjXTHSekVbfWeI0MwE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="340509247"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="340509247"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="710983956"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="710983956"
Received: from sovanbis-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.229])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:35:34 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 52AF710E1DE; Fri,  2 Jun 2023 17:35:32 +0300 (+03)
Date:   Fri, 2 Jun 2023 17:35:32 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCHv13 9/9] x86/tdx: Add unaccepted memory support
Message-ID: <20230602143532.wiki7tpqzjlydjjv@box.shutemov.name>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-10-kirill.shutemov@linux.intel.com>
 <4d8d6fc4-99b5-29ba-7f81-12e7d57907ea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8d6fc4-99b5-29ba-7f81-12e7d57907ea@amd.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 02, 2023 at 08:22:35AM -0500, Tom Lendacky wrote:
> On 6/1/23 13:25, Kirill A. Shutemov wrote:
> > Hookup TDX-specific code to accept memory.
> > 
> > Accepting the memory is done with ACCEPT_PAGE module call on every page
> > in the range. MAP_GPA hypercall is not required as the unaccepted memory
> > is considered private already.
> > 
> > Extract the part of tdx_enc_status_changed() that does memory acceptance
> > in a new helper. Move the helper tdx-shared.c. It is going to be used by
> > both main kernel and decompressor.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/Kconfig                         |  2 +
> >   arch/x86/boot/compressed/Makefile        |  2 +-
> >   arch/x86/boot/compressed/error.c         | 19 +++++++
> >   arch/x86/boot/compressed/error.h         |  1 +
> >   arch/x86/boot/compressed/mem.c           | 35 +++++++++++-
> >   arch/x86/boot/compressed/tdx-shared.c    |  2 +
> >   arch/x86/coco/tdx/Makefile               |  2 +-
> >   arch/x86/coco/tdx/tdx-shared.c           | 71 ++++++++++++++++++++++++
> >   arch/x86/coco/tdx/tdx.c                  | 70 +----------------------
> >   arch/x86/include/asm/shared/tdx.h        |  2 +
> >   arch/x86/include/asm/unaccepted_memory.h | 24 ++++++++
> >   11 files changed, 160 insertions(+), 70 deletions(-)
> >   create mode 100644 arch/x86/boot/compressed/tdx-shared.c
> >   create mode 100644 arch/x86/coco/tdx/tdx-shared.c
> >   create mode 100644 arch/x86/include/asm/unaccepted_memory.h
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 53bab123a8ee..5c72067c06d4 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -884,9 +884,11 @@ config INTEL_TDX_GUEST
> >   	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
> >   	depends on X86_64 && CPU_SUP_INTEL
> >   	depends on X86_X2APIC
> > +	depends on EFI_STUB
> >   	select ARCH_HAS_CC_PLATFORM
> >   	select X86_MEM_ENCRYPT
> >   	select X86_MCE
> > +	select UNACCEPTED_MEMORY
> >   	help
> >   	  Support running as a guest under Intel TDX.  Without this support,
> >   	  the guest kernel can not boot or run under TDX.
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index cc4978123c30..b13a58021086 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -106,7 +106,7 @@ ifdef CONFIG_X86_64
> >   endif
> >   vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> > -vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> > +vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
> >   vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
> >   vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> > diff --git a/arch/x86/boot/compressed/error.c b/arch/x86/boot/compressed/error.c
> > index c881878e56d3..5313c5cb2b80 100644
> > --- a/arch/x86/boot/compressed/error.c
> > +++ b/arch/x86/boot/compressed/error.c
> > @@ -22,3 +22,22 @@ void error(char *m)
> >   	while (1)
> >   		asm("hlt");
> >   }
> > +
> > +/* EFI libstub  provides vsnprintf() */
> > +#ifdef CONFIG_EFI_STUB
> > +void panic(const char *fmt, ...)
> > +{
> > +	static char buf[1024];
> > +	va_list args;
> > +	int len;
> > +
> > +	va_start(args, fmt);
> > +	len = vsnprintf(buf, sizeof(buf), fmt, args);
> > +	va_end(args);
> > +
> > +	if (len && buf[len - 1] == '\n')
> > +		buf[len - 1] = '\0';
> > +
> > +	error(buf);
> > +}
> > +#endif
> > diff --git a/arch/x86/boot/compressed/error.h b/arch/x86/boot/compressed/error.h
> > index 1de5821184f1..86fe33b93715 100644
> > --- a/arch/x86/boot/compressed/error.h
> > +++ b/arch/x86/boot/compressed/error.h
> > @@ -6,5 +6,6 @@
> >   void warn(char *m);
> >   void error(char *m) __noreturn;
> > +void panic(const char *fmt, ...) __noreturn __cold;
> >   #endif /* BOOT_COMPRESSED_ERROR_H */
> > diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> > index 4ecf26576a77..d2b6948a7801 100644
> > --- a/arch/x86/boot/compressed/mem.c
> > +++ b/arch/x86/boot/compressed/mem.c
> > @@ -2,11 +2,44 @@
> >   #include "error.h"
> >   #include "misc.h"
> > +#include "tdx.h"
> > +#include <asm/shared/tdx.h>
> > +
> > +/*
> > + * accept_memory() and process_unaccepted_memory() called from EFI stub which
> > + * runs before decompresser and its early_tdx_detect().
> > + *
> > + * Enumerate TDX directly from the early users.
> > + */
> > +static bool early_is_tdx_guest(void)
> > +{
> > +	static bool once;
> > +	static bool is_tdx;
> > +
> > +	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
> > +		return false;
> > +
> > +	if (!once) {
> > +		u32 eax, sig[3];
> > +
> > +		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
> > +			    &sig[0], &sig[2],  &sig[1]);
> > +		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
> > +		once = true;
> > +	}
> > +
> > +	return is_tdx;
> > +}
> >   void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> >   {
> >   	/* Platform-specific memory-acceptance call goes here */
> > -	error("Cannot accept memory");
> > +	if (early_is_tdx_guest()) {
> > +		if (tdx_accept_memory(start, end))
> > +			return;
> > +	}
> > +
> > +	error("Cannot accept memory: unknown platform\n");
> 
> So this is a change in this version. If tdx_accept_memory() fails, you'll
> report unknown platform. Wouldn't it be better to have an error message that
> indicates a failure in the accept path?

Urgh.. Didn't read the error message on the rework.

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index d2b6948a7801..a0d24df1004d 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -35,11 +35,11 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest()) {
-		if (tdx_accept_memory(start, end))
-			return;
+		if (!tdx_accept_memory(start, end))
+			panic("TDX: Failed to accept memory\n");
+	} else {
+		error("Cannot accept memory: unknown platform\n");
 	}
-
-	error("Cannot accept memory: unknown platform\n");
 }
 
 void init_unaccepted_memory(void)
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index f0ab217b566f..572514e36fde 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -8,11 +8,11 @@ static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
-		if (tdx_accept_memory(start, end))
-			return;
+		if (!tdx_accept_memory(start, end))
+			panic("TDX: Failed to accept memory\n");
+	} else {
+		panic("Cannot accept memory: unknown platform\n");
 	}
-
-	panic("Cannot accept memory: unknown platform\n");
 }
 
 static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
