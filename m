Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E0939FAF1
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhFHPiB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 11:38:01 -0400
Received: from mail-dm6nam11on2128.outbound.protection.outlook.com ([40.107.223.128]:40504
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231338AbhFHPiB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 11:38:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2g9lLn4jwpRF+iKTx1iLe4n7sOspHkxPKYghYs3JgxNMLjeeBHzULHIbeU2V0ZvivjgF1l8oReFNPr+vJyfYpvMuAfdbYxooZUMbkF0zxojYO79+eaU/3y7mRAl/gYxmUwxrwq2D/9DyF0QwLxotokTiNEi4hv9aYZKbuKCL6EZCLoQnTFJS0NJLtQ+frqwt5NHVjoMFWjOQ5pgGkQjm231yNX1iOav9AGoY/OnkP6WKwEw0FTTOClkG+vFjR1MQyI18mpx6wnNQvmbE4UsPMo2pUkkuac4Nh33Mcr6Uudhs5tImy/mmuRKfkTAV7ccWM1ZF+mnV4VXFcJwAzvg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hfh2KfZ5IwRVSdfFpzix9BMUF5h7XFADDc4+2UYD+I0=;
 b=VdKppN4XQpYxGUGb0lQY7wSMKk8ay0wB1zgC4JmsjTXP9p0qrp2j7qn6yDnz5rSd6lEDUkoKy/oqVpYTQUyHhA0UeqBqIVluR0c7VICZGW0g0LvhKI+PwOw40scpesFxeGpxwsRJu6OZoNGSU/xke0VzTK4Ifcw0yA5LGiY+KPMYre+wVkORCu3fQ5WfhZ8PE9qePLQQBZibXjSIRIPJwem7wO1y5KD/YcemGLIFAfVJPCL3DM/q237p9Uow0Jap1CUv4SyF6dNhrsjL/+URiXHrcmW3CxqwYHvIKNqV1m/8VX0N0ZUhNMWjPtLV/uOZKL5xDdngoBHNbAdcs56l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hfh2KfZ5IwRVSdfFpzix9BMUF5h7XFADDc4+2UYD+I0=;
 b=d+uBv7ydE/ucKCYkw7CkgnQyDVilQXCISSjj8x9RRPNEvnKjlB2MfpDyP5grgfXkTeNBEwBnUVNJDEb8w0bxgFEfNBKQ7FDCw96lNr6AkUMtYDNLVAD42BFzZPahemNaFSbtr2VrXQUxlhlyvBnPKk3+z41RQPGU65Pak+Rga0o=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2057.namprd21.prod.outlook.com (2603:10b6:303:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.7; Tue, 8 Jun
 2021 15:36:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2%9]) with mapi id 15.20.4242.007; Tue, 8 Jun 2021
 15:36:06 +0000
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
Thread-Index: AQHXR1WfRNuOt4THnkSQtAriU3aWFKri7Q2AgAAsnCCABJMQgIAAO7hQgAGXcACAIOKsoA==
Date:   Tue, 8 Jun 2021 15:36:06 +0000
Message-ID: <MWHPR21MB1593800A20B55626ACE6A844D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
 <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210517130815.GC62656@C02TD0UTHF1T.local>
 <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210518170016.GP82842@C02TD0UTHF1T.local>
