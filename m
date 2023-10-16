Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8268B7CB1B4
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 19:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjJPR4Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjJPR4Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 13:56:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC5DA7;
        Mon, 16 Oct 2023 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/SdjzNKC8llTqbzK5M4yd54rZVBEOFB52/z6QfMDo7U=; b=dGuZgk5gVAdiUWyjNrLk9vr6D2
        Hb5y6FVBXRUfRBvHyn+Soa4vyCFm/FodV4eLxDheai2PTmCSQLd394tBXQz3m3kgacb7+kZMAp602
        gx4EvxUI56Rz7+typFCFgG0VRpIkDZppCfjGyv92LJEtGp98KsFiy0uJJ/UsyLdZ8G3TsI2pyHFLL
        ZE4z2j4IBfvuKiBdGwHl74ZG2Rbj9EUQpTBtepWwbMaUJDZWqlPZzdh3VNQJWPMJyKCw3rI9CIuJ9
        Z6fosUBoYWdv7tNwO8hJJgwpPz/lx0wBPm0pi51uiwTnKESpsIH9AsDCiYnJes74nG3hVG3NLK0Lv
        kFQ3+GPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsRob-007TKi-E0; Mon, 16 Oct 2023 17:55:41 +0000
Date:   Mon, 16 Oct 2023 18:55:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        philip.cox@canonical.com, aarcange@redhat.com, peterx@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Message-ID: <ZS15HZqK4hu5NjSh@casper.infradead.org>
References: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016163122.12855-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 16, 2023 at 07:31:22PM +0300, Kirill A. Shutemov wrote:
>   v2:
>    - Fix deadlock (Vlastimil);
>    - Fix comments (Vlastimil);
>    - s/cond_resched()/cpu_relax()/ -- cond_resched() cannot be called
>      from atomic context;

Isn't there an implicit cpu_relax() while we're spinning?  Does this
really accomplish anything?

> +retry:
>  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
[...]
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
> +		/*
> +		 * The code is reachable from atomic context.
> +		 * cond_resched() cannot be used.
> +		 */
> +		cpu_relax();
> +
> +		goto retry;
