Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02ED49C18A
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiAZDAJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38474 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236713AbiAZDAI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:08 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMn0ao006704;
        Wed, 26 Jan 2022 02:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=DX13d+PiMvfyMGWKE5ro69EtugCuC09WkcKuPazoMi0=;
 b=DIGUhdJi2OqJ4q++2pNL6JFMiYlWLxJCdXbPkha3IEkCwh96ZlROrkrS4+TEqhkBapXW
 Cd+f/1TaGxnZDytEKU394d2TGokJSO/WbHPKz7ecweT9xJKPtyj5q+SMHDgB6NvkSZvg
 17ycbJTtgosU9bt+4XULW977vXZbA2+dW51C2JGJDCfJeP9NUZlGf9FC6ZfB3gowlSfE
 04heSGGOSGwFRNjVikqqFLTlKLcXLVCIjdBZDkUgGyxNELThoRk4dkNDq1subfQOU+Pa
 DWrOub4JygMq9XVWY+999cGo/z6P8/nIwpcdBdJ+dF/Na25jB+uMH4SopMaJGhwKEabd AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjdgrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oSt1068412;
        Wed, 26 Jan 2022 02:59:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by userp3020.oracle.com with ESMTP id 3drbcq7vab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw6kUkN/Ckqz2k9l2SQ3tSKXSSidrQEwv7Kh1E3L0ri++xYoD5dNC+OogOcZkt4PNjuGhBj5uVZCKtD86MWfshvC65Ax9j0V+lAj6hAiOQ76tQ6c5blEv2z8CwRzq45+syMzIJTWBCWPIf/tXwz7bJSaGB+wRPJnCCRxXQnW4YetbE4k+OmyhYcqhiYmaWjgKIMgQyaoXUK1s2lMPLsC+ZcopMrJHPobfhfkvPElrrH3PabZsDXwdwWyau+rOMNurvHFiwuXB0GCZy+BqW6hv6Pmryh/Tkd7yhSMuOXz1ctDaRz5vueYuMbdp4x5NZYUd2Th64OzStFXZYvjSKs4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX13d+PiMvfyMGWKE5ro69EtugCuC09WkcKuPazoMi0=;
 b=Hfxl8wE7Sq5w4+sU0Kh7CLg8H0A7itm2jiBBcPZhaK69pQ9dgSTnQ5s7vV0BbcK8RjGYNi0T9BtlwfVG3k8VHDOF0TfTr9hDvMkm2vcLuMVPK31dHTUyBdD1Hjtpl1nQpGd+fshgJ6VTUYvcbRAAc3J0WuJyVaRfQH+qErXFp9zKwQzCEww04J8JbiwpvlaKxCdT3aKwLz00o7LdNRraXT1DDQ2OT43Fn5hms3wRXpinzwMpEkiDQUqGTWHZel9ucGZWkiMidE/lplyckPh3SeDGefU7TfNWS7hAIAXSWkG8a+IBvj7q3DxMvofDy3zgrECR+0yZxRtZ78SZ7mmFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX13d+PiMvfyMGWKE5ro69EtugCuC09WkcKuPazoMi0=;
 b=u2gpJMN04u61V82Z/XTDtY7WWjSbY2DbW5LH0USkzs/yw7sxdaelWlgDs9kzGAY0jmzKgMTOYYw5TWvRrFwo6721zUSrku8IUt75jBDOBU84ltNx3l4jz8yg9KpoumOyNEbQaIqKqqN/tseQ2CKS1YmyCFByt0NjZkvF5f/Jb1o=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:45 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:45 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        nayna@linux.ibm.com, zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v10 8/8] integrity: Only use machine keyring when uefi_check_trust_mok_keys is true
