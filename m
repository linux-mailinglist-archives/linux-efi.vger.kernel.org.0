Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3752D1DB
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiESLzj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiESLzh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 07:55:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5BB82FA;
        Thu, 19 May 2022 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652961335; x=1684497335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t8Pe4Q+TJHqdH7A97sboo3Z2TolIf8EzWhjhwNv7dsg=;
  b=Tj+4p/nOQpg9L2ypSsevkuzqvs1kG8dIkLkTpdW27YVIXrwDtmmL87Z1
   6ASJSKj3dB3HOAMJ+LMRWQYL2ZoVxmw/GDOGmMj5Pz5EEsW11L28fEKpP
   F21U/0dn8NLlQVs3+I6PjSKgEf4AYWv7qjAhVc2XBfQxVfe0Ji1BCaIqi
   AHNcnkmc4bvWMHr7Ro6CwOKPH2T80mPYXOD+gQaNR6pdLepL+SCxxF9Su
   s+JNuseUbcjxnMfm6PgU31BER2lXYLh+PWKWbK3YTyYrrN5tzhSSLvVFh
   uS/uphX/rUV0xMrTNZvuNd3FiYNug4Aaxix/lWxvlPauImCIAUyTVSkN9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270988936"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="270988936"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 04:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="556863492"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2022 04:55:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E88F0109; Thu, 19 May 2022 14:55:27 +0300 (EEST)
Date:   Thu, 19 May 2022 14:55:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv6 02/15] mm: Add support for unaccepted memory
Message-ID: <20220519115527.jqzrvsqk4o225m6d@black.fi.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
 <972b5335-98df-f7b2-4b4f-53695e684d8b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972b5335-98df-f7b2-4b4f-53695e684d8b@amd.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 19, 2022 at 12:43:15PM +0200, Gupta, Pankaj wrote:
> If both Intel TDX and AMD SEV-SNP requires the memory to be accepted before
> it can be used by the guest. In what other use cases (apart from memory
> hotplug), the lazy memory acceptance will be useful?

It is nothing to do with hotplug.

Any memory has to be accepted before it can be used inside the TDX or
SEV-SNP guest. It can happen upfront, before kernel gets control (like by
firmware) or by kernel. The idea is to accept small portion of the memory
upfront and leave the rest to the kernel. The reason why delaying
acceptance make sense is boot time. We want the guest to start doing
useful stuff as fast as possible.

-- 
 Kirill A. Shutemov
