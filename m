Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70180492C98
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 18:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347506AbiARRl3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 12:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbiARRlT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Jan 2022 12:41:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCCC061574;
        Tue, 18 Jan 2022 09:41:18 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 463CF1EC018C;
        Tue, 18 Jan 2022 18:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642527673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CsZVby0OJMbu1MByStGLgighQnR1NhGu4hi+vJOU81M=;
        b=C3sJeNxIdauAfWOLlqRZorFZVR7UQ/AVKdZPwz7vfz67sIk4HNKkeQFLPa/WrKN/1Xq+Dr
        W9ZTwB4dfE9qGzH4mfg3r2AYWqKW2xjD0W/tDOSAgw0MZM1vdg7wKPSH5uyRQLZKGEWiCf
        qNVzhry0cqwqcB8Vhz47o8b2H7qJb+0=
Date:   Tue, 18 Jan 2022 18:41:16 +0100
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
Message-ID: <Yeb7vOaqDtH6Fpsb@zn.tnic>
References: <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
 <20220118172043.djhy3dwg4fhhfqfs@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118172043.djhy3dwg4fhhfqfs@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 11:20:43AM -0600, Michael Roth wrote:
> The HV fills out the initial contents of the CPUID page, which includes
> the count. SNP/PSP firmware will validate the contents the HV tries to put
> in the initial page, but does not currently enforce that the 'count' field
> is non-zero.

So if the HV sets count to 0, then the PSP can validate all it wants but
you basically don't have a CPUID page. And that's a pretty easy way to
defeat it, if you ask me.

So, if it is too late to change this, I guess the only way out of here
is to terminate the guest on count == 0.

And regardless, what if the HV fakes the count - how do you figure out
what the proper count is? You go and read the whole CPUID page and try
to make sense of what's there, even beyond the "last" function leaf.

> So we can't rely on the 'count' field as an indicator of whether or
> not the CPUID page is active, we need to rely on the presence of the
> ccblob as the true indicator, then treat a non-zero 'count' field as
> an invalid state.

treat a non-zero count field as invalid?

You mean, "a zero count" maybe...

But see above, how do you check whether the HV hasn't "hidden" some
entries by modifying the count field?

Either I'm missing something or this sounds really weird...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
