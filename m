Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743834FB90A
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 12:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbiDKKJ5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbiDKKJ4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 06:09:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D620BD2;
        Mon, 11 Apr 2022 03:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 859AEB81195;
        Mon, 11 Apr 2022 10:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD17FC385A4;
        Mon, 11 Apr 2022 10:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649671660;
        bh=7d4Fz2YovE5nbd9DXkYQpMdwcvwOp0v8/bguDOqmFSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFtbQd/iq+rlCNPGaxfC3Ir2HvIQQgsq/Vp2+3JtHAGSDwgjp8Xd5w2caZTe8PAXA
         eHsQqWA1+krPxZyVFaVbYdrqMp8DMvGob+k/4ZGEKf29Ahye/B2GdlV92VVfWYnr8m
         l0ULaiEvF5/6bu/SR0XQZK85N7o0i8G8+zOPUcz2ilXYjPcdgecr+7alIM6T1xg4PH
         zYWXQRqH1KSvIhFvCdaJkxSgZKH7wHaLOTRaePBuQBkjmpSc8p0VPiM5Bh9Ds4ELGd
         g8uGUUGlAY7+59ndecOzR57Fv6XdUEPFsDhoy6VyqJ301LTYFhzVY8yH9yzSysRmHQ
         GiefvKC1Z25dw==
Date:   Mon, 11 Apr 2022 13:07:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <YlP94T1ACwxKTgep@kernel.org>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
 <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
 <6c976344-fdd6-95cd-2cb0-b0e817bf0392@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c976344-fdd6-95cd-2cb0-b0e817bf0392@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Apr 10, 2022 at 11:38:08PM -0700, Dave Hansen wrote:
> On 4/9/22 08:54, Kirill A. Shutemov wrote:
> > On Fri, Apr 08, 2022 at 11:55:43AM -0700, Dave Hansen wrote:
> 
> >>>  	if (fpi_flags & FPI_TO_TAIL)
> >>>  		to_tail = true;
> >>>  	else if (is_shuffle_order(order))
> >>> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
> >>>  static inline bool page_expected_state(struct page *page,
> >>>  					unsigned long check_flags)
> >>>  {
> >>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> >>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> >>> +	    !PageUnaccepted(page))
> >>>  		return false;
> >>
> >> That probably deserves a comment, and maybe its own if() statement.
> > 
> > Own if does not work. PageUnaccepted() is encoded in _mapcount.
> > 
> > What about this:
> > 
> > 	/*
> > 	 * page->_mapcount is expected to be -1.
> > 	 *
> > 	 * There is an exception for PageUnaccepted(). The page type can be set
> > 	 * for pages on free list. Page types are encoded in _mapcount.
> > 	 *
> > 	 * PageUnaccepted() will get cleared in post_alloc_hook().
> > 	 */
> > 	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))

Maybe I'm missing something, but isn't this true for any PageType?

> > 		return false;
> > 
> > ?
> 
> That's better.  But, aren't the PG_* names usually reserved for real
> page->flags bits?  That naming might be part of my confusion.

We use them for PageType as well like PG_buddy, PG_offline, PG_Table.

-- 
Sincerely yours,
Mike.
