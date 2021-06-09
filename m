Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B243A138E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jun 2021 13:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhFIL6C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Jun 2021 07:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239645AbhFIL6B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Jun 2021 07:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623239766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsYYuHrua3D0nwfbXiXkP8WpKTH3SeSa8f6XqnxLdhM=;
        b=LrZsNxGGjwzHMsrG15ZTvBZIT7tceZWiEPPa9fQgvmXwXfPStLfpF9Mr534IOJLcbgiue7
        EwLQjs3rOwM8Ae6bQyuwLKRfAetOuExlMUYK513OCZ5mjARaHI9QSnUhS2l2Bu/kYBahh+
        vF+09QxlDxgVQSApWYOwRroR5AZw0vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-gJ5uh2mDNlChH6Z5_WPjqA-1; Wed, 09 Jun 2021 07:56:03 -0400
X-MC-Unique: gJ5uh2mDNlChH6Z5_WPjqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D17100A8EB;
        Wed,  9 Jun 2021 11:56:01 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 853AD60877;
        Wed,  9 Jun 2021 11:55:57 +0000 (UTC)
Date:   Wed, 9 Jun 2021 19:55:54 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com>
 <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06/08/21 at 03:38pm, Andy Shevchenko wrote:
> On Tue, Jun 8, 2021 at 3:29 PM Dave Young <dyoung@redhat.com> wrote:
> > On 06/07/21 at 08:18pm, Andy Shevchenko wrote:
> > > On Mon, Jun 07, 2021 at 07:22:21PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Jun 05, 2021 at 03:51:05PM +0800, Dave Young wrote:
> > > > > On 06/02/21 at 11:53am, Andy Shevchenko wrote:
> > > > > > On Wed, Jun 02, 2021 at 11:42:14AM +0300, Andy Shevchenko wrote:
> > > > > > > On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > > > > > > > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > > > > > > > it has been done for ACPI RSDP.
> > > > > > > >
> > > > > > > > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > > > > > > > particular the default I2C host speed is choosen based on DMI system
> > > > > > > > information and now gets it correct.
> > > > > > >
> > > > > > > Still nothing happens for a while and problem still exists.
> > > > > > > Can we do something about it, please?
> > > > >
> > > > > Seems I totally missed this thread. Old emails lost.
> > > >
> > > > You can always access to it via lore :-)
> > > > https://lore.kernel.org/linux-efi/20161217105721.GB6922@dhcp-128-65.nay.redhat.com/T/#u
> >
> > Thanks.  Hmm, this is for 32bit efi.  kexec efi boot support was only
> > added for 64bit. So if 32bit dmidecode does not work I'm not surprise.
> >
> > > >
> > > > (Okay, it's not full, but contains main parts anyway)
> > > >
> > > >
> > > > > The question Ard asked is to confirm if the firmware converted the
> > > > > SMBIOS3 addr to a virtual address after exit boot service. I do not
> > > > > remember some easy way to check it due to lost the context of the code.
> > > > > But you can try to check it via dmesg|grep SMBIOS both in normal boot
> > > > > and kexeced boot log.  And then compare if those addresses are
> > > > > identical.
> > > > >
> > > > > If the SMBIOS3 addr in kexec kernel is different then it should have
> > > > > been modified by firmware. Then we need patch kernel and kexec-tools to
> > > > > support it.
> > > > >
> > > > > You can try below patch to see if it works:
> > > >
> > > > So, AFAIU I have to apply patch to kexec tools for the fist kernel + userspace
> > > > and apply kernel patch for the second kernel? Or it's all for the first one?
> > > >
> > > > > apply a kexec-tools patch to kexec-tools if you do not use kexec -s
> > > > > (kexec_file_load):
> > > >
> > > > Here is how we are using it:
> > > > https://github.com/andy-shev/buildroot/blob/intel/board/intel/common/netboot/udhcpc-script.sh#L54
> > >
> > > Okay, thanks for the patches. I have applied them to both kernels, so the first
> > > one and second one are the same and kexec tools have a patch provided in the
> > > user space of the both kernels (only first one in use though).
> > >
> > > Before applying your patch, I have reverted my hacks (as per this series).
> > >
> > > Result is:
> > >
> > > # uname -a
> > > Linux buildroot 5.13.0-rc5+ #1 SMP Mon Jun 7 19:49:40 EEST 2021 i586 GNU/Linux
> > > # dmidecode
> > > # dmidecode 3.3
> > > Scanning /dev/mem for entry point.
> > > # No SMBIOS nor DMI entry point found, sorry.
> > >
> > > I.o.w. it does NOT fix the issue. My patches do (with a hint from user space).
> >
> > As I said, since it is 32bit efi, so your test results are expected,
> > also no need to check the kernel log about SMBIOS3 address changed or
> > not.
> 
> So, what shall I do? It's already 5 years passed without any progress
> while my patches definitely help here.
> Should I rebase and resubmit?

Probably it is doable to have kexec on 32bit efi working
without runtime service support, that means no need the trick of fixed
mapping.

If I can restore my vm to boot 32bit efi on this weekend then I may provide some draft
patches for test.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

Thanks
Dave

