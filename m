Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD53DDE3C
	for <lists+linux-efi@lfdr.de>; Mon,  2 Aug 2021 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhHBRNP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Aug 2021 13:13:15 -0400
Received: from mail-mw2nam10on2114.outbound.protection.outlook.com ([40.107.94.114]:60623
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229571AbhHBRNP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Aug 2021 13:13:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh7AZm3+pWFRS5kjXXM6YZu7/SqrQFQsUgg5DpkbtX9PPePmC0kbjUqlDEgayid5Bvvnas9oPkMZBq8YaMPRtQ/O2282ZtzHU0gpz5JXYnXm+PKwXfEsnd3SfU315HbaHhZCONlAApGzcbtKzVqsgFwvmM2HTgqbraVVmAurKd02e6ilYHU+LFQktGxF0LbgBIGpl1jMh/fgKrEjXT8nluqyXTIrW7ZMrzdDKgjUsYcx/KL83vnxV8EuJtgGdtHZUhAYwJgixbh+Efj+bcNmwR0Tv6xvxqcGykkFX5exZGmjbtLAciwklCqbMIPUcwYuFj3mgXG602tI6lE0ZpV/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yra5C488esazoH4z12sPOuVJ16mGY2/lPbqmzY3QSZo=;
 b=glEShXRy9d4lswtShQgjfMqPBvmD/oJ8Xja1Fz5ovSgcMo49Rjw+ceAiHQH4p92rgCIlwT1ej1Jr+fkhU/qOkoc9x/X27QjcOVOr9iwMfnEJJaaO0Bjl8bYx9mWe4qqxMtUtVH29ZldrOVMfmjVjewH0DJ92WPzoqzObUJH3mpaCbaFNaNEpE0RXcwpBlredk1H+uMpCSDq6IzzgBJA4W2s9HfPdpIHY0sKga/ReSmI3DGmwNK6MT7SwquXu7jbNMj+HSo0BFLYLfsxsrricCD5Ugya31GZQu9D1YJO1D7NE7DfTMCzWYr8KDSu4Vgntfa9B2GLNgbGm7d/XoOl7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yra5C488esazoH4z12sPOuVJ16mGY2/lPbqmzY3QSZo=;
 b=A/qSxvOomGMHUkqHH/sn+mCQ2UxdncMCGsMGaNTBi7d712SrswNvF9oW9dsLhu+/gGmuB5oDM7HilgcyF28WCu2oljU8JxoVKI5ahBVL2rn9fz0cnSO3trT2cEQBxYsVjS+zu2TGZ9fp7kY1RNH4ku39hFTyszOQPMWW4fG9OWE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1036.namprd21.prod.outlook.com (2603:10b6:302:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.5; Mon, 2 Aug
 2021 17:13:03 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::312e:7352:96f5:6afa]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::312e:7352:96f5:6afa%9]) with mapi id 15.20.4394.008; Mon, 2 Aug 2021
 17:13:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Mark Rutland <Mark.Rutland@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
Thread-Topic: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
Thread-Index: AQHXfXeOJQHwhOTU+UeVguN4B2cBcqtge1SAgAAL3eA=
Date:   Mon, 2 Aug 2021 17:13:03 +0000
Message-ID: <MWHPR21MB15930692A0EF42DC49EAEE83D7EF9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
 <1626793023-13830-4-git-send-email-mikelley@microsoft.com>
 <20210802162623.GC59710@C02TD0UTHF1T.local>
