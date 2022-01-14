Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5C48EDBE
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jan 2022 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiANQNc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jan 2022 11:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243161AbiANQNc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jan 2022 11:13:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15420C061574;
        Fri, 14 Jan 2022 08:13:32 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CBAA1EC04DB;
        Fri, 14 Jan 2022 17:13:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642176806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T9lVGRMfB0dZ/1pOk6rO2IeX36vPDtdKY83YL0cY2Mo=;
        b=TK52Th4/+7XvKMFOCryiQRmIwHP79uZD+OIuFZABrKQ7YzkwrV5uKKnsBKj4sUsc/3PKPr
        +x/fbpLKwQuDO7hIFbx3LuulU5N+oT7pz2XvJ8Adab9yhp1SGJnu0VK+FgU3FEn2KBrS8B
        qPgoEPJtqSyahyEqWUwxWhGgxHAS2d4=
Date:   Fri, 14 Jan 2022 17:13:30 +0100
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
Message-ID: <YeGhKll2fTcTr2wS@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113163913.phpu4klrmrnedgic@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 13, 2022 at 10:39:13AM -0600, Michael Roth wrote:
> I was thinking a future hypervisor/spec might make use of this field for
> new functionality, while still wanting to be backward-compatible with
> existing guests, so it would be better to not enforce 0. The firmware
> ABI does indeed document it as must-be-zero,

Maybe there's a good reason for that.

> by that seems to be more of a constraint on what a hypervisor is
> currently allowed to place in the CPUID table, rather than something
> the guest is meant to enforce/rely on.

So imagine whoever creates those, starts putting stuff in those fields.
Then, in the future, the spec decides to rename those reserved/unused
fields into something else and starts putting concrete values in them.
I.e., it starts using them for something.

But, now the spec breaks existing usage because those fields are already
in use. And by then it doesn't matter what the spec says - existing
usage makes it an ABI.

So we start doing expensive and ugly workarounds just so that we don't
break the old, undocumented use which the spec simply silently allowed,
and accomodate that new feature the spec adds.

So no, what you're thinking is a bad bad idea.

> snp_cpuid_info_create() (which sets snp_cpuid_initialized) only gets
> called if firmware indicates this is an SNP guests (via the cc_blob), but
> the #VC handler still needs to know whether or not it should use the SNP
> CPUID table still SEV-ES will still make use of it, so it uses
> snp_cpuid_active() to make that determination.

So I went and applied the rest of the series. And I think you mean
do_vc_no_ghcb() and it doing snp_cpuid().

Then, looking at sev_enable() and it calling snp_init(), you fail
further init if there's any discrepancy in the supplied data - CPUID,
SEV status MSR, etc.

So, practically, what you wanna test in all those places is whether
you're a SNP guest or not. Which we already have:

	sev_status & MSR_AMD64_SEV_SNP_ENABLED

so, unless I'm missing something, you don't need yet another
<bla>_active() helper.

> This code is calculating the total XSAVE buffer size for whatever
> features are enabled by the guest's XCR0/XSS registers. Those feature
> bits correspond to the 0xD subleaves 2-63, which advertise the buffer
> size for each particular feature. So that check needs to ignore anything
> outside that range (including 0xD subleafs 0 and 1, which would normally
> provide this total size dynamically based on current values of XCR0/XSS,
> but here are instead calculated "manually" since we are not relying on
> the XCR0_IN/XSS_IN fields in the table (due to the reasons mentioned
> earlier in this thread).

Yah, the gist of that needs to be as a comment of that line as it is not
obvious (at least to me).

> Not duplicate entries (though there's technically nothing in the spec
> that says you can't), but I was more concerned here with multiple
> entries corresponding to different combination of XCR0_IN/XSS_IN.
> There's no good reason for a hypervisor to use those fields for anything
> other than 0xD subleaves 0 and 1, but a hypervisor could in theory encode
> 1 "duplicate" sub-leaf for each possible combination of XCR0_IN/XSS_IN,
> similar to what it might do for subleaves 0 and 1, and not violate the
> spec.


Ditto. Also a comment ontop please.

> The current spec is a bit open-ended in some of these areas so the guest
> code is trying to be as agnostic as possible to the underlying implementation
> so there's less chance of breakage running on one hypervisor verses
> another. We're working on updating the spec to encourage better
> interoperability, but that would likely only be enforceable for future
> firmware versions/guests.

This has the same theoretical problem as the reserved/unused fields. If
you don't enforce it, people will do whatever and once it is implemented
in hypervisors and it has become an ABI, you can't change it anymore.

So I'd very strongly suggest you tighten in up upfront and only allow
stuff later, when it makes sense. Not the other way around.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
