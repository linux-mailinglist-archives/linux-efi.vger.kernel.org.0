Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4843686D
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhJUQ5i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJUQ5f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Oct 2021 12:57:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58085C061764;
        Thu, 21 Oct 2021 09:55:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1912009d2c3fdc96041a10.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:1200:9d2c:3fdc:9604:1a10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D38931EC01A2;
        Thu, 21 Oct 2021 18:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634835316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NZC8US/Sv4tJlK40hZBif2dVgLRnPir3aaoTZ1GDAZU=;
        b=WHEsNVOkCfiljBtHQ+4j3sgg9oxZ3XZ72tD3ReWZxsnZaE/K+hn3pPlrNc4ezF6zzThzeP
        8uO+2w9FCg5R7ThkyJVSmryvGtbiYy6FJ/oU2mo0Q79kmHu9yDrhX6FkfpM7SaeFV28BYj
        780hS9v0CwyRqL9Zmq9JMbWXRvTUsWM=
Date:   Thu, 21 Oct 2021 18:55:14 +0200
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
Message-ID: <YXGbcqN2IRh9YJk9@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF9sCbPDsLwlm42@zn.tnic>
 <YXGNmeR/C33HvaBi@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXGNmeR/C33HvaBi@work-vm>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 21, 2021 at 04:56:09PM +0100, Dr. David Alan Gilbert wrote:
> I can imagine a malicious hypervisor trying to return different cpuid
> answers to different threads or even the same thread at different times.

Haha, I guess that will fail not because of SEV* but because of the
kernel not really being able to handle heterogeneous CPUIDs.

> Well, the spec (AMD 56860 SEV spec) says:
> 
>   'If firmware encounters a CPUID function that is in the standard or extended ranges, then the
> firmware performs a check to ensure that the provided output would not lead to an insecure guest
> state'
> 
> so I take that 'firmware' to be the PSP; that wording doesn't say that
> it checks that the CPUID is identical, just that it 'would not lead to
> an insecure guest' - so a hypervisor could hide any 'no longer affected
> by' flag for all the CPUs in it's migration pool and the firmware
> shouldn't complain; so it should be OK to pessimise.

AFAIU this, I think this would depend on "[t]he policy used by the
firmware to assess CPUID function output can be found in [PPR]."

So if the HV sets the "no longer affected by" flag but the firmware
deems this set flag as insecure, I'm assuming the firmare will clear
it when it returns the CPUID leafs. I guess I need to go find that
policy...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
