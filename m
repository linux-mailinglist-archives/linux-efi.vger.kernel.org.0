Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE10522414
	for <lists+linux-efi@lfdr.de>; Tue, 10 May 2022 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348906AbiEJScY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 May 2022 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348808AbiEJScX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 May 2022 14:32:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1994E38A;
        Tue, 10 May 2022 11:32:21 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E0DA1EC0354;
        Tue, 10 May 2022 20:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652207536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YwlI4SOdaCiIF2T0fRasnf3pb0Dz0W+PbTJT112BTbI=;
        b=qtivRA6UZ8N6glsgC7YCH4Cm2zMMzUrDPR5yH/pAfaBCOygYNvflOfciVP7oT8Np8O/88W
        CgzdPyC6lZl0zGjd536DXox2BLwQQZXRDAB0JHlgjwISgp0GqwOGue4hyBNWd+iqwogCc/
        /bYQ0+dDaSjuHp0NUl7USPvcr5qTq8s=
Date:   Tue, 10 May 2022 20:32:23 +0200
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
Message-ID: <Ynqvtyjp77ywiI6f@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-9-kirill.shutemov@linux.intel.com>
 <YnJfhiiHn+48H2vb@zn.tnic>
 <20220506161359.4j5j5fxrw53fdbyr@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220506161359.4j5j5fxrw53fdbyr@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 06, 2022 at 07:13:59PM +0300, Kirill A. Shutemov wrote:
> Failure to accept the memory is fatal. Why pretend it is not?
> 
> For TDX it will result in a crash on the first access. Prolonging the
> suffering just make it harder to understand what happened.

Ok then. Does that panic message contain enough info so that the
acceptance failure can be debugged?

Just "Cannot accept memory" doesn't seem very helpful to me...

> That's true. Note also that the check is inherently racy. Other CPU can
> get the range or subrange accepted just after spin_unlock().
> 
> The check indicates that accept_memory() has to be called on the range
> before first access.
> 
> Do you have problem with a name? Maybe has_unaccepted_memory()?

I have a problem with the definition of this function, what it is
supposed to do and how it is supposed to be used.

Right now, it looks weird and strange: is it supposed to check for *all*
in-between (start, end)? It doesn't, atm, so what's the meaning of
@start and @end then at all?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
