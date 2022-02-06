Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D5B4AB19E
	for <lists+linux-efi@lfdr.de>; Sun,  6 Feb 2022 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiBFTVQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Feb 2022 14:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiBFTVP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Feb 2022 14:21:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548EC06173B;
        Sun,  6 Feb 2022 11:21:12 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98F631EC0441;
        Sun,  6 Feb 2022 20:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644175266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qZ+JC0pRfH6lWrzUrFpqkRDFcjI46nKdneyEJN06nQk=;
        b=ow+htihMgw4Pxti4RYLXi7ZysyRUArvgHjhpsNxhff27JMNO7FScwt2OQO9fzKzRUJgWyp
        a9pywRwMPeVHB+ZsGjFJ7ZKvh86sn2s5riv1j+ZZQXvSxDz6cXpBOFY/xpIV01KjbfMZId
        U4VUF69EB5x5H4KIHMBT1WoxuL/t7FM=
Date:   Sun, 6 Feb 2022 20:21:00 +0100
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
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 36/43] x86/compressed/64: Add identity mapping for
 Confidential Computing blob
Message-ID: <YgAfnGTiwtu2Fako@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-37-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-37-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:57AM -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> The run-time kernel will need to access the Confidential Computing
> blob very early in boot to access the CPUID table it points to. At
> that stage of boot it will be relying on the identity-mapped page table
> set up by boot/compressed kernel, so make sure the blob and the CPUID
> table it points to are mapped in advance.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/ident_map_64.c |  3 ++-
>  arch/x86/boot/compressed/misc.h         |  2 ++
>  arch/x86/boot/compressed/sev.c          | 22 ++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)

Do this ontop:

---
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index faf432684870..a5a9210d73b6 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -500,7 +500,7 @@ bool snp_init(struct boot_params *bp)
 void sev_prep_identity_maps(unsigned long top_level_pgt)
 {
 	/*
-	 * The ConfidentialComputing blob is used very early in uncompressed
+	 * The Confidential Computing blob is used very early in uncompressed
 	 * kernel to find the in-memory cpuid table to handle cpuid
 	 * instructions. Make sure an identity-mapping exists so it can be
 	 * accessed after switchover.
@@ -509,11 +509,10 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 		unsigned long cc_info_pa = boot_params->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
-		kernel_add_identity_map(cc_info_pa,
-					cc_info_pa + sizeof(*cc_info));
+		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
+
 		cc_info = (struct cc_blob_sev_info *)cc_info_pa;
-		kernel_add_identity_map((unsigned long)cc_info->cpuid_phys,
-					(unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
+		kernel_add_identity_map(cc_info->cpuid_phys, cc_info->cpuid_phys + cc_info->cpuid_len);
 	}
 
 	sev_verify_cbit(top_level_pgt);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
