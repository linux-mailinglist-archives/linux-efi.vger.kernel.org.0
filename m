Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98B44C6F7
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 19:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhKJSrQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 13:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhKJSq4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Nov 2021 13:46:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C74C06120E;
        Wed, 10 Nov 2021 10:44:08 -0800 (PST)
Received: from zn.tnic (p200300ec2f111e00f6c7178ba52ca674.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1e00:f6c7:178b:a52c:a674])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C01551EC0529;
        Wed, 10 Nov 2021 19:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636569846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C2VOLfmvL9L0orajbDbFzDBlQB82yHKAfIoIPQsHwAc=;
        b=VDuO+2n5Q4g0soTuNocoR45e46tiy9TDeRzGik3lHMNjnRD9uQhO4dlPkWbAtwc4lkoPeS
        vFCQpLvnUi5kmukfhsnFhL/G0/zNJhgBHrg8TlSWs59ed8ytsQFLhbJ687F/hUcYodJw4Z
        zAOdxjE5tQGFJkJMn8ubDa5uRWi+Ptw=
Date:   Wed, 10 Nov 2021 19:43:59 +0100
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
Subject: Re: [PATCH v6 19/42] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YYwS74PbHfNuAGQ7@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-20-brijesh.singh@amd.com>
 <YYrNL7U07SxeUQ3E@zn.tnic>
 <4ea63467-3869-b6f5-e154-d70d1033135b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ea63467-3869-b6f5-e154-d70d1033135b@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 08:21:21AM -0600, Brijesh Singh wrote:
> I am assuming you mean add some compile time check to ensure that desc will
> fit in the shared buffer ?

No:

struct ghcb {

	...

        u8 shared_buffer[2032];

so that memcpy needs to do:

	memcpy(ghcb->shared_buffer, desc, min_t(int, 2032, sizeof(*desc)));

with that 2032 behind a proper define, ofc.

> I can drop the overlap comment to avoid the confusion, as you pointed it
> more of the future thing. Basically overlap is the below condition
> 
> set_memory_private(gfn=0, page_size=2m)
> set_memory_private(gfn=10, page_size=4k)
> 
> The RMPUPDATE instruction will detect overlap on the second call and return
> an error to the guest. After we add the support to track the page validation
> state (either in bitmap or page flag), the second call will not be issued
> and thus avoid an overlap errors. For now, we use the page_size=4k for all
> the page state changes from the kernel.

Yah, sounds like the comment is not needed now. You could put this in
the commit message, though.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
