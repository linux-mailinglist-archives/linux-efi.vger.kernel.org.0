Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87D39849F
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFBIzg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 04:55:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:48991 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhFBIzf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 04:55:35 -0400
IronPort-SDR: URL9a4AKTO1OP3yOojfWTja4CoK/uiMcrgYdVfNAFXJeS0uMt4NK7jEnvDRoU6uYNyzCy81vR5
 UjBT+BRRqinQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="225028228"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="225028228"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 01:53:51 -0700
IronPort-SDR: EGZAyGBJeu3qSCpxms65HELWLfWbZoR8DsCYmC9dwVEC+azcYFwkUiZetwahkG9yOU+jn+evtO
 4djqrXWJuD9g==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="411548964"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 01:53:49 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1loMdG-00GfBX-Re; Wed, 02 Jun 2021 11:53:46 +0300
Date:   Wed, 2 Jun 2021 11:53:46 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>
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
Message-ID: <YLdHGkQSi391EqIS@smile.fi.intel.com>
References: <20161215122856.7d24b7a8@endymion>
 <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
 <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
 <20200120121927.GJ32742@smile.fi.intel.com>
 <87a76i9ksr.fsf@x220.int.ebiederm.org>
 <CAHp75VdjwWfqHtJ3n-UK_n5nzpgcpERbM+_9-Z3FrjJx7nHQzQ@mail.gmail.com>
 <CAKv+Gu-sVSWNYHEjzjOfbEryOR_XruwH=qQphq4uTXMLPK18tw@mail.gmail.com>
 <YLdDSeYjgCaarCpN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLdDSeYjgCaarCpN@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fixed Ard's address

