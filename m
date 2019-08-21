Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32AF9723F
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfHUG3f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 21 Aug 2019 02:29:35 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:44960 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726869AbfHUG3e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Aug 2019 02:29:34 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Wed, 21 Aug 2019 06:27:42 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 21 Aug 2019 06:10:55 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 21 Aug 2019 06:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuSqjAoJl2YFfNyrdXdUt7EO75yd7GPbuuvh5myKisFuc8QfHs8TOaz6j/Lor2YaqBdogpmuGE4jGUF/s5Q218mdlFViG1B8qSakLPWVMo1q/J88ybqBdcY/z1cIfa3JsrzvthKUbZjMqPCg11/CvnQw3c1A13rf+US9Z80AGwsQezyEF7a10Z+I+Gf3X2+48w35zYkCpOyYJdRaecyPT3Uy0MAM4W6FL7A+87AAxvQ0rZR5R0fkZKCAvxfUbT2fyn03TmBcE7CmFW66Xd/BaHRku+rkHDTWrDHT9wK09xTQ8qZO353bYWzVWpZqNlDbdtKDkNp6TnYyYL55TSJbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZTxDMZIPBJqeWIojlvEdBEeDNbh23i4y7kRoaL5ESM=;
 b=SYl7KhjMW5Q8EQda7HZEREQDAp/xL8wU25ukuGSEweSYkj0S33GR1wrCq9OT9zJ8UsTsTb2SChaCnwC1pZqHvWJPP7gHIFTZ1TLqQadAlqyw3pUE3eklwAHJn2cpETyanro9HKzmQXRPiI1RQ2cDCPOkgED5Vrsj2tF4wyrqXzdDRErl9IfW1Jiqqxs8B6eHi6ycKLwb8rrvNxjSye7CTn48N2VnhjeeBr+8zwX7ln2hQY2KgXJ4su5dqdN2J7b35X6QwYiAOxW8RKpxj2Cc9N4oVY9vZi4WGaTS9dzRzeJDOy7+agXk0HCSywZzUz4JaWO3H/injRz+UeawIDhz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3377.namprd18.prod.outlook.com (10.255.139.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 06:10:53 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca%6]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 06:10:53 +0000
From:   Chester Lin <clin@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
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
Thread-Index: AQHVSPSS9nx4lee000qskpi0lgLxmKcECttKgAAI7GKAASiQgA==
Date:   Wed, 21 Aug 2019 06:10:52 +0000
Message-ID: <20190821061027.GA2828@linux-8mug>
References: <20190802053744.5519-1-clin@suse.com>
 <20190820115645.GP13294@shell.armlinux.org.uk>
 <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR07CA0119.eurprd07.prod.outlook.com
 (2603:10a6:6:2c::33) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61f22c2a-f905-4127-cc83-08d725fe51b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3377;
x-ms-traffictypediagnostic: BY5PR18MB3377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3377298C6BDC45B0E41E68A8ADAA0@BY5PR18MB3377.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(7916004)(396003)(136003)(346002)(366004)(39860400002)(376002)(189003)(199004)(6916009)(71190400001)(316002)(81166006)(71200400001)(81156014)(8676002)(6246003)(8936002)(6436002)(54906003)(1076003)(6116002)(478600001)(3846002)(4326008)(6512007)(9686003)(14454004)(66556008)(66476007)(66946007)(64756008)(6506007)(26005)(386003)(102836004)(99286004)(446003)(11346002)(86362001)(476003)(486006)(33716001)(66066001)(53936002)(229853002)(7416002)(33656002)(6486002)(25786009)(52116002)(256004)(14444005)(76176011)(66446008)(5660300002)(7736002)(2906002)(305945005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3377;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zctpV5Vd1J6KbKO7aiLVqKD2XhOKywCDYlwzMG5oHFGgTqcue5mPV/qPVKQmtBClarbUQQL8FwGjFJNG1yf2WSVlyX0xoGMsTXR1v+5bdTDfJnbHzYFiaSVDxtaUULqMU5RhiypjFJv1CM993PObOF2jbZ7bNbTzc8KefSNrRlREOWU0ihWTYwku1LVlIJBfNdK51FyTewrDIAJ6T4euo46sbDkLozlnPnqonnBI3Elj8hZ+OmGYjUaJDZKGYlbLChhKT5O3tlAgC/fhqWZnGiRLQAGbWeVzqLeNfafGHoHF7MfFbX77PyUy3bCVb3OGQwalvAHlTbnA5+ZeR+T/xODxt5dVvQxFM89Iagpl6Tyrg7x3R3ahvbJajBUiCpQXYM1eX7094z7ntSl2kviRiWG3tGdhE2Nj3IDQeOTJBRk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87002BD974C20344816F3B12AD05A0E0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f22c2a-f905-4127-cc83-08d725fe51b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 06:10:53.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUNdIXFSGzihnlfuFDkoWXUzVpuicr0c3CQFupDYsE7TTlIfPMj1J1Zyq7kk4lxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3377
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 20, 2019 at 03:28:25PM +0300, Ard Biesheuvel wrote:
> On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index f3ce34113f89..909b11ba48d8 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> > >               phys_addr_t block_start = reg->base;
> > >               phys_addr_t block_end = reg->base + reg->size;
> > >
> > > +             if (memblock_is_nomap(reg))
> > > +                     continue;
> > > +
> > >               if (reg->base < vmalloc_limit) {
> > >                       if (block_end > lowmem_limit)
> > >                               /*
> >
> > I think this hunk is sane - if the memory is marked nomap, then it isn't
> > available for the kernel's use, so as far as calculating where the
> > lowmem/highmem boundary is, it effectively doesn't exist and should be
> > skipped.
> >
> 
> I agree.
> 
> Chester, could you explain what you need beyond this change (and my
> EFI stub change involving TEXT_OFFSET) to make things work on the
> RPi2?
>

Hi Ard,

In fact I am working with Guillaume to try booting zImage kernel and openSUSE
from grub2.04 + arm32-efistub so that's why we get this issue on RPi2, which is
one of the test machines we have. However we want a better solution for all
cases but not just RPi2 since we don't want to affect other platforms as well.

Regards,
Chester
