Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1055884E0
	for <lists+linux-efi@lfdr.de>; Wed,  3 Aug 2022 01:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiHBXqk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Aug 2022 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiHBXqk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Aug 2022 19:46:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58754673;
        Tue,  2 Aug 2022 16:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659483999; x=1691019999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6rXGmJONj6b+nIwOClpJuGcxiMNJkmRdeSvTUzrRYKw=;
  b=ewQmNbUhWJEhDFRchni37SDkuFJYWwsO549xArF+m0avudCnxywe/ej6
   wO1oivLgr+mEPgwMMF6r5LakoxYArgLJfDYQg1hR7JfbK5gADVw/27t1X
   6o5LtJhoHsH2AZOewI0V2dVZxIoDjJFLif8ehE3AIweiMfY1lbxswj41w
   aWAyK9nifE0bnl4YlPiwlc95z2Cz/i4T7nXuxzrPsLPmE0ke5xJAzlimj
   fIj1KEozGPklLWa0JBWcwXXc1wln5pQP7cG54n1kb/d2Vt2F8WYrz3Sfd
   48kIbt9+L2QtRAWmnaOjpQUm3LPN6oAfkeloEVYYzoHmOJVkjvAB261oB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269315114"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269315114"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 16:46:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="630919269"
Received: from ywagle-mobl.amr.corp.intel.com (HELO [10.209.29.213]) ([10.209.29.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 16:46:38 -0700
Message-ID: <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
Date:   Tue, 2 Aug 2022 16:46:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <Yt/ANO5usdV+JSSW@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yt/ANO5usdV+JSSW@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/26/22 03:21, Borislav Petkov wrote:
> On Tue, Jun 14, 2022 at 03:02:27PM +0300, Kirill A. Shutemov wrote:
>> But, this approach does not work for unaccepted memory. For TDX, a load
>> from unaccepted memory will not lead to a recoverable exception within
>> the guest. The guest will exit to the VMM where the only recourse is to
>> terminate the guest.
> FTR, this random-memory-access-to-unaccepted-memory-is-deadly thing is
> really silly. We should be able to handle such cases - because they do
> happen often - in a more resilient way. Just look at the complex dance
> this patch needs to do just to avoid this.
> 
> IOW, this part of the coco technology needs improvement.

This particular wound is self-inflicted.  The hardware can *today*
generate a #VE for these accesses.  But, to make writing the #VE code
more straightforward, we asked that the hardware not even bother
delivering the exception.  At the time, nobody could come up with a case
why there would ever be a legitimate, non-buggy access to unaccepted memory.

We learned about load_unaligned_zeropad() the hard way.  I never ran
into it and never knew it was there.  Dangit.

We _could_ go back to the way it was originally.  We could add
load_unaligned_zeropad() support to the #VE handler, and there's little
risk of load_unaligned_zeropad() itself being used in the
interrupts-disabled window early in the #VE handler.  That would get rid
of all the nasty adjacent page handling in the unaccepted memory code.

But, that would mean that we can land in the #VE handler from more
contexts.  Any normal, non-buggy use of load_unaligned_zeropad() can end
up there, obviously.  We would, for instance, need to be more careful
about #VE recursion.  We'd also have to make sure that _bugs_ that land
in the #VE handler can still be handled in a sane way.

To sum it all up, I'm not happy with the complexity of the page
acceptance code either but I'm not sure that it's bad tradeoff compared
to greater #VE complexity or fragility.

Does anyone think we should go back and really reconsider this?
