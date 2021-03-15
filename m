Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816FF33C995
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 00:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhCOXC6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Mar 2021 19:02:58 -0400
Received: from mail-mw2nam12on2121.outbound.protection.outlook.com ([40.107.244.121]:41998
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232271AbhCOXCq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Mar 2021 19:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGOQe+bPDJof/bFBCJiAYw97coiRIWp7Mujf0sEbxqGbA2WBBsx2z9vv69u0HMj7aIacsbB3mfHQ+u0IHSdED7M0EfLyEXlzMGTCOnF3Vkb5tmEyHoVkfWD651WTmWnFovTxdL/epJbrUloT0W8j9zIYOruvbTZCMmOH7cY+jr3Iny4NwC4bUwX3auTqG9UsgsNA4DmK/AJDJ09YOrvICGMNAOt0tW9O7EkdcyT4UKp/EDomRqj1ys2P3x8A5vNN0qgQmCMbRGwql+d+gny+j+id0+mbbmTCqX1gs9hm8gtfznVsqG2OgHZ+APwiSwE9aKDyJFKVQyitezkvE5DLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuG2zZm3HiGRQXJ/GSuFQErG9tEd6FQ7D38nfZG57bs=;
 b=TxSp5cBje3Vlr0/QIQMd5Cd/HltU9eUJba75ghecn/pMgN2NWurAY+d/9qMNcF2AUtOXYLO3/KR7crURgGO1xHyjFqmGQgIfraFy69gtWAP5rxz9OCadmzINH7YbEX8tX5A6mj1WNEcquMOkmEN4RaXPMt3bPAfW/HVAEyK/g8zM5JtzRyBX2d4eUl4I4pttrT4WYgEljAPiST6c98CrTVP2h6D1SBvEuK8KFpmJ3WApjOILvhzEfK+KRn3Ti3DP7AGYeXlbpvoycWwwW8s59WUgBrjUOrk8nlE9qDbdBa4SBVuYCrQLtT4iriTvekr81m1jUPPkm4MEVs6KF/ZYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuG2zZm3HiGRQXJ/GSuFQErG9tEd6FQ7D38nfZG57bs=;
 b=BZny0qmki2yKe+eM8Rd19Z2DVWeYRjrDrRdRehiG/Uq/BMAw4z0wsKoitk6hWotYOeILGh90i/KfxF/rjrAtRqvkr57L9pf/drlclTJUdzPz6FBLLl6EeuzM4vVMl7T1fiSzKQuB5o/nEdZJjlDtNYRMjgCu9CYKDl0YCpOR4L8=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SA0PR21MB1946.namprd21.prod.outlook.com
 (2603:10b6:806:e1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2; Mon, 15 Mar
 2021 23:02:43 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb%3]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 23:02:43 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
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
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v9 2/7] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Thread-Topic: [PATCH v9 2/7] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Thread-Index: AQHXFFV02TiWkaElkkGw6nJpxgFtRaqFgm9w
Date:   Mon, 15 Mar 2021 23:02:43 +0000
Message-ID: <SN4PR2101MB088014895137FCEF17A6D68FC06C9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
 <1615233439-23346-3-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1615233439-23346-3-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:148:effd:e189:3730]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b36405d7-aae3-4426-3bcc-08d8e8067129
