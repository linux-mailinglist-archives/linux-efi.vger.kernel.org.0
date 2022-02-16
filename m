Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0834B8A21
	for <lists+linux-efi@lfdr.de>; Wed, 16 Feb 2022 14:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiBPNcu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Feb 2022 08:32:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiBPNcu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Feb 2022 08:32:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F13F1D;
        Wed, 16 Feb 2022 05:32:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0CDE1EC050F;
        Wed, 16 Feb 2022 14:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645018352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JN8ROYzRXXLe/Rb2ENS9kb3VYdbDLeypkZRBnD2gAtc=;
        b=K8M/99Amrj/s+w/DF9qiSpgHOY86lkghNmuYmi4X9PE+w/EmXNako513oa/ie6xcxJOkIl
        747EnG7ncpAKd+kCoi4B+JSS4BIfWxy/oj1SPKII08u3VOCs2ZUQTQfnqj2dDKRwWfWYxw
        fnzO+V0heq0JVG/T+iH6Gdh0XlaX+mQ=
Date:   Wed, 16 Feb 2022 14:32:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <Ygz88uacbwuTTNat@zn.tnic>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
 <YgZ427v95xcdOKSC@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgZ427v95xcdOKSC@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 11, 2022 at 03:55:23PM +0100, Borislav Petkov wrote:
> Also, I think adding required functions to x86_platform.guest. is a very
> nice way to solve the ugly if (guest_type) querying all over the place.

So I guess something like below. It builds here...

---
 arch/x86/include/asm/set_memory.h |  1 -
 arch/x86/include/asm/sev.h        |  2 ++
 arch/x86/include/asm/x86_init.h   | 12 ++++++++++++
 arch/x86/kernel/sev.c             |  2 ++
 arch/x86/mm/mem_encrypt_amd.c     |  6 +++---
 arch/x86/mm/pat/set_memory.c      |  2 +-
 6 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d90338a..ce8dd215f5b3 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -84,7 +84,6 @@ int set_pages_rw(struct page *page, int numpages);
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 
 extern int kernel_set_to_readonly;
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ec060c433589..2435b0ca6cfc 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -95,4 +95,6 @@ static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 #endif
 
+void amd_notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
+
 #endif
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 22b7412c08f6..226663e2d769 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -141,6 +141,17 @@ struct x86_init_acpi {
 	void (*reduced_hw_early_init)(void);
 };
 
+/**
+ * struct x86_guest - Functions used by misc guest incarnations like SEV, TDX,
+ * etc.
+ *
+ * @enc_status_change		Notify HV about change of encryption status of a
+ *				range of pages
+ */
+struct x86_guest {
+	void (*enc_status_change)(unsigned long vaddr, int npages, bool enc);
+};
+
 /**
  * struct x86_init_ops - functions for platform specific setup
  *
@@ -287,6 +298,7 @@ struct x86_platform_ops {
 	struct x86_legacy_features legacy;
 	void (*set_legacy_features)(void);
 	struct x86_hyper_runtime hyper;
+	struct x86_guest guest;
 };
 
 struct x86_apic_ops {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e6d316a01fdd..e645e868a49b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -766,6 +766,8 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_check_cpu_features())
 		panic("SEV-ES CPU Features missing");
 
+	x86_platform.guest.enc_status_change = amd_notify_range_enc_status_changed;
+
 	/* Enable SEV-ES special handling */
 	static_branch_enable(&sev_es_enable_key);
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2b2d018ea345..7038a9f7ae55 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -256,7 +256,7 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 	return pfn;
 }
 
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
+void amd_notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 {
 #ifdef CONFIG_PARAVIRT
 	unsigned long sz = npages << PAGE_SHIFT;
@@ -392,7 +392,7 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 
 	ret = 0;
 
-	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+	amd_notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
 out:
 	__flush_tlb_all();
 	return ret;
@@ -410,7 +410,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 
 void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 {
-	notify_range_enc_status_changed(vaddr, npages, enc);
+	amd_notify_range_enc_status_changed(vaddr, npages, enc);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..0acc52a3a5b7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2027,7 +2027,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 * Notify hypervisor that a given memory range is mapped encrypted
 	 * or decrypted.
 	 */
-	notify_range_enc_status_changed(addr, numpages, enc);
+	x86_platform.guest.enc_status_change(addr, numpages, enc);
 
 	return ret;
 }
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
