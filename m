Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026BC4FB3E6
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbiDKGoI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 02:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbiDKGoH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 02:44:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8E289A0;
        Sun, 10 Apr 2022 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649659314; x=1681195314;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=qqbyajFBqHRHUrF7z93uzdgz9ZWtIREVY38IHJI0vvs=;
  b=HRmv+Wzo+zTtE59KfLTXBS6tBm+3P/mFn++KxF/lYPjrJRyEks3pOQg2
   mMBuy2c3a3ajF9j04oDf+v761b1GlxLI5qBWhqOSu2l/bJOVa3OQBBfOE
   OENSo3S3l3t/yHQkdMfyjwEZbSvGvvpJqZvnhCeNVmwL6GulwyGhC20jq
   pm8eMbtQESnmWjj2S9FZ1yPYB3U1BlOYL9hd2R198fs4n0BN2w37Fjc9h
   2eksxdPg3GTvbHRtS9RGFahSdnCiiFNhCYNCBdxqyvPZgix5nvMx7u9ff
   hXgwqdsc3ii85iX7guU06DXT7VC2UkEqFWnvLC3Z/gbVEN3QwU44D/Nxw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="260891873"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="260891873"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 23:41:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525314042"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6]) ([10.212.113.6])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 23:41:51 -0700
Message-ID: <adc87911-e1f2-4e2a-2394-17ee9213ae3e@intel.com>
Date:   Sun, 10 Apr 2022 23:41:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <20220409175210.xik3ue3shpagskvi@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <20220409175210.xik3ue3shpagskvi@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/9/22 10:52, Kirill A. Shutemov wrote:
> On Fri, Apr 08, 2022 at 12:11:58PM -0700, Dave Hansen wrote:
>> On 4/5/22 16:43, Kirill A. Shutemov wrote:
>>> Kernel only needs to accept memory once after boot, so during the boot
>>> and warm up phase there will be a lot of memory acceptance. After things
>>> are settled down the only price of the feature if couple of checks for
>>> PageUnaccepted() in allocate and free paths. The check refers a hot
>>> variable (that also encodes PageBuddy()), so it is cheap and not visible
>>> on profiles.
>>
>> Let's also not sugar-coat this.  Page acceptance is hideously slow.
>> It's agonizingly slow.  To boot, it's done holding a global spinlock
>> with interrupts disabled (see patch 6/8).  At the very, very least, each
>> acceptance operation involves a couple of what are effectively ring
>> transitions, a 2MB memset(), and a bunch of cache flushing.
>>
>> The system is going to be downright unusable during this time, right?
...
>> Do we need anything more discrete to tell users when acceptance is over?
> 
> I can imagine setups that where acceptance is never over. A VM running
> a workload with fixed dataset can have planty of memory unaccepted.
> 
> I don't think "make it over" should be the goal.

I agree, there will be users that don't care when acceptance is over.
But, I'm also sure that there are users that will care deeply.

>>  For instance, maybe they run something and it goes really slow, they
>> watch "accept_memory" until it stops.  They rejoice at their good
>> fortune!  Then, memory allocation starts falling over to a new node and
>> the agony beings anew.
>>
>> I can think of dealing with this in two ways:
>>
>> 	cat /sys/.../unaccepted_pages_left
>>
>> which just walks the bitmap and counts the amount of pages remaining. or
>> something like:
>>
>> 	echo 1 > /sys/devices/system/node/node0/make_the_pain_stop
>>
>> Which will, well, make the pain stop on node0.
> 
> Sure we can add handles. But API is hard. Maybe we should wait and see
> what is actually needed. (Yes, I'm lazy.:)

Let's just call out the possible (probable?) need for new ABI here.
Maybe it will cue folks who care to speak up.
