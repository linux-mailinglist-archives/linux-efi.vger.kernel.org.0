Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC8383A38
	for <lists+linux-efi@lfdr.de>; Mon, 17 May 2021 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhEQQnE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 May 2021 12:43:04 -0400
Received: from mail-dm6nam11on2113.outbound.protection.outlook.com ([40.107.223.113]:8680
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241895AbhEQQmi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 May 2021 12:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L18RIs7aiCh5eP1d2meu4V8oMAnEAZ6/gsA3ilPyqQg6yHVpD2UhHuZFIZuEPyLE5GnYI8OemNXRw7teQoPltTWvMrJvltrJx2Gh7hYbZGTJ6bVukWVhjII750dPklN3DltAT69cqqgqrGSkPmo2f7hpWDEV1F6jcsMlCkueTrmIJlUrI5R3mKoDkqXu5rEvppoDo0oPv6YiLxhHegQ9k5oMuvTHSdJVEuHVIvhKj9n8Xanc3fVLvbBGzVget3HcXpegivhivBtHI3se3a/GSViDiGxRdakxBFDY8DCmSLKllj5eTUGbfE8ISlvDni4G34x+pLCzC2JoFVONcPOCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtAdXnxHd+EBB1K9L54/taSy2iHRGATMSQW9v7G/A7E=;
 b=K/vsFtqwjUTCe4c/qIQmOHuK6uAlJIWaUuHHcVdf6oUbcWy9/eL5paLv4I1w/SCu9ttEk3F2XaUs1JzfLjsIslUv58InZP2M1m/GSWnGjmlRR67UblP+sBlIbkkC3bRfnDumb/j52+RUoj9YIUNrzLARzgkzhthesiS5LImaiNARUcbxO9A7Es2XP4gE1Y/7kph7BAEt3bIKK3TBwWQobHJXcbEM1iibYzK8YXF8jiQGq26IEOmj8wgeyd4qjUtrdK1AOR6AG3JR1Q1Iq+WRNEc03cYPrxUe9TGonFPkFaQS7mqq3//WSBn4TUD6MRL6Tu0vELGQW2BEDMoOHedWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtAdXnxHd+EBB1K9L54/taSy2iHRGATMSQW9v7G/A7E=;
 b=R+bkViN+7g4fiht8LHeSQl5Ho5nLwh3afhESzoP/74GyjlMMboEfR4LkbfizYstzTy6sLyZ02xXbjYI12v4KbEYc41sQ3Mt+WFYRhZszCWF22eR9zhEqqR7S1kc5ebpSshzrxtoZZFXa5IjDNFCXNN9GHDOVNqwR1i5+f1dd7AE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1786.namprd21.prod.outlook.com (2603:10b6:302:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.3; Mon, 17 May
 2021 16:41:18 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4129.023; Mon, 17 May 2021
 16:41:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Mark Rutland <Mark.Rutland@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
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
Subject: RE: [PATCH v10 2/7] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Thread-Topic: [PATCH v10 2/7] arm64: hyperv: Add Hyper-V hypercall and
 register access utilities
Thread-Index: AQHXR1WfbpYqXyQd1EyiAk5Edk8t8qri8WSAgAAjnhCABIBngIAAUccg
Date:   Mon, 17 May 2021 16:41:16 +0000
Message-ID: <MWHPR21MB1593ED3F7893F59E8BDF66ADD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-3-git-send-email-mikelley@microsoft.com>
 <20210514125243.GC30645@C02TD0UTHF1T.local>
 <MWHPR21MB1593A7625285A3E3F376B352D7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210517114449.GB62656@C02TD0UTHF1T.local>
In-Reply-To: <20210517114449.GB62656@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3583aa69-f574-4060-a1ce-d27a09aaf8c9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-17T16:37:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 374255f8-b8bc-4c3b-8f87-08d919529763
x-ms-traffictypediagnostic: MW2PR2101MB1786:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB17860925C47426E1A741C347D72D9@MW2PR2101MB1786.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cG+dpku0sG/dRKe80F5aZg5cXOSoAHHSPXqx/+bXt3p+NhkrfesCM9iq4x/jvJkUS6byczPSNt5k5/fZE6P9RQBCCNHTTjNI+ZRTNuoXAmCkggAmP3necED/BI5mtZklGFP7pl3ncaX2msvcIXP3h8+IKofnQoC/t4qojpTPWxSujZvbYKQ5EL/Mr9XUN0oR5DDii0wlZUnCHogVVTJnu6z993fj5r5070HaId1uXLy++zf3+dApbZe1De86QP/wW0wHSVK+PLNhKFMLa7YNPT5gI2NSHgT2w41hvcSHXcMkus/+dUpA6QYxZif3ApZY/6aLM9UonMxcwen1ZReWlkZ+YLk1xM+cEn6APStyXxcOxGuDfsBj1shfPND8XutFeEhRH6DH1D0yYa6RGBPr/ECHX7Go+7dwt4x4lDCGhLtienYGiwXOyRN6cknUrDpeB5+UXxOs9Xt2RsOb1GhTI1uvXl2tjBPwlRKRGkodHDSAggZBROnChxLr+OgtAtDFqX2AE8j4eqpQTIqxOpN1f1gXGwL7W9ffFt+wkUMdYHdWLi/IEDjc3Xnt0zJywMUesA1pcxjnb6jkMDFy8nb85QejBhp6Tf7/T9ec6JNmSHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(4326008)(6916009)(9686003)(122000001)(107886003)(33656002)(7696005)(5660300002)(82950400001)(478600001)(82960400001)(186003)(76116006)(55016002)(52536014)(26005)(66556008)(8676002)(66446008)(6506007)(86362001)(71200400001)(8990500004)(316002)(66946007)(8936002)(66476007)(10290500003)(38100700002)(2906002)(64756008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2aGCsXL7K7n9DQnKaericFNwZYF/fX0OY4T4E9rma7VBvVDAD/lU50qOTf3c?=
 =?us-ascii?Q?Eh3kLpn9VK32RVgYNJtAJXKCAwKojjWBiWQbTS5KRgYSnm1d0MdQeuGotGzN?=
 =?us-ascii?Q?+G5A+dDea+I0VNm7UDewG8q8G21CWj60p7YvmFZ9z19RHSSeJIQ4sV1k9tUD?=
 =?us-ascii?Q?txce+mZ46wbF7lHZ2Si1LRW+fK7X09d2fWW//w46zYva0xuNc8IkdqnVQdbe?=
 =?us-ascii?Q?8pZk3fdyqqfRrTWc1hz2o5GgK6ijAr4JKIVzpQRocFnqPRB/FP0/8QiCwSJS?=
 =?us-ascii?Q?MYRI0za+H/ymeKoRgi+6DqZftizkhFj0VHrJH74oysVl7SoowgwvoAQps6yW?=
 =?us-ascii?Q?KusALxmAeusYLdILm+5XCpnmH47kljQLqe97GfU959+Ps2uCX90FkgH0O5NS?=
 =?us-ascii?Q?bzDqIXSR+2BSCQIL7+0BmgZMfdCvDHOb0EWIQvDA//gs89NfL3O9JeZHo0C1?=
 =?us-ascii?Q?WI3E90EFX4aUZWCMxkre49gJ8Ri2C1bgWB/f0Xc2j5cPG0knL6ZJ9FFk03ej?=
 =?us-ascii?Q?luhjqh2mREl/N5pUirnEpL9HoIF/Asa/3BHr+8KgqtQ2zpiLrT0C26j8cRmx?=
 =?us-ascii?Q?UfUYVs6X3wbDgj2Oc+MFzPFxqdSiyxFXVyLVEk5PrPiecu+bocMFdtgeuk1n?=
 =?us-ascii?Q?TikXQDH4B+QYuflOspUqoKVecjlqdx0MsjAXkyBJQn8XnN03/lL7IzUXFcqZ?=
 =?us-ascii?Q?N3m2MZrdPY++GLB0QuTv3K4fppnWhM/8OgZa+GlUfY1fM/gT/rZr7gj4wrdY?=
 =?us-ascii?Q?HjBeKQ8OkkeJjKEc+hq+cZYU9rVTRz4u6djRMWNE6nee3UDxtlWTm4VY8kvx?=
 =?us-ascii?Q?jzuRqYTh0K8TKr0+LkiiWexFPIJJbzUAG+LBJDZdh6bIrhIK8pZgMvTSCiiU?=
 =?us-ascii?Q?zpSkPQzCM4292uYgXLnNzqxviwVssviuQk0I4waOdDSspSQzeJXDC+CJp3K8?=
 =?us-ascii?Q?0nGHSm0OQZzhBNHBK9sLv07k7B+Do9hdBvQTc88X?=
x-ms-exchange-antispam-messagedata-1: aCQzS5ueOx+J/es3+bwHflX+to2cPyxb7a+EnSSfdH5us3o0fKFoiv7V2BeWi1bKbUwcj7txYqIgTc+larE74N1pQGRScfI/ITB5kyzBTApsGSLOs9Jqlp2tuT1XR/rY4SQw+NwGpwA0zRwS5KWvQDVNQiz5U0jZ/iYB1mFD3eKzSLSOC7jkBwdfauCxtexeyCjd4ZBp4rA0j7/oZv7opZomdCorPdgLWmRkrWqLBhsYLOXcENEb47w6uFRZjhBES2ulUrdga7RYb4PVyNm9y3LfZymtw7+NeFifnaV3nIO3KxOhtvgC4xxDZQgU/MmF5ESTmCK2fwDVNiZbzlbmlTBl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374255f8-b8bc-4c3b-8f87-08d919529763
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 16:41:16.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IS4NV/JtXy0uBHa8/C65QgLnqc8i6F7aeSvw+oXgVFB5scMPHzNC1q3OIbkaAwHzXXv4NugMVRK0oI5kIqbuHDtFi4qFy/N+qNI/ma9A/OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1786
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Monday, May 17, 2021 4:45 A=
M
>=20
> On Fri, May 14, 2021 at 03:14:41PM +0000, Michael Kelley wrote:
> > From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 2021 5:=
53 AM
> > >
> > > On Wed, May 12, 2021 at 10:37:42AM -0700, Michael Kelley wrote:
> > > > hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
> > > > Functional Spec (TLFS), and #includes the architecture-independent
> > > > part of hyperv-tlfs.h in include/asm-generic.  The published TLFS
> > > > is distinctly oriented to x86/x64, so the ARM64-specific
> > > > hyperv-tlfs.h includes information for ARM64 that is not yet formal=
ly
> > > > published. The TLFS is available here:
> > > >
> > > >   docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/refere=
nce/tlfs
> > > >
> > > > mshyperv.h defines Linux-specific structures and routines for
> > > > interacting with Hyper-V on ARM64, and #includes the architecture-
> > > > independent part of mshyperv.h in include/asm-generic.
> > > >
> > > > Use these definitions to provide utility functions to make
> > > > Hyper-V hypercalls and to get and set Hyper-V provided
> > > > registers associated with a virtual processor.
> > > >
> > > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > > Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > > ---
> > > >  MAINTAINERS                          |   3 +
> > > >  arch/arm64/Kbuild                    |   1 +
> > > >  arch/arm64/hyperv/Makefile           |   2 +
> > > >  arch/arm64/hyperv/hv_core.c          | 130
> +++++++++++++++++++++++++++++++++++
> > > >  arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++++++++
> > > >  arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++++++
> > > >  6 files changed, 259 insertions(+)
> > > >  create mode 100644 arch/arm64/hyperv/Makefile
> > > >  create mode 100644 arch/arm64/hyperv/hv_core.c
> > > >  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
> > > >  create mode 100644 arch/arm64/include/asm/mshyperv.h
> > >
> > > > +/*
> > > > + * hv_do_hypercall- Invoke the specified hypercall
> > > > + */
> > > > +u64 hv_do_hypercall(u64 control, void *input, void *output)
> > > > +{
> > > > +	struct arm_smccc_res	res;
> > > > +	u64			input_address;
> > > > +	u64			output_address;
> > > > +
> > > > +	input_address =3D input ? virt_to_phys(input) : 0;
> > > > +	output_address =3D output ? virt_to_phys(output) : 0;
> > >
> > > I may have asked this before, but are `input` and `output` always lin=
ear
> > > map pointers, or can they ever be vmalloc pointers?
> > >
> > > Otherwise, this looks fine to me.
> >
> > The caller must ensure that hypercall arguments are aligned to
> > 4 Kbytes, and no larger than 4 Kbytes, since that's the page size
> > used by Hyper-V regardless of the guest page size.  A per-CPU
> > 4 Kbyte memory area (hyperv_pcpu_input_arg) meeting these
> > requirements is pre-allocated that callers can use for this purpose.
>=20
> What I was trying to find out was how that was allocated, as vmalloc()'d
> pointers aren't legitimate to pass to virt_to_phys().
>=20
> From scanning ahead to patch 5, I see that memory comes from kmalloc(),
> and so it is legitimate to use virt_to_phys().
>=20
>=20
> I see; and from patch 5 I see that memory come from kmalloc(), and will
> therefore be part of the linear map, and so virt_to_phys() is
> legitimate.
>=20
> What I was asking here was how that memory was allocated. So long as
> those are the only buffers used, this looks fine to me.
>=20

There is no vmalloc() or stack local memory used as arguments to a
hypercall.   Call sites know about this requirement along with the
requirement of being aligned to 4 Kbytes and no larger than 4 Kbytes.

Michael

