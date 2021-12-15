Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681DC476374
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 21:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhLOUjA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 15:39:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236138AbhLOUi7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 15:38:59 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECE161EC0521;
        Wed, 15 Dec 2021 21:38:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639600734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=38LOASUbOxitabwqSnlHmtZ4CPFEE2iObHtY//Knd18=;
        b=mA+UjtaxSHPgzi76OhlpEPn2l9W7pmBEEhSJhJPcBMs+30+5XZKiSotujmWQlxjQw/Agry
        VbfCf0I6JSgAFL3mrz1F7Z1bjgaoUCdVETfXmR29d/yHvSzF4QSJZSTsyoiEKoNUj5SnmX
        HxyqHwCnm3uX6+RUzcIy+cKr16Vfdys=
Date:   Wed, 15 Dec 2021 21:38:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Venu Busireddy <venu.busireddy@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
Message-ID: <YbpSX4/WGsXpX6n0@zn.tnic>
References: <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
 <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic>
 <20211215201734.glq5gsle6crj25sf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211215201734.glq5gsle6crj25sf@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 02:17:34PM -0600, Michael Roth wrote:
> and if fields are added in the future:
> 
>   sev_parse_cpuid(AMD_SEV_BIT, &me_bit_pos, &vte_enabled, &new_feature_enabled, etc..)

And that will end up being a vararg function because of who knows what
other feature bits will have to get passed in? You have even added the
ellipsis in there.

Nope. Definitely not.

> or if that eventually becomes unwieldly 

The above example is already unwieldy.

> it could later be changed to return a feature mask.

Yes, that. Clean and simple.

But it is hard to discuss anything without patches so we can continue
the topic with concrete patches. But this unification is not
super-pressing so it can go ontop of the SNP pile.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