In-Reply-To: <20210802162623.GC59710@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9d98692f-507e-4c74-9c93-382bfa459a8a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-02T17:08:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4da46af7-4bb7-40ef-459b-08d955d8c9b1
x-ms-traffictypediagnostic: MW2PR2101MB1036:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1036587B18477BA2F3671A06D7EF9@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wHD+RpTiT8KCwn1cms8Ep3MQC63cZN7WpqE3wEbLU9Zy2wNvNKyqI4ekWRXnd3lT72d4uu4hUlSgl02fqPYr27sva7gy7umnPO9/dNKQYJWMBldU0+oU15XHAcvCT0l+aOAPa91aE1QjRxbc7pvJkgZ8+JdaBdpk4ix1ovkTFCE2vW+12Y88qr0Xg3iMo8l289/HNRRIonGjvwMzxDxdA7RqSTOrT1Zt6KbtCm3gmdHPiwGGhxPLnqNrXIA/XBl4NQgtVPDJ3ixDHA39fz5QSJu7HCKm1GVG6k4VKgoQofQqzx1tTiDgpuojsfywxfekGw16rLimAYIuMuOslqEbBQvaVRqNCrnm3+jIywUpEGof1izdVHLzcGhRCBIMgafHPGR2YwkZn63xMvFpipQpLOuxAkVjnnO8r1NX7MFyWjdcwPWbJWKOyM4V1L0nVd99Sl+6+Led3y9GcazfK9OWJbHFEJtvn+UX6C1ozDLrS70hn+pkzdMRt+VAnkaGQG894mz+9G3Ul9XhvXCABO/BXeh0rn6A2sekwHxhBXFo/OT/YdcYHWy3wJr+fe16zjwHV+x/KSOPRuh1f6dBEcl42jOFri9pkZN7luI1B1asCleXblNR0CYSx82ao47wEX6ljp4EmbEe3qeTzeljljDfI6r/uRNB62onXiOKVe1WgT0utSi1ZbsFSx7izVkZ5rQzPLy+cVYkX9/QE3IsmTaUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66476007)(71200400001)(66446008)(64756008)(66556008)(4326008)(76116006)(10290500003)(316002)(8936002)(8676002)(86362001)(38070700005)(26005)(6506007)(55016002)(38100700002)(2906002)(5660300002)(8990500004)(52536014)(83380400001)(6916009)(7696005)(9686003)(82960400001)(54906003)(508600001)(122000001)(82950400001)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?07tbWBBO3w4m+OLPTYOGqGezNSCl5wl3RDrJsoIWsUcKonRx63znn+NP/D8L?=
 =?us-ascii?Q?Gxh18Wv+L64npijvFOZfYLAQUH0XIgU7+f7CPLapNDKrZpOar7fn97VUAWwH?=
 =?us-ascii?Q?fQuQy7FYPlPUv0o7Ed77ktZbN2Ltai3+oXezLob87AQf3WA5QdkRllA4tMfu?=
 =?us-ascii?Q?XLMxYPVkLJbQ2ideYZ4FEXGX/L+p3AAe2tbcQppHcvta34SrUTZ3drBFlldS?=
 =?us-ascii?Q?tjepCju7CT7qAZrcRm58dLgyYFRooz9caQ0cv7D+VTRkwCSt/NDT1R4A/hmX?=
 =?us-ascii?Q?6kuJQQY8gR05Sj6A/r0u/vPVpbMpnnxQc5OZt8b4xrq7ilLiCF57Qw+zWSxB?=
 =?us-ascii?Q?3DZmlWo7aapQBznoA64tVHhdBrYAPylGBHhXN2HsoW107ekKaC8nMn18vBqC?=
 =?us-ascii?Q?EHlMs0WA1ykpmx1Ft062gcBjyfMRnxZm8kBQT4Al2ZMYb7WJQNIe3oVEacDI?=
 =?us-ascii?Q?Tx7D7QetMKocKV99sP5kdpJ6cplN1l0adL3oh/+/kvizFYgNQyTzUI6zWaPZ?=
 =?us-ascii?Q?oHlgwu9NhgvOcWSbI+hXmhn3zs7ylYflf35yBV3WjCDtGKSQof6WW0hgvNFm?=
 =?us-ascii?Q?0Ve96Ije9w10upKUp7YOOGgclKyfqvWFZuD7ZfI1VHgsN/dxEQhBSvYpcATY?=
 =?us-ascii?Q?EQsZynK6+iqu41MAQbhaA62l025vfP3GcRvyVI6Lw5IzqNpdXhDNgTP4G6Ny?=
 =?us-ascii?Q?T8x6W44wHaPUSpiCRnJX2Lf3THepmSXo1B6Hp1kzjWqVn8JOnGO6bMH3lNV9?=
 =?us-ascii?Q?U1Y/OXJxdgc/q9DU5NYLKl2kyU2rjP40l+nxsioqXfK8nxOPYEb0NWPxysDI?=
 =?us-ascii?Q?1mvzsISnFYzOBhVcNhWVH3zv08Ze+pkImb8KfdE5cWn14H1pcUeSXUIlCuDM?=
 =?us-ascii?Q?g2U2iFcl+yHuqBttLgFlQoQ6OF7GvvBNPV2B/r4L+lXY0pJflBf5Fx3lSMZa?=
 =?us-ascii?Q?8ZyqRRaUMpjeB4YLIAJVp/WqNXL6jqhpX9fbNm4xVLs3AaRqTiS8NIGAknWx?=
 =?us-ascii?Q?Wse5ukAUu8qusgHkVU2gcyaCmo7SEZetjqFjIIOfH+Wa79F1+xSmvsjYGHiH?=
 =?us-ascii?Q?ZCpVL4yLMjWrU1TsBeMgo3hgyXCj5mKQjc9d0WWpdCDsbNRF0FvKjuMpOq7E?=
 =?us-ascii?Q?3n2VPynq7cxHq2l/RVP+1OBRhkVEQMXbOrMvqUSZuba69Xpudr+NwDwEpMbe?=
 =?us-ascii?Q?nxPdF9YgTGMl43VGeV+8v+u9PlbYPeoK1wDkcv8SRjGcUCqDusmFm+7BqGxe?=
 =?us-ascii?Q?9JLBMq/qGp76CYeNZXVXQUys4T+vWvJ4dl1E1loaJ2j7lQOXugjwWwPTtIdb?=
 =?us-ascii?Q?Jl+eaadsARgigrfQf2qssdLo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da46af7-4bb7-40ef-459b-08d955d8c9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 17:13:03.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NABPqVmIDUm+b97ZaLfgF40pWkTsDsNO7kmQGgoAguLJLnlCBRtCVSH0WfHzKzFLyE08ee+q4jmyb5JP1sTU4GgvXpCjGp6ygt4DDDBpr3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Monday, August 2, 2021 9:26=
 AM
