Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F84B3B44
	for <lists+linux-efi@lfdr.de>; Sun, 13 Feb 2022 13:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiBMMPg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Feb 2022 07:15:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiBMMPf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Feb 2022 07:15:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A55C37F;
        Sun, 13 Feb 2022 04:15:28 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7703F1EC063A;
        Sun, 13 Feb 2022 13:15:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644754521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q6tD3Xsv4L3AVxoyHSluBEuFz9raJ3UAB6jSHO2SnV4=;
        b=YZaHnBS6OIFdyl1RAQ15BetYbasA2SpQ/V80z/+R6aEZjdG+tOulyq4FUF0ow0zyOuOojl
        LTNWn7Nz3PtghAolELPnETr6KmZk1XRq6/C3aU4SoABb3ZP+WSLeNz7lIlqTQe10T6Iwhr
        q3L/K1+POZ/tne5qo0BVm2Vgp7/YV6s=
Date:   Sun, 13 Feb 2022 13:15:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <Ygj2Wx6jtNEEmbh9@zn.tnic>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
 <YgZ427v95xcdOKSC@zn.tnic>
 <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 11, 2022 at 11:27:54AM -0600, Brijesh Singh wrote:
> > Simply have them always present. They will have !0 values on the
> > respective guest types and 0 otherwise. This should simplify a lot of
> > code and another unconditionally present u64 won't be the end of the
> > world.
> >
> > Any other aspect I'm missing?
> 
> I think that's mostly about it. IIUC, the recommendation is to define a
> new callback in x86_platform_op. The callback will be invoked
> unconditionally; The default implementation for this callback is NOP;
> The TDX and SEV will override with the platform specific implementation.
> I think we may able to handle everything in one callback hook but having
> pre and post will be a more desirable. Here is why I am thinking so:
> 
> * On SNP, the page must be invalidated before clearing the _PAGE_ENC
> from the page table attribute
> 
> * On SNP, the page must be validated after setting the _PAGE_ENC in the
> page table attribute.

Right, we could have a pre- and post- callback, if that would make
things simpler/clearer.

Also, in thinking further about the encryption mask, we could make it a
*single*, *global* variable called cc_mask which each guest type sets it
as it wants to.

Then, it would use it in the vendor-specific encrypt/decrypt helpers
accordingly and that would simplify a lot of code. And we can get rid of
all the ifdeffery around it too.

So I think the way to go should be we do the common functionality, I
queue it on the common tip:x86/cc branch and then SNP and TDX will be
both based ontop of it.

Thoughts?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
