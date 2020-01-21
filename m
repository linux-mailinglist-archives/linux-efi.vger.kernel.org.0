Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5151014409D
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2020 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUPhd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jan 2020 10:37:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:37228 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUPhd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Jan 2020 10:37:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 07:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="221738007"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2020 07:37:29 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1itvas-0007hw-Hr; Tue, 21 Jan 2020 17:37:30 +0200
Date:   Tue, 21 Jan 2020 17:37:30 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20200121153730.GZ32742@smile.fi.intel.com>
References: <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion>
 <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
 <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
 <20200120121927.GJ32742@smile.fi.intel.com>
 <87a76i9ksr.fsf@x220.int.ebiederm.org>
 <CAHp75VdjwWfqHtJ3n-UK_n5nzpgcpERbM+_9-Z3FrjJx7nHQzQ@mail.gmail.com>
 <CAKv+Gu-sVSWNYHEjzjOfbEryOR_XruwH=qQphq4uTXMLPK18tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-sVSWNYHEjzjOfbEryOR_XruwH=qQphq4uTXMLPK18tw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 21, 2020 at 12:18:03AM +0100, Ard Biesheuvel wrote:
> On Mon, 20 Jan 2020 at 23:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jan 20, 2020 at 9:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > > > On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:

...

> > > > Can we apply these patches for now until you will find better
> > > > solution?
> > >
> > > Not a chance.  The patches don't apply to any kernel in the git history.
> > >
> > > Which may be part of your problem.  You are or at least were running
> > > with code that has not been merged upstream.
> >
> > It's done against linux-next.
> > Applied clearly. (Not the version in this more than yearly old series
> > of course, that's why I told I can resend)
> >
> > > > P.S. I may resend them rebased on recent vanilla.
> > >
> > > Second.  I looked at your test results and they don't directly make
> > > sense.  dmidecode bypasses the kernel completely or it did last time
> > > I looked so I don't know why you would be using that to test if
> > > something in the kernel is working.
> > >
> > > However dmidecode failing suggests that the actual problem is something
> > > in the first kernel is stomping the dmi tables.
> >
> > See below.
> >
> > > Adding a command line option won't fix stomped tables.
> >
> > It provides a mechanism, which seems to be absent, to the second
> > kernel to know where to look for SMBIOS tables.
> >
> > > So what I would suggest is:
> > > a) Verify that dmidecode works before kexec.
> >
> > Yes, it does.
> >
> > > b) Test to see if dmidecode works after kexec.
> >
> > No, it doesn't.
> >
> > > c) Once (a) shows that dmidecode works and (b) shows that dmidecode
> > >    fails figure out what is stomping your dmi tables during or before
> > >    kexec and that is what should get fixed.
> >
> > The problem here as I can see it that EFI and kexec protocols are not
> > friendly to each other.
> > I'm not an expert in either. That's why I'm asking for possible
> > solutions. And this needs to be done in kernel to allow drivers to
> > work.
> >
> > Does the
> >
> > commit 4996c02306a25def1d352ec8e8f48895bbc7dea9
> > Author: Takao Indoh <indou.takao@jp.fujitsu.com>
> > Date:   Thu Jul 14 18:05:21 2011 -0400
> >
> >     ACPI: introduce "acpi_rsdp=" parameter for kdump
> >
> > description shed a light on this?
> >
> > > Now using a non-efi method of dmi detection relies on the
> > > tables being between 0xF0000 and 0x10000. AKA the last 64K
> > > of the first 1MiB of memory.  You might check to see if your
> > > dmi tables are in that address range.
> >
> > # dmidecode --no-sysfs
> > # dmidecode 3.2
> > Scanning /dev/mem for entry point.
> > # No SMBIOS nor DMI entry point found, sorry.
> >
> > === with patch applied ===
> > # dmidecode
> > ...
> >         Release Date: 03/10/2015
> > ...
> >
> > >
> > > Otherwise I suspect the good solution is to give efi it's own page
> > > tables in the kernel and switch to it whenever efi functions are called.
> > >
> >
> > > But on 32bit the Linux kernel has historically been just fine directly
> > > accessing the hardware, and ignoring efi and all of the other BIOS's.
> >
> > It seems not only for 32-bit Linux kernel anymore. MS Surface 3 runs
> > 64-bit code.
> >
> > > So if that doesn't work on Intel Galileo that is probably a firmware
> > > problem.
> >
> > It's not only about Galileo anymore.
> >
> 
> Looking at the x86 kexec EFI code, it seems that it has special
> handling for the legacy SMBIOS table address, but not for the SMBIOS3
> table address, which was introduced to accommodate SMBIOS tables
> living in memory that is not 32-bit addressable.
> 
> Could anyone check whether these systems provide SMBIOS 3.0 tables,
> and whether their address gets virtually remapped at ExitBootServices?

On Microsoft Surface 3 tablet:

=== First kernel ===

# uname -a

(Previously reported issue on)
Linux buildroot 4.13.0+ #39 SMP Tue Sep 5 14:58:23 EEST 2017 x86_64 GNU/Linux

(Updated today to)
Linux buildroot 5.4.0+ #2 SMP Tue Nov 26 15:36:31 EET 2019 x86_64 GNU/Linux

# ls -l /sys/firmware/dmi/tables/
total 0
-r--------    1 root     root           825 Jan 21 15:41 DMI
-r--------    1 root     root            31 Jan 21 15:41 smbios_entry_point

# od -Ax -tx1 /sys/firmware/dmi/tables/smbios_entry_point
000000 5f 53 4d 5f 0f 1f 02 08 6a 00 00 00 00 00 00 00
000010 5f 44 4d 49 5f e0 39 03 00 40 5b 7b 0f 00 27
00001f

# dmesg | grep -i dmi
[    0.000000] DMI: Microsoft Corporation Surface 3/Surface 3, BIOS 1.50410.78 03/10/2015
[    0.403058] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)

# dmesg | grep -i smb
[    0.000000] efi:  ESRT=0x7b7c6c98  ACPI=0x7ad5a000  ACPI 2.0=0x7ad5a000  SMBIOS=0x7b5f7d18
[    0.000000] SMBIOS 2.8 present.

=== kexec'ed kernel ===
# uname -a
(in both cases, see above `uname -a`, the same version)
Linux buildroot 5.5.0-rc7+ #161 SMP Tue Jan 21 15:50:02 EET 2020 x86_64 GNU/Linux

# dmidecode
# dmidecode 3.2
	Scanning /dev/mem for entry point.
# No SMBIOS nor DMI entry point found, sorry.

# dmidecode --no-sysfs
# dmidecode 3.2
	Scanning /dev/mem for entry point.
# No SMBIOS nor DMI entry point found, sorry.


-- 
With Best Regards,
Andy Shevchenko


