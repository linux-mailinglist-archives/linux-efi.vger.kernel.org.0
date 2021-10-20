Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD34B43525C
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhJTSKx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 14:10:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47284 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhJTSKx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 14:10:53 -0400
Received: from zn.tnic (p200300ec2f0db300f8abf0ed14d647a3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b300:f8ab:f0ed:14d6:47a3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A9E31EC036B;
        Wed, 20 Oct 2021 20:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634753316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jC3IIcX0cpZuqY0H2u9GhNd5u8aIp5yIQPOEtcJKGGo=;
        b=Fv/bEf23sip2dsKp0aTcrrQ8e95rLhknRPX8YOBcNb//Di/45TckOpf89nFJgzyT9QQW0g
        CtrSP7psUhdJ3naFMgZ3cTRYiE7rzVXMbnPa+0jja/L3J+CeCkXPKS8HqcJogo7nNq2X6D
        +PvCzKzMXVmjjgAuNAIrWRZRmfySjKc=
Date:   Wed, 20 Oct 2021 20:08:39 +0200
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
Message-ID: <YXBbJwd2M03Ssq6I@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020161023.hzbj53ehmzjrt4xd@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > 1. Code checks SME/SEV support leaf. HV lies and says there's none. So
> > guest doesn't boot encrypted. Oh well, not a big deal, the cloud vendor
> > won't be able to give confidentiality to its users => users go away or
> > do unencrypted like now.
> > 
> > Problem is solved by political and economical pressure.
> > 
> > 2. Check SEV and SME bit. HV lies here. Oh well, same as the above.
> 
> I'd be worried about the possibility that, through some additional exploits
> or failures in the attestation flow,

Well, that puts forward an important question: how do you verify
*reliably* that this is an SNP guest?

- attestation?

- CPUID?

- anything else?

I don't see this written down anywhere. Because this assumption will
guide the design in the kernel.

> a guest owner was tricked into booting unencrypted on a compromised
> host and exposing their secrets. Their attestation process might even
> do some additional CPUID sanity checks, which would at the point
> be via the SNP CPUID table and look legitimate, unaware that the
> kernel didn't actually use the SNP CPUID table until after 0x8000001F
> was parsed (if we were to only initialize it after/as-part-of
> sme_enable()).

So what happens with that guest owner later?

How is she to notice that she booted unencrypted?

> Fortunately in this scenario I think the guest kernel actually would fail to
> boot due to the SNP hardware unconditionally treating code/page tables as
> encrypted pages. I tested some of these scenarios just to check, but not
> all, and I still don't feel confident enough about it to say that there's
> not some way to exploit this by someone who is more clever/persistant than
> me.

All this design needs to be preceded with: "We protect against cases A,
B and C and not against D, E, etc."

So that it is clear to all parties involved what we're working with and
what we're protecting against and what we're *not* protecting against.

End of mail 2, more later.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
