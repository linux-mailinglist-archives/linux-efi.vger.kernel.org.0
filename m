Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4EF3E85B1
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhHJVwO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 17:52:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53452 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234545AbhHJVwN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 17:52:13 -0400
Received: from zn.tnic (p200300ec2f0d6500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95C511EC0347;
        Tue, 10 Aug 2021 23:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628632305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bhrvSWnua4QgXGDLToC7m7WROlxA3VPxoYeGWv6d9b4=;
        b=p7oMu+RhNEK0R7x19i+M996JIz9jAolp9gSi95HKMhewjNccujQhOtGEXBac5xmuyWnoQ8
        VtNpb/aUb4bne0yLrWo++9p6EawNSD7KAttCXyDPqb0UwUAg1MTrP2eFAOM1Zm3RyuHGj4
        2kVcVvuDB8EtlmSykCB6fmc5ev+4LKM=
Date:   Tue, 10 Aug 2021 23:52:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 05/36] x86/sev: Define the Linux specific
 guest termination reasons
Message-ID: <YRL1GSmdJhoUCXZv@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-6-brijesh.singh@amd.com>
 <YRJkDhcbUi9xQemM@zn.tnic>
 <955b4f50-5a7b-8c60-d31e-864bc29638f5@amd.com>
 <65c53556-94e1-b372-7fb1-64bb78c7ae15@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65c53556-94e1-b372-7fb1-64bb78c7ae15@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 10, 2021 at 02:30:44PM -0500, Tom Lendacky wrote:
> IIRC, during the review of the first GHCB version there was discussion
> about assigning reason sets outside of 0 within the spec and the overall
> feeling was to not do that as part of the spec.
> 
> We can re-open that discussion for the next version of the GHCB document.

My worry is that if nothing documents which sets are allocated to which
vendor, it'll become a mess.

Imagine a Linux SNP guest and a windoze one, both running on a KVM
hypervisor (is that even possible?) and both using the same termination
reason set with conflicting reason numbers.

Unneeded confusion.

Unless the spec says, "reason set 1 is allocated to Linux, set 2 to
windoze, etc"

Then all know which is which.

And so on...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
