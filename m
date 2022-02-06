Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A774AB05E
	for <lists+linux-efi@lfdr.de>; Sun,  6 Feb 2022 16:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiBFPqV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Feb 2022 10:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBFPqU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Feb 2022 10:46:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA9C06173B;
        Sun,  6 Feb 2022 07:46:19 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB7381EC032C;
        Sun,  6 Feb 2022 16:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644162374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I2ZGpe+v4nEY0jmVxtOXpQHTFNc9Pxn4PtQ3aRV2Qtc=;
        b=CzcdKA8p9YEvjhiMkLz+0axjH596hm96hf61Ug0DiAzxmxq/rAY/+rv8CDyZa2vlSc5JjM
        ZPo2fVWy148tDei8z8wsvYq9jNWZ+yI5KVCTDWmPBbGdMjx/hyzfSGtHgdPX7HpkdqxhXa
        FEwZlI0OUAR4cZVrZex7WvXBG3Y1J1E=
Date:   Sun, 6 Feb 2022 16:46:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
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
        Tobin Feldman-Fitzthum <tobin@ibm.com>, brijesh.singh@amd.com,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 38/43] x86/sev: Use firmware-validated CPUID for
 SEV-SNP guests
Message-ID: <Yf/tQPqbP97lrVpg@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-39-brijesh.singh@amd.com>
 <20220205171901.kt47bahdmh64b45x@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205171901.kt47bahdmh64b45x@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Feb 05, 2022 at 11:19:01AM -0600, Michael Roth wrote:
> I mentioned the concern you raised about out-of-spec hypervisors
> using non-zero for Reserved fields, and potentially breaking future
> guests that attempt to make use of them if they ever get re-purposed
> for some other functionality, but their take on that is that such a
> hypervisor is clearly out-of-spec, and would not be supported.

Yah, like stating that something should not be done in the spec is
going to stop people from doing it anyway. You folks need to understand
one thing: the smaller the attack surface, the better. And you need to
*enforce* that - not state it in a spec. No one cares about the spec
when it comes to poking holes in the architecture. And people do poke
and will poke holes *especially* in this architecture, as its main goal
is security.

> Another possibility is enforcing 0 in the firmware itself.

Yes, this is the thing to do. If they're going to be reused in the
future, then guests can be changed to handle that. Like we do all the
time anyway.

> So given their guidance on the Reserved fields, and your guidance
> on not doing the other sanity-checks, my current plan to to drop
> snp_check_cpuid_table() completely for v10, but if you have other
> thoughts on that just let me know.

Yes, and pls fix the firmware to zero them out, because from reading
your very detailed explanation - btw, thanks for taking the time to
explain properly what's not in the ABI doc:

https://lore.kernel.org/r/20220205154243.s33gwghqwbb4efyl@amd.com

it sounds like those two input fields are not really needed. So the
earlier you fix them in the firmware and deprecate them, the better.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
