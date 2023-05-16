Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1931D705841
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEPUEB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 16:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPUEB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 16:04:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE75FD3;
        Tue, 16 May 2023 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684267432; x=1715803432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=953wYAY7UWvrm1tXjfski6EbreQeUgE/9pY7lM47LiQ=;
  b=giAhZizUhd5c/eXALB3h7EnS+M3NUW3edybry7WIUjtWBmY1/KtmUXHs
   tl6TqJzlPJVSQcTrMEIO+1dFZXysVGujtyRuSqCSeQGl25zBpbkhK4cdz
   nNHgars+aLn/umoGNTYGC37AUcnxSppIrKslr+jl3CFTKNykXkl3sSmrD
   kikR2609FPRX29lauPAMnBozf5ejddARIl9Kmxln54ICSGemSk9R6cFX5
   wzf1ricVq8VT1XPD+21BSGktIUjCnkx82go8YehU5ikw7/KwSuv3KGalA
   GzwFXfj03qTk2PuLchqs9+crq6+dGeGiXBtVmF5uv8jOOtXVoMCGtWc4E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="414982863"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="414982863"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 13:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="875784499"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="875784499"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 13:03:32 -0700
Message-ID: <a7550521-65bf-f9af-ddb0-118602a6340c@intel.com>
Date:   Tue, 16 May 2023 13:03:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/16/23 11:35, Ard Biesheuvel wrote:
>>> Does this mean that the kernel maps memory before accepting it? As
>>> otherwise, I would assume that such an access would page fault inside
>>> the guest before triggering an exception related to the unaccepted
>>> state.
>> Yes, the kernel maps memory before accepting it (modulo things like
>> DEBUG_PAGEALLOC).
>>
> OK, and so the architecture stipulates that prefetching or other
> speculative accesses must never deliver exceptions to the host
> regarding such ranges?

I don't know of anywhere that this is explicitly written.  It's probably
implicit _somewhere_ in the reams of VMX/TDX and base SDM docs, but heck
if I know where it is. :)

If this is something anyone wants to see added to the SEPT_VE_DISABLE
documentation, please speak up.  I don't think it would be hard to get
it added and provide an explicit guarantee.
