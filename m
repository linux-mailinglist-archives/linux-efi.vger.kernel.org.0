Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D618B58AC71
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiHEOlk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiHEOlk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 10:41:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3627F6151;
        Fri,  5 Aug 2022 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659710499; x=1691246499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jEZRMajvp62irH+o7cgsjZocWv3ZqbtMu1G37xj5vFw=;
  b=CceQ7Xbdwk4FWfHSrIVCYF6ff5Z1hYhHkCpzaNPgJEEI/piT+/ZMbl6P
   SqtEnwqF/XLS6DQ3RBnwRCJwIdGUugwGkU7n8xeF796z8LoAJjurEcThq
   15rFBxPQZvf5maVLgh4FY1DbmBktpfJMvyZdBH+JiovTEl6HTpvD19kT0
   2U/8m+ed3yw2aG3hfYISXCWZI3ExlgmdzXPF6wAquOgq+yyTuiqFIq75H
   +wBzSu3kPgnjyFGUJHTXxCOeXqBY5OYSBaTi1nbjXcL72xz9oAdXI9Glo
   kSbxurz8IagGvVhOtW7RZ67EkM7dur8WCebtt8tRrjHu8VNQredBnwr7w
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="376508901"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="376508901"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 07:41:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579518635"
Received: from rderber-mobl1.amr.corp.intel.com (HELO [10.212.217.71]) ([10.212.217.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 07:41:37 -0700
Message-ID: <eb83fcd9-f331-4d54-1ab9-78db106ee66d@intel.com>
Date:   Fri, 5 Aug 2022 07:41:38 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <f936b024-43e1-5390-e33f-ad7d355a2802@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/5/22 06:38, Vlastimil Babka wrote:
>> I'm sure we could optimize for the !unaccepted memory via static keys
>> also in this version with some checks at the right places if we find
>> this to hurt performance?
> It would be great if we would at least somehow hit the necessary code only
> when dealing with a >=pageblock size block. The bitmap approach and
> accepting everything smaller uprofront actually seems rather compatible. Yet
> in the current patch we e.g. check PageUnaccepted(buddy) on every buddy size
> while merging.

Needing to check PageUnaccepted() during the merge is fallout from
moving the acceptance to post_alloc_hook().  I _think_ an earlier
version of this did page acceptance under the zone lock, closer to where
the page comes off the 2M/4M lists.

But, page acceptance is horribly slow, so I asked Kirill to move it out
from under the zone lock.  Doing it in post_alloc_hook() (after the zone
lock is dropped) makes a lot of sense since we do zeroing in there and
zeroing is also nice and slow.

But, post_alloc_hook() is long after the 2M page has been split and that
means that we have to deal with potentially unaccepted pages during merges.

I think there are three basic options:

1. This patch: Do acceptance after the zone lock is dropped and deal
   with mixed-acceptance merges
2. Do acceptance under the zone lock as pages come off the 2M/4M lists,
   but before the page is split.
3. Pull the page off the 2M/4M lists, drop the zone lock, accept it,
   then put it back.

I'm not sure any of those other options are better.
