Return-Path: <linux-efi+bounces-843-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C52886764
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 08:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AA01F24BCF
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 07:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8BF10A3E;
	Fri, 22 Mar 2024 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6uG7uvk"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66DF1A38DF
	for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091888; cv=none; b=Js96YxaCixGwLsgIU1279XBmevSyfprl0P27XxNlcN71ja/08+51NsmRvL4xlDl5NVpzRI0A9DewTBEzwgqm8CHkFB4D7j533qzwRhv6KRxoBrH1ylsW2Hj6T32RsbbymoBpo5Or7FaTkJCZNpj+owAcV9YPViTCEoAaS/O38t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091888; c=relaxed/simple;
	bh=e6Qf8vCNzWVqdymqFnrpuJLlaOHDoVVmYrtgjJSF0UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtaOd7kEkO/gXqqZ096H12YGc634IYLGPq1zP4aUvcH2HF7SPpbB6BQE3vYWrxR2UhcAo69U7c1yknId1wb6UpGOJEmSYh2gJc8LxfZFdNb3ofr77+Blw8AVhWGFe5eOc2HxE+/JethZoeZ3O9dtSmZ60XWbGRoti96X3T9ShPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6uG7uvk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711091885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfLKWDJo3Ejx3ZbyTlRCuPz3OgymMWs+Pv+TUuu2Y6g=;
	b=I6uG7uvkrcuQmYiz+nFe9hhDmHWQ1KOdy+1h1B6tliv5SBbNjKZdKbbpvvGu9+SAWxXY17
	kEb4lZWL0KhzZbA+XkFDzVh19TOqxsIvc2ckFOmY0B0GGgbx1esHP311ve3LnDnzOSIHWh
	Ya2oTg82KoOp7fSdCNuANoYvs/mw3Xo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-7YrKw7B5MT2CDjM5sC6c7A-1; Fri, 22 Mar 2024 03:18:03 -0400
X-MC-Unique: 7YrKw7B5MT2CDjM5sC6c7A-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d02a05aba8so12295139f.1
        for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 00:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711091882; x=1711696682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfLKWDJo3Ejx3ZbyTlRCuPz3OgymMWs+Pv+TUuu2Y6g=;
        b=o9p1IHtpLdS9wkcc9kGEc9CXjVk5hcNDu5YJRKSD7kF0sp+GSrrmPuYqjrVNp9Ta7j
         ajZUH+tovN/e66ixFyABqUTwdYHMXn0e+7NHONgFnGJQgkyh53qipk1Hl7A/LT4Lb8Sd
         wDAmYdCrw5TU8/SysvZrA5yiqbbsz9C3ELJzRC+U5tFgBJ+E5F/K2QURYep+H+ga3OHW
         sgluD9incmY/PdzAkYlH98uPNbQHb9EorfdN6IIQVfnkd8beMKvkNk/ZyQRW48gQAEJz
         URxrd5kSDU/PnGjYDVqHchgKEjotPpUN6JvAiD9QDk/aCdlAMx2/IF7ZedCD0aJ/ah3v
         opFw==
X-Forwarded-Encrypted: i=1; AJvYcCX94llXA0+0qmCytEKCNRbGVnhVgTJcMm8+gU/YVaWBL1XFJYdnC6+q6ULmFTx9Ghg7X70ldQ2YZwEyQ5V49TIw5e7+x4+3Ke8I
X-Gm-Message-State: AOJu0YyQ0XYwiePk7pLUmEnQX2JEVz0040EvpntZXkrsK+8+BqGOJb9d
	8SEtG21ZO6FNr5XbjM8P/5VQisHHMbmq1uctEHuUCIB5gqlyir55NZFZUk5dnyAbgC/cwUXcRd8
	HABZEWWpf7tBbPgtsrDzHzvASxTMm0QVXMEuwzkiZ7pi/Vv+O/iF8FIbw5OP8FxpMIfSRZD5jyZ
	LY8Ot4v/ZXQ4qX0yAj7V6OX0XnvACCeH5O
X-Received: by 2002:a92:cd45:0:b0:366:b0bd:3a1a with SMTP id v5-20020a92cd45000000b00366b0bd3a1amr1228211ilq.1.1711091882347;
        Fri, 22 Mar 2024 00:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeZO/7oN5mvhzh9PedcjoZqqBtyFf77oq7+h3Pz31dRwPxzE+NYO0AjzrkeU2hRflHlyAbvQFGzJMZ2bOLAnU=
X-Received: by 2002:a92:cd45:0:b0:366:b0bd:3a1a with SMTP id
 v5-20020a92cd45000000b00366b0bd3a1amr1228204ilq.1.1711091882050; Fri, 22 Mar
 2024 00:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4eeac1f733584855965a2ea62fa4da58@huawei.com> <4c31664e-9c35-1956-e667-be976ac6510e@huawei.com>
 <CALu+AoQWiqMhRG=NXsbkBVDSTjYFfeOc9H0+GUXLE213ZWPANw@mail.gmail.com> <f286282d-a3ee-980e-565a-bf0c401ca529@huawei.com>
