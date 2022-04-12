Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B84FE5B1
	for <lists+linux-efi@lfdr.de>; Tue, 12 Apr 2022 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbiDLQWL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbiDLQWK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 12:22:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9FA4F460;
        Tue, 12 Apr 2022 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649780392; x=1681316392;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0rhW/syVVmAH9bt4RVUxl07dFxjacizqjOlvBoRg8/g=;
  b=k/FZyHUkaiChIUHg/bzf4Mm5gO0zGiYb4XR9p/zFJokYmHYOhGrBPIcn
   eLs8moWv7Yc6ujoiaEobel8kdBn5dkjxvpOcAMU96qbIQnMXGQZyQ10Sm
   J8rbnWYmwfYILNjRY+MAKIXfaw5sfayMF6knLWz9plKviIAKKjwVVSJL6
   sCLE0ongEsosooaOdfkbqwv7p29usbZ/aSfEQdGf1NGZntXI1tqgIiW5x
   taKUk1YD179gdTg27A+CmHWHMyTbN0BfChA17DDkZoMJVdWo+16070RbN
   PFIIi4jxJWgCkpRjfXKZ0YfVxj1F6wpJDlTb4Wg2Uqu3etC/9ZhD4mn5k
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="287438118"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="287438118"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:08:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="551773930"
Received: from vtelkarx-mobl.amr.corp.intel.com (HELO [10.209.191.73]) ([10.209.191.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:08:37 -0700
Message-ID: <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
Date:   Tue, 12 Apr 2022 09:08:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/12/22 01:15, David Hildenbrand wrote:
> Can we simply automate this using a kthread or smth like that, which
> just traverses the free page lists and accepts pages (similar, but
> different to free page reporting)?

That's definitely doable.

The downside is that this will force premature consumption of physical
memory resources that the guest may never use.  That's a particular
problem on TDX systems since there is no way for a VMM to reclaim guest
memory short of killing the guest.

In other words, I can see a good argument either way:
1. The kernel should accept everything to avoid the perf nastiness
2. The kernel should accept only what it needs in order to reduce memory
   use

I'm kinda partial to #1 though, if I had to pick only one.

The other option might be to tie this all to DEFERRED_STRUCT_PAGE_INIT.
 Have the rule that everything that gets a 'struct page' must be
accepted.  If you want to do delayed acceptance, you do it via
DEFERRED_STRUCT_PAGE_INIT.
