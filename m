Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8644A670F
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiBAV2v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 16:28:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59112 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232463AbiBAV2u (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Feb 2022 16:28:50 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB1171EC04AD;
        Tue,  1 Feb 2022 22:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643750924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7l7vocFxdezL9X3EUKTSMo+nYjMem25yARKYTuyX8jo=;
        b=UqY6/pu2Ue28uGppx/YJY4gkORX0RykPUqAdSDRchnnYt4NjKqnkwxUmhNgCRs7FckxK7f
        1pzKGK6KEJUNmRbkUwTZape/D5jU3FBobXFz22E3nxw6f5eTL9EmNgVU99rgmM7c7b816l
        I+PJ5mEE7Bl4LDHK9aNUF7u8RSHEypM=
Date:   Tue, 1 Feb 2022 22:28:39 +0100
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
Subject: Re: [PATCH v9 05/43] x86/compressed/64: Detect/setup SEV/SME
 features earlier in boot
Message-ID: <YfmmBykN2s0HsiAJ@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-6-brijesh.singh@amd.com>
 <Yfl3FaTGPxE7qMCq@zn.tnic>
 <20220201203507.goibbaln6dxyoogv@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201203507.goibbaln6dxyoogv@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 02:35:07PM -0600, Michael Roth wrote:
> Unfortunately rdmsr()/wrmsr()/__rdmsr()/__wrmsr() etc. definitions are all
> already getting pulled in via:
> 
>   misc.h:
>     #include linux/elf.h
>       #include linux/thread_info.h
>         #include linux/cpufeature.h
>           #include linux/processor.h
>             #include linux/msr.h
> 
> Those definitions aren't usable in boot/compressed because of __ex_table
> and possibly some other dependency hellishness.

And they should not be. Mixing kernel proper and decompressor code needs
to stop and untangling that is a multi-year effort, unfortunately. ;-\

> Would read_msr()/write_msr() be reasonable alternative names for these new
> helpers, or something else that better distinguishes them from the
> kernel proper definitions?

Nah, just call them rdmsr/wrmsr(). There is already {read,write}_msr()
tracepoint symbols in kernel proper and there's no point in keeping them
apart using different names - that ship has long sailed.

> It doesn't look like anything in boot/ pulls in boot/compressed/
> headers. It seems to be the other way around, with boot/compressed
> pulling in headers and whole C files from boot/.
> 
> So perhaps these new definitions should be added to a small boot/msr.h
> header and pulled in from there?

That sounds good too.

> Should we introduce something like this as well for cpucheck.c? Or
> re-write cpucheck.c to make use of the u64 versions? Or just set the
> cpucheck.c rework aside for now? (but still introduce the above helpers
> as boot/msr.h in preparation)?

How about you model it after

static int msr_read(u32 msr, struct msr *m)

from arch/x86/lib/msr.c which takes struct msr from which you can return
either u32s or a u64?

The stuff you share between the decompressor and kernel proper you put
in a arch/x86/include/asm/shared/ folder, for an example, see what we do
there in the TDX patchset:

https://lore.kernel.org/r/20220124150215.36893-11-kirill.shutemov@linux.intel.com

I.e., you move struct msr in such a shared header and then you include
it everywhere needed.

The arch/x86/boot/ msr helpers are then plain and simple, without
tracepoints and exception fixups and you define them in ...boot/msr.c or
so.

If the patch gets too big, make sure to split it in a couple so that it
is clear what happens at each step.

How does that sound?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
