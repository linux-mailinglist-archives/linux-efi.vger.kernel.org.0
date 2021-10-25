Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C202743946B
	for <lists+linux-efi@lfdr.de>; Mon, 25 Oct 2021 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhJYLGg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Oct 2021 07:06:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40432 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232394AbhJYLGf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 25 Oct 2021 07:06:35 -0400
Received: from zn.tnic (p200300ec2f0f4e0014f3333d144d8f4c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4e00:14f3:333d:144d:8f4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16F671EC01A2;
        Mon, 25 Oct 2021 13:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635159852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7cmuTPU0DzQTCxQyPVEejLbQuN+VwiqGyI2YEU3p7AA=;
        b=bsEi5PDRu9B//F2k3sBqf+iWQBeBiCnanLpmDuwuXJqZLC7yaGVSsuu9lgqvYe+bEmhhKl
        23nleFXGRaeNDIG9j9g2r+JuV0yV/Ja9wO/CkPt1uczRzIiQf8sqHepd0ZEDL0DmsdIgj2
        4Vzt5se9siIhk1/riS5dAv7DWDHpqdg=
Date:   Mon, 25 Oct 2021 13:04:10 +0200
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
Message-ID: <YXaPKsicNYFZe84I@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF+WjMHW/dd0Wb6@zn.tnic>
 <20211021204149.pof2exhwkzy2zqrg@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021204149.pof2exhwkzy2zqrg@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 21, 2021 at 03:41:49PM -0500, Michael Roth wrote:
> On Thu, Oct 21, 2021 at 04:51:06PM +0200, Borislav Petkov wrote:
> > On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > > The CPUID calls in snp_cpuid_init() weren't added specifically to induce
> > > the #VC-based SEV MSR read, they were added only because I thought the
> > > gist of your earlier suggestions were to do more validation against the
> > > CPUID table advertised by EFI
> > 
> > Well, if EFI is providing us with the CPUID table, who verified it? The
> > attestation process? Is it signed with the AMD platform key?
> 
> For CPUID table pages, the only thing that's assured/attested to by firmware
> is that:
> 
>  1) it is present at the expected guest physical address (that address
>     is generally baked into the EFI firmware, which *is* attested to)
>  2) its contents have been validated by the PSP against the current host
>     CPUID capabilities as defined by the AMD PPR (Publication #55898),
>     Section 2.1.5.3, "CPUID Policy Enforcement"
>  3) it is encrypted with the guest key
>  4) it is in a validated state at launch
> 
> The actual contents of the CPUID table are *not* attested to,

Why?

> so in theory it can still be manipulated by a malicious hypervisor as
> part of the initial SNP_LAUNCH_UPDATE firmware commands that provides
> the initial plain-text encoding of the CPUID table that is provided
> to the PSP via SNP_LAUNCH_UPDATE. It's also not signed in any way
> (apparently there were some security reasons for that decision, though
> I don't know the full details).

So this sounds like an unnecessary complication. I'm sure there are
reasons to do it this way but my simple thinking would simply want the
CPUID page to be read-only and signed so that the guest can trust it
unconditionally.

> [A guest owner can still validate their CPUID values against known good
> ones as part of their attestation flow, but that is not part of the
> attestation report as reported by SNP firmware. (So long as there is some
> care taken to ensure the source of the CPUID values visible to
> userspace/guest attestion process are the same as what was used by the boot
> stack: i.e. EFI/bootloader/kernel all use the CPUID page at that same
> initial address, or in cases where a copy is used, that copy is placed in
> encrypted/private/validated guest memory so it can't be tampered with during
> boot.]

This sounds like the good practices advice to guest owners would be,
"Hey, I just booted your SNP guest but for full trust, you should go and
verify the CPUID page's contents."

"And if I were you, I wouldn't want to run any verification of CPUID
pages' contents on the same guest because it itself hasn't been verified
yet."

It all sounds weird.

> So, while it's more difficult to do, and the scope of influence is reduced,
> there are still some games that can be played to mess with boot via
> manipulation of the initial CPUID table values, so long as they are within
> the constraints set by the CPUID enforcement policy defined in the PPR.
> 
> Unfortunately, the presence of the SEV/SEV-ES/SEV-SNP bits in 0x8000001F,
> EAX, are not enforced by PSP. The only thing enforced there is that the
> hypervisor cannot advertise bits that aren't supported by hardware. So
> no matter how much the boot stack is trusted, the CPUID table does not
> inherit that trust, and even values that we *know* should be true should be
> verified rather than assumed.
> 
> But I think there are a couple approaches for verifying this is an SNP
> guest that are robust against this sort of scenario. You've touched on
> some of them in your other replies, so I'll respond there.

Yah, I guess the kernel can do good enough verification and then the
full thing needs to be done by the guest owner and in *some* userspace
- not necessarily on the currently booted, unverified guest - but
somewhere, where you have maximal flexibility.

IMHO.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
