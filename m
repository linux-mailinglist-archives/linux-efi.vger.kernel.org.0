Return-Path: <linux-efi+bounces-1330-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFDE91D368
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 21:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F4A1F210BA
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6815279A;
	Sun, 30 Jun 2024 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TgCUbd7d"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2039.outbound.protection.outlook.com [40.92.103.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6422094;
	Sun, 30 Jun 2024 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719775501; cv=fail; b=Qt3bw30t8TzZuiKpzXu3z10KsNmps3yqQCxUPyOcw4YoJSIuaw8AqembVPAxd1N8XvZ+EW/YwmlxoDkI0MVArEy81TbWEpXoL3oG3hRGSgXvY2rAh6C618p5JYE3WW7vwpo5N+XonuihWuToBeutIVNZ2wW3oVRAQ8Gjko6CllY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719775501; c=relaxed/simple;
	bh=xsVhpxSe0ap9PedKD0bcUV28LFfOcKDLOBhMcmGllx0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mBntBWk5YVLKNkqjr0AxEXHwFEJeZ8ocoIYl5tZAvoIPSaExobhr0z32YbTVM3v9gHJsf77yzjKFX/chaDSBf4AGxpnwmKFPdcxSmaoj60Uak+0JK/M+t7jFV4T20v5+1ggWSO3FxQuWxEZJcjD5Us/fB4T8Z1gfMX+vauH7gMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TgCUbd7d; arc=fail smtp.client-ip=40.92.103.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9CoakKPt3I29ooC6p010EgW+qYsu7k1LxQYBL1tqKfMeVrJ541RZo4+8YJtJF/rXhu+Y5VqSowUiaV6xA7tsh7MFm1EGojood//CvJ272/a2o5hQbOJMCsLq5gIG6BMrlW8m8z6myu+1PTDWzTfrrXAtb5Iu8UFDf/N0M61slNbURA8graY0vs3B2W9/lNry06x8+vlKpe5PkPlkENquMTvtaSGnobgbNLxbClmcn+WbFP+Uqkel2wEir0XgHMVMrqUMN8SeP+WhMKgdYoJdT3o+MoThGoh+vprESouLd7c1zND9agywheOI6LzPn27fEU263TtKgQW0UtAskR4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7BenBYfnSQ5rTybFF2nUErtFsChugacaoeahzpAl60=;
 b=Ku6tdU9VeVMDad8Dzgz1XPytS/uDCnUbSobrjGgGo6EPKBptdciwPtPIFMM+D73Cvit2/yJjk8VAdS+sFdHX5aUnr9jvq23+/jSNGbAonQAO+9m3qFrGnNq3eBycoTyOLr3g0avkmNQXKNh0DWAhFMkK+k+u5xbLiMVBwYoChoDfKwYek3CmqLWWsJKuPxuAFsyyzfKxm1QyjOBMq+f5cDN2YRsVWZYaFkwQgdQb4DWRGHBFFBmoyrc2hcVLhNwmGR4Cztcgw59nC55o9SQP9eS4+gv8lSNqVKlFFCBEJYrfZkRpSDg8aklDIZGM0YmBNB4z+iUJevTaxL/d+q4trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7BenBYfnSQ5rTybFF2nUErtFsChugacaoeahzpAl60=;
 b=TgCUbd7dF4SpMvkPAoE7/SkR3JLhQg1tAO52I13RT2XMUrF1GL2zgpxA/GtJs48CvXprNIJyEr9d9Kt0Vbg9t1N6IhE+HMAU2RCqJFPkSSCZVyVmjumQDEB6XBGADuiP2SjJhCqJn+7RC3Nmor6qtk0A+gDzttCtoENG0C9Gl0X3WV8tfttaIX07Rl1gsZ0y7QeCUdYuujk5+3Dthu+n5TKepF5vTyRISgNMASvkJYAWqkWHTAaWadG8pCuDX5g0JOtiUeKXmlCXCNdckRGUxhco/QKptBaUKPbV048af5tMQ+C90Lq6P98qnFY66df25GRba3kmY3PMFZMxvVOkAA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB2049.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Sun, 30 Jun 2024 19:24:54 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Sun, 30 Jun 2024
 19:24:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	Lukas Wunner <lukas@wunner.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay
	<kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v2] efi: libstub: add support for the apple_set_os protocol
