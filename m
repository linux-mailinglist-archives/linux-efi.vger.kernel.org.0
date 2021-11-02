Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909AE44340A
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 17:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhKBQ4P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Nov 2021 12:56:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52004 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhKBQz5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 2 Nov 2021 12:55:57 -0400
Received: from zn.tnic (p200300ec2f0f6200599060f0a067c463.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6200:5990:60f0:a067:c463])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2C4D1EC0532;
        Tue,  2 Nov 2021 17:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635872001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=edrm3R3EEsBQR1D6gAzpHHTA03yLJ3qMQOUPmrVmSFM=;
        b=eEDc+58iPJ1KEK5RLv3j8dCETvgVFTaSsrzR7pOdy3VmF7evYjnsJqxOiUibHXeetZf9IZ
        xeLB0+L9Ka9uKeIjLpvQCSEWbp5E+bOJzk6g31SWdUqzALJiSOaft2W9zfN90hdCFQZWU8
        VlrsoegkGI4LYkNqaMdK2ReBGgMAbQo=
Date:   Tue, 2 Nov 2021 17:53:15 +0100
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
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 14/42] x86/sev: Register GHCB memory when SEV-SNP is
 active
Message-ID: <YYFs+5UUMfyDgh/a@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-15-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-15-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:25PM -0500, Brijesh Singh wrote:
> +	/* SEV-SNP guest requires that GHCB must be registered. */
> +	if (cc_platform_has(CC_ATTR_SEV_SNP))
> +		snp_register_ghcb(data, __pa(ghcb));

This looks like more of that "let's register a GHCB at the time the
first #VC fires".

And there already is setup_ghcb() which is called in the #VC handler.
And that thing registers a GHCB GPA.

But then you have to do it here again.

I think this should be changed together with the CPUID page detection
stuff we talked about earlier, where, after you've established that this
is an SNP guest, you call setup_ghcb() *once* and after that you have
everything set up, including the GHCB GPA. And then the #VC exceptions
can come.

Right?

Or is there a chicken-and-an-egg issue here which I'm not thinking
about?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
