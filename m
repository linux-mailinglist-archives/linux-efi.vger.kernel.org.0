Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07809589F
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 09:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfHTHiu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 20 Aug 2019 03:38:50 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:50598 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTHit (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Aug 2019 03:38:49 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.147) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Tue, 20 Aug 2019 07:33:37 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 20 Aug 2019 07:33:51 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 20 Aug 2019 07:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwR1kcEXHn517PGCCN7U4cdKG3/Cugvyc88ibiCRWVXDZdef/YyIPzeecOfaAfXnizPlYgqZebzJ8p40bL5AwJVzhYkrvPtL8oqQrZWn0EbW+XCZz+wyQ0S2fKIofellZIo7aRNPzonb+WEGz0hekblPtmFip4QFiRwiKyJ25BYlEc+D8keYSAQoL8sdR9rVHDjE8gwixtEb4nH63qRsGWVVlQNDLlIDhWHOdyqE5fqlb7t/oQNGowPZFDU/4UHdITBKYXqSH0+0k/B7ZUdmUOkP9DuzozD0ta8t7aw6A1xSm6K5ujvzxRAXk0dCKbzh4VAqLum0qoCOnrhHRPAEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wjfgky61NU2sdd0W6wZuMWIcRlW8Pg84i8FLoSJPPhE=;
 b=bN1I9cv37r75GHFyQjqqIGYmTgn6M7Fc+/om+08n3McisaAjGVbjgdwxhB0ia9e9iSz/6WYKn6+x3X/SCP4N63KinBJCRJH6/u2AUCzCKuFTpkFMEmAjCpiaEkHFvpbZ9sv7Ujt+vonj0Fo+fQYndYGiVqpW+aSi3WjRHAPASOVvdbtmMYSiKE433hjv1ikf4OPHmvfEaIRMQ31O6aL2/RuBoBcYFJep/9aYp/6qdIYjC60Dweip5CF3ZAOkeP8AotcOAvXddlOVF1sZOMdZM7CdArP9nuyJE6RkYQxD5tCaAgihMYkcYxRwVEMUPWGI+5pUd9SBbYrI/g3SirSUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3409.namprd18.prod.outlook.com (10.255.139.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 07:33:49 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca%6]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 07:33:49 +0000
From:   Chester Lin <clin@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Chester Lin <clin@suse.com>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Gary Lin <GLin@suse.com>,
        "Juergen Gross" <JGross@suse.com>, Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel
 base
Thread-Topic: [PATCH] efi/arm: fix allocation failure when reserving the
 kernel base
Thread-Index: AQHVSPSS9nx4lee000qskpi0lgLxmKbqoqP1gBFKchaAADaQgIAABPlpgAAi5uGABenAgIAAdaIQgAEWQYA=
Date:   Tue, 20 Aug 2019 07:33:48 +0000
Message-ID: <20190820073317.GA23965@linux-8mug>
References: <20190802053744.5519-1-clin@suse.com>
 <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
 <CAKv+Gu8uwbY-JtjNbgoyY230X_M6xLchVM3OUg_oNWOJrF=iCg@mail.gmail.com>
 <20190815111543.GA4728@linux-8mug>
 <CAKv+Gu-5M-4=SbOzbqbLUYnfFw29vhfcrVD=N9j_APYpKjq2wQ@mail.gmail.com>
 <20190815133738.GA2483@rapoport-lnx> <20190819075621.GA20595@linux-8mug>
 <CAKv+Gu-sdhNbhfD24Fn93mj-h6=vGi82Ghjy7AzaRSqcpXCx-g@mail.gmail.com>
In-Reply-To: <CAKv+Gu-sdhNbhfD24Fn93mj-h6=vGi82Ghjy7AzaRSqcpXCx-g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR0802CA0043.eurprd08.prod.outlook.com
 (2603:10a6:4:a3::29) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ecb2dc8-0602-40ea-a31a-08d72540bdab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BY5PR18MB3409;
