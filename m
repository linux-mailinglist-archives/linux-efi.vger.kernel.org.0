Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB610FCFD
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 13:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfLCMBd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 07:01:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25601 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbfLCMBd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 07:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575374491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSfNF4YHbcxbbA8NtVp0lm2q8g0hHPhwjrnfZaT1G4w=;
        b=DWRCsmPIPlcy5OtVLzZRIZjMU6dWbVsbb9buVQaZmWaoZDzG/60CixHCHKTsmhk40KmK+6
        Rj+HcP9NM+Fszbb52nQr5dmZu7QdOU5dcfmEr85KYwuhD4F4KSiRK3be0jKs81RE1wQv9C
        e2F1QNrRI3OfwOERCCI33uMVefL4Lv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-tMRc3LXxNxS-X7MySuq0LA-1; Tue, 03 Dec 2019 07:01:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7E1800D4C;
        Tue,  3 Dec 2019 12:01:25 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-100.pek2.redhat.com [10.72.12.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4518810016E8;
        Tue,  3 Dec 2019 12:01:19 +0000 (UTC)
Date:   Tue, 3 Dec 2019 20:01:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     James Morse <james.morse@arm.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191203120116.GB2606@dhcp-128-65.nay.redhat.com>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
 <20191129152700.GA8286@weiser.dinsnail.net>
 <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
 <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-eizr4+LZiM_EtusTjfwdM2Gho8Eq2o-sdo1vwD7GBKw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-eizr4+LZiM_EtusTjfwdM2Gho8Eq2o-sdo1vwD7GBKw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tMRc3LXxNxS-X7MySuq0LA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/03/19 at 10:01am, Ard Biesheuvel wrote:
> On Mon, 2 Dec 2019 at 09:05, Dave Young <dyoung@redhat.com> wrote:
> >
> > Add more cc
> > On 12/02/19 at 04:58pm, Dave Young wrote:
> > > On 11/29/19 at 04:27pm, Michael Weiser wrote:
> > > > Hello Dave,
> > > >
> > > > On Mon, Nov 25, 2019 at 01:52:01PM +0800, Dave Young wrote:
> > > >
> > > > > > > Fundamentally when deciding where to place a new kernel kexec=
 (either
> > > > > > > user space or the in kernel kexec_file implementation) needs =
to be able
> > > > > > > to ask the question which memory ares are reserved.
> > > > [...]
> > > > > > > So my question is why doesn't the ESRT reservation wind up in
> > > > > > > /proc/iomem?
> > > > > >
> > > > > > My guess is that the focus was that some EFI structures need to=
 be kept
> > > > > > around accross the life cycle of *one* running kernel and
> > > > > > memblock_reserve() was enough for that. Marking them so they su=
rvive
> > > > > > kexecing another kernel might just never have cropped up thus f=
ar. Ard
> > > > > > or Matt would know.
> > > > > Can you check your un-reserved memory, if your memory falls into =
EFI
> > > > > BOOT* then in X86 you can use something like below if it is not c=
overed:
> > > >
> > > > > void __init efi_esrt_init(void)
> > > > > {
> > > > > ...
> > > > >   pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, =
&end);
> > > > >   if (md.type =3D=3D EFI_BOOT_SERVICES_DATA)
> > > > >           efi_mem_reserve(esrt_data, esrt_data_size);
> > > > > ...
> > > > > }
> > > >
> > > > Please bear with me if I'm a bit slow on the uptake here: On my mac=
hine,
> > > > the esrt module reports at boot:
> > > >
> > > > [    0.001244] esrt: Reserving ESRT space from 0x0000000074dd2f98 t=
o 0x0000000074dd2fd0.
> > > >
> > > > This area is of type "Boot Data" (=3D=3D BOOT_SERVICES_DATA) which =
makes the
> > > > code you quote reserve it using memblock_reserve() shown by
> > > > memblock=3Ddebug:
> > > >
> > > > [    0.001246] memblock_reserve: [0x0000000074dd2f98-0x0000000074dd=
2fcf] efi_mem_reserve+0x1d/0x2b
> > > >
> > > > It also calls into arch/x86/platform/efi/quirks.c:efi_arch_mem_rese=
rve()
> > > > which tags it as EFI_MEMORY_RUNTIME while the surrounding ones aren=
't
> > > > as shown by efi=3Ddebug:
> > > >
> > > > [    0.178111] efi: mem10: [Boot Data          |   |  |  |  |  |  |=
  |  |   |WB|WT|WC|UC] range=3D[0x0000000074dd3000-0x0000000075becfff] (14M=
B)
> > > > [    0.178113] efi: mem11: [Boot Data          |RUN|  |  |  |  |  |=
  |  |   |WB|WT|WC|UC] range=3D[0x0000000074dd2000-0x0000000074dd2fff] (0MB=
)
> > > > [    0.178114] efi: mem12: [Boot Data          |   |  |  |  |  |  |=
  |  |   |WB|WT|WC|UC] range=3D[0x000000006d635000-0x0000000074dd1fff] (119=
MB)
> > > >
> > > > This prevents arch/x86/platform/efi/quirks.c:efi_free_boot_services=
()
> > > > from calling __memblock_free_late() on it. And indeed, memblock=3Dd=
ebug does
> > > > not report this area as being free'd while the surrounding ones are=
:
> > > >
> > > > [    0.178369] __memblock_free_late: [0x0000000074dd3000-0x00000000=
75becfff] efi_free_boot_services+0x126/0x1f8
> > > > [    0.178658] __memblock_free_late: [0x000000006d635000-0x00000000=
74dd1fff] efi_free_boot_services+0x126/0x1f8
> > > >
> > > > The esrt area does not show up in /proc/iomem though:
> > > >
> > > > 00100000-763f5fff : System RAM
> > > >   62000000-62a00d80 : Kernel code
> > > >   62c00000-62f15fff : Kernel rodata
> > > >   63000000-630ea8bf : Kernel data
> > > >   63fed000-641fffff : Kernel bss
> > > >   65000000-6affffff : Crash kernel
> > > >
> > > > And thus kexec loads the new kernel right over that area as shown w=
hen
> > > > enabling -DDEBUG on kexec_file.c (0x74dd3000 being inbetween 0x7300=
0000
> > > > and 0x73000000+0x24be000 =3D 0x754be000):
> > > >
> > > > [  650.007695] kexec_file: Loading segment 0: buf=3D0x000000003a9c8=
4d6 bufsz=3D0x5000 mem=3D0x98000 memsz=3D0x6000
> > > > [  650.007699] kexec_file: Loading segment 1: buf=3D0x0000000017b2b=
9e6 bufsz=3D0x1240 mem=3D0x96000 memsz=3D0x2000
> > > > [  650.007703] kexec_file: Loading segment 2: buf=3D0x00000000fdf72=
ba2 bufsz=3D0x1150888 mem=3D0x73000000 memsz=3D0x24be000
> > > >
> > > > ... because it looks for any memory hole large enough in iomem reso=
urces
> > > > tagged as System RAM, which 0x74dd2000-0x74dd2fff would then need t=
o be
> > > > excluded from on my system.
> > > >
> > > > Looking some more at efi_arch_mem_reserve() I see that it also regi=
sters
> > > > the area with efi.memmap and installs it using efi_memmap_install()=
.
> > > > which seems to call memremap(MEMREMAP_WB) on it. From my understand=
ing
> > > > of the comments in the source of memremap(), MEMREMAP_WB does speci=
fically
> > > > *not* reserve that memory in any way.
> > > >
> > > > > Unfortunately I noticed there are different requirements/ways for
> > > > > different types of "reserved" memory.  But that is another topic.=
.
> > > >
> > > > I tried to reserve the area with something like this:
> > > >
> > > > t a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > > > index 4de244683a7e..b86a5df027a2 100644
> > > > --- a/arch/x86/platform/efi/quirks.c
> > > > +++ b/arch/x86/platform/efi/quirks.c
> > > > @@ -249,6 +249,7 @@ void __init efi_arch_mem_reserve(phys_addr_t ad=
dr, u64 size)
> > > >         efi_memory_desc_t md;
> > > >         int num_entries;
> > > >         void *new;
> > > > +       struct resource *res;
> > > >
> > > >         if (efi_mem_desc_lookup(addr, &md) ||
> > > >             md.type !=3D EFI_BOOT_SERVICES_DATA) {
> > > > @@ -294,6 +295,21 @@ void __init efi_arch_mem_reserve(phys_addr_t a=
ddr, u64 size)
> > > >         early_memunmap(new, new_size);
> > > >
> > > >         efi_memmap_install(new_phys, num_entries);
> > > > +
> > > > +       res =3D memblock_alloc(sizeof(*res), SMP_CACHE_BYTES);
> > > > +       if (!res) {
> > > > +               pr_err("Failed to allocate EFI io resource allocato=
r for "
> > > > +                               "0x%llx:0x%llx", mr.range.start, mr=
.range.end);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       res->start      =3D mr.range.start;
> > > > +       res->end        =3D mr.range.end;
> > > > +       res->name       =3D "EFI runtime";
> > > > +       res->flags      =3D IORESOURCE_MEM | IORESOURCE_BUSY;
> > > > +       res->desc       =3D IORES_DESC_NONE;
> > > > +
> > > > +       insert_resource(&iomem_resource, res);
> > > >  }
> > > >
> > > >  /*
> > > >
> > > > ... but failed miserably in terms of the kernel not booting because=
 I
> > > > have no experience whatsoever in programming and debugging early ke=
rnel
> > > > init. But I am somewhat keen to ride the learning curve here. :)
> > > >
> > > > Am I on the right track or were you a couple of leaps ahead of me
> > > > already and I just didn't get the question?
> > >
> > > It seems a serious problem, the EFI modified memmap does not get an
> > > /proc/iomem resource update, but kexec_file relies on /proc/iomem in
> > > X86.
> > >
> > > Can you try below diff see if it works for you? (not tested, and need
> > > explicitly 'add_efi_memmap' in kernel cmdline param)
> > >
> > > There is an question from Sai about why add_efi_memmap is not enabled=
 by
> > > default:
> > > https://www.spinics.net/lists/linux-mm/msg185166.html
> > >
> > > Long time ago the add_efi_memmap is only enabled in case we explict
> > > enable it on cmdline, I'm not sure if we can do it by default, maybe =
we
> > > should.   Need opinion from X86 maintainers..
> > >
> > > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > > index 43a82e59c59d..eddaac6131cf 100644
> > > --- a/arch/x86/include/asm/efi.h
> > > +++ b/arch/x86/include/asm/efi.h
> > > @@ -243,6 +243,7 @@ static inline bool efi_is_64bit(void)
> > >
> > >  extern bool efi_reboot_required(void);
> > >  extern bool efi_is_table_address(unsigned long phys_addr);
> > > +extern void do_add_efi_memmap(void);
> > >
> > >  #else
> > >  static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
> > > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.=
c
> > > index 425e025341db..39e28ec76522 100644
> > > --- a/arch/x86/platform/efi/efi.c
> > > +++ b/arch/x86/platform/efi/efi.c
> > > @@ -149,10 +149,12 @@ void __init efi_find_mirror(void)
> > >   * (zeropage) memory map.
> > >   */
> > >
> > > -static void __init do_add_efi_memmap(void)
> > > +void __init do_add_efi_memmap(void)
> > >  {
> > >       efi_memory_desc_t *md;
> > >
> > > +     if (!add_efi_memmap)
> > > +             return;
> > >       for_each_efi_memory_desc(md) {
> > >               unsigned long long start =3D md->phys_addr;
> > >               unsigned long long size =3D md->num_pages << EFI_PAGE_S=
HIFT;
> > > @@ -224,8 +226,7 @@ int __init efi_memblock_x86_reserve_range(void)
> > >       if (rv)
> > >               return rv;
> > >
> > > -     if (add_efi_memmap)
> > > -             do_add_efi_memmap();
> > > +     do_add_efi_memmap();
> > >
> > >       WARN(efi.memmap.desc_version !=3D 1,
> > >            "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
> > > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/q=
uirks.c
> > > index 3b9fd679cea9..cfda591e51e3 100644
> > > --- a/arch/x86/platform/efi/quirks.c
> > > +++ b/arch/x86/platform/efi/quirks.c
> > > @@ -496,6 +496,7 @@ void __init efi_free_boot_services(void)
> > >               pr_err("Could not install new EFI memmap\n");
> > >               return;
> > >       }
> > > +     do_add_efi_memmap();
> > >  }
> > >
> > >  /*
> >
>=20
> We are seeing related issues on ARM where memory referenced by UEFI
> configuration tables is clobbered by the kexec tools.

Oh, the arm implementation is quite different, not sure if these are
same issues although both looks reserved memory related :)

>=20
> Given that these tables may be located in EFI boot services data
> regions, which the kernel itself knows not to touch during early boot,
> I think the solution here is to teach the kexec userland tools to
> avoid such regions when placing the kernel, initrd and other bits
> (such as the DT on ARM) in memory.
>=20

It seems hard to do so, the boot services data is only awared as EFI
memory descriptors, and some of them are freed and regarded as System
RAM in /proc/iomem,  but part of them eg. BGRT image part are kept as
reserved and with md attribute EFI_MEMORY_RUNTIME, these reserved part
are not showed as Reserved in /proc/iomem resources.

Also we have both userland kexec loader and the in kernel loader
kexec_file_load, so it sounds better if we can fix in kernel to mark them a=
s reserved
resources?

Thanks
Dave

