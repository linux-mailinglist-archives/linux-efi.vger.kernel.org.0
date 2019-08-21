Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF19735D
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 09:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfHUH3P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 21 Aug 2019 03:29:15 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:45678 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbfHUH3P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Aug 2019 03:29:15 -0400
X-Greylist: delayed 4675 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Aug 2019 03:29:13 EDT
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.146) BY m4a0040g.houston.softwaregrp.com WITH ESMTP;
 Wed, 21 Aug 2019 07:27:20 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 21 Aug 2019 07:22:57 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 21 Aug 2019 07:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+nn2QJk6L8eSJGx9L0PhbK1nvvXI7DYMLT+OP0EC1MNf03Sx74WvYntVIQbuwuwMsn4VRjIzS0ZVZ9tJDsa1Fy5vxHyUQHwlJJ0i8Ulh3acQpiup6L+i1I7QL5YNNMqw2hnEBUGZutdMyTrQ0AQwizLSe7AGiTG6SmD75A4Vy1NkyzLPhPH3kfn1JJQq+2z9dLBT370lXPGVXCr+oBErTVqaEIfyqT41Bupb1lSfpApyDS6aFj7GD5sMv0wSf3MMlLFfXn/mRUbpAq8SG8Mx4jzL/iCd2TbddJOtZSe24lI+utxdkz8rF9VVTRU3z9MCQ1Vm3WMUnVFX4tF9fiO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpgAISyxpzK57dAfded7Wdsjua5E6QYeUWCJlL4W7GE=;
 b=iTNozJLS6ymHyJvJ6zNUuGWBNpZyWyosP+bnmkufJ3xMPKIcH859UtprhIzfOaX1uM7p75Z48jkuVTME/LV6aL0sJtIZRLTFipzoVQmvI0fmMn1ChsOt+uLDwRfPZ34MLhSZ0MtuH8P3Dk8LtcJRII41nm9jgUjHJn1Yu00Z5l0C7At2hEY8AlkTHh/bKfoSLbejKDil+Rx+92KWaayQdR7C0Vw1fVSwxPD1jhThbPR70Xfe3SVu6Koxchveweaz5cOHP4VmRCimrvhO0brp3dM5NaMjhw0kA+9d402v+LKMCKH7gjssPtIgMglLmz+FxgBe4Adm1GI+HLPO2qRhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3298.namprd18.prod.outlook.com (10.255.138.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 07:22:55 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca%6]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 07:22:55 +0000
From:   Chester Lin <clin@suse.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Thread-Index: AQHVSPSS9nx4lee000qskpi0lgLxmKcECttKgAAI7GKAASiQgIAAByF/gAAKISyAAALiAA==
Date:   Wed, 21 Aug 2019 07:22:55 +0000
Message-ID: <20190821072232.GA5547@linux-8mug>
References: <20190802053744.5519-1-clin@suse.com>
 <20190820115645.GP13294@shell.armlinux.org.uk>
 <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
 <20190821061027.GA2828@linux-8mug>
 <CAKv+Gu8Yny8cVPck3rPwCPvJBvcZKMHti_9bkCTM4H4cZ_43fg@mail.gmail.com>
 <20190821071100.GA26713@rapoport-lnx>
