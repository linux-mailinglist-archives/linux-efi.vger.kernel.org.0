Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1CB4AAF78
	for <lists+linux-efi@lfdr.de>; Sun,  6 Feb 2022 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbiBFNiT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Feb 2022 08:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiBFNiS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Feb 2022 08:38:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44EC06173B;
        Sun,  6 Feb 2022 05:38:15 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 469F21EC032C;
        Sun,  6 Feb 2022 14:38:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644154687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jAuLPEHRUsnnnDOtFbaDbZZRlFj8WlIUOHei0nXkJ54=;
        b=jbvbDK7pFpV/x4yx6ITBACVsTMl0wUK77KfaIR7xczK/wojWL/Y8vhtEsgvLu26XTwC7PI
        Nz9PPVVb6VHGVQpY6Foh5zHng53Jlg0EGsBrkFj744JlWapTsjbYADAAzPIIKpVHLw1009
        gWqRhpncPL6J0yOFXGPgmb2QQ/lJg8Q=
Date:   Sun, 6 Feb 2022 14:37:59 +0100
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
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com
Subject: Re: [PATCH v9 31/43] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <Yf/PN8rBy3m5seU9@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-32-brijesh.singh@amd.com>
 <Yf5XScto3mDXnl9u@zn.tnic>
 <20220205162249.4dkttihw6my7iha3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205162249.4dkttihw6my7iha3@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

First of all,

let me give you a very important piece of advice for the future:
ignoring review feedback is a very unfriendly thing to do:

- if you agree with the feedback, you work it in in the next revision

- if you don't agree, you *say* *why* you don't

What you should avoid is what you've done - ignore it silently. Because
reviewing submitters code is the most ungrateful work around the kernel,
and, at the same time, it is the most important one.

So please make sure you don't do that in the future when submitting
patches for upstream inclusion. I'm sure you can imagine, the ignoring
can go both ways.

On Sat, Feb 05, 2022 at 10:22:49AM -0600, Michael Roth wrote:
> The documentation for lea (APM Volume 3 Chapter 3) seemed to require
> that the destination register be a general purpose register, so it
> seemed like there was potential for breakage in allowing GCC to use
> anything otherwise.

There's no such potential: binutils encodes the unstruction operands
and what types are allowed. IOW, the assembler knows that there goes a
register.

> Maybe GCC is smart enough to figure that out, but since we know the
> constraint in advance it seemed safer to stick with the current
> approach of enforcing that constraint.

I guess in this particular case it won't matter whether it is "=r" or
"=g" but still...

> I did look into it and honestly it just seemed to add more abstractions that
> made it harder to parse the specific operations taken place here. For
> instance, post-processing of 0x8000001E entry, we have e{a,b,c,d}x from
> the CPUID table, then to post process:
> 
>   switch (func):
>   case 0x8000001E:
>     /* extended APIC ID */
>     snp_cpuid_hv(func, subfunc, eax, &ebx2, &ecx2, NULL);

Well, my suggestion was to put it *all* in the subleaf struct - not just
the regs:

struct cpuid_leaf {
	u32 func;
	u32 subfunc;
	u32 eax;
	u32 ebx;
	u32 ecx;
	u32 edx;
};

so that the call signature is:

	snp_cpuid_postprocess(struct cpuid_leaf *leaf)


> and it all reads in a clear/familiar way to all the other
> cpuid()/native_cpuid() users throughout the kernel,

maybe it should read differently *on* *purpose*. Exactly because this is
*not* the usual CPUID handling code but CPUID verification code for SNP
guests.

And please explain to me what's so unclear about leaf->eax vs *eax?!

> and from the persective of someone auditing this from a security
> perspective that needs to quickly check what registers come from the
> CPUID table, what registers come from HV

Having a struct which is properly named will actually be beneficial in
this case:

	hv_leaf->eax

or even

	hv_reported_leaf->eax

vs

	*eax

Now guess which is which.

> But if we start passing around this higher-level structure that does
> not do anything other than abstract away e{a,b,c,x} to save on function
> arguments, things become muddier, and there's more pointer dereference
> operations and abstractions to sift through.

Huh?! I'm sorry but I cannot follow that logic here.

> I saved the diff from when I looked into it previously (was just a
> rough-sketch, not build-tested), and included it below for reference,
> but it just didn't seem to help with readability to me,

Well, looking at it, the only difference is that the IO is done
over a struct instead of separate pointers. And the diff is pretty
straight-forward.

So no, having a struct cpuid_leaf containing it all is actually better
in this case because you know which is which if you name it properly and
you have a single pointer argument which you pass around - something
which is done all around the kernel.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
