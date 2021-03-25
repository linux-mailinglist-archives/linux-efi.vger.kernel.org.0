Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055A234881E
	for <lists+linux-efi@lfdr.de>; Thu, 25 Mar 2021 05:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhCYEz7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Mar 2021 00:55:59 -0400
Received: from mail-bn7nam10on2128.outbound.protection.outlook.com ([40.107.92.128]:51936
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhCYEzy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Mar 2021 00:55:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4w/Kx2x759wsvxd5J0luLlaEBzITHfYKv5pINRn+uahb0LwsZGKIYEuA112QHE4h0dByYFmw6ifwIY0WcDPcjjUMPY5zRfr91nDkbSIg+16c+lHQGSMvm8TUNBW9cSS01L1oQvSArMiLUM2dxP2GomR6dvS8F2xomeKO/jS5r/K3xBhhz1PzHk3HuWDECvYix0Ezn3CXSbrSsBSg/YMDHotSS5Hmbxvd17pcV3gjfkrD6AjTK7omigcOTa+gZPqe4ImB+e5kTgY2OICGkH5ekIRbte5QudZ11N5HLb2AytsD7GcBIW3NFEoi5cPK1eMFLPN/psfr5nckxMy43ercA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayo4s30G1hoaH4b82IzFJnYCSvDoDKclEm0nTunUXO4=;
 b=eUSlyUwjte0cCItNPJsZgQHqw+n6u70jxmc9gl5+/OytC2zkkCxkGYX1fQZ4v+kJbEXMVeuIqMzDb1h1IElLV/7ajiOB83skpwpz26L4Tr1vdO357doqMOu+xJCm3UdBEDqCaz+GRR9wOdT/mu9uJGYWRb1NN9ZUBzGQ8EIXHx8uLspVNnqEMxx20Fps0vL5AW8G1wLvIcohApRfm3tJLAsjRu90Z6e71UFOe8b9ZXIseL25nm9MyPGVr9G+pCzo8UpAjMwlUV92rCyKvjCOlC1hNf/uLVmjHJBe7zDIQ3hytCg18+Dtx9wMjDgTUGJGb2U2QJjTI0xfrEf79DGtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayo4s30G1hoaH4b82IzFJnYCSvDoDKclEm0nTunUXO4=;
 b=XHOTv2GDivTFbRy4mieixqS5hYgFeyPDDi0B3unEqtRmzvmJkxgR8oqip4n7IBwRaF4CF9YbOsoi3db65xPPJxHXotvMH/3tswoDDpVE5Hry/vtoX1qDYmd3+SzGA9omM/dwWddpNuSNCmnFLR1Whxdy7gS24qA8meoZB/MLzyI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1098.namprd21.prod.outlook.com (2603:10b6:302:a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14; Thu, 25 Mar
 2021 04:55:51 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3999.004; Thu, 25 Mar 2021
 04:55:51 +0000
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
Subject: RE: [PATCH v9 1/7] smccc: Add HVC call variant with result registers
 other than 0 thru 3
Thread-Topic: [PATCH v9 1/7] smccc: Add HVC call variant with result registers
 other than 0 thru 3
Thread-Index: AQHXFFVaurdvub5JekCZY4ghSD5HLqqTdEaAgADFzNA=
Date:   Thu, 25 Mar 2021 04:55:51 +0000
Message-ID: <MWHPR21MB159351AFC4226A6AA8E33530D7629@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
 <1615233439-23346-2-git-send-email-mikelley@microsoft.com>
 <20210324165519.GA24528@C02TD0UTHF1T.local>
In-Reply-To: <20210324165519.GA24528@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-25T04:55:49Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1ddd244f-0919-460d-94b5-b037dae4fd67;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83355430-3bc9-423e-70cb-08d8ef4a4398
x-ms-traffictypediagnostic: MW2PR2101MB1098:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10983E53DB01655CC50ED301D7629@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vO43wfnp02NslzsL2gZ0F/qIc+znbp8XL6EZ7nyruUS8ae7uY51vgXdXDeVwpMULnkcML9CkdFNLoeLc4SainVRHcKNq1BA8+5wokNZnur5XuBGgJTQOpK+D9k+0Y7ZJdsHvbfpp0rN8SuKrBg6KzzXS7DGQQPRovRoq/6JqoreUU6stF9xLEfevOCE8G+XpnDF3KepcPSj4dDGOdBwXTjAnbQ23hr8R2kNu1Kf550uReRUX8bkIn6B8iDo/CFj4Ilha0JT8Q9yCvbPmIfU+ioIPbfDlw4dVuX1miam+UD35vmpfoLUCf3bA4iHKzpPwol9qLCIHMIeVhDKya1e5Svj5fby/71x3ttnbc9Z5wdNbO3Cx0ywOb5QQdbVCPt+bjRDP4nctcTef9friRnQq0S76gW3nQNEzO57GBuobki2JFtD6JqU6bYDlxraJz3nirvF8nAr5mbo+yRswmgvsSVqBkcxT5brCnG+Er3+dHmvmnSfEaSDW/miNGtXB6w8XgnHj0/8uOkmx3yY2/QBz29IhEXjSSCcz8WtrxKEkyvB/CYYu9TypP+elzcdMUuu6oqeAdFa5kEyZL6mtm6x+jUFSk1mLHhKR+uBXsDBDZnrja3XtB1iXcJHtnMTABBXnBTj88BV9hVLH/C/k+umxOKTZLMaBtWEBmF24AbBkUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(55016002)(76116006)(7416002)(9686003)(4326008)(54906003)(107886003)(8990500004)(38100700001)(86362001)(82960400001)(316002)(8936002)(478600001)(8676002)(83380400001)(33656002)(10290500003)(71200400001)(26005)(186003)(52536014)(7696005)(6916009)(5660300002)(66476007)(64756008)(66556008)(66446008)(2906002)(66946007)(6506007)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?796PoL6WVVLEMBrrdSuuLcTX2h0ObRPvo7In3U39V8dXYnKwRt924dvVK3db?=
 =?us-ascii?Q?3wKvM1qtOLFel57Hxo+hOWD5E9760AV7H5Yxz/GB6U11ZLq4iJQC/od6oi2R?=
 =?us-ascii?Q?HCugaQdw+UDw2Ld+aPuMw7zTWJbXfXM9bZNg0gmxoDNy+9tIAD02er8MLJVs?=
 =?us-ascii?Q?k6zflpjVMzzDnoIk9DrPkvEuBnrGd93eAQkdjygtVqOWGhtKiMQ2Vm4sA9E6?=
 =?us-ascii?Q?JYajZ8CYVWlyWIUR1P59pUnsQM4oPHtPCc0tKlII7NXfPhjwhLDARall3bAP?=
 =?us-ascii?Q?zgQ46tJiv9f5XfdWenb81LDowJyADY2OsmAhzf81zcKNNqabkfwhJH7A9EYi?=
 =?us-ascii?Q?wBjkrgIvLtvcy7BADskP7nDinzvfxrGOFb77x2LwF7yBivN2LWb2m7JlgZS3?=
 =?us-ascii?Q?5f7+UMqKixQHv3BubhkTBVpE+0nFt5IKUyP42g/2C4mht8y1prppxLx+wrZN?=
 =?us-ascii?Q?i1kSufDzMRlrTK62xelYmvQnhEPCiCbfCsCF5oB94G6bPCZ8RBAStXLOBbP5?=
 =?us-ascii?Q?hsEE+9Is7gTZrTTu2xyD9wbLP7HXglhQc77hI+c/34yid/T//FQjZDt90NVv?=
 =?us-ascii?Q?vaNqGyD21Q5gST2myCN3Z6Hu6UiIARpwB3TqKHqIPiGQFqovYruSkouTLayA?=
 =?us-ascii?Q?iOl/9U7rlf1hfmtIeKKqXROw3WWg1ebpumSXpF5zrf5lwfvoGr1jL7YIGrDg?=
 =?us-ascii?Q?5M9dZOlQajonFW4rDeJo4EZY8yp4iRgj236AZgiz8XwIWcZB3U8lIFjIEK/T?=
 =?us-ascii?Q?ugq3IGNyDwciiqd3t9hNviErTlwGGTiE//yV4w5Ypdf/zNZL2o2TjgHJhQ7p?=
 =?us-ascii?Q?tRSIKba4WfaXwKtUYoY7v5Dwg125v1/E5WjiDzlAAjlzKGxrcZlqqgjME5cY?=
 =?us-ascii?Q?B6sIg4s0LF6NmJjFeuTbuirzHAXZLh2/0M+vxPGqb+Ay9nIj3QXQr5e39oRx?=
 =?us-ascii?Q?KIybsD+A6/zlphOteSb21CuDcWF+d91dPkEir6FmtDrk4x+obxEh7nre9a+Z?=
 =?us-ascii?Q?EaPpHw7kHDUIbdE+7kZlLGu5+Ci1d14+Wmdfbke+Q3Di4Z64/I4G0Y1xnDRM?=
 =?us-ascii?Q?Vn6K7n2UL8L2B5yN/Xt4xMRDi7PovtMXm6CwclNDljgCWrDV8CbU8gnS3HuU?=
 =?us-ascii?Q?MdVrcz63QmOWD5IN+6w/x4sPGFFSIH7rs2GUDwM1Zfno7yoPRpvK14/wv6lg?=
 =?us-ascii?Q?8sRSRDijaGRzEpwpSfF/1aQHpkMA0B5QBQeL9vBeijyaPC1xYhOV0lN0nxCv?=
 =?us-ascii?Q?zlreIcSCQ1xODMLH+LWCtSr3hs3pnGmF19HoeSPPDMBzjs93qLP+JDRVwGPW?=
 =?us-ascii?Q?ifCZQjfZiVizCKMkJv6LBQAa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83355430-3bc9-423e-70cb-08d8ef4a4398
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 04:55:51.2368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOnp0N9xMGaFkPTHVwpI/987F0HVmsrsJgdClUVwMRA1ooqyrLQUk4BM0R0Ku5ex7fuNayFSU/Ucyo1avcnBnJXCqA/67gZqrju1UMXs9/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Wednesday, March 24, 2021 9=
:55 AM
>=20
> Hi Michael,
>=20
> On Mon, Mar 08, 2021 at 11:57:13AM -0800, Michael Kelley wrote:
> > Hypercalls to Hyper-V on ARM64 may return results in registers other
> > than X0 thru X3, as permitted by the SMCCC spec version 1.2 and later.
> > Accommodate this by adding a variant of arm_smccc_1_1_hvc that allows
> > the caller to specify which 3 registers are returned in addition to X0.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> > There are several ways to support returning results from registers
> > other than X0 thru X3, and Hyper-V usage should be compatible with
> > whatever the maintainers prefer.  What's implemented in this patch
> > may be the most flexible, but it has the downside of not being a
> > true function interface in that args 0 thru 2 must be fixed strings,
> > and not general "C" expressions.
>=20
> For the benefit of others here, SMCCCv1.2 allows:
>=20
> * SMC64/HVC64 to use all of x1-x17 for both parameters and return values
> * SMC32/HVC32 to use all of r1-r7 for both parameters and return values
>=20
> The rationale for this was to make it possible to pass a large number of
> arguments in one call without the hypervisor/firmware needing to access
> the memory of the caller.
>=20
> My preference would be to add arm_smccc_1_2_{hvc,smc}() assembly
> functions which read all the permitted argument registers from a struct,
> and write all the permitted result registers to a struct, leaving it to
> callers to set those up and decompose them.
>=20
> That way we only have to write one implementation that all callers can
> use, which'll be far easier to maintain. I suspect that in general the
> cost of temporarily bouncing the values through memory will be dominated
> by whatever the hypervisor/firmware is going to do, and if it's not we
> can optimize that away in future.
>=20

Thanks for the feedback, and I'm working on implementing this approach.
But I've hit a snag in that gcc limits the "asm" statement to 30 arguments,
which gives us 15 registers as parameters and 15 registers as return
values, instead of the 18 each allowed by SMCCC v1.2.  I will continue
with the 15 register limit for now, unless someone knows a way to exceed
that.  The alternative would be to go to pure assembly language.

I'll post a standalone RFC patch when I have something that works.  My
C pre-processor wizardry is limited, so others will probably know some
tricks that can improve on my first cut.

Michael
