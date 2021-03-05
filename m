Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E925132F4D2
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCEU4i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 15:56:38 -0500
Received: from mail-bn8nam11on2117.outbound.protection.outlook.com ([40.107.236.117]:33370
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhCEU4L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 15:56:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+ja92bCT8oUXmvfARLfBUdltPS0KLMC2yB7b3Y0gEzmtbFximymBA872UqxjY6Ez9uw8JHksBH4CufRuNuPl/RLuzJHn+4RmMbj0U8H/NhRPMiZOIq4Lik2aZ7mgxk/wiDTbBOFp20tJlLMkYHecDsqnKOrPiGA2xm+xf4/R2m08vwYj5vm43XtNE2P8oX7dbSDpTaP6jXBHq5+v4HndYSEtMN0ScP4XeMF6AluSxMtUQSlCQf4lImC6odJ/OgPXatKj420W33U24yVmSBoFlb3B0KuGKkmA74So50rCNVliPUeN0kfmI/LusHrkUHB8rBCkT2HVPscK+VEtRi/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO+hMyamoy0FPqKrxaPujTmo5F8TvCWH8LNR444CpZg=;
 b=aTkZJYMQ0m1CEBiGjEhQ54a5YSK8xaR4SVmnvD/Sev0+SZmYNjzJssCszykOsneejE1DdsHrlyDjnX+dkoUlC6VTxYC2IAq1uKKDARbmIHI8u6pRlt0kAhTzlcRLNMRvKiYh+bSFjvLXC05lhJgaGnW17dGZuGr6XZH01ouCnQs4Lhi5S9prvVq3l9FY3/XAWjjvtWwgFi+QMEOdlqI5Lvj1BIV8fXmAi46wgu17TtTS/gumJy9OC8oB6PTnoiH51fIsx2T5xiCM2AK4GgcI7VHWjOcp/USL0sVDkftyzd3abzs6PvmNrw7CHfCMrIbTPIsnlJmcwyHvSPADfiF5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO+hMyamoy0FPqKrxaPujTmo5F8TvCWH8LNR444CpZg=;
 b=Sx7R7HsPNbbaFfk86CJqYHy/hjkfD2TRRS2GvdaF5U1EyVp+ESGoYN/+e5Wn+P2jDDOG180htEpqoNvhfTQoBx8NmeO9He7+vkP0BW41mlDghPKxKyRExcv9yUNUwnPWQ5NlXUE9RHL7HzDciz8TwLfmn7KBFpWVRwZA8YqYbrc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0158.namprd21.prod.outlook.com (2603:10b6:300:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.11; Fri, 5 Mar
 2021 20:56:07 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 20:56:06 +0000
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
Subject: RE: [PATCH v8 1/6] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Thread-Topic: [PATCH v8 1/6] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Thread-Index: AQHXDwVm7IanFUbz6UeLdWLFekPIfapxZzMggAR9SNA=
Date:   Fri, 5 Mar 2021 20:56:06 +0000
Message-ID: <MWHPR21MB15935FDAC09EAC7919FAC9E5D7969@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-2-git-send-email-mikelley@microsoft.com>
 <SN4PR2101MB0880C47188DAC6446BF5E156C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0880C47188DAC6446BF5E156C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-05T20:56:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eed7fc22-5201-4e94-8d4e-c945d88c2949;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d77fb3f4-f37f-4e03-559a-08d8e01918cb
x-ms-traffictypediagnostic: MWHPR21MB0158:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0158B9FCAF07430ED5956438D7969@MWHPR21MB0158.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y9zuN2n02Z/hbrDpNk0lhvJSRafPn8vyV45PPD6uzsV1Lc/Uc229WJl6BB4DEYIVwQM6PKG3a7f3JDpM0g3qNJyQH3yNZIC+//HczYm2/z4KjwZi1PDnzg6E3fpPdimbGPX+OCcN4otbXUFWl4xjfTfWq5RWYaWYG8nHFeUAEQVPpzg0foSM8OQtrkTAAI+x2mSQZ/qsVOWWj2oOKEoCRCZKSidvrVVRD3Sq+DKHEsgRp3AS3tm3AMyRwAqXvu0ySGJWi3u+Osk4ew7NB6SddqtVgcDeY4vBzLVo4Y2MmgfOFCbPfwQk+0vISCtbHLLK5PrLSjtNHUFELgh+8a7+pagjTTTXIdpHJN8uELs3zEiTzLFtq6bozIMo5EGUBv/OvdscaOEc1bmLxTmxO/umou4DmZzmNyDzNG8evMFvW/T4w8Rehe70EW+z7Ht21ienxs4kIxOTyhT2iMWPKtDxQIuurIIi2nIO7uzVZG9XWwv0DbRRrQNN2mjxJcOBkS2v9oPVeQM/0YK5SO+cFZuXXhKRSguo3p+Hf8rKjlfnyXZlsl5k+KdnS6qqkNUG5GB6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(66946007)(64756008)(9686003)(66556008)(7696005)(6636002)(26005)(71200400001)(8676002)(82960400001)(186003)(10290500003)(316002)(54906003)(4326008)(33656002)(66476007)(107886003)(86362001)(52536014)(6506007)(2906002)(6862004)(8936002)(66446008)(8990500004)(82950400001)(55016002)(478600001)(7416002)(5660300002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?46glXKer9/8VtNf6ZpQFWynUzz7uVTSMYr8r06aUdYnq/mj3tcX9RTHnnYph?=
 =?us-ascii?Q?u+b3GKgu+6ZgZ4ZWeiOiQmOAg/+b/oF6g/1iVyDr5bxfhepE8ovRuB39eMu3?=
 =?us-ascii?Q?nYUrfXnXkkiECJC1vZBLPz3zY1WAtWLXl27BUISkQ3JuDWSE3VvFIRxoiH2w?=
 =?us-ascii?Q?LSuPiG0hN4n/BN6gir+N3HxeYEfqPU8b/bt+fyI/F/Ai4F90YlJPnhMuAoi0?=
 =?us-ascii?Q?F+qaBqykDDC0tFgkA1QGYlGGoSQg9dzGaa0bsFp4zxZNznPind0QuUsPONF4?=
 =?us-ascii?Q?zGB2CwT7wugjIAmsmHXaPfQAhmLljGczM3C0Ap845PvV3ItATdznCV8uuVic?=
 =?us-ascii?Q?RYVtm+myabDOWMDMFpwKyKCgoUumkgk1lAGUbvQmqv7H3PlE4xqpTq2N/+Vb?=
 =?us-ascii?Q?G2aBszQyypHGIlKHR2luW6E4GOMe+YyJtT4DzQemyK98wfO7nbXIozyUmyl9?=
 =?us-ascii?Q?XOYQD71qbJpNcj1h5Pp7AIDWuABw+wyB27O7BcQL8rydDUfxa78StafPQUKO?=
 =?us-ascii?Q?LTj6097V3XdVqzEUAv6Foo2X+vJBaazC1VvhxVa6ieEJtkxpz1ykQ3lxPpOd?=
 =?us-ascii?Q?AfuM8idmNPgus3/WVjFuUv+2R83fCinlorCnWn+zDZ9uaAPFxgmZWCus9SQ2?=
 =?us-ascii?Q?bc0ZBr2/QzvZc5ydIFPq9xfKPpfO70nK/OiSE87cpvr+CEpToARs+Vie6/eP?=
 =?us-ascii?Q?VpaLHJ3gXP7VvvBSE+T6oWUy6UKQnHBI2Ug6P615JJ+yCPbz4d1EghsiRDc1?=
 =?us-ascii?Q?xOLj6Te9M7e6XkTXAwbpfcE4Se2TyfmZCIdYiDe1TjMqQkSgTHjpdHWAYspx?=
 =?us-ascii?Q?svd6GnzIataEnMwINN3bgKpZ71NKMH5WhwF8RPeXrYymFV48Q7t8RQMn6Eua?=
 =?us-ascii?Q?fjGkeAh+3dDWE5qC6tZZwB78y836/ehSzrjcaeh7Jf1KZcJDsMDB1htfxVXr?=
 =?us-ascii?Q?v+ZrekWhACIq9kg9qv55/+Tisq3hbKCPOE4Q2loJfFwz3kouym4NTc5FrJHs?=
 =?us-ascii?Q?3f/6Yjn6F5G0VBzAeZ5wQRussP42T602qPRuspiazUsXEo+potBSE6cLoZus?=
 =?us-ascii?Q?ohMdKTkmJhQHS/f4vu5/KuQRep5aVIAflkTYg269wYTIjiSjwL3cA0eKeHSy?=
 =?us-ascii?Q?HZwZemwUnq7qV/Yym3z2i8lF0BHpomN3JkwbGZ0TU7NAHtDnxPqR748zuANC?=
 =?us-ascii?Q?DPMVfXAvV7/SNRmVGLw/Ll5s9N693yyfMGm4NqWOpC598AYLF877FWuaBCSY?=
 =?us-ascii?Q?3Pc0B89t60OXvqsUYlo1FiAMJvQPKTY3MXIR8WN0p3mS2SLfNL/kKM9eckB0?=
 =?us-ascii?Q?9zd/cGVVo5fLLxcoU9qQbt5Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77fb3f4-f37f-4e03-559a-08d8e01918cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 20:56:06.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34n6M2BDl91EidBENQfNOKWLkAc5HWwpMa4opWXUMXS/CwdaHLi9pyp1O/eGd9pZNHMsaRuqRl+q/IOnhrm4q0QaEbrgOnRWCgkdsfvLfSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0158
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Tuesday, March 2, 202=
1 4:35 PM
>=20
> > +}
> > +EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
> > +
> > +
> nit: Extra line, here and few other places

I'll try to clean these up.

>=20
> > +u64 hv_get_vpreg(u32 msr)
> > +{
> > +	struct hv_get_vp_registers_input	*input;
> > +	struct hv_get_vp_registers_output	*output;
> > +	u64					result;
> It seems like the code is using both spaces and tabs to align variable na=
mes. Can
> we stick to one or the other, preferably spaces.

I think the general preference is to use tabs for alignment, not
spaces, so I'll try to clean these up in the next version.

>=20
> > +
> > +	/*
> > +	 * Allocate a power of 2 size so alignment to that size is
> > +	 * guaranteed, since the hypercall input and output areas
> > +	 * must not cross a page boundary.
> > +	 */
> > +	input =3D kzalloc(roundup_pow_of_two(sizeof(input->header) +
> > +				sizeof(input->element[0])), GFP_ATOMIC);
> > +	output =3D kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
> > +
> Check for null from these malloc routines? Here and in other places.

See my comment back to Boqun Feng on the same point.

>=20
> > +	__hv_get_vpreg_128(msr, input, output);
>=20
> + * Linux-specific definitions for managing interactions with Microsoft's
> + * Hyper-V hypervisor. The definitions in this file are specific to
> + * the ARM64 architecture.  See include/asm-generic/mshyperv.h for
> nit: Two space before 'See'. Here and in couple of other places.

The debate rages in the broader world of writing about using one
space vs. two spaces. :-)   I'm still old school on this point, and use two
spaces out of decades of habit, particularly with monospaced fonts,
though I'm probably not 100% consistent.

Michael

