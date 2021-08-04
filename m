Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37083E0616
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhHDQnQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:43:16 -0400
Received: from mail-dm6nam12on2118.outbound.protection.outlook.com ([40.107.243.118]:28385
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239434AbhHDQnP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 12:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwChAQ9OgbAF185X3EZKH27U+CHbnoNwEV1eyT3JKQUXKJ1aQawBQTRu4rMi6QEetvem+o8c6Z/iPIl1dTN1wYGokY3+HiyC5/Ka/Hks3qYfnzlYUumri7b/HtLS44geiQ0uHPCZQe6fDa4a3byGmQiZw6CS7SoFrs7h5Z0YTuIqVZAsHrSjxg4K/FrxPc9mZI3PYUrPdvPdeb6RCzg4qG1EQPugg+u2LS8gVo7bS4mqyxnclBP7oflmRFoj3oy78y5FBSRyyGOQoXO08YE2OB26l0XAz1oiDGx2fIjBGw+Z60FfNnPmegINeEhZz4tf0ztV/FqNEBxynYixQ2AgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4UJyFe0MoAN1/gjzodAxk7wz7UxL0pAwYN984tgWiw=;
 b=R5S7GD0p75lDBKoYjFz2ow7z1G3acI30iNE6rQlLpDUtkxVR9z75ALgzc+zfG6ldc+UxrIeIItsUMwACNrTegklq3SAFlkJxtjAmR2pm56AFVYJCmmtoa69+CaVgdeDb+Wy0Sie1DbY7vmC6sR5LcNb1i8CyCOZJE/gI8KFxBcHth3AnzuKlp0Baxj4t2Tm0UUGsOn6tYx7BSSN/BVeQ9Fo22CIn1QyvOQ4ydcfHL31Hwpt6Ch0rdv4VIi2WwpHA+oiD2HCeqQDFbW/28DxRkudTOQl822TWtUEBO/qYHJO8MiXFU0h4lF5/u1ueViXE7FkOwrAy8Ob1gn9R0ZwWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4UJyFe0MoAN1/gjzodAxk7wz7UxL0pAwYN984tgWiw=;
 b=MkJ20A+dEwraMi9GMny/VYU4Up95bj+rSnPPLU6n6I5FIiY9Yl/iWW3s0zAigecO4Hrb+/oMoA4kGG/9A30Q8K9am15KealJ/IMhX/MzyNsut48HBTcNbmd1XExISlaKiQ0/FgmWGSVD0QDyo3G+SoEZe6jYkZTcH5jKM9zit0A=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1299.namprd21.prod.outlook.com (2603:10b6:303:162::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.2; Wed, 4 Aug
 2021 16:43:00 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 16:43:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH v12 5/5] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Thread-Topic: [PATCH v12 5/5] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Thread-Index: AQHXiUjbTijaT83PZUe2IShGH16q1atjg/mAgAAIU4CAAAA58A==
Date:   Wed, 4 Aug 2021 16:43:00 +0000
Message-ID: <MWHPR21MB15939FD6BE722550ED25FA5CD7F19@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
 <1628092359-61351-6-git-send-email-mikelley@microsoft.com>
 <20210804161040.GC4857@arm.com>
 <20210804164029.6xmloksmssrdsmvo@liuwe-devbox-debian-v2>
In-Reply-To: <20210804164029.6xmloksmssrdsmvo@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf2f330a-b83c-46eb-b280-fac3561b4bae;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-04T16:41:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7350e9be-7f5e-4fbf-3a5e-08d95766ec11
x-ms-traffictypediagnostic: CO1PR21MB1299:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CO1PR21MB1299EF6EA9246D3D4AAD07BED7F19@CO1PR21MB1299.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNx54pYyhCSFnb7Kc6qbNau8pc5vlLrF2DEn9jBIi+AB5HmftUBRU5DZf/RCrT01mjqKVdIl6pf6dmZ9A63U17yEI85KJcUpVI3ht0ILiQjadIpvVM3nwt5eOGS94JNGr8F+vNaqxs/NDksOMQpRHi5ZKAJ0yofhAutl6Wyd/Rlx2054y2MEawW05IOhmed9vmGl1W48DawsS/obGwsUugpRZrl6A4U1CudMR3SnyFr3iFzkOXUcxs44OBaUbVp+Q9vTkOKg5SIVDBu9q6+4XpIfjeg1yqwFdij3G5YgtG79iQ5IIBHvos/WeUdR/qKyMC+AQMinSvjBsIBd/Q8Wn32opYcgrSf6IonVFvXsmU/uj42TRGKehCUQvVskC2r8k2sgyPdE56u+CiN1ZcjJn4dquXhA2nqE/GPtO2tmCOWYw/weuBOqV0HTyOmbfWNlEWgjBM5VFUb1j9R4w89bxfVr0n3HazHcr7tSXxauKqjK2bzVZUcL1lQNgFu/dQkY3e60rxP8Wg4ob3oQ+UH0CqUdosDZoLeTMYgt2XRy8VywO5U6bTn3klVaTviM5OHymgcYUF2S2mGGmevHnm4sBK+n+Qzg8weddg+T7uv9SCzCbYXR33QovZYE9jI0dzrYCsEaWAim5BJc9KyFUWbE/4YEbOmw9EUxj0796P56epNWkbtC4jahXU+u2kDsyRZsrQnyfwrhmXBcIfU5D/mveg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(122000001)(66446008)(8990500004)(2906002)(110136005)(64756008)(38100700002)(8936002)(66556008)(4326008)(316002)(66946007)(38070700005)(83380400001)(33656002)(86362001)(66476007)(71200400001)(26005)(55016002)(6506007)(82960400001)(508600001)(186003)(8676002)(52536014)(76116006)(7696005)(82950400001)(9686003)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tVRFe7K8uQnH1vGdjGJSB0JlrYRj1ZmeihxPkotTptlvL7ajMU0Alx5T/BZ7?=
 =?us-ascii?Q?9dTwl7j9/YI+iT5ZPsuAq3LlVjPVlG3ZiGq1zKwe5nowL6smwzbn9cDVn5UT?=
 =?us-ascii?Q?L5wxpPPh6vpaQuyaLFkv/4XCM/rPG0qkAuYllTCBp9E/nSzoms0/am1x/e2H?=
 =?us-ascii?Q?bFB6SSo3Yz4kG/fNiIJXLsmtRc0Nzqmlvzba37eWJW+uPixH/HyCTxfwnFtX?=
 =?us-ascii?Q?qpUfL/R6f5le6XPddF+2LB1Z6Yoce8DKdj/ZORxKZnS+YwJHwNvuBBfILeXI?=
 =?us-ascii?Q?Z+IgzhufuxTQ5pvljpVzE0BjufwmvtE5D0j0/rZbXoO7DcDuMS87omg7mXxn?=
 =?us-ascii?Q?rzKWyzYzy3lKHpIaeM5liP0tugWXEqHSbBCRSytlIyT+55RLSRuA2osBJjgn?=
 =?us-ascii?Q?TqnvYLY1dOjVrDBf3n6YSTw/Qm76JcX1Hn66P6QZTPhd85AL1RQc+4jPvECr?=
 =?us-ascii?Q?jgrykuRsLXno54xdTiWQNHqxh3kHfCUYU53I7BhDkw6KZA3xQf+2bCez2OL7?=
 =?us-ascii?Q?BnIMsfKOax2dcCGIAVqlEPOSf8Hw9zqCzp9+u8UQvymTMtISb21ODhPCfEiK?=
 =?us-ascii?Q?8snbW9ClHrL3Spvq1jxXVF78oeWzEU2Q7KbEdMS57p2ibA4znNE31tHLBIDw?=
 =?us-ascii?Q?P/er9UDpk5EORRd4ztDHa3nuLQAE9C956qnuE0Yq2s5ImFAHWpMQJ2cUQLGE?=
 =?us-ascii?Q?hmqaylgy+cOjsCh9/SxD93tOIH68qhgC8EX8iNw3kr951PwnY0A/M43QSu25?=
 =?us-ascii?Q?xBYO+1FekYCEo6Bb8c6m3d3EcbW6baPWREAYHOlwHYgo4BLgcHHDHMnuAkJT?=
 =?us-ascii?Q?qUqdR7WDC2TabuF25ZJPUQ0v2vwFzoq8cPHtTVtMfgVJ8SPantg2kv5ZUl/l?=
 =?us-ascii?Q?4M9UgsfU2JyIVv2fjwLsuOF9VpiuHzkcrti2jo61VV0KdAJ9OjWXNAAZXIlz?=
 =?us-ascii?Q?y3brTAsS+4ClPS1EcfNzVHlmKRf0LpVzFuxgaXAsgyjA3aiHGWfkdL1/kj6T?=
 =?us-ascii?Q?lNEUcUMnOyU/A+Mj6lvB+3pH+05/o1+bzPnqAL9BjsJ2dP0pwTHDnUFRjzvK?=
 =?us-ascii?Q?QZsIrILAcIARhVTDTnVvJ21EiBOxZ4gTZdGEAmVE1kGADie9DV/aomtKQni/?=
 =?us-ascii?Q?6VW9CKKf1ynXAUtQTy7tv7L6lJhR3FdVUJA5QqboSUWRZNowj0m83Iyk8MvQ?=
 =?us-ascii?Q?OPX+bgpf7ioI7kWAzzZRZD/+lRlcE9TeN1pfXeqdnxv54nZjb7XmYOuDyu7v?=
 =?us-ascii?Q?c/a2FtxMSyCzk+rG1GLKsa1EfEZIpF3NyN5weeDqg8lcLp9nqT1N5yLm0HtA?=
 =?us-ascii?Q?GHkimaaiX6apr3QIDZeaV7r4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7350e9be-7f5e-4fbf-3a5e-08d95766ec11
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 16:43:00.7319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeMxc9XCuwkXsWX/O203lF0bqxWb2yVh26CYxOm1ukhgFP97L8ksX7CjAt1Wc6wpbLqAQUXRLnxrY/yr0FRpLqIysPAmyPnfAWbxo1P7kSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1299
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, August 4, 2021 9:40 AM
>=20
> On Wed, Aug 04, 2021 at 05:10:41PM +0100, Catalin Marinas wrote:
> > On Wed, Aug 04, 2021 at 08:52:39AM -0700, Michael Kelley wrote:
> > > Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
> > > ARM64, causing the Hyper-V specific code to be built. Exclude the
> > > Hyper-V enlightened clocks/timers code from being built for ARM64.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > > Acked-by: Marc Zyngier <maz@kernel.org>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > >
> > > ---
> > >  drivers/hv/Kconfig | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > index 66c794d..e509d5d 100644
> > > --- a/drivers/hv/Kconfig
> > > +++ b/drivers/hv/Kconfig
> > > @@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
> > >
> > >  config HYPERV
> > >  	tristate "Microsoft Hyper-V client drivers"
> > > -	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
> > > +	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > > +		|| (ARM64 && !CPU_BIG_ENDIAN))
> > >  	select PARAVIRT
> > >  	select X86_HV_CALLBACK_VECTOR
> >
> > Does this need to be:
> >
> > 	select X86_HV_CALLBACK_VECTOR if X86
> >
> > I haven't checked whether it gives a warning on arm64 but that symbol
> > doesn't exist.

The symbol is only referenced in code under arch/x86, so there's
no warning when building for arm64.  But yes, it would be good
hygiene to add the "if X86".

Michael

> >
> > Anyway, I can fix it up locally.
>=20
> I can fix it up while I queue these patches.
>=20
> Wei.




