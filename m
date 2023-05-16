Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF536705AFA
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjEPXEb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjEPXE3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 19:04:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019E8A58;
        Tue, 16 May 2023 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684278251; x=1715814251;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cpPm6dizOpzAe28lnc0LmN8v78c+WYJi5K9EK5t9WLY=;
  b=KSUTvuueFoNx9XjI7Bpn/I1jsAy5yZyB8a0csukopTuILsJ1O8L7WVFI
   DE/BdMRX1+VirZlGkyzMo9bmF/STjap5SB4pDBkpFPeid81xxxm/PGrcq
   MsqVKNss69vEjF00TtxgpOu1qjJk41UYIj45TDeFFX+XVijOAeaS37nlI
   IFp/rttL9tFH969dEiEJvttr+bR+AeH0fShnWWgcxprDTZH29wTnTME/s
   04JwIWopKLAs+Rf5yBLmqvE7w96bIa2RuXjGtQZn8THLTpPrB5diH44yS
   7w3E+xiPBJPMAD89UU5I7yIvgdmCiTdMEKG+RniCTfwXudxBui+Np5Bdu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="351640962"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="351640962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="875825066"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="875825066"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:04:04 -0700
Message-ID: <24a961b4-5385-0949-045b-c3da137042a2@intel.com>
Date:   Tue, 16 May 2023 16:04:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
 <20230516183352.5fvmqca34cjcv462@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230516183352.5fvmqca34cjcv462@box.shutemov.name>
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

On 5/16/23 11:33, Kirill A. Shutemov wrote:
> For context: there's a way configure TDX environment to trigger #VE on
> such accesses and it is default. But Linux requires such #VEs to be
> disabled as it opens attack vector from the host to the guest: host can
> pull any private page from under kernel at any point and trigger such #VE.
> If it happens in just a right time in syscall gap or NMI entry code it can
> be exploitable.

I'm kinda uncomfortable with saying it's exploitable.

It really boils down to not wanting to deal with managing a new IST
exception.  While the NMI IST implementation is about as good as we can
get it, I believe there are still holes in it (even if we consider only
how it interacts with #MC).  The more IST users we add, the more holes
there are.

You add the fact that an actual adversary can induce the exceptions
instead of (rare and mostly random) radiation that causes #MC, and it
makes me want to either curl up in a little ball or pursue a new career.

So, exploitable?  Dunno.  Do I want to touch an #VE/IST implementation?
No way, not with a 10 foot pole.
