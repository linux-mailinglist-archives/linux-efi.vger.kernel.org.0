Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504FC25D27A
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 09:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIDHae (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 03:30:34 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35589 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729765AbgIDH3r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 03:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599204584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMwzl/DFU5QVU1c3TC0j+2xuvQVhQLCy2L6n4az4kc0=;
        b=Up0PJggF+/lJ8xyt4GyuCI1eYnJN2R5jnnOJGFKUsd+oha8vKuK7HNf/Nnlj0vr4+UrCKR
        4OcBMh7cLnXNbpVh/2oPyIKNCgPZi2aV9U848cbzud4z8zFWz4SIXzHD/sEmy4kT11aJxX
        c24e/WVRzW/9sIePP2ZxIMpNJTSFLP8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-3omLnChZP3C5OR4cARrjwA-1; Fri, 04 Sep 2020 09:29:42 +0200
X-MC-Unique: 3omLnChZP3C5OR4cARrjwA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA0cLtl6rainHpGlWqUlypt8FBdwQZbRGZeNr7Aeqb5+5xYTv25cFl4Mj6T5WLEbx+rhz9MYAvO+IZsj4kjx3pbnAcClIrMZfCKiUQ6SjvbDQGclDqbS+C4YUz4NizL353VSX7ZbVapkLLdhf+vTJp2cgA30CbQ4vY4Rf2Psnh/WDBYYE+u3Y5tEZbXUuAvVyZ5Gica0mnsFrue1ETe13p5NeyUVvHItu4zPwKqlJMk2J1pD1IMJlP2KSgEtwreoGcz+IXtiRPAfVQkw3IRHiBIPgUUTFS6xyPw1xiPNLJHdFkP9fEwAL4Eb7yUCv/00/hGNq+tVcjXhYq1yj+jElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEYlWLpOl/XRQn0kyzMOn7W6PG7RxQna7dkoagYegxc=;
 b=noRUmguEfZ25ALH8opU8r/Dt7wRrr4Ty0ZozpmUifKQ6jJSundZpabIE+LDEeDVI//tRY1bw3J7LPwqTdflRnwTjSrvS+huMlOtmZQWf7ieouk5tUs9mtx8NwiyQfipjwJE2reuq3bazgcDcfqaosGztYDU0OB/OVbxTLudhZVYnWlPanmOxIumIQ+/RDWxC0PJYt9NqP5Y3dPL17IRFiMWnWTl9bz7PMLD1evTfB99k0U83K5CECN2n8Cje+tx8z0TLYXDV3PhZI+9bQIunQDwl7CIckzgEsLYUBRowJlQDwADBcH0g8mn7sfmLXIPq81w05rmkyn5iIPDoMlGsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB5534.eurprd04.prod.outlook.com (2603:10a6:803:d2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 07:29:41 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3%2]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:29:41 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, corbet@lwn.net,
        mark.rutland@arm.com, vincenzo.frascino@arm.com,
        samitolvanen@google.com, masahiroy@kernel.org, mingo@kernel.org
CC:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH 1/6] efistub: pass uefi secureboot flag via fdt params
Date:   Fri,  4 Sep 2020 15:29:00 +0800
Message-ID: <20200904072905.25332-2-clin@suse.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904072905.25332-1-clin@suse.com>
References: <20200904072905.25332-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug.suse.de (114.24.10.103) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 07:29:36 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [114.24.10.103]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56b8656e-1d6f-4dd3-2aca-08d850a44995
X-MS-TrafficTypeDiagnostic: VI1PR04MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5534BE18DA387DF2B17B8061AD2D0@VI1PR04MB5534.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XXOKfKx8lqrr12MHzSzqLfCXrTwnXAclEcd5/3Rs4AN9GIayomQ89+wjxha8IIucM9LO36JUfcM3mwo/Wj20K0dRrittiAEpBCYmFcY1ZNRdnJdchyxN6GF3nPCToXjN/iit0b6KmObeyciWR6Bsggu3LZShdSjbdNqvPxX91FBAnQxtk4VLuQr7ozuEP1Ilfb/QVRINHi7mPE/RX6bnLh+zf7/OD5AhcU7nCkOPUwfBE1vGMh/5yaerY9Uj9wVfsB+XFs3dMq+Jy0eKibMKmlSGa9Zuto7Azt0suySCXegJWXZYG3hykfhxnP4Xxn07LJSZloSDykL5CEccidOAQdbjJwiOQuohSBXejSDNBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(5660300002)(2906002)(956004)(316002)(66476007)(66946007)(107886003)(66556008)(6506007)(36756003)(8676002)(16526019)(52116002)(186003)(7416002)(83380400001)(6512007)(1076003)(4326008)(8936002)(26005)(2616005)(478600001)(6666004)(86362001)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NABScR6D6u20RkZ6fnWEh2qfvIS6BGuc+qhgX4q2sajgvTIaGRatvDlxmCMZ3z4kUZCcvKK8xdgVh0JMezdFQh/VUi7CM1kRWIlv6CmipTR7HyLldhoViRtEjM+9JzrHO8pnI3OCKb49ABEw0OMtyw0elrogYu8aNb2Lg0gbbbHV7LF096qu2g0LNZkOYnXc9CENsII5XF7ZqU5UFjb9bbVeG8pOby99ebGaOMdwj8VJ3SXO/CH5PIrP/075+bBhOYesU/fwagm9FaYmPx0uLyDLF3I+eLJm2sr1liscWHzN1T8UZ1beZdk3DcVjojN/7uANoo4A+3CHMcxyOrS6hjuYOyLzWbBZXAM4EiKaP/EL2sd8g5YVYaNtkzEYdVhvn0jKhY/hvvBCsyeZHCTEc3MQ8mlSwVoQKHjcD5OXkVou+XbO4jQ4rzo2K8nKtP4tq2U7O7pJCGJ1y7JRAEdXdcx2kTnbOsiYUckyQhTsPfjT8XDHyf3SIefF4KSkCxseZmmVaeDS35h3NHRV5bsz2CyTJGy3ztktWjG+vrzXULRN0QjwtWNbf35tmtvBlUVVJwP0jRPxSCqcXzc77HT6VIzyhC+JQG/VVhVMak5t9jCOODNCWMpAzq2UjlPAr8Td/nYxhAEA4DGr2klgaqezfg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b8656e-1d6f-4dd3-2aca-08d850a44995
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 07:29:41.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +APCQ5UJnImSaveX4hl/DnXuN7DzM65Kjw+H8p2+BE+1B8f3j+pnROJIxGPSkBTq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5534
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new UEFI parameter: "linux,uefi-secure-boot" in fdt boot params
as other architectures have done in their own boot data. For example,
the boot_params->secure_boot in x86.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/firmware/efi/libstub/fdt.c | 39 +++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libs=
tub/fdt.c
index 11ecf3c4640e..c9a341e4715f 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -136,6 +136,10 @@ static efi_status_t update_fdt(void *orig_fdt, unsigne=
d long orig_fdt_size,
 	if (status)
 		goto fdt_set_fail;
=20
+	status =3D fdt_setprop_var(fdt, node, "linux,uefi-secure-boot", fdt_val32=
);
+	if (status)
+		goto fdt_set_fail;
+
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		efi_status_t efi_status;
=20
@@ -199,6 +203,24 @@ static efi_status_t update_fdt_memmap(void *fdt, struc=
t efi_boot_memmap *map)
 	return EFI_SUCCESS;
 }
