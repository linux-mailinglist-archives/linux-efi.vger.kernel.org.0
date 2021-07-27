Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64D3D7BDB
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhG0RIq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 13:08:46 -0400
Received: from mail-bn7nam10on2121.outbound.protection.outlook.com ([40.107.92.121]:10592
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231828AbhG0RIk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Jul 2021 13:08:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5LtPMKR9hvFeuAbTSrgfMofBFNCJ3kbBzRrGN88nJbS3o7+W6pLd1gDVmqxeuzQYvqlqxijy4dIPUknhnXhu2jvSX5qrkuAsbQruxnUgHKSthXtKOWnZX7odOqjM07eGjAlc6cJgYtGXGgxLZUxFs+Q6Kz10yyN7kQS6JFPkJQrEtNVECsHkoAMeGrKIfP8KcNBjEAn4ftfipMKUvnmp0+d3CDjMqLJdVPhSeoLV1L4d7o101yKAMpeqgUWzpP1Pcxc+iORIuE37CCCySliohAhouYPzCb85SeP4IZHKI+VbHEygShO45Y89EsmJgfLgLk/BlVJNEr+gLryq5fTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plCURwXMYnJyor0N1CN64wT3GnHl4TtArCOkQ7qubTQ=;
 b=btHviyUz79O6PjkFPj5gIHeeMB7yjiwiCe4oPftZM/HPlN4EEYQwe0plIDaYWwkRCJGu8bi2xsBBHmREJGFV4qlQWgMg1sKevNavys+eUtXWTDjLwvetRcVa6mv7MRZJNWg3hbxQCX9S5jHoC7okMchqJkZOpqnBPob5X9ictHBuBa6W5IAE8EyQTtIZmCD8YZFfKnq1MUwl1wBP9ZGYQ65uqdIjdwl3hSP+qvADMdAoepPAg9fqoEBpa5d6CC8OEA51R3eSksBIWctGMdEkaPAS92JRgYeZEPd+yZpd8M9fN81x0bcj6v05iUFaKAif7exW3+yBFw316SGd/cTilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plCURwXMYnJyor0N1CN64wT3GnHl4TtArCOkQ7qubTQ=;
 b=Hw1VSru/Lx/L6Ps7W26rHRol3vq1HliJk8n5m2dqfPgC4m0iUYRbBcJeAzCV0aulPKLEWdTltOv9zunTK85wasiKyH0+INOIrOLycyqnyDOtcarz6Tn8/zsE3DRkFLXmZb5ZAdC67LQswqyrQxHBy1RClPMAdc6Zl3pdDZ8iKEo=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0512.namprd21.prod.outlook.com (2603:10b6:300:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.1; Tue, 27 Jul
 2021 17:08:37 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51%4]) with mapi id 15.20.4394.005; Tue, 27 Jul 2021
 17:08:37 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v11 2/5] arm64: hyperv: Add panic handler
Thread-Topic: [PATCH v11 2/5] arm64: hyperv: Add panic handler
Thread-Index: AQHXfXkd4IWTbKiKBUGvcw1PlYsfqKtXGGgQ
Date:   Tue, 27 Jul 2021 17:08:36 +0000
Message-ID: <MW4PR21MB200286756CEF98F65332C6EAC0E99@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
 <1626793023-13830-3-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1626793023-13830-3-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d479645-96cc-4920-7daa-08d951212c66
