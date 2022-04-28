Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760CB5130EF
	for <lists+linux-efi@lfdr.de>; Thu, 28 Apr 2022 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiD1KMK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Apr 2022 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiD1KLp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Apr 2022 06:11:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA6674C1;
        Thu, 28 Apr 2022 03:03:06 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 773C31EC0535;
        Thu, 28 Apr 2022 12:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651140181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PgBjqy9vQg0VYpTLuefpsdMFD4lNCA09smFUUhKxkbQ=;
        b=o+/ay/k8tOLntCUuq4C/qtmunpu2Bol5mgc9WPOI2hN4GpvuDvxbJiHGAoCS300Qp1E2Rs
        Ccp05mNGghaGTesy4iqY5q1AmS70B9H0Tf51+vF+MfJFGtjNew/44it8RJ8YmtKkimfogv
        WTbY1Xg01IY/2tln7cK+ONkKq+PNJ8E=
Date:   Thu, 28 Apr 2022 12:02:58 +0200
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
Subject: Re: [PATCHv5 03/12] efi/x86: Get full memory map in allocate_e820()
Message-ID: <YmpmUjXn7XYOhUpF@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-4-kirill.shutemov@linux.intel.com>
 <YmmmpxVDyc3R5K2t@zn.tnic>
 <20220427234853.6kt67gjrwzrhgvoa@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220427234853.6kt67gjrwzrhgvoa@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 28, 2022 at 02:48:53AM +0300, Kirill A. Shutemov wrote:
> Right. That's true. But having goto here makes patch 5/12 a bit cleaner.

Ok, let's take our time machine and go into the future:

This patch is in git, there's no concept of "next patch" anymore - and
someone is staring at it for whatever reason.

Someone is wondering: why the hell was this done this way? And which
is that "next patch"? Someone probably needs to sort them in the
application order to figure out which next patch the author is talking
about...

See what I mean?

Also, if this hunk

+
+       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+               status = allocate_unaccepted_memory(params, nr_desc, map);
+

is what this is all about, then no, this confusion is not even worth it
- please make sure your patches make sense on their own.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
