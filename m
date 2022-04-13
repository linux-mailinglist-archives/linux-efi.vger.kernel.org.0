Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1349D4FF919
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiDMOl6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiDMOl5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 10:41:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A0BFD1C;
        Wed, 13 Apr 2022 07:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D120360DEA;
        Wed, 13 Apr 2022 14:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A8C385A4;
        Wed, 13 Apr 2022 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649860774;
        bh=8yJB3RTfMHAvG+qVCpJGHNnXUQN/4L5d65PERRX6VvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6UmbR9Nnkyyb0sa6mU+ScjeQj6ySSju0otK3fB765GF5jbY38UmFbxK8+CO3WWmv
         F90FPJTu6x0c5EdcRloalAL0l4kvi4dhG77+C7x2aoN2CGYa6EA/STzOwkBp+H1/bI
         /dxmdZQhK/FfXWeHKOiRPHwA8AtpSvBl86ja5Y46Vm/w1prNZkBZoE3Ds4VCn5CFtq
         v+/MnU4bLFcgdCigJu1Yg2hJWLSN6KwcZQ+9ZG0DtRkfjHjUMcvOE04QbRbZ0gYAeB
         /XCJIHJAHtZ9YjazAXQfpXUbK9a31JvULtIkqEwSTHTpvcazlHD76suMOabluS2C0x
         7aPTRxcwuEDKQ==
Date:   Wed, 13 Apr 2022 17:39:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Message-ID: <YlbgmOwb9uXMt49l@kernel.org>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
 <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
 <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 13, 2022 at 12:36:11PM +0200, David Hildenbrand wrote:
> On 12.04.22 18:08, Dave Hansen wrote:
> > On 4/12/22 01:15, David Hildenbrand wrote:
> > 
> > The other option might be to tie this all to DEFERRED_STRUCT_PAGE_INIT.
> >  Have the rule that everything that gets a 'struct page' must be
> > accepted.  If you want to do delayed acceptance, you do it via
> > DEFERRED_STRUCT_PAGE_INIT.
> 
> That could also be an option, yes. At least being able to chose would be
> good. But IIRC, DEFERRED_STRUCT_PAGE_INIT will still make the system get
> stuck during boot and wait until everything was accepted.

The deferred page init runs multithreaded, so guest with SMP will be stuck
for less time.
 
> I see the following variants:
> 
> 1) Slow boot; after boot, all memory is already accepted.
> 2) Fast boot; after boot, all memory will slowly but steadily get
>    accepted in the background. After a while, all memory is accepted and
>    can be signaled to user space.
> 3) Fast boot; after boot, memory gets accepted on demand. This is what
>    we have in this series.
> 
> I somehow don't quite like 3), but with deferred population in the
> hypervisor, it might just make sense.

IMHO, deferred population in hypervisor will be way more complex than this
series with similar "visible" performance.

-- 
Sincerely yours,
Mike.
