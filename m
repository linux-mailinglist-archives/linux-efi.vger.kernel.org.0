Return-Path: <linux-efi+bounces-1316-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6391D006
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 06:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77C61F21697
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 04:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25DF28DB3;
	Sun, 30 Jun 2024 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="W1/AIFR6"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2026.outbound.protection.outlook.com [40.92.103.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0F23A6;
	Sun, 30 Jun 2024 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719722583; cv=fail; b=VSxUeEWZa8L6MaC+jclxt+2wKxpSrriCVFkMSlMQ+jnAKnqfbK9fgvYmYI1trO5vl4j0tUQGWxXJT8we5Ox/T4XPjsJmEOJrZA0gzqRcM/mtFHqRJzh88dmLg9Xq2JBi/pEkndtz+dUXWjm+UEIUFNqhg4DQpMtXek49NMhVvV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719722583; c=relaxed/simple;
	bh=y2hNzU2BKvYrAwH6yZxWKtTogInzuLKv0GJ+V2pBBas=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=joVz+dIMBy4NhQcjEIsw+21JQ8DZTk80H3LafL/WObq3q6ARA6AGrskw/6mlkS8YayQ+aYOEHC8vh35Xqkpqjvz/tPsZ2SjnWsypTy9yQ5W82WAlxf0ctU+/7WTJu4fiP0Ci5bD1l6AgB1CDNtTu06xYNYmjcLlFpOKX4+PuwuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=W1/AIFR6; arc=fail smtp.client-ip=40.92.103.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OydP28kl1iRHc4X2eu/VgzEtKalOTKc5rlSeVcmp7cOoXOYVANMZlPEKoqa6VDMEtSRJ/Vk2Xp54pirnRIT8TmUWQiX9ZN84x7NwoY9QsvZj/KRMjyFAgsaCzLYIaxexxXQUDDlzy1UyUAlfjLJXzUYjANNC8YXkY0bHJYwn5vd/E9IzmleJ3jkpQkbl9XUvMDBkCCCg5ByJ1Co40r5l0racrCp7OzvOT6MNXr4foQY5MRYZAS2z7euJYyFdPKlG3A3L1nHW7DXajsEeTS5ky96YB42lzYdKaCZpU3XAMTyK8q28tJfcgYqdwW6Nrw1rmYtEt6+BMCFXsz7VrjfNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGiuhNLd+zt22je608tdVtBGK7yrGLMwjXGE8YMZm+Y=;
 b=iF+cqeOlXWF6h5VHgbjgh7xIxQzlYpOEkRm/IjsbU7f1rGB9a5KAQI8MVmmc7QHYb5OVChz/lj62f/3fPHUwYv5fdsqExeNRz41uj40VOPPkloVYB/yWrnYYKeZE/nnd2awOutdXIiYsYfI/Ub3zVN+rx2feOIqznHB8AP9ZJ1UmLO6y4ajmSTWTwmh+WW2GJZ88pz9QmVe7elJTlXzv4A1PqAcbw2tKiwrVUOGyXjmBTGfi65w3E+tCKfxBlG81CBuTly6rQQ0jX7NIinTibVRYZmIDS2V36oBONIYQZIJOqvTN5wLw40KYrKeFswfOF6pkoXiamfmBoCeIy4acwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGiuhNLd+zt22je608tdVtBGK7yrGLMwjXGE8YMZm+Y=;
 b=W1/AIFR6ZFOq7iWraxMLh70q5ntp38YMDZHPCqXWw1aoSsKSvBmgRsTGb1CR+1anC9YV7J2dSsxtqzMLzODiIQk0CSxRgwIFZJ+BOxMnj3k7emAdDlL+dsmfcytNJdsxOC64SnVxi0k6QZqU1RB1l7sgxvxClUHJlphnc5nkgNQLHbG5VvztPQlvtDkl7pzidx9XNd+nHT26RO2AdJT4pQpgSwYY85wM7kIYxDnRKsT8GB9YPoM9sqx++DDbAETAXq+k8/pZsI7F5kKd2OUi+dH86QpA1pWutKUghZClV0l/j+G0F3ImZ/V7ldPkGvya1HmysG460I/fqJYfQmT/FQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB0476.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:121::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sun, 30 Jun 2024 04:42:55 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 04:42:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Subject: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Topic: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Index: AQHayqf5lax52sGQGEOGg2rscpuZMw==
Date: Sun, 30 Jun 2024 04:42:55 +0000
Message-ID: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [fvZo6JfLGEB3BYx2zD2NwhYjtpGSJVcol4mceK61hB39RkE/r9dfHvdTAHNd4omw]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB0476:EE_
x-ms-office365-filtering-correlation-id: 44bddc7d-b17f-4aa7-eaad-08dc98bf1c09
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|102099032|440099028|3412199025|4302099013|1602099012;
x-microsoft-antispam-message-info:
 jzsjXbWNusy9/VY0zQJad6h8UTW7pkfzQPVLOJ4pY1eabj7XNmskqGbi4Ny5FZiyZ/LJj6Oo+JxtFgF+m6mNitNEFqskbWA6sZn2fj4fJR4V1SlCzu5l29TLjP46J4Q/j94MFxvMaBAm1tbb0RFhP9kdKItJYTHt0N4Gztyx8scGYHi2O+IfPdWCYBH7mjD6KfwddE6tGa2zdyy9xBRAH6wWtoGRfYiHJLRv4O5YlRbvjiUtaIpSA1N93k/3o7RF1k1fawYLkER7g3hehZOzycOd4MC4zhlT4h8YfgqrOJI/j1s0csz2nVuIZbwmEL1BjjBMeM7wSS0H+S+S36NP2RHvWipF4vcojb0KvDivwT1w1GdzYyzM3FJJ9mGToV+561woO2Wtyvc+hdc+Gez0Shpby9SZ9SwPdX1+Z5Wk12SZza5/OQTnhonOXHhqSSIR+XnABlzQ+Fhg/gptJS1d+6JyyBS8ZCnXmlUq1T0HBF4DAnFEljjuQVeHSd73K5prb2Mh9+RM2aQ0FWG95yeMCGQyvzPvbZjL5HDHVTiRulGvNp1/mzO+U8t9mODhLkmr1/BoaYNNuI1nqUTO6FzNCLeJ4+kXvtyxh67nbzdCZOVySiZaAd5NOrbdbEYJ2k1DZkg+Qji5Ae77t8x0PxRGHGkdXt9/Fz4VH113f/iN6ijcH0jb1XrL494zazm7/0ONZ8459QoeZKpGVjYO2gc5Fz3HgO1Q7uVGh7tXY10goqY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qOUfkf/+bgLoGoeTltZkj/ggHt66Mxd+P+45UsTtro2JtuW6joPYjjIB9iw7?=
 =?us-ascii?Q?HX4r+diHaq6fQALi2rg23GEIw1qNInOaX/5GstkYxfdimdDWmJV1kOPNNkge?=
 =?us-ascii?Q?uwlrSmHEheBAGvVRWPouql/l3UMukEC7lcuybga6/nQbF2NTJyuo5gwLwvb3?=
 =?us-ascii?Q?SViQcZwmMMqs9f9zZgJLUJis1vq6TrM+CGW4lakENFl42KRduSBtRjLIOBKm?=
 =?us-ascii?Q?pr3rgakOCP68L32hhoqwGoZhlYLqFRrskVhcgicx/UxGchfot7fkcK223jvO?=
 =?us-ascii?Q?y3/hnlAC2McmrLIYfeuSh5/KsdYmPGzKle0lWfB/B7BIwrHwJOJzb8/ZWZFE?=
 =?us-ascii?Q?r4/Od9d8ki1TLQU2GJMDwPuLPqSm9/V9GHXHnvUKw14QP0yk7vU1kWsCXtP4?=
 =?us-ascii?Q?7X5+/FVCRSMpmgP9sQ/y0Ne7PN+7V6M3aZ0Qb5UDny5SmSjvxDmuyuE+J8uF?=
 =?us-ascii?Q?FZh/fxbVdqmhYcwF3ZQ3GcVW+UomHtw1V4EjjfdPJPV/z4hngvbmkSw+mv3U?=
 =?us-ascii?Q?drJ3f3FZfh1X+opS1cvdRNxcnMF0ZSIqV0g7oByI1PwoCcU3rZmX2AeHzLr3?=
 =?us-ascii?Q?IMt2xX/0cWQTXDKgw/YLjvv8dk2CmTGzZQ2LSZOg1moGTGEuHSnZ8bl0nNjX?=
 =?us-ascii?Q?n+mDFFJdb45nrtz7AJZU4O5qFswThaVzBMqgIpqnAwBKGWqZ7agbaLXOiHOn?=
 =?us-ascii?Q?mk3ucLrnx25jScIw18o1Uh5nCI+mz1OCQG4rpmLjgqz05UTfvgS5DGRl/oI/?=
 =?us-ascii?Q?0X0uVn67lRoJnlzCAEfHPvYTyFbN3vXd5uC0YIqQqvof2iPYnBTIcH9WE/Gt?=
 =?us-ascii?Q?CneVHjpaqoGMw2ShUwRyNmNmvBEEQz0ebxKhrsK0BKbJpYDzNwl2KeC5IHnx?=
 =?us-ascii?Q?UcteKwFuYfRUQ7rd1UP1LzNqkFnwunJJFtG3WSYndOj90U2q5Bafqm+EwOt/?=
 =?us-ascii?Q?w2X4fo/DqbubGDCClc1jgVAP3wmMyUN9/RNmJXjxlh+4+9aXLzi5OZ89ioGY?=
 =?us-ascii?Q?JeFJjIByvfvutcdCoIM0Uv45NfRDICM2NYEGWFzdlqyjjBo+RDM/FdVzqLFD?=
 =?us-ascii?Q?9/rqWbW5HPvTiLksn1bv7mriZ+CycRYp7jdgI9mey7JUzKVUVevLM6I7sOve?=
 =?us-ascii?Q?+zk1a3fSH+/UwE8Ku+gvC9LFXoCnR/QgLbmBg2HCYFbFk8zQcDbYFdRnwMmE?=
 =?us-ascii?Q?fRA8cntsjDWcUIBRaagTdz1oYK9CE3XTNagu19jg96jbMht5kX2/aJGpzDeE?=
 =?us-ascii?Q?3LKBZ7ai3XIrrZwWmy5Y4BJA+nBXsYLtrHevxjgHRt1gqGT16T72W2IdBnD+?=
 =?us-ascii?Q?9jbYv8iXXxmEUGQ7DrIu/xZK?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E0DFB4C89E47C4B86EA2FD55368F767@INDP287.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bddc7d-b17f-4aa7-eaad-08dc98bf1c09
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 04:42:55.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0476

From: Aditya Garg <gargaditya08@live.com>

Commit 0c18184de990 brought support for T2 Macs in apple-gmux. But in order=
 to
use dual GPU, the integrated GPU has to be enabled. On such dual GPU EFI Ma=
cs,
the EFI stub needs to report that it is booting macOS in order to prevent t=
he
firmware from disabling the iGPU.

This patch is also applicable for some non T2 Intel Macs.

Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html

Credits also goto Kerem Karabay <kekrby@gmail.com> for helping porting the =
patch
to the Linux kernel.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 ++
 .../firmware/efi/libstub/efi-stub-helper.c    |  3 +++
 drivers/firmware/efi/libstub/efistub.h        | 14 ++++++++++
 drivers/firmware/efi/libstub/x86-stub.c       | 27 +++++++++++++++++++
 include/linux/efi.h                           |  1 +
 5 files changed, 47 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 41644336e..cbd4697a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -399,6 +399,8 @@
 			      useful so that a dump capture kernel won't be
 			      shot down by NMI
=20
+	apple_set_os	[KNL] Report that macOS is being booted to the firmware
+
 	autoconf=3D	[IPV6]
 			See Documentation/networking/ipv6.rst.
=20
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmw=
are/efi/libstub/efi-stub-helper.c
index bfa30625f..3d99acc1a 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -19,6 +19,7 @@
 bool efi_nochunk;
 bool efi_nokaslr =3D !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_novamap;
+bool efi_apple_set_os;
=20
 static bool efi_noinitrd;
 static bool efi_nosoftreserve;
@@ -73,6 +74,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_loglevel =3D CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd =3D true;
+		} else if (!strcmp(param, "apple_set_os")) {
+			efi_apple_set_os =3D true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl =3D true;
 		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/=
libstub/efistub.h
index 212687c30..21b414d09 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -38,6 +38,7 @@ extern bool efi_nochunk;
 extern int efi_loglevel;
 extern int efi_mem_encrypt;
 extern bool efi_novamap;
+extern bool efi_apple_set_os;
 extern const efi_system_table_t *efi_system_table;
=20
 typedef union efi_dxe_services_table efi_dxe_services_table_t;
@@ -825,6 +826,19 @@ union apple_properties_protocol {
 	} mixed_mode;
 };
=20
+typedef struct apple_set_os_protocol apple_set_os_protocol_t;
+
+struct apple_set_os_protocol {
+	u64 version;
+	efi_status_t (__efiapi *set_os_version) (const char *);
+	efi_status_t (__efiapi *set_os_vendor) (const char *);
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
index 70b325a2f..2131f8543 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -223,6 +223,30 @@ static void retrieve_apple_device_properties(struct bo=
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
@@ -321,6 +345,9 @@ static void setup_quirks(struct boot_params *boot_param=
s)
 	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
 	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
 		retrieve_apple_device_properties(boot_params);
+
+	if (efi_apple_set_os)
+		apple_set_os();
 }
=20
 /*
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80b21d1c6..f1e58e027 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -387,6 +387,7 @@ void efi_native_runtime_setup(void);
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
2.34.1


