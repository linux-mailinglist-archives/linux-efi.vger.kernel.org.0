Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F128F4A0400
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 23:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiA1W6n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 17:58:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53298 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbiA1W6n (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 17:58:43 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 782941EC0541;
        Fri, 28 Jan 2022 23:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643410717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YiDtT4AmBwaBafxN19hikHkQnXHuV/Zji75Dg4d6z9o=;
        b=JeMERGTf8a8RMw2DrlfHpHUsES5/Meq6ySSpY6TOuLfyFrvzNtDn7lveOsMTQ4SU6arz+m
        vxDfM4FJAPWYkgfWaV36naGgiPVOxezlLHTHlm1xJzgUAY1EVilAiIfwlzUYOoK9QYfL72
        YM+sGX1caWZrfkO6VxwW0DyxEL2P9J8=
Date:   Fri, 28 Jan 2022 23:58:32 +0100
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
Message-ID: <YfR1GNb/yzKu4n5+@zn.tnic>
References: <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
 <20220118172043.djhy3dwg4fhhfqfs@amd.com>
 <Yeb7vOaqDtH6Fpsb@zn.tnic>
 <20220118184930.nnwbgrfr723qabnq@amd.com>
 <20220119011806.av5rtxfv4et2sfkl@amd.com>
 <YefzQuqrV8kdLr9z@zn.tnic>
 <20220119162747.ewgxirwcnrcajazm@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119162747.ewgxirwcnrcajazm@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 19, 2022 at 10:27:47AM -0600, Michael Roth wrote:
> At that point it's much easier for the guest owner to just check the
> CPUID values directly against known good values for a particular
> configuration as part of their attestation process and leave the
> untrusted cloud vendor out of it completely. So not measuring the
> CPUID page as part of SNP attestation allows for that flexibility.

Well, in that case, I guess you don't need the sanity-checking in the
guest either - you simply add it to the attestation TODO-list for the
guest owner to go through:

Upon booting, the guest owner should compare the CPUID leafs the guest
sees with the ones supplied during boot.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
