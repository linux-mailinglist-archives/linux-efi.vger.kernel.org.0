Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E224132C98F
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 02:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhCDBJ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Mar 2021 20:09:29 -0500
Received: from mail-co1nam11on2114.outbound.protection.outlook.com ([40.107.220.114]:41312
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388972AbhCCVb3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Mar 2021 16:31:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEu3TNf9xC7esRi6fnmki1eiXAmpRiiWdvf1N5JBeAeARoJxc4Ll/rHZKD3FrKet6ujh2lZv2X8SxYV//bo8ryr9GdDVaI9M+SqUd4U3lCugFkmzi78UIcLYTwo8nRXnYy15D2dNTgznwjjeLUvwqGOoBDFFCEyzgoIUMeqy+TafBDaFaZAOZXlTX18nR2QK7CpT+oeKl/gaiEZchmXMcRw3lIawwEDZdZ79gRoq3+76BScH8FMEtvWkba5wy8dNl/fc+4AO9YGFUv0RTADigOk1csq0lBojg4d1DCkk3hehblL9a71nB3amTbAUNwROsxdvbwvW3uatsP+BribF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYfS8Ej9aBhwNV8XNRPfQBIb964tqeNhzWCMMk3M8aI=;
 b=BuM2JO/cM7QTzgrvLLnFqt1e5SOavOQftbzir7udjo9yqFV+4GPMpLinYdXJ+G/vpI/T2n7Zgky65PmqkSFKN/AJzSk0Ty1CYZ229cm4GZE56JuKKPtD2tzC1vQYE7qRd8L/8O6qh8RqZvQvFCG4+EIUFxq6ScgTAmRnoiUfI+0frMamCfKz3zRRP5J4MwYHV18aVMuzm56my3WZiA0PqMTO+VC5N3gbQ7eJ4JA8phzZKCgSpfHQuuWD0V+0Y1gAKH1qhPFMVqcG0LimNQTLHqNmLXy0F0NVgoM794kq0ejMTmC7OtefadX2LoyvycfvVAOm2tDgZDsqprXKL29sfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYfS8Ej9aBhwNV8XNRPfQBIb964tqeNhzWCMMk3M8aI=;
 b=U1aiHRJ49K0kiRiBEbk4fwRxXrl6ROmMJzK70SVrG91hLqFI2dEa5nZKuxKgnyeIAB7//jTE4ESph4lkOxmuUaHQP3ubu+ARgD0nzoes7IvO/FwnLYseTz56K1uZQ7UHLQdgrO68ImH9CgBYpNl9VNjtw6Y9DgFvH0RtFGTG6FA=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB0925.namprd21.prod.outlook.com
 (2603:10b6:805:a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.9; Wed, 3 Mar
 2021 21:29:43 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61%8]) with mapi id 15.20.3912.011; Wed, 3 Mar 2021
 21:29:43 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>
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
Subject: RE: [PATCH v8 3/6] arm64: hyperv: Add kexec and panic handlers
Thread-Topic: [PATCH v8 3/6] arm64: hyperv: Add kexec and panic handlers
Thread-Index: AQHXDwVuGuMCLtr0l0qRwiIIh5sEOapyuVmQ
Date:   Wed, 3 Mar 2021 21:29:43 +0000
Message-ID: <SN4PR2101MB08803661D7BA9E30C9D26971C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-4-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1614649360-5087-4-git-send-email-mikelley@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 23b7cc63-418e-44ff-3b0a-08d8de8b75ea
x-ms-traffictypediagnostic: SN6PR2101MB0925:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB092540648CA220A4F6C50FCBC0989@SN6PR2101MB0925.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9Y3LDR0eh05ys1S7jokdM5tIrRsomUffW92lPZGQgwjmBaRPLuqAQ12/P6fRW/L4XgATf2r4Ewr8qXeIlYlTs/rLtqLoywDpU6vsil6rWKceH4Av7zucfhKizNCk06m3K4TAh1NlDqwgEDLMsZjXs+YdW7uqKrx2cv4GpmDVbClNh5w3Aw97bcLJp7LB2UYps4R6CIzKI97f10R/h5oP0VHraZUjbDZrSdOLYFu//gGNyBYJBC4asjGV2hY6EblJGUKr7lxJQp4RrxozKmZxh7UDqRGkY9lSkGjEGniR080YQcyE1hLcrHxFqmquXW+PFCZvBNjymRubFt9pZHBaNpyu3p4kV+kJa3fi/NI/JaQ1hMkU5gHRKrAR+/l41xOOuY0ffEdMqSFhV/uwzldVRzT8sxkyU88PehHwL0pk+Gp7QbEjpjBlYHdsg/GMZQ4Igt/amdZhQNH2XSE3SwcfgV56cB7fpqf8UjsxIFPAM+Ko1J5CBNXJsbnQAPsnBBvNX2t5qo3Gd1wy/dwHH6wc5FK08MXnnLmo8dr9Z4mnz1CuWnSX0XmVkwSK6TRhhFQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(54906003)(8936002)(8990500004)(6636002)(186003)(316002)(66446008)(64756008)(5660300002)(33656002)(66476007)(107886003)(9686003)(8676002)(6862004)(66556008)(10290500003)(86362001)(7416002)(2906002)(66946007)(6506007)(71200400001)(55016002)(478600001)(558084003)(76116006)(7696005)(82960400001)(52536014)(82950400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yXs58DKYHdU3BEHRSyrKdIcAmDK3+MW5lGY/x5oU2mNd9oK7E/tr70kdh1nO?=
 =?us-ascii?Q?IeotSv6SUOv3c2DU/sw9VUVuAu+/4rxoBWThqkqthhwSntXl9JvT/JwnVEmX?=
 =?us-ascii?Q?vLIaAuLHQC2zq/2NaAbfnv3gZc/qD7+Up6S2dDjO0D3Qwx8tXlcqQMntobwo?=
 =?us-ascii?Q?MHy7TkPKNvGRMdCE9z7EzOgAXjPHTUvX37ZUgEifQhK3H1sCTS7+rTcqYt+f?=
 =?us-ascii?Q?kzyDwMyJU1cOhZzpcmN1zIGiHW5aaWUroptOJaeA3RFsBCrl4NY48QUazzUy?=
 =?us-ascii?Q?udkYL/UGv0ksxIK9xd2yLeDIJ1PopHClotoBOqjmit1pMIc05CWyy+1+RfUQ?=
 =?us-ascii?Q?FH74cyZMfT7CkmfX1JYzb6y6sLIMmC1YatgEopQNcUnl5DrOTDIZyNedUlYT?=
 =?us-ascii?Q?pGG7kj8ktUu/WIQfucQK1cNmowv1sGtVZ2azJVxGAo0tfCRS0dzU800KgnQT?=
 =?us-ascii?Q?ZPRBKhIstAYAyTXA/OintPLhigsIT6/oTaS4upJdzo2VbWHDEYyniiPQ0m7k?=
 =?us-ascii?Q?w5yudSbH5Q+2LMHXkWjxR4UE66bBtXWWABsFiT2dwPX7AldKlvRUg9AEzxea?=
 =?us-ascii?Q?NzAKDZxBuqzQs+9zHlT4pyvcTt8qBSqGiAzyyidYJ4NclR2gXBK4df87ceJY?=
 =?us-ascii?Q?jh+bMPMVqteyJdjPnEc+fjl8pkmO0bqNTgi4fhVsJwQrrhGQ86gbc9U9qTzW?=
 =?us-ascii?Q?3gnO8wFdcPRYRZ9owb8JNA3P+zPMcjAj4nEMpOXDQ+z8pcoO8bPw9GubNyA/?=
 =?us-ascii?Q?LXL65sjm5KiymEZtzjd+qIWYC0YXlvvRQIavyKLWFANQKKLfz0FLMhQH09DA?=
 =?us-ascii?Q?hrzEMYvztLY6vgvJ/xal4L1j2ce82mVX8pzNJYNo5Bq7RMpDxMiu2wRr28wq?=
 =?us-ascii?Q?dgcTbyZe2RGnMDAQ72DbH8Q4/MGWh0A+DxuEHk7MakxJ0Zp9JNgd+D3s3lZH?=
 =?us-ascii?Q?c7XLMhD4DO2v3DwGGMncUTShhbOtGysLaNsP75dSiiGLXO/Mwwfmp3jwij8g?=
 =?us-ascii?Q?Im6JTvw4LXW5wtLcAGOzR9zFmakd/oa4gpPXN6m9+ca1PgeIOwSzJg8eqjWX?=
 =?us-ascii?Q?kYdDp08Lfxv2IM/QsOAan7L8cVfoVPOvUzLK9FdD3Gdrm/pAXg/yX2soCAmU?=
 =?us-ascii?Q?iP3ChO0h94snobPTa4NUop93EoyhozBL+yPz5l760OCfyKp4cIfYifJHLmMy?=
 =?us-ascii?Q?Uhu79vdTJKaUJHw+5FDl+aK7Gh1piV4HdwtmoQhy5WVp7DBbbsZgt6Sas7h6?=
 =?us-ascii?Q?rlx0+1T/g5NbzyAbtH0RcexpnvSgWZMjPgfFSKrMzHVhgeAS4jq2kISeFIe/?=
 =?us-ascii?Q?dQbhDxcaasvwWLEQx5UeKTRIlw4nd0r7LnR49jqxi+3ZUDjhNYVPvl+6SrIT?=
 =?us-ascii?Q?S0p5zGVrODCU1svXc3oL6YgPq+sv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b7cc63-418e-44ff-3b0a-08d8de8b75ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:29:43.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0shhBMY/3hA9DKz0Yy5lnvOk5geSqzfhyUi2oLdpIC4XbZDaJcvp2vulnssM22kTiGDDBQBu6dEyP6r96LJBqyE4wMQ+wWn7x8l1ftwwrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0925
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> +EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
> +
> +void hv_remove_crash_handler(void)
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
> --
> 1.8.3.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
