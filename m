Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B667C6C39
	for <lists+linux-efi@lfdr.de>; Thu, 12 Oct 2023 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjJLLZ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 07:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjJLLZ3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 07:25:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F091;
        Thu, 12 Oct 2023 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697109927; x=1728645927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oJ16RQQC6qiRD4UY3lzsspj/62XsaNODkFID0iZfpso=;
  b=bh/rByC8qy/JaE+twRevfZRfUkc0WyyVBSRFKMHN01g0bHiyGoe4fR69
   R7LSDACZCF7xpW6kSu04f8hIHKY/0Tsxs53mat1xiji+tUOZKhKFNz9jP
   MTZhGB3Vl6uGMQ/XmvxYtQbrbCUvkVO36a6sqwjiqB1Lu648mM3c9Y7+P
   M764vx/IpcKpho+98YbdZQk/7d4Zj3jQq0i9EzvF47tP+8ds6M4TNiKHV
   Ou+yz2GGPrMJ7rs1aGyrClTMNIbMlmWiSpcPtLgWdF+BKU7lVnAhddvzX
   OjVEDYiSRl9rZxfJaql+gqjsGgXojuhOZurPdgk3cN39EInmsqZFWNNcC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="387734532"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="387734532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:25:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783665676"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="783665676"
Received: from nmalinin-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.130])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:25:26 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 63E6E10A1B1; Thu, 12 Oct 2023 14:25:23 +0300 (+03)
Date:   Thu, 12 Oct 2023 14:25:23 +0300
From:   kirill.shutemov@linux.intel.com
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Don't try to print after ExitBootService()
Message-ID: <20231012112523.6koxkdrk72srx5og@box.shutemov.name>
References: <20231011192528.262425-1-nik.borisov@suse.com>
 <20231012101456.goamenepqlte65jv@box.shutemov.name>
 <8e36be57-58a6-404e-8828-6c777b8d2196@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e36be57-58a6-404e-8828-6c777b8d2196@suse.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 12, 2023 at 01:51:13PM +0300, Nikolay Borisov wrote:
> 
> 
> On 12.10.23 г. 13:14 ч., kirill.shutemov@linux.intel.com wrote:
> > On Wed, Oct 11, 2023 at 10:25:28PM +0300, Nikolay Borisov wrote:
> > > setup_e820() is executed after UEFI's ExitBootService has been called.
> > > This causes the firmware to throw an exception because Console IO
> > > protocol handler is supposed to work only during boot service
> > > environment. As per UEFI 2.9, section 12.1:
> > > 
> > >   "This protocol isused to handle input and output of text-based
> > >   information intended for the system user during the operation of code
> > >   in the boot services environment."
> > > 
> > > Running a TDX guest with TDVF with unaccepted memory disabled results in
> > > the following output:
> > 
> > Oh. My bad.
> > 
> > But there's other codepath that does the same. If setup_e820() fails with
> > EFI_BUFFER_TOO_SMALL, efi_stub_entry() would try to print "exit_boot()
> > failed\n".
> > 
> > I wouldner if it is feasible to hook up earlyprintk console into
> > efi_printk() machinery for after ExitBootService() case? Silent boot
> > failure is not the best UX.
> > 
> 
> 
> In my testing I was able to transpose setup_e820 and efi exit_boot_service
> by calling exit_boot_func before setup_e820 which ensures the various memory
> variables are populated. Is there any specific reason why ExitBootServices
> is called before setting up the e820 table? AFAIU this is an arbitrary
> choice?

Because if you allocate memory with EFI service it can alter EFI memory
map and we need the last version to convert it to e820.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
