Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6333E32C98B
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbhCDBJW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Mar 2021 20:09:22 -0500
Received: from mail-mw2nam10on2124.outbound.protection.outlook.com ([40.107.94.124]:11623
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1386532AbhCCS3J (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Mar 2021 13:29:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSdGdtlQjR6JEi7ypIFN6k1AvrYT6P+JMXxXr3lGFlSU946xiMOVmdXM72a3X3NEJYgyfeut//CodKN1YgUoBd1Dvoqug3Ih3PmSys8oBadhlOahXBjycd/wYQ5gZzqOsHsNobAphngxw4dlWP+PlFVQGWS/VsKus7KoU7Ml0rfD3C5j7FYtOlKnrBd5eqltL3ZWBOk/Qck8i9ruj2CuThLIMUNzGq1enG4s6pIZadqkPwYwOZGwvPIqqKiA5ZNFayspExhAAQX3d2ZFouiP+tMkZbNgMeqUlMxHSpc1AnSP0wC0xZbO9myeqGP0eAD+emD36dEWfb16MCiSmXSsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCaTJYv1PGUgqsmnq3TTdSNdQwwQAp00eGMpIvWuD/4=;
 b=DYAc6e0mhebZmu7rWFQEyayB86tL8yxgEnFN9ZLAbYSe4yXBWXtEyf7j/qOYF27qssVN4KyynFoWiPfm5IizCuwjGtn+TN6GJ/UXCq52jNRJ07XhNHWnEYedKJRVuhcx/TbLMoDdmZl5xkzit/qbVQN2Nqhk8eQiGBCXp2/kD3yutaPVYZu4lIqXuFXrK+Tht4NdtZuEm/7CS8dQeRFYyA5431XN2pCZQm24iIXOhlMnd9mjjTtMir4E9kzsRnr5hUY19yiczES7b9QHhniO7IVK8qpSCiEV8NZSuxxu63SAN+PqqhW49UhWf560I6CsNsC1toNkPCL1I5j24cPBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCaTJYv1PGUgqsmnq3TTdSNdQwwQAp00eGMpIvWuD/4=;
 b=FBHnbiFbY2Z84ZS7wmiNv4kzGdFK9n6lAx7oDx5Vdxwi8OyZUMHPXTTQUPEACh2Cb+e5sr+jrvCv5UPBS0EvIYzGhJTTy9u642ZMuRrWB9tZB2+DWMM+pUMSzSXxA942A+s/V9BQwBBs2G3nUReOlFAArZLfufB04t6OvL0xJBI=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1664.namprd21.prod.outlook.com
 (2603:10b6:805:62::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Wed, 3 Mar
 2021 18:28:16 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61%8]) with mapi id 15.20.3912.011; Wed, 3 Mar 2021
 18:28:16 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v8 1/6] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Thread-Topic: [PATCH v8 1/6] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Thread-Index: AQHXDwVm7IanFUbz6UeLdWLFekPIfapxZzMggAEuN+A=
Date:   Wed, 3 Mar 2021 18:28:16 +0000
Message-ID: <SN4PR2101MB0880BC201B64BF4274539951C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-2-git-send-email-mikelley@microsoft.com>
 <SN4PR2101MB0880C47188DAC6446BF5E156C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0880C47188DAC6446BF5E156C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:3132:9d16:d3c9:b7bf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89f19a60-e025-4c73-1d2b-08d8de721cbb
