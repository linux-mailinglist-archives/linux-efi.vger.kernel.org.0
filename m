Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891858CBA5
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 17:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiHHPzc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Aug 2022 11:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiHHPzc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Aug 2022 11:55:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8EA450;
        Mon,  8 Aug 2022 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659974131; x=1691510131;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=adBjDflubgueY7hGEhT8HFxQtuN3PdKVUrGiUqSnREU=;
  b=QNl8boFMSdd13fHRMSLuu6+NrsXbgOEBFB63vn1QA34ztvfht9YrpV4j
   RNht1lLlATlrr9mudTlGBhSDGParDryEqrFWshfi7VyNXdHWX/iPLYr4D
   lGwlcgJn1MXEiEubNmtsiQX6mckyrxo6bQ2nzOGm5VPfMV+R1XiOKsKYJ
   pzQg9c0RP55Stryj7BZHi+DyY0WZhHrEa3nNNvFVwZ8uaNizAeWsRZ6/h
   jOIb2VTBsOTy40JiD0Kr6uenlovaJQYmWRWf1xRacDqpo8Wd0pcmQmPfb
   eH9WL0zenRFMT/KBGYXZQPaepgx5lkssOUmlwxyoSycMNiHfDTPWer7Oo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291406259"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291406259"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 08:55:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="604416918"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO [10.212.251.15]) ([10.212.251.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 08:55:08 -0700
Message-ID: <4992c5b3-b9a9-b4ff-b09c-1383faf1ea6f@intel.com>
Date:   Mon, 8 Aug 2022 08:55:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <cb9d3310-3bc0-8ecf-5e71-becce980235f@redhat.com>
 <f936b024-43e1-5390-e33f-ad7d355a2802@suse.cz>
 <eb83fcd9-f331-4d54-1ab9-78db106ee66d@intel.com>
 <cecbaa10-6d0a-8925-004b-ff53d9f56e83@suse.cz>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cecbaa10-6d0a-8925-004b-ff53d9f56e83@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/5/22 11:17, Vlastimil Babka wrote:
>> 3. Pull the page off the 2M/4M lists, drop the zone lock, accept it,
>>    then put it back.
> Worth trying, IMHO. Perhaps easier to manage if the lists are distinct from
> the normal ones, as I suggested.

I was playing with another series recently where I did this, momentarily
taking pages off some of the high-order lists and dropping the zone lock.

Kirill, if you go looking at this, just make sure that you don't let
this happen to too much memory at once.  You might end up yanking memory
out of the allocator that's not reflected in NR_FREE_PAGES.

You might, for instance want to make sure that only a small number of
threads can have pulled memory off the free lists at once.  Something
*logically* like this:

// Limit to two threads at once:
atomic_t nr_accepting_threads = ATOMIC_INIT(2);

	page = del_page_from_free_list();
	if (!PageAccepted(page)) {
		if (atomic_dec_and_test(&nr_accepting_threads)) {
			// already at the thread limit
			add_page_from_free_list(page, ...);
			spin_unlock_irq(&zone->lock);
			// wait for a slot...
			spin_lock_irq(&zone->lock);
			goto retry;
		} else {
			spin_unlock_irq(&zone->lock);
			accept_page(page);
			spin_lock_irq(&zone->lock);
			add_page_from_free_list(page, ...);
			// do merging if it was a 2M page
		}
	}

It's a little nasty because the whole thing is not a sleepable context.
 I also know that the merging code needs some refactoring if you want to
do merging with 2M pages here.  It might all get easier if you move all
the page allocator stuff to only work at the 4M granularity.

In any case, I'm not trying to dissuade anyone from listening to the
other reviewer feedback.  Just trying to save you a few cycles on a
similar problem I was looking at recently.
