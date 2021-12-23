Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32E47E29A
	for <lists+linux-efi@lfdr.de>; Thu, 23 Dec 2021 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhLWLu2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Dec 2021 06:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbhLWLu1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Dec 2021 06:50:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA9C061756;
        Thu, 23 Dec 2021 03:50:26 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09C2A1EC054E;
        Thu, 23 Dec 2021 12:50:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640260221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cuJ+soGkmwGVdG30YPS/F1N7S/DbyJYTLWnol8x+5u4=;
        b=Rsvnfq2qxXXOgXEVluwWck3R4Eyw+KHKRdwmXra1wDyjKVwD1FsCFugMErEl59E6zC09t+
        7CnZ2kUaKkSUR4FmgVCit4Y+JvrquvY0CLpilS0y9xMwmq1YCHGFBnupRwRbzYYqxst3b+
        O8/fud/q7zcxWW+af8iQXU/ftTyZoOs=
Date:   Thu, 23 Dec 2021 12:50:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 12/40] x86/sev: Add helper for validating pages in
 early enc attribute changes
Message-ID: <YcRifo82cGk+wP+a@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-13-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-13-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:04AM -0600, Brijesh Singh wrote:
> The early_set_memory_{encrypt,decrypt}() are used for changing the
					^
					ed()


> page from decrypted (shared) to encrypted (private) and vice versa.
> When SEV-SNP is active, the page state transition needs to go through
> additional steps.
> 
> If the page is transitioned from shared to private, then perform the
> following after the encryption attribute is set in the page table:
> 
> 1. Issue the page state change VMGEXIT to add the page as a private
>    in the RMP table.
> 2. Validate the page after its successfully added in the RMP table.
> 
> To maintain the security guarantees, if the page is transitioned from
> private to shared, then perform the following before clearing the
> encryption attribute from the page table.
> 
> 1. Invalidate the page.
> 2. Issue the page state change VMGEXIT to make the page shared in the
>    RMP table.
> 
> The early_set_memory_{encrypt,decrypt} can be called before the GHCB

ditto.

> is setup, use the SNP page state MSR protocol VMGEXIT defined in the GHCB
> specification to request the page state change in the RMP table.
> 
> While at it, add a helper snp_prep_memory() that can be used outside
> the sev specific files to change the page state for a specified memory

"outside of the sev specific"? What is that trying to say?

/me goes and looks at the whole patchset...

Right, so that is used only in probe_roms(). So that should say:

"Add a helper ... which will be used in probe_roms(), in a later patch."

> range.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev.h |  10 ++++
>  arch/x86/kernel/sev.c      | 102 +++++++++++++++++++++++++++++++++++++
>  arch/x86/mm/mem_encrypt.c  |  51 +++++++++++++++++--

Right, for the next revision, that file is called mem_encrypt_amd.c now.

...

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 3ba801ff6afc..5d19aad06670 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -31,6 +31,7 @@
>  #include <asm/processor-flags.h>
>  #include <asm/msr.h>
>  #include <asm/cmdline.h>
> +#include <asm/sev.h>
>  
>  #include "mm_internal.h"
>  
> @@ -49,6 +50,34 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
>  /* Buffer used for early in-place encryption by BSP, no locking needed */
>  static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
>  
> +/*
> + * When SNP is active, change the page state from private to shared before
> + * copying the data from the source to destination and restore after the copy.
> + * This is required because the source address is mapped as decrypted by the
> + * caller of the routine.
> + */
> +static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
> +				     unsigned long paddr, bool decrypt)
> +{
> +	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +
> +	if (!cc_platform_has(CC_ATTR_SEV_SNP) || !decrypt) {

Yeah, looking at this again, I don't really like this multiplexing.
Let's do this instead, diff ontop:

---
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index c14fd8254198..e3f7a84449bb 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -49,24 +49,18 @@ EXPORT_SYMBOL(sme_me_mask);
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
 /*
- * When SNP is active, change the page state from private to shared before
- * copying the data from the source to destination and restore after the copy.
- * This is required because the source address is mapped as decrypted by the
- * caller of the routine.
+ * SNP-specific routine which needs to additionally change the page state from
+ * private to shared before copying the data from the source to destination and
+ * restore after the copy.
  */
 static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
 				     unsigned long paddr, bool decrypt)
 {
 	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
 
-	if (!cc_platform_has(CC_ATTR_SEV_SNP) || !decrypt) {
-		memcpy(dst, src, sz);
-		return;
-	}
-
 	/*
-	 * With SNP, the paddr needs to be accessed decrypted, mark the page
-	 * shared in the RMP table before copying it.
+	 * @paddr needs to be accessed decrypted, mark the page shared in the
+	 * RMP table before copying it.
 	 */
 	early_snp_set_memory_shared((unsigned long)__va(paddr), paddr, npages);
 
@@ -124,8 +118,13 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
 		 * Use a temporary buffer, of cache-line multiple size, to
 		 * avoid data corruption as documented in the APM.
 		 */
-		snp_memcpy(sme_early_buffer, src, len, paddr, enc);
-		snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
+		if (cc_platform_has(CC_ATTR_SEV_SNP)) {
+			snp_memcpy(sme_early_buffer, src, len, paddr, enc);
+			snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
+		} else {
+			memcpy(sme_early_buffer, src, len);
+			memcpy(dst, sme_early_buffer, len);
+		}
 
 		early_memunmap(dst, len);
 		early_memunmap(src, len);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
