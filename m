Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563AC49B55C
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 14:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbiAYNvN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 08:51:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32900 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577805AbiAYNtD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Jan 2022 08:49:03 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 376201EC01B7;
        Tue, 25 Jan 2022 14:48:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643118536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JQN8XD6k6puvlSUuf8A5aQx4ew310N7RwtnuTiZnHb8=;
        b=EBAYLLI8ZKdEmazAnudhSelafx11VzBXAhRuc9nYJyQhp2LpsI0UmGGAOdRz66aFffbETc
        hCkJcMLrjFST9eUShtGEQdgddvtR0BF2inaRz6BebGta3+5aTH7+CKm3Dp4uIM8Y6HCT4A
        SbwvPtfNj63BrzWM1xMA1pzgCEGYiwE=
Date:   Tue, 25 Jan 2022 14:48:51 +0100
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
Subject: Re: [PATCH v8 33/40] x86/compressed/64: add identity mapping for
 Confidential Computing blob
Message-ID: <Ye//w6Qm4P6HX870@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-34-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-34-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:43:25AM -0600, Brijesh Singh wrote:
> +static void sev_prep_identity_maps(void)
> +{
> +	/*
> +	 * The ConfidentialComputing blob is used very early in uncompressed
> +	 * kernel to find the in-memory cpuid table to handle cpuid
> +	 * instructions. Make sure an identity-mapping exists so it can be
> +	 * accessed after switchover.
> +	 */
> +	if (sev_snp_enabled()) {
> +		struct cc_blob_sev_info *cc_info =
> +			(void *)(unsigned long)boot_params->cc_blob_address;
> +
> +		add_identity_map((unsigned long)cc_info,
> +				 (unsigned long)cc_info + sizeof(*cc_info));
> +		add_identity_map((unsigned long)cc_info->cpuid_phys,
> +				 (unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
> +	}
> +
> +	sev_verify_cbit(top_level_pgt);
> +}
> +

Also, that function can just as well live in compressed/sev.c and
you can export add_identity_map() instead.

That latter function calls kernel_ident_mapping_init() which is
already exported. add_identity_map() doesn't do anything special
and it is limited to the decompressor kernel so nothing stands in
the way of exporting it in a pre-patch and renaming it there to
kernel_add_identity_map() or so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
