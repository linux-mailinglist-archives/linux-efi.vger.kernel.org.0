Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A44AC8D0
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 19:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiBGSqg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 13:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiBGSnO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 13:43:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1835AC0401DC;
        Mon,  7 Feb 2022 10:43:13 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24AE01EC02B9;
        Mon,  7 Feb 2022 19:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644259387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SZEc3K4WUssJFPuRZM4cYUdq0EX2pDa+Q3YePuI1VGc=;
        b=qmClInz1dKwfOZbiO2QrY2gZK/xZolImE900/WaPmxRFwwOa2cp3K4OMeOEJsTi80Hu4Qp
        G43sMx+xX8AUxdLvcgTvewjlRnNRSbTkdwsgOZ6e9vtHFY+GtTdk9DIq09oCjIgK1EE+5Z
        CRyqtdz0t/QXSU+RToQpc+wZ3krqc2c=
Date:   Mon, 7 Feb 2022 19:43:01 +0100
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
Message-ID: <YgFoNeASrXizWMIa@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-39-brijesh.singh@amd.com>
 <20220205171901.kt47bahdmh64b45x@amd.com>
 <Yf/tQPqbP97lrVpg@zn.tnic>
 <20220207170018.sg37idc6nzlzgj6p@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220207170018.sg37idc6nzlzgj6p@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 07, 2022 at 11:00:18AM -0600, Michael Roth wrote:
> this is more a statement that an out-of-spec hypervisor should not
> expect that their guests will continue working in future firmware
> versions, and what's being determined here is whether to break
> those out-of-spec hypervisor now, or later when/if we actually
> make use of the fields in the guest code,

I think you're missing a very important aspect here called reality.

Let's say that HV is a huge cloud vendor who means a lot of $ and a
huge use case for SEV tech. And let's say that same HV is doing those
incompatible things.

Now imagine you break it with the spec change. But they already have
a gazillion of deployments on real hw which they can't simply update
just like that. Hell, cloud vendors are even trying to dictate how CPU
vendors should do microcode updates on a live system, without rebooting,
and we're talking about some wimpy fields in some table.

Now imagine your business unit calls your engineering and says, you need
to fix this because a very persuasive chunk of money.

What you most likely will end up with is an ugly ugly workaround after a
lot of managers screaming at each other and you won't even think about
breaking that HV.

Now imagine you've designed it the right and unambiguous way from the
getgo. You wake up and realize, it was all just a bad dream...

> Ok, I'll follow up with the firmware team on this. But just to be clear,
> what they're suggesting is that the firmware could enforce the MBZ checks
> on the CPUID page, so out-of-spec hypervisors will fail immediately,
> rather than in some future version of the spec/cpuid page, and guests
> can continue ignoring them in the meantime.

Yes, exactly. Fail immediately.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
