Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA7E3AA50F
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhFPUTd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 16:19:33 -0400
Received: from mail-bn7nam10on2122.outbound.protection.outlook.com ([40.107.92.122]:43784
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232073AbhFPUTc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 16:19:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko0gYpVq8DVcHHAzs6cVlsVtRkUuVYI+1HPCzeAwxhLJ7w+mA9OFs9LVIDkbWs0c6bkWopgWEDYlBmzhQRLJDQlnPeLP9dEoW18rKKzi/Afy0TOQB5gvxS1Ny6XMCNCZqp/hPghNp1OQR0NOKC41v+0qcH22Z2dI/p+ZjXxJ8Jo14RXNTmLT+7J+f4Zb6EOFnPd6tpO0YXfOVC7qjxKGkFDYOXtl//vRnED9zIqBMb7P+CacHfN1YzcKxl2bInJ+ZvSSuGtpQV/8oJyBC4wVmZrmNYR79es0gkxaWVGVuQ+NTh/GMLCxbj3bH4bIdyFsn6T8tt5rvNdAYYhaazdyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaZYTyDROLdbxNPpjL8Y/lQC/FH1vQ1pl9d+cV5v3wA=;
 b=kV3XXrDEG64/Tr1mQqfKGLaqQcK+ZnbLMo4eAOyA5T0tYO/o7sWARVv0B0jP0zRjR4BqF2Q1iPUlARntPkMBEPl/3hB/GecK4yoRt8NBYtIR5c1DZlVI+KmcTv7H3UJQe2qiRFFdWP7tEkwRTYn103gQnPAWEuu0TKReMHcZWOyD2FHdJjdu1WIFk9pV8Q45FFsMm781iNZHZb+7VkILz+NRkQXXFesiR0Kdv+sAnBR2pYCTMlw/I/OUiEYN1oOU06e4HvYKypNr6/yaRoh2BdfQ/Y/LB2n8VznMs00y1s5TS6tF2vNSV4lFwT6kNs4by0gVyV/kIyAr4iJtlqAb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaZYTyDROLdbxNPpjL8Y/lQC/FH1vQ1pl9d+cV5v3wA=;
 b=IyeTb9S7z3/kTNRgkHp0t90qUAlP4PnbxvMCWXhg24l4AAGq3uV5agZnbkhPl3MrTGLUZMTLteTvEOr5fWmwR3V5OoxHT8EEd9093iy06Bmg6hjx2SWo15fnMPJnSKGP+aafaER2oYayGC6JEz5w0M27K6Mx1Rkh86qtOZC+rTM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1818.namprd21.prod.outlook.com (2603:10b6:302:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.3; Wed, 16 Jun
 2021 20:17:19 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168%8]) with mapi id 15.20.4264.004; Wed, 16 Jun 2021
 20:17:19 +0000
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
Thread-Index: AQHXR1WfRNuOt4THnkSQtAriU3aWFKri7Q2AgAAsnCCABJMQgIAAO7hQgAGXcACAIOKsoIADPsaAgAVVr2CABFICYA==
Date:   Wed, 16 Jun 2021 20:17:19 +0000
Message-ID: <MWHPR21MB1593AD0CB11802FD65108AC7D70F9@MWHPR21MB1593.namprd21.prod.outlook.com>
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
In-Reply-To: <MWHPR21MB1593095A9B8B61B14D7DF08DD7319@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=26879e91-db56-4b35-b514-4786f8542303;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-14T02:13:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 302e6695-c534-492c-1a17-08d93103be3c
x-ms-traffictypediagnostic: MW2PR2101MB1818:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1818C6AFA2C6015197D0BFCDD70F9@MW2PR2101MB1818.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kETpNdTKD6dSaIjeIzdguqunivPAXDxQ1wMO2CGF9kTkLSSw1pDhOaynrVxrtDqnzf1HdBy9IVhOP8KveEXpnJlCwyIQaRIMXbEJACEtONyXPUf5cw48stpJS1hhYKQGFB3mjMRRfosFfNd6YGhSq4l0HsyATFxFnmId8Th0n7TH+mzwkSBX94x91fD1vWEqPjEuIyDDOWfTYlDtG/xPueIthGGRNyBqQzkYMYssLtSfWvt6uGyAlQvSJIGuhyUu1d6H7mwItitJDPdA7hNOkYVgq4oEf1DIWjhG/1TcZOU9JLcQH+ZQn29vDnFd0YetHtdIdhKyI/X6gFHaRKIL+VGynnp54wlbd5jE2WPLQC1e0pS2s5igi5JUUDkvp+B4ZGXbzcEnr3Tz0EZ1IFWaQSXTsRuTCGz7Ep8ru6WcUKE+1e6G6XABzrGlhi8X6vxI4MTDvxf5xCwTtiym6Iqd1JNnM+poTOvDMZLwfj7dgZsBzoQDZz4hvrUhyDGg8uMZEPczm7vT7pDGEpU2IMry4FZLmI5CtRLYZFS18DUMF7vQOOg0QTv++rPPSQCoXZC3+vN6NTg+Qbv3kxxWzOZQXxVqTvnN5xtRx0TybLpqLLCe1xR2iYmSSYsk9ClFgL4Nb3KG0ftlUYbwTFhcZQuTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8990500004)(316002)(6506007)(54906003)(33656002)(5660300002)(7696005)(107886003)(122000001)(55016002)(9686003)(38100700002)(6916009)(66946007)(10290500003)(82960400001)(82950400001)(2906002)(86362001)(26005)(8936002)(52536014)(83380400001)(4326008)(7416002)(186003)(66556008)(66476007)(71200400001)(478600001)(8676002)(64756008)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yggufgdz/XvPI8+DympswM4Yb54C/NpFQZxKOlIuBoRs0K+HIs4lE2TfWkW7?=
 =?us-ascii?Q?FFXuc2+HIcrNloYjyMTijag/i6FqCrz0LiiRx1k5NSpnfFWSuWh+hZoahehp?=
 =?us-ascii?Q?LkGZjwCw1MX2u6gubLUnPC1aDIkrp+2nUewjXEM5+HiDnMC4PcmcjHh4Sy8m?=
 =?us-ascii?Q?TPmhKrL8NCm04m9gOGuwGhdPjWMzpPYSO4EJorP+JSdgig04ITM9hygKqxvp?=
 =?us-ascii?Q?tgWSy/MDeEIBcgKILji9/5jGBXmduVVg2N5MpMsAxFiWtYKnscC3kwXowzN4?=
 =?us-ascii?Q?KNH6JSu65KZ5iDRxY9FXv6oIwQ9bkEt7ClNM1fcbQRhZE7ZVqxJeu56nyFBx?=
 =?us-ascii?Q?ZtnSdw1KI6kXo1zlBvZHIf3ptjz3BmrePqNBfkCwYL7559f0EbGniG2/CEqb?=
 =?us-ascii?Q?ufXz9k23kiLOWnQiTifzNN+ATCJuBTZZbZocuh/39Lh5p0VGlwXnzoUlYZ1+?=
 =?us-ascii?Q?9BI8IECFM1nMX8qzxCfPNSlCDP1dfW/pXNFhK3z1KE376jm5zGo7X+CggYqB?=
 =?us-ascii?Q?G45iztOHRzhRkZ3ziUdQppJ63SwbQDsp5dT0iPXADN116J48KRzTeloBYFdJ?=
 =?us-ascii?Q?CVbddVpS5e2JVOpKIarnjyB5aUrfX30U/dgZaPlSbV6m1RqfxCMwzH5NR/tq?=
 =?us-ascii?Q?IU51xK9qpG5HiwwLo3G7GRL8ARK6ae9sl1R+zZ6Nk2477YXaIAX3UyxtS+yQ?=
 =?us-ascii?Q?oiOTFe/xLBPGHfAEabfZCl79gcdBfM55SMw8r7Gmd5fvyonS4d7ZoLhSnJp1?=
 =?us-ascii?Q?O8tC8u6j0Ty+kcqJosM+8vqMhmPHQaBcijTlz1/ZRxwPl/rCHG3ZVoNThSzR?=
 =?us-ascii?Q?CnkHrSD4pGrcDIu5I1LF/W5sZ77efTNovfaY4WatXrLdMgkSGJcDBefTlYWm?=
 =?us-ascii?Q?DWN54us1oF+Af0Xf/hL6m4R8zQud+n53c+GSrVZSzUGPcMPVaVFZfbYGZfoO?=
 =?us-ascii?Q?b6B1RL1wBkfiKiy9ISwTvanM6oBvMN9POPoPU9UNAqXW3EgUlYi9X7MU+r31?=
 =?us-ascii?Q?xzCUqX+lhN9RfSmHdl9iphdCUsN7kbGK5KnHqt0TqnIZ88O16vuCOC/i3NKP?=
 =?us-ascii?Q?MzZMBW1+sKdV25kuJEL1MkvIePeVjgLjQmewx6bQDCcq6HnC6Y0sK6v8CYmb?=
 =?us-ascii?Q?3K134j5ia8VktL2YdqwneLpLUyHOn0hiOHRUvFfKE44NI/MgzxBe+dE5QnNd?=
 =?us-ascii?Q?8JKU5DrpgsApIG9s2D0mQcVtDd0l79ki8/d0f5Oil1BD8wzJNGQqL0m+VI90?=
 =?us-ascii?Q?UYIRzjMAU3Z9Cr9NJja80T1tXONz2Qo7DCN0JL2BnUZ9hAO8ffkoqJOQgns3?=
 =?us-ascii?Q?3fPmOg+a4aBZqG1O2Eknm+CI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302e6695-c534-492c-1a17-08d93103be3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 20:17:19.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxjF+PyuHwMgjKCAsmZaArDc/V3Az4Ncuu5wh+9zHppEyKce++RY9OTAnaWMJ2kbq34VMKAHqJUbDnim55IK+F5+KTE/lENzmXwzqtD63NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1818
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com> Sent: Sunday, June 13, 2021 7=
:42 PM
>=20
> From: Mark Rutland <mark.rutland@arm.com> Sent: Thursday, June 10, 2021 9=
:45 AM
> >
> > Hi Michael,
> >
> > [trimming the bulk of the thrread]
> >
> > On Tue, Jun 08, 2021 at 03:36:06PM +0000, Michael Kelley wrote:
> > > I've had a couple rounds of discussions with the Hyper-V team.   For
> > > the clocksource we've agreed to table the live migration discussion, =
and
> > > I'll resubmit the code so that arm_arch_timer.c provides the
> > > standard arch_sys_counter clocksource.  As noted previously, this jus=
t
> > > works for a Hyper-V guest.  The live migration discussion may come
> > > back later after a deeper investigation by Hyper-V.
> >
> > Great; thanks for this!
> >
> > > For clockevents, there's not a near term fix.  It's more than just pl=
umbing
> > > an interrupt for Hyper-V to virtualize the ARM64 arch timer in a gues=
t VM.
> > > From their perspective there's also benefit in having a timer abstrac=
tion
> > > that's independent of the architecture, and in the Linux guest, the S=
TIMER
> > > code is common across x86/x64 and ARM64.  It follows the standard Lin=
ux
> > > clockevents model, as it should. The code is already in use in out-of=
-tree
> > > builds in the Linux VMs included in Windows 10 on ARM64 as part of th=
e
> > > so-called "Windows Subsystem for Linux".
> > >
> > > So I'm hoping we can get this core support for ARM64 guests on Hyper-=
V
> > > into upstream using the existing STIMER support.  At some point, Hype=
r-V
> > > will do the virtualization of the ARM64 arch timer, but we don't want=
 to
