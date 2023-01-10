Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250A6643C4
	for <lists+linux-efi@lfdr.de>; Tue, 10 Jan 2023 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjAJO4p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 09:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjAJO4o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 09:56:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FABB1081;
        Tue, 10 Jan 2023 06:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673362603; x=1704898603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eBfaUhZOLcHd/sdh/6tGQyQ/jHfPZIRMgOQy3o8072o=;
  b=VWIL84QuHQwmX7QeN4Y5YVQ9jRki3fxJ4G+YwRBIYK/8A/YfHjI0SLtZ
   oeuaFlxyK2GcAAM1a8G8OjqeJu6m//rbQs+QIoySMk4Q4D7mA7dRwk0SW
   zeq477NrrX+cQxSTu5KsX6HXtQ7KZ0QweHtd8VOPe4k18WMIxLXATNUfO
   /AZQqv4THNGoVITEkhtifLEWVFvwuyScYTUbiFbIEE/OWyLUGtIrXr4lc
   1LGQXv6agaWel6t7W3KqdGcG1MPXgf4Ieea7ybOw+OP829C5Wt6i5CTWx
   wnvT0peMJNXSszKq7AZZQ+j37QU0wF7eVTu/gGD++KdreT1Jjs7s8yiSF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324399807"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="324399807"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 06:56:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689421438"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="689421438"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2023 06:56:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFG3M-00751G-06;
        Tue, 10 Jan 2023 16:56:40 +0200
Date:   Tue, 10 Jan 2023 16:56:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 1/2] efi/earlycon: Replace open coded strnchrnul()
Message-ID: <Y718p+yuKza/hJr7@smile.fi.intel.com>
References: <20221208221217.56354-1-andriy.shevchenko@linux.intel.com>
 <Y71u/Hn+khg/Nuj7@smile.fi.intel.com>
 <CAMj1kXEWLcBTR5z0aC9=n1rLT=Z2yMNW8D-HpLd6e8YCz1hMJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEWLcBTR5z0aC9=n1rLT=Z2yMNW8D-HpLd6e8YCz1hMJA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 10, 2023 at 03:15:28PM +0100, Ard Biesheuvel wrote:
> On Tue, 10 Jan 2023 at 14:58, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Dec 09, 2022 at 12:12:16AM +0200, Andy Shevchenko wrote:
> > > strnchrnul() can be called in the early stages. Replace
> > > open coded variant in the EFI early console driver.
> >
> > Any comments on the series?
> 
> Looks fine to me. Queued up in efi/next now.

Thank you and HNY!

-- 
With Best Regards,
Andy Shevchenko


