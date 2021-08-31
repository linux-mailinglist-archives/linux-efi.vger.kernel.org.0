Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC03FC416
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbhHaIDi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 04:03:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33872 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240134AbhHaIDg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 04:03:36 -0400
Received: from zn.tnic (p200300ec2f0f2f00e5150ccccff88358.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2f00:e515:ccc:cff8:8358])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADB021EC050D;
        Tue, 31 Aug 2021 10:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630396955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+Hzu0yamQhg+NF0YFQ2l8T9eIMH/KofAiCkpDBBtktU=;
        b=VeIJeDe1YeYq7fFcAdVoI5uWnR5kZeO3gHSjdm7P0w2zseJrdTyLkmnLIxDVAPlI2AsiSY
        A+LccssbTECpYseBuznoG4ooAs7HrnywRA7Kz+fsPvyHpK3v02E9EVPNp3Epjm4MuGNrOk
        apXrBYO+XWahTfw18+1NXcVGqOgDrYI=
Date:   Tue, 31 Aug 2021 10:03:12 +0200
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <YS3iCqSY2vEmmkQ+@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
 <YSZTubkROktMMSba@zn.tnic>
 <20210825151835.wzgabnl7rbrge3a2@amd.com>
 <YSZv632kJKPzpayk@zn.tnic>
 <20210827133831.xfdw7z55q6ixpgjg@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827133831.xfdw7z55q6ixpgjg@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 08:38:31AM -0500, Michael Roth wrote:
> I've been periodically revising/rewording my comments since I saw you're
> original comments to Brijesh a few versions back, but it's how I normally
> talk when discussing code with people so it keeps managing to sneak back in.

Oh sure, happens to me too and I know it is hard to keep out but when
you start doing git archeology and start going through old commit
messages, wondering why stuff was done the way it is sitting there,
you'd be very grateful if someone actually took the time to write up the
"why" properly. Why was it done this way, what the constraints were,
yadda yadda.

And when you see a "we" there, you sometimes wonder, who's "we"? Was it
the party who submitted the code, was it the person who's submitting the
code but talking with the generic voice of a programmer who means "we"
the community writing the kernel, etc.

So yes, it is ambiguous and it probably wasn't a big deal at all when
the people writing the kernel all knew each other back then but that
long ain't the case anymore. So we (see, snuck in on me too :)) ... so
maintainers need to pay attention to those things now too.

Oh look, the last "we" above meant "maintainers".

I believe that should explain with a greater detail what I mean.

:-)

> I've added a git hook to check for this and found other instances that need
> fixing as well, so hopefully with the help of technology I can get them all
> sorted for the next spin.

Thanks, very much appreciated!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
