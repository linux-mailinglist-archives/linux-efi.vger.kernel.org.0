Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8810E768
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2019 10:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfLBJFg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Dec 2019 04:05:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbfLBJFf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Dec 2019 04:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575277534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAoDcpZsTZBeGAgb4FDu6Iu8xRQd3BKioUUXksqixrQ=;
        b=fBneG1cnsmmwoZJbvesaSEif1Mz1ZElbD7AV/ZKUaQVeqlvP0XunJryyOUhV69UG3HY+zq
        34sLyYHA/NNRgqdBOWnxzHiff3eVqBFiwnvo1xVngVR36xSmUpOB0RmOe84YF8PoL7SjHI
        QmpiReuTuwXrSosVwRPiDTXeVIrjZXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-twPDTInbNQyZkEM9W9Tjqw-1; Mon, 02 Dec 2019 04:05:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 357BB8017DF;
        Mon,  2 Dec 2019 09:05:29 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-203.pek2.redhat.com [10.72.12.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2443D5C21A;
        Mon,  2 Dec 2019 09:05:23 +0000 (UTC)
Date:   Mon, 2 Dec 2019 17:05:20 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Michael Weiser <michael@weiser.dinsnail.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
 <20191129152700.GA8286@weiser.dinsnail.net>
 <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: twPDTInbNQyZkEM9W9Tjqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add more cc
On 12/02/19 at 04:58pm, Dave Young wrote:
> On 11/29/19 at 04:27pm, Michael Weiser wrote:
> > Hello Dave,
> >=20
> > On Mon, Nov 25, 2019 at 01:52:01PM +0800, Dave Young wrote:
> >=20
> > > > > Fundamentally when deciding where to place a new kernel kexec (ei=
ther
> > > > > user space or the in kernel kexec_file implementation) needs to b=
e able
> > > > > to ask the question which memory ares are reserved.
> > [...]
> > > > > So my question is why doesn't the ESRT reservation wind up in
> > > > > /proc/iomem?
> > > >=20
> > > > My guess is that the focus was that some EFI structures need to be =
kept
> > > > around accross the life cycle of *one* running kernel and
> > > > memblock_reserve() was enough for that. Marking them so they surviv=
e
> > > > kexecing another kernel might just never have cropped up thus far. =
Ard
> > > > or Matt would know.
> > > Can you check your un-reserved memory, if your memory falls into EFI
> > > BOOT* then in X86 you can use something like below if it is not cover=
ed:
> >=20
> > > void __init efi_esrt_init(void)
> > > {
> > > ...
> > > =09pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &en=
d);
> > > =09if (md.type =3D=3D EFI_BOOT_SERVICES_DATA)
> > > =09=09efi_mem_reserve(esrt_data, esrt_data_size);
> > > ...
> > > }
> >=20
> > Please bear with me if I'm a bit slow on the uptake here: On my machine=
,
> > the esrt module reports at boot:
> >=20
> > [    0.001244] esrt: Reserving ESRT space from 0x0000000074dd2f98 to 0x=
0000000074dd2fd0.
> >=20
> > This area is of type "Boot Data" (=3D=3D BOOT_SERVICES_DATA) which make=
s the
> > code you quote reserve it using memblock_reserve() shown by
> > memblock=3Ddebug:
> >=20
> > [    0.001246] memblock_reserve: [0x0000000074dd2f98-0x0000000074dd2fcf=
] efi_mem_reserve+0x1d/0x2b
> >=20
> > It also calls into arch/x86/platform/efi/quirks.c:efi_arch_mem_reserve(=
)
> > which tags it as EFI_MEMORY_RUNTIME while the surrounding ones aren't
> > as shown by efi=3Ddebug:
> >=20
> > [    0.178111] efi: mem10: [Boot Data          |   |  |  |  |  |  |  | =
 |   |WB|WT|WC|UC] range=3D[0x0000000074dd3000-0x0000000075becfff] (14MB)
> > [    0.178113] efi: mem11: [Boot Data          |RUN|  |  |  |  |  |  | =
 |   |WB|WT|WC|UC] range=3D[0x0000000074dd2000-0x0000000074dd2fff] (0MB)
> > [    0.178114] efi: mem12: [Boot Data          |   |  |  |  |  |  |  | =
 |   |WB|WT|WC|UC] range=3D[0x000000006d635000-0x0000000074dd1fff] (119MB)
> >=20
> > This prevents arch/x86/platform/efi/quirks.c:efi_free_boot_services()
> > from calling __memblock_free_late() on it. And indeed, memblock=3Ddebug=
 does
