Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CFA705A20
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 00:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEPWAL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 18:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjEPWAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 18:00:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0810EC;
        Tue, 16 May 2023 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684274409; x=1715810409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/gElHzywUsJHlUOft8PJljOmt4C9JPUiaPG7wwx26iQ=;
  b=TpNKLP4VK+BdeciInAAjTaVzx9bdrb4F5hQtBpsAuKRhh8ciTS3scwZv
   gRwtTkGPT5jPlrSrlL16c7m13BX6zo9Flu3FglVTZkgcOsvFzlYsRryvw
   Ff3ypO/0NS0SxEGrEkyk76lwIk0ToSbo7QPnve6bSZjldXTvt0TbbLJHp
   SjIvoKVYWSwuKlTgDt2I+7j+FaXoq/Os4dbeTmaOYHEtn5T7S8ryq5nBz
   nhAdxNUZ2usMeU31q11uSQ94ErusUhRfxvMHFML5F+jiLIYy3c41rmHCv
   0K2snU1HOxkXjG+j+ua95FFYCMCjJrbkZW7dh6vzPnV/lV/JdTsGvWHvn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="340980067"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="340980067"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="813612412"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="813612412"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:59:56 -0700
Message-ID: <f7b2e758-625a-aafd-d545-bfa6eae513bb@intel.com>
Date:   Tue, 16 May 2023 14:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
 <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
 <6fe42f66-819c-f2c8-176b-759c1c5a9cf5@intel.com>
 <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
 <a7550521-65bf-f9af-ddb0-118602a6340c@intel.com>
 <20230516215210.pviqojbr5o4hd6bb@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230516215210.pviqojbr5o4hd6bb@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/16/23 14:52, Kirill A. Shutemov wrote:
> On Tue, May 16, 2023 at 01:03:32PM -0700, Dave Hansen wrote:
>> On 5/16/23 11:35, Ard Biesheuvel wrote:
>>>>> Does this mean that the kernel maps memory before accepting it? As
>>>>> otherwise, I would assume that such an access would page fault inside
>>>>> the guest before triggering an exception related to the unaccepted
>>>>> state.
>>>> Yes, the kernel maps memory before accepting it (modulo things like
>>>> DEBUG_PAGEALLOC).
>>>>
>>> OK, and so the architecture stipulates that prefetching or other
>>> speculative accesses must never deliver exceptions to the host
>>> regarding such ranges?
>> I don't know of anywhere that this is explicitly written.  It's probably
>> implicit _somewhere_ in the reams of VMX/TDX and base SDM docs, but heck
>> if I know where it is. 😄
> It is not specific to TDX: on x86 (and all architectures with precise
> exceptions) exception handling is delayed until instruction retirement and
> will not happen if speculation turned out to be wrong. And prefetching
> never generates exceptions.

Not to be Debbie Downer too much here, but it's *totally* possible for
speculative execution to go read memory that causes you to machine
check.  We've had such bugs in Linux.

We just happen to be lucky in this case that the unaccepted memory
exceptions don't generate machine checks *AND* TDX hardware does not
machine check on speculative accesses that would _just_ violate TDX
security properties.

You're right for normal, sane exceptions, though.
