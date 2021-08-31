Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A873FCB71
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbhHaQXK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 12:23:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50868 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239733AbhHaQXK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 12:23:10 -0400
Received: from zn.tnic (p200300ec2f0f2f00fdddcaa5e3f9e694.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2f00:fddd:caa5:e3f9:e694])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53D851EC01B5;
        Tue, 31 Aug 2021 18:22:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630426929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pJLc4Nr2FSbY+5utp8zq0cqJuoQnIBsw2l3U+d3olSs=;
        b=OG2MmH57Xx0+9u8ejAjkuvOP+tpM08VxofHGL0MJDMGrKoMdpsPtFuWCKWBH3KhkdjY5dR
        q04iSVWqzy2Mb06ywIkrzyJ5B5weBNc36UQmvjpJ6W6e412ErBjN16s9Q7SaeuWeoRm2Jc
        puWQRQUhEU3pSfl/bw2Jv4OLgnedFsQ=
Date:   Tue, 31 Aug 2021 18:22:44 +0200
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
Subject: Re: [PATCH Part1 v5 32/38] x86/sev: enable SEV-SNP-validated CPUID
 in #VC handlers
Message-ID: <YS5XVBNrASp7Zrig@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com>
 <YSkCWVTd0ZEvphlx@zn.tnic>
 <20210827183240.f7zvo3ujkeohmlrt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827183240.f7zvo3ujkeohmlrt@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 01:32:40PM -0500, Michael Roth wrote:
> If the memory is allocated in boot/compressed/mem_encrypt.S, wouldn't
> kernel proper still need to create a static buffer for its copy?

Just like the other variables like sme_me_mask etc that file allocates
at the bottom. Or do you have a better idea?

> Would that be a reasonable approach for v6?

I don't like the ifdeffery one bit, TBH. I guess you should split it
and have a boot/compressed page and a kernel proper one and keep 'em
separate. That should make everything nice and clean at the cost of 2*4K
which is nothing nowadays.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
