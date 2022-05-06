Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F25851DEF1
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 20:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiEFSTg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 14:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390808AbiEFSSO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 14:18:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A36E8FE;
        Fri,  6 May 2022 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651860844; x=1683396844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WizXc0R3BJTlovfE/8nWaCi8wLxJyfq2X70P9CYgneY=;
  b=Nt6KVKoAJx/UyC2TCKY/WmsNmcFLkdYXPB973USQLk654sxB7knmaLqN
   H/22pgspLeiRiWhbku69vm+A3oCcACkS5U/pGARvx6r32aH3jp5a1nlOj
   M/AJ6k21303jzbIAA/Zgpd8Xh65SCogjGcPb90ZdO3YXa/+5u1OwHX9yK
   GDQRHB5ntaD3TurVb2nzZgU0hXSZDcE3EmDhEi2zsFyghu8xzfU6eK6ig
   CZV+Jsr323QVAc7dEjhXp6xVwMmpLCsRmCM/KTOQ+h+OTzXNLlKjgPkU6
   oIrxttoKSGGUX+tu4Uv1IDK/+4fXDW8KEIPSyeu626wHO/sKGmii4L5lj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="329084903"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="329084903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:14:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="695293311"
Received: from hgadiraj-mobl2.amr.corp.intel.com (HELO [10.212.44.56]) ([10.212.44.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:14:01 -0700
Message-ID: <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
Date:   Fri, 6 May 2022 11:14:00 -0700
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
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, daniel.gutson@eclypsium.com,
        "H. Peter Anvin" <hpa@zytor.com>, alex.bazhaniuk@eclypsium.com,
        hughsient@gmail.com, Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic>
 <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/6/22 10:55, Boris Petkov wrote:
> So here's the deal: we can say in the kernel that memory encryption
> is enabled and active.  But then all those different devices and so
> on,  can or cannot support encryption. IO devices do not support
> encryption either, afaict.

At least on MKTME platforms, if a device does DMA to a physical address
with the KeyID bits set, it gets memory encryption.  That's because all
the encryption magic is done in the memory controller itself.  The CPU's
memory controller doesn't actually care if the access comes from a
device or a CPU as long as the right physical bits are set.

The reason we're talking about this in terms of CXL devices is that CXL
devices have their *OWN* memory controllers.  Those memory controllers
might or might not support encryption.

> But that is not the question - they don't wanna say in fwupd whether
> every transaction was encrypted or not - they wanna say that
> encryption is active. And that we can give them now.

The reason we went down this per-node thing instead of something
system-wide is EFI_MEMORY_CPU_CRYPTO.  It's in the standard because EFI
systems are not expected to have uniform crypto capabilities across the
entire memory map.  Some memory will be capable of CPU crypto and some not.

As an example, if I were to build a system today with TDX and NVDIMMs,
I'd probably mark the RAM as EFI_MEMORY_CPU_CRYPTO=1 and the NVDIMMs as
EFI_MEMORY_CPU_CRYPTO=0.

I think you're saying that current AMD SEV systems have no need for
EFI_MEMORY_CPU_CRYPTO since their encryption capabilities *ARE* uniform.
 I'm not challenging that at all.  This interface is total overkill for
systems with guaranteed uniform encryption capabilities.

But, this interface will *work* both for the uniform and non-uniform
systems alike.
