Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E332BCC7
	for <lists+linux-efi@lfdr.de>; Wed,  3 Mar 2021 23:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhCCOlC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Mar 2021 09:41:02 -0500
Received: from mail-bn7nam10on2130.outbound.protection.outlook.com ([40.107.92.130]:17633
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232876AbhCCAfy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 2 Mar 2021 19:35:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoQSUINQtCIxU7+1PSY9AFL4pOtnjhSWp7BOt/g7NGK+pK2wPG//a5zVBarNWakbVvfO7lA5CTQRbhminfJHpeDdB4+QQKrXbj6JRCGq0jxJm9FfD/9tX2O92FcIVqWY1yy569ffOW86+8kCnmwotCFMGUYSnUoH2iqGZ1DL0pMwP7xG+HBFRpg4tnxyoZAi9EkABLGw28AO//3iaIoGnq1GWKU4cKuK+3rpcnJPzGh/8odezqWzxD4G/w3OcJevVbniFqjSxx0j/h/POMlxoMoy+mgUEokyrtu+DPE2cGuf5/MVK39M/KtIuU/Vhb7jTt2ES0acAO8H7AzuJHVgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+8NmGt3s1Kv/lso7Xg6e3xyq7BybjluQ/j2kxQmjD4=;
 b=PpI1rEjZBdaCowo+o5RUPBH//5cRzWpxpRI7btoQ/1xxPXgf9nLCvLYyFKzTxkGoI+hp8g2InXAqonC6IbGCcptEauGcaG3iDO1iH9mWzb7cMlQF2tbNgZbPFsrgcsY3GsJNFLwAfmWfkqsif3aTR+XHn0z1zXe+Uu/HM05/jLkksdNAIOakLT3yzAhJmXI8TRJSkvL5yzUWBuSrMmPwzjCK46CVXQxl5Xfx4/QPTC3IAXOAExOUM1+GnaJIpPclgtlt3RiwLcUac9JhELN9o8ZOW3Us1LP6nVQx5d7taqVU00xoOhAWRkMoWHKtQMySanq7lNA6ZdLLIOoFVQjZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+8NmGt3s1Kv/lso7Xg6e3xyq7BybjluQ/j2kxQmjD4=;
 b=JJ5gxShPw0h12kf3IOAjSzNQ0Mg3c4Nfx7eoP12oVQXUsClZcMtmhU6MOdIIMURf6iI6vQsS0nIW+TfGZYHzsoGZEPcV1MrXGHTGBXAqBibm8BmATx4rcGptjZZTerg24IVY/wP3kfAPhxsgP8Fz7xBzGeWp3zleF5XZ+AAjxvs=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1007.namprd21.prod.outlook.com
 (2603:10b6:805:a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.2; Wed, 3 Mar
 2021 00:34:57 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61%8]) with mapi id 15.20.3912.011; Wed, 3 Mar 2021
 00:34:57 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>
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
Thread-Index: AQHXDwVm7IanFUbz6UeLdWLFekPIfapxZzMg
Date:   Wed, 3 Mar 2021 00:34:57 +0000
Message-ID: <SN4PR2101MB0880C47188DAC6446BF5E156C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-2-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1614649360-5087-2-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:3132:9d16:d3c9:b7bf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f619943-4c24-45b9-a783-08d8dddc2c35
x-ms-traffictypediagnostic: SN6PR2101MB1007:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB1007CDE15615083A081DED32C0989@SN6PR2101MB1007.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOvmBVGiqjWh6xtiAmOuLbZtt6eJ+azStvmeKavzjasbZ2ZkcegMrgHvSsZuWSnvUaZSI26YrnNr6NGPRebmHPpViZ0RvptH87tuHvr8lK6TxBvl+wBcxf3Q9j0DFwFDYJso+gl66P1yWe9VbjQXaQaui4hxF3O6yePItO0mWgOuQ98LuV3/PsnxUjS56jX9KLghAcfpdgTbb58eN+JPZNtdEYDAziU6/jwK6UJ/fube0IowGXnwOSjIOPEbLo6Pv4aoOq5dloGROp9wGjlG/WbxK0RMdTypQSGAy4YsxNxt2sOz8aCCrTX/uqy1tEmE9TtZ/UPSCOUKclZJ2SPhs1FOOnk0ffd6vD72inO8wQDcDKGk9iA0trvyw5USHq8GLYf4nvvq9kGwcBUJHR2Ir48g6sCTKE5lGeLWLGzdcaUZiTbaf/hkOzrCyQwU9PFPsOqmIaUQMyNrBTG1h2whWGWMHY1M8ov3iBJDVRf34u98Y47ERmmE6YsNSrwKhkZF4IVXU4CcqOOVMFKrBZuKIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(478600001)(86362001)(82960400001)(66446008)(2906002)(4326008)(82950400001)(66476007)(66556008)(8936002)(8990500004)(6506007)(8676002)(316002)(71200400001)(7696005)(6862004)(6636002)(52536014)(33656002)(9686003)(66946007)(5660300002)(55016002)(54906003)(10290500003)(186003)(107886003)(64756008)(76116006)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NkvDE3JtahwY9jxm4tK/QKaNzKv5hmLm0XbVr3qEP1qfaviXLOonEm+Wm31M?=
 =?us-ascii?Q?IjHQR+vC5tM1R9wBormU3CBkNRSssEOXDI+WopW6CahS/WpKm2gvBmjg9bql?=
 =?us-ascii?Q?FkjCBWly1YewTqHaO2jV12sSA/LzvaNDEewdYogctiAp0//j8PoP27PHrNOu?=
 =?us-ascii?Q?5+3TuBXLTTBm/Nd6uWW1DTcMbThCaSAMcTvXQRaqumirDlxt9bZWTv8FS1e2?=
 =?us-ascii?Q?xVnuXcSg8H50PybUhO8cWBkCwCpkuRc5kvYwTMwhbQSNdr0PtZaepzGgTRq0?=
 =?us-ascii?Q?VzfSKMpcNyhBS9jZT+fXdFQSKCtqul0hhaaYr+4eBqUDMsQXboQT88/4sJqJ?=
 =?us-ascii?Q?d9RC+46YfO367JYK2WnRx8Cs6NfZtonnE7WBQXn0OH3DjGGklE1xOwvOF212?=
 =?us-ascii?Q?6S3cWROScJkZk3s+Dkqk1f853zOtoGLI5Gf6T8Y7e9UJ7M6exwRQYfCv0/0r?=
 =?us-ascii?Q?pBuGCLli47KEdPPB6rGiz45jCb8onYyE9N3nbDMoxH3YNaBWfbCg6yWG+CQ9?=
 =?us-ascii?Q?YJJpOaMtz6x6hHC9cmdHQj9+xRZdWvXBWis7H6nQ84Xs7Ae5a9oi+O7oSI3j?=
 =?us-ascii?Q?pwngxMteKD4waRBK1VSS31ukBwMaZq/EMCLBVPCIldI7fEBYAjZQdfI9Zk6/?=
 =?us-ascii?Q?2aXEyMf6/qMqc6hpWgxLWvFYKlwDIXoUFY+148M2LaNYHU+MxUO9Jm8Dw6T7?=
 =?us-ascii?Q?kLPDS+FG9B6KUXGwiJ8G5MI/cUT9cXL8NiYXzoHosdAXw/n9JysT1Mx6kcVT?=
 =?us-ascii?Q?pZmbh6FWuyAYSnJVKVhvZ3Rw497wRgBUvqUUMCLrlMo1hrF6gq7U7NroCzw4?=
 =?us-ascii?Q?pRoVm1GO+HYrmw6J3Lx839jS3HtrA2f+CYrCK+NJ3gRPt4i8rwly1Kea4vNS?=
 =?us-ascii?Q?G+xQqzrH4IgEWmE2ykmNc1Lj/+pCFrXSEunnbLfUFcApfpdUqk/2NcAOp6V1?=
 =?us-ascii?Q?+/uUX2UqSSjdsKRiiQPPnZePMC8k2yX4GY5vk3vIHPAT4H94wAqDyCmVPyAy?=
 =?us-ascii?Q?aEQ2eI0OzqrK1yRZgGO6RuJZxT3aQmqMgh1XMhy3oGemi8XbAWaG76W6hKH8?=
 =?us-ascii?Q?DP0Ymc14OaHd8vQpcWfPEcSPYFig1wN6QBZEL6sW2gP7HF8P434YNBZZKS52?=
 =?us-ascii?Q?N+/lQfr/6eS1BCDcO2lKLrSR4FwQ/gWJ+GMwmoohePnzrHjwl+MdK+6XI1TW?=
 =?us-ascii?Q?0SxvsfVe3rTtVFobdHLCmmIcMOBAJDhA6R9FTu4S/Jv+s9z+7y82shDYTk+p?=
 =?us-ascii?Q?jyHP4x+s/aBx6L4Eqey5HgS/BsMubxH47rSpcg7kbkES3f7L/hOM2RD5sWcP?=
 =?us-ascii?Q?JYzaUlhuK1dotB5pls/HFiI/LxEE5F1RGkhOeSejxILpcjstAy3Wk1ZVP6M3?=
 =?us-ascii?Q?qq+i/GMtgJ7n1aUdG7J4fWxyQi4a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f619943-4c24-45b9-a783-08d8dddc2c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 00:34:57.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jp+kYvT5b8CBD3ipdFvjA6yP12sAp63Wi6foSIV6O2XF9VHz9zqkCTKE97amSjs9wPoKv80lrC05OjY0g1AJKVAXWyis131YfdEPnYcAgEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1007
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> +}
> +EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
> +
> +
nit: Extra line, here and few other places

> +u64 hv_get_vpreg(u32 msr)
> +{
> +	struct hv_get_vp_registers_input	*input;
> +	struct hv_get_vp_registers_output	*output;
> +	u64					result;
It seems like the code is using both spaces and tabs to align variable name=
s. Can
we stick to one or the other, preferably spaces.

> +
> +	/*
> +	 * Allocate a power of 2 size so alignment to that size is
> +	 * guaranteed, since the hypercall input and output areas
> +	 * must not cross a page boundary.
> +	 */
> +	input =3D kzalloc(roundup_pow_of_two(sizeof(input->header) +
> +				sizeof(input->element[0])), GFP_ATOMIC);
> +	output =3D kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
> +
Check for null from these malloc routines? Here and in other places.

> +	__hv_get_vpreg_128(msr, input, output);

+ * Linux-specific definitions for managing interactions with Microsoft's
+ * Hyper-V hypervisor. The definitions in this file are specific to
+ * the ARM64 architecture.  See include/asm-generic/mshyperv.h for
nit: Two space before 'See'. Here and in couple of other places.

