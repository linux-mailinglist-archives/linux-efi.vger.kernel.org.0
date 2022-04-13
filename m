Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4A4FF5D6
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiDMLk7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 07:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiDMLk5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 07:40:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B3B5C354
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 04:38:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x33so3016213lfu.1
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZsUJ2NINlf/YGW3oKuUtDCOd4WHYH6lv9r94E8nLe7k=;
        b=uxdU90BlQLxm0jDBpwT7ZMBvjlYIIiuIeQRT3hGbatcT1HUweuug/AHiWZ/ufhqwGo
         mVAjin2rGuacjH0++numKLzwazoDwfSff0NMvZVnuAPgoMJbqvDy1edfuAy40M8BFC/x
         a3laDOVAcLJR3IqFtnn+Amrp1MEceVLZ4500Kf78sVczEg4lQrTkzpiTM7sGu7TF/IL1
         MrG+dTFhVE/Z0ag7oNkra0VOAz8vP+9DIsrR7yV5mXS7nXj3rXbXcUt96Tg/WxcJ5oe7
         D66RiJa98VTqhO3o+k7IwlPhz5/uW8Mzr89bUA/hjNBYKp6JqGfad4ttcKn8J102HYgP
         mZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZsUJ2NINlf/YGW3oKuUtDCOd4WHYH6lv9r94E8nLe7k=;
        b=vod3/gMbDSoy5SF9LrSYiG7r8Lgl6dNRb/UN4FXmy9AgihkJXvFR6IU6vTSlpeIGYr
         +YUMe0y7E3jDpjp42Ml43FvKXephfcoKnuTqHp5Dc4yhMcTybUntVs8dmaIfwe44p22M
         ZgSc5QwzURnRo4YX5d+OblvMdnhVNaCMFh/gNbE5/OL4cxKsnSUmFvsvzvUC+4bYq5n2
         xUiMUW7D7H6WdfPKCJc1PHT6BpLy6aRKU8KRvmNNnf0n08BOIAay6/+vpiP2HeSPvWL7
         9ZsXOnVaZ5RQLMuVSeNz0VPtz4Du92IB1y1OwAdMpzu7RruynCmoPYSHmVh6ixmKHroL
         Lbew==
X-Gm-Message-State: AOAM532jE9i1BDsAn8HY7fcyGB5UY4Uycc971pQvOpoJ39sPhrpqjcRE
        EQ3tkuLW7tuOhWFobLrcBHkdFA==
X-Google-Smtp-Source: ABdhPJyqOiwPXY3JcLiTivxhds7PtI4vfS0IEt8zlViK9HOGTpUtfBt/VR8j//JV+OX1VzpzOxSuGQ==
X-Received: by 2002:a19:4953:0:b0:46b:bdc2:860a with SMTP id l19-20020a194953000000b0046bbdc2860amr4567387lfj.6.1649849908414;
        Wed, 13 Apr 2022 04:38:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k5-20020a196f05000000b0046b94269595sm1503056lfc.169.2022.04.13.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:38:28 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DF1E510369B; Wed, 13 Apr 2022 14:40:01 +0300 (+03)
Date:   Wed, 13 Apr 2022 14:40:01 +0300
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
Message-ID: <20220413114001.wdsi2xrm4btrghms@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
 <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
 <6c976344-fdd6-95cd-2cb0-b0e817bf0392@intel.com>
 <YlP94T1ACwxKTgep@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlP94T1ACwxKTgep@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 11, 2022 at 01:07:29PM +0300, Mike Rapoport wrote:
> On Sun, Apr 10, 2022 at 11:38:08PM -0700, Dave Hansen wrote:
> > On 4/9/22 08:54, Kirill A. Shutemov wrote:
> > > On Fri, Apr 08, 2022 at 11:55:43AM -0700, Dave Hansen wrote:
> > 
> > >>>  	if (fpi_flags & FPI_TO_TAIL)
> > >>>  		to_tail = true;
> > >>>  	else if (is_shuffle_order(order))
> > >>> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
> > >>>  static inline bool page_expected_state(struct page *page,
> > >>>  					unsigned long check_flags)
> > >>>  {
> > >>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> > >>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
> > >>> +	    !PageUnaccepted(page))
> > >>>  		return false;
> > >>
> > >> That probably deserves a comment, and maybe its own if() statement.
> > > 
> > > Own if does not work. PageUnaccepted() is encoded in _mapcount.
> > > 
> > > What about this:
> > > 
> > > 	/*
> > > 	 * page->_mapcount is expected to be -1.
> > > 	 *
> > > 	 * There is an exception for PageUnaccepted(). The page type can be set
> > > 	 * for pages on free list. Page types are encoded in _mapcount.
> > > 	 *
> > > 	 * PageUnaccepted() will get cleared in post_alloc_hook().
> > > 	 */
> > > 	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
> 
> Maybe I'm missing something, but isn't this true for any PageType?
> 
> > > 		return false;
> > > 
> > > ?
> > 
> > That's better.  But, aren't the PG_* names usually reserved for real
> > page->flags bits?  That naming might be part of my confusion.
> 
> We use them for PageType as well like PG_buddy, PG_offline, PG_Table.

PG_buddy gets clear on remove from the free list, before the chec.

PG_offline and PG_table pages are never on free lists.

-- 
 Kirill A. Shutemov
