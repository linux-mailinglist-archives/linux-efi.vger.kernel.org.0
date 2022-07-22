Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024057E767
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jul 2022 21:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiGVTal (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jul 2022 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbiGVTak (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Jul 2022 15:30:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1F915829;
        Fri, 22 Jul 2022 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658518239; x=1690054239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yiC+//i7K9IE9d4hXO9yECQl7g97rBdGulNv7h3t0vA=;
  b=Z5zzNv/Q2kfa9jA0Be87Z1plev2I1M4f/CLlOQd0TPcRr+YgKhGNWG+q
   uJplcwtJcUDFj/tqHt3xEtFv7/EyzbYnRFSuJo5sk736hCIUrbwjjMSYQ
   5dHIdm9qNaIJTGeP686uzxW+YMV1whnQmG3gn+67EcfbgC7T2xEearOlC
   IbRiFX/U+EHp+vdUAZoGAjKV48kfopSPH5/5PbqoL/f24tUnzBiv4XeLT
   O8EiSK9ooPg94Q4B1LBmrUuydt34iUDQnEpbeliq7Pdkc4Ptdr1LV/DY3
   jYWDyDkr0fAYJ5JgHXKvJgHx8HaOgiYj3c2ujX2xMtGRYcc5hWiSFfuCm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="284941028"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="284941028"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 12:30:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="926161928"
Received: from jnoah-mobl.amr.corp.intel.com (HELO [10.209.71.211]) ([10.209.71.211])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 12:30:37 -0700
Message-ID: <707ca113-c2a2-8fe2-a22c-5be13adc7bb4@intel.com>
Date:   Fri, 22 Jul 2022 12:30:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <YtltYRuL+2uQkYUK@zn.tnic> <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
 <Ytr4FCV2xPGUBLqs@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Ytr4FCV2xPGUBLqs@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/22/22 12:18, Borislav Petkov wrote:
> On Thu, Jul 21, 2022 at 08:49:31AM -0700, Dave Hansen wrote:
>> So, those (effective) 2MB clflush+memset's (plus a few thousand cycles
>> for the hypercall/tdcall transitions)
> 
> So this sounds strange - page validation on AMD - judging by the
> pseudocode of the PVALIDATE insn - does a bunch of sanity checks on the
> gVA of the page and then installs it into the RMP and also "PVALIDATE
> performs the same segmentation and paging checks as a 1-byte read.
> PVALIDATE does not invalidate TLB caches."
> 
> But that still sounds a lot less work than what the TDX module needs to
> do...

Sure does...  *Something* has to manage the cache coherency so that old
physical aliases of the converted memory don't write back and clobber
new data.  But, maybe the hardware is doing that now.


>> If you have a few hundred CPUs all trying to allocate memory (say,
>> doing the first kernel compile after a reboot), this is going to be
>> very, very painful for a while.
>>
>> That said, I think this is the right place to _start_. There is going
>> to need to be some kind of follow-on solution (likely background
>> acceptance of some kind). But, even with that solution, *this* code
>> is still needed to handle the degenerate case where the background
>> accepter can't keep up with foreground memory needs.
> 
> I'm still catering to the view that it should be a two-tier thing: you
> validate during boot a certain amount - say 4G - a size for which the
> boot delay is acceptable and you do the rest on-demand along with a
> background accepter.
> 
> That should give you the best of both worlds...

Yeah, that two-tier system is the way it's happening today from what I
understand.  This whole conversation is about how to handle the >4GB memory.
