Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C032232F4C9
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 21:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCEUvD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 15:51:03 -0500
Received: from mail-bn7nam10on2105.outbound.protection.outlook.com ([40.107.92.105]:26497
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhCEUuw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 15:50:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbT5FT5t3aexXJmD6xy0KnTZc7zc4UUr2qSeNnmhNJX35qRb8hBbxsMA8XOwmLGMHfua3JU+tOXe2BwrcMCvCJnEhTfebSFEC/0yA9oxsOjFwdjsblpcq+x+jiA1xUE2L88vMuYaN/24YgtEaHFjnfTCDZ3EvRuY8mVaOlLaesXyDnqSZ4zcp6QXa2kCamXxY9Sn+2bNVswG9HWxd3yPQhRjcaGU+gPHUHEiAGQS2RmjK8s1Bc9ylrImtcSyKzupEuzXc/fGstiZsn0H4sXsMckOBqMzabcfEFlfrXJ/UBiaK/ijsA4VDR572BxxRNtVV8z2NrIDJsJPbGvltKplWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83cTk3Z0YSbNWJEdRTLEYkjLf2nQa2VvkDGR0ZJTF9Y=;
 b=bQ4edCjQzjc4KDuHJV3getjq8h0/uXnWYJ71hG5LuSiyWzMiawxrvmy8natCYsa0hNuE9S0ipd+osLFGvkwwvfltYRQbwNWlFh5VZPRpg0UEprrYGtqDxwV5L2a3JKtQb08t2ynZMk5nKQRUfN6Kske0350yMDEBKPSlVponWGXeQJw88cNTULd7ELAbdJmLQ0ElNnq1bRO3uM8mXlNt6hBpXyIjBwbxW526al7qlea8x+ToKd+KN2Wv7REVKzNxXeqCICZim+PCY2LS6syEjqX2n3P3mbmOdpzAyNnXtzrluYMPWJyzpgnXlMv8tUC5HI0RdahZhylXTSF1OYfe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83cTk3Z0YSbNWJEdRTLEYkjLf2nQa2VvkDGR0ZJTF9Y=;
 b=RxsJF8wMqqLKjkhN61x4JDhwG9xspY3DGFg3uZqLJKqDvE5Bi6vqgW0NvVF4/1DHxR59KmIebDRnEqMfNr9B8z8JwFX9GD6KnC4KHgLB1WOlZaEx2uOIqbAt/NHOOEiYIKI7qQDs0uoYdnz/R/7KUju9DfmoornQiY1lNV8wt1g=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14; Fri, 5 Mar
 2021 20:50:49 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 20:50:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Thread-Index: AQHXBkw53oUu1j5MYUuXintiG4xa8apmn1UAgA9VSHA=
Date:   Fri, 5 Mar 2021 20:50:49 +0000
Message-ID: <MWHPR21MB1593AC05C12BF8CDC066C545D7969@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
 <1613690194-102905-2-git-send-email-mikelley@microsoft.com>
 <YDW73Oh//1iAGTka@boqun-archlinux>
In-Reply-To: <YDW73Oh//1iAGTka@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-05T20:50:47Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dad554c7-b4cd-4baf-9f02-f5cd66f0d316;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31b97a24-ac1a-4c03-8585-08d8e0185be8
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB19562C57937E165FCAFCE385D7969@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ES6M9QN15Q/iqEV0RZEv1whcHkIbKCUzDDDSpQqtwcb3zIcbkQjftQN/wGvARKMr4nKTdTEvWlGkk7F4bKzpVx7RhIWYo3cHpUfCNXKpADzBNt+ENMslo5N8Z6VFpC+UxXSLD4NVYWI5qtLfgdkTovfl4bYjh/kfPcHc8ikGcwESi2zt/+VpzIk3GDe4hBRg2B5irJ0EXCBgfXxfQ11WUqrWvbKEershxxM71IaXw1I3JNMc9L8CPURj5xlRPAIfEpX2zf8R0Df5Fm4UNEVkXODHtvvDjmN0kgd29KngJXF+SfAP6D0lZrzduUhQ5dh6myDmby8PAmn6EPK0mI5XADLi0N+Nb4esOjzU2zf3Dl9NLdUACTChWraqQJObz74Sk9rr6mr/t/kqnEzHafpn27C0/EM9F5E/eCd/ksBuLcTuzNbsjAotSWTmIVomfEHrZ1GSX0zO/7xGt5czB/+yu1nl4bDb99/nEpJP2y7wYC4KlUM7x9T3uQ2nJXQheN3MkIrvfsXmwsnDrNhzALPL3lK2hz3W8GY+mbwxxwlWw0C2EJRJftQbLjXGY4NMx2xR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(55016002)(71200400001)(52536014)(478600001)(26005)(66446008)(7696005)(33656002)(6506007)(83380400001)(5660300002)(8990500004)(186003)(6916009)(86362001)(64756008)(82950400001)(316002)(82960400001)(10290500003)(66556008)(8936002)(9686003)(66476007)(7416002)(2906002)(4326008)(54906003)(8676002)(76116006)(66946007)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IlMO8uGqjmHZyzkkhcN5BjfNNJFiBOqAQxDCDtsSYgOtD/oHTdUyC34jLig4?=
 =?us-ascii?Q?adgz5tSlLpvFn5PHPZutBLGEtFMVN8qE4OMUZ6UPLBk9N22NZ7+NTbMnIXLR?=
 =?us-ascii?Q?/ZfOopoWkkx5yhbYgGEwyaniQi4OON1VegBL/h4Y7TfKd2hTLSYjM2OoMCZ7?=
 =?us-ascii?Q?sd0RoVPfGIEP5TQYDNHjqEdVp8XyRC2BntTEjDzbl0apPrF8Zf/76Dlrieay?=
 =?us-ascii?Q?VeZTw44tfW4LiitYgtDhHeYMGWWJS50VqFi/ZBiy1nOFfHxetjMS8JqoNj6c?=
 =?us-ascii?Q?MLhK73CcEx745oWxXRIEACccWCePuFZAd+GuJCoOsQnQHS42uGrqm8PPpZZ1?=
 =?us-ascii?Q?6EkFpL2FtXSyRGf2zDjSsDoViVGj+hBfzz2nyOc3dExW/zkkuNgnW7ZRCMm5?=
 =?us-ascii?Q?5IQeCTBq0Lh8nA7g525uUtBnbQ5nzr3AiepDxXtXcDY+xu9Hi+9z+cp6zbj9?=
 =?us-ascii?Q?zXhcZWyGaw0P4bXLfIZC0XvnihGmY5+19NP/kiTglBBf9triwlSZs6PcGDyp?=
 =?us-ascii?Q?G0qkfBXt9xvP8uo7RB06pa2LQr74axnu4UJDdWk6isT96DH3j3knL19IxfXX?=
 =?us-ascii?Q?V35IoJd6aTK1eBj91fer5xj6JKgglDJ4bMGiGAsedgVj3+dIIK9R+/QCFqvK?=
 =?us-ascii?Q?PcsPR3DEg0d/EF8/lNAPuHc7ozjZveYR9CzMxwZUAWqyvX6JbKFIE/7DynOo?=
 =?us-ascii?Q?3olalJSfVmdA4JyRfOMyh9dPYDHf/vYKjm9rw/nhTT3OISY9+iKbnLAPta1Z?=
 =?us-ascii?Q?gosxAlauczXiIpJE+66j8TCQYzArEhTS5RQ8hthjsvf/g4aeEbGDepkTiwda?=
 =?us-ascii?Q?TWv/BEp9u+Sg0W1Mbv9aeYIh3d3EOq1eVv4+DQ3w7tGHmQLt8Ht6XnZylndW?=
 =?us-ascii?Q?O2/O42XSl46lNc41QLpmJu0QjCPQ2+wYcpJkKiCMyuA7hyRWKb2udy9b964z?=
 =?us-ascii?Q?LfrcJmx7P5vhVKarKJtcHpXMZGILzikvyRVnwJGBGunX8sb5F5NBI/AW5bqz?=
 =?us-ascii?Q?mtAgTcFetWqmP6mqALSJZoT8/Qi+LCrVZSZzL49Kx3dOtWWtigtpLXzVHssU?=
 =?us-ascii?Q?e1XZHfBU17h44+HnmqquLT/g50AMrv+5LvBQRlApyIXCtKHLFc7Yw8VutJcy?=
 =?us-ascii?Q?7UaYhonXwgGcLYXFxj9Nnsb+r0g5aUCKynBhuukxXma1kXfy3xHpXB78KNA8?=
 =?us-ascii?Q?i3E5vHSTy9oRTiM+F6mpCDAq1JW0KWFnItjzM/rCoI6MwFuVUB/uy8X7tC0M?=
 =?us-ascii?Q?Q/x1IKVOKvn/bk7tPVoq6Xsh1kA8NnxNOeI+JRm9THeVD4SR/7bz1uae0J/V?=
 =?us-ascii?Q?JsDimb858nhsYJ0DXBrwpvcl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b97a24-ac1a-4c03-8585-08d8e0185be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 20:50:49.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZbkvtg1LT1ulSyTia0U8t3ZV0hGrwWUQWvIkTRUlEG4sgo0ZrpnVAA00EXHUxxTxrABIPAiexSC6ikIBHbG95UmTbqMj4A8EKAjZZ9V2q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Tuesday, February 23, 2021 6:=
37 PM
>=20
> On Thu, Feb 18, 2021 at 03:16:29PM -0800, Michael Kelley wrote:
> [...]
> > +
> > +/*
> > + * Get the value of a single VP register.  One version
> > + * returns just 64 bits and another returns the full 128 bits.
> > + * The two versions are separate to avoid complicating the
> > + * calling sequence for the more frequently used 64 bit version.
> > + */
> > +
> > +void __hv_get_vpreg_128(u32 msr,
> > +			struct hv_get_vp_registers_input  *input,
> > +			struct hv_get_vp_registers_output *res)
> > +{
> > +	u64	status;
> > +
> > +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> > +	input->header.vpindex =3D HV_VP_INDEX_SELF;
> > +	input->header.inputvtl =3D 0;
> > +	input->element[0].name0 =3D msr;
> > +	input->element[0].name1 =3D 0;
> > +
> > +
> > +	status =3D hv_do_hypercall(
> > +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COMP_1,
> > +		input, res);
> > +
> > +	/*
> > +	 * Something is fundamentally broken in the hypervisor if
> > +	 * getting a VP register fails. There's really no way to
> > +	 * continue as a guest VM, so panic.
> > +	 */
> > +	BUG_ON((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS);
> > +}
> > +
> > +u64 hv_get_vpreg(u32 msr)
> > +{
> > +	struct hv_get_vp_registers_input	*input;
> > +	struct hv_get_vp_registers_output	*output;
> > +	u64					result;
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
>=20
> Do we need to BUG_ON(!input || !output)? Or we expect the page fault
> (for input being NULL) or the failure of hypercall (for output being
> NULL) to tell us the allocation failed?
>=20
> Hmm.. think a bit more on this, maybe we'd better retry the allocation
> if it failed. Because say we are under memory pressusre, and only have
> memory enough for doing one hvcall, and one thread allocates that memory
> but gets preempted by another thread trying to do another hvcall:
>=20
> 	<thread 1>
> 	hv_get_vpreg():
> 	  input =3D kzalloc(...);
> 	  output =3D kmalloc(...);
> 	<preempted and switch to thread 2>
> 	hv_get_vpreg():
> 	  intput =3D kzalloc(...); // allocation fails, but actually if
> 	                         // we wait for thread 1 to finish its
> 				 // hvcall, we can get enough memory.
>=20
> , in this case, if thread 2 retried, it might get the enough memory,
> therefore there is no need to BUG_ON() on allocation failure. That said,
> I don't think this is likely to happen, and there may be better
> solutions for this, so maybe we can keep it as it is (assuming that
> memory allocation for hvcall never fails) and improve later.
>=20
> Regards,
> Boqun

Having to do these memory allocations in order to make a
hypercall results in a lot of messiness.  I've just gone back to
try again at doing hv_get_vpreg() and hv_get_vpreg_128()
as "fast" hypercalls that pass inputs (and outputs) in registers
like hv_set_vpreg().  I have it working now, with some tweaks
to arm_smccc_1_1_hvc() to allow outputs in a wider range
of registers than just X0 thru X3.  This wider range of registers
is allowed by the SMCCC version 1.2 and 1.3 specs, so hopefully
is acceptable.  I'll send out a new version using this "fast"
hypercall approach that completely avoids all these memory
allocation problems.

Michael

>=20
> > +	__hv_get_vpreg_128(msr, input, output);
> > +
> > +	result =3D output->as64.low;
> > +	kfree(input);
> > +	kfree(output);
> > +	return result;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_get_vpreg);
> > +
> > +void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *res)
> > +{
> > +	struct hv_get_vp_registers_input	*input;
> > +	struct hv_get_vp_registers_output	*output;
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
> > +	__hv_get_vpreg_128(msr, input, output);
> > +
> > +	res->as64.low =3D output->as64.low;
> > +	res->as64.high =3D output->as64.high;
> > +	kfree(input);
> > +	kfree(output);
> > +}
> [...]
