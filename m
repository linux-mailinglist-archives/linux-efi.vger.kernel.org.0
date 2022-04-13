Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFE4FF956
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiDMOuq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiDMOup (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 10:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B82D644E5;
        Wed, 13 Apr 2022 07:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AE961CD2;
        Wed, 13 Apr 2022 14:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB28C385A4;
        Wed, 13 Apr 2022 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649861303;
        bh=FgczV9vyyhtmBq+7sQB2zbK2zkbVOySmGyJEOuInnlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQw7UBPRl43qPWUCP2erzWWaWPQNsx70yocpG64iBv2l/aAtgrwO3qsNv+dq2+Ch5
         JU7LOh8SUpkXyAOfn0+SnN+NSLeR0dhUGW+m4a7/20guJtrgLblegv5sNemLcgPqKl
         6J9FTjAKTpFtGRTENxV8SurPZxzU+o/DiJl5sBZXY5wBhL1MObXsp+5qrg/fRxl1JX
         x9+TXStgVboZIpoQYAV1bAyaKsDvgEai2GQhwx1z7TDTwAp5kz7qfxpKf9bfGC8w8k
         OETaHeX9pWfVR+5+xQP4RoU2bnZst5FCD2aKRDDi1+lWvsAToUjeX4fbXza6rrXPK2
         UlrExmZwnqSbw==
Date:   Wed, 13 Apr 2022 17:48:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Brijesh Singh <brijesh.singh@amd.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Message-ID: <YlbiqdqCH+j7TK80@kernel.org>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
 <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
 <6c976344-fdd6-95cd-2cb0-b0e817bf0392@intel.com>
 <YlP94T1ACwxKTgep@kernel.org>
 <20220413114001.wdsi2xrm4btrghms@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413114001.wdsi2xrm4btrghms@box.shutemov.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 13, 2022 at 02:40:01PM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 11, 2022 at 01:07:29PM +0300, Mike Rapoport wrote:
> > On Sun, Apr 10, 2022 at 11:38:08PM -0700, Dave Hansen wrote:
> > > On 4/9/22 08:54, Kirill A. Shutemov wrote:
> > > > On Fri, Apr 08, 2022 at 11:55:43AM -0700, Dave Hansen wrote:
> > > 
> > > >>>  	if (fpi_flags & FPI_TO_TAIL)
> > > >>>  		to_tail = true;
> > > >>>  	else if (is_shuffle_order(order))
> > > >>> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
> > > >>>  static inline bool page_expected_state(struct page *page,
> > > >>>  					unsigned long check_flags)
> > > >>>  {
> > > >>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> > > >>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> > > >>> +	    !PageUnaccepted(page))
> > > >>>  		return false;
> > > >>
> > > >> That probably deserves a comment, and maybe its own if() statement.
> > > > 
> > > > Own if does not work. PageUnaccepted() is encoded in _mapcount.
> > > > 
> > > > What about this:
> > > > 
> > > > 	/*
> > > > 	 * page->_mapcount is expected to be -1.
> > > > 	 *
> > > > 	 * There is an exception for PageUnaccepted(). The page type can be set
> > > > 	 * for pages on free list. Page types are encoded in _mapcount.
> > > > 	 *
> > > > 	 * PageUnaccepted() will get cleared in post_alloc_hook().
> > > > 	 */
> > > > 	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
> > 
> > Maybe I'm missing something, but isn't this true for any PageType?
> 
> PG_buddy gets clear on remove from the free list, before the chec.
> 
> PG_offline and PG_table pages are never on free lists.

Right, this will work 'cause PageType is inverted. I still think this
condition is hard to parse and I liked the old variant with
!PageUnaccepted() better.

Maybe if we wrap the whole construct in a helper it will be less eye
hurting.
 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
