Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6697C6AB5
	for <lists+linux-efi@lfdr.de>; Thu, 12 Oct 2023 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjJLKPE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJLKPD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 06:15:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372D9D;
        Thu, 12 Oct 2023 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697105701; x=1728641701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYC9BvIZGZ9sEAjxJUBPvKlJQCnqSQLaN/33GRubX9w=;
  b=llBmfMiwz7U6zf/cjNLj2N8EMxkOhthz5X31ICzD/Y/jli7yH/KVeefN
   wSZfTSdgsBq+cK7SKcq6FhRDBuUE73fvo9swc0wUGwLfLVgW8RUcsibkG
   jstnTScc8CxlnN+J/uAmaSNYXakceWo+7yw0VNfn+iUiODpWLg3jwu1+3
   UU9j50tWWMw4RLv91DoYTDzZec3S97Gr905qqPUaov3APW6FYD4iiNtMQ
   IZVG3be70MrOehNf8BRQpoxSgPj0wlwdZwJmCPSEt1X2nuV6moZuPeuDc
   GTLZlwGxtB+DxJ5/nrBHp+iu2RnKUG2eC7KCnZRDlsnPdVOo/Zcq+lMct
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383747368"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="383747368"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="878059340"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="878059340"
Received: from nmalinin-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.130])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:14:59 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B666810A1B1; Thu, 12 Oct 2023 13:14:56 +0300 (+03)
Date:   Thu, 12 Oct 2023 13:14:56 +0300
From:   kirill.shutemov@linux.intel.com
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Don't try to print after ExitBootService()
Message-ID: <20231012101456.goamenepqlte65jv@box.shutemov.name>
References: <20231011192528.262425-1-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011192528.262425-1-nik.borisov@suse.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 11, 2023 at 10:25:28PM +0300, Nikolay Borisov wrote:
> setup_e820() is executed after UEFI's ExitBootService has been called.
> This causes the firmware to throw an exception because Console IO
> protocol handler is supposed to work only during boot service
> environment. As per UEFI 2.9, section 12.1:
> 
>  "This protocol isused to handle input and output of text-based
>  information intended for the system user during the operation of code
>  in the boot services environment."
> 
> Running a TDX guest with TDVF with unaccepted memory disabled results in
> the following output:

Oh. My bad.

But there's other codepath that does the same. If setup_e820() fails with
EFI_BUFFER_TOO_SMALL, efi_stub_entry() would try to print "exit_boot()
failed\n".

I wouldner if it is feasible to hook up earlyprintk console into
efi_printk() machinery for after ExitBootService() case? Silent boot
failure is not the best UX.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
