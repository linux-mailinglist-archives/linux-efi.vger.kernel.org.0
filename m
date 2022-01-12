Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3F48BE88
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 07:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiALGXe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 01:23:34 -0500
Received: from mail-bo1ind01olkn0176.outbound.protection.outlook.com ([104.47.101.176]:3964
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231773AbiALGXe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jan 2022 01:23:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDMN4GM+KYubs96HZb8Dt43Aeo+ykeTu7Y8vCMvC8pJbCE/NCiCeCqNjj5Qae65t5fQ59a0L/UBZpu0aa1WhgXKtyL7E7W6dySZ5Ree2g611xWJCq8RSRTeqR6UoxrUrBaeOO/UsomhD4r+LJwkDmqY44ui5V9/3hC/2BWD76ZkQbvJOCrklY4bL7Hy1LjnfWim0s9WZHgeEtUrPK1bXejZPRIvSIIOu/Vnz8id4zaoI1wHXVj79SKjcDqSkfKsOPL79nhX0WWb8wadlCJTAcWZytGGuPNYgaAe+6ET65MpxDSeeNjgKRuqvbWPergQWrAmO4t8heUYkhguLCIhY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuGGxQyLu1WiW4aGs6UAQlr2bpex3EsJVdY9ByqzT5I=;
 b=iUD5yIoy+GThD9KcuJjlv+v2TRN/OVFzER7OW2vIOYyWZ5zwvNZtHNBuivmSfzw2Vzfb2FZmCKmqrVaTIP3WxUlwsF9i7yDvLQ7XfoB9q4YoI1HeN9WOnsICaj0UQ3bOMGmol24lpJ1GuTZ+4bhPY7iQHUhP3ooMK3XYcpStifX7tqhT6gcaLYPuQBOBlUbQMzk7yzBRurqZijPrsR9no6nfzzs1elb1Swo47rXUo7iiFe3pJ2GRP+fJBb+ITvZZL/Chigx3a+EnndRqidi4bmEx0VVeRujefdA0Dcj4wEAHPm/VT4H/n/QwjX0LBSezBJGo+RDdluW/U0TaQ4QFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuGGxQyLu1WiW4aGs6UAQlr2bpex3EsJVdY9ByqzT5I=;
 b=DIO5NYa/p1+0F5p+3Rl2oqI/f0Fx3BWvnFtpN62DlDVh9stCOWT5IIsIDzrn+wJ+maASpNwiz1xNMj5d12nHZxQju8VCnl3wgoDZnHSw8yVkKuz5Fr5mgCenBaxkjL4wHlNXN0bnB3NpyvXFkNUcQW5VPkjnNzA6VALflD1aVxO8rJP/bjs0pVXLF7d7+AUCUWnCt/UrXPNDDn+unD4lvSUOSlntfS0ofXxt16VojMF7hCogFiHuXMGPVwJk7gGJtGOAMD0dFRcOHNOhKvkXMtN25bTGRcIfq1sPmgmfEinABkn31LoelKXBqnuW5KPSI12AQ5f+HlldGTblnSGuLw==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB5055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 06:23:29 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 06:23:29 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
Thread-Topic: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
Thread-Index: AQHYBjftpMq4zkRpy0ySdpCXbzTJeKxcamkAgAAHMYCAAALOgIAAEuaAgAJmE4A=
Date:   Wed, 12 Jan 2022 06:23:29 +0000
Message-ID: <787447CE-C7DC-4EA3-B498-6FEA88C523A1@live.com>
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
 <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
 <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com>
 <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
 <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
In-Reply-To: <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [y2Ie9BNS8ChqS3Vbj409nNrwiVOvS7t4dLRkmWmc4nhborsIDmbvPbcJmpy9+JBQ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61bb605a-43ed-4634-f37f-08d9d5940ce6
x-ms-traffictypediagnostic: PNZPR01MB5055:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2Kv7LGFai97YqpCBvIWGQdaP2dQxrkJex/a/N0rL4oRUYckBIFqK6nPrxWWqP7tvF0lO5n81FkMdGisaTKHYB2pOHW4xaL25uwVNPJmO5OhXz/tzsFeVtKQ/KUFZPJRoNMDXjn2s4iviBdjxRw6pycegCTVSrVJsfMj7gQZyfukK3g6LoW8Fntlf9kRID/Wh4lr8icQPsIbzt84Bxty7EDNQu97PahUS5CJi4NEgD/sl8SgFiJSOIu50mkU3DAcTsWaId5PV9WuUE9/Bvw+skyGtWid3niS0AYDq6Km9jHRTaOPfrJPSdubfzbvcwmAxLdfHqOBWmxHJso1lmxnc2uBQSf9yLoxXKcKQnjf2Yoyod6FiUMZk9rLbFf93uCWB9Km/d3e9gVQjwQN5MPbVTKLF0woQ/q6LE2cA9rm/GlRfv9+5w0T/Iht8q6WzHH/aLMVexYCUtm5alLNKVn2r/PXik7AA5R/uqK3CCqGrCpxrYmJ7GU0fovtX7s+FTIU3QYe+VrcOElGFAweGhD88FalVuFV0V5IY6bkundUgkQ3VOlfmCibndhaauOpCnjoZkplJ4+UVOauVU5yGlEDRw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0iL4dCiejjV1wGZaWWmAvgcp+nQCj8V7umgC5SoY6OzYdFY4Z3nD3LVabb8O?=
 =?us-ascii?Q?SmphiFM4pTklB05qXqft4u9Uz+K7b39eZxUb0s8ZJjCv1Z/NJxR+eH4v4alr?=
 =?us-ascii?Q?IWCteobkLlJUUICc3yQQvN5FUjSYVAB2l0SvnhyOHr403Ai+id9z7hESqUox?=
 =?us-ascii?Q?xRtRKmcOJyJFDl3XSvnoyvIN2z0ytCBU/buNJPbkmE/DXqodF5cr5Do8oMdt?=
 =?us-ascii?Q?8KNpgHHObHeScShompxfXGyYucM4TSBRWLIrkzMCamqfckcYx3OABwryHoyN?=
 =?us-ascii?Q?pw0MTwgai/u+e9wKAC1pLwTq5uENg4KUipvPJ+Seh4ZIDPRJRnD7DpMjjJOD?=
 =?us-ascii?Q?OzR/DSUAIplQo3pWVphPknRHLb8VwD5yfDAMU+mhvO++HfyPmyc+zl0OrvCy?=
 =?us-ascii?Q?rCDv7Bmkgfidtmd15rsbHWrMTNQ36AcEx5QORv68GzQYISCFbF/rtbA/StHU?=
 =?us-ascii?Q?8+IiksXSfQyYLWKXPdFBLYbshpN7UI5SPrW3N31JL0nCcnuN/QiCodD+IEkg?=
 =?us-ascii?Q?82vacstcFatE27blAremM5a6uqkSjvaNpA4XiH3zy2eozfRy6Pflpr4JODIM?=
 =?us-ascii?Q?HLsXUhSPVQKoRAP+ZnJzJV4pyzHYRfY0np9i0SCbg4PimTOo4g4t8douuAac?=
 =?us-ascii?Q?8DzYqY+zhNqpPKBHV4Lnp+gdhnRCuPx7Gsu+y0EJLyr4NmYaeRbaQ2ac7v1E?=
 =?us-ascii?Q?ybrR7WE4wxeVhm8lblEJGCHDsdELoRwsluO19O4lihrqUX+Rs12Kh/X8EB35?=
 =?us-ascii?Q?Zfa1D2I8Kglsjn6QOgWLXg7CrvmnBqi5lW7MGLlG4VZmPhLwnIsz6sxuidl5?=
 =?us-ascii?Q?ytWdkDp35Ev3tAKXf6vvZcsBQwURlkfRn3vajDFKyDt9DjQ9Ca/MxmtKaVZP?=
 =?us-ascii?Q?rAtZVQPlLoGWsu2SjatLuoSzFrapEFbTbwiUKGwer60+CFfUpxad0N1Qtd7g?=
 =?us-ascii?Q?cde3HgfablinlIkb+Xbt5DyKxKCs7yFIYGXKpTOeJrQKTD7IFxnqjuxWXxAW?=
 =?us-ascii?Q?UhjfzHuu6rFOf3SYax+EuIDwqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37EBA0AA63D0C242840EFF07BA9E5B27@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bb605a-43ed-4634-f37f-08d9d5940ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 06:23:29.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB5055
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard
As I said before, if I apply the patch below, the things work well
>=20
> Can you check whether things work as before after applying the change bel=
ow?
>=20
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 147c30a81f15..d7203355cc69 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -399,7 +399,7 @@ static int __init efi_systab_init(unsigned long phys)
>                efi_nr_tables           =3D systab32->nr_tables;
>        }
>=20
> -       efi.runtime_version =3D hdr->revision;
> +       efi.runtime_version =3D EFI_1_10_SYSTEM_TABLE_REVISION;
>=20
>        efi_systab_report_header(hdr, efi_fw_vendor);
>        early_memunmap(p, size);

Now, I tried to quirk on the basis of DMI data for some t2 Macs using this =
patch :-

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81..0d73d7709 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -44,6 +44,7 @@
 #include <linux/io.h>
 #include <linux/reboot.h>
 #include <linux/bcd.h>
+#include <linux/dmi.h>
=20
 #include <asm/setup.h>
 #include <asm/efi.h>
@@ -339,6 +340,52 @@ void __init efi_print_memmap(void)
 	}
 }
