Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805123EF435
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhHQUot (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 16:44:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39396 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhHQUos (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 16:44:48 -0400
Received: from zn.tnic (p200300ec2f117500b0ae8110978caeec.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:b0ae:8110:978c:aeec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72BF51EC054F;
        Tue, 17 Aug 2021 22:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629233048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kGYRnAMSLbjZ/FPl31T/5mLxunyqniOXuhCt9CoiNRU=;
        b=idhoqaoyNMw69THb+H9A2bvcCKeTLrJJEVDaSQEOLre37KzokOn5QvSNWIaUINNWyKXzfL
        zFyPuHjYKuUCSBTfF15vmrp6mLt5UlEQXw1zBkbpwbbgFtKjzb2XpHf60liU/yGOXA4AeB
        oQBWI2rcyv8ZFE0Nkd6kyFS0kkGo3J4=
Date:   Tue, 17 Aug 2021 22:44:48 +0200
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
Message-ID: <YRwfwCo4gwjWMbD0@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-16-brijesh.singh@amd.com>
 <YRvxZtLkVNda9xwX@zn.tnic>
 <d9aabcb8-9db2-838c-74c7-c0e759257d3f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9aabcb8-9db2-838c-74c7-c0e759257d3f@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 17, 2021 at 03:34:41PM -0500, Brijesh Singh wrote:
> I am not seeing any strong reason to sanity check the reserved bit in the
> psc_entry. The fields in the psc_entry are input from guest to the
> hypervisor. The hypervisor cannot trick a guest by changing anything in the
> psc_entry because guest does not read the hypervisor filled value. I am okay
> with the psc_hdr because we need to read the current and end entry after the
> PSC completes to determine whether it was successful and sanity checking PSC
> header makes much more sense. Let me know if you are okay with it ?

Ok, fair enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