x-ms-traffictypediagnostic: MWHPR21MB0512:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB05127AC308A63DA72F509A03C0E99@MWHPR21MB0512.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFEYRZRsiDo0+e7bYOocZX0fo1O2yCaTXVy3BDOpA1oVcDLRCNt1yc8KPTFKyuQvbSPdj9Rna5xNAHZY231NJsNAjDn8ipDdo8b9Z7JVo4ohf2KX0V4OxZ1aCHoOfWWxniwJCVNrIPtb635CGRtefnuvu6tl0zTywBhbmGc/T/GQzWHU07KCHFScXCT3+N+2P50xOjnHxHK7SZ3ert9l9HIgMrWjk+7DFqoskeBZA9vzpUFy7+gZOwMLmnTPRT9SPtxBKzFaaLrrzxBnQTXRcjtKpwg2zql+9Nxme7KtyaFvSSqsWJ9zn/gO7/Pi7So+LltMq7HZZw5lkcfVKU3crU2CbzzjunqaQEON04S0QUPB2foVk0vlt7jgSpzbUL+W0wLKlJica1R7RgxqQtjHytEItAh46M52hgzUy7EDZzKDQIamYfkjTugrHP6MWWWiI9W93GUeWI0Xwyn8yCouREndTusTWCofz3lj/jKBWOtrP9hetACIywnLM6h+YZYAxcEMjUYaIQhsAjmXKYy3QLWQGHSVxqJrlfKGlPv68hsPhGApB7N+citrVF8D/8oRQBd8aFSTL7NXIG1HfN2LNtN5dZJbXZUHe38SbU8UGeNbI596JFpHeZFiv2jqGJ8spai3nYycRA4I5g3JJ/WzSWXUpEcgg5vb3FFNWXClt82maeRv/welt3nrfbZ5tqfzpGiqmbKh4MdZAqtRWyQTGhbKkYj7b7S4rl3CDcrSQ6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(33656002)(64756008)(52536014)(76116006)(66446008)(82960400001)(66556008)(82950400001)(122000001)(10290500003)(8936002)(55016002)(5660300002)(110136005)(4326008)(66476007)(38100700002)(186003)(66946007)(508600001)(921005)(86362001)(71200400001)(316002)(7696005)(107886003)(8676002)(9686003)(2906002)(83380400001)(8990500004)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pn/iG+pib7ta2A/mNsMO+EZ7hSATXgUEu72tLGwyJerI+gFtZr5zuLsh4Ops?=
 =?us-ascii?Q?ce6NRqCJ/W5icBU4XmSokEaQwhOgQyHqyfLov2uWrim5KEbe9lBjxbdYXLsv?=
 =?us-ascii?Q?ovKE6as9Z4dJhumUf9jLNJ7mA6w5/DRTvRbo6+lvvmlzF+d9HwPJJjRD2l0e?=
 =?us-ascii?Q?x4RQ8Q2LAkDbXN0nN/zafd7h662BMyZwDhaT2ZmGsbtK9vtijA995jNErJzJ?=
 =?us-ascii?Q?dhqRrYk3rTO/YlK89tLmkZOaalLULbvYf0waw8gT3yOzxYSjts9Vb9T8QWG+?=
 =?us-ascii?Q?4BfcBOssDvHD6WrmuVMrVhrPOWKBaZGzWW6BNSAelOPcxUJSH3T6Nh38wc9S?=
 =?us-ascii?Q?JgZqIQkK+WbYvcgMYyYj/Onn3zW8t3PVf2/4SV4PeKnTsbFGG3UC8yhGYQOi?=
 =?us-ascii?Q?nZQiFcqdO74wHuVoy/uQVgtcD5p+LqXSo0pWUogxdIR03MyQuUTrniyUeu+f?=
 =?us-ascii?Q?XihcQg2MQk/aTNWCgKTNJRtPRU4Xlm2A0FSByR7Sw1DPTx1WtonwpNzF7j35?=
 =?us-ascii?Q?3kPRRaynu1HA7vtYWZ7cJ/86KXSybstKnw8YWLlTxal6dY/klYvtzyClhvu5?=
 =?us-ascii?Q?BiKTuAKAXe93j8nxDtHCX0vgcd1RVqePeqJVG9JgO1Lhw1MTyuZimPyDfNQr?=
 =?us-ascii?Q?+CqRHogRyPo1xSFKaGXO/E+xSgs2lg8xBT8/YTwa11UUIA5gemtU4kieanUI?=
 =?us-ascii?Q?XmPELlKf4gnsZxo1hktNYeDdM77QlihsRK5Ek/cBLPjnF95j85MnQ/CKRNb3?=
 =?us-ascii?Q?5ZVUhvN5DVbK4ddxJi9fot9EAfT+WUhOrVQhdqC8QbWj9wcQz4cFyRXf9/Px?=
 =?us-ascii?Q?zNAMKmC9+2SltJI21L1K3/t/sBZVHy4HV3uFPTKTlk8vh5oGnZV8XRiLz4YZ?=
 =?us-ascii?Q?OvXiV0Ow/5eKn5DKBtKSs1eh39341rMiyJ0xQAgsYDnxzXu+rclMftdP42wN?=
 =?us-ascii?Q?9WWI8M4WMNmuhCqxEoIMrnRfDiASfnpx+up7iRGpR2FjjVeauDJdeH36jWoJ?=
 =?us-ascii?Q?BXNRqEb98pqHmnVCRkSUtXZLT3lo52T/EBDpsbG1eV7K7bADgTAHaSNYytNI?=
 =?us-ascii?Q?k6JGOtrawf8x6uDlo14/9jRT17eG6+RomJ84u02ic6RrNNFnOtmOOcbvmC7W?=
 =?us-ascii?Q?sXmuV5hA/FlZcQckdfDfUVZ0olu3cpqByjtjaaPFLjGgDtFSWzORCEagRbLZ?=
 =?us-ascii?Q?bx8NQstQKsz+mYLQBXNIN/8t2wuNTjRI/XEt0z8qmCKF8+l8kvrr6eikxH8o?=
 =?us-ascii?Q?ltZPSjp/jbdNT3YhFTMAkgfjB6ic3mbvYafNonrLjfM6jwX8rl+4jy3jteg1?=
 =?us-ascii?Q?LDiK7EwxRszMuxeOhh6YtND8EH3/y39BCAC6vBkiDHSdhjHueWJt50iWRpXT?=
 =?us-ascii?Q?nm0XGSbxaxvkgIUJ2dn8e1ZZda6/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d479645-96cc-4920-7daa-08d951212c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:08:36.9484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czISgSMQPG/kO6iuh26+Mo9lLkjJHWvlWX6lU6kBeJE1DLvr5342B991LukDR7EZCaCIqFPcKNr8kgBnWY8JdRGFWZGiKM0Yac7TEr6GjKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> Add a function to inform Hyper-V about a guest panic.
