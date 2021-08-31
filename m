Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9513FC568
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 12:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhHaKFC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 06:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhHaKFA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 06:05:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D3C061575;
        Tue, 31 Aug 2021 03:04:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f2f00d101edea3987ba94.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2f00:d101:edea:3987:ba94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 342B41EC0301;
        Tue, 31 Aug 2021 12:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630404239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Iy/3OVOK2NO1M2KIyDPoKyc8AMsQklIILxAjZ9SXyHs=;
        b=TqfC8o+lCMa9u2RL22+RqrpTPdI3kTNcFktz4HTPTnJ994lq5l/XO4N0POc3/b6hIO7sAZ
        N7muTCC+WhFGpb2OXYP9886cgKxM9GBsgJMYluW7my4M+WkhTtxQbvdGA0O3EbDReHooWP
        PjZm11QjPSAJcD5Cqon++2aGzkTY5/Y=
Date:   Tue, 31 Aug 2021 12:04:33 +0200
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 28/38] x86/compressed/64: enable
 SEV-SNP-validated CPUID in #VC handler
Message-ID: <YS3+saDefHwkYwny@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-29-brijesh.singh@amd.com>
 <YSaXtpKT+iE7dxYq@zn.tnic>
 <20210827164601.fzr45veg7a6r4lbp@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827164601.fzr45veg7a6r4lbp@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 11:46:01AM -0500, Michael Roth wrote:
> I think I can split out at least sev_snp_cpuid_init() and
> sev_snp_probe_cc_blob(). Adding the actual cpuid lookup and related code to
> #VC handler though I'm not sure there's much that can be done there.

Ok.

> Will get this fixed up. I should've noticed these checkpatch warnings so
> I modified my git hook to flag these a bit more prevalently.

Yeah, that comes from git actually.

> Will make sure to great these together, but there seems to be a convention
> of including misc.h first, since it does some fixups for subsequent
> includes. So maybe that should be moved to the top? There's a comment in
> boot/compressed/sev.c:
> 
> /*
>  * misc.h needs to be first because it knows how to include the other kernel
>  * headers in the pre-decompression code in a way that does not break
>  * compilation.
>  */
> 
> And while it's not an issue here, asm/sev.h now needs to have
> __BOOT_COMPRESSED #define'd in advance. So maybe that #define should be
> moved into misc.h so it doesn't have to happen before each include?

Actually, I'd like to avoid all such nasty games, if possible, with the
compressed kernel includes because this is where it leads us: sprinkling
defines left and right and all kinds of magic include order which is
fragile and error prone.

So please try to be very conservative here with all the including games.

So I'd like to understand first *why* asm/sev.h needs to have
__BOOT_COMPRESSED defined and can that be avoided? Maybe in a separate
mail because this one already deals with a bunch of things.

> cpuid.h is for cpuid_function_is_indexed(), which was introduced in this
> series with patch "KVM: x86: move lookup of indexed CPUID leafs to helper".

Ok, if we keep cpuid.h only strictly with cpuid-specific helpers, I
guess that's fine.

> efi.h is for EFI_CC_BLOB_GUID, which gets referenced by sev-shared.c
> when it gets included here. However, misc.h seems to already include it,
> so it can be safely dropped from this patch.

Yeah, and this is what I mean: efi.h includes a bunch of linux/
namespace headers and then we have to go deal with compressed
pulling all kinds of definitions from kernel proper, with hacks like
__BOOT_COMPRESSED, for example.

That EFI_CC_BLOB_GUID is only needed in the compressed kernel, right?
That is, if you move all the CC blob parsing to the compressed kernel
and supply the thusly parsed info to kernel proper. In that case, you
can simply define in there, in efi.c or so.

> The 'reserved' fields here are documented in SEV-SNP Firmware ABI
> revision 0.9, section 8.14.2.6 (CPUID page), and the above 'reserved'
> fields of sev_snp_cpuid_fn are documented in section 7.1 (CPUID Reporting)
> Table 14:
> 
>   https://www.amd.com/system/files/TechDocs/56860.pdf
> 
> The 'unused' / 'unused2' fields correspond to 'XCR0_IN' and 'XSS_IN' in 
> section 7.1 Table 14. They are meant to allow a hypervisor to encode
> CPUID leaf 0xD subleaf 0x0:0x1 entries that are specific to a certain
> set of XSAVE features enabled via XCR0/XSS registers, so a guest can
> look up the specific entry based on its current XCR0/XSS register
> values.
> 
> This doesn't scale very well as more XSAVE features are added however,
> and was more useful for the CPUID guest message documented in 7.1, as
> opposed to the static CPUID page implemented here.
> 
> Instead, it is simpler and just as safe to have the guest calculate the
> appropriate values based on CPUID leaf 0xD, subleaves 0x2-0x3F, like
> what sev_snp_cpuid_xsave_size() does below. So they are marked unused
> here to try to make that clearer.
> 
> Some of these hypervisor-specific implementation notes have been summarized
> into a document posted to the sev-snp mailing list in June:
> 
>   "Guest/Hypervisor Implementation Notes for SEV-SNP CPUID Enforcement"
> 
> It's currently in RFC v2, but there has been a change relating to the
> CPUID range checks that needs to be added for v3, I'll get that sent
> out soon. We are hoping to get these included in an official spec to
> help with interoperability between hypervisors, but for now it is only
> a reference to aid implementations.

Thanks for explaining all that. What I mean here is to have some
reference above it to the official spec so that people can find it. With
SEV-*, there are a *lot* of specs so I'd like to have at least pointers
to the docs where one can find the text about it.

> Ok, will look at working this into there.

Yeah, first you need to kick Tom to send a new version. :-)

> More specifically, the general protocol to determine SNP is enabled seems
> to be:
> 
>  1) check cpuid 0x8000001f to determine if SEV bit is enabled and SEV
>     MSR is available
>  2) check the SEV MSR to see if SEV-SNP bit is set
> 
> but the conundrum here is the CPUID page is only valid if SNP is
> enabled, otherwise it can be garbage. So the code to set up the page
> skips those checks initially, and relies on the expectation that UEFI,
> or whatever the initial guest blob was, will only provide a CC_BLOB if
> it already determined SNP is enabled.
> 
> It's still possible something goes awry and the kernel gets handed a
> bogus CC_BLOB even though SNP isn't actually enabled. In this case the
> cpuid values could be bogus as well, but the guest will fail
> attestation then and no secrets should be exposed.
> 
> There is one thing that could tighten up the check a bit though. Some
> bits of SEV-ES code will use the generation of a #VC as an indicator
> of SEV-ES support, which implies SEV MSR is available without relying
> on hypervisor-provided CPUID bits. I could add a one-time check in
> the cpuid #VC to check SEV MSR for SNP bit, but it would likely
> involve another static __ro_after_init variable store state. If that
> seems worthwhile I can look into that more as well.

Yes, the skipping of checks above sounds weird: why don't you simply
keep the checks order: SEV, -ES, -SNP and then parse CPUID. It'll fail
at attestation eventually, but you'll have the usual flow like with the
rest of the SEV- feature picking apart.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
