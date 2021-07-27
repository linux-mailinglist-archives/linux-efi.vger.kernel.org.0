Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F23D7B8C
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhG0RFg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 13:05:36 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:5569
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhG0RFg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Jul 2021 13:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyvDOCw0mMFgMWKczBOUSQSopHrs7AnbWOok3BbpBVnrXYmzTPgtXmjanbGc3+RQq98437QkM8YXk7aC5QP1gPaKutv7KMoEfgdkeTQeSyNRht/ntLf+ZICG2pHLFFOvuyI1uygkat5hlAojj1MWKVz0w1+J3QUoGIDN4nTcl7rBkfwrNLbNzRnLiZaogk9wYCKCStDbCymckTuKctiX6C1TETH7r+CGdivXD4d1RxVrFIDiAxQ7T2OeYjaL9YCECfC39uAOluslrmt2+m89bzeMCQgV7QafRaVnmyeBP7bIzPm6yfWpY2gbXa5DismrzlB92eXEqMuJqxclwVRplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWXYPqFgwmwaGrEQoOJWbKhP7Wp+P2g7mLzfa8p1Gbc=;
 b=iGE9LtmT+DiSlaUSQHC16U3ocv0E+YrnoqHqeWD402vdRZUX5wsJxd9CoLwS/dwQQ3Q/YcH00kTK98oyK69MkQHOel2cthSaV1YULnvLq4IOH5zZpNBGQu9+BRgVBPyXPQZ+mwLE123zXtWyWbN8lpQsKixzJoJ/f5QdxJiwrGuwCOgHc1AjPpbz9wvdsEiud7EcmhLO5aR591NFDY5anKhqCnptjmWRjlZCloc1NDAneZ3rS/TsSPB3p11ophLa7neUNV+R+ilmLe+97vweWKHKgV2//v1rniTG4RYiqOOnbPGYmVY4MsiyuRwmcXOA4ThrO295FBJxk63VM3n46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWXYPqFgwmwaGrEQoOJWbKhP7Wp+P2g7mLzfa8p1Gbc=;
 b=Uelzy5VMzIwIm2OdxNiO8tJaL7yHtbRNNhxj2Y522z0OLhx1aJsPF3ziNKnQnBk9M41Vv7NgF8fbTdRmJu8WJbZD8mWPcx5/Mux6k2+TEkn8NbxBa8z1kEbqymzBz8FsWsi5EE9j0m7brQgzYO2UV8Gir5DONk+bLY25VfKoJfY=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0639.namprd21.prod.outlook.com (2603:10b6:300:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.3; Tue, 27 Jul
 2021 17:05:33 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51%4]) with mapi id 15.20.4394.005; Tue, 27 Jul 2021
 17:05:33 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
Thread-Topic: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
Thread-Index: AQHXfXk3HZzHZE4RbUysV6rBbtdFDqtXF4yw
Date:   Tue, 27 Jul 2021 17:05:33 +0000
Message-ID: <MW4PR21MB200240F67E9572EA5C4F986CC0E99@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
 <1626793023-13830-4-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1626793023-13830-4-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ff97e1b-9a34-4f7d-3dab-08d95120bed8
