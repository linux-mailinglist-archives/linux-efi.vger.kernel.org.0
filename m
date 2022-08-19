Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96159A533
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 20:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350232AbiHSSEe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350077AbiHSSEF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 14:04:05 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96A118CB5;
        Fri, 19 Aug 2022 10:50:10 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JHk5ku022214;
        Fri, 19 Aug 2022 17:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=RnwnYghEwQeP0XjAHe5hGKq5zloA1y4JTzPC+mj35eM=;
 b=Fzx0vPqm6CDyhm59L9T+LtlePi2IOW0qz7t5KKLkbjIR1490p1z0znB07gryaW8ztW2K
 9zMZmQvWlaXX0YzcatkqDihGPU+iCYdfKO39t9Xj2KfVIiHMuBOFIVjRe5yNg6lRQJoI
 qZnu/UQe4cp66OgvXLyrquTeiOjRr5UmE5EM2Yfopl3z70H2FezR3ksvMC6m63nIwQ0Y
 QLvuwKBjXhHfNweOVkWISnkYIwQGwcot/TOKf3TFqtdzMUz+0HY4JLzhCag6kSsAJaAz
 NGyEZkrWUREHMyqa7l406OLOkuivmWvM4jbWw46GVaBOH2Vd1gB9GBFJ1bC0rFiT8bVp vw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2e4h94bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 17:48:58 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 638ED804CAE;
        Fri, 19 Aug 2022 17:48:45 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 05:48:42 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 19 Aug 2022 05:48:42 -1200
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 05:48:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTkvcuYc9aQ89qLMsD/Hm8vcNle9ZyHWuV6dRATVA78ucOvSkxRDmD17NYJJVuu/5z6r2kmNLm4LMtG0Arrw214ZGGrHlSt+SMFmmqzLQ9B6W2Q60+wbU98+EqF6zFnQmCE2zcLSy4mj3kX9FLnMplOXroHlDw08KUnWupPGe9dgqniEYQRxWAq3LOwKee0zL4hSRxs68AhwATST2HINHYd87+muqML1fZK2sNADr7XgyXQ14C+PQPIvi6ZOJ5c74e3Lyy6Cuaj2GZcZDIow2GjKEXwfBTOwWIzr4j2J2kl3wF9LS6ssXjygYTtNu7YFJuoNuhlKAgyM+FKbj+143w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnwnYghEwQeP0XjAHe5hGKq5zloA1y4JTzPC+mj35eM=;
 b=IKYQ0GctAs0D1w3WxiHnBViN9RecUFJhO8djX83dyX86clk+jvkXrcrtKZXvz3rxrljElLkRTKMPNkZvOQ2clZvdxHlFTg+iSANT4kl0KNSxmeaqCbJMVVqTZkaPH5Dim6qUNddDtij0yVx6d0cYCOeF71um0JRKMxOQL16ZZVVK9DJx1ROAYEYSjZuQ0JZPTZcq17rjWiJqp+zyWxnuhM4KSqo/Tgl4WUmUV1DsUl44O3A4Hri+AMVR782b+aqBWKucNUaNwwkPuECSBk6SvLX6mdwornEEF0QkUomkNFbrn7woqkDgXMy7jSBMyazpv/WM481hE+IGwCJpPnHDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 IA1PR84MB3057.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.17; Fri, 19 Aug
 2022 17:48:39 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 17:48:39 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Justin He <Justin.He@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Topic: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Index: AQHYskazgdaGLeNebEWQzyv29780RK21ZjbQgACj04CAAE7iUA==
Date:   Fri, 19 Aug 2022 17:48:39 +0000
Message-ID: <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
 <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de165599-b7a7-4320-5658-08da820b0cba
