Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5A7206DA
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjFBQJE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbjFBQJE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 12:09:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09127BC;
        Fri,  2 Jun 2023 09:09:03 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 092F01EC0333;
        Fri,  2 Jun 2023 18:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685722141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xu4XCvM1sAiwB/WfAq5MbMKHo8Vx2G01mpn67g5+mLc=;
        b=XNFq0zyeMW0Rzi8qdgeGXSA3AM7MDd19unhJsTI0DQezaVNRgx0+TUvw6/qhFDedLPY4XM
        wkZnKYWcXoIP+yql921r/5tJ9amPai4rDZiK02xaMyVnjo9hXgW4Dzh/X07T0kNLWVBzXq
        dH1lwHdt6qW1gzCnVhUSoieE8MKsZ4A=
Date:   Fri, 2 Jun 2023 18:09:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCHv13 4/9] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20230602160900.GEZHoUHHpPKMnzV3bs@fat_crate.local>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-5-kirill.shutemov@linux.intel.com>
 <20230602140641.GKZHn3caQpYveKxFgU@fat_crate.local>
 <20230602153644.cbdicj2cc6p6goh3@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602153644.cbdicj2cc6p6goh3@box.shutemov.name>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 02, 2023 at 06:36:44PM +0300, Kirill A. Shutemov wrote:
> I don't see why it is simpler. It looks unnecessary noisy to me.

Noisy?

I have no clue what you mean.

It is regular:

	if (bla && flu)

vs

	if (bla)
		return flu();

It is about having regular patterns which can be recognized at a quick
glance by those who get to stare at that code constantly.

> Configuration table suppose to be present, even if unaccepted memory is
> not supported. Something is very wrong if it is missing.

I am not sure if it is the decompressor's job to do such validation
- I guess this is something the EFI code should do.

> I will downgrade it warn().

Yes, or simply return here without accepting memory - plain and simple.

> I wanted to keep unaccepted_table private to the libstub/unaccepted_memory.c.
> The setter provides a good spot for documentation to guide unaccepted
> memory enablers for other archs.
> 
> Still want replace it with direct assignment?

No clue. Why would you want to keep a variable in the libstub private
which is not even in kernel proper, AFAICT?

> Okay, I will make init_unaccepted_memory() return true if unaccepted
> memory is present and hide defined it always-false for !UNACCEPTED_MEMORY.
> So this hunk will look this way:
> 
> 	if (init_unaccepted_memory()) {
> 		debug_putstr("Accepting memory... ");
> 		accept_memory(__pa(output), __pa(output) + needed_size);
> 	}

Yap, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
