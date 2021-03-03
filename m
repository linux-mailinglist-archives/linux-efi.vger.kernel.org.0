Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4632C98E
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 02:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbhCDBJ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Mar 2021 20:09:27 -0500
Received: from mail-co1nam11on2090.outbound.protection.outlook.com ([40.107.220.90]:61536
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388005AbhCCUWT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Mar 2021 15:22:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cghhVquZyJb2lH5YrMslPDBaPfMBclGh9mes3/0sIDhC64KvfKfWERAqhy2YlJxJiG8oEYuW94R1j4szGEalxQUEllqOXLCRbUu/BPx9GuCMEyilgMQyJUc/rHz8tKtQ5mBGkUOrogZIQmpJ/9rXpNdtHOrUAMLGsJghflPR6U5/RsK+Y4a2zu/osHAtz/ui3pVFHNwR5uGeUyqai0ekkFkMensncPv1+6j07Lc151ix+06cMR6Y1wc0FwZH+LDeWG5Osdm3gIoQ/cHlz0fbtdI8wbCBnaSHPnpnE7RtwbaCUi1Tysp5VFVgI05LZgMQ6/C3+zztqvAcrxz4SOfBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXnoYLCNOthLZA64iKnM4hMaBzuMTJk/+CysSaHliNs=;
 b=WUvrsk6WulNpUVnO7F2HIwoa9LVWiwLt1kYPIzwy7VxO4ssiaE11ex4ggBWIdK5Ntd9MffeypdVG9TyxZJOwe16wUJBgP/T/Fb5fn0bL71jLTV2Y8cmmyUfblZABstOy5mzRzqJAYkZJ0ztxSm2ikNFmkxAbZPM9HG4zy6shvZaIJ9vXh5PTh4vPTolLcsPHaQBy6Ocv4TX5NpcHWVhnlu3mWUoJ92zd46t7/DW3+lko9MesMHfEdGeyHb1RNxy30fXPStAuZC3mQuh26ejtcYVNLSR5tFAzZrRmddSz7To6mhA6+L7H7jrZsVqSfFGskoY+yyXqOIUcpm2U56MjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXnoYLCNOthLZA64iKnM4hMaBzuMTJk/+CysSaHliNs=;
 b=ZZqQKzCbPN5zKLacuqk0zsofRjSnqxXQcnN5826Mz/GiywXUGoozDOYHa675Yx2MwYcQSuimUlid85LLE5a+fhn6Gj0lUm+zLuAjzVri+FcUejkAzovAOp6NiHITI29GSxs4B3KEPq1SCxj4RI08gsSEVkWecWiSQAaaKl8dwlQ=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1662.namprd21.prod.outlook.com
 (2603:10b6:805:5f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.11; Wed, 3 Mar
 2021 20:21:27 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61%8]) with mapi id 15.20.3912.011; Wed, 3 Mar 2021
 20:21:26 +0000
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
Subject: RE: [PATCH v8 4/6] arm64: hyperv: Initialize hypervisor on boot
Thread-Topic: [PATCH v8 4/6] arm64: hyperv: Initialize hypervisor on boot
Thread-Index: AQHXDwVnaTIwkoHCmke0wnq+tNhy8KpytJGg
Date:   Wed, 3 Mar 2021 20:21:26 +0000
Message-ID: <SN4PR2101MB088051AEE9E4C9CF85271A87C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-5-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1614649360-5087-5-git-send-email-mikelley@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 340decde-5007-4245-5efc-08d8de81ec4c
x-ms-traffictypediagnostic: SN6PR2101MB1662:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB166233013EC6464D5283E664C0989@SN6PR2101MB1662.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ewz0iKwsGvmdCt2sMcRFuPLbpzE/EWAREqyIVRIm7Wymgw9CAWPB0DhHcg4B5uIrepCj8zoZfTHzwyfFnZYsawdpsItMHpBGBAMkisxaYWu2zVV1OfvFLZ2dmVRlVRAi0w0Owy2lBWDb3uuSc55pe/cq1FWrv1Cmd+9FTTYKWePkil+yUtj/zzfpfkb1BpeH+zrO/45BYOFcj7xdcd/6+Th+RlZE5poxRJ3OV4wC2S1NSma0fk7SOvrWnqpotMp2bGENW0zQbHfKQEbOcN+UPHZzYgqO9SJOh/WpF7X/H4PrUrpfhziOJlAZcZZCfzPXH6v3hYMgla8sCl6z5sRaEleoWz63sQv4Ocl+Oy31/IM1Gyomkk+aEByemDHi/tz2cpl5o/+h/Lq3hh1F1ZR7S4Nz4BUL079+ZUKDhUghHsAcRb05c+8rseY78IBjV2syqtyYNs8Bkw36kjMHcvsGf7W/pkZ8FbARGxGGDxP5O6iyhh9bYJZjTHmO45tfEn8YgjRMOSum0yv0nRVsgPgjVRt0Fz2GzUaEAyhxszzzEMjj9SccKGKJRqv63U4i6cGF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(478600001)(186003)(52536014)(8990500004)(55016002)(9686003)(64756008)(66446008)(107886003)(2906002)(66946007)(66476007)(76116006)(7696005)(82960400001)(54906003)(6636002)(316002)(8676002)(5660300002)(6506007)(71200400001)(33656002)(86362001)(6862004)(8936002)(4326008)(7416002)(10290500003)(66556008)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?79R0jUmQLxbhSiKCcfNM9ijXJOUV1hGCCHgZEkKt3RiaqeRSV6/hdNKkXch+?=
 =?us-ascii?Q?BbZqUKE3l9fccykKTcipO4+11huPPgG1IembAarKd1ATAatfb4LNxqJbLXDN?=
 =?us-ascii?Q?E/URgFlo7WjmNeZGcNgA6/3FRYDMElbW4jJoqAJt/QaJvFHXWRBAr9OW05bI?=
 =?us-ascii?Q?Dysc52CtdGsq96uJtSHU02qPgjq+Ra9u9j9hoeIjZ6FhEkHlogwHcNrLhkuv?=
 =?us-ascii?Q?6j+8ZuxRK9dbq1qjhGAXZVCmsBU9RKhKP9z56aV1//DvNW95Xt7Wi5sTRguw?=
 =?us-ascii?Q?Cvtk9wZPlOuL/O4XSpbuDvoEB7i+kn8jH9yN0sMu9rGsfoR9geSk1RaoKbvn?=
 =?us-ascii?Q?U8LV50H18t/xo8rKi+10Kbqh6WNbYK0gEmY3xdkYqJwHxCdPrho7ELQd4NPg?=
 =?us-ascii?Q?Lwq9UwU97otmPJNj0rjZa5CDExSgggiahNrZvTv5veAdMegGKxUIOOCEfzr4?=
 =?us-ascii?Q?832Frt7wOVEOoYIv7GKczhUIpWsX4923NsV5hFj3+0HCnOUbGbecmVV576gV?=
 =?us-ascii?Q?3H/th493szxvd6hIYVesiEXJ00nt90hVEa9ce1/pwOVziqKOq933Ixx7QjH1?=
 =?us-ascii?Q?r8qqy/dFAFSWF1o75lreJphN5hXQSFc5DQMUtTzoHP4Zowxa203j/Hug9uc0?=
 =?us-ascii?Q?wBU1i/e2atO0gllcTqBTUZcpRQY5htqxoZRhSjk8UzeG42t4Nic6PuIoK2ta?=
 =?us-ascii?Q?feJIeZk3pzDm/xFoZM/giPVGvSNa5BSiD0neBsvtgN2VO3Sg3phHPt3TQDzY?=
 =?us-ascii?Q?0arPApM4ap2EkVpFAZQc3kUyyoqPII+FhBkeKVqbzyMjAmnjXLe7OIKwCC1L?=
 =?us-ascii?Q?QNOmayG44Yvrhsegs+zP+1xgvLy0mLCwyX7rPQhIlw5yfJRIv3NewjKKARe7?=
 =?us-ascii?Q?7v1YoevVPRKnRSgANu3ePk9GCctQ8cylfn3ZT0hSqY9qmWkUNq6+UN3iHgea?=
 =?us-ascii?Q?YuiT/ikvAAajnsqs75gfyCk8kmEhR5LHBvGiiHi4Htj1bEyQ5GWu3G2ea2fF?=
 =?us-ascii?Q?GUL4K6HDjlB/rndCodvMVnEPepYo919NlOraZFxspA1fnrOSquFoeACok2hW?=
 =?us-ascii?Q?eZmgB9tuRUQM/HcRMWTgyR0npkQlNqFKsgWyRtS19/vd2J0YlXsq/MPOrbue?=
 =?us-ascii?Q?ebZ6Tc2i4IJdl247lcC87PXkKqzb49YVCf3JfdtED4WzBHTaSFDm92i6EJHV?=
 =?us-ascii?Q?F/uPHzI5t05T7RyzgWXQcUO0cRpIEKlhkyrv/P0uOehsH95a9k//xUcGCfa8?=
 =?us-ascii?Q?yII03jZlqLidkmJnAYd091XAPsR8UtZdyyc/2POkbrqSb8oPSL0D3jGOEDwX?=
 =?us-ascii?Q?CP66P4SSnHJ5CR8Gs6vfliS0TzOXspSPrQKJ2Ki9TdF5gg4SoNhEHTu0H8uO?=
 =?us-ascii?Q?3nzUr/HT2Q2iSZM3V8mra9+xnwM/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340decde-5007-4245-5efc-08d8de81ec4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 20:21:26.8211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbkgOwYMz99UaUoPPNlo5fhQAglnSaYkvN47ekbXHLqnYnH6kmAHpQD9De2i2zy/78gbmRFfiQiyXcNzfESVOgEUgJyuDcmHd0KDCA4bRGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1662
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> +static u64 hypercall_output __initdata;
> +
> +static int __init hyperv_init(void)
> +{
> +	struct hv_get_vpindex_from_apicid_input *input;
> +	u64	status;
> +	int	i;
nit: both, tabs & spaces are being used to indent variable names. Can we st=
ick
to one?

> +
> +	/*
> +	 * Hypercall inputs must not cross a page boundary, so allocate
> +	 * power of 2 size, which will be aligned to that size.
> +	 */
> +	input =3D kzalloc(roundup_pow_of_two(sizeof(input->header) +
> +				sizeof(input->element[0])), GFP_KERNEL);
> +	if (!input)
> +		return -ENOMEM;
Similar to the comment on the other patch, can this be done through a
per-cpu hypercall input page?

> +		if ((status & HV_HYPERCALL_RESULT_MASK) =3D=3D HV_STATUS_SUCCESS)
> +			hv_vp_index[i] =3D hypercall_output;
> +		else {
CNF suggests using braces even for single line 'if' statements if the 'else=
' is a multi-line
statement

> +			pr_warn("Hyper-V: No VP index for CPU %d MPIDR %llx status %llx\n",
> +				i, cpu_logical_map(i), status);
> +			hv_vp_index[i] =3D VP_INVAL;
> +		}

> +bool hv_is_hyperv_initialized(void)
> +{
> +	return hyperv_initialized;
> +}
> +EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);

This to me seems like more of an indication that whether the hypervisor is =
Hyper-V or
something else, rather than if necessary Hyper-V pieces have been initializ=
ed. If that is
the case, suggest renaming. Maybe just call it 'hv_is_hyperv'?
