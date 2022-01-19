Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8949395C
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jan 2022 12:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354060AbiASLRf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jan 2022 06:17:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353333AbiASLRe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Jan 2022 06:17:34 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80D521EC0104;
        Wed, 19 Jan 2022 12:17:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642591048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3JZMc0cZY/SUPYpFhVyzLfJhcLypzpNmmb+t6qBlwLE=;
        b=qUTlStzkk+lxcVwq7swjPFQ90VBHDXor/Tws967xJSIi7NJbDhMSz/XastqXpZeuvyTGp7
        dxN3rR3fv510nGlnMCZYnyEltwTGh0aoC7CcRFjap1yroqzhNbhErBllK8CVsvnbqoQuzX
        AyR9nydZAv2CUODYccXnBOA4d3FTOhA=
Date:   Wed, 19 Jan 2022 12:17:22 +0100
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
Message-ID: <YefzQuqrV8kdLr9z@zn.tnic>
References: <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
 <20220118172043.djhy3dwg4fhhfqfs@amd.com>
 <Yeb7vOaqDtH6Fpsb@zn.tnic>
 <20220118184930.nnwbgrfr723qabnq@amd.com>
 <20220119011806.av5rtxfv4et2sfkl@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119011806.av5rtxfv4et2sfkl@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 07:18:06PM -0600, Michael Roth wrote:
> If 'fake_count'/'reported_count' is greater than the actual number of
> entries in the table, 'actual_count', then all table entries up to
> 'fake_count' will also need to pass validation. Generally the table
> will be zero'd out initially, so those additional/bogus entries will
> be interpreted as a CPUID leaves where all fields are 0. Unfortunately,
> that's still considered a valid leaf, even if it's a duplicate of the
> *actual* 0x0 leaf present earlier in the table. The current code will
> handle this fine, since it scans the table in order, and uses the
> valid 0x0 leaf earlier in the table.

I guess it would be prudent to have some warnings when enumerating those
leafs and when the count index "goes off into the weeds", so to speak,
and starts reading 0-CPUID entries. I.e., "dear guest owner, your HV is
giving you a big lie: a weird/bogus CPUID leaf count..."

:-)

And lemme make sure I understand it: the ->count itself is not
measured/encrypted because you want to be flexible here and supply
different blobs with different CPUID leafs?

> This is isn't really a special case though, it falls under the general
> category of a hypervisor inserting garbage entries that happen to pass
> validation, but don't reflect values that a guest would normally see.
> This will be detectable as part of guest owner attestation, since the
> guest code is careful to guarantee that the values seen after boot,
> once the attestation stage is reached, will be identical to the values
> seen during boot, so if this sort of manipulation of CPUID values
> occurred, the guest owner will notice this during attestation, and can
> abort the boot at that point. The Documentation patch addresses this
> in more detail.

Yap, it is important this is properly explained there so that people can
pay attention to during attestation.

> If 'fake_count' is less than 'actual_count', then the PSP skips
> validation for anything >= 'fake_count', and leaves them in the table.
> That should also be fine though, since guest code should never exceed
> 'fake_count'/'reported_count', as that's a blatant violation of the
> spec, and it doesn't make any sense for a guest to do this. This will
> effectively 'hide' entries, but those resulting missing CPUID leaves
> will be noticeable to the guest owner once attestation phase is
> reached.

Noticeable because the guest owner did supply a CPUID table with X
entries but the HV is reporting Y?

If so, you can make this part of the attestation process: guest owners
should always check the CPUID entries count to be of a certain value.

> This does all highlight the need for some very thorough guidelines
> on how a guest owner should implement their attestation checks for
> cpuid, however. I think a section in the reference implementation
> notes/document that covers this would be a good starting point. I'll
> also check with the PSP team on tightening up some of these CPUID
> page checks to rule out some of these possibilities in the future.

Now you're starting to grow the right amount of paranoia - I'm glad I
was able to sensitize you properly!

:-)))

> Nevermind, that doesn't work since snp_cpuid_info_get_ptr() is also called
> by snp_cpuid_info_get_ptr() *prior* to initializing the table, so it ends
> seeing cpuid->count==0 and fails right away. So your initial suggestion
> of checking cpuid->count==0 at the call-sites to determine if the table
> is enabled is probably the best option.
> 
> Sorry for the noise/confusion.

No worries - the end result is important!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
