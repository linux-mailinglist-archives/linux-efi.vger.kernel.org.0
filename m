Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997E4FFA60
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiDMPjK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiDMPjJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 11:39:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C156514D;
        Wed, 13 Apr 2022 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649864207; x=1681400207;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=oIiCjJKpo00HkSNcMJpuGaaA17RzsSWMzH4oj7iHyy8=;
  b=Je7G3kM5dmQj2cX90v9DuZIfXtlqKgiCycMZhsSsTj3PBq/gOYmA0eP8
   NfLFM9AcJHGOOVLbU+c5L3XyiimGpqxDTU6JcaTXRFK+HHecKMW/abYE+
   g564/YAIwu2r4yuzuwGjoNQYFMsmFwwA5VUSd9jmnopl/MCnZ5YxKsGGq
   018wHC9CJrtDsDGdBPYbfH/+BctdekU2tvyquKOrFbssA0krokhNBH3Ss
   rkGWB2yrCnBQq+ExQzt/eOUxBieTEfL0mhsbaHSX3tZDPk/nDwKCEmF5V
   zRggL7X+zUUx6La0Mx6zPIQjjWJrYKmKHGbvtJdaesFHodZWx23N0uRI9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262879943"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262879943"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:36:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="559791794"
Received: from jmsepko-mobl.amr.corp.intel.com (HELO [10.212.61.150]) ([10.212.61.150])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:36:45 -0700
Message-ID: <cfcf9f82-7e5f-58b6-7b47-9ac552832596@intel.com>
Date:   Wed, 13 Apr 2022 08:36:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
 <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
 <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
 <20220413113024.ycvocn6ynerl3b7m@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <20220413113024.ycvocn6ynerl3b7m@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/13/22 04:30, Kirill A. Shutemov wrote:
>> 2) Fast boot; after boot, all memory will slowly but steadily get
>>    accepted in the background. After a while, all memory is accepted and
>>    can be signaled to user space.
...
> Frankly, I think option 2 is the worst one. You still CPU cycles from the
> workload after boot to do the job that may or may not be needed. It is an
> half-measure that helps nobody.

Let's not be too hyperbolic here.  "Worst" is entirely subjective and it
totally depends on your perspective and what you care about.

There are basically four options:

 * Accept everything in early boot
 * Accept with deferred page free
 * Accept with kthread after boot
 * Accept on demand

and four things that matter:

 * Code complexity
 * Time to a shell prompt
 * CPU/Memory waste
 * Deterministic overhead

Did I miss any?

News flash: none of the options wins on all the things that matter.
We're going to have to pick one (or maybe two).  I'm also not horribly
convinced that there's a problem here worth solving, especially one that
requires surgery in the core of the buddy allocator.

This is essentially making a performance argument: it takes too long to
boot if we go with a simpler solution.  Yet, I haven't seen any data.  I
think we need to go with the simplest approach(es) until there's some
actual data to guide us here.

Here's another way to look at it:

> https://docs.google.com/spreadsheets/d/1Fpv0Yp0CTF5_JXHR2pywvNtImTwUVGTxDMlJ5t8qiis/edit?usp=sharing

