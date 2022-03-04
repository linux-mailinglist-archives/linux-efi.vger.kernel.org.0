Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380F64CD7A9
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 16:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiCDPYY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 10:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiCDPYY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 10:24:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FC13CEC8;
        Fri,  4 Mar 2022 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646407416; x=1677943416;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=8+CEXWwRwOMrbbF77tgElxSqFXtFdC2qH4kdmgKvO/8=;
  b=Ku2PX1M7qTskpAJoDfaZfr44hYgwjmKLKSxPUiaMNC6RKTBTpgK1Ybbv
   hjLNPXHdADnx24V3yH6fkiNiwLr36m723Q/khAKiOnaUuk+CyvbwFDdTD
   FPwx5W3Bmw/9Q9RrJMkP/TfladthCf40q3UJ1/tAL5kyYWt4Qc40SEWBA
   DBNxeIBj3fzZT+/w85PNIsfpGN1C1FEyW0XxEarqeFJpYFMiWjtX+VXqj
   DJUnw2Na35dgNqhbVBX/WjubWXDXjezcy9i3yLLUfEIskSr2D2SXLuDww
   LELWe4Js0Q2hrWLkQv/TSfW/KEi/byuJZBQVc5Ikm71v/0XkmUchFt2Bu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="241417941"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="241417941"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 07:23:36 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="640610291"
Received: from eabada-mobl2.amr.corp.intel.com (HELO [10.209.6.252]) ([10.209.6.252])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 07:23:34 -0800
Message-ID: <bd52a9ed-c44f-989f-60a0-f15dd4260e09@intel.com>
Date:   Fri, 4 Mar 2022 07:23:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-43-brijesh.singh@amd.com>
 <c85259c5-996c-902b-42b6-6b812282ee25@intel.com>
 <9c075b36-e450-831b-0ae2-3b680686beb4@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 42/45] virt: Add SEV-SNP guest driver
In-Reply-To: <9c075b36-e450-831b-0ae2-3b680686beb4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/4/22 05:17, Brijesh Singh wrote:
>> BTW, this look like a generic allocator thingy.  But it's only ever used
>> to allocate a 'struct snp_guest_msg'.  Why all the trouble to allocate
>> and free one fixed-size structure?  The changelog and comments don't
>> shed any light.
> The GHCB specification says that a guest must use shared memory for
> request, response, and certificate blob. In this patch, you are seeing
> that {alloc,free}_shared_pages() used only to alloc/free the request and
> response page. In the last patch, we used the same generic function to
> allocate the certificate blob with a different size (~16K) than 'struct
> snp_guest_msg.'

It sounds like it's worth a sentence or two in the changelog to explain
this new "allocator" and its future uses.