> > > have to stay out-of-tree until after that happens.
> >
> > My main concern here is making sure that we can rely on architected
> > properties, and don't have to special-case architected bits for hyperv
> > (or any other hypervisor), since that inevitably causes longer-term
> > pain.
> >
> > While in abstract I'm not as worried about using the timer
> > clock_event_device specifically, that same driver provides the
> > clocksource and the event stream, and I want those to work as usual,
> > without being tied into the hyperv code. IIUC that will require some
> > work, since the driver won't register if the GTDT is missing timer
> > interrupts (or if there is no GTDT).
> >
> > I think it really depends on what that looks like.
>=20
> Mark,
>=20
> Here are the details:
>=20
> The existing initialization and registration code in arm_arch_timer.c
> works in a Hyper-V guest with no changes.  As previously mentioned,
> the GTDT exists and is correctly populated.  Even though it isn't used,
> there's a PPI INTID specified for the virtual timer, just so
> the "arm_sys_timer" clockevent can be initialized and registered.
> The IRQ shows up in the output of "cat /proc/interrupts" with zero counts
> for all CPUs since no interrupts are ever generated.  The EL1 virtual
> timer registers (CNTV_CVAL_EL0, CNTV_TVAL_EL0, and CNTV_CTL_EL0)
> are accessible in the VM.  The "arm_sys_timer" clockevent is left in
> a shutdown state with CNTV_CTL_EL0.ENABLE set to zero when the
> Hyper-V STIMER clockevent is registered with a higher rating.
>=20
> Event streams are initialized and the __delay() implementation
> for ARM64 inside the kernel works.  However, on the Ampere
> eMAG hardware I'm using for testing, the WFE instruction returns
> more quickly than it should even though the event stream fields in
> CNTKCTL_EL1 are correct.  I have a query in to the Hyper-V team
> to see if they are trapping WFE and just returning, vs. perhaps the
> eMAG processor takes the easy way out and has WFE just return
> immediately.  I'm not knowledgeable about other uses of timer
> event streams, so let me know if there are other usage scenarios
> I should check.

I confirmed that Hyper-V is not trapping the WFE instruction.  And
on a Marvell TX2 and on an Ampere Altra, the counter event stream
and WFE provide the expected delay.  Evidently WFE on the eMAG
doesn't actually delay.  Bottom line:  event streams work as expected
in a Hyper-V VM.  No changes needed to arm_arch_timer.[ch].

Michael

>=20
> Finally, the "arch_sys_counter" clocksource gets initialized and
> setup correctly.  If the Hyper-V clocksource is also initialized,
> you can flip between the two clocksources at runtime as expected.
> If the Hyper-V clocksource is not setup, then Linux in the VM runs
> fine with the "arch_sys_counter" clocksource.
>=20
> Michael
