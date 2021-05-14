Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE8380D46
	for <lists+linux-efi@lfdr.de>; Fri, 14 May 2021 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhENPgd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 May 2021 11:36:33 -0400
Received: from mail-bn8nam08on2099.outbound.protection.outlook.com ([40.107.100.99]:58273
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234728AbhENPgc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 May 2021 11:36:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMiBbP9PUq++EYtM63EDctg5nPLVtHG4thqLbgxyrX3Jyd+9Ci76Yze54ZNZuJMMyN32vHXXE547xS3VAeCrCm56NdS7wDY8TYJ7RTfn4YKEXqPWkfRpCIYW1XvxQtgYrUtdFrMvUBQulxLSUI4oAWBh5nHo2TqQ+0HRj5Wmbp74hWnX43+/Ysiwb9Aetltikf6HQZM1dfcZZVvav920msjegJOGUELB/vqO2MGut6CpFps0THNb5p/+2L0ncvzLZtg6ahmS+6rM3ERePDUpE2dMcHx7RqeSjePhhBeNv3/R93Ya0lNS8cYfjcDqlr0adPG1Rvpik7myiCCmLhZ6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTIyz9I4o4eyFst3tODs9VaOrus2oqk+TyEdHKJWNSE=;
 b=BEUVivAczScScmA/AwQmJ0/9WybBiCCltS+qO35fMQ36CE5kL6p8Jr94ZYdKj32GnvhnoAMlg2vh+IqZd+FdITHbk3WBpfw1Nt/XRGBMa6MEVh8NB5JLh3tDxXP3zFnlzlkc6Pr9HJsr3EStcPUa7QeFMPqrJ7ujlJZPcdH8tZ+PV0G4J2lTK4Wbnxi7yke1+1wPvS/+NfAvZyK0UeXhioK1vzKkauTQB0AgBpKlIE1WZAfUGZ/a8gHA3J9/rS9IIiWvNU7VM3OTTJ54zBkLHQy7tfl0xspNUgBzb2Y7178g/v/htlG5/sRGUgakYasYR6z4lN4RzgTPgKZ2rnj9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTIyz9I4o4eyFst3tODs9VaOrus2oqk+TyEdHKJWNSE=;
 b=KH1K0NmUS39JewnrJ0FhxZvMpSobtLhah3FBk1rsXHRsElfQZYcFkzmon24a3/GNWhsP4DjGTuNKmwBsRVkzu7uQT/IXSy+jIBh4JKABPulldr7XriJXFj+HfwDbJR3hTAJ3775axavzh5eF7g/YwimmP2P76yawQGLhlOYWarM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0286.namprd21.prod.outlook.com (2603:10b6:300:7a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.9; Fri, 14 May
 2021 15:35:15 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4129.023; Fri, 14 May 2021
 15:35:15 +0000
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
Thread-Index: AQHXR1WfRNuOt4THnkSQtAriU3aWFKri7Q2AgAAsnCA=
Date:   Fri, 14 May 2021 15:35:15 +0000
Message-ID: <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
In-Reply-To: <20210514123711.GB30645@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5eaa3a3-be51-4f5d-a074-77f4f2fb1413;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-14T15:16:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9f825b5-032d-46f5-a5d7-08d916eddf4d
x-ms-traffictypediagnostic: MWHPR21MB0286:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB028682BE7C933168886B9B60D7509@MWHPR21MB0286.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TZQDN4RdOtrlGWmcQ7ar0Gp5/0WVGdz7hSQK9dIAYsWBOaYDoS3vJ4dsJFetz/vGgdIGsj08KW0WqqyboxcPraPeRq2PsOPOGkWneDwj3SD7JSx3jt59hrKyg5zPL6xrxtJn/Y7LsRDTTdn2l0HYYIpjv03zxggohNRMb+MTvmhHgXBI4EoxkuFtAwfNK+ybyHAPFMoe97GC/rYt0DiM214kt9Ed1rTAsUi5i6kWM4CQXIGr8xvA5ZTZevNPcTwDyKuP7cVYKYxxhLRJVfDWSmXn7nwtBt/3ZNFo6rsO9mww8XHCBtRQ37/4d4KDSeMCN/HEESBZiPe28MjcE/kvmVejmQ3huUvLdQj1fHABghbX6GONqJhs25UfwdTe/Y+PI1ApvIB1IOdLxE5VRcKTKrXcecehKAgNZfN3f9Zci1dv+BbB31MteVGldqKq4U5E1t1xf0kDKGbvi5aEu5fn5RGYYHX/9BNNYkfeFNAmIL4m4DAKhA7nEJCq9S9TN53K4KlqSPPfZaWlbTBKzKZduk6pMoum37f/FOQBA2zDaNLpxi5j/5YsyFpEA0MMy9fz/8AZ9GWxTRWn6qC7YBL58mcP5jFi+p5YvDR5JzCSd8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8990500004)(71200400001)(9686003)(82950400001)(26005)(55016002)(5660300002)(6506007)(6916009)(7416002)(8936002)(186003)(8676002)(66556008)(82960400001)(64756008)(7696005)(33656002)(122000001)(86362001)(66946007)(66476007)(316002)(66446008)(478600001)(76116006)(107886003)(4326008)(83380400001)(54906003)(38100700002)(2906002)(10290500003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BmJUfBgD8Kx0s6DrHVePYNboFFxBTC6k5fC/DgpW5zP8g8m8hy7JumqkneoV?=
 =?us-ascii?Q?aWG8+cyqfb8WV2khjwn2UEZ36RLI/pc85Ot+TQUwaYEC67Z3aMO+FkLmpVFJ?=
 =?us-ascii?Q?S3tLMQUW1eBfR0uwMW5m8JMlCL5TqI/WvYfxo3wDAB594szkbCHUmDcTho3Y?=
 =?us-ascii?Q?hN+5rPgdpSfyTvSTkN2Hc1jPOnHvFgapZoemDYx53uEePTO7JLj6vsDlUDei?=
 =?us-ascii?Q?eKh/Y7D/TQS0nzquyc0fD7nj2VJlv6fU3sUYG7Z2uCrfBo5KKOq0387AmfIK?=
 =?us-ascii?Q?l4B1ceHLTwWtrOCGj3Y6nIXMjaS3LYqDJtmGi73GY0zglqKSBK6hGUnGoCnb?=
 =?us-ascii?Q?DrJRk2HxcT0fGPkw++qpdrYCaYR5ThuGY2LohR5LcyyAjhkQ6f6zd8GqlOpx?=
 =?us-ascii?Q?6a56Vo+6I+PxPBkBa3yCfNTkBg1rLZP3q+sNIm9/YkqE221KNbCjlHGJHzO8?=
 =?us-ascii?Q?o5ptY1PUF2xjs7i570aN1OkeFYAbDY78nrmvkGjIhrBc5FEy5On6KfPSdKzd?=
 =?us-ascii?Q?I67ZsZ3S1iouFPwOtyTxNGD4OJgkhlneKyJydSd5/HscQg9Y+Bl9zx47w+/2?=
 =?us-ascii?Q?mjHXiAmKp/iPh8XrlYpkrXXwE/e97FWdxbGVwUKJcfHRTQndmfGqQaj0Zm+Y?=
 =?us-ascii?Q?RCO1wFepKK4W1lje+rurlulpz3fl0BytSSN5bwn0R4QKXfI05cbCdBRtwsgj?=
 =?us-ascii?Q?qtlOmEmYmSGAOvJYAjM2fgvDn+BL6fsN2H5hjr5g8pV3bDM4XI9kKZ5zSAqY?=
 =?us-ascii?Q?ozuOaOlNRTqtvsj8JhZ/kEAoioJc4pmgNUl/12Ey7Yu6KXVgp4tEa+P6WBTT?=
 =?us-ascii?Q?RrQbzkYRCigXkRXy4gh1DVKOy+47QVeuEt7MJ6JISe9kkCwVmn4mHOXf0Vcl?=
 =?us-ascii?Q?O5CRp9xkJSXBgbOSsVOnwNaNfV12kyAgjk4tPoiumszx6ZJdLkZJ7xQ9rayT?=
 =?us-ascii?Q?HXXFhj+dvnCSyJ1WG1MZWDqHINc+RJ4J5ZRM0mnL?=
x-ms-exchange-antispam-messagedata-1: +xi5cCueXYRxrk7zRxLg1ZdxtcmXb0yoQgiraEIfBULcUrKZlhyy0+buXqXMRQuU4wTJctbB768F1xkSO9CLPXyonmaIDTpfUYvQS/cXecs/0RPeUpDaYQpwEQv5S9mT0/okXT85IEkRrbLkCjOKmx/z0dFyItXN6v+mMLfMmDY2NCYi0Le9eGzqL6+am2rji1RnZenZA6KoJD1zzayYfzWi1onVr0umH94atMJ5vJDzPdNDvG0NrgTKBjdV5GXGNH8B23zi+VKlHtChRlWEXfrVLg1Euy0mIv+ce4UFHh8VnsLVl0zR7c+wiV4Xo4K0530+SM4B2E/Soco4tRDISFHw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f825b5-032d-46f5-a5d7-08d916eddf4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 15:35:15.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kATba9OlJmWO8jBDdanMOvlaoL3CGSW4SjHaEgo3eP6q8KGk06p6V59yfq69u2bWnEaQ/LqfN5ZDkIdra9zHQmZscjrizb6JbUznHkaTcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 2021 5:37 A=
M
>=20
> Hi Michael,
>=20
> On Wed, May 12, 2021 at 10:37:43AM -0700, Michael Kelley wrote:
> > Add architecture specific definitions and functions needed
> > by the architecture independent Hyper-V clocksource driver.
> > Update the Hyper-V clocksource driver to be initialized
> > on ARM64.
>=20
> Previously we've said that for a clocksource we must use the architected
> counter, since that's necessary for things like the VDSO to work
> correctly and efficiently.
>=20
> Given that, I'm a bit confused that we're registering a per-cpu
> clocksource that is in part based on the architected counter. Likewise,
> I don't entirely follow why it's necessary to PV the clock_event_device.
>=20
> Are the architected counter and timer reliable without this PV
> infrastructure? Why do we need to PV either of those?
>=20
> Thanks,
> Mark.
>=20

For the clocksource, we have a requirement to live migrate VMs
between Hyper-V hosts running on hardware that may have different
arch counter frequencies (it's not conformant to the ARM v8.6 1 GHz
requirement).  The Hyper-V virtualization does scaling to handle the
frequency difference.  And yes, there's a tradeoff with vDSO not
working, though we have an out-of-tree vDSO implementation that
we can use when necessary.

For clockevents, the only timer interrupt that Hyper-V provides
in a guest VM is its virtualized "STIMER" interrupt.  There's no
virtualization of the ARM arch timer in the guest.

Michael

> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > ---
> >  arch/arm64/include/asm/mshyperv.h  | 12 ++++++++++++
> >  drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm=
/mshyperv.h
> > index c448704..b17299c 100644
> > --- a/arch/arm64/include/asm/mshyperv.h
> > +++ b/arch/arm64/include/asm/mshyperv.h
> > @@ -21,6 +21,7 @@
> >  #include <linux/types.h>
> >  #include <linux/arm-smccc.h>
> >  #include <asm/hyperv-tlfs.h>
> > +#include <clocksource/arm_arch_timer.h>
> >
> >  /*
> >   * Declare calls to get and set Hyper-V VP register values on ARM64, w=
hich
> > @@ -41,6 +42,17 @@ static inline u64 hv_get_register(unsigned int reg)
> >  	return hv_get_vpreg(reg);
> >  }
> >
> > +/* Define the interrupt ID used by STIMER0 Direct Mode interrupts. Thi=
s
> > + * value can't come from ACPI tables because it is needed before the
> > + * Linux ACPI subsystem is initialized.
> > + */
> > +#define HYPERV_STIMER0_VECTOR	31
> > +
> > +static inline u64 hv_get_raw_timer(void)
> > +{
> > +	return arch_timer_read_counter();
> > +}
> > +
> >  /* SMCCC hypercall parameters */
> >  #define HV_SMCCC_FUNC_NUMBER	1
> >  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/h=
yperv_timer.c
> > index 977fd05..270ad9c 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -569,3 +569,17 @@ void __init hv_init_clocksource(void)
> >  	hv_setup_sched_clock(read_hv_sched_clock_msr);
> >  }
> >  EXPORT_SYMBOL_GPL(hv_init_clocksource);
> > +
> > +/* Initialize everything on ARM64 */
> > +static int __init hyperv_timer_init(struct acpi_table_header *table)
> > +{
> > +	if (!hv_is_hyperv_initialized())
> > +		return -EINVAL;
> > +
> > +	hv_init_clocksource();
> > +	if (hv_stimer_alloc(true))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_timer_init);
> > --
> > 1.8.3.1
> >
