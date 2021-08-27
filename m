Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800623F9B8E
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbhH0PTK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 11:19:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49636 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245404AbhH0PTJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 11:19:09 -0400
Received: from zn.tnic (p200300ec2f1117008c66b42124dc6a0e.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:8c66:b421:24dc:6a0e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 661E41EC0493;
        Fri, 27 Aug 2021 17:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630077493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZslriKHxbCHlChlqpQpN8Ct1kTFVcJmfBH1i2TOMis0=;
        b=dS9d0tdMHelX7BeSkD5dirk3h3ErCw77WLAuqdv85ajmebrGqQhIMoW5u1vhc6oTuaqaKy
        LjB5nMNTRp8Q3EzgAOD0U+X0ai7Hy9JvEQKMg2IlniiG9AWAWuejj0XN486YyVD21OT7fs
        +wU9HdR9Y57TbcWeSNGREZ1ynEyPloE=
Date:   Fri, 27 Aug 2021 17:18:49 +0200
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 32/38] x86/sev: enable SEV-SNP-validated CPUID
 in #VC handlers
Message-ID: <YSkCWVTd0ZEvphlx@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-33-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:27AM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> This adds support for utilizing the SEV-SNP-validated CPUID table in

s/This adds support for utilizing/Utilize/

Yap, it can really be that simple. :)

> the various #VC handler routines used throughout boot/run-time. Mostly
> this is handled by re-using the CPUID lookup code introduced earlier
> for the boot/compressed kernel, but at various stages of boot some work
> needs to be done to ensure the CPUID table is set up and remains
> accessible throughout. The following init routines are introduced to
> handle this:

Do not talk about what your patch does - that should hopefully be
visible in the diff itself. Rather, talk about *why* you're doing what
you're doing.

> sev_snp_cpuid_init():

This one is not really introduced - it is already there.

<snip all the complex rest>

So this patch is making my head spin. It seems we're dancing a lot of
dance just to have our CPUID page present at all times. Which begs the
question: do we need it during the whole lifetime of the guest?

Regardless, I think this can be simplified by orders of
magnitude if we allocated statically 4K for that CPUID page in
arch/x86/boot/compressed/mem_encrypt.S, copied the supplied CPUID page
from the firmware to it and from now on, work with our own copy.

You probably would need to still remap it for kernel proper but it would
get rid of all that crazy in this patch here.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
