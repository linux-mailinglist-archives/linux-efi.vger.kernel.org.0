Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810F43FECE4
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbhIBL1a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 07:27:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhIBL13 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 07:27:29 -0400
Received: from zn.tnic (p200300ec2f0ed1002d220efd52bc539e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:2d22:efd:52bc:539e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E179F1EC0528;
        Thu,  2 Sep 2021 13:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630581986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nZDBbNwW0kzPiqS/jH6ifLFLt5uI+iZ0TLZo07Wo180=;
        b=PVqkwqgxwkgB67Wb5b6iXPa5pJWSmTjnI/8EkkTlPxlHEXlvZhiVAYvl6uEAVRmlmYHbg3
        T4hS6EmZOtkeycXGzbvzamDU6UNpeyViICmVFuIUyYQckxeXgvZ5u9EcMhgOL3iLiEyxcS
        cHbsR20RNgm2UWY23Pl2ZCMPmOwcMPo=
Date:   Thu, 2 Sep 2021 13:26:56 +0200
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
Message-ID: <YTC1ANx81eQeGN4o@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com>
 <YSkxxkVdupkyxAJi@zn.tnic>
 <9e0e734d-7d2f-4703-b9ce-8362f0c740f4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e0e734d-7d2f-4703-b9ce-8362f0c740f4@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 30, 2021 at 10:07:39AM -0500, Brijesh Singh wrote:
> The SNP firmware spec says that counter must begin with the 1.

So put that in the comment and explain what 0 is: magic or invalid or
whatnot and why is that so and that it is spec-ed this way, etc.

Just having it there without a reasoning makes one wonder whether that's
some arbitrary limitation or so.

> During the GHCB writing the seqno use to be 32-bit value and hence the GHCB
> spec choose the 32-bit value but recently the SNP firmware changed it from
> the 32 to 64. So, now we are left with the option of limiting the sequence
> number to 32-bit. If we go beyond 32-bit then all we can do is fail the
> call. If we pass the value of zero then FW will fail the call.

That sounds weird again. So make it 64-bit like the FW and fix the spec.

> I just choose the smaller name but I have no issues matching with the spec.
> Also those keys does not have anything to do with the VMPL level. The
> secrets page provides 4 different keys and they are referred as vmpck0..3
> and each of them have a sequence numbers associated with it.
> 
> In GHCB v3 we probably need to rework the structure name.

You can point to the spec section so that readers can find the struct
layout there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
