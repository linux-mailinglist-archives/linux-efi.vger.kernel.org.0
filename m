Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF65B25D265
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgIDH37 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 03:29:59 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:48992 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729795AbgIDH34 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 03:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599204593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nV7ImcWOQUtOaqrhFMET4pRKvqK6muS+/EFT4AfzGCo=;
        b=fiyJfI/4Q2I9ZzwfmsDBckn3P4CaezE+fnaC6wsIot5zcflk96oAjcmaggyyiYEzV1XFuS
        WhnF/ecmmBxn45RPYLTadscw/wTgtLk5us0OZke/w8/tDfOSmhaBVs7FI2GkTFieI/UCdH
        Wcwxb4GETu9Wydi6q+LoPvMqA4ECPGs=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-jnFOm67RMJGj5lSlySvvCg-1; Fri, 04 Sep 2020 09:29:52 +0200
X-MC-Unique: jnFOm67RMJGj5lSlySvvCg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnfZrdxiJSpisEtjMv+9AQ8UHOnmkZKMAHy9LMbXX1IoelOJ5K5wAljPKIWc3f8JWvxYwar1yvRTwIGZZaEAUINq3VQZKlR5lkoyaGjBkz8mKV5dRNmWpEvkiKJQDWmnz5LgfzF44SdP69a23+sDb92cgRWOumBYcqwDVGv3S7ojKgFu8g9/+pd9OI3RWrbO01DJDIuAgxbH9djf92o71EtALeC9uoQmwYaIwL8CAlKs5XBZk6pF7pm5WUbnvpWBYXfomN7mnyUbrUg3LtBETDfIyt4vMOwIwigt9z+4bfNtroJRQRqnPdoaodJpeHIYhB9NGFDXj8RgjmQC1Aa70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX39dqHiWkXvJ2Px5ZdB62dgBlibIoVWwceDNrn8hBU=;
 b=QOxrcVLu7uYN68OzK7IHGgTHbYyoaTXl6RHD8Jhc2/uu5xeuwpjfdP2EjBVPXP0oD2yDO1R7uCfjHLkfGC0YHtcSNxWUMMJBx4hal2Vq4bM1GaS5hmspIwQRHRbCoEIcDUfHpVRsa1l3bPQ0Mc+aEaiP8IY4CSO3h4ANkYT2JhroYAcf2vawa/bsGmrqVziBi43p/frmENqrUj4EmVGWztnb2X8ZP/oSxpkVqRTfIVzKhgBs95uVeo0DkM5YQ5jBi24ZiVPlc4vhK5hH/z2eOCgcp7qCJoFRrMHkOSeZckYcPtHgaDPMokSpE1KesTuD2WWYEOGHiuHPwa7g7WItcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0401MB2654.eurprd04.prod.outlook.com (2603:10a6:800:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Fri, 4 Sep
 2020 07:29:49 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3%2]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:29:49 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, corbet@lwn.net,
        mark.rutland@arm.com, vincenzo.frascino@arm.com,
        samitolvanen@google.com, masahiroy@kernel.org, mingo@kernel.org
