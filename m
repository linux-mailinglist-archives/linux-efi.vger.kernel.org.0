Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0446BC48
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhLGNVI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 08:21:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236913AbhLGNVH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Dec 2021 08:21:07 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A07471EC047E;
        Tue,  7 Dec 2021 14:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638883051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=95VQLKSNF4QWMQ09hda7pdps2WmbfOKf1gNMtpDPlS4=;
        b=np3NMTz+/Qi3FJluqNhrqUTFzwJNqFZhFGubvx83OlmR0HPXR0Flz8vwvOWEGECZi1RCbI
        rqQfcKSJgEqGW2+1cjJIji8I55z+pO+EH9eKLBk/wGjX20DmBewYR1JLPBCFZaPLCABxTv
        W9r7V93QzzXgzXyRpJhnM5q6quWyczY=
Date:   Tue, 7 Dec 2021 14:17:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
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
Subject: Re: [PATCH v7 09/45] x86/sev: Save the negotiated GHCB version
Message-ID: <Ya9e7fDxj6WiomqI@zn.tnic>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-10-brijesh.singh@amd.com>
 <5b1c348a-fc26-e257-7bc2-82d1326de321@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b1c348a-fc26-e257-7bc2-82d1326de321@gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 07, 2021 at 08:51:53PM +0800, Tianyu Lan wrote:
> Hi Brijesh:

Do me a favor please and learn not to top-post on a public mailing list.
Also, take the time to read Documentation/process/ before you send
upstream patches and how to work with the community in general.

> We find this patch breaks AMD SEV support in the Hyper-V Isolation
> VM. Hyper-V code also uses sev_es_ghcb_hv_call() to read or write msr
> value. The sev_es_check_cpu_features() isn't called in the Hyper-V
> code and so the ghcb_version is always 0.

If hyperv is going to expose hypervisor features, then it better report
GHCB v2. If not, then I guess < 2 or 1 or so, depending on how this is
defined.

> Could you add a new parameter ghcb_version for sev_es_ghcb_hv_call()
> and then caller may input ghcb_version?

No, your hypervisor needs to adhere to the spec and report proper ghcb
version. We won't be doing any accomodate-hyperv hacks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
