Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE73E5C76
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 16:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhHJODN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhHJODM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Aug 2021 10:03:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61AC0613D3;
        Tue, 10 Aug 2021 07:02:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d650032a7c3e3b83a4c54.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:32a7:c3e3:b83a:4c54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43F6D1EC0236;
        Tue, 10 Aug 2021 16:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628604163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PVX/m13LlgW2RqeJado5fh0rRBijUO5c/y0yBM9F/DE=;
        b=JWZPzNZ/xGpf7iPnHSEAqrFCvp+lnaHI0oBVV2vKcj/Tog4CULHEumJH7s2bOwhs2geilQ
        oMRRacR8FZigRA1lDkloeXT5wLQCy9NaPsGi/3El21mNKEPpczb/tFxxXhvIzmBjiy9N3M
        z7uLILiZ+jAyP/muqU7zSEgv5peuAIk=
Date:   Tue, 10 Aug 2021 16:03:27 +0200
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
Subject: Re: [PATCH Part1 RFC v4 03/36] x86/sev: Add support for hypervisor
 feature VMGEXIT
Message-ID: <YRKHLwrV1Q1oG9Nn@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-4-brijesh.singh@amd.com>
 <YRJha2XSZo3u7KIr@zn.tnic>
 <a95a7b8f-fb86-62ce-0900-66761771a0ca@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a95a7b8f-fb86-62ce-0900-66761771a0ca@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 10, 2021 at 08:39:02AM -0500, Brijesh Singh wrote:
> I was thinking that some driver may need it in future, but nothing in my
> series needs it yet. I will drop it and we can revisit it later.

Yeah, please never do such exports in anticipation.

And if we *ever* need them, they should be _GPL ones - not
EXPORT_SYMBOL. And then the API needs to be discussed and potentially
proper accessors added instead of exporting naked variables...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