=20
+static efi_status_t update_fdt_secboot(void *fdt, u32 secboot)
+{
+	int node =3D fdt_path_offset(fdt, "/chosen");
+	u32 fdt_val32;
+	int err;
+
+	if (node < 0)
+		return EFI_LOAD_ERROR;
+
+	fdt_val32 =3D cpu_to_fdt32(secboot);
+
+	err =3D fdt_setprop_inplace_var(fdt, node, "linux,uefi-secure-boot", fdt_=
val32);
+	if (err)
+		return EFI_LOAD_ERROR;
+
+	return EFI_SUCCESS;
+}
+
 struct exit_boot_struct {
 	efi_memory_desc_t	*runtime_map;
 	int			*runtime_entry_count;
@@ -208,6 +230,9 @@ struct exit_boot_struct {
 static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 				   void *priv)
 {
+	efi_status_t status;
+	enum efi_secureboot_mode secboot_status;
+	u32 secboot_var =3D 0;
 	struct exit_boot_struct *p =3D priv;
 	/*
 	 * Update the memory map with virtual addresses. The function will also
@@ -217,7 +242,19 @@ static efi_status_t exit_boot_func(struct efi_boot_mem=
map *map,
 	efi_get_virtmap(*map->map, *map->map_size, *map->desc_size,
 			p->runtime_map, p->runtime_entry_count);
=20
-	return update_fdt_memmap(p->new_fdt_addr, map);
+	status =3D update_fdt_memmap(p->new_fdt_addr, map);
+
+	if (status !=3D EFI_SUCCESS)
+		return status;
+
+	secboot_status =3D efi_get_secureboot();
+
+	if (secboot_status =3D=3D efi_secureboot_mode_enabled)
+		secboot_var =3D 1;
+
+	status =3D update_fdt_secboot(p->new_fdt_addr, secboot_var);
+
+	return status;
 }
=20
 #ifndef MAX_FDT_SIZE
--=20
2.26.1

