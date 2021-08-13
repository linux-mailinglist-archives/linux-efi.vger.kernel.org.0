Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E418A3EB8F7
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhHMPSc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 11:18:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45364 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241781AbhHMPQk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Aug 2021 11:16:40 -0400
Received: from zn.tnic (p200300ec2f0a0d0070a51027a6cfb94b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:70a5:1027:a6cf:b94b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90F391EC01A8;
        Fri, 13 Aug 2021 17:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628867765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcZRb7fN3hFtAKCXxg7x6SSxBo6yLJXq3dd1LH5J27A=;
        b=Clc8p7koFJ+GJJXpijQCzMHuLwybz/LyKXR0HDs+oqj3CwGY5tNTpH+j+U/fF+kI9y3oIf
        DLgkSPeZps+chyUHErsdpd71tlyGXnxpRP1mexeir7y8per+tlAF/7FEHY0maGC2sfT0nL
        jFaiheSWsQhftC/35TNt3MLwEerRIm4=
Date:   Fri, 13 Aug 2021 17:16:48 +0200
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
Subject: Re: [PATCH Part1 RFC v4 08/36] x86/sev: check the vmpl level
Message-ID: <YRaM4LK/mQS+/pOm@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-9-brijesh.singh@amd.com>
 <YRYegqsigZfrbFbk@zn.tnic>
 <bd5b8826-ab0b-4f4f-8594-0c7e6232941a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd5b8826-ab0b-4f4f-8594-0c7e6232941a@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 13, 2021 at 08:13:20AM -0500, Brijesh Singh wrote:
> During the firmware initialization the PSP requires that the VMPLEn is
> set. See SNP firmware spec [1] section 8.6. To run the SNP guest you
> *must* specify a VMPL level during the vCPU creation.

Yes, that's why I said "implicit VMPL level 0"! When you don't specify
it, it should implied as 0.

Right now that "enable" bit is useless as it is *forced* to be enabled.

I sincerely hope querying the VMPL level is going to be made
straight-forwaed in future versions.

> I should not say its optional when we know from the SEV-SNP spec that
> VMPLEn must be set to launch SEV-SNP guest. I will fix the description.

It probably wasn't required when that bit was invented - why would you
call it "enable" otherwise - but some decision later made it required,
I'd guess.

> There is no easy way for a guest to query its VMPL level.

Yes, and there should be.

> The VMPL level is set during the vCPU creation. The boot cpu is
> created by the HV and thus its VMPL level is set by the HV. If HV
> chooses a lower VMPL level for the boot CPU then Linux guest will
> not be able to validate its memory because the PVALIDATE instruction
> will cause #GP when the vCPU is running at !VMPL0. The patch tries to
> detect the boot CPU VMPL level and terminate the boot.

I figured as much. All I don't like is the VMPL checking method.

> If guest is not running at VMPL0 then step #2 will cause #GP.  The check
> is prevent the #GP and terminate the boot early.

Yah, Tom helped me understand the design of the permission masks in the
RMP on IRC.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
