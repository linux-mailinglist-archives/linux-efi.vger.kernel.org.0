Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC132F4D9
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 22:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCEU6p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 15:58:45 -0500
Received: from mail-bn7nam10on2133.outbound.protection.outlook.com ([40.107.92.133]:3905
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229794AbhCEU6k (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 15:58:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCFRqy/D4rUjuI3n9qp0G6oMtMvo48NRCdf9gS+X/EgNc6GQigR1EFunxjfCcCJ/j0wXehOoLQ7DLEtA1K274EcxQD2z2b2EH7XUve1kCnB/UCAXvRgDYb0JjA//9odjkOf3nOLkMk/UdGbQgMldx+AG8MvkgH4gHNzMuaJSTqXgFKTqwqcul2ektuvSns17f/UWRHEACcIxx9D33x/YvPPuRyZ/VnJUJxDqHS3ZP6L6yUzpruZjjPG9JyTr6F49HZFGDFA4TTFcLf3OgPun5j/LEakZdB9lR3Vetyx94dkdjaOktnv6bPorwKBjXVJkDXuI6s7hStNAcx5FKuiFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRh9lEvZpacGLBgF7XB1XifH9YKJTPJBwtTz4TES0Y0=;
 b=UjyJPjMorwxO+GQfOgh/soPMA8DX+VVwRExSgus1Ip7KVeMXlsVeTcJfo0q++508OdI/Wk2LLMnyXQ/hkDIuBJhTiTn9jpfvxmSFQDSjpl8lWceZuwOPrJXG/pg3PIMUxkLHTzAcnIyTb/sInmVMjIySFe1FYajsiVj9ma4bUUpgjIrElvwKgejeXUAOUz7n2Wy/q35Dpncli441PrywNfMZNrGLCrj7/W95YqLm6ck86Vdh6fXDTD0PV6U22EXdJcBJniQnrKUZRqzpK19eWcy9+6d2xdd9EQhwRyC/j/nDlW5zTx2SFZtHdQFIXirdfISihZGy7KU2SRFRsePwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRh9lEvZpacGLBgF7XB1XifH9YKJTPJBwtTz4TES0Y0=;
 b=O9pWAMEySqo/kR5oPCcEp+QvuMh5f35XppvOp0U3chIpLT5Y7LQeW305DGFbmwKHRuQs9jNyZUghQZjbpL4FB/mJ6A2fZjaL6BG8ZG5X1UAQSSomRavTABcCu8y5le17BUGxwZItUZf9+tEVf3ST8x3gINY4K5MdMyvcfXWUJWc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1953.namprd21.prod.outlook.com (2603:10b6:303:74::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.17; Fri, 5 Mar
 2021 20:58:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 20:58:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
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
Thread-Index: AQHXDwVm7IanFUbz6UeLdWLFekPIfapxZzMggAEuN+CAA1B6YA==
Date:   Fri, 5 Mar 2021 20:58:37 +0000
Message-ID: <MWHPR21MB1593400D400EA8091070301AD7969@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-2-git-send-email-mikelley@microsoft.com>
 <SN4PR2101MB0880C47188DAC6446BF5E156C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <SN4PR2101MB0880BC201B64BF4274539951C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0880BC201B64BF4274539951C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-05T20:58:35Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1b3f19ee-cc8c-4582-9abf-4b5ccb34c3a7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efc1d4bc-09be-4214-252d-08d8e01972bd
x-ms-traffictypediagnostic: MW4PR21MB1953:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB19531D7192487692E602DD5BD7969@MW4PR21MB1953.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DeqBIKgptZFtOo8sWF+vTzGmKTfi2x8Woy9AUt3yhBv5LLn1tpndo2LyDuHIZAU15eTI2Wn5l8LdTWJOSweYWfe3IciI0Y/auiHmcl+xXRfVVKSsLGooBTgfOhpFhQbd+KUnh70orgEFFhtl4T70695z09e2n6ZeuZaZfh3tJmc+Rkc2Pvd0NZVH1ZJ88uhI18E+cntmXgh+/RwopNAcP/ZJ+yyhlyLdrKN0Rjh558ssN1iKp/D4n9/EMlJdyw9Ckv6qUNwWDEQPiubj8C+kOrJd7F2yBW8WyKG2dsn5dOhp2jcm/ZCo/BAKVL4s0DcKLP9tC+vd8RIv80CmhOPIUd/hZP0L7Z4UeoUBKbJd3uazMRvozmHbt4aoSf9fJvFzkOelFEBc5DkaVE4tciz4oGRk3fZFZ81XsdszRKcvov2mIGK/mQVDE0WYXqKjdWGYiK3ZG96+tnMkrK9zupq6V0jJw39Hk4YFoyu3DsMH9TmYlHgrYSLU4+TOl3f1ceeLdIULG7Toi/md6KZ9VPcBt+fWBpzlQlK8zfFh6xg42rJEFXmcHP15kDMjrwd5YVMf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(86362001)(186003)(478600001)(26005)(82960400001)(82950400001)(316002)(71200400001)(54906003)(5660300002)(55016002)(64756008)(76116006)(52536014)(66476007)(4326008)(6862004)(8676002)(66946007)(10290500003)(6506007)(8936002)(66446008)(8990500004)(7416002)(66556008)(7696005)(2906002)(33656002)(6636002)(107886003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9OIKQmY7ypE3a8qnUFwErSGw/ozepOK5MTkBnjWmnmV3j0CkAA05WnSzzcKz?=
 =?us-ascii?Q?iyIWdej3TPn4OBLwkENgVJBheKGdIC8xtn2HUPqpX+85+o6fk/3G2jhMQHwK?=
 =?us-ascii?Q?vIeEuCAwys5A15habjIyOhA84bESkSuVMqFanOQa6nA6u82bziuM9ulcXpMP?=
 =?us-ascii?Q?szhnCXKIM4VDMjwjr+NJ6NMYC1VOWqpi4opfG8a3c9Hcql99H3i+gA6B9GT8?=
 =?us-ascii?Q?RKFiJsxmsAn1OaYE3o7ByWA6Cjj6i1uWsLPk/0eyRZKM9652OzLbSp8VYODh?=
 =?us-ascii?Q?pirNpvZSbaaLpoBnOT+W5OkJ0KOuUyve4hH1rEIvS1AiZypOoDOwAQRnQRkQ?=
 =?us-ascii?Q?rEbfzsYtsSfvCCXMQtHPsxgpLGh3pys8x7eekF9NP1fkM2AxErFWItOvg/4S?=
 =?us-ascii?Q?NAV7vt0A1Bk0GeJso63SnaejpQTtEFK1fVvFiQDk81Nke7ls/s/cTPMVglrd?=
 =?us-ascii?Q?f3GBqGQmfOjCxdq365uy3UY6UGydOiBHKPsOYXyi8FeKILOWfBXri1fs0xxJ?=
 =?us-ascii?Q?LyuFVCffOA2rOF/ZJ4D+gYgx6bT2/ILcaW0rjg679xVAbMX5+a85C/6U/QkZ?=
 =?us-ascii?Q?O/5M3lXArIao4ZvbTL2xaPajkatAH5eaeDlCzprLidJo/TcdamFX7PLLReP9?=
 =?us-ascii?Q?qeidK311w9YRAV4PgMlHtr3UTeOujKI/0xPYUIXkT66OPrbpn5fUW1Gh5CH+?=
 =?us-ascii?Q?VU/6KuP5ise29xXp+EBsE4udgdcZmm47s52/HFpKJeYmLeogf2/Eus6i0IuM?=
 =?us-ascii?Q?l83JqBzM4q1TgtPgWnEH1lcPZFEGkwylplBSlH6NpjXNvLDCJbCzftDw1Ct8?=
 =?us-ascii?Q?c54Te9xv6qTNIuj6uQDe4DId4JvLlMhEyQOq4jbMZAQb2x5P9ZbImae1YaNi?=
 =?us-ascii?Q?q54Sa6PPS1Gigm1mprUl0YjBNbG+SfvAIiH8A8CoM5WSY7kiZDQyrBE0Fd4/?=
 =?us-ascii?Q?5ZfBZlnR75HoA0Yk1oJ6XzfY47SmzSwzSWUrWD1LYg5UPzoJCwdI/zpKakng?=
 =?us-ascii?Q?VI+l5430UF1Qjd+7+4EyMFliKzuu+WTBxJQbANe6f9peCSKmggglNuafrzac?=
 =?us-ascii?Q?Yex0xhQ2v4swqqgFxTWe0cLGoM6HvGtbHgje81xT0uyXRGVjTnvyxq5DlEqd?=
 =?us-ascii?Q?TTY657YrTRbcfBqYOt/3bxwarFJBM53/bd8f1lWw+W47EWtz5e0FthAvfcQN?=
 =?us-ascii?Q?yssGcg7L8TuyFshAPekX3EOlIFeA3MzcYR/AJoCP25vKHPjvp4JycYu/PRJ8?=
 =?us-ascii?Q?NEOKKgVzWCljnbwg0XsADOjRxQSkHLF8FcsGEMcWT7G+XwRiL/vyTigZtJ07?=
 =?us-ascii?Q?xr6UUJsrRvDzKYj/Zjf2AMnI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc1d4bc-09be-4214-252d-08d8e01972bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 20:58:37.5518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yylqnayrw46W8jy92Rs2ulk44zmaFbMftjzFmzScZdA16u2lmfY/YENFgeaQGCJ0ZNQlcceHiQ+1ZkJz2HMv9ZCcPYz1hMtOPUcKW//REH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1953
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Wednesday, March 3, 2=
021 10:28 AM
>=20
> > > +
> > > +	/*
> > > +	 * Allocate a power of 2 size so alignment to that size is
> > > +	 * guaranteed, since the hypercall input and output areas
> > > +	 * must not cross a page boundary.
> > > +	 */
> > > +	input =3D kzalloc(roundup_pow_of_two(sizeof(input->header) +
> > > +				sizeof(input->element[0])), GFP_ATOMIC);
> > > +	output =3D kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC)=
;
> > > +
> > Check for null from these malloc routines? Here and in other places.
>=20
> Between, is there a plan to setup a percpu input/output page for hypercal=
l
> input/output on ARM (like we do for x64)? I didn't check the specific siz=
e requirement
> for this particular call, but, that generally will remove the need for th=
ese
> allocations.

I'm not planning to add percpu input/output pages in this patch set.  As no=
ted
in another reply, we can eliminate these memory allocations entirely by usi=
ng
"fast" hypercalls.  At that point, there would be no usage of percpu input/=
output
pages in this patch set.  If the need arises in the context of future work,=
 we can
add them at that time.

Michael
