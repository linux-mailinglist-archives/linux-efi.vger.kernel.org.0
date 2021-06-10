Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63F3A2FCE
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jun 2021 17:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhFJPwz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Jun 2021 11:52:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47044 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhFJPwz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Jun 2021 11:52:55 -0400
Received: from zn.tnic (p200300ec2f0cf600591105fc6a1dcc4d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:5911:5fc:6a1d:cc4d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C6851EC047D;
        Thu, 10 Jun 2021 17:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623340257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/ucDEPiAjCNgh+5QYV19aaLxDA7Gu7w2xk6M9j+LUNE=;
        b=hw2aXx8BFfNHa4IZlkwBdukgEW8Ik8YFYC6RGLU1bKHqwQ80CVn0B0VEaJxiCjJln46oPK
        fYImG+6j+vFbfPd4bXZgu/g/Jzv1RMvR0bmq9ul0RLWe/yTIRreFOeWAtTyiBzTg2GEPDI
        4imoc5EragOgkErfv4T4zV31vKEHWG8=
Date:   Thu, 10 Jun 2021 17:50:51 +0200
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
Message-ID: <YMI02+k2zk9eazjQ@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-12-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:05AM -0500, Brijesh Singh wrote:
> @@ -65,6 +65,12 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>  /* RMP page size */
>  #define RMP_PG_SIZE_4K			0
>  
> +/* Memory opertion for snp_prep_memory() */
> +enum snp_mem_op {
> +	MEMORY_PRIVATE,
> +	MEMORY_SHARED

See below.

> +};
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern struct static_key_false sev_es_enable_key;
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
> @@ -103,6 +109,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
>  
>  	return rc;
>  }
> +void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
> +		unsigned int npages);
> +void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> +		unsigned int npages);

Align arguments on the opening brace.

> +void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
> @@ -110,6 +121,15 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
>  static inline void sev_es_nmi_complete(void) { }
>  static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
>  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
> +static inline void __init
> +early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages)

Put those { } at the end of the line:

early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }

no need for separate lines. Ditto below.

