Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE14CD854
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiCDPyb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiCDPya (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 10:54:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BD1AEEC3;
        Fri,  4 Mar 2022 07:53:41 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-252-111.2.247.pool.telefonica.de [2.247.252.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35AC11EC050F;
        Fri,  4 Mar 2022 16:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646409216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0c6IacfVZd8j72dL9wAC45bHiux03YijXdPN6i1GuS4=;
        b=cRz5oManH/s+VDrsWwL9HJ0SIzzmGa8vp+iiSfE45lHZOHwX+uQatnqocubuVI7wBpzL/A
        Ps79+OoMNx4gCT2Rq7Asw8tomUKRakI6p6hj9M7zuyeTl+o7V4SjROTjBXj+DJc4o/z2xj
        nxaYw/Bwt7hhC7vOLUesJ88qIjlxfiM=
Date:   Fri, 4 Mar 2022 16:53:39 +0100
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 44/45] virt: sevguest: Add support to get extended
 report
Message-ID: <YiI1+Qk2KaWt+uPu@nazgul.tnic>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-45-brijesh.singh@amd.com>
 <YiDegxDviQ81VH0H@nazgul.tnic>
 <7c562d34-27cd-6e63-a0fb-35b13104d41f@amd.com>
 <YiIc7aliqChnWThP@nazgul.tnic>
 <c3918fcc-3132-23d0-b256-29afdda2d6d9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3918fcc-3132-23d0-b256-29afdda2d6d9@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 04, 2022 at 09:39:16AM -0600, Brijesh Singh wrote:
> Depending on which ioctl user want to use for querying the attestation
> report, she need to look at the SNP/GHCB specification for more details.
> The blob contains header that application need to parse to get to the
> actual certificate. The header is defined in the spec. From kernel
> driver point-of-view, all these are opaque data.

... and the ioctl text needs to point to the spec so that the user knows
where to find everything needed. Or how do you expect people to know how
to use those ioctls?

> Will do.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
