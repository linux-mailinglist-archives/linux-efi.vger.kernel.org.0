Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7E95C57
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfHTKfC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 20 Aug 2019 06:35:02 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:53598 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729392AbfHTKfB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Aug 2019 06:35:01 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.191) BY m9a0003g.houston.softwaregrp.com WITH ESMTP;
 Tue, 20 Aug 2019 10:34:21 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 20 Aug 2019 10:29:55 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 20 Aug 2019 10:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPJPFpbR/8HK9P5IzwWKG8rA0liHE8hL+hW2DTNsa5q8R3EOGoXQsY77HcWUNxSizE9z38Km1s2K/2exaE4oS7Snt5qtKZB896BAbXqPgZ2trpJHH8VjpceuV6g+GwGb9zDwHw9X15RGFFQ9hhLt6i4DrwMAOOYi3hj/D+fyJe0jhOyC8Qu2ir8d1ru8PmrwV6b4YYT0A9gnoolGMwt+WNI52rVsweDUwqhn3dlhRgpfSQbVnlOswJCIcrHD6vqN2bBOL+YWZr8IgtnwgbAJuog/LehHBW7WPOS4IBxro4QVrWGVLSvXeaohqUJU5U9EP0tDK4//oLd6mUEyvpxjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=filDXmbNfqpVTbrkV/YdHGMNUVsfHqcLguXghUvtgns=;
 b=fu9IjAhrQI2cQYjIjmfHtpXZJqmKD+eNaHJcpQ8zhIuI9ynH6FPBoeWPUjlWyDkB3rzsW9yctHSM3XDCeWd1ubGPlpHXzDkSnUTlf8zpUnZBXqr13TLZs+wlxz96SQuPIYQm7EBh44YhgatyCwrxWC9K3NcsG07FxAXSEhntUVhPSmENSs9vPnhDuLWmuxwphW3K+1qp0INbfnt1uD+aX4eWcEe3aro8FCAte/lz4LvJOaNc/GlhPQaPBHvuEzcT6CVBMWbmstruT2NhzVYAvD0Qin2pPlYnf7pweHv1tI5BS8eQHRU3J02qXfph/+5emfd8GAFGbVwMs5w8RqA9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3187.namprd18.prod.outlook.com (10.255.139.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 10:29:54 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca%6]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 10:29:54 +0000
From:   Chester Lin <clin@suse.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Chester Lin <clin@suse.com>, Gary Lin <GLin@suse.com>,
        Juergen Gross <JGross@suse.com>, Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel
 base
Thread-Topic: [PATCH] efi/arm: fix allocation failure when reserving the
 kernel base
Thread-Index: AQHVSPSS9nx4lee000qskpi0lgLxmKbqoqP1gBFKchaAADaQgIAABPlpgAAi5uGABenAgIAAdaIQgAEbAmmAACx5AA==
Date:   Tue, 20 Aug 2019 10:29:53 +0000
Message-ID: <20190820102928.GA14667@linux-8mug>
References: <20190802053744.5519-1-clin@suse.com>
 <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
 <CAKv+Gu8uwbY-JtjNbgoyY230X_M6xLchVM3OUg_oNWOJrF=iCg@mail.gmail.com>
 <20190815111543.GA4728@linux-8mug>
 <CAKv+Gu-5M-4=SbOzbqbLUYnfFw29vhfcrVD=N9j_APYpKjq2wQ@mail.gmail.com>
 <20190815133738.GA2483@rapoport-lnx> <20190819075621.GA20595@linux-8mug>
 <CAKv+Gu-sdhNbhfD24Fn93mj-h6=vGi82Ghjy7AzaRSqcpXCx-g@mail.gmail.com>
 <20190820074930.GC5989@rapoport-lnx>
