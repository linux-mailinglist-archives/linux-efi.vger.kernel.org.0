Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664484364AE
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJUOud (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 10:50:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUOub (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 10:50:31 -0400
Received: from zn.tnic (p200300ec2f1912003b8abe7004197216.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:1200:3b8a:be70:419:7216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF9201EC0554;
        Thu, 21 Oct 2021 16:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634827693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LFIuHJqA1Ok8eGxsQDk+FzhK+VwfVCIGalVILCtc6mM=;
        b=F5CjdLMt3ljZR1pMBN0I0I40KB+bqYCabnPHfamE/zWwBlD+b7GndmIPbxEEZdzMWYOKBc
        QQuBG9sOlY7F34hP3KevRm1q0eYMT4x8d02Rmzs4Q89yN+sDrxE0esRUINg416udbF0AgO
        b/qutwzImWXA1ZE5aFGniElqF/PQqiM=
Date:   Thu, 21 Oct 2021 16:48:16 +0200
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
Message-ID: <YXF9sCbPDsLwlm42@zn.tnic>
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
> At which point we then switch to using the CPUID table? But at that
> point all the previous CPUID checks, both SEV-related/non-SEV-related,
> are now possibly not consistent with what's in the CPUID table. Do we
> then revalidate?

Well, that's a tough question. That's basically the same question as,
does Linux support heterogeneous cores and can it handle hardware
features which get enabled after boot. The perfect example is, late
microcode loading which changes CPUID bits and adds new functionality.

And the answer to that is, well, hard. You need to decide this on a
case-by-case basis.

But isn't it that the SNP CPUID page will be parsed early enough anyway
so that kernel proper will see only SNP CPUID info and init properly
using that?

> Even a non-malicious hypervisor might provide inconsistent values
> between the two sources due to bugs, or SNP validation suppressing
> certain feature bits that hypervisor otherwise exposes, etc.

There's also migration, lemme point to a very recent example:

https://lore.kernel.org/r/20211021104744.24126-1-jane.malalane@citrix.com

which is exactly what you say - a non-malicious HV taking care of its
migration pool. So how do you handle that?

> Now all the code after sme_enable() can potentially take unexpected
> execution paths, where post-sme_enable() code makes assumptions about
> pre-sme_enable() checks that may no longer hold true.

So as I said above, if you parse SNP CPUID page early enough, you don't
have to worry about feature rediscovery. Early enough means, before
identify_boot_cpu().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
