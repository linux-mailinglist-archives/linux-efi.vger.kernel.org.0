Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841C8474B8E
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhLNTKR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Dec 2021 14:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhLNTKQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Dec 2021 14:10:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCFFC061574;
        Tue, 14 Dec 2021 11:10:16 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C80461EC02AD;
        Tue, 14 Dec 2021 20:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639509010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DI2vukmIvxeB24qycMTvikeEQ9/5m2LSUmK7BFY/UXc=;
        b=iYY1nA/6HMelMQmtlpVuYveRU5HkIKZWb/btW1eVmU8/1GVzhoLzagRE2znZsMCw1LsF4x
        Sy+YxuDjLUl1PYTFSjvZRBrffZF00IUbhZUYVe8ceJtpeQ2+GFh1DPllxpKzX7R8OySXr6
        bLYmZvn3Lo8z7CwK9yueRQyYm37ePi0=
Date:   Tue, 14 Dec 2021 20:10:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Venu Busireddy <venu.busireddy@oracle.com>
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YbjsGHSUUwomjbpc@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbjYZtXlbRdUznUO@dt>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 14, 2021 at 11:46:14AM -0600, Venu Busireddy wrote:
> What I am suggesting should not have anything to do with the boot stage
> of the kernel.

I know exactly what you're suggesting.

> For example, both these functions call native_cpuid(), which is declared
> as an inline function. I am merely suggesting to do something similar
> to avoid the code duplication.

Try it yourself. If you can come up with something halfway readable and
it builds, I'm willing to take a look.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
