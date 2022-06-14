Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AFA54BAF7
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiFNTwk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 15:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349374AbiFNTwg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 15:52:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740927FDA
        for <linux-efi@vger.kernel.org>; Tue, 14 Jun 2022 12:52:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o17so8612928pla.6
        for <linux-efi@vger.kernel.org>; Tue, 14 Jun 2022 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jsh+9nIpfSBa1uEbPDqPUdbNg1GFShpfTtOI9ZfqinA=;
        b=eLG14A21pvHg32PiwjkaP+dh9Qho4ANeFBz02faR0OsqBnkDDbTweNJx25wqnfQzwT
         LZajfdHpDqoWVoTqlS5amqN02i/CTNrfUTFQxdPrK0wLT0hHu+P2l3WdL7or8ftHI9Zj
         XI6Sb0fyqhajsZSEvctk10YiHR/27iHNnn/m7fJGCWnpiNwaU0p3zQ+N2If5En6CbSTZ
         TeARvQ+PHUGw6gNxjtkgCDbMTLgsykaaVNPB7nHEVrJpbGorTL+E+nAzD0nESw9Ctc4T
         OUGprmoaRamJ5Mbt8Vl7O0v085JO+MNslMMSYl2Ztf9NtnQUjrdbPuMBixF4qeoNNkDU
         KwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jsh+9nIpfSBa1uEbPDqPUdbNg1GFShpfTtOI9ZfqinA=;
        b=69y5N09rarZxbzq6CE5HKhC419WPBpcLO1wNHkoq0kQdDd/8LjJu9XhYRbg+L2lud/
         OFxvfNyBpkdxGBoKzdiPh9Kl0+kp4fXO6fiauEKnBvOyAUiki0YqzXdh9pdCc1gGbgsP
         Ac/0H30wVyTx4PzyE9Qc12wBlZD6u2N0Rm9r1S7Akt4ysVo9iLplchCx/2vn0NNEFKPG
         qf/ZCovap4v5qP8PqZ0W0pHe69vApDxleJ481MssX+bzD5KAqBEaKM1ue5jLqI2ojifq
         wczc7bTGAtUAn7o2AVquaAY4Qdy/8u89wAKsAQ7ZnKb2tl02baD8mjJmxALXTDl2+dbv
         gnmQ==
X-Gm-Message-State: AJIora98oF5NLBpdJ2yGkSHAM889jq6kpeh4Mw7u3yvhVJ/+4FvAiqTe
        AgcCCdh/1+lRPErlwpYG0QxEZA==
X-Google-Smtp-Source: AGRyM1vv7m0b7E/234X9osMyE0Ar/aQSj9TrfEOaTO6q4JlGEpk2zdpwTjkcgfSkZj0JFdWamW6DWA==
X-Received: by 2002:a17:90b:1b0d:b0:1e6:847e:6448 with SMTP id nu13-20020a17090b1b0d00b001e6847e6448mr6122283pjb.125.1655236353306;
        Tue, 14 Jun 2022 12:52:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7958b000000b0051bdb735647sm8046474pfj.159.2022.06.14.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:52:32 -0700 (PDT)
Date:   Tue, 14 Jun 2022 19:52:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Michael Roth <michael.roth@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Message-ID: <Yqjm/b3deMlxxePh@google.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-20-brijesh.singh@amd.com>
 <YqfabnTRxFSM+LoX@google.com>
 <YqistMvngNKEJu2o@google.com>
 <daaf7a84-4204-48ca-e40c-7ba296b4789c@amd.com>
 <YqizrTCk460kov/X@google.com>
 <6db51d45-e17a-38dd-131d-e43132c55dfb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db51d45-e17a-38dd-131d-e43132c55dfb@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022, Tom Lendacky wrote:
