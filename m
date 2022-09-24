Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027A65E8699
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 02:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiIXAMf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 20:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiIXAMe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 20:12:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F892495E;
        Fri, 23 Sep 2022 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663978353; x=1695514353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G3CI1T3vaiOw+YTGkAQr9PkuUsYAHJ0lByNrxw7Sxsk=;
  b=gLTFHHMj4zCCLDDJ5KKa4FgY3t54vKBwWy82UrJpQwq6G2+go975EgBd
   bqnF3G++kV0V8BaLt+pAEijK0Hd0CiJ8ReX7zZyneKPS1YVYWORZxfABu
   22nIkYeq7DTOqiyzrZlkHoTlSks4JVzgWBstZ0q8s6eOUNmmqZnUoPkoI
   MofQHlZ2EKYkfwEuoBY8ixPNhuhM06on7hjoZzOWV15j9G2fxWosfEjIY
   yORi0wjfIt7bzf9HH2dryUXy8K/KUKFmy5Qq5uAXeuaHsBCJAgsPKGCLD
   Krj50UzO47BfBFRRnTSdfmW4bBioEVvK+rDBIYrzPqdmP6V9C2a1qOzS1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="283834799"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="283834799"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 17:12:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="653600785"
Received: from hanjulee-mobl1.amr.corp.intel.com (HELO [10.252.138.32]) ([10.252.138.32])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 17:12:31 -0700
Message-ID: <ca72bdfb-9868-162f-63d5-f778dd03db22@intel.com>
Date:   Fri, 23 Sep 2022 17:12:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
References: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
 <20220924000954.hhaghgkrb6h33nvq@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220924000954.hhaghgkrb6h33nvq@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/23/22 17:09, Kirill A. Shutemov wrote:
> On Fri, Sep 23, 2022 at 03:17:30PM -0700, Dave Hansen wrote:
>> The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
>> even have NX support.  Even PAE builds that support NX have to contend
>> with things like EFI data and code mixed in the same pages where W+X
>> is unavoidable.
>>
>> The folks still running X86_32=y kernels are unlikely to care much about
>> NX.  That combined with the fundamental inability fix _all_ of the W+X
>> things means this code had little value on X86_32=y.  Disable the checks.
> Maybe downgrade the check to a warning for X86_32=y?

But for this EFI case, we really don't want the warning.  It's unfixable.

I'm also not sure we want to go to the trouble to properly silence the
warning in these unfixable cases.  There was an argument elsewhere in
the thread that we really shouldn't be warning on things that we don't
have full intentions to fix.  I buy that argument.
