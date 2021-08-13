Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC033EBA1A
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhHMQcS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbhHMQcR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Aug 2021 12:32:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679CFC061756;
        Fri, 13 Aug 2021 09:31:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a0d00fd43514a4e38f781.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:fd43:514a:4e38:f781])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D3041EC01A9;
        Fri, 13 Aug 2021 18:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628872304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NdcAaQ22ajLR1RVBUmtY/+BY0x+jRUM1hOLQmWgEtUs=;
        b=PyDgosI4i/QB5H11RsoENB8QrV6viOuQxdZz6jMCz6J5QLBtV8lyslxjQ5R8YQC5/Bst2i
        l5mSrdzRZcTOoBq0b3dpee2je9Id2FcVSPRpTor4k9w4j5ddcW2LE1l8uHcCSR0KhqE/Vf
        bPxKuiRZ0l//nG4r1Su9bwSs5SsiPqw=
Date:   Fri, 13 Aug 2021 18:32:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH Part2 RFC v4 33/40] KVM: SVM: Add support to handle MSR
 based Page State Change VMGEXIT
Message-ID: <YRael/GphmsQk36u@zn.tnic>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-34-brijesh.singh@amd.com>
 <YPHzcstus9mS8hOm@google.com>
 <b9527f12-f3ad-c6b9-2967-5d708d69d937@amd.com>
 <YPXKuiRCjod8Wn2n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPXKuiRCjod8Wn2n@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 19, 2021 at 06:55:54PM +0000, Sean Christopherson wrote:
> I've no objection to using PSC for enums and whatnot, and I'll happily
> defer to Boris for functions in the core kernel and guest, but for KVM
> I'd really like to spell out the name for the two or so main handler
> functions.

Well,

- we abbreviate things in the kernel all the time - this is no
exception. We don't name it

	secure_nested_paging_handle_page_state_change()

either. :-)

- If you don't know what PSC means, now you do :-P Also, comments above
the function names help.

- I asked for the shortening because those function names were a
mouthful and when you see

snp_handle_page_state_change()

I wonder, it is "handling", is it "changing" or what is it doing. And
the page state change is a thing so the "handle" is important here. Thus
the

snp_handle_psc()

variant.

Also, shorter function names make the code more readable. I'm sure
you've read firmware code or other OS code before to understand what I
mean.

Anyway, I felt I should give my arguments why I requested the
shortening.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