x-ms-traffictypediagnostic: SA0PR21MB1946:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SA0PR21MB19460A450E82A5DDDCFF2EE0C06C9@SA0PR21MB1946.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ki5gMKZMxPaXEHVmhMDAY6vamVGuB5TaMVCt+Aq/oqNyD+aYRZC92+DbmylQNjtNDVM8zKZ2lRT2L0gVSIu9PQX6VO16zwIpOtTIjAE03gi8lnW8KhOkS+bkQMxIfcD8ULVJ70wl7H8oC8ji8/QqSDoORsrZOtM7oaYIYTcV3XPHqVsaFv+zrP9MG81Rbg0yoIlmLbn7lE/oxK1o1fw/Z4sz9bjpz9nZM4Bo1aBn2LEHxhRfRM2ZPGmyaNdOgz+jBk319YKPwZ7QsPY+vk3glZVX/ptdSDuGs44rDdsUF30NwPhSqFPyNbdzuJvbxx0fgxmJHBqxCVMsmvcrkfkPQLH1uW7MXL77ECGKJ6wsdFtXxJ8/7+aVAQXCN7OWpmeauqIa0B072GqbAtwdkCJERBhj8NxSUZNVsj7gGO+kMrfvYZmT4D4bqz0U7qfC9FD8Lb/iLfkMUEvsGI6w9TqZzMYGLd7BtbE37jAoLrYSdX88BAdpki2jX6e5ZGwHyds1X7NDWhXbrDphRAYCYfLkdyQ+xuhvkoPASoAEl75QkoujnEdPYs1AHArULsUbIOsnDGsiBcoE7dnr2cHKT0/b+yuVuukDdFQQO7D9GnlCTe0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(66446008)(478600001)(8936002)(64756008)(6636002)(9686003)(6506007)(7416002)(71200400001)(66476007)(66556008)(66946007)(76116006)(55016002)(107886003)(316002)(52536014)(110136005)(5660300002)(8990500004)(82950400001)(82960400001)(86362001)(4744005)(8676002)(33656002)(4326008)(7696005)(10290500003)(921005)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5iZNKkLjJSK3nnKum+DBz5XpRivt53qGh0fqAO1MTU+faaKjQ8jKMqYfrPdy?=
 =?us-ascii?Q?yaIIremkNDxM99yCz67Qm131Sgs24SGWkJGjVQTCZCsXKm3H0Ss1xRGQCe18?=
 =?us-ascii?Q?Fv64BQy8kvwigChE02MJejLvhy/pYXajqaZ5R+78skA+B7U9PBwbSfla/NoW?=
 =?us-ascii?Q?llha1I0sDqeD6tGTHxzk5lMQQDQ2BTYzMKcLAnZkYF6Q/GqqA9Ci6MZcTEBY?=
 =?us-ascii?Q?tJQlLZLMchGhZixRlL/shkYbui6ExE5LZXpgr6V0xlzIkA8lpUJBLG70iW1l?=
 =?us-ascii?Q?Q0DIZBSjrq2HXVq73y1w93BhI+CIBaujx3mF8DNKA4MCPGxmGbY8g6gOufnG?=
 =?us-ascii?Q?qHpabrIQp9K0D0TPox348Qt71XZ5SfBbzxN0L7az721ox58ZowFUcWfAAG2i?=
 =?us-ascii?Q?4aUWznaHa+EpXsZWfyth0+C74Rr0xlirGzfgjmBeu9pWo6uQG5izxBvizG8V?=
 =?us-ascii?Q?fMr9GyZgvKpJAxHoYhwBiYkmlJRwwLjc8eUYHF+1O4i3HNM9HpYWSuoGDbpZ?=
 =?us-ascii?Q?l0SoFXzSZ1Sr7Ik9nVO+Ha8bymGXRRfRIQh1X+BbRMU7zip4/wlhImYKVhkT?=
 =?us-ascii?Q?NDtK5DKoOuDdtUHE9M5eoNI4IA01dxSc4UCobNK6Z8K+CdseL4p9Rc6Vw2zR?=
 =?us-ascii?Q?dUAvk/x7pNZGFAEKH6zUweLFgewWQeiEz0EIzR5PGYWIdRMT9f5uq/NXLYzA?=
 =?us-ascii?Q?c9UhCFm7uSrqvtjtzL2Za+rdt//g7skXbWPTdK43zvX2VHwfqhEGriPl0Hnw?=
 =?us-ascii?Q?X1VfvVfVB1c9DVAl3uOOb2+Wvp2WGx+VXMKSdWiLxIOM5zDbXwhf0E5RmTjY?=
 =?us-ascii?Q?x9jdJkY+Kd1YLp/9VMnMwkAVfhngqIEdRqHtyg71dGf8KZowIBipGxpXtWMt?=
 =?us-ascii?Q?ThbkRyZ2lmH/6Bn8ZznnWLXS9EQJEdr63eR41Rq6FBHWaJD1oCTuPcU3W6jq?=
 =?us-ascii?Q?7IP/WTqNmvBoUFtUa5KoI7I4eM0Q4i7KoH/+4NWF3jYERpl/JvYdEUjEHg5P?=
 =?us-ascii?Q?/OV75/vSBGIibEMvB1XJ1wDxzfmjAMSAT+vU1Yx6VrvgMxX8oG0GgsF09oO0?=
 =?us-ascii?Q?Y7uPZe/piGJGFXhY1yoxzO3oPNCbbYmd7Il1gN10En+DNI8h5S7brnV3zX3y?=
 =?us-ascii?Q?PKPzWR4rb7e2O3+YW4XU44x1jkXSRgfu24Wyj064Ix1/buecguXFaZPtzzjQ?=
 =?us-ascii?Q?dE7xePJp7xw8zY4O0yjuPvfVYk5wlv/6k1Ir9ld/ffi5BweTA9o6aGR/DoOH?=
 =?us-ascii?Q?MmWSL/nWYUg9RMWQtL43cDfY0hJVy3b5mhMCwZEs/uerMe8pa64DGZ64jsSk?=
 =?us-ascii?Q?7aQgCZdp1VTefcarS2G/WiUVdI96+b8eloZgjfgEHivyBVTacVH1OVz2oUJg?=
 =?us-ascii?Q?FvRYaGA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36405d7-aae3-4426-3bcc-08d8e8067129
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 23:02:43.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77XawtgA8tGtOIwA4h6wH0p6RK6gRyHw20fk1ok2adYXQ1sCBYCPnqfbDt1RF8n5guXhtQFEhwCFRo3YUCj87VNqvpcDdzmvPtc6MWICvfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1946
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> +static inline u64 hv_get_register(unsigned int reg)
> +{
> +	return hv_get_vpreg(reg);
> +}
> +
> +/* SMCCC hypercall parameters */
> +#define HV_SMCCC_FUNC_NUMBER	1
> +#define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> +				ARM_SMCCC_STD_CALL,		\
> +				ARM_SMCCC_SMC_64,		\
> +				ARM_SMCCC_OWNER_VENDOR_HYP,	\
> +				HV_SMCCC_FUNC_NUMBER)
> +
> +#include <asm-generic/mshyperv.h>
> +
> +#endif
> --
> 1.8.3.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