>=20
> This code is built only when CONFIG_HYPERV is enabled.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c | 52 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index 4c5dc0f..b54c347 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -127,3 +127,55 @@ u64 hv_get_vpreg(u32 msr)
>  	return output.as64.low;
>  }
>  EXPORT_SYMBOL_GPL(hv_get_vpreg);
> +
> +/*
> + * hyperv_report_panic - report a panic to Hyper-V.  This function uses
> + * the older version of the Hyper-V interface that admittedly doesn't
> + * pass enough information to be useful beyond just recording the
> + * occurrence of a panic. The parallel hv_kmsg_dump() uses the
> + * new interface that allows reporting 4 Kbytes of data, which is much
> + * more useful. Hyper-V on ARM64 always supports the newer interface, bu=
t
> + * we retain support for the older version because the sysadmin is allow=
ed
> + * to disable the newer version via sysctl in case of information securi=
ty
> + * concerns about the more verbose version.
> + */
> +void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
> +{
> +	static bool	panic_reported;
> +	u64		guest_id;
> +
> +	/* Don't report a panic to Hyper-V if we're not going to panic */
> +	if (in_die && !panic_on_oops)
> +		return;
> +
> +	/*
> +	 * We prefer to report panic on 'die' chain as we have proper
> +	 * registers to report, but if we miss it (e.g. on BUG()) we need
> +	 * to report it on 'panic'.
> +	 *
> +	 * Calling code in the 'die' and 'panic' paths ensures that only
> +	 * one CPU is running this code, so no atomicity is needed.
> +	 */
> +	if (panic_reported)
> +		return;
> +	panic_reported =3D true;
> +
> +	guest_id =3D hv_get_vpreg(HV_REGISTER_GUEST_OSID);
> +
> +	/*
> +	 * Hyper-V provides the ability to store only 5 values.
> +	 * Pick the passed in error value, the guest_id, the PC,
> +	 * and the SP.
> +	 */
> +	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->sp);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P4, 0);
> +
> +	/*
> +	 * Let Hyper-V know there is crash data available
> +	 */
> +	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
> +}
> +EXPORT_SYMBOL_GPL(hyperv_report_panic);
> --
> 1.8.3.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>