Date:   Tue, 25 Jan 2022 21:58:34 -0500
Message-Id: <20220126025834.255493-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d470f1c-e83c-4659-9281-08d9e077e853
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4654F54FD9465BE02B6E098A87209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0V4BHUUWFtNgkWsEGdHoIqyLmOYMhiAsymKY7l3Hf2WYvxoIkHPnSFvozjR9UGhAIBeFUHO2k3ByK/8Fjq9lU7t9vd/cwNF+hh1gBoXWoP++pzXEswoEE9+t3DkeDbDNqVmNix0lE+prKEUHzwTFtcim8ikcziOx/QDV1D1eQMEhl8/Z2QWA0rxBB5P4ntmDn/MzJpP68N37vyKaX3AxfJIGx/Fc9kvzN7CC2YYaD8nAIx0IYYVjOKVEzm+wV9nJWVEq9l53V3PWSY7Wrg80pFBxgGUcYPfRZzX4iNJoBHLpoYFBwXfCIjk0LComzx9495p7q6QfsTVJ05AqARvA5OgZbKCdgXPe31V2mZJ3fXDJ5WcSVblzobGXEge3JkdDJnqr2UY9E5MmF3qqR1I3lgDAgR0n4VCLXJ7aXM5oVjQ73aDa7q1KZ1/CNpAyI0siqj29PccUmeO0PCHh0Vy+HiqJM51ucPZcANPbHtrwpQ2OC4vaKupKe9XjUCP0sxafXJP7fuGE+ojUrFOOTBhjFhxuDXAIapCObgSUkNtRIEilYzRKM/+6tDmScpuFNdTYHr2oWiCsEb5NAV2hgR+QK/0bwueOfaiIo/5PWgaS25ELsHwTJk1siqCC4OKyiJw7DKEhz9gKM6FlbIg61s5XfpuzdmpFwM0Ly5hq8IS0/oTuhsaWhTMq2Iur70dT0MOFhwADvK5r8/42Ch1zE3p+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6m1aX3joed9PmrLhUs5zlPmiGzH6NzuAfgBPARVuH+76f9okX8yRI5NfObV4?=
 =?us-ascii?Q?oVYdkm8vTIMLJKFNJOMC0B3FadR2tg485s+/kTnGMYMk1FRFBxPif5MsK6Ia?=
 =?us-ascii?Q?0bZ69e/KsngJ0FOCDSmqH9f4Jin27MXGDSXFRcZHmdCBSq/0BxXqj5T04kLR?=
 =?us-ascii?Q?9bcjnqLTkEzPaaLzJHKiOQ3FTIYfFxpuUZblEYSfmwBEWoPwSn9vv+GMPEK/?=
 =?us-ascii?Q?UaKVOQU9IARmFww7NIfG+FOIUh6hpyuX+kaPwnOYBqU7BXVQmnq3XITCJgow?=
 =?us-ascii?Q?GrIUnNYJzIk3wu1lABay/BgvXjuCR3c5ej0QLhJ4pWAlUDaHH0F47BaYq/qB?=
 =?us-ascii?Q?H5nLM7Fp3xuE9+BGcnkr2GpL37qXh+qxtQo5H4veELV8wmt6bv+dhWousXeY?=
 =?us-ascii?Q?NycLb2dGcZjsYYQN9EjqcZwa4xa0pMnKhOjn9ghodQ5CRMKWy+F9RN3erANI?=
 =?us-ascii?Q?Q2RjmHCytpdx/GggBsPxtPcFW/roDvC74vvFutT9dSpkMB5+7k9ixdKwfi3v?=
 =?us-ascii?Q?/Jxvmwrj/+8o8ayNdO1n8JLbbnOtvYPtunTkcORVC1o7h9h4eL/kdi7Htkc9?=
 =?us-ascii?Q?L3/LVE9ZpbdV5g2W6XgyEfSMaO/kRtt+um7mP0ah+pCPsBATeA0DswXjq1t4?=
 =?us-ascii?Q?4K+TCpPQF1NhI5B/gsBX9wkDpfTVt8c9bwrvp4x2tS5FpBiQVWo1X3twwB4s?=
 =?us-ascii?Q?5KTuaoCgg5ZIvgpQhsxLn0h1yg24S+cPSjkNEAjc6TdI/EiPyn1f2U41BHRw?=
 =?us-ascii?Q?drP47/uwmQHAUAkaV6gSOC4oBRRvCi0uZ+57TGbrRcC5WJPSD1mZZ0yq4J/I?=
 =?us-ascii?Q?ZrH9Pfk+ZAku2My1SiyAbvRlJLmg+t3n9D/G0rdKnlQmJn6A+cH4e+BQrxNr?=
 =?us-ascii?Q?zXGwZ2XVRFWzZC4yu2b1EHqeoGk63qIzRPFXvRqv/4mvR354j0CkdbfhleTJ?=
 =?us-ascii?Q?vYxHgwozeCOQ7w71B1SwNtWdEEBAQTrmXobApclBWNrTXZ5LU5XtnaxXq3jw?=
 =?us-ascii?Q?Ud+ZkwuLVd0hYO5m5XfIGgyJYArCcA0E8BV5/vY7JQdP022VSaBmnzpiuewr?=
 =?us-ascii?Q?Z48/x3Nix2p4oUFtEsoO42CdhktkdDkJC3QrI7XMDw6DTuhNm7xj22gIQTig?=
 =?us-ascii?Q?Mp/fo6PjpSvZ8BZX++q594HdsM9kZJKZRP3H+IF6hlHYLC7wlgkURnGjvxXL?=
 =?us-ascii?Q?V9AE+dSMr9yAs4Q+EBuWwzQnQww24saElzXi3n5YU40V0IYRz1otvVUMyMOQ?=
 =?us-ascii?Q?AvuFIR0g8Vx1hgNbfJKkWfhhBzvDudtadSByYMqf9kSEbfkqYPj10AwHpMYm?=
 =?us-ascii?Q?hq6LCcsuzU0lEqoSFJjryukz9n9wbq7pbFTzq2xpZo0lA1hByFk/qg2OGfLr?=
 =?us-ascii?Q?IGt04siCdmhonBQs2mu2KSOF6eMhFtoFFt2xgK8Lvj1XeJ/8oABY97UK+JLG?=
 =?us-ascii?Q?d0EM9wnz4KXRUkWH/rZSDss19czwy3eXeo+wa5ndXavzWDo/Ae8vZS6ex2n6?=
 =?us-ascii?Q?FfKdCyPCLVG+hQNLWRAqfkpIlQ9gRrwSljoV4nYPDU/goH3bcgvFQx51LKGf?=
 =?us-ascii?Q?s3YA/Aa9b7FEtrAHjRqdU/EfwAnEv6TfQB92IiLi0gosrzm5VtH20KZgi2/9?=
 =?us-ascii?Q?JaiTnob0MSVtiUvopEdv0i0QtBPOudAhsAZogD75wU/DGWnlySWWTLUippri?=
 =?us-ascii?Q?OALt+i38G1R0WzqwBN0ZVl0HMkc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d470f1c-e83c-4659-9281-08d9e077e853
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:45.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET8OXapE9S/dKW7SZj94lAtVV1t5Zr/CHETcUWxO9oZ5xSGS4C3srETzq/mWHCKKLT4iIhHbCS6lvwrK4Lk+KnEKUn3S/HeYywkXYaDYN6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260011
X-Proofpoint-GUID: AHqjLRdYUHiKVdhuz4W9ATjBDJpjW-3m
X-Proofpoint-ORIG-GUID: AHqjLRdYUHiKVdhuz4W9ATjBDJpjW-3m
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With the introduction of uefi_check_trust_mok_keys, it signifies the end-
user wants to trust the machine keyring as trusted keys.  If they have
chosen to trust the machine keyring, load the qualifying keys into it
during boot, then link it to the secondary keyring .  If the user has not
chosen to trust the machine keyring, it will be empty and not linked to
the secondary keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4: Initial version
v5: Rename to machine keyring
v6: Unmodified from v5
v7: Made trust_mok static
v8: Unmodified from v7
v10: Added Jarkko's Reviewed-by
---
 security/integrity/digsig.c                      |  2 +-
 security/integrity/integrity.h                   |  5 +++++
 .../integrity/platform_certs/keyring_handler.c   |  2 +-
 .../integrity/platform_certs/machine_keyring.c   | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 7b719aa76188..c8c8a4a4e7a0 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -112,7 +112,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
-		if (id == INTEGRITY_KEYRING_MACHINE)
+		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
 			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 730771eececd..2e214c761158 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -287,9 +287,14 @@ static inline void __init add_to_platform_keyring(const char *source,
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
+bool __init trust_moklist(void);
 #else
 static inline void __init add_to_machine_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
+static inline bool __init trust_moklist(void)
+{
+	return false;
+}
 #endif
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 4872850d081f..1db4d3b4356d 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -83,7 +83,7 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
-		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
 			return add_to_machine_keyring;
 		else
 			return add_to_platform_keyring;
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 09fd8f20c756..7aaed7950b6e 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -8,6 +8,8 @@
 #include <linux/efi.h>
 #include "../integrity.h"
 
+static bool trust_mok;
+
 static __init int machine_keyring_init(void)
 {
 	int rc;
@@ -59,3 +61,17 @@ static __init bool uefi_check_trust_mok_keys(void)
 
 	return false;
 }
+
+bool __init trust_moklist(void)
+{
+	static bool initialized;
+
+	if (!initialized) {
+		initialized = true;
+
+		if (uefi_check_trust_mok_keys())
+			trust_mok = true;
+	}
+
+	return trust_mok;
+}
-- 
2.18.4

