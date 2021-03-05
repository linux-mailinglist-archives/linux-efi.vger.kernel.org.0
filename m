Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17932F50F
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 22:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCEVDe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 16:03:34 -0500
Received: from mail-bn7nam10on2092.outbound.protection.outlook.com ([40.107.92.92]:4577
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229629AbhCEVD0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 16:03:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F06CAXJPZ69K95xi6cfKydJGSeJOJSZyObQ5iaQSAl/pGEw+cqXwJcAWzLr9kb0aHHYC/nSIfaFheTcYgcNcVQ7N9pHL7bmPTPxHmwPRCIHBS9up8GQpoXoL7xFjJHLV851NU2wPKXHilEi1mBpS7aBFkEqe0/BUpWp0Brc/RjCTqQGhWLLK9sVHy341C0Y/JiV6u92aI8AJTBeXQEfEVK7HGN/WFau05AgqzwJ1Xe2FgkJRXO2/FuX44whKKMdgy2YGAJVvZUWIA30WIuLtxO7g/VFdP0sOftGPTaS1epol3tI7ibu96FcHFNAI4Yj/6OfiutKrkS2FhFVx3SFdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxxWjXajWEYtomimjQoOXyEzgjSQs0cgrygbINE42yk=;
 b=jS2+WqBQ57008ZdJ+asMEM0UAloKKfpDKd8iAzSxqRit87POBUcpaGDkXhJ9eADj7LC+Yo1QOB0kGVsn+Yr2A9PTzEMrpYagHgfK7cW/Wxgp0YAftccbz6VpE92avl2SoEdzpaa4FDvrUZCq2ypowri7n+JROmNHFwJARMWE1VQpqZl1SBGbqmGZlfOFhvYP4+3XQYloEZpmHPCAz2mKYO2q6oS0lsv1Gs2S+svhZ8VL4X7cm0kTaP0J8REJVk+vo3nYJSFxd+ILQTluZjeTYaegceiEM2ijYtCf3QN5IL9VsLDg5mjb+sSUUTBeUW9V38Em00iTIE//qofMZ2f4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxxWjXajWEYtomimjQoOXyEzgjSQs0cgrygbINE42yk=;
 b=BXbiUb4LIQcVDEGeGdCr/6h1Xh4zcFPiA+Kj6kIZoshm/d+pMTKVa9e/elO97fgv2QfpoItOLYfSTJ9DSlbXpklRGDTSXzccOgr5p9GKvBnf2iJpdRVcpTiRnFTcBrXV9eG1ehKtPk/da8El/kqMXSQwPKQhjzpFUcegKIzK5rg=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1953.namprd21.prod.outlook.com (2603:10b6:303:74::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.17; Fri, 5 Mar
 2021 21:03:24 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 21:03:24 +0000
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
Subject: RE: [PATCH v8 4/6] arm64: hyperv: Initialize hypervisor on boot
Thread-Topic: [PATCH v8 4/6] arm64: hyperv: Initialize hypervisor on boot
Thread-Index: AQHXDwVnaTIwkoHCmke0wnq+tNhy8KpytJGggAMyJ3A=
Date:   Fri, 5 Mar 2021 21:03:24 +0000
Message-ID: <MWHPR21MB1593960D8B1FFCEC510CD991D7969@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-5-git-send-email-mikelley@microsoft.com>
 <SN4PR2101MB088051AEE9E4C9CF85271A87C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB088051AEE9E4C9CF85271A87C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-05T21:03:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d6ecbce3-e220-4772-a618-44ae319e7742;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4a23980-403c-4b17-4841-08d8e01a1db1
x-ms-traffictypediagnostic: MW4PR21MB1953:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB19531985A52A0CD5FE20600AD7969@MW4PR21MB1953.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJZsoi04VuuD5H9kbGLRd3gvPvZ54c0B1EsAQMJkYrlr7tCeHQmCdV2H1ofytGS7vn2OI/QuB6xUSVFQBrl+FRtDy/y2GwovNPmR2WyEqw0UG/AAxEzdHLzuKnyNYQ6c9lup41/5EylGI59mTQAsq/N9q5/nMngoACQTscFuGd90A95M5BUnSGqeZ06C8LVumgburumBUc1oSAWmhIEiWNhvkikRHUXeVdpzUFJpv2UnvHdwCXWEsyAxTZrSLSpVLRS9I4JRiWILjpOqRvf/O56G6BGLDoqbMcKLbGWvCUtxnPKr6kdDxPcYB1AeUZxoUHGVBxJu+KAsVnam3PrpMaAty2IEaxnZNmDKdkC1zZ0FoAXFnWmeVZ+HZMji4EZLPNAZ7RrE32M6A9nYLX7xSEq2FJFv1LDVNvZba3AVO90ipeXYWuBvh2CPuErhFAQIw+hx6XXgr1HdGtKj2JU2VE/Ly+XpGhnLoM8/wT4puTfsjARJJXw52xh7kilzRPFbNFSkrpntkm37qjT//L2jxqfm5HByoBBIZ3sO9er2YKDEDxiAZ/EVtk1z+XPG6Ztb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(86362001)(186003)(478600001)(26005)(82960400001)(82950400001)(316002)(71200400001)(54906003)(5660300002)(55016002)(64756008)(76116006)(52536014)(66476007)(4326008)(6862004)(8676002)(66946007)(10290500003)(6506007)(8936002)(66446008)(8990500004)(7416002)(66556008)(7696005)(2906002)(33656002)(6636002)(107886003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6ybKOnGCq8OSFxQMMGNCoDz86zNEvtltIvdGwoBIzlilcqcSVom9gnRTZ7eN?=
 =?us-ascii?Q?uoaLDKEMNgpdYDxuxw7IvCWm238nFgx2agKx4kvmkhSXfWTmD/C6e2fTHilB?=
 =?us-ascii?Q?WyMr8GEKP/lYY8NQPF/eb3oFtliOisanEKlVVPMJw/pAA0SgjpDueuTnz/MJ?=
 =?us-ascii?Q?dlOuFTr9W4zgL/kNxMaNbjJmIWnRdSBPSjJfuvTBuHkMefFBFF/7k/c9+4pi?=
 =?us-ascii?Q?3KabVqHGXQLEllNU43S/n/d2g8ZC7WrIMf0BfZ+iTL9rhSfEWjpJaStuGQpT?=
 =?us-ascii?Q?/EJQ/5AdoM6r+Oyb72It8Ll7VybCvlwZCqsz808w2KoG76xdZ6biO562lhff?=
 =?us-ascii?Q?f/XZYe+88nmTmRxmgBfNVWaC4y1FAILvCgADukoxanD3/qXrbH7SjeK73jEO?=
 =?us-ascii?Q?3UIAx5viGYK7m3HfTt442r6Ldq9LsKYLr1LuaDHIK79IKjCbXq2InnQ8KntR?=
 =?us-ascii?Q?F6SdQ+s6fIbQ9jyVkRP+kuvk8zufJCpxnoVknaA4yZWYQRQ7A27DYg+Vu5Uk?=
 =?us-ascii?Q?HSOHGyi70zLrOTSx56lWD+og3lbrvNZmAW1q3WxGS6aHuJkBl3cBJgbLpPl+?=
 =?us-ascii?Q?OmwuYKQHL+tApkzrYpX/HgYOBnNn9mKu8l2+ltqwbPU5riLHhRDlJ61TcO87?=
 =?us-ascii?Q?GBUDPc1v5i6wOenjrhdFIjDTczgHIudIXy6Y5QDpebyFqvyhITjip2ZLZdGX?=
 =?us-ascii?Q?IvlLHO4Ioh4knex7otaSMIJQ42QhIqsqZ1Lb9cIO5/AtqFCjR/af8JxejE7V?=
 =?us-ascii?Q?Z8hF6tTBL0wXj1ctUV276EXluq9n50vvczfDKCe2OIaUQWBLE7HAd7A0VzKH?=
 =?us-ascii?Q?6IHVFAHkkLg6SANpZB2zEGv6SrxDonW07rDqPEsCeliHzrlbWav2DJtD7lkc?=
 =?us-ascii?Q?ak/MvBBaettqPQvQ3loKl5H991CNUPUiw21X5knLv4NFivQ1a5w6M36yXpaW?=
 =?us-ascii?Q?mqJuBjyyF/C2iREiZ/1h8g4OmgcngtNcr6HZDrwviJlRfemASziBzD1M5MHS?=
 =?us-ascii?Q?F3r27t5bSlW+STpshgKDBJOhFuaPs3vLNToeY5EcevDEBL+tnFYGjtMfR+Rt?=
 =?us-ascii?Q?ADWczYf2aL0RlrZMxJFhy+anpOB8xyxeeAubwTp0PLXJJ0rdjHhGN7Tj6o4d?=
 =?us-ascii?Q?VQugNVlG9Ex33au/q5gK7Kiu0wQsQV0ZNKrQ/cjR/AcEJj0vWIqNVqVWJuXn?=
 =?us-ascii?Q?7kEROuTg2j28oVNwHJQznVFJtCXc/ulAQYgB4hx+qq0zRiXe8uF7+Nyj30L4?=
 =?us-ascii?Q?zQuOn1Hafr/HOQJG67Kw9RqCfPuvcNvMDXQ0II1270pdIpi2guIoz6Fz+f1m?=
 =?us-ascii?Q?pu9mxZaUXvv+u/Vd0BtGZmx5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a23980-403c-4b17-4841-08d8e01a1db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 21:03:24.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mzq+q/UEY/2L76ZIOfC+GaIhyMV0pbH4IwwlF1rFPAPC2Vaec0n/v9hz6pSlZDSG3znZCVetjnEpS7/4XYDf53kAXFzxH5Lnpyttn4c0XRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1953
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Wednesday, March 3, 2=
021 12:21 PM
>=20
> > +static u64 hypercall_output __initdata;
> > +
> > +static int __init hyperv_init(void)
> > +{
> > +	struct hv_get_vpindex_from_apicid_input *input;
> > +	u64	status;
> > +	int	i;
> nit: both, tabs & spaces are being used to indent variable names. Can we =
stick
> to one?
>=20

Agreed.  Will make this consistent in the next version.

> > +
> > +	/*
> > +	 * Hypercall inputs must not cross a page boundary, so allocate
> > +	 * power of 2 size, which will be aligned to that size.
> > +	 */
> > +	input =3D kzalloc(roundup_pow_of_two(sizeof(input->header) +
> > +				sizeof(input->element[0])), GFP_KERNEL);
> > +	if (!input)
> > +		return -ENOMEM;
> Similar to the comment on the other patch, can this be done through a
> per-cpu hypercall input page?

Per comments on other previous patch, these allocations can be eliminated
and the problem avoided entirely.

>=20
> > +		if ((status & HV_HYPERCALL_RESULT_MASK) =3D=3D HV_STATUS_SUCCESS)
> > +			hv_vp_index[i] =3D hypercall_output;
> > +		else {
> CNF suggests using braces even for single line 'if' statements if the 'el=
se' is a multi-line
> statement

Will do.

>=20
> > +			pr_warn("Hyper-V: No VP index for CPU %d MPIDR %llx status
> %llx\n",
> > +				i, cpu_logical_map(i), status);
> > +			hv_vp_index[i] =3D VP_INVAL;
> > +		}
>=20
> > +bool hv_is_hyperv_initialized(void)
> > +{
> > +	return hyperv_initialized;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
>=20
> This to me seems like more of an indication that whether the hypervisor i=
s Hyper-V or
> something else, rather than if necessary Hyper-V pieces have been initial=
ized. If that is
> the case, suggest renaming. Maybe just call it 'hv_is_hyperv'?

This function also exists on the x86/x64 side and is used in architecture i=
ndependent
code.  It's meaning is somewhere between "is Hyper-V" and "is Hyper-V initi=
alized".
I'm not sure there's much value in changing the name everywhere.

Michael
