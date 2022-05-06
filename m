Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82B851DC36
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443090AbiEFPgd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443091AbiEFPgV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 11:36:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9E6D951;
        Fri,  6 May 2022 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651851130; x=1683387130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LfMNbao3ZjCq5W5xkjvkRFQQK+D46fsTZ0ZtKYEZ5ow=;
  b=QKU/UUY7W6Ld1Wq88rJsnRi4nM5gqxnTWbRLg7XbnlKWXNR8kSoYs2Zx
   Inw3CzAsszIL+1HNbuRVlNjreDzB55pDyVRvUzjRcJn5pbbfl7mCT3sF7
   o1KJgeHoiAaH6YC96rf6k3MbMqJYTxh1YlslaLXpzLLHN1jLo8CCkp2w5
   dGG4u80GfKo6GF2BleaYLriQmcxmw4j/ZxvaVuF21+UshjjgMobjcL7C1
   zSg8CRpzC3VpXi7i9n8tj9RdYegDXNfoNoZx61GbdxNh+hU91NnEMDXpR
   3S8QwG9v7VuuiQnZ4GYCzDcdNa7yq0O9DvvOxlkaUQt1uDDbsG7LwlDBy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268101344"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268101344"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:32:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="812430096"
Received: from nnwaiwux-mobl.amr.corp.intel.com (HELO [10.212.56.26]) ([10.212.56.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:32:08 -0700
Message-ID: <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
Date:   Fri, 6 May 2022 08:32:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic>
 <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YnUYLDjIThbIz/Uf@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/6/22 05:44, Borislav Petkov wrote:
>> Dave Hansen pointed those out in a previuos patch serie, here is the
>> quote:
>>
>>> CXL devices will have normal RAM on them, be exposed as "System RAM" and
>>> they won't have encryption capabilities.  I think these devices were
>>> probably the main motivation for EFI_MEMORY_CPU_CRYPTO.
> So this would mean that if a system doesn't have CXL devices and has
> TME/SME/SEV-* enabled, then it is running with encrypted memory.
> 
> Which would then also mean, you don't need any of that code - you only
> need to enumerate CXL devices which, it seems, do not support memory
> encryption, and then state that memory encryption is enabled on the
> whole system, except for the memory of those devices.

CXL devices are just the easiest example to explain, but they are not
the only problem.

For example, Intel NVDIMMs don't support TDX (or MKTME with integrity)
since TDX requires integrity protection and NVDIMMs don't have metadata
space available.

Also, if this were purely a CXL problem, I would have expected this to
have been dealt with in the CXL spec alone.  But, this series is
actually driven by an ACPI spec.  That tells me that we'll see these
mismatched encryption capabilities in many more places than just CXL
devices.

