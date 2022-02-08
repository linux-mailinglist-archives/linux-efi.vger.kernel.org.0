Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2F4ADBE7
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbiBHPCQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 10:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350967AbiBHPCP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 10:02:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B2C061576;
        Tue,  8 Feb 2022 07:02:13 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE2981EC053F;
        Tue,  8 Feb 2022 16:02:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644332528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PmHLjCv8QPKB/e0+L9sQuWzLs6/HCLu3AQwtoLxemqY=;
        b=cJ+v1YVsVB5ysTBNNKVmP99U334P0+41QjVaIkHm37ZZu0pzwjEgVIAgukztHCJgE2F/PO
        hQoUIH1TReaIabKCaPXeoP8tiEZpWM2lFT8soN7USRwTa8yQgE+fdaVrHtV/SUlbm6aVVm
        K9pkhVbpBPWSCiDhwDpLe4oaZ7nng1U=
Date:   Tue, 8 Feb 2022 16:02:02 +0100
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
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 33/43] x86/compressed: Add SEV-SNP feature
 detection/setup
Message-ID: <YgKF6kzR87WuXj/a@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-34-brijesh.singh@amd.com>
 <Yf/6NhnS50UDv4xV@zn.tnic>
 <20220208135009.7rfrau33kxivx5h3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220208135009.7rfrau33kxivx5h3@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 08, 2022 at 07:50:09AM -0600, Michael Roth wrote:
> I'm assuming that would be considered 'non-static' since it would need
> to be exported if sev-shared.c was compiled separately instead of
> directly #include'd.

No, that one can lose the prefix too. We'll cross that bridge when we
get to it.

> And then there's also these which are static helpers that are only used
> within sev-shared.c:
> 
>   snp_cpuid_info_get_ptr()

So looking at that one - and it felt weird reading that code because it
said "cpuid_info" but that's not an "info" - that should be:

struct snp_cpuid_table {
        u32 count;
        u32 __reserved1;
        u64 __reserved2;
        struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
} __packed;

just call it what it is - a SNP CPUID *table*.

And then you can have

	const struct snp_cpuid_table *cpuid_tbl = snp_cpuid_get_table();

and that makes it crystal clear what this does.

>   snp_cpuid_calc_xsave_size()
>   snp_cpuid_get_validated_func()
>
>   snp_cpuid_check_range()

You can merge that small function into its only call site and put a
comment above the code:

	/* Check function is within the supported CPUID leafs ranges */

>   snp_cpuid_hv()
>   snp_cpuid_postprocess()
>   snp_cpuid()
> 
> but in those cases it seems useful to keep them grouped under the
> snp_cpuid_* prefix since they become ambiguous otherwise, and
> just using cpuid_* as a prefix (or suffix/etc) makes it unclear
> that they are only used for SNP and not for general CPUID handling.
> Should we leave those as-is?

Yap, the rest make sense to denote to what functionality they belong to.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
