Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31F4A74BB
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiBBPhS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 10:37:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbiBBPhR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Feb 2022 10:37:17 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10A411EC059D;
        Wed,  2 Feb 2022 16:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643816232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lR+5h1xpSxxBgCHRuGXXMTqEsGCqmfgSEVBH7xBsRo8=;
        b=G1I2u0TJApKDboo30VddlADnScMtG9Dasl6SClNcRc3fiGRb2fK/j/sKg+xwr9mX0TT+ZC
        AJ9QWyrGIKjz+/gy+c6U1k+Cklc9Dn99Qr83fclck8Fa/7bM0+WVKGpo+wAtukkS1ZSCzy
        IodLXDx0DeRa8zBUw2LNDiIdCUCh2KY=
Date:   Wed, 2 Feb 2022 16:37:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 10/43] x86/sev: Check SEV-SNP features support
Message-ID: <YfqlI5UZ73K2z1I8@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-11-brijesh.singh@amd.com>
 <YfmRBUtoWNb9BkuL@zn.tnic>
 <02102fda-63b9-5da0-2e2b-037761cc0019@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02102fda-63b9-5da0-2e2b-037761cc0019@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 08:28:17AM -0600, Brijesh Singh wrote:
> Yeah, most of the documentation explicitly calls SEV-SNP, I was unsure about
> the trademark, so I used it in the comments/logs. I am okay with the SEV
> prefix removed; I am not in the marketing team, and hopefully, they will
> *never* see kernel code ;)

They better! :-)

Also, in our kernel team here, the importance lies on having stuff
clearly and succinctly explained, without any bla or fluff. When you
look at that code later, you should go "ah, ok, that's why we're doing
this here" - not, "uuh, I need to sit down and parse that comment
first."

That's why I'd like for comments to have only good and important words -
no deadweight marketing bla.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
