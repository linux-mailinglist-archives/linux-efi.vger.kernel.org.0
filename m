Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97358AC85
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiHEOxv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbiHEOxu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 10:53:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797713F30E;
        Fri,  5 Aug 2022 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659711229; x=1691247229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cW59A0boZIrZcRLHW5J56RfVnKU27mehgVJoXc75M14=;
  b=CbGtY5Y33/bC213ZXNfdPMhCxYAj3Q3uYNOMSIxgfD+gx+MSeQPPc4+7
   UIb3T0Z/0NL4Lx8Z9uWscZgJS2u6+4bkcpcRpRnpjAN6TVYaKI1P2ItnT
   rOAMfh3qRj5AiNuLpyp04FxUOZpnPlBp2zNdlIE+lD8pLrpUxgUq7OhU0
   N+mep48IIVCuTIlPQkaZd5aKAMKR6d4kOcKFOUB44aTOjnboJtzipmUv5
   rjy/3fnmXd6jKQGHeOTvL4siOUk9c5gOnXcRExDLAwYAO6g7Vnm+FccLM
   5r/eM/F2auzh9YUqA1PQh9CmJJX5gT5cfcm3ioHl3jeQids953QagC5eV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="291437687"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="291437687"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 07:53:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579521566"
Received: from rderber-mobl1.amr.corp.intel.com (HELO [10.212.217.71]) ([10.212.217.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 07:53:48 -0700
Message-ID: <6501ea6b-5659-53ee-7ae0-7ad248844086@intel.com>
Date:   Fri, 5 Aug 2022 07:53:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
 <e828b48f-dcd8-6404-fc30-6e1dd682252f@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <e828b48f-dcd8-6404-fc30-6e1dd682252f@redhat.com>
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

On 8/5/22 07:22, David Hildenbrand wrote:
>> A list that sits besides the existing free_area, contains only >=pageblock
>> order sizes of unaccepted pages (no migratetype distinguished) and we tap
>> into it approximately before __rmqueue_fallback()? There would be some
>> trickery around releasing zone-lock for doing accept_memory(), but should be
>> manageable.
>>
> Just curious, do we have a microbenchmark that is able to reveal the
> impact of such code changes before we start worrying?

Nope.  I went looking to see if I could find any impact.  I think Kirill
did too.  Too bad that effort didn't make it into the changelog yet.

The merging check at least is just checking a field in a cache-hot
'struct page'.  The common case is probably three instructions:

	load to a register
	check the bit
	jump if not set

It adds a wee bit of icache pressure, but it's also the kind of thing
that should be a piece of cake for the branch predictors.

That dynamic check could easily be wrapped by a static branch.  But,
that first requires more code to go dig in the nooks and crannies of the
page allocator to make sure *ALL* pages are accepted.
