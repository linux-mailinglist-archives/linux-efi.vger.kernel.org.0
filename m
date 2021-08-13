Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383253EB46E
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhHMLNF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 07:13:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240262AbhHMLNE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Aug 2021 07:13:04 -0400
Received: from zn.tnic (p200300ec2f0a0d0079874d21390dee82.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:7987:4d21:390d:ee82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CD731EC0354;
        Fri, 13 Aug 2021 13:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628853152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WPW5sSZjUxZ3x8JTAj91aHnNyirgFEzr1J7d0XBG/HA=;
        b=P2ABTh4lPaXRaUU+RtlYZTkMizbxNKmwMIwxtCmMEan0F0wJtyuBhj1mLNFzeSCag+f5va
        /hKeBFX1vqOUbEHFnpNyZ1XO3hPc56tZM0Gd2Vt2gvfnUx9/RSgF3d4B6CeAZB4Sk50o1T
        XctMGGA8nfKk6rRyiZhqhk6A5CS1hOI=
Date:   Fri, 13 Aug 2021 13:13:11 +0200
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
Subject: Re: [PATCH Part1 RFC v4 12/36] x86/sev: Add helper for validating
 pages in early enc attribute changes
Message-ID: <YRZTx8agX75mwyxP@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-13-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707181506.30489-13-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:14:42PM -0500, Brijesh Singh wrote:
> +void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
> +					 unsigned int npages)
> +{
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return;
> +
> +	 /* Ask hypervisor to add the memory pages in RMP table as a 'private'. */

From a previous review:

	Ask the hypervisor to mark the memory pages as private in the RMP table.

Are you missing my comments, do I have to write them more prominently or
what is the problem?

DO I NEED TO WRITE IN CAPS ONLY MAYBE?

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

From a previous review:

s/make/mark/

> +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_SHARED);
> +}
> +
> +void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)

that op should be:

enum psc_op {
        SNP_PAGE_STATE_SHARED,
        SNP_PAGE_STATE_PRIVATE,
};

too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
