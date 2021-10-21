Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157C1436484
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJUOlx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 10:41:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhJUOlu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 10:41:50 -0400
Received: from zn.tnic (p200300ec2f1912003b8abe7004197216.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:1200:3b8a:be70:419:7216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D5941EC03C9;
        Thu, 21 Oct 2021 16:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634827173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y17JTnGMD0mtwTslqhoBBVABf5L1UdFOBWZGIOCjXBc=;
        b=WBGqbz725B0Tn4Gqi9IfVffxfPZHOyMrX9swMzwzKOKDnAf95Ur6JThfCJ9KBP7gbW1Dh0
        r24q9fqe9U0q38J4Z4zQLkXLXqluT8qQUy7iWT1AHe+c2HFsXO79fNq8iAHcPUE/bd0dTI
        8uOp5LTDa0i52bQxYYTnt6TwbG41+zU=
Date:   Thu, 21 Oct 2021 16:39:31 +0200
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
Message-ID: <YXF7o8X9Elc8s8t7@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXBbJwd2M03Ssq6I@zn.tnic>
 <20211021020542.v5s7xr4s2j3gsale@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021020542.v5s7xr4s2j3gsale@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 09:05:42PM -0500, Michael Roth wrote:
> According to the APM at least, (Rev 3.37, 15.34.10, "SEV_STATUS MSR"), the
> SEV MSR is the appropriate source for guests to use. This is what is used
> in the EFI code as well. So that seems to be the right way to make the
> initial determination.

Yap.

> There's a dependency there on the SEV CPUID bit however, since setting the
> bit to 0 would generally result in a guest skipping the SEV MSR read and
> assuming 0. So for SNP it would be more reliable to make use of the CPUID
> table at that point, since it's less-susceptible to manipulation, or do the
> #VC-based SEV MSR read (or both).

So the CPUID page is supplied by the firmware, right?

Then, you parse it and see that the CPUID bit is 1, then you start using
the SEV_STATUS MSR and all good.

If there *is* a CPUID page but that bit is 0, then you can safely assume
that something is playing tricks on ya so you simply refuse booting.

> Fully-unencrypted should result in a crash due to the reasons below.

Crash is a good thing in confidential computing. :)

> But there may exist some carefully crafted outside influences that could
> goad the guest into, perhaps, not marking certain pages as private. The
> best that can be done to prevent that is to audit/harden all the code in the
> boot stack so that it is less susceptible to that kind of outside
> manipulation (via mechanisms like SEV-ES, SNP page validation, SNP CPUID
> table, SNP restricted injection, etc.)

So to me I wonder why would one use anything *else* but an SNP guest. We
all know that those previous technologies were just the stepping stones
towards SNP.

> Then of course that boot stack needs to be part of the attestation process
> to provide any meaningful assurances about the resulting guest state.
>
> Outside of the boot stack the guest owner might take some extra precautions.
> Perhaps custom some kernel driver to verify encryption/validated status of
> guest pages, some checks against the CPUID table to verify it contains sane
> values, but not really worth speculating on that aspect as it will be
> ultimately dependent on how the cloud vendor decides to handle things after
> boot.

Well, I've always advocated having a best-practices writeup somewhere
goes a long way to explain this technology to people and how to get
their feet wet. And there you can give hints how such verification could
look like in detail...

> That would indeed be useful. Perhaps as a nice big comment in sme_enable()
> and/or the proposed sev_init() so that those invariants can be maintained,
> or updated in sync with future changes. I'll look into that for the next
> spin and check with Brijesh on the details.

There is Documentation/x86/amd-memory-encryption.rst, for example.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
