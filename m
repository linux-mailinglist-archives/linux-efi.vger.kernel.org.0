Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A604546F4
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 14:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKQNO3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 08:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhKQNO2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 08:14:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E627C061570;
        Wed, 17 Nov 2021 05:11:30 -0800 (PST)
Received: from zn.tnic (p200300ec2f13a300a559e3e7ac095ca4.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a300:a559:e3e7:ac09:5ca4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8086E1EC051E;
        Wed, 17 Nov 2021 14:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637154688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ALEk0hpWexx1uJP+VlOkANLAH949xQs8c0lPv5drCRk=;
        b=eE5HYa8PJYy2qraGlEjSQ3OwljdXLGSLLo/wYzi+AKx+gDrhTQil/J35E0iAq2850IYc/p
        z7Ihif2mEgnblXMZbsWL5Q5Ql9Ab1Ep9l7ZHeWAVVQyVdMdZ9qdO4jqhu5RvNGtF5evPaS
        8h9ClG6c2q0yv1sMhabGOXo+3zZN0AU=
Date:   Wed, 17 Nov 2021 14:11:20 +0100
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
Subject: Re: [PATCH v7 02/45] x86/sev: detect/setup SEV/SME features earlier
 in boot
Message-ID: <YZT/eBLQnQOVejzp@zn.tnic>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-3-brijesh.singh@amd.com>
 <YZKxCdhaFTTlSHAJ@zn.tnic>
 <20211115201715.gv24iugujwhxmrdp@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211115201715.gv24iugujwhxmrdp@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 15, 2021 at 02:17:15PM -0600, Michael Roth wrote:
> but in order for that to happen soon enough to make use of the CPUID
> table for all CPUID intructions, it needs to be moved to just after the first
> #VC handler is setup (where snp_cpuid_init() used to be in v6).

So, it needs to happen after the initial IDT is loaded on the BSP in
startup_64_setup_env().

So why don't you call sme_enable() right after the
startup_64_setup_env() call and add a comment above it to explain why
this call needs to happen there?

Instead of sticking that call in startup_64_setup_env() where it doesn't
belong conceptually - enabling SME doesn't really have anything to do
with setting up early environment...

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
