Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EFB3A6CBE
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 19:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhFNRKA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 13:10:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:27173 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234056AbhFNRJ7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 13:09:59 -0400
IronPort-SDR: 5rJdn/tN7TQkKY8GtrKjIKfAw4xEas4+dr4gOJGFiRlioUlnHSebn3PfkpBT1jcUbQErQ9iPM6
 qQJSvIfMmU7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="186219185"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="186219185"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 10:07:39 -0700
IronPort-SDR: 4XeDyNei1DGThgPXtXTDeh7EMz9LgxDeeJpLhA64s4Vd/30J39NLMDB1xVHIyZu/YZjYL0+sT3
 5d8XfE5Y2JyA==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="420841276"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 10:07:37 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lsq3h-002Hnw-QP; Mon, 14 Jun 2021 20:07:33 +0300
Date:   Mon, 14 Jun 2021 20:07:33 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
References: <YLdEZoSWI41fcTB1@smile.fi.intel.com>
 <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com>
 <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMd39tIPercgljll@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 14, 2021 at 06:38:30PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 12, 2021 at 12:40:57PM +0800, Dave Young wrote:
> > > Probably it is doable to have kexec on 32bit efi working
> > > without runtime service support, that means no need the trick of fixed
> > > mapping.
> > > 
> > > If I can restore my vm to boot 32bit efi on this weekend then I may provide some draft
> > > patches for test.
> > 
> > Unfortunately I failed to setup a 32bit efi guest,  here are some
> > untested draft patches, please have a try.
> 
> Thanks for the patches.
> 
> As previously, I have reverted my hacks and applied your patches (also I
> dropped patches from previous mail against kernel and kexec-tools) for both
> kernel and user space on first and second environments.
> 
> It does NOT solve the issue.
> 
> If there is no idea pops up soon, I'm going to resend my series that
> workarounds the issue.

Hold on, I may have made a mistake during testing. Let me retest this.

-- 
With Best Regards,
Andy Shevchenko


