Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343624927EF
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 15:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbiAROCx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 09:02:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243400AbiAROCw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 09:02:52 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA99D1EC0441;
        Tue, 18 Jan 2022 15:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642514566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4JA023Sy7F48GbJHjrrwIoXYzwKYqGQtCBAMqfyQANo=;
        b=QVgvfx98+X2IoAfXGC2QEREdXtSvoWS83vhZnsrxrNqdtbkWGX89kMM+eosJlcDhEsUXdI
        ovazPq/TSnRzTvdcDj+JT/tDuSwcPDIefvr7iyfUHTVM1Q3uisxxkT09LrHgwbVK5RuAnd
        BCpcpQC1lExp3P6caPQtNf+qU5CDYMU=
Date:   Tue, 18 Jan 2022 15:02:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 29/40] x86/compressed/64: add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <YebIiN6Ftq2aPtyF@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118043521.exgma53qrzrbalpd@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 17, 2022 at 10:35:21PM -0600, Michael Roth wrote:
> Unfortunately, in sev_enable(), between the point where snp_init() is
> called, and sev_status is actually set, there are a number of cpuid
> intructions which will make use of do_vc_no_ghcb() prior to sev_status
> being set (and it needs to happen in that order to set sev_status
> appropriately). After that point, snp_cpuid_active() would no longer be
> necessary, but during that span some indicator is needed in case this
> is just an SEV-ES guest trigger cpuid #VCs.

You mean testing what snp_cpuid_info_create() set up is not enough?

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 7bc7e297f88c..17cfe804bad3 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -523,7 +523,9 @@ static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
 		     u32 *edx)
 {
-	if (!snp_cpuid_active())
+	const struct snp_cpuid_info *c = snp_cpuid_info_get_ptr();
+
+	if (!c->count)
 		return -EOPNOTSUPP;
 
 	if (!snp_cpuid_find_validated_func(func, subfunc, eax, ebx, ecx, edx)) {

---

Btw, all those

        /* SEV-SNP CPUID table should be set up now. */
        if (!snp_cpuid_active())
                sev_es_terminate(1, GHCB_TERM_CPUID);

after snp_cpuid_info_create() has returned are useless either. If that
function returns, you know you're good to go wrt SNP.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
