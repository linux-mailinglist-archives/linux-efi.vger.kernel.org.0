Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08C33EF19B
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhHQSRk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 14:17:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46944 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhHQSRk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 14:17:40 -0400
Received: from zn.tnic (p200300ec2f1175006a73053df3c19379.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:6a73:53d:f3c1:9379])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AA421EC0556;
        Tue, 17 Aug 2021 20:17:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629224221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XxZOJFQ4/UtYMMPE2hte00+BJM98D2VDLNtyNZE78CM=;
        b=BsBVJFBSgu8Iv+F/GHrHfxj/N39ok4iLAd9NnK//E2y4h0hIzNsuRbvYJV5enGEYZ+ladi
        EEOmWDLqlrqST8OrYcF6YjXH7HODiN1sGhL6u9ylqdwKxjmjnHWbnQyWax69Htj3T+/Osz
        CFyip7AO9eYqt6jCKmskrU3WvMimYlk=
Date:   Tue, 17 Aug 2021 20:17:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 15/36] x86/mm: Add support to validate
 memory when changing C-bit
Message-ID: <YRv9RNfvB+4ikmkw@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-16-brijesh.singh@amd.com>
 <YRvxZtLkVNda9xwX@zn.tnic>
 <162d75ca-f0ec-bb7e-bb47-70060772a52c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162d75ca-f0ec-bb7e-bb47-70060772a52c@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 17, 2021 at 01:07:40PM -0500, Brijesh Singh wrote:
> > > +	if (!desc)
> > > +		panic("failed to allocate memory");
> > 
> > Make that error message more distinctive so that *if* it happens, one
> > can pinpoint the place in the code where the panic comes from.
> > 
> 
> Now I am running checkpatch and notice that it complain about the message
> too. I can add a BUG() or WARN() to get the stack trace before the crashing.

checkpatch complains because there's a kmalloc before it and if it
fails, the mm core will issue a warning so there's no need for a warning
here.

But in this case, you want to panic and checkpatch doesn't see that so
you can ignore it here and leave the panic message but make it more
distinctive so one can find it by grepping. IOW, something like

	if (!desc)
		panic("SEV-SNP: Failed to allocame memory for PSC descriptor");

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
