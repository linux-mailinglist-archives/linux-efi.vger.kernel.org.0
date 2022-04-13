Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597F4FF9CF
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiDMPQI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiDMPQH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 11:16:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2226387A3
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 08:13:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bi26so4167370lfb.2
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RAAc5fa4F90WsSmMhyXG1BxDYmJJkdC+jeev0xBh19I=;
        b=xX5d3iFAgBwcsG6s5J2C4/fLi6LlyCP196z7KBeTpn4ttNrT/0VeBmqpZrVANXjtIM
         c+eUxPnL6kXEYJbv4Wu711Aji9cUBck5mBk5FPqthYuLmchh9cr8gy0oZMXvZNReQYj1
         BmLMVOWE8WynJFd75yYTUjAO/Z5R88LGTxqx1qVZW03UaLpsXNPqkOogT9Y2TBkZffCD
         kTujj7PajUDP5BlNSVjQYaWeEt4OYUyRNCaRGxL2QE+H9R4IxgqWYQ+E1oV5KFlds+wv
         /9WiANG5JdMNnpyoOWRq/uIjvdTdz6N+UOz8yvngBhyX3YddzCFyhpeCtSDAgX0tVIoE
         Upcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RAAc5fa4F90WsSmMhyXG1BxDYmJJkdC+jeev0xBh19I=;
        b=xe7BhwnPjuZxnWSq7xilUeCDPxlRZ7y+yRNfkxmYR5POlpaJ2v3jtnaeirp7fRWZa1
         KQCt4D4DDwikswtHdCkQNSvXHnViifXmIGgnNlwNNgkfx8UtzXPeRPJG/+jUU8nWOQW6
         jAgwveNTWpuc6Z3lXAK7YGepamLL9+LXXSqlOo9gu+/k+SUGd1DVE5+SD9ne59obf55E
         AHlo7AtJrcTs9Js/v5g0GTi1moqKlxgeAEjImnYZSkhGurw+rNmDNUtQygd4MzHckDJa
         85ClBwwJ48TNvHyciUg4rndRrCwQUgU9lUFTB0XPXOf/1GAEWbWzzn4gcMZiZxpy94Yd
         myMg==
X-Gm-Message-State: AOAM531esdcJMY0dBTRjF70eYycNuDwVLQCl23hWfrvPABLHp9DCDcB9
        ZNdMbHhgB+yGJuZ2hUK+5q03QQ==
X-Google-Smtp-Source: ABdhPJzGMpUSiE9GVIjXl9oR+9/sm+CrqfOI2L7c3sX8hQf2neNKEahVQsBzUzo5C7G8Z/yzmwf7dQ==
X-Received: by 2002:a19:da12:0:b0:46b:926f:d34b with SMTP id r18-20020a19da12000000b0046b926fd34bmr15227644lfg.646.1649862824074;
        Wed, 13 Apr 2022 08:13:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bj8-20020a2eaa88000000b0024b6abfc2ddsm741396ljb.114.2022.04.13.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:13:43 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0929910369B; Wed, 13 Apr 2022 18:15:17 +0300 (+03)
Date:   Wed, 13 Apr 2022 18:15:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20220413151517.tzd76kzja3424lqu@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
 <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
 <6c976344-fdd6-95cd-2cb0-b0e817bf0392@intel.com>
 <YlP94T1ACwxKTgep@kernel.org>
 <20220413114001.wdsi2xrm4btrghms@box.shutemov.name>
 <YlbiqdqCH+j7TK80@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlbiqdqCH+j7TK80@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 13, 2022 at 05:48:09PM +0300, Mike Rapoport wrote:
> On Wed, Apr 13, 2022 at 02:40:01PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Apr 11, 2022 at 01:07:29PM +0300, Mike Rapoport wrote:
> > > On Sun, Apr 10, 2022 at 11:38:08PM -0700, Dave Hansen wrote:
> > > > On 4/9/22 08:54, Kirill A. Shutemov wrote:
> > > > > On Fri, Apr 08, 2022 at 11:55:43AM -0700, Dave Hansen wrote:
> > > > 
> > > > >>>  	if (fpi_flags & FPI_TO_TAIL)
> > > > >>>  		to_tail = true;
> > > > >>>  	else if (is_shuffle_order(order))
> > > > >>> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
> > > > >>>  static inline bool page_expected_state(struct page *page,
> > > > >>>  					unsigned long check_flags)
> > > > >>>  {
> > > > >>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> > > > >>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> > > > >>> +	    !PageUnaccepted(page))
> > > > >>>  		return false;
> > > > >>
> > > > >> That probably deserves a comment, and maybe its own if() statement.
> > > > > 
> > > > > Own if does not work. PageUnaccepted() is encoded in _mapcount.
> > > > > 
> > > > > What about this:
> > > > > 
> > > > > 	/*
> > > > > 	 * page->_mapcount is expected to be -1.
> > > > > 	 *
> > > > > 	 * There is an exception for PageUnaccepted(). The page type can be set
> > > > > 	 * for pages on free list. Page types are encoded in _mapcount.
> > > > > 	 *
> > > > > 	 * PageUnaccepted() will get cleared in post_alloc_hook().
> > > > > 	 */
> > > > > 	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
> > > 
> > > Maybe I'm missing something, but isn't this true for any PageType?
> > 
> > PG_buddy gets clear on remove from the free list, before the chec.
> > 
> > PG_offline and PG_table pages are never on free lists.
> 
> Right, this will work 'cause PageType is inverted. I still think this
> condition is hard to parse and I liked the old variant with
> !PageUnaccepted() better.

Well the old way to deal with PageUnaccepted() had a flaw: if the page is
PageUnaccepted() it will allow any other page types to pass here. Like
PG_unaccepted + PG_buddy will slide here.

> Maybe if we wrap the whole construct in a helper it will be less eye
> hurting.

Hm. Any suggestion how such helper could look like? Cannot think of
anything sane.

-- 
 Kirill A. Shutemov
