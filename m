Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA329588E29
	for <lists+linux-efi@lfdr.de>; Wed,  3 Aug 2022 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiHCOCg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Aug 2022 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiHCOCe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Aug 2022 10:02:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425DE2CE1C;
        Wed,  3 Aug 2022 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659535352; x=1691071352;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=3kbiD6sIxSxAjVpFKmkjnzMfUr0hXQ3N3rtFHjcQbH4=;
  b=hx32VLxKoA7yyXx+uPpqfWeyh1L5SxpNJCDxVR1v/8QoGsH20dP+s3Mh
   J5uWD+xrZ4URuqYuj0ZQAf7lNeGHSRkElDAM3Uuakvwml+AL/el2o7VKQ
   CuAY5DxWDi4ROqj6Qv9aqr8ff50B9UJELoZeEMdSCL0HXEP4CxgOXXqdf
   Q4Vqqyf9cHkqDg7nt4MXwZt3JnegAxG3UEU5qd7hfAwk5GfQ+3GxaLPsC
   vLOyaJcpxQebQ8lTWf3JeOqVu/e2jnd0CJ6IovXjt0ucUJxNAVTgFp6eN
   GxbJeDuNd+El9dQtsgBKuYfmNrURhqNp1YvEx8yRbWINAN1XWyxGYzdts
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="375977435"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="375977435"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:02:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631159385"
Received: from buichris-mobl.amr.corp.intel.com (HELO [10.209.124.150]) ([10.209.124.150])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:02:30 -0700
Message-ID: <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com>
Date:   Wed, 3 Aug 2022 07:02:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Content-Language: en-US
From:   Dave Hansen <dave.hansen@intel.com>
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
 <Yt/ANO5usdV+JSSW@zn.tnic> <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
In-Reply-To: <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/2/22 16:46, Dave Hansen wrote:
> To sum it all up, I'm not happy with the complexity of the page
> acceptance code either but I'm not sure that it's bad tradeoff compared
> to greater #VE complexity or fragility.
> 
> Does anyone think we should go back and really reconsider this?

One other thing I remembered as I re-read my write up on this.

In the "new" mode, guests never get #VE's for unaccepted memory.  They
just exit to the host and can never be reentered.  They must be killed.

In the "old" mode, I _believe_ that the guest always gets a #VE for
non-EPT-present memory.  The #VE is basically the same no matter if the
page is unaccepted or if the host goes out and makes a
previously-accepted page non-present.

One really nasty implication of this "old" mode is that the host can
remove *accepted* pages that are used in the syscall gap.  That means
that the #VE handler would need to be of the paranoid variety which
opens up all kinds of other fun.

 * "Old" - #VE's can happen in the syscall gap
 * "New" - #VE's happen at better-defined times.  Unexpected ones are
   fatal.

There's a third option which I proposed but doesn't yet exist.  The TDX
module _could_ separate the behavior of unaccepted memory #VE's and
host-induced #VEs.  This way, we could use load_unaligned_zeropad() with
impunity and handle it in the #VE handler.  At the same time, the host
would not be allowed to remove accepted memory and cause problems in the
syscall gap.  Kinda the best of both worlds.

But, I'm not sure how valuable that would be now that we have the
(admittedly squirrelly) code to avoid load_unaligned_zeropad() #VE's.
