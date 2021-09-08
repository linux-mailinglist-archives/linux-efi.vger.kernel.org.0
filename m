Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864F2403AE1
	for <lists+linux-efi@lfdr.de>; Wed,  8 Sep 2021 15:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhIHNpp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Sep 2021 09:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhIHNpo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Sep 2021 09:45:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE9EC061575;
        Wed,  8 Sep 2021 06:44:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efc003bde2e7441c2ae39.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fc00:3bde:2e74:41c2:ae39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2F9F1EC0354;
        Wed,  8 Sep 2021 15:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631108670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g4fdFT9TphduKbM4f8gqWCQfmgmAQk4nxlIef4GbtEo=;
        b=n7yul8HTwJlFp/yx7QkeuLuAqcNy1w6sC78Xa/KvUJ/p6ymPJmlKdKSwscxfKa9Jz3Ey5l
        mXyRjO9EfjkNGERJzM1tGCuR1wvUQelK+vzkRQCEZzNhrDDteBL2amE5o/9RdZOlLbk76f
        IrcezixdaotsLOtinE6VQs+cgQ77L1I=
Date:   Wed, 8 Sep 2021 15:44:22 +0200
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
Subject: Re: [PATCH Part1 v5 36/38] virt: Add SEV-SNP guest driver
Message-ID: <YTi+NgNW/iIKBfKL@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-37-brijesh.singh@amd.com>
 <YTZSAB5H9EC2uk8z@zn.tnic>
 <bb72ce36-19d3-e2df-fa51-3940e4e9118e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb72ce36-19d3-e2df-fa51-3940e4e9118e@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 07, 2021 at 08:35:13AM -0500, Brijesh Singh wrote:
> Unfortunately, the doc folks are replacing the current spec with the new,
> and previous URLs are no longer valid. I will spell out the spec version
> number so that anyone downloading the spec from bugzilla will able to locate
> it.

Yap, this is yet another example why we need a stable collection for
docs, outside of the vendor domains which change way too often and URLs
end up disappearing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