x-ms-traffictypediagnostic: SN6PR2101MB1664:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB1664A8FCB4087A3A79B2BCA7C0989@SN6PR2101MB1664.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2cFjlAptUahYzVR93P+YgX5ikbhIK4nK10hWWNrb/k8XuDfg7mxeuOJMa2r3KNG6WnKVy50aku4IOKieGZF8cgmfbe9wRGAWzg8N28wpn44jbruLbfSUhomyqCeWBAXaoTc0xeYg4H2ekDOrYLlX/cpEeFnvOKE/4xzruYtWEvLSniB4BE52RQTJKceIrOadZsoGud73Gi4SBfexj5r3qqUrCwOFkw9vVd9CU2WJQDbwIwIdIBQuAR1pyvY6uG10Yd6vD1mGDpBDoyjS/N1gmVPQF65u4mW9hsrIqwLD8n4CemrQ+8Be4GuQ3EYnu46Xp0DQNvQoWQ4jItef6gv46h5aEOnEYh5vl3AxHqY9eVDC1Qszgkcs7kZbQSByRTIjS+Lg9XOzODtiO6H0OwbSPS1SmphWWco57PD2QbcIxYhNoTVi3mhjM1aj3ky4i3NIjwTndH2VJ/17C3OddkmjNZtskrJKMNeE04+d3V67N7VFTS9fVp2jReIB6UA9kHJ2O6OhtxTwm9bqnTZsBK6lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(8676002)(86362001)(71200400001)(76116006)(7416002)(2940100002)(316002)(33656002)(66476007)(7696005)(9686003)(5660300002)(4326008)(66446008)(64756008)(110136005)(107886003)(55016002)(186003)(8990500004)(82950400001)(10290500003)(52536014)(4744005)(6636002)(82960400001)(478600001)(66556008)(6506007)(54906003)(66946007)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uQCGJNRpXkkIWGeEcnhDYyuVD5TrsWO1ZXwGn+8d3CNIJ1f4CPj/e781qvLp?=
 =?us-ascii?Q?I6B4xsm7rXZpiIYQSe31jNmWxShHfFnIhXZVDYWrpsl1wi+mJNfY89UsurEE?=
 =?us-ascii?Q?cMR5yLiAg0ysWQoaX88bDGTLdJiyymvnM+QgSkaWWreJ+SDJ215vSnYz1wqo?=
 =?us-ascii?Q?IZLLWxbjQtTNVczKlG0NVuQy5PttpH8vv/kWBtRayp33jdQCwwaPj7IpdxHI?=
 =?us-ascii?Q?1+dI3ShzbwpM6GltWqIioktThdhlWQ33pyv9eGziRU1b9M3aO6E4EEaXMSl9?=
 =?us-ascii?Q?tVefep1WQ7hNg3yWdWHN/Yl5GtZ6xrW4CVjNUXHd9siI9MNd4qDLefsJ6mEF?=
 =?us-ascii?Q?z46seKeSa+9Y1I4AdtlNUSRvb1AJeqdy0DnmpaoSNihJ426Xv4L+ZUHVd/vp?=
 =?us-ascii?Q?jZ2nP5DKD2t4ByDkKyjRLPAMO+qvcVg3s47YyF/wlA5q8RwFhRDPufL8vkxf?=
 =?us-ascii?Q?2mfRLkRoCFFsEjxFH0LBP4UDk1p5f/97WuNSBdYE00OWAjrmpK+AAlYhnRDU?=
 =?us-ascii?Q?fupQ2UnUeNlb8/WoABfw1AhZm0te/VJt0/b2GS0p8WuMy6ptmgZPT8nyUqic?=
 =?us-ascii?Q?8u3LfAFpBqmoblkfGKJyzvPqbLt/9GvsnBSXlfpcfd1jieVoEa6MYcHKe4r0?=
 =?us-ascii?Q?Gjda18oI0U+j9Bv4U+S6my1EuUnYSQG3CZQV7RqH3WgL1O8ajWHDE4Qw8Vvq?=
 =?us-ascii?Q?vpuEMPKraAEM1lyg8CIGlZtDAYlf2pJwDS11oNLuLipUYn5rx4oN/LThAOIz?=
 =?us-ascii?Q?a/WC/3/ihGSzmUi+CADBFgTyy0OSXte3hvK5X3/+J3eojRl06eSSYrEycGCX?=
 =?us-ascii?Q?wW2/RRG2gdpHTeZS+ghz0WjEBEx0bttAnw9A4O6hmDx//YKAgHnWn9XyvUBu?=
 =?us-ascii?Q?pdxRCu6LsOJmT5l55fpwqSPO0ZJBSprc8RXlAkQOLr1fa7tR6PQHwumsdFoq?=
 =?us-ascii?Q?Tt9jgfUlZww4T8EEabXW/w2zsI7wHEUda/ppOAiwF65OruHMmRDvEgS7edyh?=
 =?us-ascii?Q?xkKAAJE1200sTFsGiDVZuefCwJTNDfWAK4tA3kQ28XIW+QjNYeQaijDcVoA+?=
 =?us-ascii?Q?JbYyqtjoGqMhuxi1MGvzZuhxBo5ftxsLw2OklR0092ILnGyJZJHSBvPViZCM?=
 =?us-ascii?Q?Ry+P1bPEtZPCSDOSOxQkdiuGMhtdVA4j4oUApnC7rzO+vFtwz5TAIVmG7PLe?=
 =?us-ascii?Q?9g17Qp8grWmSJmXWbPSdf3fsN/fkxM4SQBVxNJrfAlss2LNYLBAbys+YZTcC?=
 =?us-ascii?Q?+U6QKLYXfsg3i7dhjGzkMdpJJyWO3bDsQMRCzu/IRjfP+o/wX59sQysorrlm?=
 =?us-ascii?Q?mQEDSXdvO2zUFKrLGhQxvftmmBgY5kCo27WJHkCFJ+GVdJaghW6TiIUcoBd6?=
 =?us-ascii?Q?oXpqrGl4rMCvwGpCMAArzOMpCsV9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f19a60-e025-4c73-1d2b-08d8de721cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:28:16.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNitiuIIw0D0gu7dz9HbOQp52A46aaQiqrPzo17fefdK+bJU869z/hSOd2cYJv3CJc6jPN9Q/DqGKHzrNr05zgkML9Dc4DMsR4BNG3PpyEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1664
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> > +
> > +	/*
> > +	 * Allocate a power of 2 size so alignment to that size is
> > +	 * guaranteed, since the hypercall input and output areas
> > +	 * must not cross a page boundary.
> > +	 */
> > +	input =3D kzalloc(roundup_pow_of_two(sizeof(input->header) +
> > +				sizeof(input->element[0])), GFP_ATOMIC);
> > +	output =3D kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
> > +
> Check for null from these malloc routines? Here and in other places.

Between, is there a plan to setup a percpu input/output page for hypercall
input/output on ARM (like we do for x64)? I didn't check the specific size =
requirement
for this particular call, but, that generally will remove the need for thes=
e
allocations.