In-Reply-To: <20210518170016.GP82842@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=75fcf65e-e61f-4d86-b22d-66fb3a29e44d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-08T15:11:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d8ac072-4838-4f3f-f944-08d92a9321a7
x-ms-traffictypediagnostic: MW4PR21MB2057:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB2057E8D82544B6033EB03CEAD7379@MW4PR21MB2057.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtmZSHm9GRDZX7YscFvENR+Fg5G/xDxid318kaZS1XR4H6LYIiiwn7PYWro2PdD4DCp7BLxBsxBX49wnddA+NDTuQBWJMnKJFmS+H3Oi+yNYzBvS8lWpR75I2M6MZerMgA7cLdAOrGh+SU0bk8Ve+dBsA+qYIAWuPl0pJRldjgA1Kx1On7rSoTqG8Mq9vOk9UyCwevFUNHx5D5RHKUsIp1RsP6lTsQtl9i+8m4G4al6tYPmyTCCIzRBMNaxE0w0ExzjpVBFLjUbWTWeNE8QdnTwDQ4J88196+ywEK/NEHj3Trp6KCGXp4a3TpL6NvnOX9gSIJmw6YfoaCFwfOqn7tqtpLUZbG8TrzEPe1egFo4IEcDXHySHF30YeS5tyrYVJFHOWe9VMP3R8TcdP8XIjIkRoqQtOUDEfoGZsvKmFChJolWUm8agcEmJ6YqOpaHPXP7hdsIsoMHZugrS7UaqQhHRcovnoUvomHIOJtfI7380iUA2NP1D1q1RluosxNQDIy/2lRY7NPA6O/qzc/WWoQgEm4ZkH7levsFBb7176FteamZhEUiYwYu905yVjt/zW1w47HU5AkdcsxteRRqnCmvjIbezAc45f27lSR4ayJ/thL61F2d1SMK9MGr2daZ4/RfnVFeOMUImdPqLepC+N+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(7696005)(82950400001)(82960400001)(122000001)(86362001)(107886003)(478600001)(38100700002)(7416002)(83380400001)(55016002)(9686003)(71200400001)(4326008)(8676002)(26005)(8936002)(6506007)(76116006)(316002)(66946007)(52536014)(8990500004)(6916009)(64756008)(186003)(66446008)(66556008)(66476007)(2906002)(54906003)(10290500003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xbcymaWUdo41kYE25iBm3//n2uFyNW0R4/fR9dVuH4+ZTfOWzey+PRm+gY1L?=
 =?us-ascii?Q?5mPLy1eeUXnU+9oADh21u3rpu0//QVcdxfuARlA66jsKHPHojV3nk7wN8FGE?=
 =?us-ascii?Q?L/6YY/IOic5tRqX0YyABLzvtlVsDugtSLy90Dy71gereQ3BSnWcQlhxc0pbE?=
 =?us-ascii?Q?mi+JLw3EXsWgdjuatu5ALKEa7a1tf+upCxNakWNhHayVJe3sxMycYWF5MPuk?=
 =?us-ascii?Q?Kn3IPUQ1sP/agB0A9yTtb3/91ElEMiz88fxuvEKjzEHq4pVCVtcbsemD7mWT?=
 =?us-ascii?Q?XnNKnc/ReVDUimcPUpfNxNc1z4QIHUzgAG4bQVQV1Q58aSod37pkZ7ToY9/u?=
 =?us-ascii?Q?FuuvU4TQntmprREbvb01hC+M3pkHfSGu/CD57wVOUlrEPNkTpSc4SC3RB8uZ?=
 =?us-ascii?Q?FebY/AW0ADFYUNemzISx/5iwfejBT7kKxxwJG1GzRZiqiO9uVJ91wjpSwE0n?=
 =?us-ascii?Q?NcEUvlS89ZOpxCs8wiE+96QPzwAWjJqmkL25CTTQocj9W+9X9v/qyQ339a+J?=
 =?us-ascii?Q?uiUDxBFNQyGbWYJrnLV3ZP9IBXTzT9cyVGDS93RzqSmAmMdHVxwlkDVJkCLC?=
 =?us-ascii?Q?cUN3mVnCyewRWTvAVGJkbnm/0Uq58qhBVGC6UhAX8zOSeO0AJINrOnSSaxqv?=
 =?us-ascii?Q?3HFOPsKTp4g+5l7DOE8ndIfFqB2ykk1uwAHk4q1B+SmC3RkPriWS3WZV9bd1?=
 =?us-ascii?Q?EPHCfeFx6XIVCT/GjsKPh2AYRJtkFu4jKzKZlCPbowtlNBsub3UG3QV0V6+4?=
 =?us-ascii?Q?qC/fUmhvEd/HIbiH+Mt2Eft0EdNdS9JOIflNz/3l9A4LSxiuALeSQ0Jan1dS?=
 =?us-ascii?Q?LcXIDtiMVwxPfMzrc4p0ltQUgv0/jKQrIhu7PzhqhXrFwnfWmWRpAXr0QE/D?=
 =?us-ascii?Q?W4dX7NeOH+J5t2p2DFj9nDoEXtK5MW/d0LJTqL1PWX7RbPAwk7bGQVTVr78J?=
 =?us-ascii?Q?hp7IqikEQcfgSDxHDKgK0eavbUa04wwUoa5cBpRzN03sDRIqmHDp6Zk2Uv68?=
 =?us-ascii?Q?0zDiaCXmDeZXEWB3dMfpBlsg++RhYbmDEeEW72eoDQueucZypptwG2p4kzMI?=
 =?us-ascii?Q?Kl7l5FAJCef3UHiD3ZhwHtliY2+gsFu9ESV9SCFfjZa8VXwMnp/4UuaaQZO3?=
 =?us-ascii?Q?JTs7izozd2TRkbGUUL1JvUbCBLWwMiM3i2sosBA3mkcmDFhsU0HpJMWK9JcF?=
 =?us-ascii?Q?QUoEH3RYntJifW/lGYh8ATSQT9WlmWoTmcebkORXBMmtAduLjF4bUmoBCoAK?=
 =?us-ascii?Q?vJTA/wQhyMptFSwflR1wHtHbOZgbaLRMsHKQE0gJQSxoE1J3v1Te4QsU0K1O?=
 =?us-ascii?Q?VJ4U4oZ6jlcM5U6Y4zPxOcx8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8ac072-4838-4f3f-f944-08d92a9321a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 15:36:06.1931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JxWTEiQeaTRSQi1HBnMytuCTy2q1fNBAPz/NONlIlbfqhlOIa2iTmRLeVNT4Jgno1nQWoBINRzyoP6uwCqsIAtzFv5vm0qpjc/2lRi04zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2057
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Tuesday, May 18, 2021 10:00=
 AM
>=20
> On Mon, May 17, 2021 at 05:27:49PM +0000, Michael Kelley wrote:
> > From: Mark Rutland <mark.rutland@arm.com> Sent: Monday, May 17, 2021 6:=
08 AM
> > >
> > > On Fri, May 14, 2021 at 03:35:15PM +0000, Michael Kelley wrote:
> > > > From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 202=
1 5:37 AM
> > > > > On Wed, May 12, 2021 at 10:37:43AM -0700, Michael Kelley wrote:
> > > > > > Add architecture specific definitions and functions needed
> > > > > > by the architecture independent Hyper-V clocksource driver.
> > > > > > Update the Hyper-V clocksource driver to be initialized
> > > > > > on ARM64.
> > > > >
> > > > > Previously we've said that for a clocksource we must use the arch=
itected
> > > > > counter, since that's necessary for things like the VDSO to work
> > > > > correctly and efficiently.
> > > > >
> > > > > Given that, I'm a bit confused that we're registering a per-cpu
> > > > > clocksource that is in part based on the architected counter. Lik=
ewise,
> > > > > I don't entirely follow why it's necessary to PV the clock_event_=
device.
> > > > >
> > > > > Are the architected counter and timer reliable without this PV
> > > > > infrastructure? Why do we need to PV either of those?
> > > > >
> > > > > Thanks,
> > > > > Mark.
> > > >
> > > > For the clocksource, we have a requirement to live migrate VMs
> > > > between Hyper-V hosts running on hardware that may have different
> > > > arch counter frequencies (it's not conformant to the ARM v8.6 1 GHz
> > > > requirement).  The Hyper-V virtualization does scaling to handle th=
e
> > > > frequency difference.  And yes, there's a tradeoff with vDSO not
> > > > working, though we have an out-of-tree vDSO implementation that
> > > > we can use when necessary.
> > >
> > > Just to be clear, the vDSO is *one example* of something that won't
> > > function correctly. More generally, because this undermines core
> > > architectural guarantees, it requires more invasive changes (e.g. we'=
d
> > > have to weaken the sanity checks, and not use the counter in things l=
ike
> > > kexec paths), impacts any architectural features tied to the generic
> > > timer/counter (e.g. the event stream, SPE and tracing, future feature=
s),
> > > and means that other SW (e.g. bootloaders and other EFI applications)
> > > are unlikley to function correctly in this environment.
> > >
> > > I am very much not keen on trying to PV this.
> > >
> > > What does the guest see when it reads CNTFRQ_EL0? Does this match the
> > > real HW value (and can this change over time)? Or is this entirely
> > > synthetic?
> > >
> > > What do the ACPI tables look like in the guest? Is there a GTDT table=
 at
> > > all?
> > >
> > > How does the counter event stream behave?
> > >
> > > Are there other architectural features which Hyper-V does not impleme=
nt
> > > for a guest?
> > >
> > > Is there anything else that may change across a migration? e.g. MIDR?
> > > MPIDR? Any of the ID registers?
> >
> > The ARMv8 architectural system counter and associated registers are vis=
ible
> > and functional in a VM on Hyper-V.   The "arch_sys_counter" clocksource=
 is
> > instantiated by the arm_arch_timer.c driver based on the GTDT in the gu=
est,
> > and a Linux guest on Hyper-V runs fine with this clocksource.  Low leve=
l code
> > like bootloaders and EFI applications work normally.
>=20
> That's good to hear!
>=20
> One potential issue worth noting is that as those pieces of software are
> unlikely to handle counter frequency changes reliably, and so may not
> behave correctly if live-migrated.
>=20
> > The Hyper-V virtualization provides another Linux clocksource that is a=
n
> > overlay on the arch counter and that provides time consistency across a=
 live
> > migration. Live migration of ARM64 VMs on Hyper-V is not functional tod=
ay,
> > but the Hyper-V team believes they can make it functional.  I have not
> > explored with them the live migration implications of things beyond tim=
e
> > consistency, like event streams, CNTFRQ_EL0, MIDR/MPIDR, etc.
> >
> > Would a summary of your point be that live migration across hardware
> > with different arch counter frequencies is likely to not be possible wi=
th
> > 100% fidelity because of these other dependencies on the arch counter
> > frequency?  (hence the fixed 1 GHz frequency in ARM v8.6)
>=20
> Yes.
>=20
> In addition, there are a larger set of things necessarily exposed to VMs
> that mean that live migration isn't all that practical except betweenm
> identical machines (where the counter frequency should be identical),
> and the timer frequency might just be the canary in the coalmine. For
> example, the cache properties enumerated in CTR_EL0 cannot necessarily
> be emulated on another machine.
>=20
> > > > For clockevents, the only timer interrupt that Hyper-V provides
> > > > in a guest VM is its virtualized "STIMER" interrupt.  There's no
> > > > virtualization of the ARM arch timer in the guest.
> > >
> > > I think that is rather unfortunate, given it's a core architectural
> > > feature. Is it just the interrupt that's missing? i.e. does all the
> > > PE-local functionality behave as the architecture requires?
> >
> > Right off the bat, I don't know about timer-related PE-local
> > functionality as it's not exercised in a Linux VM on Hyper-V that is
> > using STIMER-based clockevents.  I'll explore with the Hyper-V
> > team.  My impression is that enabling the ARM arch timer in a
> > guest VM is more work for Hyper-V than just wiring up an
> > interrupt.
>=20
> Thanks for chasing this up!
>=20

I've had a couple rounds of discussions with the Hyper-V team.   For
the clocksource we've agreed to table the live migration discussion, and
I'll resubmit the code so that arm_arch_timer.c provides the
standard arch_sys_counter clocksource.  As noted previously, this just
works for a Hyper-V guest.  The live migration discussion may come
back later after a deeper investigation by Hyper-V.

For clockevents, there's not a near term fix.  It's more than just plumbing
an interrupt for Hyper-V to virtualize the ARM64 arch timer in a guest VM.
From their perspective there's also benefit in having a timer abstraction
that's independent of the architecture, and in the Linux guest, the STIMER
code is common across x86/x64 and ARM64.  It follows the standard Linux
clockevents model, as it should. The code is already in use in out-of-tree
builds in the Linux VMs included in Windows 10 on ARM64 as part of the
so-called "Windows Subsystem for Linux".

So I'm hoping we can get this core support for ARM64 guests on Hyper-V
into upstream using the existing STIMER support.  At some point, Hyper-V
will do the virtualization of the ARM64 arch timer, but we don't want to
have to stay out-of-tree until after that happens.

Thoughts?

Michael