x-ms-traffictypediagnostic: MWHPR21MB0639:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB06390283E0E73C7F850858D9C0E99@MWHPR21MB0639.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKmDh/diiFis1evQWufKiyeiwDO1m+pH1HqMSNr4Inw5eiS8GB2W35IZu/LgdPnnR2c/vsAFg0GNmfyOEpSp02uOlSafKyILeeMEVpQeugdiGjyE4oa4byvGitH0low2IYNnG9q9Vzstes4qcgpr5KzoPETip4jv6nSU4Ls2+1j1qOMJODJDaa4qRcdJmVGRDjsmNEgHm68nIZxx/bVF4397fxsA6S2F+14n2Cu/CZOIRJS4FdOHylChlSqFavyF4PjxiI5mfMjQvYsjjgj1nvHFU1v1FfUQO04QYNq1MfXLUNnvlKx3Jj2vTJKchOIVOIdvjtVOaqylj783yveLi1wj8M21xYwcc4wzokw14T5cMCO+S9gCIviRNyJ3GAo3ArAeffCGA5XN/1Glzx4NicQNdgtCMG+3d3MrSHVex6gUc5rR2aPaQ4mNCsm75V5PUUG0mhm1RQxD/Kh4w1q5vPt5kXxbi+x08msFuRwjumIkXm7y4HpOD2vpdAS3b5W5Vd/Qt5gKzmuuaGXyG6N9vjLjPp7zqBUTUjUksNppH3mXTCzm2CBM5n4kro0QLMFSjXRw45+vGY+fTOlqj57weDYfzmi0IHTzwIo4RqgsZKtZsTCe+1pKWfxc63uVQh0P6ytbst27s0//Qr4wcvt9NEbcxrSdUqWt8CWoULEASMTJnN78lpgr/w+VX38U0bno3jn0PH9/youCEX0puZ1bujY/WDNLuAcbKk1ONL2Jl18=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(6506007)(64756008)(107886003)(71200400001)(66556008)(52536014)(508600001)(66476007)(66446008)(66946007)(10290500003)(7696005)(186003)(8676002)(8936002)(83380400001)(33656002)(110136005)(82950400001)(82960400001)(921005)(2906002)(55016002)(316002)(38100700002)(122000001)(9686003)(86362001)(4326008)(5660300002)(8990500004)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PR0TopoNaKuYz/zFtYv5yqfu0vfrIzTwqZ9dU2OPIfvFISEkA4XcXY6FRxha?=
 =?us-ascii?Q?sc6QhawPVkXO95iwllP3NBrBYqdSp8xPkArxiHerIJvvLapkvpYJOmUtWlJ1?=
 =?us-ascii?Q?g0m4uz424Cc2VAnZu03S6jCv6gjCQxQEwm7qB0rnpaANiv6jKGGD6SlyHcxu?=
 =?us-ascii?Q?yioklINdVKhm+ZAmaJHoF7IhS7Zfz0n/OvUaasitT/8SWIAB2//iWNKc59O9?=
 =?us-ascii?Q?gmKOAQZl8XuZOYQY0cboFltZ5KATy6Z3d5y6m2r1r50wtfT5fZ4vcGlhFRXM?=
 =?us-ascii?Q?MHEsVcWh66tcmDsaVj2qK3LC216nWXE+i2vk/PZHexC+UoLv/bUvkQNQ7Uj/?=
 =?us-ascii?Q?aSeVrqhRg36544kyD0ZeHQgWTkkOC6QzOWfjJvH58f3y9IaavsH6F66ge3sc?=
 =?us-ascii?Q?wv2A11upa5q5Wr4XgtUSqu4Iuom1kFqvtavFGemRoReNT7UUBqaq9PsAz0gU?=
 =?us-ascii?Q?VFRTsGeg48TOh2kqofkztuPFk18izrxlgDLLQrb5rz7vViF/60yLq7sBRCFd?=
 =?us-ascii?Q?YCTlrbB1bm6oscQ6UYM3dT7fgh/h/9TMRgqmrYY4CwKYPDAV66eAbTb4RVle?=
 =?us-ascii?Q?ve41p4XmzxcOEvSA4LY4AAtZXrfGARqNqQBCVPt7khylVLyjkpPKg25VHZOB?=
 =?us-ascii?Q?CU26XhDwitQO6dLHHc02HB+UdbNpTvGpTSY71wcgys5ZSrH6kb/RTK0DHJFp?=
 =?us-ascii?Q?x9JXrgBzm8049bYvjhVP+R4jc1fxyUuBUYvU/yrx4U4eazvqcifzm4OIUK/Y?=
 =?us-ascii?Q?Z+RZjYZl1c+ZIP4r5A02vfrOeMbKm+q88vA487VmtLV2akTn9AH0CjzB9cJY?=
 =?us-ascii?Q?5RtW15xS26IyOnj/+9K87cmK/sX6DzCh6ORLdaCxe/TdBd80KIpG2YviRIQr?=
 =?us-ascii?Q?WcQ2KkG0tuPTMyHiXQejFMYsaxYhpzZb/Qx+QJdtTP3RePISYuPr7Vlvtg8P?=
 =?us-ascii?Q?628eWn0YxLztT2+Dohx1nXZCPI7XCDQoh4GaRB+xNdHt5NCv4Bg8IpuyUu6W?=
 =?us-ascii?Q?XEIu7kZjP73rznMSynSxJplE3JEFEyDDAKlYJdO48cD0jTN6MuU/y7Whiud4?=
 =?us-ascii?Q?SCRY7x2O47OPKtU8KxfOQtE9fpXRN6ymovX1VtUuJlF8808eU/Urp+GDYISh?=
 =?us-ascii?Q?xqUKD1vqUWKzzWCSIZm7ovp5zh8Dqo7Jlvl9RCCNO8X9x53DKOsuNqGQN4Vi?=
 =?us-ascii?Q?puiUShdZdc8VhlQuQQ9UWDwjdVOAz6Iyf3TeNp8l26E7XSuyy6r2nox0dNX1?=
 =?us-ascii?Q?dySX2Ehfv7hgzNOXDsNCCmxMpSyXl3KfJVbWyHlO1AT6CDuBrYXYUOj0FOO7?=
 =?us-ascii?Q?pr2ksZNnfSzzUo6iw5WzE55uH1AwrNdm+TZa4P1APL+VADq/PTtsrN5nu4EO?=
 =?us-ascii?Q?JW3Te+DVPg7VLy355y8Z/2OhVjmB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff97e1b-9a34-4f7d-3dab-08d95120bed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:05:33.1505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bLXKeOElv4Z4kXEKLY14KADamXT+9XHlUDkVfayk4FAkrcnf462MWOeo6tEYkYgq5pdQSXfeqf8ChgY8635zPrzhVrAiniQ0OS6zIlYJoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0639
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> Subject: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
>=20
> Add ARM64-specific code to initialize the Hyper-V
> hypervisor when booting as a guest VM.
>=20
> This code is built only when CONFIG_HYPERV is enabled.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile   |  2 +-
>  arch/arm64/hyperv/mshyperv.c | 83 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/hyperv/mshyperv.c
>=20
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> index 1697d30..87c31c0 100644
> --- a/arch/arm64/hyperv/Makefile
> +++ b/arch/arm64/hyperv/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y		:=3D hv_core.o
> +obj-y		:=3D hv_core.o mshyperv.o
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> new file mode 100644
> index 0000000..2811fd0
> --- /dev/null
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Core routines for interacting with Microsoft's Hyper-V hypervisor,
> + * including hypervisor initialization.
> + *
> + * Copyright (C) 2021, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/acpi.h>
> +#include <linux/export.h>
> +#include <linux/errno.h>
> +#include <linux/version.h>
> +#include <linux/cpuhotplug.h>
> +#include <asm/mshyperv.h>
> +
> +static bool hyperv_initialized;
> +
> +static int __init hyperv_init(void)
> +{
> +	struct hv_get_vp_registers_output	result;
> +	u32	a, b, c, d;
> +	u64	guest_id;
> +	int	ret;
> +
> +	/*
> +	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
> +	 * have the string "MsHyperV".
> +	 */
> +	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +		return -EINVAL;
> +
> +	/* Setup the guest ID */
> +	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
> +
> +	/* Get the features and hints from Hyper-V */
> +	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
> +	ms_hyperv.features =3D result.as32.a;
> +	ms_hyperv.priv_high =3D result.as32.b;
> +	ms_hyperv.misc_features =3D result.as32.c;
> +
> +	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
> +	ms_hyperv.hints =3D result.as32.a;
> +
> +	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc=
 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> +		ms_hyperv.misc_features);
> +
> +	/* Get information about the Hyper-V host version */
> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
> +	a =3D result.as32.a;
> +	b =3D result.as32.b;
> +	c =3D result.as32.c;
> +	d =3D result.as32.d;
> +	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
> +
> +	ret =3D hv_common_init();
> +	if (ret)
> +		return ret;
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:onlin=
e",
> +				hv_common_cpu_init, hv_common_cpu_die);
> +	if (ret < 0) {
> +		hv_common_free();
> +		return ret;
> +	}
> +
> +	hyperv_initialized =3D true;
> +	return 0;
> +}
> +
> +early_initcall(hyperv_init);
> +
> +bool hv_is_hyperv_initialized(void)
> +{
> +	return hyperv_initialized;
> +}
> +EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> --
> 1.8.3.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