> On 6/14/22 11:13, Sean Christopherson wrote:
> > > > > This breaks SME on Rome and Milan when compiling with clang-13.  I haven't been
> > > > > able to figure out exactly what goes wrong.  printk isn't functional at this point,
> > > > > and interactive debug during boot on our test systems is beyond me.  I can't even
> > > > > verify that the bug is specific to clang because the draconian build system for our
> > > > > test systems apparently is stuck pointing at gcc-4.9.
> > > > > 
> > > > > I suspect the issue is related to relocation and/or encrypting memory, as skipping
> > > > > the call to early_snp_set_memory_shared() if SNP isn't active masks the issue.
> > > > > I've dug through the assembly and haven't spotted a smoking gun, e.g. no obvious
> > > > > use of absolute addresses.
> > > > > 
> > > > > Forcing a VM through the same path doesn't fail.  I can't test an SEV guest at the
> > > > > moment because INIT_EX is also broken.
> > > > 
> > > > The SEV INIT_EX was a PEBKAC issue.  An SEV guest boots just fine with a clang-built
> > > > kernel, so either it's a finnicky relocation issue or something specific to SME.
> > > 
> > > I just built and booted 5.19-rc2 with clang-13 and SME enabled without issue:
> > > 
> > > [    4.118226] Memory Encryption Features active: AMD SME
> > 
> > Phooey.
> > 
> > > Maybe something with your kernel config? Can you send me your config?
> > 
> > Attached.  If you can't repro, I'll find someone on our end to work on this.
> 
> I was able to repro. It dies in the cc_platform_has() code, where it is
> trying to do an indirect jump based on the attribute (actually in the
> amd_cc_platform_has() which I think has been optimized in):
> 
> bool cc_platform_has(enum cc_attr attr)

...

> ffffffff81002160:       ff 24 c5 c0 01 00 82    jmp    *-0x7dfffe40(,%rax,8)
> 
> This last line is what causes the reset. I'm guessing that the jump isn't
> valid at this point because we are running in identity mapped mode and not
> with a kernel virtual address at this point.
> 
> Trying to see what the difference was between your config and mine, the
> indirect jump lead me to check the setting of CONFIG_RETPOLINE. Your config
> did not have it enabled, so I set CONFIG_RETPOLINE=y, and with that, the
> kernel boots successfully.

That would explain why my VMs didn't fail, I build those kernels with CONFIG_RETPOLINE=y.

> With retpolines, the code is completely different around here:

...

> I'm not sure if there's a way to remove the jump table optimization for
> the arch/x86/coco/core.c file when retpolines aren't configured.

And for post-boot I don't think we'd want to disable any such optimizations.

A possibled "fix" would be to do what sme_encrypt_kernel() does and just query
sev_status directly.  But even that works, the fragility of the boot code is
terrifying :-(  I can't think of any clever solutions though.

Many thanks again Tom!

---
 arch/x86/include/asm/sev.h |  4 ++++
 arch/x86/kernel/head64.c   | 10 +++++++---
 arch/x86/kernel/sev.c      | 16 +++++++++++-----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 19514524f0f8..701c561fdf08 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -193,6 +193,8 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 void setup_ghcb(void);
 void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned int npages);
+void __init __early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					  unsigned int npages);
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned int npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
@@ -214,6 +216,8 @@ static inline void setup_ghcb(void) { }
 static inline void __init
 early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
 static inline void __init
+__early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index bd4a34100ed0..5efab0d8e49d 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -127,7 +127,9 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif

-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+						    pmdval_t *pmd,
+						    unsigned long physaddr)
 {
 	unsigned long vaddr, vaddr_end;
 	int i;
@@ -156,7 +158,9 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 			 * address but the kernel is currently running off of the identity
 			 * mapping so use __pa() to get a *currently* valid virtual address.
 			 */
-			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+			if (sev_status & MSR_AMD64_SEV_SNP_ENABLED_BIT)
+				__early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr),
+							      PTRS_PER_PMD);

 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
@@ -316,7 +320,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();

-	return sme_postprocess_startup(bp, pmd);
+	return sme_postprocess_startup(bp, pmd, physaddr);
 }

 /* Wipe all early page tables except for the kernel symbol map */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f0124c410..48966ecc520e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -714,12 +714,9 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	pvalidate_pages(vaddr, npages, true);
 }

-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned int npages)
+void __init __early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					  unsigned int npages)
 {
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return;
-
 	/* Invalidate the memory pages before they are marked shared in the RMP table. */
 	pvalidate_pages(vaddr, npages, false);

@@ -727,6 +724,15 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
 }

+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned int npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	__early_snp_set_memory_shared(vaddr, paddr, npages);
+}
+
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
 {
 	unsigned long vaddr, npages;

base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
--

