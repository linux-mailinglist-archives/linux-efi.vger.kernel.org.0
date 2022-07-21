Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED857D03F
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jul 2022 17:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiGUPtp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jul 2022 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiGUPtk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Jul 2022 11:49:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E7CE24;
        Thu, 21 Jul 2022 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658418575; x=1689954575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cxrvSMixUSva/vWiltebPsIj2OtNtkjOCGTWpSyZWFU=;
  b=XXKtHJ0+GpkHO3LhMloMZuf/tQ8zaUPP53SsmrhAm/hgXro6IqN8BR9K
   rPKekpLEjD9LG5NKtOzzJyoLFqJLkQClRZsB5tgy+JfG5Pszmet29YzHX
   I6AtidlnO0YeNYRCg9Lf8jN/xPXGfPn3OySHVkrtmdVEyLVJhp8VfNSu7
   /I9WMGEXLTXC8cUmtGgRK81jvtQ2pJnS1Qn9NeHyqAQKb4ys81G2BUGff
   P1xdoAH1T61E/MqDhh8KGlVBUGLsg6MxFoXOrgfpOO73P08fzEE1n1s3B
   TGbs9txnEHOVpfUip+vOlxq3rvVp04sS2KUa6fbxZvmABT1JFW1mewwkP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267481965"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="267481965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:49:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573792891"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:49:32 -0700
Message-ID: <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
Date:   Thu, 21 Jul 2022 08:49:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <YtltYRuL+2uQkYUK@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YtltYRuL+2uQkYUK@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/21/22 08:14, Borislav Petkov wrote:
> On Tue, Jun 14, 2022 at 03:02:19PM +0300, Kirill A. Shutemov wrote:
>>     On-demand memory accept means latency spikes every time kernel steps
>>     onto a new memory block. The spikes will go away once workload data
>>     set size gets stabilized or all memory gets accepted.
> What does that mean?
> 
> If we're accepting 2M pages and considering referential locality, how
> are those "spikes" even noticeable?

Acceptance is slow and the heavy lifting is done inside the TDX module.
 It involves flushing old aliases out of the caches and initializing the
memory integrity metadata for every cacheline.  This implementation does
acceptance in 2MB chunks while holding a global lock.

So, those (effective) 2MB clflush+memset's (plus a few thousand cycles
for the hypercall/tdcall transitions) can't happen in parallel.  They
are serialized and must wait on each other.  If you have a few hundred
CPUs all trying to allocate memory (say, doing the first kernel compile
after a reboot), this is going to be very, very painful for a while.

That said, I think this is the right place to _start_.  There is going
to need to be some kind of follow-on solution (likely background
acceptance of some kind).  But, even with that solution, *this* code is
still needed to handle the degenerate case where the background accepter
can't keep up with foreground memory needs.
