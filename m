Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA4436444
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJUOaZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 10:30:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhJUOaZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 10:30:25 -0400
Received: from zn.tnic (p200300ec2f1912003b8abe7004197216.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:1200:3b8a:be70:419:7216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD0101EC0554;
        Thu, 21 Oct 2021 16:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634826487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rcU9vPUUzI5swHp7U/1X5pUaXTmEfV+1ihJzmOdAcOM=;
        b=qMTa8TKwojdJWcWHU4iWnSB3q3yU5q61pMpG8GDVfyoMftwa8AJp8ju65Ond55BqBrHHZr
        FaxndF/cbJqIyuqXkmPXxt8wD/vwcy/4fnPFK5VBwgfOiZMy6w8afPcPqpDhCVTNOfExBW
        fnUfImp1INRySM74yPeOVphMoiw8cy0=
Date:   Thu, 21 Oct 2021 16:28:07 +0200
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
Message-ID: <YXF4914AczWoN8TK@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXBZYws8NnxiQJD7@zn.tnic>
 <20211021003535.ic35p6nnxdmavw35@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021003535.ic35p6nnxdmavw35@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 07:35:35PM -0500, Michael Roth wrote:
> Fortunately, all the code makes use of sev_status to get at the SEV MSR
> bits, so breaking the appropriate bits out of sme_enable() into an earlier
> sev_init() routine that's the exclusive writer of sev_status sounds like a
> promising approach.

Ack.

> It makes sense to do it immediately after the first #VC handler is set
> up, so CPUID is available, and since that's where SNP CPUID table
> initialization would need to happen if it's to be made available in
> #VC handler.

Right, and you can do all your init/CPUID prep there.

> It may even be similar enough between boot/compressed and run-time kernel
> that it could be a shared routine in sev-shared.c.

Uuh, bonus points! :-)

> But then again it also sounds like the appropriate place to move the
> snp_cpuid_init*() calls, and locating the cc_blob, and since there's
> differences there it might make sense to keep the boot/compressed and
> kernel proper sev_init() routines separate to avoid #ifdeffery).
>
> Not to get ahead of myself though. Just seems like a good starting point
> for how to consolidate the various users.

I like how you're thinking. :)

> Got it, and my apologies if I've given you that impression as it's
> certainly not my intent. (though I'm sure you've heard that before.)

Nothing to apologize - all good.

> Agreed, if we need to check SEV MSR early for the purposes of SNP it makes
> sense to move the overall SEV feature detection code earlier as well. I
> should have looked into that aspect more closely before introducing the
> changes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