>=20
> On Tue, Jul 20, 2021 at 07:57:01AM -0700, Michael Kelley wrote:
> > Add ARM64-specific code to initialize the Hyper-V
> > hypervisor when booting as a guest VM.
> >
> > This code is built only when CONFIG_HYPERV is enabled.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/arm64/hyperv/Makefile   |  2 +-
> >  arch/arm64/hyperv/mshyperv.c | 83 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 84 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/hyperv/mshyperv.c
> >
> > diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> > index 1697d30..87c31c0 100644
> > --- a/arch/arm64/hyperv/Makefile
> > +++ b/arch/arm64/hyperv/Makefile
> > @@ -1,2 +1,2 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-y		:=3D hv_core.o
> > +obj-y		:=3D hv_core.o mshyperv.o
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.=
c
> > new file mode 100644
> > index 0000000..2811fd0
> > --- /dev/null
> > +++ b/arch/arm64/hyperv/mshyperv.c
> > @@ -0,0 +1,83 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Core routines for interacting with Microsoft's Hyper-V hypervisor,
> > + * including hypervisor initialization.
> > + *
> > + * Copyright (C) 2021, Microsoft, Inc.
> > + *
> > + * Author : Michael Kelley <mikelley@microsoft.com>
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/acpi.h>
> > +#include <linux/export.h>
> > +#include <linux/errno.h>
> > +#include <linux/version.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <asm/mshyperv.h>
> > +
> > +static bool hyperv_initialized;
> > +
> > +static int __init hyperv_init(void)
> > +{
> > +	struct hv_get_vp_registers_output	result;
> > +	u32	a, b, c, d;
> > +	u64	guest_id;
> > +	int	ret;
>=20
> As Marc suggests, before looking at the FADT, you need something like:
>=20
> 	/*
> 	 * Hyper-V VMs always have ACPI.
> 	 */
> 	if (acpi_disabled)
> 		return 0;
>=20
> ... where `acpi_disabled` is defined in <linux/acpi.h> (or via its
> includes), so you don't need to include any additional headers.
>=20
> > +
> > +	/*
> > +	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
> > +	 * have the string "MsHyperV".
> > +	 */
> > +	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> > +		return -EINVAL;
>=20
> As Marc suggests, it's no an error for a platform to not have Hyper-V,
> so returning 0 in tihs case would be preferable.
>=20
> Otherwise this looks fine to me.
>=20

Thanks Marc and Mark.  Good point that the code should cleanly
handle the case where a kernel is built with CONFIG_HYPERV but
running somewhere other than as a Hyper-V guest.

Michael


