Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136243FC59F
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbhHaK0w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 06:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbhHaK0w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 06:26:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59191C061575;
        Tue, 31 Aug 2021 03:25:57 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f2f00d101edea3987ba94.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2f00:d101:edea:3987:ba94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C81011EC0301;
        Tue, 31 Aug 2021 12:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630405551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9au5Ib2D8iCGnkGnB5h3PrkkAHJSnmZMrsYQr2spPug=;
        b=C9MEtadGhn2B1d01Tkv0ATDV6t7XjHM984fM/2q3kBGB3rhHjyytvPa9psO9uFnqXWeish
        +TKIdvhUUZ8sWo9tk4LpibCf75wr3uxvGVDzgQcndXxIDGBH48JMykQ9sbPNT9Fo37TZYs
        sj4C/m3u/3wFVYeQJYytDYtNRle0188=
Date:   Tue, 31 Aug 2021 12:26:28 +0200
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
Subject: Re: [PATCH Part1 v5 30/38] x86/compressed/64: store Confidential
 Computing blob address in bootparams
Message-ID: <YS4D1A9Uy1TmNwmT@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-31-brijesh.singh@amd.com>
 <YSjzcgQDubOY1pGI@zn.tnic>
 <20210827190955.fc5eyvk2mmtuawwz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827190955.fc5eyvk2mmtuawwz@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 02:09:55PM -0500, Michael Roth wrote:
> Most of the #ifdef'ery is due to the EFI scan, so I moved that part out
> to a separate helper, snp_probe_cc_blob_efi(), that lives in
> boot/compressed.sev.c. Still not pretty, but would this be acceptable?

It is still ugly... :)

I guess you should simply do two separate functions - one doing the
compressed dance and the other the later parsing and keep 'em separate.
It's not like you're duplicating a ton of code so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
