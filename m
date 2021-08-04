Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B333E060A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhHDQjo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:39:44 -0400
Received: from mail-bn7nam10on2108.outbound.protection.outlook.com ([40.107.92.108]:20193
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239264AbhHDQjT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 12:39:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjQ8C8Ge2tcZcqtjZMhFiQCHh4l0yihLcdO+k06sG3VealJsG6OZ2x7cdx0KoW2TvOlJPHWEupwDyxStu/htynsY3S9zuOSwdQGiY2knxrP8QZKs6qoDzUuMbABBli6ox2fqdEXzObev1a1UYJ/MEopQd5Mm7gBJdVQi3gd0IGo9d8b5T6snUEHvwwfDaZZzhEc9Myuv75gGtmnkRP66pRXc+Ag5efRks/XaQgkeOe5DQaI77t4ZNd8ihbBdC1SG+mZpPl3pro3k4wqT+gMJNF0+VvGE0kJsOComgJo016okHkbUp6uDnxHmG7Q1Z2FNVYLqkvUX+5OCRfV6+hixXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuYat74pjYc+38w/rrUCed12bQeT2QfB4OmsbdBRfbY=;
 b=GDSgPOYNnuwtCvVdRRjXy7D93QsnhA0BB0xAdKXy9TBNM+YpNFUzlX6g1+FDpfj1U/WChPLwg1idcQ1LFDYihxdvwfeiA6dQtffKcFnZrFuqvNZXHaMcnBGfX51STBwSP2nxjm3gH7+oFzn4CYr8rFSz6L6O5Tsi7gOF5QJY2fzUB66Yp013lOBRaXQ4CHGTE4Ox2//MdPJK5CCjboN2cQuvKUEDusFJ5ERZp9m0r71/jKM/GAJJpV2iCrQvbNUYHnKgIDaBt4oZsRZ850UkhlSGRbakJHYccM+cJKl1DQwTg0KQ4X/Q1WqLj6XLi3Uk2up3NS4Vh0sPRWMABM7Bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuYat74pjYc+38w/rrUCed12bQeT2QfB4OmsbdBRfbY=;
 b=hJ4eq4hI1zEG7rf6/Vj9Y/mp57/l3+eiW1ET5krjl9q5REwX9cx7PBtY4JZyXaqdZwBEnsidyiaA7LiJOtAX6lt922YBhD/6phF1JOidmgIyLset3TUYarZZ999rQUGfHJiM5FpAFXl2rCBsEmHjYacSK98vXLs0e3ALSAn4+dU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1316.namprd21.prod.outlook.com (2603:10b6:303:153::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 16:39:03 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 16:39:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH v12 0/5] Enable Linux guests on Hyper-V on ARM64
Thread-Topic: [PATCH v12 0/5] Enable Linux guests on Hyper-V on ARM64
Thread-Index: AQHXiUjTly44W5NXSUiYnV60OWzMuKtjiD2AgAAB+tA=
Date:   Wed, 4 Aug 2021 16:39:02 +0000
Message-ID: <MWHPR21MB159317B1D47ED60C73B47021D7F19@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
 <20210804162555.GD4857@arm.com>
In-Reply-To: <20210804162555.GD4857@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e9af289a-30bc-4dcc-831e-c7dfb5d976de;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-04T16:33:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c30b73-777c-4d1b-0ac7-08d957665e50
x-ms-traffictypediagnostic: CO1PR21MB1316:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CO1PR21MB131600D52546D2C4E53A18C8D7F19@CO1PR21MB1316.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EaiYvDOeBfYT/ChrjyztSlkw4xlRg3heQhY7AhqR5fIpdZUV3vs9w8WbTAZShN1odF/p0y/OtRTotJ9Rg/BeDC5XnB23/MMwhKbw7f0GBhqJ4l7wXFkfreuppgUbRo3WR64FeVTot6mDt4pqHcGbFs2SzHLHtBzVuC7a4x+MGynAiLIEzGNb8xTg9ju660glSqIqMs8Tnmt7wlfdeq5cr2N4tOTnhQozBv52Gh45Ohl6GjUY92rR7ZEhUpZs2HSW2wsgsd9zl5BuYRfAYkRUo5PNVc9zMX8vkzcIEZoO0lanvyikEt08a6fUT5jNNB+Mu+fWJrxKrYNiMTLxyrEo0eheeIz5d3rBhoy/jvRhxHqgB790x6TrH+jk5nxlwy4OCyws032qypBy4RBY5fnARXJBps1orHc0nKNSNrv4m5Hao6g0PMG5ds4ViAgEg0AqEB1hdp0d2uGaPNw9YKUX25TRy4z3sBuENZphdwE4+1DAIt5nl7Vet1igkbAA95GpDkM2AJKyoY/Bvl2XBxkgelfuI8uagocFQQkdMMfq8uwwrMizTzeDD9+sxo6B/r2nbJvDTjRmqJP2ukcHls04xzK6jYbArPdABQXkCLjNIYeGwaJiNUeB12Gxc7b8nNsG/BoPkUJrFzJWT0pPTbEMGGpq4pczW8MHrek0tBbQo/nnhYGh6L1X8A94HYGjpIR/8h45E82u37DMTxkNXGsX2Lakd4aQbWOhufLgoE48KLsckHVdSsF+h9NP+3fOgFkcXcFkb6s2GjYhG/zr3RpI+2/RwV8YiEX2tyHU4Z+1Ub0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(10290500003)(64756008)(26005)(76116006)(66446008)(66946007)(508600001)(66476007)(7696005)(33656002)(4326008)(82960400001)(186003)(9686003)(66556008)(55016002)(5660300002)(6506007)(52536014)(8936002)(8676002)(8990500004)(86362001)(122000001)(38070700005)(6916009)(316002)(2906002)(82950400001)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oebF4uRyInU4wPs2BjKJk9lN3nqXKM7Xd9V8G8Qk0ZebO7fpPLqOsVjbl7tD?=
 =?us-ascii?Q?XWrpoGPdt6fjej28F59MaVTV7Pmvfqc58li6SIt02fw9yzoV8FO202O1hwTr?=
 =?us-ascii?Q?yUu6IESd+/QRWdYrnkd6P3UURumxaCDQs+fiiMNp0LznC+GxmGa1uX0l054d?=
 =?us-ascii?Q?OxINs3PP/nyYCWJtzipb6TvF3TLjDB0yJKyG4col4EIT8PG5jfA2YFUfp3dR?=
 =?us-ascii?Q?kJ8umuLVrDLk8WIRA8fNmSkcuW7U48hoVBumzkQdBURAGq3Ct18iciv8LR4Z?=
 =?us-ascii?Q?u3P2HD+EBtHjXNjishcIjk7iP2M4DLYGj4tUf9XXeosWcHavISDejI5sZ0qe?=
 =?us-ascii?Q?d9Zu4r0Dc+mY0qo0eXr/74ZtjhDEvjiQusFvFndKXw0klTlIPsIXj5yx4ufJ?=
 =?us-ascii?Q?hbJrDe7otQP9n735SN+EzqY+z0ycCS8L3oHI4Lf9BnPn40CE0B90DDTtfjvw?=
 =?us-ascii?Q?M/+pcK8Ny5vJGhBpb0/mRKE8PifnP58nvBTWpQYddEJSi0lLp+La1Jyk9Z6f?=
 =?us-ascii?Q?utk0ZGSJ0xQ9DOxkkVtxNKakZPlfG8mk1xFAG4NuGgcJxAYr8N55LuXUDK8J?=
 =?us-ascii?Q?wMa1lkiBw++3Go7WzG+8Xque+h7ZIHNQs5pyVbQSQieN25Yfr2s21IcJpu8p?=
 =?us-ascii?Q?vpTrCL1+lE0YU4uekVoxCimitAlPqhCUn7kcs69pYS38xrOB3J/J7UhEBm+Q?=
 =?us-ascii?Q?B+ZJG/gdxci0qMzSklqreNFEfNth0D7vuyKJGxGKILuKOiv/eaRgG+uu27iF?=
 =?us-ascii?Q?0v+5EWsamxI3m499n81/W2L7WhPJUHi7c93YDZzX3YFxxUpUUNuw6B9XV6bT?=
 =?us-ascii?Q?APjLWR8z+7XLZTJgH3Ktx0O+Voq1xHlY+hdXh6tTXlnf5jAV9IJa9i5Ewx7R?=
 =?us-ascii?Q?T9EY6weXuEzBaNMKeLCOltifqeCe0dNh6uTbLxwdhsozEyeI7uvx1c6ky2p0?=
 =?us-ascii?Q?2jD4x0nvNFr+FeAYW2qOvrTD29t9bI4+iaVJrgmx4qfhHSwr5dS0mjVBhDLS?=
 =?us-ascii?Q?8NtZelTmEWWP7fojtpUGirnlOF4QLxHWiS3DPwblAcgAXTm62ZVD9dvPEnf1?=
 =?us-ascii?Q?uG9S8Qr8u2iaO9ccklgJ1YfnXjrY62hG0CSteeqZoBFD8CwzJ7Yv+4jg5edj?=
 =?us-ascii?Q?xyai1ymnxQq2aKbcmWnrWmfhP6jNjeXOX4dR4qOyjjYDQ4mT6qjmYYKvTeio?=
 =?us-ascii?Q?hICcqm3SMuByu9ZTmsYrVRmc9tOmXTl479J02O98GOZ1wMdg7w2v5bw6z6c0?=
 =?us-ascii?Q?Td4NCsdIMEq4xSuoOZa9dh+7JFO4brfE+F4J72MYEXYls6/Fx2WQAk8WUvYm?=
 =?us-ascii?Q?fTJfCZ5+DCI9kyiofMERT4Ut?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c30b73-777c-4d1b-0ac7-08d957665e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 16:39:02.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2O32SS9yf+grSzT2NbUxNI7YLpoVGWtWZxc9yudRDugtaS1L8aRu456Dr7fzrtPjj6BCLGcdNHDKLKP5gMFLzY5r3cgaiweabHvEuU8haU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1316
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com> Sent: Wednesday, August 4, =
2021 9:26 AM
>=20
> On Wed, Aug 04, 2021 at 08:52:34AM -0700, Michael Kelley wrote:
> > This series enables Linux guests running on Hyper-V on ARM64
> > hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> > Hyper-V and its hypercall mechanism.  Existing architecture
> > independent drivers for Hyper-V's VMbus and synthetic devices just
> > work when built for ARM64. Hyper-V code is built and included in
> > the image and modules only if CONFIG_HYPERV is enabled.
> [...]
> > Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
> > with 4K/16K/64K page size. Linux guests with this patch series
> > work with all three supported ARM64 page sizes.
> >
> > The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
> > x86/x64-specific code and is not being built for ARM64. Enabling
> > Hyper-V vPCI devices on ARM64 is in progress via a separate set
> > of patches.
> >
> > This patch set is based on the linux-next20210720 code tree.
>=20
> Is it possible to rebase this on top of -rc3? Are there any
> dependencies or do you plan to upstream this via a different tree?
>=20

There are dependencies on changes in the hyperv-next tree
(https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/)
which is why you are getting the build errors.  The changes
common-ized some code between the x86 side and previous
versions of this patch set (and fixed the #include nmi.h problem).=20
So the code would most naturally go upstream through that tree.

Michael


> It applies cleanly but it doesn't build for me:
>=20
> In file included from arch/arm64/include/asm/mshyperv.h:52,
>                  from arch/arm64/hyperv/hv_core.c:19:
> include/asm-generic/mshyperv.h: In function 'hv_do_rep_hypercall':
> include/asm-generic/mshyperv.h:86:3: error: implicit declaration of funct=
ion 'touch_nmi_watchdog' [-Werror=3Dimplicit-
> function-declaration]
>    86 |   touch_nmi_watchdog();
>       |   ^~~~~~~~~~~~~~~~~~
>=20
> A quick fix for the above was to include nmi.h in mshyperv.h.
>=20
> However, the below I can't fix since there's no trace of
> hv_common_init() on top of 5.14-rc3:
>=20
> arch/arm64/hyperv/mshyperv.c: In function 'hyperv_init':
> arch/arm64/hyperv/mshyperv.c:66:8: error: implicit declaration of functio=
n 'hv_common_init' [-Werror=3Dimplicit-function-
> declaration]
>    66 |  ret =3D hv_common_init();
>       |        ^~~~~~~~~~~~~~
> arch/arm64/hyperv/mshyperv.c:71:5: error: 'hv_common_cpu_init' undeclared=
 (first use in this function)
>    71 |     hv_common_cpu_init, hv_common_cpu_die);
>       |     ^~~~~~~~~~~~~~~~~~
> arch/arm64/hyperv/mshyperv.c:71:5: note: each undeclared identifier is re=
ported only once for each function it appears in
> arch/arm64/hyperv/mshyperv.c:71:25: error: 'hv_common_cpu_die' undeclared=
 (first use in this function)
>    71 |     hv_common_cpu_init, hv_common_cpu_die);
>       |                         ^~~~~~~~~~~~~~~~~
> arch/arm64/hyperv/mshyperv.c:73:3: error: implicit declaration of functio=
n 'hv_common_free' [-Werror=3Dimplicit-function-
> declaration]
>    73 |   hv_common_free();
>       |   ^~~~~~~~~~~~~~
>=20
> --
> Catalin
