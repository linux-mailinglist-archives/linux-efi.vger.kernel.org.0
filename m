Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513E4383B45
	for <lists+linux-efi@lfdr.de>; Mon, 17 May 2021 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbhEQR3g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 May 2021 13:29:36 -0400
Received: from mail-mw2nam10on2096.outbound.protection.outlook.com ([40.107.94.96]:65120
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241680AbhEQR3I (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 May 2021 13:29:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxKufeAwbpAb1Veyzgmu/h6pBdK1deoqjUSPkOrPR2KwOXlCAGnf8BcscSLCPyOd2k+CobCudWVufgtfVVsz8hwPkpEHs3KZFTFNs7oVG2KmOrjOCHG1KpIlVVji1oZ52G4vk7DwnGjOZUH6mMe9OetIaPBPUXkElk3CfGCxCZ/4gXbACBeBf2bVdbB8n+4wZhP+e1R4pN17yoRiX3ihS/pLU5Q6C2cJdatqS7XDnghCray0XItyrmAztPofs4zF9DTMgUpgdyi/kvRvPlNcsLa8W5XgepSBTxCQEzk0mSJRrAF/L+xRRUEnraSbf7fMmH0es2LjQBdHBQjm3+8VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBI17b9hx74IEVRHvSf3tsdHnaGj6cAD/vX0w/zdljQ=;
 b=Yd+gO55aDPfDvYg7ZxIJalpVCJDb2OeLCeuQkcjoUWwFPSsCMzj82G9l2QkKg0g4TOuft6p/m3ACDX/Pzdx/mHp/JU2p4AdsdXnQDA2LyrtMVqtGsfTiXKgdcpabdSrHs7UmyA+M4cRenkW8/GpjPz0WlGutRI5ytBjWG+GOm3SBV6FLEIG0lh9rJ0F5HPsK5UVtFzlh8OXp41GAuqZKM9KwkxZnP+ETAeW+kTHRkQrvWFXxxuEN14qxAhkenOGkxG9Iq9eOKIMyihIJU2tqomKS6N32FQQUdqBAHtW+rkKgT823i+fMoDEGS4+MzU5/OWtHqpbYlhMkEt2P6UAfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBI17b9hx74IEVRHvSf3tsdHnaGj6cAD/vX0w/zdljQ=;
 b=QJCfpsbDfqlb0tG8PK0Msy5SXyuHPYplD5LGmqhLu8bih8u2vZfZOwCX68MGiph1dXOSIX7cTXxq0BYVF4duo9c8t9VAneBYnPkRNu6oPeWiaLMrQ12XRBbHNdAJcC1BWMtJVHUuGAJgLZdy1t7+apSST5IYTfwJlZjF/x3Oq7Y=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0937.namprd21.prod.outlook.com (2603:10b6:302:4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.6; Mon, 17 May
 2021 17:27:49 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4129.023; Mon, 17 May 2021
 17:27:49 +0000
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
Subject: RE: [PATCH v10 3/7] arm64: hyperv: Add Hyper-V clocksource/clockevent
 support
Thread-Topic: [PATCH v10 3/7] arm64: hyperv: Add Hyper-V
 clocksource/clockevent support
Thread-Index: AQHXR1WfRNuOt4THnkSQtAriU3aWFKri7Q2AgAAsnCCABJMQgIAAO7hQ
Date:   Mon, 17 May 2021 17:27:49 +0000
Message-ID: <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
 <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210517130815.GC62656@C02TD0UTHF1T.local>
In-Reply-To: <20210517130815.GC62656@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64b36f6f-5fad-4b61-b0f2-4e651fd5b71c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-17T16:41:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4c8c0b7-4477-4a47-d9b7-08d919591817
x-ms-traffictypediagnostic: MW2PR2101MB0937:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09379183DD429C2A0CB18931D72D9@MW2PR2101MB0937.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jgk65DRhWgHTNukWkW1I8uSLHJaabsPeBM7XiA8Cci0WrPQ8Pmgy53BcTUcIVxH7IjSeP6Aim4Bn2UHXCwLLTOrKUGDZXY8/KukjCOczPZ4+AaxoeT/z65jf75tP4+60/bl0ZslewRnsjrfao5rnxlWEGT01VdJFeCbo17vwHEKZf1gss2JgD4zH40A5MOIOlnZrZsnnMWy44TbidMIhPK4ozU5bKNicb4gyedpk9jwy4AyT43VLZM5oszH4l0WZpK5QIieWmizISKVp+AYyLno6DWKdZ7X4cH1PfVyVOg6J7NJ84EUr2kCm5sUhLHZrqWqNPoRZkq1KEYNMzxGVSOaBwj9pyPTQBTj+z3fBtp8GVv9HETJtq4UP8ssv+VfYSw0rZWC6liVkR/jovcWK3zbLivYJs0YRGfpOkSqw2OE/08XPe6OposTMkLowCW/GNOomxJYZJxlc+sRDW4qLbBJFarOENlC5LHCrGQMEfCVixM6l+bCPgeE5Iz4Djl3z0avsPCYgjY2H0ApQphLDF1HT8HzV66KMzu4ImWOj5+QE5SuVT1GVQ2fETkdResB+CjWJCyCbaCW/6ua+fFQt7Bu0Yg8ydZCW/0y7C9STVLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(71200400001)(66446008)(64756008)(6506007)(107886003)(82950400001)(82960400001)(33656002)(6916009)(5660300002)(26005)(83380400001)(7416002)(8676002)(66946007)(66556008)(66476007)(8990500004)(76116006)(478600001)(54906003)(122000001)(316002)(2906002)(8936002)(38100700002)(86362001)(55016002)(4326008)(9686003)(52536014)(10290500003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PVczhLqXU75nVfDMi/t+uU7EnwM3120bTvSnplcPK8m8c8ozS3o9HN+k/l7?=
 =?us-ascii?Q?Fa2zQeOFdPKhaqP+qskRpKR1m03hAeb4As4FK1/qLNp6hcSalaJDM8VXeWIC?=
 =?us-ascii?Q?8OkWUOjWQPeG5wOn4D2NisaQ+NedBKOHjn36EiW0SheD3hh9wy1SkCxyt4oE?=
 =?us-ascii?Q?GvhB18DsmhI0sn7VS4/5qB9FWPDRz60zrhl5qq1077L/QRf2Gr4LG8WmbHjU?=
 =?us-ascii?Q?zWKE28o0kKb378oMPcpCUURcKhTidSO4PBUFPk5xbLWBMVmXqwwQMdHSfgpg?=
 =?us-ascii?Q?N9E5acSy0lT6Zky5dnjIQXBw2vS8AvWMwvt8U4Vsot+uQ3ZyhqTczUO8fmdl?=
 =?us-ascii?Q?yHwG7Bkjl/Dnbo6Xbj8ay9RS2JAyh+Zd4Zv1xqrrLSDwKtdvRnmgUDi9Few+?=
 =?us-ascii?Q?4sCzwRgSVAAIOVSme0UoKk2aJq5NKgUK3eSn2WUUVGeJFy/zgYk6VpOU0+iO?=
 =?us-ascii?Q?XuBwBdjk2XlEEJArD6jMScc1VgbSK4aaFGikENyVVwFBCW9I+gOijXwzWWV/?=
 =?us-ascii?Q?DANBkxNe1p8ilaqRdkBqzGR2G3CF94193ROChYzRrmxCuT4bOw+TAAAQOPiJ?=
 =?us-ascii?Q?5TI1l/oGHok/nbBetsChoiDy1Go15iwHl/DhpdIBP536o5OJTeFcynBMdIRe?=
 =?us-ascii?Q?SLYnv1SFxOPhY9jTorESPXsQrHU4Mjmi9E4gysQtZce5hiYWkzC4qr3PyvnY?=
 =?us-ascii?Q?LJljzONs/pBR8rON2WRhNdazkRpLWoevpPusAIsvy/DGbjDtGC5sKPEu+wkb?=
 =?us-ascii?Q?/DeD29o66Cr9ghSqAwxLMiBkN7q90ExZc3N9FmhDQInINJvzktD+bj/UtLew?=
 =?us-ascii?Q?H9t8gKgd/iOTEobdOgZzlkEr6KJ8YiY4NDt6GvGJ3+2AkxT1NsKggU5Hyvre?=
 =?us-ascii?Q?IySEGDWgVQQccVt655aFlNE0YkGyGgJZB4zKNJVspG/RcZazgcKXhOIL81/Y?=
 =?us-ascii?Q?EeewNKzi6EEDgc49GC4Ltso38lG22BBRO6dZYOgU?=
x-ms-exchange-antispam-messagedata-1: ADcDrtwkxpSD/Ud6ECDedgRpWXcYi3/pqdUkMfkyfO7DElqZoo32kl227+kH9udkccwHZHV2eipG5tAMX3bjjdBVMrgXY2yaPmHmx2HP3JlD6TEIlGPDj9Wl1tn9d2NezIiSgnFNn//pGlU7Yv3W9GYxKWoKyn1Ar6hiEGFdXH7rR3Ghdgf3+qjq8tmflGCnFN25JvYuv3XdiSPsng3MQiwNCg0olxzFBP9hC7NTcoKX63y7gZ4QF2Djticw7yRcjNjazeEMWjOFma6FLYGLTaAGtzg1FRgxA0rMcCqwGVe0DoTgl4ZpDtRhCn10x1FlfzV7YxTuq8BUOPBpgKtm00Ee
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c8c0b7-4477-4a47-d9b7-08d919591817
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 17:27:49.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkGNcDQ0njV0GhWcruLAL70CHC/Fyio/yHr8iONqZTeaSmJ0pN2lzMY37oRnhAA+hiGR48kEGsfkctpvi1gZfXX9pqYsXg1721sQzrXT0f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0937
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Monday, May 17, 2021 6:08 A=
M
>=20
> On Fri, May 14, 2021 at 03:35:15PM +0000, Michael Kelley wrote:
> > From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 2021 5:=
37 AM
> > > On Wed, May 12, 2021 at 10:37:43AM -0700, Michael Kelley wrote:
> > > > Add architecture specific definitions and functions needed
> > > > by the architecture independent Hyper-V clocksource driver.
> > > > Update the Hyper-V clocksource driver to be initialized
> > > > on ARM64.
> > >
> > > Previously we've said that for a clocksource we must use the architec=
ted
> > > counter, since that's necessary for things like the VDSO to work
> > > correctly and efficiently.
> > >
> > > Given that, I'm a bit confused that we're registering a per-cpu
> > > clocksource that is in part based on the architected counter. Likewis=
e,
> > > I don't entirely follow why it's necessary to PV the clock_event_devi=
ce.
> > >
> > > Are the architected counter and timer reliable without this PV
> > > infrastructure? Why do we need to PV either of those?
> > >
> > > Thanks,
> > > Mark.
> >
> > For the clocksource, we have a requirement to live migrate VMs
> > between Hyper-V hosts running on hardware that may have different
> > arch counter frequencies (it's not conformant to the ARM v8.6 1 GHz
> > requirement).  The Hyper-V virtualization does scaling to handle the
> > frequency difference.  And yes, there's a tradeoff with vDSO not
> > working, though we have an out-of-tree vDSO implementation that
> > we can use when necessary.
>=20
> Just to be clear, the vDSO is *one example* of something that won't
> function correctly. More generally, because this undermines core
> architectural guarantees, it requires more invasive changes (e.g. we'd
> have to weaken the sanity checks, and not use the counter in things like
> kexec paths), impacts any architectural features tied to the generic
> timer/counter (e.g. the event stream, SPE and tracing, future features),
> and means that other SW (e.g. bootloaders and other EFI applications)
> are unlikley to function correctly in this environment.
>=20
> I am very much not keen on trying to PV this.
>=20
> What does the guest see when it reads CNTFRQ_EL0? Does this match the
> real HW value (and can this change over time)? Or is this entirely
> synthetic?
>=20
> What do the ACPI tables look like in the guest? Is there a GTDT table at
> all?
>=20
> How does the counter event stream behave?
>=20
> Are there other architectural features which Hyper-V does not implement
> for a guest?
>=20
> Is there anything else that may change across a migration? e.g. MIDR?
> MPIDR? Any of the ID registers?

The ARMv8 architectural system counter and associated registers are visible
and functional in a VM on Hyper-V.   The "arch_sys_counter" clocksource is
instantiated by the arm_arch_timer.c driver based on the GTDT in the guest,
and a Linux guest on Hyper-V runs fine with this clocksource.  Low level co=
de
like bootloaders and EFI applications work normally.

The Hyper-V virtualization provides another Linux clocksource that is an
overlay on the arch counter and that provides time consistency across a liv=
e
migration. Live migration of ARM64 VMs on Hyper-V is not functional today,
but the Hyper-V team believes they can make it functional.  I have not
explored with them the live migration implications of things beyond time
consistency, like event streams, CNTFRQ_EL0, MIDR/MPIDR, etc.

Would a summary of your point be that live migration across hardware
with different arch counter frequencies is likely to not be possible with
100% fidelity because of these other dependencies on the arch counter
frequency?  (hence the fixed 1 GHz frequency in ARM v8.6)

>=20
> > For clockevents, the only timer interrupt that Hyper-V provides
> > in a guest VM is its virtualized "STIMER" interrupt.  There's no
> > virtualization of the ARM arch timer in the guest.
>=20
> I think that is rather unfortunate, given it's a core architectural
> feature. Is it just the interrupt that's missing? i.e. does all the
> PE-local functionality behave as the architecture requires?

Right off the bat, I don't know about timer-related PE-local
functionality as it's not exercised in a Linux VM on Hyper-V that is
using STIMER-based clockevents.  I'll explore with the Hyper-V
team.  My impression is that enabling the ARM arch timer in a
guest VM is more work for Hyper-V than just wiring up an
interrupt.

Michael

>=20
> Thanks,
> Mark.
>=20
> >
> > > >
> > > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > > Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > > ---
> > > >  arch/arm64/include/asm/mshyperv.h  | 12 ++++++++++++
> > > >  drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
> > > >  2 files changed, 26 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> > > > index c448704..b17299c 100644
> > > > --- a/arch/arm64/include/asm/mshyperv.h
> > > > +++ b/arch/arm64/include/asm/mshyperv.h
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/types.h>
> > > >  #include <linux/arm-smccc.h>
> > > >  #include <asm/hyperv-tlfs.h>
> > > > +#include <clocksource/arm_arch_timer.h>
> > > >
> > > >  /*
> > > >   * Declare calls to get and set Hyper-V VP register values on ARM6=
4, which
> > > > @@ -41,6 +42,17 @@ static inline u64 hv_get_register(unsigned int r=
eg)
> > > >  	return hv_get_vpreg(reg);
> > > >  }
> > > >
> > > > +/* Define the interrupt ID used by STIMER0 Direct Mode interrupts.=
 This
> > > > + * value can't come from ACPI tables because it is needed before t=
he
> > > > + * Linux ACPI subsystem is initialized.
> > > > + */
> > > > +#define HYPERV_STIMER0_VECTOR	31
> > > > +
> > > > +static inline u64 hv_get_raw_timer(void)
> > > > +{
> > > > +	return arch_timer_read_counter();
> > > > +}
> > > > +
> > > >  /* SMCCC hypercall parameters */
> > > >  #define HV_SMCCC_FUNC_NUMBER	1
> > > >  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> > > > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksour=
ce/hyperv_timer.c
> > > > index 977fd05..270ad9c 100644
> > > > --- a/drivers/clocksource/hyperv_timer.c
> > > > +++ b/drivers/clocksource/hyperv_timer.c
> > > > @@ -569,3 +569,17 @@ void __init hv_init_clocksource(void)
> > > >  	hv_setup_sched_clock(read_hv_sched_clock_msr);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(hv_init_clocksource);
> > > > +
> > > > +/* Initialize everything on ARM64 */
> > > > +static int __init hyperv_timer_init(struct acpi_table_header *tabl=
e)
> > > > +{
> > > > +	if (!hv_is_hyperv_initialized())
> > > > +		return -EINVAL;
> > > > +
> > > > +	hv_init_clocksource();
> > > > +	if (hv_stimer_alloc(true))
> > > > +		return -EINVAL;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_timer_init);
> > > > --
> > > > 1.8.3.1
> > > >
