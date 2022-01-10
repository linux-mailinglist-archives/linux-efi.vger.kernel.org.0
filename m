Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CA48A208
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 22:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbiAJVjD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 16:39:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345005AbiAJVjA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Jan 2022 16:39:00 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 508751EC057F;
        Mon, 10 Jan 2022 22:38:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641850734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QYUGUNXbmi2LdCdOvBCW683CHHlfPmzfKCrYmMAw9b8=;
        b=AryriMF3Iwldr2mWy2ARgb8hyWf3UhlZMIf9kUaHLNz4efSeZCFm2kCH8g1kVElpvWvJCs
        7j7NmWya16FgP0tWJA3Su8wYz1lPuQGO9Rqbo4Q0ABjrOveVTh+WqPkMcw0P3PoInvv+8n
        q1kU9ZKn6e1zg1s9H/d0XmdtMW8ZhAc=
Date:   Mon, 10 Jan 2022 22:38:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Venu Busireddy <venu.busireddy@oracle.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YdynctN1UKuEqDmF@zn.tnic>
References: <20211215174934.tgn3c7c4s3toelbq@amd.com>
 <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic>
 <20211215201734.glq5gsle6crj25sf@amd.com>
 <YbpSX4/WGsXpX6n0@zn.tnic>
 <20211215212257.r4xisg2tyiwdeleh@amd.com>
 <YdNKIOg+9LAaDDF6@dt>
 <5913c603-2505-7865-4f8e-2cbceba8bd12@amd.com>
 <1148bed5-29dc-04b2-591b-c7ef2d2664c7@amd.com>
 <YdyihO2pEE/MWsIT@dt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdyihO2pEE/MWsIT@dt>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 10, 2022 at 03:17:56PM -0600, Venu Busireddy wrote:
> Can't we do that rework (if any) as and when it is needed? I am worried
> that we will never get this in!

In case you've missed it from a previous mail on that same thread:

"But this unification is not super-pressing so it can go ontop of the
SNP pile."

So such cleanups go ontop, when the dust settles and when we realize
that there really are parts which can be unified. Right now, everything
is moving so first things first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
