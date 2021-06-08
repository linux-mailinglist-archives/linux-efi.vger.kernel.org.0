Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC439F684
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhFHM1o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 08:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231993AbhFHM1o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Jun 2021 08:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623155150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jga5cgK+A8ydMUQlLBxVKdrh6U1IwpbLL2b3HyDvHoQ=;
        b=fUHqQNo/6RwSSGybkwRir1B+zjFbatU3jE5rwWqoQuX9rZz27KlArVl/Hps1d36NlZ32RQ
        VZZoVyLYUespN8S1U8TdCuxJcvzAW4tWiEemk/6fzFyvk9ORUdKsF9VL4pRyv+B080oC7f
        tqiH3CBC6E5ZGjj6Zw2HO6RopFm8Iu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-1Eiql0obMuq_UfswicDnmQ-1; Tue, 08 Jun 2021 08:25:49 -0400
X-MC-Unique: 1Eiql0obMuq_UfswicDnmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F3A31854E30;
        Tue,  8 Jun 2021 12:25:48 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-220.pek2.redhat.com [10.72.12.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38DA15C1BB;
        Tue,  8 Jun 2021 12:25:43 +0000 (UTC)
Date:   Tue, 8 Jun 2021 20:25:40 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com>
 <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL5U/zSb50SnbLgW@smile.fi.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06/07/21 at 08:18pm, Andy Shevchenko wrote:
> On Mon, Jun 07, 2021 at 07:22:21PM +0300, Andy Shevchenko wrote:
> > On Sat, Jun 05, 2021 at 03:51:05PM +0800, Dave Young wrote:
> > > On 06/02/21 at 11:53am, Andy Shevchenko wrote:
> > > > On Wed, Jun 02, 2021 at 11:42:14AM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > > > > > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > > > > > it has been done for ACPI RSDP.
> > > > > > 
> > > > > > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > > > > > particular the default I2C host speed is choosen based on DMI system
> > > > > > information and now gets it correct.
> > > > > 
> > > > > Still nothing happens for a while and problem still exists.
> > > > > Can we do something about it, please?
> > > 
> > > Seems I totally missed this thread. Old emails lost.
> > 
> > You can always access to it via lore :-)
> > https://lore.kernel.org/linux-efi/20161217105721.GB6922@dhcp-128-65.nay.redhat.com/T/#u

Thanks.  Hmm, this is for 32bit efi.  kexec efi boot support was only
added for 64bit. So if 32bit dmidecode does not work I'm not surprise.

> > 
> > (Okay, it's not full, but contains main parts anyway)
> > 
> > 
> > > The question Ard asked is to confirm if the firmware converted the
> > > SMBIOS3 addr to a virtual address after exit boot service. I do not
> > > remember some easy way to check it due to lost the context of the code.
> > > But you can try to check it via dmesg|grep SMBIOS both in normal boot
> > > and kexeced boot log.  And then compare if those addresses are
> > > identical.
> > > 
> > > If the SMBIOS3 addr in kexec kernel is different then it should have
> > > been modified by firmware. Then we need patch kernel and kexec-tools to
> > > support it.
> > > 
> > > You can try below patch to see if it works:
> > 
> > So, AFAIU I have to apply patch to kexec tools for the fist kernel + userspace
> > and apply kernel patch for the second kernel? Or it's all for the first one?
> > 
> > > apply a kexec-tools patch to kexec-tools if you do not use kexec -s
> > > (kexec_file_load):
> > 
> > Here is how we are using it:
> > https://github.com/andy-shev/buildroot/blob/intel/board/intel/common/netboot/udhcpc-script.sh#L54
> 
> Okay, thanks for the patches. I have applied them to both kernels, so the first
> one and second one are the same and kexec tools have a patch provided in the
> user space of the both kernels (only first one in use though).
> 
> Before applying your patch, I have reverted my hacks (as per this series).
> 
> Result is:
> 
> # uname -a
> Linux buildroot 5.13.0-rc5+ #1 SMP Mon Jun 7 19:49:40 EEST 2021 i586 GNU/Linux
> # dmidecode
> # dmidecode 3.3
> Scanning /dev/mem for entry point.
> # No SMBIOS nor DMI entry point found, sorry.
> 
> I.o.w. it does NOT fix the issue. My patches do (with a hint from user space).

As I said, since it is 32bit efi, so your test results are expected,
also no need to check the kernel log about SMBIOS3 address changed or
not.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thanks
Dave