=20
+static const struct dmi_system_id apple_use_old_runtime_version[] =3D {
+	{
+		 .matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{
+		 .matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,2"),
+		},
+	},
+	{
+		 .matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
+		},
+	},
+	{
+		 .matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir8,1"),
+		},
+	},
+	{
+		 .matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir8,2"),
+		},
+	},
+	{
+		 .matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,1"),
+		},
+	},
+	{
+		 .matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,2"),
+		},
+	},
+	{ }
+};
+
 static int __init efi_systab_init(unsigned long phys)
 {
 	int size =3D efi_enabled(EFI_64BIT) ? sizeof(efi_system_table_64_t)
@@ -347,6 +394,7 @@ static int __init efi_systab_init(unsigned long phys)
 	bool over4g =3D false;
 	void *p;
 	int ret;
+	const struct dmi_system_id *dmi_id;
=20
 	hdr =3D p =3D early_memremap_ro(phys, size);
 	if (p =3D=3D NULL) {
@@ -398,8 +446,15 @@ static int __init efi_systab_init(unsigned long phys)
 		efi_config_table	=3D systab32->tables;
 		efi_nr_tables		=3D systab32->nr_tables;
 	}
-
-	efi.runtime_version =3D hdr->revision;
+=09
+	dmi_id =3D dmi_first_match(apple_use_old_runtime_version);
+	if (dmi_id) {
+		efi.runtime_version =3D EFI_1_10_SYSTEM_TABLE_REVISION;
+		pr_info("T2 Mac detected. Using runtime service version 1.10\n");
+	}
+	else {
+		efi.runtime_version =3D hdr->revision;
+	}
=20
 	efi_systab_report_header(hdr, efi_fw_vendor);
 	early_memunmap(p, size);
--=20
2.25.1

But, now the issue doesn't seen to get resolved
Could you help me in this?=
