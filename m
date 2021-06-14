Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A803A5B9C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 04:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhFNCo3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Jun 2021 22:44:29 -0400
Received: from mail-dm6nam12on2121.outbound.protection.outlook.com ([40.107.243.121]:23607
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232295AbhFNCo2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 13 Jun 2021 22:44:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD/x6O+I5+hhHUjZ7FtkGOFrcRKH/22q0eVVQqVFtessU3Tpv9qYBXY8Jnytl1lXo0Ri1KzUPwnhrRywW8+P/7RHvxOarYk4b1dwqkakmOv/IpPmuznlHA98eF7C/kDICKkqXaBDH2CaQ+N59gqZYuc87HhOHdr8uZxT5vvq8evuBIGEcYdkJoNm6q3HHBBlTeMmCryeNObHk4HVEOWlQE/AkHHPwppdCySft9wVanKQ5ngOHsfy9d4vye3MjoiYq2zH6mz7zn7TyPNyCexNDwznBUh1DwMqsxoUWy8Z/0TxhAZyhBuMpDeKbm9U53UAzGAnlLQiBVvTNxCUji+9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0D5cPulYQHsqSbFoVYRXLwz1KjN5GFmb5VuGQBe93U=;
 b=Rp6/QKWgzPgiiYQtPENt4eog5bkRq/ahT424fc7iVo1/B9sl7+yWv6pVj4JGsr4rBWHY1O+0lhkf13dAY16zGun8YqIUqQMDQ5zm2CBuz5siks5icqXiezEzC2WeHdl8Wmy3GcAuDdZGjKylUAjnGiXQqid/pb00a7KuN04bK0v6HkNb18N6969bsADuuH+zUm8Rz682tSMn8JBfvEhdF4p3qUYEXtcfBTAKJijsotK6p+M8n32cy0rcm8IVwDZPIR2prQnApdFCRQJFn/GR7pOAsg+i28kHeGL59u4v3QrIBabALQyUhw9X/z76pq1YDpnuihQPVo45bGLvhaC1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0D5cPulYQHsqSbFoVYRXLwz1KjN5GFmb5VuGQBe93U=;
 b=U99CVs7IqgWO5iuJ0lKm6Rb7PxDCvGs+hQQWchsztU1S3JUFJCRl/IOqc+DZ9hRFT2rEyAsFIeAETIM0PTB8KmQbMcQzhK4zcqjGa0mpDqK+pY57CPpOYPUKboUK5k6piLumFBv5KK1exU2QBsA2nSZe0Ajw+3r1yh/0gF9HmhA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0940.namprd21.prod.outlook.com (2603:10b6:302:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.5; Mon, 14 Jun
 2021 02:42:23 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2%9]) with mapi id 15.20.4242.012; Mon, 14 Jun 2021
 02:42:23 +0000
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
Thread-Index: AQHXR1WfRNuOt4THnkSQtAriU3aWFKri7Q2AgAAsnCCABJMQgIAAO7hQgAGXcACAIOKsoIADPsaAgAVVr2A=
Date:   Mon, 14 Jun 2021 02:42:23 +0000
Message-ID: <MWHPR21MB1593095A9B8B61B14D7DF08DD7319@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
 <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210517130815.GC62656@C02TD0UTHF1T.local>
 <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210518170016.GP82842@C02TD0UTHF1T.local>
 <MWHPR21MB1593800A20B55626ACE6A844D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210610164519.GB63335@C02TD0UTHF1T.local>
