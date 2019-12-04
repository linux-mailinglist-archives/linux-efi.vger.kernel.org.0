Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62415112258
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 06:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfLDFWS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 00:22:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49691 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbfLDFWR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 00:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575436936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92CBU2Ty+dwDpFTMX4aM10Q30OyEhz7K16TwsMGdXwM=;
        b=h0Oslm1dIh27aAGIdrBD0zDKYRezmbD7gAL0dj1yucGwV2MTsm1zAt/kHRxjIyFGisQvRs
        FUqC4TrIhl/M9H4RTnqUGv+v1IjGBw7w6CgAgaHcZIGvXtorPxU6/ehqnpDLmevO5kmT7I
        bPGSHNSkBFMyvJmSm9agdRS6l4dkXXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-SATqPsZZOmSjNgVSUFE58g-1; Wed, 04 Dec 2019 00:22:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 955B810054E3;
        Wed,  4 Dec 2019 05:22:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C083319C69;
        Wed,  4 Dec 2019 05:22:05 +0000 (UTC)
Date:   Wed, 4 Dec 2019 13:22:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Michael Weiser <michael@weiser.dinsnail.net>
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191204052201.GA2665@dhcp-128-65.nay.redhat.com>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
 <20191129152700.GA8286@weiser.dinsnail.net>
 <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
 <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
 <20191202234541.GA27567@weiser.dinsnail.net>
 <20191203115435.GA2606@dhcp-128-65.nay.redhat.com>
 <20191203211146.GA536@weiser.dinsnail.net>
MIME-Version: 1.0
In-Reply-To: <20191203211146.GA536@weiser.dinsnail.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SATqPsZZOmSjNgVSUFE58g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/03/19 at 10:11pm, Michael Weiser wrote:
> Hi Dave,
>=20
> On Tue, Dec 03, 2019 at 07:54:35PM +0800, Dave Young wrote:
>=20
> > > Neither adding add_efi_memmap nor adding your patch and setting that =
option
> > > does make the ESRT memory region appear in /proc/iomem. kexec_file st=
ill
> > > loads the kernel across the ESRT region.
> > Hmm, sorry, my bad, actuall add_efi_memmap does not consider the
> > EFI_MEMORY_RUNTIME attribute, it only reads the memory descriptor types=
.
>=20
> > Will read your replied information later, did not get time today, but
> > probably below chunk can help?
>=20
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/qui=
rks.c
> > index 3b9fd679cea9..516307617621 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -293,6 +293,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, =
u64 size)
> >  =09early_memunmap(new, new_size);
>=20
> >  =09efi_memmap_install(new_phys, num_entries);
> > +=09e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > +=09e820__update_table(e820_table);
> >  }
>=20
> >  /*
>=20
> Yes, that did it:
>=20
> 00000000-00000fff : Reserved
> 00001000-0009efff : System RAM
> 0009f000-000fffff : Reserved
>   000a0000-000bffff : PCI Bus 0000:00
>   000e0000-000e3fff : PCI Bus 0000:00
>   000e4000-000e7fff : PCI Bus 0000:00
>   000e8000-000ebfff : PCI Bus 0000:00
>   000ec000-000effff : PCI Bus 0000:00
>   000f0000-000fffff : PCI Bus 0000:00
>     000f0000-000fffff : System ROM
> 00100000-74dd1fff : System RAM
>   65000000-6affffff : Crash kernel
> 74dd2000-74dd2fff : Reserved                   <----- ESRT
> 74dd3000-763f5fff : System RAM
> 763f6000-79974fff : Reserved
> 79975000-799f1fff : ACPI Tables
> 799f2000-79aa6fff : ACPI Non-volatile Storage
>   79a17000-79a17fff : USBC000:00

Ok, good to know it works.  I will think about it and file a patch
later.  There are more things to consider, eg. kexec reboot multiple
times, userspace kexec loader etc.

If we choose to fix it in kexec_file path to avoid those region then we
need to do same in userspace, there will be compatibility issues so I
would still prefer to go with this way you tested.

BTW, on my laptop the ESRT stays in EFI runtime area so I do not see the
problem.  This should be machine/firmware specific.

Here is the info on my laptop:
[    0.000000] efi: mem34: [Runtime Data       |RUN|  |  |  |  |  |  |   |W=
B|WT|WC|UC] range=3D[0x000000007a4b0000-0x000000007a676fff] (1MB)
[    0.020670] esrt: Reserving ESRT space from 0x000000007a4ec000 to 0x0000=
00007a4ec088.

Thanks
Dave

