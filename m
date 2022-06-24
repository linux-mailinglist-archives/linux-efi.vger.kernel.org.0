Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3555A02F
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiFXRrr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiFXRrq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:47:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FD3369DB;
        Fri, 24 Jun 2022 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656092866; x=1687628866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=shiV5Ay7GQ2Tu/mMj01l+eBCIevTWE/G5toVrHbXBHM=;
  b=btafN/P26gOL70qYu3508Depm7xGwVB1BOuS/OEjzauNePbkvmfzkVHH
   pEyg7Slr9Xw9YOKSvn0pozNlmrc4MQ6OGZQ5hH/27pZP+x0lclSU1x4wl
   pE1Qi+WThdR3pLcbXY13fZqTzW0Y/L8pb0puxI4LxCEVYg+d7YchIJXG+
   LXtLSpsdP72vWgirQYnmvD0DLOvE9D/cT3RB7RPPTa76J9fjA8hA6BQR6
   jVr1S6jeYqSD9IiOGD5aO/vnlOUtWmC9PNw6lFAmnuVwzygeXA76KSyQ+
   soEXTcLBND8HgJ2VNQti54d46NIBWDbSiEH/vpw07K2tLLAjQRGYwDsEa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="342741407"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342741407"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 10:47:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="731410181"
Received: from mdedeogl-mobl.amr.corp.intel.com (HELO [10.209.126.186]) ([10.209.126.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 10:47:43 -0700
Message-ID: <1e7ad728-d796-c84d-b7ba-b96d8f9fcd0c@intel.com>
Date:   Fri, 24 Jun 2022 10:47:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Content-Language: en-US
To:     Marc Orr <marcorr@google.com>
Cc:     Peter Gonda <pgonda@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Marcelo <marcelo.cerri@canonical.com>, tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <5af19000-4482-7eb9-f158-0a461891f087@intel.com>
 <CAA03e5F480=psSECDAkXQEvNKk3une-4dJV57Hde4z4MMzh=1A@mail.gmail.com>
 <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com>
 <CAA03e5HxiLkOUbOrsgbzVdAUNZvnnryuNcqrz1ZWECtWLwKMXA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAA03e5HxiLkOUbOrsgbzVdAUNZvnnryuNcqrz1ZWECtWLwKMXA@mail.gmail.com>
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

On 6/24/22 10:19, Marc Orr wrote:
>> Is this a matter of
>>
>>         can boot from a guest firmware that doesn't pre-validate all the
>>         guest memory?
>>
>> or
>>
>>         can boot from a guest firmware that doesn't pre-validate all the
>>         guest memory ... with access to all of that guest's RAM?
>>
>> In other words, are we talking about "fails to boot" or "can't see all
>> the RAM"?
> Ah... yeah, you're right, Dave -- I guess it's the latter. The guest
> won't have access to all of the memory that the customer is paying
> for. But that's still bad. If the customer buys a 96 GB VM and can
> only see 4GB because they're kernel doesn't have these patches they're
> going to be confused and frustrated.

They'll at least be a _bit_ less angry and frustrated than if they were
staring at a blank screen. ;)  But, yeah, I totally get the point.

How big is the window going to be where we have guests that can have
unaccepted memory, but don't have acceptance support?  For TDX, it's
looking like it'll probably _just_ be 5.19.  Is TDX on 5.19 in shape
that cloud providers can deploy it?  Or, is stuff like lack of
attestation a deal breaker?