> +{
> +}
> +static inline void __init
> +early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages)
> +{
> +}
> +static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
>  #endif
>  
>  #endif
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 455c09a9b2c2..6e9b45bb38ab 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -532,6 +532,111 @@ static u64 get_jump_table_addr(void)
>  	return ret;
>  }
>  
> +static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
> +{
> +	unsigned long vaddr_end;
> +	int rc;
> +
> +	vaddr = vaddr & PAGE_MASK;
> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> +
> +	while (vaddr < vaddr_end) {
> +		rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
> +		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
> +			sev_es_terminate(1, GHCB_TERM_PVALIDATE);
					^^

I guess that 1 should be a define too, if we have to be correct:

			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);

or so. Ditto for all other calls of this.

> +
> +		vaddr = vaddr + PAGE_SIZE;
> +	}
> +}
> +
> +static void __init early_set_page_state(unsigned long paddr, unsigned int npages, int op)
> +{
> +	unsigned long paddr_end;
> +	u64 val;
> +
> +	paddr = paddr & PAGE_MASK;
> +	paddr_end = paddr + (npages << PAGE_SHIFT);
> +
> +	while (paddr < paddr_end) {
> +		/*
> +		 * Use the MSR protocol because this function can be called before the GHCB
> +		 * is established.
> +		 */
> +		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
> +		VMGEXIT();
> +
> +		val = sev_es_rd_ghcb_msr();
> +
> +		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)

From a previous review:

Does that one need a warning too or am I being too paranoid?

> +			goto e_term;
> +
> +		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
> +			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
> +			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
> +			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
> +			goto e_term;
> +
> +		paddr = paddr + PAGE_SIZE;
> +	}
> +
> +	return;
> +
> +e_term:
> +	sev_es_terminate(1, GHCB_TERM_PSC);
> +}
> +
> +void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
> +					 unsigned int npages)
> +{
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return;
> +
> +	 /* Ask hypervisor to add the memory pages in RMP table as a 'private'. */

	    Ask the hypervisor to mark the memory pages as private in the RMP table.

> +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
> +
> +	/* Validate the memory pages after they've been added in the RMP table. */
> +	pvalidate_pages(vaddr, npages, 1);
> +}
> +
> +void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> +					unsigned int npages)
> +{
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return;
> +
> +	/*
> +	 * Invalidate the memory pages before they are marked shared in the
> +	 * RMP table.
> +	 */
> +	pvalidate_pages(vaddr, npages, 0);
> +
> +	 /* Ask hypervisor to make the memory pages shared in the RMP table. */

			      mark

> +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_SHARED);
> +}
> +
> +void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
> +{
> +	unsigned long vaddr, npages;
> +
> +	vaddr = (unsigned long)__va(paddr);
> +	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +
> +	switch (op) {
> +	case MEMORY_PRIVATE: {
> +		early_snp_set_memory_private(vaddr, paddr, npages);
> +		return;
> +	}
> +	case MEMORY_SHARED: {
> +		early_snp_set_memory_shared(vaddr, paddr, npages);
> +		return;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	WARN(1, "invalid memory op %d\n", op);

A lot easier, diff ontop of your patch:

---
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7c2cb5300e43..2ad4b5ab3f6c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -65,12 +65,6 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 
-/* Memory opertion for snp_prep_memory() */
-enum snp_mem_op {
-	MEMORY_PRIVATE,
-	MEMORY_SHARED
-};
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2a5dce42af35..991d7964cee9 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -662,20 +662,13 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
 	vaddr = (unsigned long)__va(paddr);
 	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
 
-	switch (op) {
-	case MEMORY_PRIVATE: {
+	if (op == SNP_PAGE_STATE_PRIVATE)
 		early_snp_set_memory_private(vaddr, paddr, npages);
-		return;
-	}
-	case MEMORY_SHARED: {
+	else if (op == SNP_PAGE_STATE_SHARED)
 		early_snp_set_memory_shared(vaddr, paddr, npages);
-		return;
+	else {
+		WARN(1, "invalid memory page op %d\n", op);
 	}
-	default:
-		break;
-	}
-
-	WARN(1, "invalid memory op %d\n", op);
 }
 
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
---

>  static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
>  
> +/*
> + * When SNP is active, changes the page state from private to shared before

s/changes/change/

> + * copying the data from the source to destination and restore after the copy.
> + * This is required because the source address is mapped as decrypted by the
> + * caller of the routine.
> + */
> +static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
> +				     unsigned long paddr, bool decrypt)
> +{
> +	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +
> +	if (!sev_feature_enabled(SEV_SNP) || !decrypt) {
> +		memcpy(dst, src, sz);
> +		return;
> +	}
> +
> +	/*
> +	 * If the paddr needs to be accessed decrypted, mark the page

What do you mean "If" - this is the SNP version of memcpy. Just say:

	/*
	 * With SNP, the page address needs to be ...
	 */

> +	 * shared in the RMP table before copying it.
> +	 */
> +	early_snp_set_memory_shared((unsigned long)__va(paddr), paddr, npages);
> +
> +	memcpy(dst, src, sz);
> +
> +	/* Restore the page state after the memcpy. */
> +	early_snp_set_memory_private((unsigned long)__va(paddr), paddr, npages);
> +}
> +
>  /*
>   * This routine does not change the underlying encryption setting of the
>   * page(s) that map this memory. It assumes that eventually the memory is
> @@ -96,8 +125,8 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
>  		 * Use a temporary buffer, of cache-line multiple size, to
>  		 * avoid data corruption as documented in the APM.
>  		 */
> -		memcpy(sme_early_buffer, src, len);
> -		memcpy(dst, sme_early_buffer, len);
> +		snp_memcpy(sme_early_buffer, src, len, paddr, enc);
> +		snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
>  
>  		early_memunmap(dst, len);
>  		early_memunmap(src, len);
> @@ -277,9 +306,23 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
>  	else
>  		sme_early_decrypt(pa, size);
>  
> +	/*
> +	 * If page is getting mapped decrypted in the page table, then the page state
> +	 * change in the RMP table must happen before the page table updates.
> +	 */
> +	if (!enc)
> +		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);

Merge the two branches:

	/* Encrypt/decrypt the contents in-place */
        if (enc) {
                sme_early_encrypt(pa, size);
        } else {
                sme_early_decrypt(pa, size);

                /*
                 * On SNP, the page state change in the RMP table must happen
                 * before the page table updates.
                 */
                early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
        }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
