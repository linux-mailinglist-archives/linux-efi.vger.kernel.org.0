Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1F3EBB11
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhHMRJt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 13:09:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33428 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhHMRJs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Aug 2021 13:09:48 -0400
Received: from zn.tnic (p200300ec2f0a0d00fd43514a4e38f781.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:fd43:514a:4e38:f781])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4622D1EC0502;
        Fri, 13 Aug 2021 19:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628874551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OYDR+bOlD9MQDx8acVKVsEbxOBwDuCkmZLbEzyaj+Rs=;
        b=AOLEJqQyVT9avPMKrehwNg2854F7QmISBDwpu37rsCOUEDPNyxTi2bE0MsVpYw9uZa7DBF
        zWQntqK0GpobQ9qnhEivbl5Gr/FUv22Q3WasTXn6VgIvU6yDId2fwJkmxaqQxx3vPULrVJ
        bYEW/1RBqALROSM3XU1THRatcNZZJ90=
Date:   Fri, 13 Aug 2021 19:09:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 13/36] x86/kernel: Make the bss.decrypted
 section shared in RMP table
Message-ID: <YRanXmUZCCLjNqDy@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-14-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:43PM -0500, Brijesh Singh wrote:
> The encryption attribute for the bss.decrypted region is cleared in the
> initial page table build. This is because the section contains the data
> that need to be shared between the guest and the hypervisor.
> 
> When SEV-SNP is active, just clearing the encryption attribute in the
> page table is not enough. The page state need to be updated in the RMP
> table.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/head64.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Please apply this cleanup before this one.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/head64: Carve out the guest encryption postprocessing into a helper

Carve it out so that it is abstracted out of the main boot path. All
other encrypted guest-relevant processing should be placed in there.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/head64.c | 55 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..eee24b427237 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -126,6 +126,36 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+{
+	unsigned long vaddr, vaddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
 /* Code in __startup_64() can be relocated during execution, but the compiler
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
@@ -135,7 +165,6 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -276,29 +305,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
 
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 */
-	if (mem_encrypt_active()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
-			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
+	return sme_postprocess_startup(bp, pmd);
 }
 
 unsigned long __startup_secondary_64(void)
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
