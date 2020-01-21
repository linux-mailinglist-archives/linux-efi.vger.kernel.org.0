Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814F914431C
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2020 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAURYF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jan 2020 12:24:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:7131 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAURYF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Jan 2020 12:24:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 09:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="250323755"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 09:24:02 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1itxFz-0000qC-1l; Tue, 21 Jan 2020 19:24:03 +0200
Date:   Tue, 21 Jan 2020 19:24:03 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jean Delvare <jdelvare@suse.de>, Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20200121172403.GA32742@smile.fi.intel.com>
References: <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
 <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
 <20200120121927.GJ32742@smile.fi.intel.com>
 <87a76i9ksr.fsf@x220.int.ebiederm.org>
 <20200120224204.4e5cc0df@endymion>
 <CAHp75Veb02m3tU9tzZe912ZmX5mdaYkZ90DD67FVERJS15VsXw@mail.gmail.com>
 <20200121100359.6125498c@endymion>
 <87zheg93io.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zheg93io.fsf@x220.int.ebiederm.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 21, 2020 at 10:29:35AM -0600, Eric W. Biederman wrote:
> Jean Delvare <jdelvare@suse.de> writes:
> 
> > On Mon, 20 Jan 2020 23:55:43 +0200, Andy Shevchenko wrote:
> >> On Mon, Jan 20, 2020 at 11:44 PM Jean Delvare <jdelvare@suse.de> wrote:
> >> >
> >> > On Mon, 20 Jan 2020 10:04:04 -0600, Eric W. Biederman wrote:  
> >> > > Second.  I looked at your test results and they don't directly make
> >> > > sense.  dmidecode bypasses the kernel completely or it did last time
> >> > > I looked so I don't know why you would be using that to test if
> >> > > something in the kernel is working.  
> >> >
> >> > That must have been long ago. A recent version of dmidecode (>= 3.0)
> >> > running on a recent kernel  
> >> > (>= d7f96f97c4031fa4ffdb7801f9aae23e96170a6f, v4.2) will read the DMI  
> >> > data from /sys/firmware/dmi/tables, so it is very much relying on the
> >> > kernel doing the right thing. If not, it will still try to fallback to
> >> > reading from /dev/mem directly on certain architectures. You can force
> >> > that old method with --no-sysfs.
> >> >
> >> > Hope that helps,  
> >> 
> >> I don't understand how it possible can help for in-kernel code, like
> >> DMI quirks in a drivers.
> >
> > OK, just ignore me then, probably I misunderstood the point made by
> > Eric.
> 
> No.  I just haven't dived into this area of code in a long time.
> 
> It seems a little indirect to use dmidecode as the test to see if the
> kernel has the pointer to the dmitables, but with the knowledge you
> provided it seems like a perfectly valid test.

In any case that doesn't work. See my response to Ard.

-- 
With Best Regards,
Andy Shevchenko


