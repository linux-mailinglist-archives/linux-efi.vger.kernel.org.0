Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F3559EF1
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiFXQ5w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiFXQ5u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 12:57:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C19B4755A;
        Fri, 24 Jun 2022 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656089870; x=1687625870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h9unbbnqGQL7IjxvTCwmIkRm1Ll3fd9IcwkzJE10U7I=;
  b=bsTBGQmeizaqW9vIRm2s33WR7J1vq/z+d7hFuYqbmRk7DlzbHGjv5EBT
   NT/YSwqRHNYd6r5cx0lck8HkyiosUEFM/of24b+MXBlawqxMw8MKfgcZv
   i59ydHo6TZ1e1gXaIgo0GfkEuXxH6M+U3dJBHezTJtRqsD97rqjx/4hPN
   47LVfHot+kIy7JSxF0WWChvSWILvgQU+xlYT5ftGZ+bKx7sFG6kECPFyX
   lZ/mBmbuWg3Pk//Q6z2pprjD2XZ66cU7ynX/jRa/+Ad64PQ3U9xNjxAQ8
   aNVUAlBcb6L6aJ83HRx9SSU0WIXQbPhg1keAaXPAqDJH7hLG1PD6EWxf3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="342730540"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342730540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 09:57:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="731393321"
Received: from mdedeogl-mobl.amr.corp.intel.com (HELO [10.209.126.186]) ([10.209.126.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 09:57:48 -0700
Message-ID: <5af19000-4482-7eb9-f158-0a461891f087@intel.com>
Date:   Fri, 24 Jun 2022 09:57:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
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

Peter, is your enter key broken?  You seem to be typing all your text in
a single unreadable paragraph.

On 6/24/22 09:37, Peter Gonda wrote:
> if a customer incorrectly labels their image it may fail to boot..

You're saying that firmware basically has two choices:
1. Accept all the memory up front and boot slowly, but reliably
2. Use thus "unaccepted memory" mechanism, boot fast, but risk that the
   VM loses a bunch of memory.

If the guest can't even boot because of a lack of memory, then the
pre-accepted chunk is probably too small in the first place.

If the customer screws up, they lose a bunch of the RAM they paid for.
That seems like a rather self-correcting problem to me.
