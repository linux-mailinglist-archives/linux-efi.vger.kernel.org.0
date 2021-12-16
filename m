Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B694F4779CC
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 17:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhLPQ66 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 11:58:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37228 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234595AbhLPQ65 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Dec 2021 11:58:57 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBA3B1EC0554;
        Thu, 16 Dec 2021 17:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639673932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pWUEpsE8ix8ctSY2BZMA53JnU2wfByQzeCxkRLFpc1c=;
        b=o7ugRI55iHPXK9G3PKXYJcJLewQ7gLw1LKObNzgLkbdKRnJk0IOa0Y4GpnP5IlJTsKCVT8
        FDWsPqFtEoUgwzI9kBLu08QGoarVHyULigW8/R0xwsYO2y9dbc3Qae/rkmwHdq2VxaQvMi
        Qv8ykGXyRYVzjNyQmvkzz2qWx3FT7TI=
Date:   Thu, 16 Dec 2021 17:58:54 +0100
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
Subject: Re: [PATCH v8 06/40] x86/sev: Check SEV-SNP features support
Message-ID: <YbtwTne5BjERZV1r@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-7-brijesh.singh@amd.com>
 <Ybtfon70/+lG63BP@zn.tnic>
 <225fe4e5-02de-5e3e-06c8-d7af0f9dd161@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <225fe4e5-02de-5e3e-06c8-d7af0f9dd161@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 16, 2021 at 10:28:45AM -0600, Brijesh Singh wrote:
> A good question; the GHCB page is needed only at the time of #VC.  If the
> second stage VC handler is not called after the sev_enable() during the
> decompression stage, setting up the GHC page in sev_enable() is a waste.

It would be a waste if no #VC would fire. But we set up a #VC handler so
we might just as well set up the GHCB for it too.

> But in practice, the second stage VC handler will be called during
> decompression. It also brings a similar question for the kernel
> proper, should we do the same over there?

I'd think so, yes.
 
> Jorge did the initial ES support and may have other reasons he chose to set
> up GHCB page in the handler. I was trying to avoid the flow change. We can
> do this as a pre or post-SNP patch; let me know your thoughts?

You can do a separate patch only with that change and if it causes
trouble, we can always debug/delay it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