> > not report this area as being free'd while the surrounding ones are:
> >=20
> > [    0.178369] __memblock_free_late: [0x0000000074dd3000-0x0000000075be=
cfff] efi_free_boot_services+0x126/0x1f8
> > [    0.178658] __memblock_free_late: [0x000000006d635000-0x0000000074dd=
1fff] efi_free_boot_services+0x126/0x1f8
> >=20
> > The esrt area does not show up in /proc/iomem though:
> >=20
> > 00100000-763f5fff : System RAM
> >   62000000-62a00d80 : Kernel code
> >   62c00000-62f15fff : Kernel rodata
> >   63000000-630ea8bf : Kernel data
> >   63fed000-641fffff : Kernel bss
> >   65000000-6affffff : Crash kernel
> >=20
> > And thus kexec loads the new kernel right over that area as shown when
> > enabling -DDEBUG on kexec_file.c (0x74dd3000 being inbetween 0x73000000
> > and 0x73000000+0x24be000 =3D 0x754be000):
> >=20
> > [  650.007695] kexec_file: Loading segment 0: buf=3D0x000000003a9c84d6 =
bufsz=3D0x5000 mem=3D0x98000 memsz=3D0x6000
> > [  650.007699] kexec_file: Loading segment 1: buf=3D0x0000000017b2b9e6 =
bufsz=3D0x1240 mem=3D0x96000 memsz=3D0x2000
> > [  650.007703] kexec_file: Loading segment 2: buf=3D0x00000000fdf72ba2 =
bufsz=3D0x1150888 mem=3D0x73000000 memsz=3D0x24be000
> >=20
> > ... because it looks for any memory hole large enough in iomem resource=
s
> > tagged as System RAM, which 0x74dd2000-0x74dd2fff would then need to be
> > excluded from on my system.
> >=20
> > Looking some more at efi_arch_mem_reserve() I see that it also register=
s
> > the area with efi.memmap and installs it using efi_memmap_install().
> > which seems to call memremap(MEMREMAP_WB) on it. From my understanding
> > of the comments in the source of memremap(), MEMREMAP_WB does specifica=
lly
> > *not* reserve that memory in any way.
> >=20
> > > Unfortunately I noticed there are different requirements/ways for
> > > different types of "reserved" memory.  But that is another topic..
> >=20
> > I tried to reserve the area with something like this:
> >=20
> > t a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > index 4de244683a7e..b86a5df027a2 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -249,6 +249,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, =
u64 size)
> >         efi_memory_desc_t md;
> >         int num_entries;
> >         void *new;
> > +       struct resource *res;
> > =20
> >         if (efi_mem_desc_lookup(addr, &md) ||
> >             md.type !=3D EFI_BOOT_SERVICES_DATA) {
> > @@ -294,6 +295,21 @@ void __init efi_arch_mem_reserve(phys_addr_t addr,=
 u64 size)
> >         early_memunmap(new, new_size);
> > =20
> >         efi_memmap_install(new_phys, num_entries);
> > +
> > +       res =3D memblock_alloc(sizeof(*res), SMP_CACHE_BYTES);
> > +       if (!res) {
> > +               pr_err("Failed to allocate EFI io resource allocator fo=
r "
> > +                               "0x%llx:0x%llx", mr.range.start, mr.ran=
ge.end);
> > +               return;
> > +       }
> > +
> > +       res->start      =3D mr.range.start;
> > +       res->end        =3D mr.range.end;
> > +       res->name       =3D "EFI runtime";
> > +       res->flags      =3D IORESOURCE_MEM | IORESOURCE_BUSY;
> > +       res->desc       =3D IORES_DESC_NONE;
> > +
> > +       insert_resource(&iomem_resource, res);
> >  }
> > =20
> >  /*
> >=20
> > ... but failed miserably in terms of the kernel not booting because I
> > have no experience whatsoever in programming and debugging early kernel
> > init. But I am somewhat keen to ride the learning curve here. :)
> >=20
> > Am I on the right track or were you a couple of leaps ahead of me
> > already and I just didn't get the question?
>=20
> It seems a serious problem, the EFI modified memmap does not get an
> /proc/iomem resource update, but kexec_file relies on /proc/iomem in
> X86.
>=20
> Can you try below diff see if it works for you? (not tested, and need
> explicitly 'add_efi_memmap' in kernel cmdline param)
>=20
> There is an question from Sai about why add_efi_memmap is not enabled by
> default:
> https://www.spinics.net/lists/linux-mm/msg185166.html
>=20
> Long time ago the add_efi_memmap is only enabled in case we explict
> enable it on cmdline, I'm not sure if we can do it by default, maybe we
> should.   Need opinion from X86 maintainers..
>=20
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 43a82e59c59d..eddaac6131cf 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -243,6 +243,7 @@ static inline bool efi_is_64bit(void)
> =20
>  extern bool efi_reboot_required(void);
>  extern bool efi_is_table_address(unsigned long phys_addr);
> +extern void do_add_efi_memmap(void);
> =20
>  #else
>  static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 425e025341db..39e28ec76522 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -149,10 +149,12 @@ void __init efi_find_mirror(void)
>   * (zeropage) memory map.
>   */
> =20
> -static void __init do_add_efi_memmap(void)
> +void __init do_add_efi_memmap(void)
>  {
>  =09efi_memory_desc_t *md;
> =20
> +=09if (!add_efi_memmap)
> +=09=09return;
>  =09for_each_efi_memory_desc(md) {
>  =09=09unsigned long long start =3D md->phys_addr;
>  =09=09unsigned long long size =3D md->num_pages << EFI_PAGE_SHIFT;
> @@ -224,8 +226,7 @@ int __init efi_memblock_x86_reserve_range(void)
>  =09if (rv)
>  =09=09return rv;
> =20
> -=09if (add_efi_memmap)
> -=09=09do_add_efi_memmap();
> +=09do_add_efi_memmap();
> =20
>  =09WARN(efi.memmap.desc_version !=3D 1,
>  =09     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirk=
s.c
> index 3b9fd679cea9..cfda591e51e3 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -496,6 +496,7 @@ void __init efi_free_boot_services(void)
>  =09=09pr_err("Could not install new EFI memmap\n");
>  =09=09return;
>  =09}
> +=09do_add_efi_memmap();
>  }
> =20
>  /*