In-Reply-To: <f286282d-a3ee-980e-565a-bf0c401ca529@huawei.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Mar 2024 15:18:13 +0800
Message-ID: <CALu+AoRaq0FinqJC-yDus7Df=XP2TfZREn9nsZ_1CaExuYOdaA@mail.gmail.com>
Subject: Re: Question about Address Range Validation in Crash Kernel Allocation
To: Li Huafei <lihuafei1@huawei.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: "chenhaixiang (A)" <chenhaixiang3@huawei.com>, Baoquan He <bhe@redhat.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, Louhongxiang <louhongxiang@huawei.com>, 
	"wangbin (A)" <wangbin224@huawei.com>, 
	"Fangchuangchuang(Fcc,Euler)" <fangchuangchuang@huawei.com>, "wanghai (M)" <wanghai38@huawei.com>, 
	"Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024 at 20:37, Li Huafei <lihuafei1@huawei.com> wrote:
>
>
>
> On 2024/3/21 18:06, Dave Young wrote:
> > Hi,
> >
> > On Thu, 21 Mar 2024 at 17:49, Li Huafei <lihuafei1@huawei.com> wrote:
> >>
> >> Hi Baoquan=EF=BC=8C
> >>
> >> On 2024/3/21 17:17, chenhaixiang (A) wrote:
> >>>
> >>>>> I'm sorry for the delay. Here are some details from the boot log an=
d
> >>>> /proc/iomem:
> >>>>> The Boot log:
> >>>>> [    0.000000] Linux version 6.8.0 (root@localhost.localdomain) (gc=
c (GCC)
> >>>> 10.3.1, GNU ld (GNU Binutils) 2.37) #3 SMP PREEMPT_DYNAMIC Wed Mar 2=
0
> >>>> 11:46:11 UTC 2024
> >>>>> [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.8.0
> >>>> root=3D/dev/mapper/root ro crashkernel=3D512M resume=3D/dev/mapper/s=
wap
> >>>> rd.lvm.lv=3Droot rd.lvm.lv=3Dswap crash_kexec_post_notifiers softloc=
kup_panic=3D1
> >>>> reserve_kbox_mem=3D16M fsck.mode=3Dauto fsck.repair=3Dyes panic=3D3
> >>>> nmi_watchdog=3D1 quiet rd.shell=3D0 memblock=3Ddebug efi=3Ddebug
> >>>> console=3DttyS0,115200n8 console=3Dtty0
> >>>> ......snip...
> >>>>> [    0.022622] memblock_phys_alloc_range: 536870912 bytes align=3D0=
x1000000
> >>>> from=3D0x0000000000000000 max_addr=3D0x0000000100000000
> >>>> reserve_crashkernel_generic+0x7c/0x220
> >>>>> [    0.022628] memblock_phys_alloc_range: 536870912 bytes align=3D0=
x1000000
> >>>> from=3D0x0000000100000000 max_addr=3D0x0000400000000000
> >>>> reserve_crashkernel_generic+0x7c/0x220
> >>>>> [    0.022632] memblock_reserve: [0x000000c01f000000-0x000000c03eff=
ffff]
> >>>> memblock_alloc_range_nid+0xee/0x170
> >>>>> [    0.022634] memblock_phys_alloc_range: 268435456 bytes align=3D0=
x1000000
> >>>> from=3D0x0000000000000000 max_addr=3D0x0000000100000000
> >>>> reserve_crashkernel_generic+0x11d/0x220
> >>>>> [    0.022638] memblock_reserve: [0x0000000049000000-0x0000000058ff=
ffff]
> >>>> memblock_alloc_range_nid+0xee/0x170
> >>>>> [    0.022640] crashkernel low memory reserved: 0x49000000 - 0x5900=
0000
> >>>> (256 MB)
> >>>>> [    0.022641] crashkernel reserved: 0x000000c01f000000 -
> >>>> 0x000000c03f000000 (512 MB)
> >>>>
> >>>> Here, crashkernel,low is reserved in region:  [0x49000000 - 0x590000=
00] (256
> >>>> MB)
> >>>>       crashkernel,high is reserved in region: [0x000000c01f000000 -
> >>>> 0x000000c03f000000] (512 MB) ......
> >>>>> [    0.029839] memblock_reserve: [0x000000c03ffff740-0x000000c03fff=
ff7f]
> >>>> memblock_alloc_range_nid+0xee/0x170
> >>>>> [    0.029843] e820: update [mem 0x53cbd000-0x53ccffff] usable =3D=
=3D>
> >>>> reserved
> >>>>> [    0.029861] TSC deadline timer available
> >>>>
> >>>> Then here, region [0x53cbd000-0x53ccffff] is reserved in e820, and p=
rint abvoe
> >>>> "usable =3D=3D> reserved". This should be the step which prevents ea=
rlier reserved
> >>>> crashkernel,low from being added to iomem tree. I am not sure what t=
riggered
> >>>> the e820 update.
> >>
> >> We added dump_stack () printing in efi_mem_reserve () and found that
> >> [0x53cbd000-0x53ccffff] was reserved by BGRT:
> >>
> >>   [    0.032259] e820: update [mem 0x53cbd000-0x53ccffff] usable =3D=
=3D>
> >> reserved
> >>   [    0.032262] CPU: 0 PID: 0 Comm: swapper Not tainted
> >> 5.10.0-60.18.0.50.h820.eulerosv2r11.x86_64 #7
> >>   [    0.032263] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 8.25
> >> 08/30/2022
> >>   [    0.032264] Call Trace:
> >>   [    0.032265]  ? dump_stack+0x57/0x6e
> >>   [    0.032267]  ? bgrt_init+0xc2/0xc2
> >>   [    0.032268]  ? __e820__range_update+0x7a/0x1d6
> >>   [    0.032270]  ? bgrt_init+0xc2/0xc2
> >>   [    0.032272]  ? bgrt_init+0xc2/0xc2
> >>   [    0.032274]  ? efi_arch_mem_reserve+0x1a3/0x1d0
> >>   [    0.032276]  ? efi_mem_reserve+0x2d/0x42
> >>   [    0.032278]  ? acpi_parse_bgrt+0xa/0x11
> >>   [    0.032279]  ? acpi_table_parse+0x86/0xbc
> >>   [    0.032281]  ? acpi_boot_init+0x79/0xad
> >>   [    0.032282]  ? setup_arch+0x835/0x954
> >>   [    0.032284]  ? start_kernel+0x5d/0x455
> >>   [    0.032286]  ? secondary_startup_64_no_verify+0xc2/0xcb
> >>
> >> efi_reserve_boot_services() has reserved memory of type
> >> EFI_BOOT_SERVICES_CODE & EFI_BOOT_SERVICES_DATA  before crashkernel.
> >> efi_bgrt_init() assumes that EFI_BOOT_SERVICES_DATA is not reserved by
> >> other modules. Then, the e820_table is directly updated, and the BGRT
> >> memory is reserved.
> >>
> >> However, memblock_is_region_reserved() in efi_reserve_boot_services()
> >> returns true when the ranges only overlap.
> >>
> >>      already_reserved =3D memblock_is_region_reserved(start, size);
> >
> > Do you mean efi_reserve_boot_services is supposed to reserve the bgrt
> > memory but it does not reserve it due to the region overlapping with
> > some other reserved region?  If so can you debug and find what exact
> > memblock reserved region overlaps with the bgrt?
>
> Yes. I added the following debug print to efi_reserve_boot_services():
>
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -339,6 +339,10 @@ void __init efi_reserve_boot_services(void)
>
>                 already_reserved =3D memblock_is_region_reserved(start, s=
ize);
>
> +               pr_info("kdumpdebug: efi_reserve_boot_services start 0x%l=
u, "
> +                       "size 0x%lx, type 0x%lx, already_reserved %d\n",
> +                       start, size, md->type, already_reserved);
> +
>                 /*
>                  * Because the following memblock_reserve() is paired
>                  * with memblock_free_late() for this region in
>
> This memory [0x0000005976a018-0x00000005976abc7] is reserved here, which =
belongs to EFI_BOOT_SERVICES_DATA.
>     [    0.000000] memblock_reserve: [0x000000005976a018-0x000000005976ab=
c7] efi_memattr_init+0x51/0xa0
> It falls in the following range
>     [    0.000000] efi: mem22: [Boot Data   |   |  |  |  |  |  |  |  |  |=
   |WB|WT|WC|UC] range=3D[0x0000000051329000-0x000000005cefefff] (187MB)
>
> in efi_reserve_boot_services(), [0x0000005132900-0x00000005cefeff] will n=
ot be fully reserved because [0x0000005976a018-0x0000005976abc7]
> has already been reserved and overlaps with [0x0000005976a018-0x000000597=
6abc7]

Ok, it looks to me it is like this:

efi_memattr_init() reserved the memattr table with memblock_reserve
efi_reserve_boot_services failed to reserve the boot data region which
includes the memattr table due to it has been revervely partially.

So this should be a UEFI issue revealed by the crashkernel resource
late intert commit.   I suspect the memblock_reserve in
efi_memattr_init can be just removed and leave to
efi_reserve_boot_services to do that.

Added Ard and efi list for opinion.


>
>     [    0.021316] efi: kdumpdebug: efi_reserve_boot_services start 0x513=
29000, size 0xbbd6000, type 0x4, already_reserved 1
>
> It is not reserved by memblock, this free memory region is allocated by c=
rashkernel
>
>     [    0.022597] crashkernel low memory reserved: 0x49000000 - 0x590000=
00 (256 MB)
>     [    0.022599] crashkernel reserved: 0x000000c01f000000 - 0x000000c03=
f000000 (512 MB)
>
> In efi_bgrt_init (), it is assumed that the memory of the EFI_BOOT_SERVIC=
ES_DATA type has been successfully
> reserved. Therefore, the address in the range is directly used. As a resu=
lt, the memory overlaps with
> the crashkernel region.
>
>     [    0.029694] e820: update [mem 0x53cbd000-0x53ccffff] usable =3D=3D=
> reserved

Thanks
Dave


