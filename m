Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C960B47B295
	for <lists+linux-efi@lfdr.de>; Mon, 20 Dec 2021 19:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhLTSKj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Dec 2021 13:10:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhLTSKj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 20 Dec 2021 13:10:39 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2F431EC02AD;
        Mon, 20 Dec 2021 19:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640023829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u3qadLJLiGlSgg2xgOL2YC+8FxEP43TobdqfUt7kZfs=;
        b=QmswxF0+lNGM5M1aASyqrDia50ovg/fASW425kO6II3UgRUEDk7qDKW5x2diW9uBn4cFwN
        8Go6v7DlrLikQSAnRE9A53xfP+VfrhPTF04qONhX2QpcnXQbJq28hRJ2+dpkX1JUdu1SCs
        pp11efyKP/pk75Bs0dtNIKKVTQuMxVY=
Date:   Mon, 20 Dec 2021 19:10:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Mikolaj Lisik <lisik@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [PATCH v8 08/40] x86/sev: Check the vmpl level
Message-ID: <YcDHF016tJLkempZ@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-9-brijesh.singh@amd.com>
 <YbugbgXhApv9ECM2@dt>
 <CADtC8PX_bEk3rQR1sonbp-rX7rAG4fdbM41r3YLhfj3qWvqJrw@mail.gmail.com>
 <79c91197-a7d8-4b93-b6c3-edb7b2da4807@amd.com>
 <d56c2f64-9e31-81d8-f250-e9772ba37d7e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d56c2f64-9e31-81d8-f250-e9772ba37d7e@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 17, 2021 at 04:33:02PM -0600, Tom Lendacky wrote:
> > > > > +      * There is no straightforward way to query the current VMPL level. The
> > > > > +      * simplest method is to use the RMPADJUST instruction to change a page
> > > > > +      * permission to a VMPL level-1, and if the guest kernel is launched at
> > > > > +      * a level <= 1, then RMPADJUST instruction will return an error.
> > > > Perhaps a nit. When you say "level <= 1", do you mean a level lower than or
> > > > equal to 1 semantically, or numerically?
> > 
> > Its numerically, please see the AMD APM vol 3.
> 
> Actually it is not numerically...  if it was numerically, then 0 <= 1 would
> return an error, but VMPL0 is the highest permission level.

Just write in that comment exactly what this function does:

"RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
higher) privilege level. Here, clear the VMPL1 permission mask of the
GHCB page. If the guest is not running at VMPL0, this will fail.

If the guest is running at VMP0, it will succeed. Even if that operation
modifies permission bits, it is still ok to do currently because Linux
SNP guests are supported only on VMPL0 so VMPL1 or higher permission
masks changing is a don't-care."

and then everything is clear wrt numbering, privilege, etc.

Ok?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