In-Reply-To: <20210610164519.GB63335@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=26879e91-db56-4b35-b514-4786f8542303;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-14T02:13:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95834311-1e0e-4ce1-f429-08d92ede0a17
x-ms-traffictypediagnostic: MW2PR2101MB0940:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09408894517FA385C69DC36FD7319@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0K1BcoOb4Mcj7zTaJwY4oXRc4G+FhbZA/uH88LcOlk+gWKE/WDSxGzAXwfh+Lann/e5Gk7dKboV91iSKRI+7LllYoLEl7P2ktmORgjc46GnUNE1K6Eo9JGbs0yJJBG4qOTSFa9xTRlTbv9NQVc4QH3eb1/n8XQXYMVdGXiS9vAYibku7GKGx/dWMSJXobYAmxf+K4qP+zpmzquRKcjWZG1UKgfQxgz4sjoG9ZBPW9F1+JjFQGDz9qhw8ri2UiNZr+G2JMdliT4sVuBHPd+2chM9IQxgeDcw5kByPzJCErWPIxr3y/qXm4YBtRbk841MY8Xi7bqk03v2EhEnqPayNkvODv3PJxiefmTqdOG+5A7U5xBlbuzm7i9T/EMHiTE7F3B+v42pKGIiW/6m+UUxiJVqELqv9N3LZuKMayIF3++vYkIa1XovTqlXPQTLo9UyWTwl+hRUz5KpPD2J/ZGaUDzcSaYsTQnyWsf5brcS1hUqh6wMDSvtZFDk9wGzgqS5Alt0ECGcgDJA40Or5gsNlVtZfCvTdhs8p4SozUX2Lwaq/2v2v/hFyZGco08X7U7H/5zpiEm6cXG5QOJCvD1yXlLJYFThzjQMk7ycSj2093vK0+NCALuNNw3LGyR2y6m66X1X9BKyiTsU2bpW+eNgiqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(478600001)(8990500004)(82960400001)(83380400001)(2906002)(71200400001)(7416002)(122000001)(4326008)(76116006)(9686003)(54906003)(6916009)(8936002)(316002)(7696005)(107886003)(86362001)(6506007)(55016002)(5660300002)(33656002)(10290500003)(186003)(66946007)(8676002)(52536014)(66556008)(26005)(64756008)(82950400001)(66446008)(38100700002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?emAGm23ekzS0XiZwIvMyTicj+Zs5uU/0TMduqDroKHk0Cv/12UkPGy2Vw9xj?=
 =?us-ascii?Q?exi+TnWpZSGC/+aCOTn4aCPp+SQa01iUYjJ616LD38kmycitcn+Bo3VviMfZ?=
 =?us-ascii?Q?iiQdnXZefF2bNTuLPG2gKx00ypZUdPH9nacwm2CXtbDFWglKlmbMvzGf+C5/?=
 =?us-ascii?Q?S4s91t5iZt9VbXdUo7CVBoPrpi2w0oUkaOJjUlhf8tMrINgc4I52xODz+I/Q?=
 =?us-ascii?Q?shEdpePzeNBDUF8Eztj4SKI5CsYyY/NiExVQi7m/wrK1+ln9kItA+UwISTM5?=
 =?us-ascii?Q?04cdbrZgDlL2J9AsbXa4bPYtlZs5Nv38IhRAnvdQPRg06YMLIat8WKNnyXww?=
 =?us-ascii?Q?XOKDBkiA4Xf0K9YSzKsNw6rPaNalLUZIdcVDgbwktjinCt4DrMU4iapQQt+J?=
 =?us-ascii?Q?N/W4ImWbYp+RMGdgkD7t3EIB0zVSWK4q0TTAP6rqoJrLG0OeOZYHhbyOTDfh?=
 =?us-ascii?Q?cZt+pVlo7UMepGQ5FNXOUAm9JVsFGQs0wpCyDaEMbapIite7urpD5RC3BJtq?=
 =?us-ascii?Q?tlUReaJpPy4Bfr/v+VBzLeiyIXnmmheWR5d1CRFrfpGGiKhrpOpPqkusgZu0?=
 =?us-ascii?Q?pLg84lExb3dPUfm56Bl+I/VSoMNzBP56Gq3n+h1Mw80stpzLaejyekUJgE2U?=
 =?us-ascii?Q?7KXRmMqO8mlkPOjFdiIhFm0lKPI8/0YwKkb64k92HvG0I2JhWCPdMmInM9Mb?=
 =?us-ascii?Q?3IvpdOoPnj1zuA7HZvNVz++JxIG/xOcycsVNyFj5UIBO2HACmso+r2Z8Mf7A?=
 =?us-ascii?Q?NxYbtuBYk39iNjSFjFyxKePtkf8pUuK8XjraM7tOHZhyldisPOtWYfA91vlW?=
 =?us-ascii?Q?sxz4++zUDsbnFg77C5u3yF1WTt1WntdpY729QJvwHJFx39+Cu6eLgWT28zIF?=
 =?us-ascii?Q?8HQ2PKzbip1jgEboGVVLjGdltto5fKShWtfs2IJLhY9JvpG/MpY2bvsAAaDA?=
 =?us-ascii?Q?9RtBSNXOASDEYyvRmf0yyhjI2Xah62Oax0JxilX3KklciPIWmM9qpy/IUV3S?=
 =?us-ascii?Q?07ChXeXOnTYGyaxson6DHIDWhE+pQe6ttd9uYKx9J0Pb+Ae/MYvVCJUHrcXi?=
 =?us-ascii?Q?fdhI/co92GHSu9FzVtOmexKAKiHEMpnzubFGarm3OBCLW1La/bRgfiGQN/sY?=
 =?us-ascii?Q?Mva1Ad/YHi0crwyUbY2Cf9PaFNiCSKuNO5IQUzldXhfgWdnmTbJJa0cqw3gB?=
 =?us-ascii?Q?rVwIRlqd4iFAqIxu9lC2C57+0/wVyePxDjV8jJE5pkTaUyp3ck6bnvpfRvrA?=
 =?us-ascii?Q?4RhqEjCfTj1fpOiqCsC3ExywSaqfXXGaMRrCB5aYwRNYGaEBMIheSvdJIo0z?=
 =?us-ascii?Q?fqwWd4IUkA821Vo6HQqrGPcg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95834311-1e0e-4ce1-f429-08d92ede0a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 02:42:23.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKOouu1HmAZ0Kbk7pJ0iBK2XYLd4RJcpgrD5tka5WLkDwWh7cBPdOp37knoakExeixtHX6SXEyOXpTLcWyPrOdYt7aTiKB9VrK8bnuFbjfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Thursday, June 10, 2021 9:4=
5 AM
>=20
> Hi Michael,
>=20
> [trimming the bulk of the thrread]
>=20
> On Tue, Jun 08, 2021 at 03:36:06PM +0000, Michael Kelley wrote:
> > I've had a couple rounds of discussions with the Hyper-V team.   For
> > the clocksource we've agreed to table the live migration discussion, an=
d
> > I'll resubmit the code so that arm_arch_timer.c provides the
> > standard arch_sys_counter clocksource.  As noted previously, this just
> > works for a Hyper-V guest.  The live migration discussion may come
> > back later after a deeper investigation by Hyper-V.
>=20
> Great; thanks for this!
>=20
> > For clockevents, there's not a near term fix.  It's more than just plum=
bing
> > an interrupt for Hyper-V to virtualize the ARM64 arch timer in a guest =
VM.
> > From their perspective there's also benefit in having a timer abstracti=
on
> > that's independent of the architecture, and in the Linux guest, the STI=
MER
> > code is common across x86/x64 and ARM64.  It follows the standard Linux
> > clockevents model, as it should. The code is already in use in out-of-t=
ree
> > builds in the Linux VMs included in Windows 10 on ARM64 as part of the
> > so-called "Windows Subsystem for Linux".
> >
> > So I'm hoping we can get this core support for ARM64 guests on Hyper-V
> > into upstream using the existing STIMER support.  At some point, Hyper-=
V
> > will do the virtualization of the ARM64 arch timer, but we don't want t=
o
> > have to stay out-of-tree until after that happens.
>=20
> My main concern here is making sure that we can rely on architected
> properties, and don't have to special-case architected bits for hyperv
> (or any other hypervisor), since that inevitably causes longer-term
> pain.
>=20
> While in abstract I'm not as worried about using the timer
> clock_event_device specifically, that same driver provides the
> clocksource and the event stream, and I want those to work as usual,
> without being tied into the hyperv code. IIUC that will require some
> work, since the driver won't register if the GTDT is missing timer
> interrupts (or if there is no GTDT).
>=20
> I think it really depends on what that looks like.

Mark,

Here are the details:

The existing initialization and registration code in arm_arch_timer.c
works in a Hyper-V guest with no changes.  As previously mentioned,
the GTDT exists and is correctly populated.  Even though it isn't used,
there's a PPI INTID specified for the virtual timer, just so
the "arm_sys_timer" clockevent can be initialized and registered.
The IRQ shows up in the output of "cat /proc/interrupts" with zero counts
for all CPUs since no interrupts are ever generated.  The EL1 virtual
timer registers (CNTV_CVAL_EL0, CNTV_TVAL_EL0, and CNTV_CTL_EL0)
are accessible in the VM.  The "arm_sys_timer" clockevent is left in
a shutdown state with CNTV_CTL_EL0.ENABLE set to zero when the
Hyper-V STIMER clockevent is registered with a higher rating.

Event streams are initialized and the __delay() implementation
for ARM64 inside the kernel works.  However, on the Ampere
eMAG hardware I'm using for testing, the WFE instruction returns
more quickly than it should even though the event stream fields in
CNTKCTL_EL1 are correct.  I have a query in to the Hyper-V team=20
to see if they are trapping WFE and just returning, vs. perhaps the
eMAG processor takes the easy way out and has WFE just return
immediately.  I'm not knowledgeable about other uses of timer
event streams, so let me know if there are other usage scenarios
I should check.

Finally, the "arch_sys_counter" clocksource gets initialized and
setup correctly.  If the Hyper-V clocksource is also initialized,
you can flip between the two clocksources at runtime as expected.
If the Hyper-V clocksource is not setup, then Linux in the VM runs
fine with the "arch_sys_counter" clocksource.

Michael
