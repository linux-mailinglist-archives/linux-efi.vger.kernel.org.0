Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB4522EF5
	for <lists+linux-efi@lfdr.de>; Wed, 11 May 2022 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiEKJHT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 May 2022 05:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiEKJHM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 May 2022 05:07:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB622CC88;
        Wed, 11 May 2022 02:07:10 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34D2C1EC053F;
        Wed, 11 May 2022 11:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652260025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L16i6BF0FXuXjMhQ9rYFWCKSc1fETQHwnQIemH2KAqE=;
        b=rAaK1zqfEck/5icveUj2Kh7QRdsXXRN8aV1/Cia8BRr8YqrY4hzYFaUyQX7oM6KII2VXom
        1fD0b5W1NSwWtaxJyhh76lABcEHPDCic2ga6FZ+pEK/6wQ7TTKNMBvYZBvI457v8gj4CGI
        Ey6/R6Af0dbOKhS8N/wYlrD1OGi55uI=
Date:   Wed, 11 May 2022 11:07:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 08/12] x86/mm: Provide helpers for unaccepted memory
Message-ID: <Ynt8vDY78/YeXO99@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-9-kirill.shutemov@linux.intel.com>
 <YnJfhiiHn+48H2vb@zn.tnic>
 <20220506161359.4j5j5fxrw53fdbyr@box.shutemov.name>
 <Ynqvtyjp77ywiI6f@zn.tnic>
 <20220511011535.or73rm6oviwa5niy@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220511011535.or73rm6oviwa5niy@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 11, 2022 at 04:15:35AM +0300, Kirill A. Shutemov wrote:
> Okay. Fair enough. I will change it to
> 
> 			panic("Cannot accept memory: unknown platform.");

So I haven't went all the way in the patchset but what I see is:

                /* Platform-specific memory-acceptance call goes here */
                if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
                        tdx_accept_memory(range_start * PMD_SIZE,
                                          range_end * PMD_SIZE);
                } else {
                        panic("Cannot accept memory");
                }

so how would you decide for some other platform that it should panic?

TDX should panic, that I get. But you can just as well WARN_ONCE() here
so that it gets fixed. Panicking is counterproductive.

> It checks if the range of memory requires accept_memory() call before it
> can be accessed.
> 
> If any part of the range is not accepted, the call is required.
> accept_memory() knows what exactly has to be done. Note that
> accept_memory() call is harmless for any valid memory range.
> It can be called on already accepted memory.

Aaah, so that's what I was missing. So this function definitely needs a
comment ontop of it. And a name change to something like

	range_contains_unaccepted_memory()

or so to actually state what it does.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
