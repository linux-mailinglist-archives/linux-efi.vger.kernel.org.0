Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2336436AD9
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhJUSsu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 14:48:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJUSst (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 14:48:49 -0400
Received: from zn.tnic (p200300ec2f1912005c22c248f35985a5.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:1200:5c22:c248:f359:85a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF4681EC053B;
        Thu, 21 Oct 2021 20:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634841992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WvxWgq2dLAGqen8UM31jjC2Q8Nfg2PZVc4rOcpkz+RQ=;
        b=TabvkIr+qmtR55/vwHcln6Rs8ye3YUSx9Dog/d2cXtpz1H4TnQNoL9czyC7cFT+ujxLj0B
        cZfWEH+Var/MpHaA0blwxefl9GWCYta5nWH3/guDkDjWtCVLZpnZukGu/mc4DX54BQoph+
        yDf69FlEAUe5W1ly8gCa/HifIYG1APE=
Date:   Thu, 21 Oct 2021 20:46:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <YXG1hvxcXsU2XCa1@zn.tnic>
References: <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF9sCbPDsLwlm42@zn.tnic>
 <YXGNmeR/C33HvaBi@work-vm>
 <YXGbcqN2IRh9YJk9@zn.tnic>
 <YXGflXdrAXH5fE5H@work-vm>
 <YXGlPf5OTPzp09qr@zn.tnic>
 <YXGnxs0hV3IKGDwP@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXGnxs0hV3IKGDwP@work-vm>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 21, 2021 at 06:47:50PM +0100, Dr. David Alan Gilbert wrote:
> Hang on, I think it's perfectly fine for it to clear that bit - it just
> gets caught if it *sets* it (i.e. claims to be a chip unaffected by the
> bug).
> 
> i.e. if guestval=0 then (GustVal & whatever) == GuestVal
>   fine
> 
> ?

Bah, ofc. The name of the bit is NullSelectorClearsBase - so when it is
clear, we will note we're affected, as that patch does:

+       /*
+        * CPUID bit above wasn't set. If this kernel is still running
+        * as a HV guest, then the HV has decided not to advertize
+        * that CPUID bit for whatever reason.  For example, one
+        * member of the migration pool might be vulnerable.  Which
+        * means, the bug is present: set the BUG flag and return.
+        */
+       if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {
+               set_cpu_bug(c, X86_BUG_NULL_SEG);
+               return;
+       }

I have managed to flip the meaning in my mind.

Ok, that makes more sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