In-Reply-To: <20190821071100.GA26713@rapoport-lnx>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB8PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:10:be::27) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ca4e210-2834-48f6-7585-08d7260862d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3298;
x-ms-traffictypediagnostic: BY5PR18MB3298:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3298511F873616A6D980EBF8ADAA0@BY5PR18MB3298.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(26005)(54906003)(476003)(5660300002)(316002)(1076003)(186003)(486006)(478600001)(6306002)(53936002)(6512007)(9686003)(966005)(66946007)(64756008)(66446008)(6506007)(386003)(76176011)(6916009)(33656002)(66556008)(66476007)(14454004)(102836004)(52116002)(99286004)(6486002)(6436002)(81166006)(3846002)(446003)(33716001)(66066001)(81156014)(8936002)(2906002)(8676002)(86362001)(6246003)(25786009)(71200400001)(71190400001)(7416002)(4326008)(229853002)(11346002)(6116002)(7736002)(305945005)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3298;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V+3SmBcfEmgfd9Zlu4NUXu9CqqOVhgZNi+Z3JxTsdsvDUY6N4Vlyaf6JzWymeXD6r0EKQkIdhBWrOi7Gf1uhZuxM/RKGDVDM+lcyZe61HL6ZZabuSyTXOdYGfOXE0fv6Zp4znsrqFQrioFLr5rNpLbepTKQi8u+dVNxA4LoLHk652TSrQ1qclqnnOimhYHXkIJG12Gae00tfjVxalnnK5JLOtFxncEYLe08JRKFH6r7J+yG3NIDHz2h8gs2vrLAFv5x8ec+i3kh3PfW3V6O93IYrdK9P24jckfQuYYPv944oAU4/anil9uGcj5uEll5qXrBEL6VNp2QD5zTXoHLJNS8cCiQ7QZ9Kad0d4f/yI7Iug76jncU2KIG77pRzQN8VTbULTwRTrHtJTw21SHhbwsAQQxWZsX1KJl/oU3VWnbI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89049C7AA5D24246A3058968A6556C2E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca4e210-2834-48f6-7585-08d7260862d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 07:22:55.7456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzonwTQMja6tOwccwt1UGrw3bCQKODZ+zAi3gyMLG6dlqpwUfAL2rHRpud2JAYaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3298
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 21, 2019 at 10:11:01AM +0300, Mike Rapoport wrote:
> On Wed, Aug 21, 2019 at 09:35:16AM +0300, Ard Biesheuvel wrote:
> > On Wed, 21 Aug 2019 at 09:11, Chester Lin <clin@suse.com> wrote:
> > >
> > > On Tue, Aug 20, 2019 at 03:28:25PM +0300, Ard Biesheuvel wrote:
> > > > On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > > > > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > > > > index f3ce34113f89..909b11ba48d8 100644
> > > > > > --- a/arch/arm/mm/mmu.c
> > > > > > +++ b/arch/arm/mm/mmu.c
> > > > > > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> > > > > >               phys_addr_t block_start = reg->base;
> > > > > >               phys_addr_t block_end = reg->base + reg->size;
> > > > > >
> > > > > > +             if (memblock_is_nomap(reg))
> > > > > > +                     continue;
> > > > > > +
> > > > > >               if (reg->base < vmalloc_limit) {
> > > > > >                       if (block_end > lowmem_limit)
> > > > > >                               /*
> > > > >
> > > > > I think this hunk is sane - if the memory is marked nomap, then it isn't
> > > > > available for the kernel's use, so as far as calculating where the
> > > > > lowmem/highmem boundary is, it effectively doesn't exist and should be
> > > > > skipped.
> > > > >
> > > >
> > > > I agree.
> > > >
> > > > Chester, could you explain what you need beyond this change (and my
> > > > EFI stub change involving TEXT_OFFSET) to make things work on the
> > > > RPi2?
> > > >
> > >
> > > Hi Ard,
> > >
> > > In fact I am working with Guillaume to try booting zImage kernel and openSUSE
> > > from grub2.04 + arm32-efistub so that's why we get this issue on RPi2, which is
> > > one of the test machines we have. However we want a better solution for all
> > > cases but not just RPi2 since we don't want to affect other platforms as well.
> > >
> > 
> > Thanks Chester, but that doesn't answer my question.
> > 
> > Your fix is a single patch that changes various things that are only
> > vaguely related. We have already identified that we need to take
> > TEXT_OFFSET (minus some space used by the swapper page tables) into
> > account into the EFI stub if we want to ensure compatibility with many
> > different platforms, and as it turns out, this applies not only to
> > RPi2 but to other platforms as well, most notably the ones that
> > require a TEXT_OFFSET of 0x208000, since they also have reserved
> > regions at the base of RAM.
> > 
> > My question was what else we need beyond:
> > - the EFI stub TEXT_OFFSET fix [0]
> > - the change to disregard NOMAP memblocks in adjust_lowmem_bounds()
> > - what else???
> 
> I think the only missing part here is to ensure that non-reserved memory in
> bank 0 starts from a PMD-aligned address. I believe this could be done if
> EFI stub, but I'm not really familiar with it so this just a semi-educated
> guess :)
>  
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=next&id=0eb7bad595e52666b642a02862ad996a0f9bfcc0
>

Hi Ard and Mike,

Sorry for my misunderstanding and I agree with Mike. We could still meet the
memblock_limit issue if there's a non-reserved memory in bank0 starts from an
unaligned address.

Regards,
Chester
