Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD3492B53
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 17:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbiARQey (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 11:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbiARQex (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Jan 2022 11:34:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE4C061574;
        Tue, 18 Jan 2022 08:34:53 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D29021EC056A;
        Tue, 18 Jan 2022 17:34:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642523687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xK1Ruqt0Z3LpMS/GeIOUADQcueEO2vAcwQe8tnfengs=;
        b=bIZs6T3eRL29/2uilP6w7Rm92gPfcnQp2vi0QmpTHCgNpF01xtADYy6ZJfaiUEkVQxQ7rz
        tTfqeCf214MnTZxLlL7syAvWgctc20H4w+1cxhqAXyOfZEU72KaDQPbBJ7erwJXEqkWN4y
        xfQn8rJrSZmZg3PGrtGbOaU4fct01Es=
Date:   Tue, 18 Jan 2022 17:34:49 +0100
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
Subject: Re: [PATCH v8 29/40] x86/compressed/64: add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <YebsKcpnYzvjaEjs@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118143730.wenhm2bbityq7wwy@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 08:37:30AM -0600, Michael Roth wrote:
> Actually, no, because doing that would provide hypervisor a means to
> effectively disable CPUID page for an SNP guest by provided a table with
> count == 0, which needs to be guarded against.

Err, I'm confused.

Isn't that "SEV-SNP guests will be provided the location of special
'secrets' 'CPUID' pages via the Confidential Computing blob..." and the
HV has no say in there?

Why does the HV provide the CPUID page?

And when I read "secrets page" I think, encrypted/signed and given
directly to the guest, past the HV which cannot even touch it.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
