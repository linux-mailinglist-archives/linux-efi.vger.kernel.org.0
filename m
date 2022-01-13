Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F248D762
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 13:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiAMMVw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 07:21:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234441AbiAMMVw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Jan 2022 07:21:52 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F5531EC0354;
        Thu, 13 Jan 2022 13:21:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642076506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZAoUL5a30Wp0xdYKJeBn+tmpm7PgO5BS6psMkuvBq8M=;
        b=CqlnEkYObcIR43yDYw3C2KJS5WHJlpnJqJMuMnLMlIrYSUNOCpVOEdyX6D3+R3zbMYU5zH
        A/vKSe0rHv8F1ICeR/Lr3Sk2KzaAY9hlbqsY7gHNJXmYwxVkGGiq5PUfhWLTzg+LlbVkun
        3Mfw2yZnU4tNkYNsospcmMwNxxEYsm0=
Date:   Thu, 13 Jan 2022 13:21:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 20/40] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
Message-ID: <YeAZXgW6G/0aVlXn@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-21-brijesh.singh@amd.com>
 <Yc8jerEP5CrxfFi4@zn.tnic>
 <75c0605f-7ed0-abcc-4855-dae5d87d0861@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75c0605f-7ed0-abcc-4855-dae5d87d0861@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 12, 2022 at 10:33:40AM -0600, Brijesh Singh wrote:
> Yes, the SEV-SNP feature is required. Anyway, I will improve a check. We
> will reach to AP creation only after SEV-SNP feature is checked, so, in AP
> creation routine we just need to check for the AP_CREATION specific feature
> flag; I will add comment about it.

Right, at least a comment explaining why the bits are ORed.
> 
> > You can still enforce that requirement in the test though.
> > 
> > Or all those SEV features should not be bits but masks -
> > GHCB_HV_FT_SNP_AP_CREATION_MASK for example, seeing how the others
> > require the previous bits to be set too.

Thinking about this more, calling it a "mask" might not be optimal here
as you use masks usually to, well, mask out bits, etc. So I guess a
comment explaning why the OR-in of bit 0...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
