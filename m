Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664F7428918
	for <lists+linux-efi@lfdr.de>; Mon, 11 Oct 2021 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhJKIuf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Oct 2021 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbhJKIue (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Oct 2021 04:50:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9294C061570;
        Mon, 11 Oct 2021 01:48:34 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08bb008041f0293f2a9501.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:8041:f029:3f2a:9501])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8ED011EC01CE;
        Mon, 11 Oct 2021 10:48:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633942112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WX7Mv16IItiWUhDYtgsQ58XhYcnYoY2/nQSVZ23QgEg=;
        b=Ue70iMsndjsy737r0a//5qQ1NU65dolZ0oHJYGSTMEMzKT3itfDJfBtMRSqYuWrKViHFS3
        2eZO2GQS2SA1qZ6pyQ0CvE9ttnnQNX3/j6ygLUtSzi8mRTaSJD9CRoohuRLpaGHYGxN4Xf
        nQqfHtGyOog15JWmfroRpy+iRXtWPqk=
Date:   Mon, 11 Oct 2021 10:48:28 +0200
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v6 03/42] x86/sev: Get rid of excessive use of defines
Message-ID: <YWP6XDbbqyWalbSa@zn.tnic>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-4-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180453.462291-4-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 08, 2021 at 01:04:14PM -0500, Brijesh Singh wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Remove all the defines of masks and bit positions for the GHCB MSR
> protocol and use comments instead which correspond directly to the spec
> so that following those can be a lot easier and straightforward with the
> spec opened in parallel to the code.
> 
> Aligh vertically while at it.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

When you handle someone else's patch, you need to add your SOB
underneath to state that fact. I'll add it now but don't forget rule as
it is important to be able to show how a patch found its way upstream.

Like you've done for the next patch. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
