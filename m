Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA87832C98C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbhCDBJ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Mar 2021 20:09:26 -0500
Received: from mail-eopbgr700112.outbound.protection.outlook.com ([40.107.70.112]:18720
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351051AbhCCTXb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Mar 2021 14:23:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahHUajztAKpqu5V8ERHev81VG1s/Q7EMw7gx9+eRh/qjazH6HofzQcoKfahg/RIpN99Yd2M035/ewjKxr89Ra8ee5aPG3eq+y+bmULNYuHjrruiy74BpuCe//2aPrrMZwsS7EkTTTSv0XikZ3NpVt0OgN5gWcYMP5WLYTVNWrv+eKSDrRzJ9X7dwPslaWNXFNuu7dFbp0mY7uEE7A/aOoVq/Kjd5GCnPscR5xkIgtdSsW9cqabAhQX6hT3mBWL4fnjngVe/UGQYG5NAFt4sHgC/S6T5EnN9JjF+hVHa6cvJ+NlCEhj6oBRTrOqJQn+YkB9f8GwrY1hiDErgbG0c1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qshzL0aZo6+RK0gVFqKw3YT5Cs2SlO06t/qWZCw919Q=;
 b=h/KcCn4nKLActeraCNEIvwfOWe861K5EDZTUyfpycRDPiCxYw7jiGmDyojHsXbyomTzXEwWGFPuaFT+hVr9iDwXv9Qua9IkfZ57/KNc7ScIKob61/NbeKMEO1S1Ot+i3oVrOiTz3Pv4asCJ38Z2AMBBAELj1rbM8QB4xggsk9+eaeFdIqaj/LU4Gb/6tuPe1DyAIlzA1aqID92s+u45uyDjULhOMD4l54LGpzbOMSnfa2LobzyLnjooacf14pSnCLyFsz+BWMx/6NGvjmczo+H6HfjEZREZWS1Jc2YRNoM5dey+DWbiCkDpu8KZ5ipWnxw41zQVU+0CfTcMws9kxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qshzL0aZo6+RK0gVFqKw3YT5Cs2SlO06t/qWZCw919Q=;
 b=PdlDQw6CPLBv+ON5F73SXAPTJo9oD0y8uTXF/tx0B8Eqj61fQ/HDyYESLaXNm5L3ADngds9plUqgp+M3zFYN9w2+Z/WwCjTOob3+UXF/W1elXDq7kSJBRf+x3KBdlYb/vGIY0/NVkd+vDU8KlfoXV4z49vMnq7v6Q4lEeTn7JFE=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1133.namprd21.prod.outlook.com
 (2603:10b6:805:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.8; Wed, 3 Mar
 2021 19:22:43 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61%8]) with mapi id 15.20.3912.011; Wed, 3 Mar 2021
 19:22:42 +0000
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
Subject: RE: [PATCH v8 6/6] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Thread-Topic: [PATCH v8 6/6] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Thread-Index: AQHXDwVoFp5j5KsMdkS0exoQxgNRsKpypitQ
Date:   Wed, 3 Mar 2021 19:22:42 +0000
Message-ID: <SN4PR2101MB0880FB2AC894DC5B6031F361C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-7-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1614649360-5087-7-git-send-email-mikelley@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 22ad0d52-7a7b-45ae-8915-08d8de79b7d3
x-ms-traffictypediagnostic: SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB113389B123F384592D7C3EC2C0989@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 823JHfkjDoPSSkIJKNx91dJP+DdiFrtmp2mi91swB5MArmGunwFhM0sh35BDcG+sLenryb69tPJxTSYeQr14k0cpmnR4idBTRRbr1V990B1BC0HR5ZLCHB8nl9Dy2P/IlYc6PcQqLm+vGIMpVmYD6TAU0fzXNbIJBPB20X8uTKrPJ37SEe3EB7zuWfB/p6QSsXI2zDuaKUK+fNgs9gCYhi9z++N45/ogIM7TYxRc1r9pD0Bi7+8eNbv0ez9Q76agSEY3aTW1y1KScuUcJMSa5CT7Irni0yHUfXetcQfyKBvf7MzGRCOJxAz9ZmJcLRMrdfe0qh6IzO5NhsclSzUK6KyXkVapkkJY8gXGjw+d36VDa+XUXpbwPW1quU2lQPcr4oBiPKVdvnpmGrOB+FMvg+cJleVzS8WW1Fc99oGLBghI/fPKaXZ276tER8kTQxbnhTO+BizEoouq9VORq+V33LrboFuaJk3VXKQUys/FP4jYuB9rQRL5tv2Rh0S3Q/C9Tm5cSAJuB16Xajo5FRAAtvALRWVLDuUrJKhYMe+tc5O36tmm0Cf3TmhzI3sDTzBp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(8936002)(8676002)(5660300002)(7416002)(478600001)(4744005)(66946007)(4326008)(33656002)(82950400001)(82960400001)(2906002)(76116006)(6506007)(66446008)(86362001)(8990500004)(54906003)(83380400001)(10290500003)(66556008)(71200400001)(6862004)(7696005)(9686003)(52536014)(316002)(55016002)(186003)(66476007)(107886003)(64756008)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qyO1m3hlj9evUMlvmfzqpeR24/I4GKVpwF5GMwzWVat3Mura/UKl43NTjs5w?=
 =?us-ascii?Q?m8gYpA5fQnk0AOVkeQp2CKxs/POZPZb6OgsMncybHozLFCa4i322bKsUMumH?=
 =?us-ascii?Q?pR5W5RhFXlgNvfVG7yR3zPF19Laegkbu/9koZPYKy8ummg4MEsw5+YOMZ/Av?=
 =?us-ascii?Q?QWiRJZWzmqW0ok8bp8tx1XKzbyyJGFqXWznt/tijDQzgHHdgW03qKgbW7NL3?=
 =?us-ascii?Q?OJmCeCxIH9vKP3BR6egcDHqoky+IsIkRR3b5KpDFOrImu2yu9T7tUxlsPkRb?=
 =?us-ascii?Q?Fj4cowqi5lDWMpqfd3gej1WdcfC2cwrsrBVGMn6oU9twFGkvjSQw2XGeG8SP?=
 =?us-ascii?Q?8qKF3bbj5eEvJdN5cllhAu8lszRRq+8GTHmwdmwpkkwLTdfkBmVcN+2tK5Ln?=
 =?us-ascii?Q?hRFiVKehfagUv3Sjkma2PcTC3wEHZK9TWPBGHJkmRg7M/myXIiUb0UnTZzxi?=
 =?us-ascii?Q?aQ7SDkibQTYnmNLRDWZa0LDG0uruJrAzSMZfPdV7SnVaxEh+aHjCmjZmQiyO?=
 =?us-ascii?Q?nq8erSQnriihEWZDsqm/hwcA3GD2Rv+kvOUPBfAypIrSnO/ZV7qjO2vkNZxg?=
 =?us-ascii?Q?1a/iLjfW1wJjtSKv9jhDDlxgNDUbXdWUsGURxD0VeuGprS8U5054c8/nReD2?=
 =?us-ascii?Q?XZZzAs6QXiDPPPn3q1IvhO5MM1Ik+PbGJHxN6mOKloWJ2IKLr9IR+a4h5kJr?=
 =?us-ascii?Q?IrWVnyM7ZQMFdY5oLnt8wIMaT4pQZO40RbV77RNsIfs7vC5XUGEvGgZtSwQt?=
 =?us-ascii?Q?oORL495n1ug8nCRkXG0plCdcL/Uf80nBpFAQtimsKtdQoBTsQl1878OQ/1u9?=
 =?us-ascii?Q?4sSuWsUUcZ/oEsCvoGhT1CN0T/qZFXSU5nNeycg42SyEbEAHkY30JBHytilH?=
 =?us-ascii?Q?eOaMux/+7S+USLh4UGlRxCaduuo/TRLv0Eh5IebZzwuSJKOQt04/AYpXqyAe?=
 =?us-ascii?Q?fB+B/oObIXtyPq8pIldTEkpaLtlcnAm3nMuE7wI66Ltbdf8DAD+Lj1H+sVA7?=
 =?us-ascii?Q?DCIisPafQ7Flz8sSC8vFqoVUdeNMC9TJddSj11z6+PA0zPFAXdk/gLjPnlEI?=
 =?us-ascii?Q?Gxvm+qmIEm6609uSwJ2c1w46I23CbyNdSFAAQlJn1dSZ274jtfhOVuzy2qZP?=
 =?us-ascii?Q?eu9IovqAqb7yppNdryZmqd8gzeJBnQoFxXfPkuUEb2RVKkFiL8ZtqHMNn66N?=
 =?us-ascii?Q?tJrZHD2qExbZpBZfyr1FAW9wdmZnrHGNg7a1EH9+g01cl9Zq05NyVakrkWOd?=
 =?us-ascii?Q?uKzRxhUb9J4f1QbzInnyicq8DqhsesqJmz6nLMldS0LqwidgKxdDi9wS8L6U?=
 =?us-ascii?Q?+84HF5/nZzFmdnPAFvft6OeNQeNTSgIdX5EsL8kzhiQwMYpRP2e1j4KgfI3/?=
 =?us-ascii?Q?JKhWZtKGg2L/yNP6qPl6/7y01H6+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ad0d52-7a7b-45ae-8915-08d8de79b7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 19:22:42.8508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JeHWzuobcKFY/q5bpxEK+xQuKSwC/hdwFH5ACRbdcafY5WEe5DvZotHU7cngx8GllsYJZcONJ2Y/BnOtF3oUVa3vrXCTdxM33OI+ksw/L1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
> ARM64, causing the Hyper-V specific code to be built.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 79e5356..d492682 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
>=20
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
> -	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
> +	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> +		|| (ARM64 && !CPU_BIG_ENDIAN))
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR
>  	help
> --
> 1.8.3.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>