x-ms-traffictypediagnostic: IA1PR84MB3057:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fMiuKEKVmaS0hYDxs/Nz6X6IZd7hu4uQVdTPQFSIdyd/2IkE22CAgGnrF7FSWxAxcegZRzBkXDEAhDUeR8AOsqJvdDouf6mIjuDGt4EpY6tKLyF4k5yehRkZ4UOJtCZDlYWndsd5/0hzdENIlBIJ1O0s5wUW0Yxk7I/c76WTdikoS9sOt3lkSv/go2vbirAlUjY8h9wPoKEy8o+n+mDHzHDOFTS9xBFLaHY6TOtxwgN9ZxgwYTjuLlK/XNIknjuPAZVnnj8rGQB8bsPQsErnMeVLhtEEzwHemWBHwN56pIXjiC2PsMUXA4ZHk5LjrpHxK6FFKBfCD4dhlY655772MUz+5dmZbHpRc5VHUMuOoY/J74xjqzo+pEd/a/dDm+lcy+/v88x3VsGhLbAaRZU5XmJWTaAcJ6t9bTVcod0Oijy6SQ9NMSl0geq0t/6Bg+A1KgRozk32zoG9Hxekt5jTAWqK5g1ruaewSSgG7k92/XnO7yeHie6iM/bZkR4ggKaJtV/VZNOFPdXetzeQX7N8eD5mSlf+y1U1Mj6LRRRnUoKKATr+kchQv2jdJXVM6EYRahaPzca4ijSMi7kpfBYyUaf+g1tmz5AZnmfLGSlv2vOQAI3G2YB/vPrr5gmbIWT/DW7/aTPyXShcKyASyUgzdfIj+CyATgw4EAt/AKVupieDu24wLiDiq3e1hslelA4BIUoGwXxK8IiMiBi0C7LOKZOO2g/SzLhUTvOu1ixvsbdROuL9GBBPctgaYdGg8r9HQfRG1cs6/SrFzGWqlFPawg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(376002)(396003)(346002)(6506007)(122000001)(316002)(4326008)(8676002)(38100700002)(66556008)(7696005)(33656002)(5660300002)(53546011)(66946007)(2906002)(41300700001)(7416002)(66476007)(64756008)(82960400001)(76116006)(66446008)(8936002)(38070700005)(478600001)(9686003)(71200400001)(52536014)(26005)(86362001)(186003)(83380400001)(6916009)(55016003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QOQLc18eDNEeBfzGevGzsDDvfsJLc43vwLL2s9IEJCaaip/mLnpzdqUnmndJ?=
 =?us-ascii?Q?bCkfcgo6JzGhAsn2NjTtv7EzqK2643r5aT6alf7dx751ASdjjPOhLh8OiiSU?=
 =?us-ascii?Q?0xAWeuZoZa+5adBv8RYvppCr8+Tl7ZhdA9An1trHp2qDvtQfRzsodovuVtmE?=
 =?us-ascii?Q?hqHC//uwEBn+r0sn/T0kxuJnKmwZZQQYwcawQsBUM1kQ/FvYqxEdIRLvS8AA?=
 =?us-ascii?Q?s9kvKZLhJRPQ8cKgL9wHYGvx1+tIfXZHahUkjIKO8z/w6PJ5bkj1hFh0THsk?=
 =?us-ascii?Q?SaKUjncJE/qQ2GAuaKjKIfCESz73L5jaoe8LBwAAC+pJ0IN40wM+o2k4I0tL?=
 =?us-ascii?Q?Le/tk4l0hpTRkFhSqJPotKkLwcOQtwrMW9UOt3penONMZvTgd/8AtNMdbDxm?=
 =?us-ascii?Q?p7Geeb8RH6nvXp3pqaMVWJv9TI9T/PrV0l6p67YdmrD96+A3P+OIvysXRKD7?=
 =?us-ascii?Q?GeU2TPk5L0sqrUDRoI/EauD8jJeGvA9/wG1zuJnUpl4y3v1LUx9Fiptj65Ky?=
 =?us-ascii?Q?118BC5iUhGMYvbscCPtFndKaJk0vsDGi8ZW5cK9o7Av0iBUFQcVJq7T5InJY?=
 =?us-ascii?Q?yHeYBwC2ChC6vj8r4LK/HkfT4z4NEHDQU+O7fo7liisDa66jq3uIUdmnqqJt?=
 =?us-ascii?Q?BVBNDqjhqATVbO+7XvUKCFQqqyEsI957pVLZ1emnjkniKJTEhOCBlxhQjJR3?=
 =?us-ascii?Q?eXjM4yHtIhhP+fzIWafy57NLTJ0QXxBPwmAphlYVzVypSzQJ2hmOVyM8RUsK?=
 =?us-ascii?Q?Mi81HEtNr83JLxnX20vIGIpFbyLy5UWrb0QRepnGMsF+d7Dx7Tkg6fzOlTYp?=
 =?us-ascii?Q?WF/b+KNb315xvX2CKS80hlx1iduj9ec2NEmqmhu4bxTSkiBm91VIdZkrFb4Y?=
 =?us-ascii?Q?0qbCfUYByg3Or7If3AwKJHTrtF5fURAZ2+tFZp0eeIsuVXlsI6FZN+HYxird?=
 =?us-ascii?Q?pTIq+S1UhIhj1I0Led72fOLlQFXiE1q3AJ/ZG9bWTQUfcAa3SXG002h12biw?=
 =?us-ascii?Q?K0vjv3t/XuBkDsW54D5k0zCq15Kkth9k6/MSnf46rIxpvRDl3hOiejpTdjGD?=
 =?us-ascii?Q?ODBPIha+ayER2IOFyRCzlJVZ8P8qYE41Uu+fp2jwrbotlpVfJHUNrbnUu9V4?=
 =?us-ascii?Q?HVnRGVuS4jl7TIzhKZHYibC6Gq37BKi4MqJHt7+zD+zDiE69pnx2aWX3VMJ2?=
 =?us-ascii?Q?grHddff32G3t3DCAz7M9XuWGnKZER0X5Jb6Ba5z3RVJNPE71rRbhiZ3lkb4T?=
 =?us-ascii?Q?VutEIsrhwcoPx1OXfVJZe9zSo7ancd6PlROd3AAXQvVB4/Jh2uKjZJ3DOn1B?=
 =?us-ascii?Q?uvcw/XJF0AihTiJeTft86GaBqoJgE1f8cnOpbbE3UJZZGFJHX8vU3SQyHFza?=
 =?us-ascii?Q?jCL7benSDwzaEW7ZjFFe3BW5cQmG77aFuoswp4kUofq9ktOYJWXB19Xu5l+/?=
 =?us-ascii?Q?z+HGztFvl94AsCgTmIqIrGhiI3DaHpGM3H/xyKXWKDM6zicL+MgZimmvYyQB?=
 =?us-ascii?Q?w9SlEbhUGmhFSK0Cs5MRQjrnJpmce+XapnVrQstu9U78zz7P0U3nKCjSmePC?=
 =?us-ascii?Q?wK/dWnNzRBjCk4rrZZgKlxJcQvAbYUf1C7AXu6at?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de165599-b7a7-4320-5658-08da820b0cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 17:48:39.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEIdjatB/o+SGyZcnXvLJJxS7XJRx8BDep/Xaw+5O1ZJHbMAD5QRd8EmAA0SwvOOOWu4kRL68TIWisYP04+QBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3057
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: jn70Yokz6HMmy1uYzqVXMqCJxEQ8gYrv
X-Proofpoint-ORIG-GUID: jn70Yokz6HMmy1uYzqVXMqCJxEQ8gYrv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208190065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Friday, August 19, 2022 4:35 AM, Justin He wrote:
> > > @@ -1382,6 +1395,7 @@ static int ghes_probe(struct platform_device
> > > *ghes_dev)
> > >  	platform_set_drvdata(ghes_dev, ghes);
> > >
> > >  	ghes->dev =3D &ghes_dev->dev;
> > > +	set_ghes_devs_registered(false);
> >
> > This does not look right to me.
> >
> > The condition of using ghes_edac is (ghes-present) && (ghes-preferred),
> > where:
> >  - ghes-present is latched on ghes_probe()
> >  - ghes-preferred is true if the platform-check passes.
> >
> > ghes_get_device() introduced in the previous patch works as the
> > ghes-preferred check.
> >
> > We cannot use ghes_edac registration as the ghes-present check in this
> > scheme since it is deferred to module_init().
>=20
> What is the logic for ghes-present check? In this patch, I assumed it is =
equal to
> "ghes_edac devices have been registered". Seems it is not correct.

Using (ghes_edac-registered) is a wrong check in this scheme
since ghes_edac registration is deferred.  This check is fine in
the current scheme since ghes_edac gets registered before
any other chipset-specific edac drivers.

> But should we consider the case as follows:
> What if sbridge_init () is invoked before ghes_edac_init()? i.e. Should w=
e get
> sb_edac driver selected when ghes_edac is not loaded yet (e.g. on HPE)?

No.  The point is that ghes_edac driver needs to be selected,
"regardless of the module ordering", on a system with GHES
present & preferred.

Note that this new scheme leads to the following condition
change:=20
- Current: (ghes-present) && (ghes-preferred) && (ghes_edac registered)
- New: (ghes-present) && (ghes-preferred)

The option I suggested previously keeps the current condition,
but this new scheme does not for better modularity.

What this means is that if ghes_edac is not enabled (but ghes
is enabled) on a system with GHES present & preferred, no edac
driver gets registered.  This change is fine from my (HPE) perspective
and should be fine for other GHES systems.  GHES systems have
chipset-specific edac driver in FW.  OS-based chipset-specific edac
driver is not necessary and may lead to a conflict of chipset register
ownership.

> > I'd suggest the following changes:
> > - Update ghes_get_device() to check a flag latched on ghes_probe().
>=20
> Still need your elaborating about the details of the flag. i.e. When is t=
his flag
> latched? When is it unlatched?

This flag is a static variable, say ghes_present, which is set to false ini=
tially.
ghes_probe() sets it to true.  ghes_edac_preferred() (aka. ghes_get_device)
checks this flag at beginning and returns false if this flag is false.  It =
does not
get unlatched since ACPI GHES table is static.

Toshi
