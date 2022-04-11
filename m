Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3265A4FC242
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348424AbiDKQ3j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 12:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244728AbiDKQ3i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 12:29:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0AF31215;
        Mon, 11 Apr 2022 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649694444; x=1681230444;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/aHQQW61ELAgL2r5a3VbnJQ4DMr1/mD/2EjRSZ2mIbc=;
  b=j7eiuL0g24UYsefRpRN3vRTTS31A3QHFnQdOOxsREk5cUW34paTJRhID
   MDBZIEMiRzZUelROBU5LIuJWG9ZkbCroW2pZ2A52w6jAXltyBnCDQTTdD
   VG+W0fjx+KSMy3/jtCUdtDeE04Hcw/aKb6roDkFz2j3/BDwK5Kh2tJaUs
   wIS+VB05DZunau8C7hHRskaPXOFa8Xi24Ol5pLuDSHGKS0ur1gm4TCeZs
   AbZKuVGi6HyI0iSEDlcpViepjRf+xTEcqpOS5hJxZmYJ8Nie7LqQW0OV1
   VTVtpBoI2APo93vBZM5j8pSrR+c/uRUbc2Ntvv3w8SKillAbzgo4wtahM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261004641"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261004641"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:27:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="507173559"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6]) ([10.212.113.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:27:22 -0700
Message-ID: <fae338db-f892-b234-6918-227219e45cbe@intel.com>
Date:   Mon, 11 Apr 2022 09:27:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <20220409175210.xik3ue3shpagskvi@box.shutemov.name>
 <adc87911-e1f2-4e2a-2394-17ee9213ae3e@intel.com> <YlRPdQP5c1DQqZeN@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <YlRPdQP5c1DQqZeN@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/11/22 08:55, Borislav Petkov wrote:
> On Sun, Apr 10, 2022 at 11:41:57PM -0700, Dave Hansen wrote:
>> Let's just call out the possible (probable?) need for new ABI here.
>> Maybe it will cue folks who care to speak up.
> Err, why would you teach the user to go poke at some arbitrary sysfs
> nodes when the accepting code can simply issue a printk from time to
> time
> 
>   "Guest unnaccepted memory progress: XX%. This slows down operations at the moment."

I guess that's not a horrible place to start.  It's also not *horribly*
different from how guests work today.  If hosts lazily allocate RAM,
they'll see largely the same kind of behavior.

What ends up determining how much memory is pre-accepted versus being
done from the guest?  Is that just a normal part of setting up a TDX
guest, like from the qemu cmdline?  Or, is there some convention with
the virtual firmware?