On Wed, Jun 02, 2021 at 11:37:29AM +0300, Andy Shevchenko wrote:
> On Tue, Jan 21, 2020 at 12:18:03AM +0100, Ard Biesheuvel wrote:
> > On Mon, 20 Jan 2020 at 23:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Mon, Jan 20, 2020 at 9:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > > > > On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:
> > > > >> Ccing efi people.
> > > > >>
> > > > >> On 12/16/16 at 02:33pm, Jean Delvare wrote:
> > > > >> > On Fri, 16 Dec 2016 14:18:58 +0200, Andy Shevchenko wrote:
> > > > >> > > On Fri, 2016-12-16 at 10:32 +0800, Dave Young wrote:
> > > > >> > > > On 12/15/16 at 12:28pm, Jean Delvare wrote:
> > > > >> > > > > I am no kexec expert but this confuses me. Shouldn't the second
> > > > >> > > > > kernel have access to the EFI systab as the first kernel does? It
> > > > >> > > > > includes many more pointers than just ACPI and DMI tables, and it
> > > > >> > > > > would seem inconvenient to have to pass all these addresses
> > > > >> > > > > individually explicitly.
> > > > >> > > >
> > > > >> > > > Yes, in modern linux kernel, kexec has the support for EFI, I think it
> > > > >> > > > should work naturally at least in x86_64.
> > > > >> > >
> > > > >> > > Thanks for this good news!
> > > > >> > >
> > > > >> > > Unfortunately Intel Galileo is 32-bit platform.
> > > > >> >
> > > > >> > If it was done for X86_64 then maybe it can be generalized to X86?
> > > > >>
> > > > >> For X86_64, we have a new way for efi runtime memmory mapping, in i386
> > > > >> code it still use old ioremap way. It is impossible to use same way as
> > > > >> the X86_64 since the virtual address space is limited.
> > > > >>
> > > > >> But maybe for 32bit, kexec kernel can run in physical mode, but I'm not
> > > > >> sure, I would suggest Andy to do a test first with efi=noruntime for
> > > > >> kexec 2nd kernel.
> > > > >
> > > > > Guys, it was quite a long no hear from you. As I told you the proposed work
> > > > > around didn't help. Today I found that Microsoft Surface 3 also affected
> > > > > by this.
> > > > >
> > > > > Can we apply these patches for now until you will find better
> > > > > solution?
> > > >
> > > > Not a chance.  The patches don't apply to any kernel in the git history.
> > > >
> > > > Which may be part of your problem.  You are or at least were running
> > > > with code that has not been merged upstream.
> > >
> > > It's done against linux-next.
> > > Applied clearly. (Not the version in this more than yearly old series
> > > of course, that's why I told I can resend)
> > >
> > > > > P.S. I may resend them rebased on recent vanilla.
> > > >
> > > > Second.  I looked at your test results and they don't directly make
> > > > sense.  dmidecode bypasses the kernel completely or it did last time
> > > > I looked so I don't know why you would be using that to test if
> > > > something in the kernel is working.
> > > >
> > > > However dmidecode failing suggests that the actual problem is something
> > > > in the first kernel is stomping the dmi tables.
> > >
> > > See below.
> > >
> > > > Adding a command line option won't fix stomped tables.
> > >
> > > It provides a mechanism, which seems to be absent, to the second
> > > kernel to know where to look for SMBIOS tables.
> > >
> > > > So what I would suggest is:
> > > > a) Verify that dmidecode works before kexec.
> > >
> > > Yes, it does.
> > >
> > > > b) Test to see if dmidecode works after kexec.
> > >
> > > No, it doesn't.
> > >
> > > > c) Once (a) shows that dmidecode works and (b) shows that dmidecode
> > > >    fails figure out what is stomping your dmi tables during or before
> > > >    kexec and that is what should get fixed.
> > >
> > > The problem here as I can see it that EFI and kexec protocols are not
> > > friendly to each other.
> > > I'm not an expert in either. That's why I'm asking for possible
> > > solutions. And this needs to be done in kernel to allow drivers to
> > > work.
> > >
> > > Does the
> > >
> > > commit 4996c02306a25def1d352ec8e8f48895bbc7dea9
> > > Author: Takao Indoh <indou.takao@jp.fujitsu.com>
> > > Date:   Thu Jul 14 18:05:21 2011 -0400
> > >
> > >     ACPI: introduce "acpi_rsdp=" parameter for kdump
> > >
> > > description shed a light on this?
> > >
> > > > Now using a non-efi method of dmi detection relies on the
> > > > tables being between 0xF0000 and 0x10000. AKA the last 64K
> > > > of the first 1MiB of memory.  You might check to see if your
> > > > dmi tables are in that address range.
> > >
> > > # dmidecode --no-sysfs
> > > # dmidecode 3.2
> > > Scanning /dev/mem for entry point.
> > > # No SMBIOS nor DMI entry point found, sorry.
> > >
> > > === with patch applied ===
> > > # dmidecode
> > > ...
> > >         Release Date: 03/10/2015
> > > ...
> > >
> > > >
> > > > Otherwise I suspect the good solution is to give efi it's own page
> > > > tables in the kernel and switch to it whenever efi functions are called.
> > > >
> > >
> > > > But on 32bit the Linux kernel has historically been just fine directly
> > > > accessing the hardware, and ignoring efi and all of the other BIOS's.
> > >
> > > It seems not only for 32-bit Linux kernel anymore. MS Surface 3 runs
> > > 64-bit code.
> > >
> > > > So if that doesn't work on Intel Galileo that is probably a firmware
> > > > problem.
> > >
> > > It's not only about Galileo anymore.
> > >
> > 
> > Looking at the x86 kexec EFI code, it seems that it has special
> > handling for the legacy SMBIOS table address, but not for the SMBIOS3
> > table address, which was introduced to accommodate SMBIOS tables
> > living in memory that is not 32-bit addressable.
> > 
> > Could anyone check whether these systems provide SMBIOS 3.0 tables,
> > and whether their address gets virtually remapped at ExitBootServices?
> 
> Can you tell how to do this and I will try to get information?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