Thread-Topic: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Thread-Index: AQHayyMvFlnFTIp0RUWwNwMGUJGcQg==
Date: Sun, 30 Jun 2024 19:24:54 +0000
Message-ID: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [8/N0KH7yCT8WQmCVnzOJORy/yOueVHKzkaWgoFPy+5wAnhypcrfgxrQswxnCtK5O]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB2049:EE_
x-ms-office365-filtering-correlation-id: 8491d23d-6a5f-41e3-5455-08dc993a51dd
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|102099032|4302099013|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 4CzqB8YYOr8Ml8lrytEzRKF/tX9AecfOsHCyUQaNiIY6BEVAlw7na/8iUeG8+vXsZc8ekKh83nsTWZ9gCcJ2ICIJuhGyHGlV8Btnvz9Qf5Tr40GR09q3DAtAttpScbpiMr+g8ajDGHbbCmeEgZN6mJMsw6JVofy8obPngJbuKeN54TV2Ob+GcJ/i/aofY5+rVcjl/PsACGWGqgZrrP3Xl6cAM5Ujkmn0PjjdODO24IEmwAZ0H6rkgaRFY3wqAxz43Px6lZIvtFy11HiqafzGqsA38B+61i8CN+zu2y/bv/ybCz5v6X7DvztOMf6mPWp4eYlYQqY3hPVd+6i9Nb1rbkyvR5B9JHafcYb2sFyYZtbJ2n96NZvWL/XXRFGOOg8KyQtHF+OtxgP4yXb3vv8/JhS+hI8NE0CJVBuz1Vh3ECxKTCNZKtK5xUtYmjCIK8cMZyLv/Ct7x7qPTwS+vVFlv72UzlC9AYS2LqAQtV4iW4UTTXjWrbjq/mBNVv0QgU2Bbdzpwn9wBpoBbPvHDR+HTBYM7nnUX+bybykpp+cWtmttWjFKIb2Tj/uxVHMge0hgh0Ut9deRKEKaL453cR7mvk4hSU1rR4fobxClCd/dsoBaiBNIg+DhjL6v69aoqdUcN1jysl1F2ak/Q/H3vZbpsJvpoNbiIkK6cgMefLV/EzDdbi/8DXrXbRpLb+PIqqLLHGQW9Ql8BcLP1EsOEvyaLs5BEY1JT++OL5rvm7XuI/8=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vr0MGQ/Y6J72pgUH9R6aJErZkml5VkOLxyatRy5Rav+DXnYf0VRqK4oywc16?=
 =?us-ascii?Q?P56GUD7oWrC0dfRXfiw9OV9qYIcr0XqdjwhEIgoCstmrB8eRd5agIO38gqkm?=
 =?us-ascii?Q?Zcwg56iOICSfDnvGmQWVZWWsKSE/urDE22Xp3HeKWaOxCe2HthmCkDGGTRU1?=
 =?us-ascii?Q?nsF+LNIytd/frPy0Q+t9lWmoFaajcwI6Ze9B5S+URzvNqMkV3f/WvTMlmaxi?=
 =?us-ascii?Q?9Xl8E5p7qf8sR1t5TdHrqXGqylE/RLKvezfre/TNSKVlI4lyHb1gwdiaeca6?=
 =?us-ascii?Q?NRK0CG8DWpIHUP2nNKEB84BzA5QITQcrdR8+3YuEwtjjewj990oI3f3SbC9t?=
 =?us-ascii?Q?gkHvNotZcxCrntJv2+g+tWPOSPECWUn8cPMlANsmFm+bbXLmrwE35fXVKHrL?=
 =?us-ascii?Q?N+b+put/Z9mVMtd1aAoa5SppvSH4Qpmdzn/RbVLokVxBbPZQCdmJvPvfzSpM?=
 =?us-ascii?Q?s5NB8vWnz4fwxK0dl4sCmhQOfMwuTqUy4TJNLnOsuYXlvf8Peg8S7I6dP3Yz?=
 =?us-ascii?Q?MDimWqgi4qStqiIcPlZ8QCWD3N7znWI8iQUwWT1i5JkCxlGKU+PXzTry6m1e?=
 =?us-ascii?Q?2+AEXuQONvzapFhlYJYpV/KXlM+2NMWP59EBFrluHJ1xE/qI9t6HX4LlrWd+?=
 =?us-ascii?Q?HoerByS4Gl42vuXlWIbAsGedZ05wQwi0K2qdfrNbJqG4AIEX5CJ48ISmRev5?=
 =?us-ascii?Q?qbgRqWsGQqu3jfuNI5bhnVXX6Lz9wfTZ7Nr4MmyErHdeK4fXiYGjWz39oHG0?=
 =?us-ascii?Q?/0UIJSonquj/6EKKMk6l/dvJmKCHbcjQXP58y4WaWlHgDHOC1dXdxNa+TARZ?=
 =?us-ascii?Q?ca54pOAAuubgVGSxgtxDoulvIEDiZyIYGDBsVlrpguIyOfiAMSnlul5iXi4F?=
 =?us-ascii?Q?YiaEsWlkRhrj1EGbp9VX+QLgaYBRXH0lkQ3yt9GSgjA5U1m7eDuF1qfMQJ17?=
 =?us-ascii?Q?iIgvzeDgYUOVI76GfbjPT2BHk6ZuyrIXJRf6gY8WkVHf1J1SoaiHmISmGyr3?=
 =?us-ascii?Q?2tSEuVlsxaZH7OsKRhAXVzDr7HqMZigdtiF+kDXozp6jmEiZK55D9vUTzSxP?=
 =?us-ascii?Q?WhSrF5sv7tDbGKHVz07gbJw5bFtpG/xoaA+GEqKL7RAYzEJGF6ULvqfXwg5C?=
 =?us-ascii?Q?kDybYDP9+/FAujdr4ozHc5osVJi4Ykr7oLRM06lBZg7JkMz2jU1ZGqkMGN/5?=
 =?us-ascii?Q?Y6WZdpvRen2C0LJjLmzTAgAceUIU7MdHQtUgQkbEQzLlhCWasaLRqqPiWHMZ?=
 =?us-ascii?Q?EPQ5xh4roYZUpRZK/nBNSwubFG1zmwLesMHiWVFxe3OOVynYOtWMtRJa/p3m?=
 =?us-ascii?Q?eFzT6hIPh848eWWlTOl1KWU/?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39261093FEF91E49AF92DD08E9A19542@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8491d23d-6a5f-41e3-5455-08dc993a51dd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 19:24:54.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2049