CC:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH 2/6] efi/arm: a helper to parse secure boot param in fdt params
Date:   Fri,  4 Sep 2020 15:29:01 +0800
Message-ID: <20200904072905.25332-3-clin@suse.com>
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
Received: from linux-8mug.suse.de (114.24.10.103) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 07:29:44 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [114.24.10.103]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35718e2a-585f-40ef-577a-08d850a44e4e
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB265423F22055152D82C6610EAD2D0@VI1PR0401MB2654.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2ReF9pPHpHw4IhdSOdf27pP8pvJu4ozN/P8hgvglzX32AuprBF6mBAmizy3xLRCDqo/4vMzupAT6Cg3FjlI2DGAa0QCkdBo+Drfvbv+PUY5kQ4rqU5gYvdZZClFsq7rHvBfK10qGTAiaEkC6Z7yvdKeuzKBwgxdGlkJTDmZGH/30EcTqZVbjH+QUY5oKNScrEC53hsz8c+8+lCG0r7HIgDpmoCD1Ttd2Usgu9kT7UVo+G2J4elT9zBU8slleDicv5rbJWZXOaYP1RQ3Hd2IALFqfixZYA7bRuoNtdpQJJ1MA7jcQc1lvF6c5+jkrUGCyzE5v1bknlQfS2FyWtzXRrnSnRPeDU7WGBu5T49xjvYZA/ullSw4GuvJx7sSG218
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(66476007)(478600001)(8676002)(7416002)(52116002)(66556008)(66946007)(2906002)(6512007)(8936002)(4326008)(316002)(186003)(107886003)(6666004)(26005)(5660300002)(16526019)(6506007)(956004)(36756003)(1076003)(2616005)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sRnqmCSJfwLPOdwZ3PXo/jWldN+hFRTH0HpJ89Q4NZaQH6NmMjapFQID01eaWRw0+PP2UwibRe9g/Aa0Sjnv2lNKTP/XKPqXmlPvsLnk+z0b/d1VcN1WSDL4BqYCcZTT5QkIB2bBGObqeodX8LoSKRXqR9jppTOoQpItd99lcBqP0UVRzzIAglQjSnXkwJJ17PH+blr+dAPkJ0m8OE1KbfjOjC1+Ov6YWSQa6eWMpQ4z3tiqlEydpUouRn4vECbag8Iw/e2CX3iH1pPGsHmwncWwke7S2YaltXb1/OOzRr604rrkzlQ0CGQHkJNC3HZ+Z4LlDNwPwgtqvymSeQzajTfzcdp4ZbtOPbz6WMn9T1QEiN4ckj1R8bBULvW3B3yMFbdVDSYifdef6916bUaqEfJeRwWYKFTBz5EhcUazHarsRKxbZZnUFSSRyS69sPF82JhFs4+xp/i4/qaOkMVHxZSLJw6CL5np+poS/SMuC/Ph7g1l780WK7r8PtxsHpXEBMrnxEoc/IpMkppj1woukzjKa1HSnxr8Cxojh6tZKt9Zq4P/G8rI7uL8J/uKy5xtFyjJuviL2sULbTosw5dCqKkh2x/l/RT/YbtGNxsToC5++VuHLEtCGM3MZeyHwLdVoWnhz6XWova4i/+Vmde4rg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35718e2a-585f-40ef-577a-08d850a44e4e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 07:29:49.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7U1qZS/AX+ulMXM2l19nkJfGOWzR2HnGUXqXGIuOIWY6Vkf3Fi8kiDEp7WeB81J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2654
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a helper to query the UEFI secureboot param from the chosen node in
FDT.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/firmware/efi/fdtparams.c | 23 +++++++++++++++++++++++
 include/linux/efi.h              |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtpar=
ams.c
index bb042ab7c2be..d58ec4119bcf 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -124,3 +124,26 @@ u64 __init efi_get_fdt_params(struct efi_memory_map_da=
ta *mm)
 	pr_info("UEFI not found.\n");
 	return 0;
 }
+
+bool __init efi_secureboot_enabled_in_fdt(void)
+{
+	const void *fdt =3D initial_boot_params;
+	int node;
+	u32 secboot;
+
+
+	node =3D fdt_path_offset(fdt, "/chosen");
+
+	if (node < 0) {
+		pr_err("chosen node not found.\n");
+		return false;
+	}
+
+	if (!efi_get_fdt_prop(fdt, node, "linux,uefi-secure-boot",
+			      "SECURE BOOT", &secboot, sizeof(secboot))) {
+		if (secboot)
+			return true;
+	}
+
+	return false;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 73db1ae04cef..315126b2f5e9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -663,6 +663,7 @@ extern int efi_mem_reserve_persistent(phys_addr_t addr,=
 u64 size);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 		struct resource *data_resource, struct resource *bss_resource);
 extern u64 efi_get_fdt_params(struct efi_memory_map_data *data);
+extern bool __init efi_secureboot_enabled_in_fdt(void);
 extern struct kobject *efi_kobj;
=20
 extern int efi_reboot_quirk_mode;
--=20
2.26.1

