Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51934A7861
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 19:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiBBS5s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 13:57:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232525AbiBBS5s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Feb 2022 13:57:48 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 609371EC04E2;
        Wed,  2 Feb 2022 19:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643828262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3U8ZC9BzawtxrXmVgjq+VFamXu78o7dgi9QKX8beiZs=;
        b=MDv7m46t4sdlGD3qdQjScPzNa+EG0UH+UnAFyVxGzAhV3Yw72N/tVvr+2NA3yYhGoDTbJu
        PE6ls7I9F+5AMJEBl0qU/58v49+c2NkvUKY0vgpJUixC5teLwmC0vBKwC3DIWDQG9Ieuj6
        xKWLIOdRG/BdhXkeqLw2mxTSMaVUgJk=
Date:   Wed, 2 Feb 2022 19:57:37 +0100
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
Message-ID: <YfrUIVv70fTwydZv@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-6-brijesh.singh@amd.com>
 <Yfl3FaTGPxE7qMCq@zn.tnic>
 <20220201203507.goibbaln6dxyoogv@amd.com>
 <YfmmBykN2s0HsiAJ@zn.tnic>
 <20220202005212.a3fnn6i76ko6u6t5@amd.com>
 <YfogFFOoHvCV+/2Y@zn.tnic>
 <20220202172801.4plsgy5ispu2bi7c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202172801.4plsgy5ispu2bi7c@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 11:28:01AM -0600, Michael Roth wrote:
> Indeed... it looks like linux/{elf,io,efi,acpi}.h all end up pulling in
> kernel proper's rdmsr()/wrmsr() definitions, and pulling them out ends up
> breaking a bunch of other stuff,

It's a nightmare - just gave it a try. No wonder they call it include
hell.

> so I think we might be stuck using a different name like
> rd_msr()/wr_msr() in the meantime.

Ok, but then pls call them boot_rdmsr() and boot_wrmsr() so that there's
a clear distinction from all the other msr helpers. And put a comment
above them in arch/x86/boot/msr.h explaining why they're called this
way.

One fine day I'll have this mess untangled and clean...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