x-ms-traffictypediagnostic: BY5PR18MB3409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB34096303A3826033171B4B46ADAB0@BY5PR18MB3409.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(54094003)(199004)(189003)(53434003)(2906002)(71200400001)(1076003)(7736002)(66556008)(64756008)(7416002)(66476007)(66446008)(66946007)(5660300002)(81156014)(6486002)(33716001)(6512007)(6116002)(3846002)(86362001)(6916009)(316002)(6436002)(8936002)(54906003)(229853002)(8676002)(81166006)(386003)(6506007)(102836004)(33656002)(4326008)(486006)(476003)(446003)(66066001)(9686003)(71190400001)(478600001)(11346002)(99286004)(76176011)(305945005)(53936002)(14444005)(186003)(6246003)(256004)(26005)(52116002)(14454004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3409;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eiNk9Tc3O77Cj0lK6s9VLT05FCTlb4+/A7wbzWO3kW1uddnxao45/0hUpEk7MXktpRold4FYNamuYjPHjDsYNb0AvKLgkxflEPn4+ZgsopZIj5H8wCmXQRZJmamRvXDJNXVvRR4+DEypDPfOSytrkj9Hwa0CHTdCGUi0RGWzlrWkvdreE4q8eucbQHq4YL+JD+0Dxm7exk8CUK/YlzndYaFpqQVbHz3H00IFTQb6D8d/Mg8TdGwH0qJPZxJmX0bURYrPpTEz8DAHfK+XcSs+8nTBBq1w17O9scMGJTiR7LvWEzVhNjj5XZaekpcwiSRHmJol9/kMlexONTxaFfNNo0hXe2YVz5iQTgKC71Bq8FVfYhWb3j5O0pT2+u20E2WOFh2SzQIPk/1AI7PSFOAo7oBEN1uvMptKR4jMgIIpQEE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B550FB2332C01549BFF295A0423D60C2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecb2dc8-0602-40ea-a31a-08d72540bdab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:33:48.9879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ptgTqR1Ko2YBKNhQNfQzVC2gjza3BV7jGVmjtg3isQhNQsd6VOXLYh1L498v5zF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3409
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 19, 2019 at 05:56:51PM +0300, Ard Biesheuvel wrote:
> On Mon, 19 Aug 2019 at 11:01, Chester Lin <clin@suse.com> wrote:
> >
> > Hi Mike and Ard,
> >
> > On Thu, Aug 15, 2019 at 04:37:39PM +0300, Mike Rapoport wrote:
> > > On Thu, Aug 15, 2019 at 02:32:50PM +0300, Ard Biesheuvel wrote:
> > > > (adding Mike)
> > > >
> > > > On Thu, 15 Aug 2019 at 14:28, Chester Lin <clin@suse.com> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Thu, Aug 15, 2019 at 10:59:43AM +0300, Ard Biesheuvel wrote:
> > > > > > On Sun, 4 Aug 2019 at 10:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > > > >
> > > > > > > Hello Chester,
> > > > > > >
> > > > > > > On Fri, 2 Aug 2019 at 08:40, Chester Lin <clin@suse.com> wrote:
> > > > > > > >
> > > > > > > > In some cases the arm32 efistub could fail to allocate memory for
> > > > > > > > uncompressed kernel. For example, we got the following error message when
> > > > > > > > verifying EFI stub on Raspberry Pi-2 [kernel-5.2.1 + grub-2.04] :
> > > > > > > >
> > > > > > > >   EFI stub: Booting Linux Kernel...
> > > > > > > >   EFI stub: ERROR: Unable to allocate memory for uncompressed kernel.
> > > > > > > >   EFI stub: ERROR: Failed to relocate kernel
> > > > > > > >
> > > > > > > > After checking the EFI memory map we found that the first page [0 - 0xfff]
> > > > > > > > had been reserved by Raspberry Pi-2's firmware, and the efistub tried to
> > > > > > > > set the dram base at 0, which was actually in a reserved region.
> > > > > > > >
> > > > > > >
> > > > > > > This by itself is a violation of the Linux boot protocol for 32-bit
> > > > > > > ARM when using the decompressor. The decompressor rounds down its own
> > > > > > > base address to a multiple of 128 MB, and assumes the whole area is
> > > > > > > available for the decompressed kernel and related data structures.
> > > > > > > (The first TEXT_OFFSET bytes are no longer used in practice, which is
> > > > > > > why putting a reserved region of 4 KB bytes works at the moment, but
> > > > > > > this is fragile). Note that the decompressor does not look at any DT
> > > > > > > or EFI provided memory maps *at all*.
> > > > > > >
> > > > > > > So unfortunately, this is not something we can fix in the kernel, but
> > > > > > > we should fix it in the bootloader or in GRUB, so it does not put any
> > > > > > > reserved regions in the first 128 MB of memory,
> > > > > > >
> > > > > >
> > > > > > OK, perhaps we can fix this by taking TEXT_OFFSET into account. The
> > > > > > ARM boot protocol docs are unclear about whether this memory should be
> > > > > > used or not, but it is no longer used for its original purpose (page
> > > > > > tables), and the RPi loader already keeps data there.
> > > > > >
> > > > > > Can you check whether the following patch works for you?
> > > > > >
> > > > > > diff --git a/drivers/firmware/efi/libstub/Makefile
> > > > > > b/drivers/firmware/efi/libstub/Makefile
> > > > > > index 0460c7581220..ee0661ddb25b 100644
> > > > > > --- a/drivers/firmware/efi/libstub/Makefile
> > > > > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > > > > @@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)     += arm-stub.o fdt.o
> > > > > > string.o random.o \
> > > > > >
> > > > > >  lib-$(CONFIG_ARM)              += arm32-stub.o
> > > > > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > > > > > +CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > > > >  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > > > >
> > > > > >  #
> > > > > > diff --git a/drivers/firmware/efi/libstub/arm32-stub.c
> > > > > > b/drivers/firmware/efi/libstub/arm32-stub.c
> > > > > > index e8f7aefb6813..66ff0c8ec269 100644
> > > > > > --- a/drivers/firmware/efi/libstub/arm32-stub.c
> > > > > > +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> > > > > > @@ -204,7 +204,7 @@ efi_status_t
> > > > > > handle_kernel_image(efi_system_table_t *sys_table,
> > > > > >          * loaded. These assumptions are made by the decompressor,
> > > > > >          * before any memory map is available.
> > > > > >          */
> > > > > > -       dram_base = round_up(dram_base, SZ_128M);
> > > > > > +       dram_base = round_up(dram_base, SZ_128M) + TEXT_OFFSET;
> > > > > >
> > > > > >         status = reserve_kernel_base(sys_table, dram_base, reserve_addr,
> > > > > >                                      reserve_size);
> > > > > >
> > > > >
> > > > > I tried your patch on rpi2 and got the following panic. Just a reminder that I
> > > > > have replaced some log messages with "......" since it might be too long to
> > > > > post all.
> > > > >
> > > >
> > > > OK. Good to know that this change helps you to get past the EFI stub boot issue.
> > > >
> > > > > In this case the kernel failed to reserve cma, which should hit the issue of
> > > > > memblock_limit=0x1000 as I had mentioned in my patch description. The first
> > > > > block [0-0xfff] was scanned in adjust_lowmem_bounds(), but it did not align
> > > > > with PMD_SIZE so the cma reservation failed because the memblock.current_limit
> > > > > was extremely low. That's why I expand the first reservation from 1 PAGESIZE to
> > > > > 1 PMD_SIZE in my patch in order to avoid this issue. Please kindly let me know
> > > > > if any suggestion, thank you.
> > >
> > >
> > > > This looks like it is a separate issue. The memblock/cma code should
> > > > not choke on a reserved page of memory at 0x0.
> > > >
> > > > Perhaps Russell or Mike (cc'ed) have an idea how to address this?
> > >
> > > Presuming that the last memblock dump comes from the end of
> > > arm_memblock_init() with the this memory map
> > >
> > > memory[0x0] [0x0000000000000000-0x0000000000000fff], 0x0000000000001000 bytes flags: 0x4
> > > memory[0x1] [0x0000000000001000-0x0000000007ef5fff], 0x0000000007ef5000 bytes flags: 0x0
> > > memory[0x2] [0x0000000007ef6000-0x0000000007f09fff], 0x0000000000014000 bytes flags: 0x4
> > > memory[0x3] [0x0000000007f0a000-0x000000003cb3efff], 0x0000000034c35000 bytes flags: 0x0
> > >
> > > adjust_lowmem_bounds() will set the memblock_limit (and respectively global
> > > memblock.current_limit) to 0x1000 and any further memblock_alloc*() will
> > > happily fail.
> > >
> > > I believe that the assumption for memblock_limit calculations was that the
> > > first bank has several megs at least.
> > >
> > > I wonder if this hack would help:
> > >
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index d9a0038..948e5b9 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -1206,7 +1206,7 @@ void __init adjust_lowmem_bounds(void)
> > >                        * allocated when mapping the start of bank 0, which
> > >                        * occurs before any free memory is mapped.
> > >                        */
> > > -                     if (!memblock_limit) {
> > > +                     if (memblock_limit < PMD_SIZE) {
> > >                               if (!IS_ALIGNED(block_start, PMD_SIZE))
> > >                                       memblock_limit = block_start;
> > >                               else if (!IS_ALIGNED(block_end, PMD_SIZE))
> > >
> >
> > I applied this patch as well and it works well on rpi-2 model B.
> >
> 
> Thanks, Chester, that is good to know.
> 
> However, afaict, this only affects systems where physical memory
> starts at address 0x0, so I think we need a better fix.
> 
> I know Mike has been looking into the NOMAP stuff lately, and your
> original patch contains a hunk that makes this code (?) disregard
> nomap memblocks. That might be a better approach.
>
Hi Ard and Mike,

In my original patch, I studied map_lowmem() and found that some blocks might
not be mapped according to the current memory map. Thus I assumed maybe NOMAP
blocks could still be ignored in adjust_lowmem_bounds() since they would not
be allocated afterward. But that change in mmu.c still depends on a condition
that there should be a PMD_SIZE block or consecutive smaller NOMAP blocks which
exacly fit the PM_SIZE alignment at the beginning of memory map otherwise the
memblock_limit could still fall on a very low address. That's why I tried to
allocate pages again in arm32-stub.c in order to fill the gap between the
unaligned block_start and the PMD_SIZE aligned kernel base.

Please feel free to let me know if any idea and I am willing to help with
verification.
