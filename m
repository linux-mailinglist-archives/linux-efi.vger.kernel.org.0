Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963BF380CA4
	for <lists+linux-efi@lfdr.de>; Fri, 14 May 2021 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhENPP4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 May 2021 11:15:56 -0400
Received: from mail-dm6nam10on2093.outbound.protection.outlook.com ([40.107.93.93]:5729
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230287AbhENPPz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 May 2021 11:15:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUvLnbmHKmKQxCu/JZfF1hOlXKP0ZdO0veATG5JltT/3BFBytw9PZXEzrf+xbKbERCZXfJ9hAMRJ3aYg7OOg5Edq9hVitrM2KraQsjDXsx5hylVNEFnoWEIR88xvL6IcN9I2KgWxSVBpqZjxIsXkz5zqzK1fKYAcIwD/mKAxYZsC0pCuIlU0lUrZzMXUY0XquK6piBiCOnMfObcxVJU/vbWAIYSlwOZijp4GTpBHn5PkgW21scVHCDLGfXir240vXE/Hnkc12tq/PTv4Z/9eNBDeZRsM/Xi9qkil0pQ1C3XSEeADKrAmgr8eoiYhOyAnfNATE9djN9dKpvCLOG8i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O7XbQLYw3LBv771OUD7/xWoT1k+8HEz3/8vhfahFfU=;
 b=ByOdT5fDG+3iwQnkOF7msTK22LcXlemy/0ZS+mX7jR5lK5dVwgVsop9zR2lLjXrOadT671cnvVWaSDEq/sfDy8eN7DJrTiGOi8uePEXF+v8e3bTjkzwd3/5ENPZ9xGIvaIkuPKeIG/KA3UFUCkLGPqPjNR/bFx0qd9yMHMXdsNtsSbKA51WcfKueD3LcxnwC4ukUQS+NgFGBcgxxao715LwI1uFlraloMULr/U4UmnhGJmAq0oIeyRVzrIflwvtaZBzr6C00d6ML75Q8Z5wCM8ue9VHZFPWrmNF8Zu0tZizqjOCVfpgbskYr9llYKuPb3xZ33VR2kHQaPdeldDtgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O7XbQLYw3LBv771OUD7/xWoT1k+8HEz3/8vhfahFfU=;
 b=WBrOcSjL9WyztxX2DqvStGNNcAzYjmU2VHQKjWMaIdndxfH3u0/sNtAXpm0ViCGyYBFak5CB8MWgh+ez1aqW4Hw6wxufSt7mBd4/27VB+0AYAvCAZvryYEFxVc9qCtWNO88mEmTK5ESSJ9FxabBjz0czlRiLAw1+Uh1m69LFHYM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1955.namprd21.prod.outlook.com (2603:10b6:303:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.7; Fri, 14 May
 2021 15:14:42 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4129.023; Fri, 14 May 2021
 15:14:42 +0000
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
Thread-Index: AQHXR1WfbpYqXyQd1EyiAk5Edk8t8qri8WSAgAAjnhA=
Date:   Fri, 14 May 2021 15:14:41 +0000
Message-ID: <MWHPR21MB1593A7625285A3E3F376B352D7509@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-3-git-send-email-mikelley@microsoft.com>
 <20210514125243.GC30645@C02TD0UTHF1T.local>
In-Reply-To: <20210514125243.GC30645@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eedfe2eb-b6aa-4f1b-983e-22cf800d8e82;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-14T15:00:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30e4fb4f-1023-442a-cfef-08d916eaffd9
x-ms-traffictypediagnostic: MW4PR21MB1955:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1955F7871EFF0B0E01EADFBCD7509@MW4PR21MB1955.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trQd9T6alOYf49QTVm7tGcRaN1R0c3/POvdKpylhjVS4wUVXPc3Rf1xzi0fAQDQbsk6/fNGbY3jd2gt1Uf+HrfA7u+YAfdikEPgAVLthB24nGhj0kaLAro+zcJt5jz3Q47jbKkKpMhHDphyHQLYaVPG+vQD24FPLl7g9C1L67dTXRD/HCRYpa5HAEfeDrfgFgArr4o0zPWE33NZ+Z/dyvZb7G0EDDseAwiyjZR418IIjjoN3fp1SoNqT+b1SoIuHO+Nq40VR9VY6dOFfpNilZOjNMG9Zx44tqgpvgKVO9htHnU7Hcwg00qZ10FKdm2e6+C8iFq+wAhMnnSkAMOgNuzMg8qr+m7Q7zFrqeV6lQlpM2NISC3KrUhB0IoLxpN2r7OhyZeyeInTIwxSiEAK2uBjvqx5gnorC8P7K1UEHpT/PMnNQWAtz+30R6sx1gIGaxK4aQW8bjRT4sE2G38kG51IWHnNJO5zZWX5bOVgBM/m3ADxpJKMEFnetvGIkTO0KF4q+jKTlthfdmgr9VFzywxdUCqHeN/oUYw0WMXBN4YSyL3qz4dPZGXZQKumAAm6pDjv8EqX+XWU9U8oUTsHR3Rbps3CxurmAHRgup9Ike3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(82960400001)(82950400001)(26005)(316002)(4326008)(33656002)(66476007)(10290500003)(86362001)(6506007)(71200400001)(66446008)(38100700002)(2906002)(7696005)(107886003)(478600001)(5660300002)(64756008)(52536014)(76116006)(66946007)(9686003)(6916009)(8936002)(8990500004)(7416002)(54906003)(55016002)(66556008)(8676002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGyU5ZxwN2KPMlOwZYenr1TJL+CbHNMQexpMmAPY+4rcT9oc+2M/qq6GDpne?=
 =?us-ascii?Q?tdM1xiaEDpv/Ag/jX+FsSA/0e/tSOpNoq6i7B7YBvKvET0HsHm92qVKL35nM?=
 =?us-ascii?Q?3yB09NcUNhKVaZYD3XWnkIMuU6vExVMWvoBXpWGSqnqeHWL1qaKlu3T8nqRD?=
 =?us-ascii?Q?yFBoDtE9SxSwFJlcELlxuc9GoC9im0Uuxunp9t69Uhakhl6fHzYZWh4+V2UV?=
 =?us-ascii?Q?jgZzGehWLSjMEZXTfyl1wn7ktdqYdHLkBzufNcDz2ufbJSDAREAXl/kIPSQb?=
 =?us-ascii?Q?09eUFSahZhXOQlI+6JK5aDA1KexUvoB+eWovDWjo3KwgcbBOrX08slUAJHKF?=
 =?us-ascii?Q?FWI+nVbhnzI9aWqhSU9+r15n0+wG5UpKb+czFtai8l58szYmbwnKtCM+l2pO?=
 =?us-ascii?Q?XysRR4Y6wMsve3LdvozIhXym6VmUzcZlDDVrBdJP7FYZeH7Ff6gakDXwhcVA?=
 =?us-ascii?Q?XC4Az32ax8qKBdmnUM93AMQ+0zllcdYqBkRjjTVHCYMAcQCvpWiwDfuSQexJ?=
 =?us-ascii?Q?Sfn1U1tzcyQQlnQ9tOQY5Aj6Puz93NKxehlq8eJX2ymW4ZDguBASmXSIDuSN?=
 =?us-ascii?Q?NHL5jW5g5I9ZdzI4tiI8myqK9MYohfMb0HQZHQZn8L07U93mBiS46C5PEEBn?=
 =?us-ascii?Q?2SgLq8tytD25SOdoUYtzmMZSQIOX2GLBRpgifRIhiSfkOqGkf+j/K+u+25OJ?=
 =?us-ascii?Q?hkumXk6AZRxuH9Cn4HuFS5Yh+WpiuII+bAnWVm0CBM8exe7bcJ0+uwJa0uCe?=
 =?us-ascii?Q?rJzzUIfKYKam4xxGd3RquHrMNq3I/faEgB1XqAEtUJpx4DCNiBXyyAF0VaBG?=
 =?us-ascii?Q?LTIqiFyxF674uduLDfJfUJH+6K6gnnp3wc6hcwtfOvs0J9Kd5i+7By1EXbi9?=
 =?us-ascii?Q?4VJl9kjGm97Xq0CR2A5WIhA9FqUO7h0SUd7iZk6NhIApZwmGXqMQ6/Frm5pO?=
 =?us-ascii?Q?TwaZO3M2E8bAkPLCx64Ut8rAoIpD6+at6ejS3lfY?=
x-ms-exchange-antispam-messagedata-1: +f82z7U0EEwWNjZqFCvZ2MWVDg0ZidHyGgYXdILQDntX6TtZ4AuvUx/1aVtc099OhHHS7ghTewGrWjiGEPmO9mfilRw4d/YmPEOhoTmKDevklYUn2DPUIzjbIcyUVL4pBHEXN3Y0F1wMHFppfIHxLO933cHktXeIThuTsVUv8JrHWLcpcYFQXFAO9Zg2upEXhwfebHk5nJ7lC7Oh6qO373GppF1R0r4DHOH/KEh2+TvSKz7v9VKqVOLb+4MNxRp3TXRDR6TwCro+Bd2N3g2Hd9FCbz5nA+GUmLjb76PiAEqJn+VFRCX/+g5A5agMziqVcqAj+vYyMHnPn7yVkrIKUbF/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e4fb4f-1023-442a-cfef-08d916eaffd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 15:14:41.9049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDPe5uNhThntJ7h1B1dUyRjyoBQUJ7s6AtnZBOXZoHM03Aw33uW25VKpnb6rAiERtgg7nbbGQFVK4LoDpJqcs6jOnVi3PqfI+W56lBKx5D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1955
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 2021 5:53 A=
M
>=20
> On Wed, May 12, 2021 at 10:37:42AM -0700, Michael Kelley wrote:
> > hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
> > Functional Spec (TLFS), and #includes the architecture-independent
> > part of hyperv-tlfs.h in include/asm-generic.  The published TLFS
> > is distinctly oriented to x86/x64, so the ARM64-specific
> > hyperv-tlfs.h includes information for ARM64 that is not yet formally
> > published. The TLFS is available here:
> >
> >   docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/=
tlfs
> >
> > mshyperv.h defines Linux-specific structures and routines for
> > interacting with Hyper-V on ARM64, and #includes the architecture-
> > independent part of mshyperv.h in include/asm-generic.
> >
> > Use these definitions to provide utility functions to make
> > Hyper-V hypercalls and to get and set Hyper-V provided
> > registers associated with a virtual processor.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > ---
> >  MAINTAINERS                          |   3 +
> >  arch/arm64/Kbuild                    |   1 +
> >  arch/arm64/hyperv/Makefile           |   2 +
> >  arch/arm64/hyperv/hv_core.c          | 130 +++++++++++++++++++++++++++=
++++++++
> >  arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++++++++
> >  arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++++++
> >  6 files changed, 259 insertions(+)
> >  create mode 100644 arch/arm64/hyperv/Makefile
> >  create mode 100644 arch/arm64/hyperv/hv_core.c
> >  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
> >  create mode 100644 arch/arm64/include/asm/mshyperv.h
>=20
> > +/*
> > + * hv_do_hypercall- Invoke the specified hypercall
> > + */
> > +u64 hv_do_hypercall(u64 control, void *input, void *output)
> > +{
> > +	struct arm_smccc_res	res;
> > +	u64			input_address;
> > +	u64			output_address;
> > +
> > +	input_address =3D input ? virt_to_phys(input) : 0;
> > +	output_address =3D output ? virt_to_phys(output) : 0;
>=20
> I may have asked this before, but are `input` and `output` always linear
> map pointers, or can they ever be vmalloc pointers?
>=20
> Otherwise, this looks fine to me.
>=20

The caller must ensure that hypercall arguments are aligned to
4 Kbytes, and no larger than 4 Kbytes, since that's the page size
used by Hyper-V regardless of the guest page size.  A per-CPU
4 Kbyte memory area (hyperv_pcpu_input_arg) meeting these
requirements is pre-allocated that callers can use for this purpose.
On the x86 side there's also a similar hyperv_pcpu_output_arg,
but there are no use cases for it on ARM64.

Michael
