Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D24435242
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJTSDZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhJTSDY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 14:03:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB20C06161C;
        Wed, 20 Oct 2021 11:01:10 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0db300f8abf0ed14d647a3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b300:f8ab:f0ed:14d6:47a3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2FA61EC036B;
        Wed, 20 Oct 2021 20:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634752868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/4U7+bVpmBPJ7gV+r1bdTzVoBWatHcmArzH+WpFLVX0=;
        b=LQb5wxNMBVSSlO4PGPVoSe/7fkJf0JVygFKVgj3YJxWvdH223GLeJBRVogaHJsXpgELkDZ
        aR2X2C7ns1benSbZXA3zSmx/zXmFDxNO1jhKOrJ2xoKPbM5W4/RCaen8vWDcaktwbP3Uoo
        bofa4W9GEGyxWkwSaRWxf1JrdO63uX8=
Date:   Wed, 20 Oct 2021 20:01:07 +0200
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
Message-ID: <YXBZYws8NnxiQJD7@zn.tnic>
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
> [Sorry for the wall of text, just trying to work through everything.]

And I'm going to respond in a couple of mails just for my own sanity.

> I'm not sure if this is pertaining to using the CPUID table prior to
> sme_enable(), or just the #VC-based SEV MSR read. The following comments
> assume the former. If that assumption is wrong you can basically ignore
> the rest of this email :)

This is pertaining to me wanting to show you that the design of this SNP
support needs to be sane and maintainable and every function needs to
make sense not only now but in the future.

In this particular example, we should set sev_status *once*, *before*
anything accesses it so that it is prepared when something needs it. Not
do a #VC and go, "oh, btw, is sev_status set? No? Ok, lemme set it."
which basically means our design is seriously lacking.

And I had suggested a similar thing for TDX and tglx was 100% right in
shooting it down because we do properly designed things - not, get stuff
in so that vendor is happy and then, once the vendor programmers have
disappeared to do their next enablement task, the maintainers get to mop
up and maintain it forever.

Because this mopping up doesn't scale - trust me.

> [The #VC-based SEV MSR read is not necessary for anything in sme_enable(),
> it's simply a way to determine whether the guest is an SNP guest, without
> any reliance on CPUID, which seemed useful in the context of doing some
> additional sanity checks against the SNP CPUID table and determining that
> it's appropriate to use it early on (rather than just trust that this is an
> SNP guest by virtue of the CC blob being present, and then failing later
> once sme_enable() checks for the SNP feature bits through the normal
> mechanism, as was done in v5).]

So you need to make up your mind here design-wise, what you wanna do.

The proper thing to do would be, to detect *everything*, detect whether
this is an SNP guest, yadda yadda, everything your code is going to need
later on, and then be done with it.

Then you continue with the boot and now your other code queries
everything that has been detected up til now and uses it.

End of mail 1.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
