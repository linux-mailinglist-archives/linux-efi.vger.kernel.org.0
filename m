Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB53B5731
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhF1CYF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Jun 2021 22:24:05 -0400
Received: from mail-oln040093003009.outbound.protection.outlook.com ([40.93.3.9]:40338
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231678AbhF1CYE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Jun 2021 22:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiyYzpvQMUFgZtmM/7FJOOEYpkO6zDcQw2ufQJdVwcNyNp4BbeqiuOyFVnIhzuRNUx18r349xc1Wv/32h9YTeIcEAe/niZmsabgM2naoY43181ubT2iZY0Z8l0Zy77YQDpasAxq/6Mss6ZhdbZTnWluLqfKI2j//PjW4qRrT2nxY+RK0+eaoDqPbTdGexQPorAxUewYp1YTGADy/tHtA3DpRDHpMt3+Dj4kqjSmArbuTINfvzcnAqdZYXG6FUU8fNyZlj9ylz/r6nieFbGGt9X+YO01swJe7WmHL8cV80v01GkGibqHdvnO1baFBU4oMXuPkMcOOeCEyA2XX1Abu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKj0UgAtA/6i1KiacCxWBSbs0E+bp6hqwehXMz7uJdI=;
 b=BFbyMniLPxolbdtiq9c1WFVETrLElwM95O2VIWMH1byK3CWM/N0kgjZ0Mm1HzKtcTdM9rqTN8KjOnDCjBn4OM2DdvvyYhPOkT64jV1mK/kz83G7sMIW3ym5ey1Hiuu/ZKnGpqRT1tM7lwtMRB1Nb40E8HmLk2BWUrIqzFbaDkF+P3HuU8e4KzTriVNhzpmLoeVaDKyAUGeimLwJ8YxuaYtxf/8dWBqNnIbtbnHoqHN8eZVlLIfBzWFSCW5Sk5iu2q51Dn5HL5CLE8ECnkyGDNcUi3hpYxt1QICWNiw0Ii8TQgrvqf/2pd8l1Uc+csb2wpSrDlAtOJ9OMDWsPAbm0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKj0UgAtA/6i1KiacCxWBSbs0E+bp6hqwehXMz7uJdI=;
 b=c9IMKiKGb40nFNFTYlJvYBlPeC40yQXXy0I3UFuStGXfId3xSPn5ZZVMScQ/6sbZmjQ6XqpGzQ3Tu8nk8wtsmjpGJkQxlVC42At7tjYCO4mi7H0e22Jatu+yge9uLQA/qF5sTxURFzazi5OO6lDTKoQnmzCEgQtGFbuVM9uDTDQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1986.namprd21.prod.outlook.com (2603:10b6:303:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.5; Mon, 28 Jun
 2021 02:21:29 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07%6]) with mapi id 15.20.4308.006; Mon, 28 Jun 2021
 02:21:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
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
Thread-Index: AQHXR1WfRNuOt4THnkSQtAriU3aWFKri7Q2AgAAsnCCABJMQgIAAO7hQgAGXcACAIOKsoIADPsaAgAVVr2CADRNtAIABghcAgAcpprA=
Date:   Mon, 28 Jun 2021 02:21:28 +0000
Message-ID: <MWHPR21MB159396AA55E2270FD4BC4EECD7039@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
        <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
        <20210514123711.GB30645@C02TD0UTHF1T.local>
        <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
        <20210517130815.GC62656@C02TD0UTHF1T.local>
        <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
        <20210518170016.GP82842@C02TD0UTHF1T.local>
        <MWHPR21MB1593800A20B55626ACE6A844D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
        <20210610164519.GB63335@C02TD0UTHF1T.local>
        <MWHPR21MB1593095A9B8B61B14D7DF08DD7319@MWHPR21MB1593.namprd21.prod.outlook.com>
        <20210622095412.GC67232@C02TD0UTHF1T.local>
 <87pmwdariz.wl-maz@kernel.org>
