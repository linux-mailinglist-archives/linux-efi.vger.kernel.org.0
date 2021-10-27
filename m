Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D843C864
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbhJ0LTj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 07:19:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237402AbhJ0LTi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Oct 2021 07:19:38 -0400
Received: from zn.tnic (p200300ec2f1615002935f4cf24b5c3ba.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:2935:f4cf:24b5:c3ba])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C06CA1EC0622;
        Wed, 27 Oct 2021 13:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635333431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=stNjoo2XJVbCmOdEgRU5yFEgbX9ASxd3JdeLr48Zahs=;
        b=ebK1cCm9TusIIJya8AsuEOa2C3nQXceCim+lTIqBQiXlDB1x/eNW5KTm2nrR7tb97mQhQS
        vnvCswmbz10LpK/Kw8nzXp85LtQ568h2zkaEyr3nXmArdt3dd3cOUNBshF/UW+o8mvILwa
        acBETot9fx4OESPek0YesL84jKRUcrY=
Date:   Wed, 27 Oct 2021 13:17:11 +0200
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
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <YXk1N6ApJA8PgkwM@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF+WjMHW/dd0Wb6@zn.tnic>
 <20211021204149.pof2exhwkzy2zqrg@amd.com>
 <YXaPKsicNYFZe84I@zn.tnic>
 <20211025163518.rztqnngwggnbfxvs@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025163518.rztqnngwggnbfxvs@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 25, 2021 at 11:35:18AM -0500, Michael Roth wrote:
> As counter-intuitive as it sounds, it actually doesn't buy us if the CPUID
> table is part of the PSP attestation report, since:

Thanks for taking the time to explain in detail - I think I know now
what's going on, and David explained some additional stuff to me
yesterday.

So, to cut to the chase:

 - yeah, ok, I guess guest owner attestation is what should happen.

 - as to the boot detection, I think you should do in sme_enable(), in
pseudo:

	bool snp_guest_detected;

        if (CPUID page address) {
                read SEV_STATUS;

                snp_guest_detected = SEV_STATUS & MSR_AMD64_SEV_SNP_ENABLED;
        }

        /* old SME/SEV detection path */
        read 0x8000_001F_EAX and look at bits SME and SEV, yadda yadda.

        if (snp_guest_detected && (!SME || !SEV))
                /*
		 * HV is lying to me, do something there, dunno what. I guess we can
		 * continue booting unencrypted so that the guest owner knows that
		 * detection has failed and maybe the HV didn't want us to force SNP.
		 * This way, attestation will fail and the user will know why.
		 * Or something like that.
		 */


        /* normal feature detection continues. */

How does that sound?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