From: Aditya Garg <gargaditya08@live.com>

0c18184de990 ("platform/x86: apple-gmux: support MMIO gmux on T2 Macs")
brought support for T2 Macs in apple-gmux. But in order to use dual GPU,
the integrated GPU has to be enabled. On such dual GPU EFI Macs, the EFI
stub needs to report that it is booting macOS in order to prevent the
firmware from disabling the iGPU.

This patch is also applicable for some non T2 Intel Macs.

Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html

Credits also goto Kerem Karabay <kekrby@gmail.com> for helping porting
the patch to the Linux kernel.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/firmware/efi/libstub/efistub.h  | 15 +++++++++++
 drivers/firmware/efi/libstub/x86-stub.c | 33 ++++++++++++++++++++++---
 include/linux/efi.h                     |  1 +
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/=
libstub/efistub.h
index 27abb4ce0..4257a8b7c 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -825,6 +825,21 @@ union apple_properties_protocol {
 	} mixed_mode;
 };
=20
+typedef union apple_set_os_protocol apple_set_os_protocol_t;
+
+union apple_set_os_protocol {
+	struct {
+		unsigned long version;
+		efi_status_t (__efiapi *set_os_version) (const char *);
+		efi_status_t (__efiapi *set_os_vendor) (const char *);
+	};
+	struct {
+		u32 version;
+		u32 set_os_version;
+		u32 set_os_vendor;
+	} mixed_mode;
+};
+
 typedef u32 efi_tcg2_event_log_format;
=20
 #define INITRD_EVENT_TAG_ID 0x8F3B22ECU
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi=
/libstub/x86-stub.c
index 1983fd3bf..1eea4f7ba 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -225,6 +225,30 @@ static void retrieve_apple_device_properties(struct bo=
ot_params *boot_params)
 	}
 }
=20
+static void apple_set_os(void)
+{
+	efi_guid_t guid =3D APPLE_SET_OS_PROTOCOL_GUID;
+	apple_set_os_protocol_t *set_os;
+	efi_status_t status;
+
+	status =3D efi_bs_call(locate_protocol, &guid, NULL, (void **)&set_os);
+	if (status !=3D EFI_SUCCESS)
+		return;
+
+	if (efi_table_attr(set_os, version) >=3D 2) {
+		status =3D efi_fn_call(set_os, set_os_vendor, "Apple Inc.");
+		if (status !=3D EFI_SUCCESS)
+			efi_err("Failed to set OS vendor via apple_set_os\n");
+	}
+
+	/* The version being set doesn't seem to matter */
+	if (efi_table_attr(set_os, version) > 0) {
+		status =3D efi_fn_call(set_os, set_os_version, "Mac OS X 10.9");
+		if (status !=3D EFI_SUCCESS)
+			efi_err("Failed to set OS version via apple_set_os\n");
+	}
+}
+
 efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 						unsigned long size)
 {
@@ -335,9 +359,12 @@ static const efi_char16_t apple[] =3D L"Apple";
=20
 static void setup_quirks(struct boot_params *boot_params)
 {
-	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
-	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
-		retrieve_apple_device_properties(boot_params);
+	if (!memcmp(efistub_fw_vendor(), apple, sizeof(apple))) {
+		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES)) {
+			retrieve_apple_device_properties(boot_params);
+		}
+		apple_set_os();
+	}
 }
=20
 /*
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 418e55545..e28873eb1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -385,6 +385,7 @@ void efi_native_runtime_setup(void);
 #define EFI_MEMORY_ATTRIBUTES_TABLE_GUID	EFI_GUID(0xdcfa911d, 0x26eb, 0x46=
9f,  0xa2, 0x20, 0x38, 0xb7, 0xdc, 0x46, 0x12, 0x20)
 #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4, =
 0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44f=
b,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
+#define APPLE_SET_OS_PROTOCOL_GUID		EFI_GUID(0xc5c5da95, 0x7d5c, 0x45e6,  =
0xb2, 0xf1, 0x3f, 0xd5, 0x2b, 0xb1, 0x00, 0x77)
 #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x9=
3, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
 #define EFI_TCG2_FINAL_EVENTS_TABLE_GUID	EFI_GUID(0x1e2ed096, 0x30e2, 0x42=
54,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2, =
 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
--=20
2.39.3 (Apple Git-146)


