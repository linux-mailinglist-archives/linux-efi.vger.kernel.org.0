Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8978C3FEC9D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhIBLGP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhIBLGP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 07:06:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F2C061575;
        Thu,  2 Sep 2021 04:05:16 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ed100d115725f57e7001c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:d115:725f:57e7:1c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 400421EC0528;
        Thu,  2 Sep 2021 13:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630580711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qrih5nOxCt8KX8+xxQwcW009cmgk6NbkNVdkRjjSG0s=;
        b=Uo+t/oIfbI8rJlB3MWNOvzZBGwQz2x6Er54vJvC277hf/75pt4jxpEm/nVpzSFsIiiCVRj
        X+1ltV5NAxwh0jq60Oy/XIYQGVQJUYNxs/WGRGxHh4CvYPmfUojTxRx0jeCLu0+AMj3jyX
        TFzVyb8+6qw4WI6Pkct1YFlXl2Gfz4w=
Date:   Thu, 2 Sep 2021 13:05:45 +0200
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
Message-ID: <YTCwCZr5KZXd8bsG@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com>
 <YSkCWVTd0ZEvphlx@zn.tnic>
 <20210827183240.f7zvo3ujkeohmlrt@amd.com>
 <YS5XVBNrASp7Zrig@zn.tnic>
 <20210901011658.s4hgmvbptgseqcm3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901011658.s4hgmvbptgseqcm3@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 31, 2021 at 08:16:58PM -0500, Michael Roth wrote:
> What did you think of the suggestion of defining it in sev-shared.c
> as a static buffer/struct as __ro_after_init? It would be nice to
> declare/reserve the memory in one place. Another benefit is it doesn't
> need to be exported, and could just be local with all the other
> snp_cpuid* helpers that access it in sev-shared.c

Yap.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
