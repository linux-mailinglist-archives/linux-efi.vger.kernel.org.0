Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B03559E79
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiFXQWl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 12:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFXQWj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 12:22:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A356768;
        Fri, 24 Jun 2022 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656087759; x=1687623759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xL3KlmHGWviM8HJoLAyDTXeAYfhn8TtCOi1g2QYm2Bw=;
  b=mOVsmCq6Gy6VfiVn2S9ChCt7X4y1H28ogG+na2fu4Sa8WUeFv59Q82zt
   IsRdVhb4dOKvY7ik9XMsWKyWNfr+JlsjFCft7+9SLrJV0S15eTPuDgvnC
   Sc8wVVy1dWRWlrqQmt45w+yfrmLbciljnXruFMM3mp84VYDQ9RS2sAxmo
   YOTqzyCvvtTmatxdA593EWpBJB4Ks9BKv9pZc2xxdR6iBerQhQc8YHzwI
   GihPLrzxtmB/d5DiqIlua81J/4d5gSjbEYpW5XAhjVr84eF4BLqETzwnF
   bU6KNQ1ATLkgUWWlkLPGjyroEbDEsHoOcLiLTrI6Wl+VKKYs2EReLUxMW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278580770"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="278580770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 09:22:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="731380192"
Received: from mdedeogl-mobl.amr.corp.intel.com (HELO [10.209.126.186]) ([10.209.126.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 09:22:37 -0700
Message-ID: <7c74e86e-295f-0958-cbdf-b54b4ca688dd@intel.com>
Date:   Fri, 24 Jun 2022 09:22:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 14/14] x86/tdx: Add unaccepted memory support
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-15-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220614120231.48165-15-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/22 05:02, Kirill A. Shutemov wrote:
>  static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>  	/* Platform-specific memory-acceptance call goes here */
> -	error("Cannot accept memory");
> +	if (is_tdx_guest())
> +		tdx_accept_memory(start, end);
> +	else
> +		error("Cannot accept memory: unknown platform\n");
>  }

There are quite a few of these

	if (tdx())
		...

conditions in common code here.  Shouldn't this be something like a
CC_ATTR_MEM_ACCEPT?

	if (cc_platform_has(CC_ATTR_MEM_ACCEPT))
		cc_accept_memory(...);
	else
		error("Cannot accept memory: unknown platform\n");

I understand that TDX is the first one to the party.  Is this the time
to add the cc_ infrastructure?
