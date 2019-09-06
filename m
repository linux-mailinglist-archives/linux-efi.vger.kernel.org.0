Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059E4AC008
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2019 21:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405198AbfIFTAo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Sep 2019 15:00:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:19366 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405197AbfIFTAo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Sep 2019 15:00:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 12:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,474,1559545200"; 
   d="scan'208";a="384313381"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2019 12:00:41 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6JTM-0004KJ-BX; Fri, 06 Sep 2019 22:00:40 +0300
Date:   Fri, 6 Sep 2019 22:00:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Jean Delvare <jdelvare@suse.de>, kexec@lists.infradead.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        matt@codeblueprint.co.uk, ard.biesheuvel@linaro.org
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20190906190040.GA16211@smile.fi.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion>
 <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
 <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:
> On 12/16/16 at 02:33pm, Jean Delvare wrote:
> > On Fri, 16 Dec 2016 14:18:58 +0200, Andy Shevchenko wrote:
> > > On Fri, 2016-12-16 at 10:32 +0800, Dave Young wrote:
> > > > On 12/15/16 at 12:28pm, Jean Delvare wrote:
> > > > > I am no kexec expert but this confuses me. Shouldn't the second
> > > > > kernel have access to the EFI systab as the first kernel does? It
> > > > > includes many more pointers than just ACPI and DMI tables, and it
> > > > > would seem inconvenient to have to pass all these addresses
> > > > > individually explicitly.
> > > > 
> > > > Yes, in modern linux kernel, kexec has the support for EFI, I think it
> > > > should work naturally at least in x86_64.
> > > 
> > > Thanks for this good news!
> > > 
> > > Unfortunately Intel Galileo is 32-bit platform.
> > 
> > If it was done for X86_64 then maybe it can be generalized to X86?
> 
> For X86_64, we have a new way for efi runtime memmory mapping, in i386
> code it still use old ioremap way. It is impossible to use same way as
> the X86_64 since the virtual address space is limited.
> 
> But maybe for 32bit, kexec kernel can run in physical mode, but I'm not
> sure, I would suggest Andy to do a test first with efi=noruntime for
> kexec 2nd kernel.

Sorry for a delay.
Eventually I found time to check this.

Unfortunately the efi=noruntime didn't help:

# uname -a
Linux buildroot 5.3.0-rc7+ #17 Thu Sep 5 16:08:22 EEST 2019 i586 GNU/Linux
# dmidecode
# dmidecode 4.2
Scanning /dev/mem for entry point.
# No SMBIOS nor DMI entry point found, sorry.
#
# cat /proc/cmdline
... ignore_loglevel efi=noruntime earlycon=efifb acpi_rsdp=0xf01e014

So, I am all ears to anything else to try.

-- 
With Best Regards,
Andy Shevchenko


