Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229B03F7A7F
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhHYQ3r (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 12:29:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237216AbhHYQ3q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Aug 2021 12:29:46 -0400
Received: from zn.tnic (p200300ec2f0ea700924cc147a25a6e09.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a700:924c:c147:a25a:6e09])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05A8A1EC01FC;
        Wed, 25 Aug 2021 18:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629908935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kXTBbKX0N8PVFTNyf4PA8VUf4fQWGNpL4TXA4DMB1bg=;
        b=mRh7IF3B7odzldZV3V/mzJ72uHB8k0Pq9hyfRcu4jLE78QMHTDYO2Pe1ADumwvclqVsmRR
        8dwOilrLxXRsANVS/QE7TJa1bSM9fXknzuzuyY0hgB+AWSo+/7CrTo4AlGzk7a5lEd6p0Q
        7VBIyUc8virQJPI3RulnowUJ3yaHAlc=
Date:   Wed, 25 Aug 2021 18:29:31 +0200
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
Subject: Re: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <YSZv632kJKPzpayk@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
 <YSZTubkROktMMSba@zn.tnic>
 <20210825151835.wzgabnl7rbrge3a2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210825151835.wzgabnl7rbrge3a2@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 25, 2021 at 10:18:35AM -0500, Michael Roth wrote:
> On Wed, Aug 25, 2021 at 04:29:13PM +0200, Borislav Petkov wrote:
> > On Fri, Aug 20, 2021 at 10:19:18AM -0500, Brijesh Singh wrote:
> > > From: Michael Roth <michael.roth@amd.com>
> > > 
> > > As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
> > > head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
> > > to allow a call to set_bringup_idt_handler(), which would otherwise
> > > have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
> > > sufficient for that case, this will still cause issues if we attempt to
								^^^

I'm tired of repeating the same review comments with you guys:

Who's "we"?

Please use passive voice in your text: no "we" or "I", etc.
Personal pronouns are ambiguous in text, especially with so many
parties/companies/etc developing the kernel so let's avoid them please.

How about you pay more attention?

> I didn't realize the the 32-bit path was something you were suggesting
> to have added in this patch, but I'll take a look at that as well.

If you're going to remove the -no-stack-protector thing for that file,
then pls remove it for both 32- and 64-bit. I.e., the revert what
103a4908ad4d did.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
