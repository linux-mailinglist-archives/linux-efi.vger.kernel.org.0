Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525574B3C7A
	for <lists+linux-efi@lfdr.de>; Sun, 13 Feb 2022 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiBMRVn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Feb 2022 12:21:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiBMRVm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Feb 2022 12:21:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC6517F9;
        Sun, 13 Feb 2022 09:21:36 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A0361EC02B9;
        Sun, 13 Feb 2022 18:21:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644772891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ufk7PMLyTSC7SBB9XUxAFhjH4Ne7SBwgRzzji7hMfcE=;
        b=CYZeT4CQKL7MRLKnjYmoY+MrvzzIwtQO7Us+DR5MjPMTd5AbVP5oiKrp1s6sRjnBgNs5uv
        6HtIX8+MjLS6QIqU7GMB9UEaOxVQ7ZeR1NcgdtSiQgaPLpmCPWo3P3LD//xF6qeNNhmSkH
        ANF2rfVktTKli3h1ArNCrCoJMi370SM=
Date:   Sun, 13 Feb 2022 18:21:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <Ygk+HQgeRIwgZ/nt@zn.tnic>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
 <YgZ427v95xcdOKSC@zn.tnic>
 <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com>
 <Ygj2Wx6jtNEEmbh9@zn.tnic>
 <7712e67b-f1c4-b818-ce20-b37e2a0e329b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7712e67b-f1c4-b818-ce20-b37e2a0e329b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 13, 2022 at 08:50:48AM -0600, Tom Lendacky wrote:
> I think there were a lot of assumptions that only SME/SEV would set
> sme_me_mask and that is used, for example, in the cc_platform_has() routine
> to figure out whether we're AMD or Intel. If you go the cc_mask route, I
> think we'll need to add a cc_vendor variable that would then be checked in
> cc_platform_has().

Right, or cc_platform_type or whatever. It would probably be a good
idea to have a variable explicitly state what the active coco flavor is
anyway, as we had some ambiguity questions in the past along the lines
of, what does cc_platform_has() need to return when running as a guest
on the respective platform.

If you have it explicitly, then it would work unambiguously simple. And
then we can get rid of CC_ATTR_GUEST_SEV_SNP or CC_ATTR_GUEST_TDX which
is clumsy.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
