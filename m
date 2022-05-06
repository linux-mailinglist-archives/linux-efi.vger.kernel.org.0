Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DCA51DF3E
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383137AbiEFSr1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351134AbiEFSr0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 14:47:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A011562F4;
        Fri,  6 May 2022 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651862623; x=1683398623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bL2l0mBh/m3FqkVcFUlaW65j5IuY1hIrZKH10XD8PzQ=;
  b=hs1vrOAd70909DMUKmHXO7v3/98njzpSK/BZX5Xa8pk+S4yimTHTx3WT
   EmJvSwNq3QHydTw9QysVpbuGwI0l0zXfVzZN2e9IwotBJd7ATCbG+9rDM
   Y+vqR/aUHCDfvqiPi8MAbwp7BID8FFyEjTCzyusJ9AHjWZE41+q4niTLm
   xeWOpbTulY6YA+lB6Pq5sJAkoPDomRjXixvhcoSvmegDsBO5fVa+mu55c
   US67bYHnW74LaVG4Ajmt9JNuTlNwNPuoZ2tGqVMxEOucKJKcT6seT6d/m
   t8ZNA8Vn0JqzQiNCKLN/kwHhd1WaQwS1F4njttRyqVGebta6fzc+8FKPc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248452978"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248452978"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:43:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="695305666"
Received: from hgadiraj-mobl2.amr.corp.intel.com (HELO [10.212.44.56]) ([10.212.44.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:43:40 -0700
Message-ID: <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
Date:   Fri, 6 May 2022 11:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Content-Language: en-US
To:     Boris Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        platform-driver-x86@vger.kernel.org, daniel.gutson@eclypsium.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, alex.bazhaniuk@eclypsium.com,
        hughsient@gmail.com, Andy Shevchenko <andy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic>
 <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
 <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/6/22 11:25, Boris Petkov wrote:
> On May 6, 2022 6:14:00 PM UTC, Dave Hansen <dave.hansen@intel.com>
> wrote:
>> But, this interface will *work* both for the uniform and
>> non-uniform systems alike.
> And what would that additional information that some "node" -
> whatever "node" means nowadays - is not encrypted give you?

Tying it to the node ties it to the NUMA ABIs.  For instance, it lets
you say: "allocate memory with encryption capabilities" with a
set_mempolicy() to nodes that are enumerated as encryption-capable.

Imagine that we have a non-uniform system: some memory supports TDX (or
SEV-SNP) and some doesn't.  QEMU calls mmap() to allocate some guest
memory and then its ioctl()s to get its addresses stuffed into EPT/NPT.
 The memory might be allocated from anywhere, CPU_CRYPTO-capable or not.
 VM creation will fail because the (hardware-enforced) security checks
can't be satisfied on non-CPU_CRYPTO memory.

Userspace has no recourse to fix this.  It's just stuck.  In that case,
 the *kernel* needs to be responsible for ensuring that the backing
physical memory supports TDX (or SEV).

This node attribute punts the problem back out to userspace.  It gives
userspace the ability to steer allocations to compatible NUMA nodes.  If
something goes wrong, they can use other NUMA ABIs to inspect the
situation, like /proc/$pid/numa_maps.
