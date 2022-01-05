Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5A485A00
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbiAEU1W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 15:27:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:10654 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244017AbiAEU1O (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 5 Jan 2022 15:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641414434; x=1672950434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FSFWIc4HSv9YdqR3Ma1IzBH4Anr1q7MqPqL/vrhT98M=;
  b=MDf3a41GWsP02QDmKOrs8kN9dKULQKH+g69N9V/3gBpwK1OYq3xaomyr
   LiLRPzoZwL9+JeO7Zrh1YESjcvVpJqVIESFzqfhhU48UTagdvuzib1pjL
   lKx1LOL1Ml/CEkVZGx2A104a1Hvz1DOakoC4s89Y1h8RYlmWPFPgTBPxa
   sMr1DlI8qVhCLNX2nXpr3iAlhvuaPrHOSQTsLKGiwxdDokBHYpVCFGdi2
   KxpwcjDRnFmWjH+eYCW1Loghd/7dn5xa/lBCdvaFzxF99Ven/Xo+pYoTG
   L7f7yLqHjiVgSlqqJCrzI4ZvwgyTi4BHRAIZOQBR3POaYAh+wRI6dKSZG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229345941"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="229345941"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 12:27:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="760939957"
Received: from njvora-mobl.amr.corp.intel.com (HELO [10.212.154.74]) ([10.212.154.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 12:27:10 -0800
Message-ID: <acba0832-9b11-c93d-7903-fff33f740605@intel.com>
Date:   Wed, 5 Jan 2022 12:27:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
Content-Language: en-US
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com> <YdSKQKSTS83cRzGZ@dt>
 <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/5/22 11:52, Brijesh Singh wrote:
>>>           for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>>> +            /*
>>> +             * When SEV-SNP is active then transition the page to shared in the RMP
>>> +             * table so that it is consistent with the page table attribute change.
>>> +             */
>>> +            early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
>>
>> Shouldn't the first argument be vaddr as below?
> 
> Nope, sme_postprocess_startup() is called while we are fixing the 
> initial page table and running with identity mapping (so va == pa).

I'm not sure I've ever seen a line of code that wanted a comment so badly.