In-Reply-To: <87pmwdariz.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6abc58bd-18e3-4979-bf8b-30ea663433f0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-27T22:18:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac38fc1-116e-4791-f5c2-08d939db7023
x-ms-traffictypediagnostic: MW4PR21MB1986:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1986BEAED0F3F37799D89B4FD7039@MW4PR21MB1986.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUV/oST/w1nu39xbhuy1knqBAbm1WIE1BC6yOh9/X2IUmb6QnVTGraqdGPbayV03gfZHAT64Afl8vG+pwPjRzW+QBiQWoi+V0wEJWaoBpvfhqt8QcyyUAkAkl5EK0SROGBD3CtsvZI6QJOsbnCCFX/SMN7pzN2V6yymXI1pySOA0rgCJ3ZVHG89shQIN7NT+APvpHeyida9dNQwKGfmYn9myOO3hL6tAHkHtJmQ7w2HqC7TWAgD2lq+cuuVE/UmjlC1ahHz0S6Ao27B30GhQjRnT6aAG/EaiLj/NtQQIjRApJokayaViGOgF95TY9C6y20mL0oE7j7ArrjvVnx9Y+U/3DGngkp5OB3iMeadwz0x53dghfVN6HZR14mKL4ZPHjBLFJXtVlj2qWa02a/KVH3aSiAR/2jGnU23N4i8AA+w2cN+SozmIJkuEGkPHbpDpTxEgf0+8p1GhNhCD858CBm39JQRO7xB5N6yEXKbaiDXGwLeBTRvpixUaNLR/E0uxenJpEekvIYP6Lci6FNqU9PVH0+P6U9uAtly/TALcwN0qeu0m6sQ3F67FU2UvBwNJUA9JN0Rtm3OjeBcu23CVLhx8TZsV7z2bB67HyhbUE1KYfkNbq3kWZ++1BabXdWLoG9TpUFdvYFVJHTzqUR2nsom63xSQeY77VsDfzTxZm5667O+T38ABwZu/KNLSyo6H9bQRvnR3p8CXqI6paOhZ5/9KzPNSfki4ZkIFjjVHhpGgFDFbeWZjMTtbClfr9i1rhwQdlB1j6e7cTkR2A10ECg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(8676002)(7696005)(186003)(107886003)(55016002)(26005)(83380400001)(82960400001)(8936002)(82950400001)(9686003)(86362001)(5660300002)(64756008)(2906002)(38100700002)(76116006)(7416002)(10290500003)(316002)(478600001)(66556008)(122000001)(966005)(66446008)(54906003)(110136005)(66476007)(66946007)(8990500004)(4326008)(71200400001)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KUsssJ6fznyE0qg/uN9AEGWe3igCE/iIH4WNFOfAAdQ5X8ytKdc9aaCOgzl+?=
 =?us-ascii?Q?VLzQZVwSipKYQGsKSD+xcoHET576p29IN3Bk2LE8CsJrln0VH5ZTHMAQLMY6?=
 =?us-ascii?Q?VdrlWBTIg6O0AUhw3FTATgdbg2g+ampc2WTQ99yo1QVZyG0FzPFz7KmlGs6w?=
 =?us-ascii?Q?AX0cnfMZnl1kYWVQFHb3M4ThCt+lKiNNZQPPNNP1NZ3jQy2hm2CwCS6VMGut?=
 =?us-ascii?Q?pjNS4rn7jL4BFT/uee79CTjatwWwWmrVOyMIKM+oi2cvA4nzpPxOUDCFM9FP?=
 =?us-ascii?Q?TCDrhdnZ4YX0Ea5nchGBSEadSNLPjKvaC7yQqfK8Y6LEHOFQX6gdlaPGun6E?=
 =?us-ascii?Q?U+9KnUUZyWWjdjbrJPxLQdtRdcRbCmtvLNIkHH97THMRCi3Jon6JKkmBBhPD?=
 =?us-ascii?Q?KoykT9DOxFq2ONEIsxFV1L3HNPF8H/PrlodVCl5RY+9QFLvo35XaUN1sdvYv?=
 =?us-ascii?Q?jBcYZUgw0mk4hBJ9zSOpqEIz7zqE6+GPz1Zb3EoGE6yyhJ4sizx3XPcCaVhj?=
 =?us-ascii?Q?Hx8ddrhOxtAYEDeuS6IStMumMe5A+k2295kjzreiitEuyd0GYz0W6G/L2Pte?=
 =?us-ascii?Q?KHZj8p+orKuzoTlaoNRaFOi9MnETznWeDYhwwwQVrtQw/VSkBxhkwI/kXz+T?=
 =?us-ascii?Q?/DZiAy2YFf53JPa4DiTsEIQfE7+ukz5fsqHP8pcXjG0qH0YE59dxvzu0l30R?=
 =?us-ascii?Q?9bqD02thKUiU5iyiLosf/iQmnYRxIK8fmWSREtIf9YpH4lpYNfswgDMLuo+j?=
 =?us-ascii?Q?meAXT6EO1cJ0aRLQB4hQrvjFdYCtL2iKAZ60xJuv9oJnDZ4KuGdlFKtMgVVG?=
 =?us-ascii?Q?GZOCK+fvm1ZLWmgtCVObLWKARH19w0KIIT1moK6Xksmo01p+Wma25dYyWbFS?=
 =?us-ascii?Q?OuGJgqo4mug+cdajwypMejrkk3NMgwtjXzsMwC1D9MhL97vT/JggfsHYU72m?=
 =?us-ascii?Q?kCr/ZCtBADAYPuChMGi0Kmp/DiR8AwERvkWNK+p3UhwbE1CizQX1CYXmcmgM?=
 =?us-ascii?Q?9YGLSWtf/0fNNsCYyL9mZVz9sTOnDq+ME1N7Pm9tcXSFq4wPGuX0DPkRMxLk?=
 =?us-ascii?Q?Wj9eqGs1pNNdzAG9V7yL/VvJH1FTVw/bhZtaNtKGkMSx8AK3nfXq46XcknH/?=
 =?us-ascii?Q?02TBnJuLhn+78lUCYxngsYMA+zOq2kZaiq8KYpJGoFQ1vMjUH2y2BNv7xbQD?=
 =?us-ascii?Q?b3VlcQLIQjTXJ65ERjXKcXueLPVcjKGtr/mCHTYnDMo072iYGuj4TVuQwOyD?=
 =?us-ascii?Q?r2KOH0hRAPOgRHDdkW+Ti538bjKukRzddnmiKZent1M+siA4lA/N+pPbWj1x?=
 =?us-ascii?Q?Ej5rzxQHwREG69t3dWoIPjkj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac38fc1-116e-4791-f5c2-08d939db7023
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 02:21:29.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aa/HdXWxFq+JThPQ1HzH7UM4KYHFqDlaQMW9AObUUefmWKNACbLWKaE8Em3A6WWEhGJC3VVT6HgAvHS1WgCbz8bV4T8ekEcmFSoVxt8EFrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1986
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Marc Zyngier <maz@kernel.org> Sent: Wednesday, June 23, 2021 1:56 AM
>=20
> On Tue, 22 Jun 2021 10:54:12 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Michael,
> >
> > Thanks for all this; comments inline below. I've added Marc Zyngier, wh=
o
> > co-maintains the architected timer code.
> >
> > On Mon, Jun 14, 2021 at 02:42:23AM +0000, Michael Kelley wrote:
> > > From: Mark Rutland <mark.rutland@arm.com> Sent: Thursday, June 10, 20=
21 9:45 AM
> > > > On Tue, Jun 08, 2021 at 03:36:06PM +0000, Michael Kelley wrote:
> > > > > I've had a couple rounds of discussions with the Hyper-V team.   =
For
> > > > > the clocksource we've agreed to table the live migration discussi=
on, and
> > > > > I'll resubmit the code so that arm_arch_timer.c provides the
> > > > > standard arch_sys_counter clocksource.  As noted previously, this=
 just