In-Reply-To: <20190820074930.GC5989@rapoport-lnx>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::16)
 To BY5PR18MB3283.namprd18.prod.outlook.com (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f9e794b-f436-4cb5-1d0a-08d72559569f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3187;
x-ms-traffictypediagnostic: BY5PR18MB3187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB31874266D0C26EE9D268951EADAB0@BY5PR18MB3187.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(54094003)(486006)(71190400001)(1076003)(76176011)(6506007)(14454004)(2906002)(229853002)(53936002)(316002)(6916009)(33716001)(33656002)(478600001)(5660300002)(305945005)(7736002)(4326008)(256004)(3846002)(186003)(25786009)(9686003)(6512007)(6116002)(99286004)(66446008)(66556008)(64756008)(66476007)(66946007)(446003)(386003)(6246003)(476003)(11346002)(14444005)(81166006)(81156014)(8936002)(8676002)(6436002)(7416002)(86362001)(102836004)(52116002)(71200400001)(54906003)(6486002)(66066001)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3187;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6g1IAZ7WLGxyRkiNwF3U5fX6f3j9feiojo6nwMPjg/qqTzLVis5ZSyjX86OOsjJ0JfzzB7zQH8pEgZD7NFmWShqKQwNSgfXhN+biRnV61Pvki0Zl79RNJ2L/BWFRavNXOp98Rrx/uyDROsGxGaqgV2Dt4nb1f4fecu11ULIYxu7TdUEtNxXbpKGXEl9AWeHrDhX1Oj9GJQLWU5fuBkAyhpbtmiBpEcaWbNE+toHcqJNvAcgsjdeNvBGNgmqLXYp4FS0uuFwuvEGaiBlMuMkT3fiIwACo95ygmXIIf6Kvphrj9NbQt1E4X3FDnq+TZKgctiwlhyAaxs4IGE7RAVw7+RCwDrWizxXS7NyVrA3gAEVV5VLB/oZ3cQQqam20LZj4A+FPvblYZMa+nuWILDNiBeujuAG5kTF0c81fX+Q+gzw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D33D655DF8D5948A9EDBECD2C6D774E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9e794b-f436-4cb5-1d0a-08d72559569f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 10:29:53.5497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KXfrFHpc8eEbKnkXcTIHPqT7w8EBQkw+W40Yytwv3bj0PJMtWLDhdMMCDTwTuIm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3187
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 20, 2019 at 10:49:30AM +0300, Mike Rapoport wrote:
> On Mon, Aug 19, 2019 at 05:56:51PM +0300, Ard Biesheuvel wrote:
> > On Mon, 19 Aug 2019 at 11:01, Chester Lin <clin@suse.com> wrote:
> > >
> > > Hi Mike and Ard,
> > >
> > > On Thu, Aug 15, 2019 at 04:37:39PM +0300, Mike Rapoport wrote:
> > > > On Thu, Aug 15, 2019 at 02:32:50PM +0300, Ard Biesheuvel wrote:
> > > > > (adding Mike)
> > > > >
> 
> ...
> 
> > > > > > In this case the kernel failed to reserve cma, which should hit the issue of
> > > > > > memblock_limit=0x1000 as I had mentioned in my patch description. The first
> > > > > > block [0-0xfff] was scanned in adjust_lowmem_bounds(), but it did not align
> > > > > > with PMD_SIZE so the cma reservation failed because the memblock.current_limit
> > > > > > was extremely low. That's why I expand the first reservation from 1 PAGESIZE to
> > > > > > 1 PMD_SIZE in my patch in order to avoid this issue. Please kindly let me know
> > > > > > if any suggestion, thank you.
> > > >
> > > >
> > > > > This looks like it is a separate issue. The memblock/cma code should
> > > > > not choke on a reserved page of memory at 0x0.
> > > > >
> > > > > Perhaps Russell or Mike (cc'ed) have an idea how to address this?
> > > >
> > > > Presuming that the last memblock dump comes from the end of
> > > > arm_memblock_init() with the this memory map
> > > >
> > > > memory[0x0] [0x0000000000000000-0x0000000000000fff], 0x0000000000001000 bytes flags: 0x4
> > > > memory[0x1] [0x0000000000001000-0x0000000007ef5fff], 0x0000000007ef5000 bytes flags: 0x0
> > > > memory[0x2] [0x0000000007ef6000-0x0000000007f09fff], 0x0000000000014000 bytes flags: 0x4
> > > > memory[0x3] [0x0000000007f0a000-0x000000003cb3efff], 0x0000000034c35000 bytes flags: 0x0
> > > >
> > > > adjust_lowmem_bounds() will set the memblock_limit (and respectively global
> > > > memblock.current_limit) to 0x1000 and any further memblock_alloc*() will
> > > > happily fail.
> > > >
> > > > I believe that the assumption for memblock_limit calculations was that the
> > > > first bank has several megs at least.
> > > >
> > > > I wonder if this hack would help:
> > > >
> > > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > > index d9a0038..948e5b9 100644
> > > > --- a/arch/arm/mm/mmu.c
> > > > +++ b/arch/arm/mm/mmu.c
> > > > @@ -1206,7 +1206,7 @@ void __init adjust_lowmem_bounds(void)
> > > >                        * allocated when mapping the start of bank 0, which
> > > >                        * occurs before any free memory is mapped.
> > > >                        */
> > > > -                     if (!memblock_limit) {
> > > > +                     if (memblock_limit < PMD_SIZE) {
> > > >                               if (!IS_ALIGNED(block_start, PMD_SIZE))
> > > >                                       memblock_limit = block_start;
> > > >                               else if (!IS_ALIGNED(block_end, PMD_SIZE))
> > > >
> > >
> > > I applied this patch as well and it works well on rpi-2 model B.
> > >
> > 
> > Thanks, Chester, that is good to know.
> > 
> > However, afaict, this only affects systems where physical memory
> > starts at address 0x0, so I think we need a better fix.
> 
> This hack can be easily extended to handle systems with arbitrary start
> address, but it's still a hack...
> 
> > I know Mike has been looking into the NOMAP stuff lately, and your
> > original patch contains a hunk that makes this code (?) disregard
> > nomap memblocks. That might be a better approach.
> 
> I was actually looking how to replace NOMAP with something else to make
> memblock.memory consistent with actual physical memory banks. But this work
> is stashed for now.
> 
> I'm not sure that skipping NOMAP regions would be good enough.
> If I understand corrrectly, with Chester's original patch the reservation
> of PMD aligned chunk of 32M for the kernel made the first conv-mem region
> PMD aligned and then memblock_limit will be set to the end of this region.
> 
> Is there a reason for marking EFI_RESERVED_TYPE as NOMAP rather than simply
> reserve them with memblock_reserve()?
> 

Hi Mike,

I make this change in efistub so I am not sure if memblock_reserve() can be
linked by ld or not. I tried using efi_mem_reserve() but got a linker error of
undefined reference. Is there a better place to call memblock_reserve() after
efistub?

Thanks,
Chester
