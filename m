Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02F13FA073
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 22:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhH0URm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhH0URm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Aug 2021 16:17:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A7C0613D9;
        Fri, 27 Aug 2021 13:16:53 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1117002bace1eb09205059.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:2bac:e1eb:920:5059])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 514951EC0453;
        Fri, 27 Aug 2021 22:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630095407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hCYoAQ41iPdcZpGqXz/s23YuGJNo/dQNa8YAMDCU2HY=;
        b=GjwdFy7qt3ob/0LSLGK1B82Uz9msxITNAaImGC4UJMX+n4gSh2vCqtUX2rj8qMmiRPn1e/
        HecOiNXJt9D+5vT+0p8cH27z9/RkZ1Q/Mk6D1oG4FD+3yJhzjZLXLE3tSuH6RdA+IAQFfr
        Thjs6tnmfK016mHtHDygxa8FbMhAwFg=
Date:   Fri, 27 Aug 2021 22:17:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
Message-ID: <YSlIVRzTGHjou3eA@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-34-brijesh.singh@amd.com>
 <YSkkaaXrg6+cnb9+@zn.tnic>
 <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
 <20005c9e-fd82-5c96-7bfb-8b072e5d66e6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20005c9e-fd82-5c96-7bfb-8b072e5d66e6@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 02:57:11PM -0500, Tom Lendacky wrote:
> The main thing about this is that it is an error code from the HV on
> extended guest requests. The HV error code sits in the high-order 32-bits of
> the SW_EXIT_INFO_2 field. So defining it either way seems a bit confusing.
> To me, the value should just be 1ULL and then it should be shifted when
> assigning it to the SW_EXIT_INFO_2.

Err, that's from the GHCB spec:

"The hypervisor must validate that the guest has supplied enough pages

...

certificate data in the RBX register and set the SW_EXITINFO2 field to
0x0000000100000000."

So if you wanna do the above, you need to fix the spec first. I'd say.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