> > > > > works for a Hyper-V guest.  The live migration discussion may com=
e
> > > > > back later after a deeper investigation by Hyper-V.
> > > >
> > > > Great; thanks for this!
> > > >
> > > > > For clockevents, there's not a near term fix.  It's more than jus=
t plumbing
> > > > > an interrupt for Hyper-V to virtualize the ARM64 arch timer in a =
guest VM.
> > > > > From their perspective there's also benefit in having a timer abs=
traction
> > > > > that's independent of the architecture, and in the Linux guest, t=
he STIMER
> > > > > code is common across x86/x64 and ARM64.  It follows the standard=
 Linux
> > > > > clockevents model, as it should. The code is already in use in ou=
t-of-tree
> > > > > builds in the Linux VMs included in Windows 10 on ARM64 as part o=
f the
> > > > > so-called "Windows Subsystem for Linux".
> > > > >
> > > > > So I'm hoping we can get this core support for ARM64 guests on Hy=
per-V
> > > > > into upstream using the existing STIMER support.  At some point, =
Hyper-V
> > > > > will do the virtualization of the ARM64 arch timer, but we don't =
want to
> > > > > have to stay out-of-tree until after that happens.
> > > >
> > > > My main concern here is making sure that we can rely on architected
> > > > properties, and don't have to special-case architected bits for hyp=
erv
> > > > (or any other hypervisor), since that inevitably causes longer-term
> > > > pain.
> > > >
> > > > While in abstract I'm not as worried about using the timer
> > > > clock_event_device specifically, that same driver provides the
> > > > clocksource and the event stream, and I want those to work as usual=
,
> > > > without being tied into the hyperv code. IIUC that will require som=
e
> > > > work, since the driver won't register if the GTDT is missing timer
> > > > interrupts (or if there is no GTDT).
> > > >
> > > > I think it really depends on what that looks like.
> > >
> > > Mark,
> > >
> > > Here are the details:
> > >
> > > The existing initialization and registration code in arm_arch_timer.c
> > > works in a Hyper-V guest with no changes.  As previously mentioned,
> > > the GTDT exists and is correctly populated.  Even though it isn't use=
d,
> > > there's a PPI INTID specified for the virtual timer, just so
> > > the "arm_sys_timer" clockevent can be initialized and registered.
> > > The IRQ shows up in the output of "cat /proc/interrupts" with zero co=
unts
> > > for all CPUs since no interrupts are ever generated. The EL1 virtual
> > > timer registers (CNTV_CVAL_EL0, CNTV_TVAL_EL0, and CNTV_CTL_EL0)
> > > are accessible in the VM.  The "arm_sys_timer" clockevent is left in
> > > a shutdown state with CNTV_CTL_EL0.ENABLE set to zero when the
> > > Hyper-V STIMER clockevent is registered with a higher rating.
> >
> > This concerns me, since we're lying to the kernel, and assuming that it
> > will never try to use this timer. I appreciate that evidently we don't
> > happen to rely on that today if you register a higher priority timer,
> > but that does open us up to future fragility (e.g. if we added sanity
> > checks when registering timers), and IIRC there are ways for userspace
> > to change the clockevent device today.
>=20
> Indeed. Userspace can perfectly unbind the clockevent using
> /sys/devices/system/clockevents/clockevent*/unbind_device, and the
> kernel will be happy to switch to the next per-cpu timer, which
> happens to be the arch timer. Oh wait...
>=20
> >
> > > Event streams are initialized and the __delay() implementation
> > > for ARM64 inside the kernel works.  However, on the Ampere
> > > eMAG hardware I'm using for testing, the WFE instruction returns
> > > more quickly than it should even though the event stream fields in
> > > CNTKCTL_EL1 are correct.  I have a query in to the Hyper-V team
> > > to see if they are trapping WFE and just returning, vs. perhaps the
> > > eMAG processor takes the easy way out and has WFE just return
> > > immediately.  I'm not knowledgeable about other uses of timer
> > > event streams, so let me know if there are other usage scenarios
> > > I should check.
> >
> > I saw your reply confirming that this is gnerally working as expected
> > (and that Hyper-V is not trapping WFE) so this sounds fine to me.
> >
> > > Finally, the "arch_sys_counter" clocksource gets initialized and
> > > setup correctly.  If the Hyper-V clocksource is also initialized,
> > > you can flip between the two clocksources at runtime as expected.
> > > If the Hyper-V clocksource is not setup, then Linux in the VM runs
> > > fine with the "arch_sys_counter" clocksource.
> >
> > Great!
> >
> > As above, my remaining concern here is fragility around the
> > clockevent_device; I'm not keen that we're lying (in the GTDT) that
> > interrupts are wired up when they not functional, and while you can get
> > away with that today, that relies on kernel implementation details that
> > could change.
> >
> > Ideally, Hyper-V would provide the architectural timer (as it's already
> > claiming to in the GTDT), things would "just work", and the Hyper-V
> > timer would be an optimization rather than a functional necessity.
> >
> > You mentioned above that Hyper-V will virtualize the timer "at some
> > point" -- is that already planned, and when is that likely to be?
> >
> > Marc, do you have any thoughts on this?
>=20
> Overall, lying to the kernel is a bad idea. Only implementing half of
> the architecture is another bad idea. I doubt the combination of two
> bad ideas produces a good one.
>=20
> If Hyper-V guests need to use another timer (for migration purposes?),
> that's fine. But we rely on both the base architecture to be
> completely implemented *and* on advertised features to be functional.
> I think this has been our position since the first Hyper-V patches
> were posted... 3 years ago?
>=20
> What is the hold up for reliably virtualising the arch timer,
> including interrupt delivery?

