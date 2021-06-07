Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5296539E755
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jun 2021 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFGTTt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Jun 2021 15:19:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhFGTTs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Jun 2021 15:19:48 -0400
Received: from zn.tnic (p200300ec2f0b4f0088b5a9d37dea41e8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:88b5:a9d3:7dea:41e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 857C91EC01DF;
        Mon,  7 Jun 2021 21:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623093475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ehln04p+pdRKYdvljTdVaV1hT2/TwzWAtZ5Bi9xJ3pM=;
        b=IiP6uM+6kRb7GZOxGl0o+S+6Ci9htoOXKscwvzrsIGqDdPFmm1AFoG4voddW2DSdf6S0hd
        61BYBoBQ1gt5WW84qB5anjzjpH5ZWJn5by0iw2r1F06SXbvvmENTPHu8QgC3TtH2uCBt5I
        wCUo2xFrQTPxBo3Pm6y8NncUCEFaJdg=
Date:   Mon, 7 Jun 2021 21:17:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Venu Busireddy <venu.busireddy@oracle.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 00/22] Add AMD Secure Nested Paging
 (SEV-SNP) Guest Support
Message-ID: <YL5w3N4baodLeIhi@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <YL5wSgektxdZPXZC@dt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YL5wSgektxdZPXZC@dt>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 07, 2021 at 02:15:22PM -0500, Venu Busireddy wrote:
> I could not find that commit (493a0d4559fd) either in
> git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git repo, or in
> git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git repo. Which
> repo can I use to apply this series?

Use the current tip/master, whichever it is, in the former repo.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
