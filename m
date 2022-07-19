Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A057A90C
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jul 2022 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiGSVg5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbiGSVgy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 17:36:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD205C343;
        Tue, 19 Jul 2022 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658266614; x=1689802614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lZfxsCoZwidUXvUg1h38BCfji1GHOSEqDIubN9Z3IFE=;
  b=TtVDgTX2aNKX+WBJlsBLmOusKL3LgkIdb9dReAcUjpRMidATh4vxBVzM
   +EhEmFuxYP+zHr55nS9t1guguoacQlNKp/FwELwB6qF4q25dkXHO1Leps
   1CygA7v1E9ivn+klNXMPcxhxfc1TyNY4Q/J2MFaI3JKJm4F76ix1KLHvC
   rT1YMjlTmQ+TDaV0NuDIb0ScDGXwsdQfhieyHaSUj44XT26vru9i/tPb9
   jxHjyPMOxkUAuyxQKB185fn8rkqw7XLrgN7epIhj43h2XjznUNlT5VnVd
   leQaIdTMk+aqFipQEiX0htjQ2AoFlnO5n+gKespYI0lSMisXrUcBAARmR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372916179"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="372916179"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 14:35:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="687272611"
Received: from twliston-mobl1.amr.corp.intel.com (HELO [10.212.132.190]) ([10.212.132.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 14:35:45 -0700
Message-ID: <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
Date:   Tue, 19 Jul 2022 14:35:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
References: <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
 <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
 <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com>
 <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic>
 <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YtcgxxMyFTReuuRw@zn.tnic>
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

On 7/19/22 14:23, Borislav Petkov wrote:
> On Tue, Jul 19, 2022 at 10:45:06PM +0200, Ard Biesheuvel wrote:
>> So let's define a way for the EFI stub to signal to the firmware
>> (before EBS()) that it will take control of accepting memory. The
>> 'bootloader that calls EBS()' case can invent something along the
>> lines of what has been proposed in this thread to infer the
>> capabilities of the kernel (and decide what to signal to the
>> firmware). But we have no need for this additional complexity on
>> Linux.
> To tell you the truth, I've been perusing this thread from the sidelines
> and am wondering why does this need this special dance at all?
> 
> If EFI takes control of accepting memory, then when the guest kernel
> boots, it'll find all memory accepted and not do anything.
> 
> If EFI doesn't accept memory, then the guest kernel will boot and do the
> accepting itself.
> 
> So either I'm missing something or we're overengineering this for no
> good reason...

They're trying to design something that can (forever) handle guests that
might not be able to accept memory.  It's based on the idea that
*something* needs to assume control and EFI doesn't have enough
information to assume control.

I wish we didn't need all this complexity, though.

There are three entities that can influence how much memory is accepted:

1. The host
2. The guest firmware
3. The guest kernel (or bootloader or something after the firmware)

This whole thread is about how #2 and #3 talk to each other and make
sure *someone* does it.

I kinda think we should just take the guest firmware out of the picture.
 There are only going to be a few versions of the kernel that can boot
under TDX (or SEV-SNP) and *can't* handle unaccepted memory.  It seems a
bit silly to design this whole interface for a few versions of the OS
that TDX folks tell me can't be used anyway.

I think we should just say if you want to run an OS that doesn't have
unaccepted memory support, you can either:

1. Deal with that at the host level configuration
2. Boot some intermediate thing like a bootloader that does acceptance
   before running the stupid^Wunenlightended OS
3. Live with the 4GB of pre-accepted memory you get with no OS work.

Yeah, this isn't convenient for some hosts.  But, really, this is
preferable to doing an EFI/OS dance until the end of time.
