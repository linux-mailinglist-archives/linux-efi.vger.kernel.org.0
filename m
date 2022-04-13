Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96F4FFFBD
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiDMUJ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiDMUJZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 16:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F47B545;
        Wed, 13 Apr 2022 13:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A391E61E32;
        Wed, 13 Apr 2022 20:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BE4C385A3;
        Wed, 13 Apr 2022 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649880420;
        bh=1lv0TYn1rI0bZiX2xcJLC6rgxIwufGUuDS8PwYZgZZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxeoUVNxqagKDTCoBhEg0ZjenI8HlagF6DUcw+G/PXtILlsb/+4C9pEpvNlD3uf3p
         E1v+kxYnRb8b20Y1YbQOvYk79efC+87JQDK3EzvaIg4gX5CtXbi6K6Z8Gfj7QI0Dop
         TYMDAmgwT9qN1CC287v6xLZf9RDalh20LNPvfCIJPDQlgqB5MU43zs16zcyjJp3bps
         aJhxG6La5MxAlJFcJ8YkEprju0ttd6mReGFuXZKsED7A7qu3OrktN/MXqtX+Y6z9Vh
         jaJNTthb2d6e3Adq6vTyH+gxu4FVqcgI5SXduICpNWFjEqDM466H4gwBr7tIY6rfE8
         zQR8zc24UsmKQ==
Date:   Wed, 13 Apr 2022 23:06:46 +0300
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
Message-ID: <YlctVvp5V1OpgKJW@kernel.org>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
 <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
 <6c976344-fdd6-95cd-2cb0-b0e817bf0392@intel.com>
 <YlP94T1ACwxKTgep@kernel.org>
 <20220413114001.wdsi2xrm4btrghms@box.shutemov.name>
 <YlbiqdqCH+j7TK80@kernel.org>
 <20220413151517.tzd76kzja3424lqu@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413151517.tzd76kzja3424lqu@box.shutemov.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 13, 2022 at 06:15:17PM +0300, Kirill A. Shutemov wrote:
> On Wed, Apr 13, 2022 at 05:48:09PM +0300, Mike Rapoport wrote:
> > On Wed, Apr 13, 2022 at 02:40:01PM +0300, Kirill A. Shutemov wrote:
> > > On Mon, Apr 11, 2022 at 01:07:29PM +0300, Mike Rapoport wrote:
> > > > On Sun, Apr 10, 2022 at 11:38:08PM -0700, Dave Hansen wrote:
> > > > > On 4/9/22 08:54, Kirill A. Shutemov wrote:
> > > > > > On Fri, Apr 08, 2022 at 11:55:43AM -0700, Dave Hansen wrote:
> > > > > 
> > > > > >>>  	if (fpi_flags & FPI_TO_TAIL)
> > > > > >>>  		to_tail = true;
> > > > > >>>  	else if (is_shuffle_order(order))
> > > > > >>> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
> > > > > >>>  static inline bool page_expected_state(struct page *page,
> > > > > >>>  					unsigned long check_flags)
> > > > > >>>  {
> > > > > >>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> > > > > >>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> > > > > >>> +	    !PageUnaccepted(page))
> > > > > >>>  		return false;
> > > > > >>
> > > > > >> That probably deserves a comment, and maybe its own if() statement.
> > > > > > 
> > > > > > Own if does not work. PageUnaccepted() is encoded in _mapcount.
> > > > > > 
> > > > > > What about this:
> > > > > > 
> > > > > > 	/*
> > > > > > 	 * page->_mapcount is expected to be -1.
> > > > > > 	 *
> > > > > > 	 * There is an exception for PageUnaccepted(). The page type can be set
> > > > > > 	 * for pages on free list. Page types are encoded in _mapcount.
> > > > > > 	 *
> > > > > > 	 * PageUnaccepted() will get cleared in post_alloc_hook().
> > > > > > 	 */
> > > > > > 	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
> > > > 
> > > > Maybe I'm missing something, but isn't this true for any PageType?
> > > 
> > > PG_buddy gets clear on remove from the free list, before the chec.
> > > 
> > > PG_offline and PG_table pages are never on free lists.
> > 
> > Right, this will work 'cause PageType is inverted. I still think this
> > condition is hard to parse and I liked the old variant with
> > !PageUnaccepted() better.
> 
> Well the old way to deal with PageUnaccepted() had a flaw: if the page is
> PageUnaccepted() it will allow any other page types to pass here. Like
> PG_unaccepted + PG_buddy will slide here.

It seems to me that there was an implicit assumption that page types are
exclusive and PG_unaccepted would break it.
 
> > Maybe if we wrap the whole construct in a helper it will be less eye
> > hurting.
> 
> Hm. Any suggestion how such helper could look like? Cannot think of
> anything sane.

Me neither :(

How about updating the comment to be

	/*
	 * The page must not be mapped to userspace and must not have a
	 * PageType other than PageUnaccepted.
	 * This means that page->_mapcount must be -1 or have only
	 * PG_unaccepted bit cleared.
	 */
	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