Marc (and Mark) --

In our early interactions about the Hyper-V clocks and timers, the code
was a bit spread out, and you suggested moving all the clocksource
and clockevent stuff to a driver under drivers/clocksource.  See
https://lore.kernel.org/lkml/e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com/.
That was a good change independent of any ARM64 considerations,
but I read (or perhaps overread) your comments to say that it was OK
to use these Hyper-V para-virtualized clocks/timers instead of the ARM64
architectural ones in a Hyper-V VM.  They work and it's what the Hyper-V
guys wanted to do anyway, so having Hyper-V offer the ARM64 arch
counter and timer in a VM hasn't been a priority.  They had other stuff tha=
t
didn't work at all on ARM64, so that's where their attention went.

I agree that it would be better to have the ARM64 arch counter/timer
fully implemented in a Hyper-V VM.  But we're wanting to find a practical
way to move forward, and in doing so confine any rough edges to Hyper-V
VMs and the Hyper-V specific code in the kernel tree. We're maintaining
and shipping the code out-of-tree based on Hyper-V ARM64 current behavior
and would like to get this core enablement code upstream. Sure, unbinding
the Hyper-V clockevent doesn't work, but that's not a problem in any use
cases we see from customers.

All that said, our discussions with the Hyper-V team are continuing.  We're
still in the process of seeing what's practical to get and when.

Michael

>=20
> Thanks,
>=20
> 	M.
>=20
> --
> Without deviation from the norm, progress is not possible.
