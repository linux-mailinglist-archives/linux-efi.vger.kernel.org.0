Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672E7055F2
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEPS1c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPS1b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 14:27:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C49E;
        Tue, 16 May 2023 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684261650; x=1715797650;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h1IC5Du4s+rB6lI+ZptTZERfabS0oTlbNW5MVGmb3FA=;
  b=Eq3EzPCUE/j5/hyIH+5inO79UjRCxodnSfG2mqrrJ7odbyg4hTUkNxcv
   H1OzcJQ03K2muavEDZ6s9B5+vAZC1H8Bq2oXBnGLUrICJmX85J1bqAz4i
   G/9Aa/VGsArQKcBkJkhd8ZzBpnORT2vzjAj+zvMw3VNvutRq+qs0M0OHq
   Rs6DtBWAUzJOtRaueViEcrA5IamvYuD1DEQZ2erF+wIgMy1jkowSR68+C
   Dqo0sR+N2uVf8pKtrDH+YPelVXC+ws3SuImaF4RE1KHB6g+PAW2kYaPtz
   R5FLSGGnSpXEFOFlldYYEOwS01r3X+8qQIuXlNmx4SUVbSfukmzEuCeXx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="351587627"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="351587627"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 11:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="771162721"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="771162721"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 11:27:16 -0700
Message-ID: <6fe42f66-819c-f2c8-176b-759c1c5a9cf5@intel.com>
Date:   Tue, 16 May 2023 11:27:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
 <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/16/23 11:08, Ard Biesheuvel wrote:
>> But, this approach does not work for unaccepted memory. For TDX, a load
>> from unaccepted memory will not lead to a recoverable exception within
>> the guest. The guest will exit to the VMM where the only recourse is to
>> terminate the guest.
>>
> Does this mean that the kernel maps memory before accepting it? As
> otherwise, I would assume that such an access would page fault inside
> the guest before triggering an exception related to the unaccepted
> state.

Yes, the kernel maps memory before accepting it (modulo things like
DEBUG_PAGEALLOC).

