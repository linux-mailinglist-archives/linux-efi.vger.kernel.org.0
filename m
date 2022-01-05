Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D86485C8C
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbiAEXvw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44084 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245576AbiAEXvG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:06 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N5G1n009916;
        Wed, 5 Jan 2022 23:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AfBdTLyp+eCgXsJVPdns1cBm8q0VATTcj3tqV/Tzetc=;
 b=rqYr38IWXsvdeutoV/R3hM6BtG6q2Fh9BeYASDdCAWUWz9RPX9ja3TIVvQFz8S8abP4P
 ZKi8cc1ZnB+JnCXYvsI3FI3QiVepQQJbOOFLTps40soDSxcv79CeLSVheLjbPtUwtJ1q
 jByQsGL0qgQ7qGmw/uA3TGYX7swzXs2rYGJweU0wL1KVlvSKuNoLKtPTdFIjfyoh8/xH
 x9rkF1S6Ra8L0OtLhqxCQ1j0A67FlYwhu6FW0eUIaC0/sAPuE9khqfX0feGX7YFrbkIm
 1at+ZBSFKwAEjB4FtV0zWwuAhRBWv4vZZcA63FsCGZ0c6L4/s0z0OirOsVKq8mJ5IEf7 UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpp820a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjIhC177103;
        Wed, 5 Jan 2022 23:50:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 3ddmq5shhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq2uiKJ4e4f9CV/na77arhEpN7CMiMyWEIPO+beISdsGkE47FPo92zIauQetnp9CLI2J6IjFS7wGxl/GBVgEACEIoAflw+HBqwqECC5QgnjT1Ef3d9TdH6kbhZVCqBzx2nLJA9gIBt5TWySh1c22SNm2BIhUmL5rpFdWyEpR1eMECuoqRE2pc53U+WuuxpjaXbqSQbjIHJPfthdeopBAIKI7JK9YOGMoXhbOxeC91OPnpNC9Tgxx74249fjLwjmUvjRDV6tzoCCeDAASQWethXeG5eGCvzwvknN2yDRjU5p5AG52I+3PBuIsBpj++H90LUvDtXB11W6lXXL3juIj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfBdTLyp+eCgXsJVPdns1cBm8q0VATTcj3tqV/Tzetc=;
 b=mRz6c9maZlb59OEUzNtrxdfu1HPebfVQKAEzN8MnNx196c+uOEo0TO+jFs2tbOe767IT8F/2SieVI9p89AujnQPnX1QbxNIWXeHqH+I4DoVZZPDCgPzr/YldCE4zAa1UleAVjPeN2sVTOFXm5YXrbeOsWDspFizt423q6iY5xvGrsoohs8Pw6WpdPry+zUQt4hzmi0JW6CQKT87nMrbgGj37RvryHxZFFP9sqIhbYAetY13y6MmSpnMG4NXIFaZIe8mYLcOpOV5wrwQAnfSTWot187oKSWawpNIaDrZbEmtmk1H9m7CrCN37RcHWnyraJCTjXHnCxSxnwFrLUOUiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfBdTLyp+eCgXsJVPdns1cBm8q0VATTcj3tqV/Tzetc=;
 b=dzjXt7GpBhlyyb5Lg6I7O7YuPzblSKgSRnTT7z9V8FnCIINmebLm9w8+HFTJnSS2KCE7Y5jVWRN2KtTMsa8SnSWCvNWVPSYfUvD9zsFpHAnddJQ9ial2rm4bDmxSfTsloU0UMDV2NIHIXcdm9oIflIK1/KEWW8busuG+mPm9RGU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4261.namprd10.prod.outlook.com (2603:10b6:610:7d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 23:50:46 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:46 +0000
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
Subject: [PATCH v9 8/8] integrity: Only use machine keyring when uefi_check_trust_mok_keys is true
Date:   Wed,  5 Jan 2022 18:50:12 -0500
Message-Id: <20220105235012.2497118-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5935e9ea-2f11-45a0-3965-08d9d0a631a0
X-MS-TrafficTypeDiagnostic: CH2PR10MB4261:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB42616A2A898888EA3A54F352874B9@CH2PR10MB4261.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rI70nQ+8XDbb8t+6IFhYKZ9qv4Po+lbXU+iKg15BZ2f6Llj5819njuKF2SONfCBaFJ3VDCdkF5ZZKyNQo2Omb5Tfa58usqL1Yu7cXxpJ7cSIPrf36/ReaWrwrjP2rGkiUNFdzRbn0iOCVmc8y5FiLAyXqSzoBSYWdqSyvdXaaXSaK6yO5G7J6IbT6moFe82ETumguf8CezFhOPMyMNs0uavge6wIrtoYZPuXLmzMIO7s6hm6GEDe3JPFBd7/tfRmHvMwjnzQl2w7LS+PPTP9MZLyKuEaDTwZvLqqBs01YuWfUrWg7MGVph3E30OECq5bFg3oSCevU349iLGRsxNaypKCsLA8TvakTg9/91z1NBUxAEBtc/X6z0lja4MF5Uy/IGYNY8SW46hriEYRMQcjU9atfwpaM5qG7whhAoANnCpQR5whjX1k2XtZHM0D/jtn2Mg3IatVQzyvuqWT6tKJqPGebdvX89om7pl+vi5yTdNJ9eBpJP1arPmWud1iKx8CXt2pNoo+2xMmQniygEPo1PaRvx/2YeEfEGu06rrIQBIdqet0/7SWvj4pZWcZ959WXTeUCaIamh3BbFLoukmIyN5M641gmVkn1XFnw6AkzubTVEUETSkDXNQbgckZ/xJJ3KConVj+xPICquiF2zVMzszSjYYpWMQOjBamKB7mbS3qr7zyPOm96AaGtoJopaQmAsEoSgVJ0BlBp5ZWrp6/3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(316002)(6512007)(38100700002)(86362001)(6506007)(107886003)(6666004)(66946007)(7416002)(8676002)(2616005)(66556008)(1076003)(2906002)(508600001)(4326008)(83380400001)(5660300002)(186003)(6486002)(26005)(8936002)(44832011)(52116002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/7Yr9DIMBzv60RjiK4MHBpY3M8K3qMMclbru+WWRx1GGD1kFHEb81bh0cMYV?=
 =?us-ascii?Q?v1ILUE+MeYtg7MAiNcyYGddtLXsA100ReeZ3HLBkKxI/N9Ws+QDdxZV9i1cG?=
 =?us-ascii?Q?u5TH8890rxHrIMFsKKaNR6YCwFLDouL7x8qIDlTu3WsolF6pja+mmbUTZWjF?=
 =?us-ascii?Q?ZxYVjyHJjWnjWhR80XIfA+uxKDANHCprE7cWtwgzPlK9z1bq1zW6Xh6gJrPO?=
 =?us-ascii?Q?UFgFDBCASx5ilP1jnEID25amZqtGj7ABVQvmD2Pyoc3Qxs1Kt1/FZ2l8DllX?=
 =?us-ascii?Q?5JEoAmiAH7sBfCYHfDci8ZGvO+VNl+paOpXK+WHS2z/8/J/7qrQFWrFvB/F7?=
 =?us-ascii?Q?Y0KJ/cQRuL0SUHFE/u8uQIYyMnreDRApdSa6PEUd4xdNx+aeUWEerB/X8AlG?=
 =?us-ascii?Q?d/JCPRdu6VfaWvLpWWCe+qS8aQeyA/WHMRhnQN8sSd7IqoJeXaNcyJZ5ikKk?=
 =?us-ascii?Q?ZxFU1ag+2YvbulcTVZ77LhfMFG5yHqyooPt4n7XYxf86F66pvw0BxEBR9p7i?=
 =?us-ascii?Q?ti7xSXpRwuWytSyiBWocYidAnzqjfwVdSMHwo5WbNvLrFkMhjs5SYfRYr2O2?=
 =?us-ascii?Q?CVYDLIbvgOnDdLb5QBf2sfhSvaAFGTHAgraHlYxI52snMBl9YSGRjWwJaX4Y?=
 =?us-ascii?Q?JscXRypPd6jG7IrllRXyAPHqI80cd7IUwNbNH9HDyj+oEJIkpPUXXGd+0l9a?=
 =?us-ascii?Q?Bxf1yrvBYsN4pzn/sbvX5zqiyFVa0UFRVc0v+Rzveckpk7B75dkeFENxEky5?=
 =?us-ascii?Q?U4yoALIlcKLuYxuNEiyDdrDzxPivVrQvWWEUHWG+MH9ZoFFFGrrHoo3cu9+M?=
 =?us-ascii?Q?DB7kXthWXqyVbQ69JoZYKUFXq22ABRan9qp+/kdrB1+oqPhbxqQi62FjIDqA?=
 =?us-ascii?Q?u7y+pCX26xPs9VxFM1pnZZhvEy9okrZ7jP2EjQXHdTShint5e/VqkVqumhqM?=
 =?us-ascii?Q?fXHBhViGqJCBPsXd18hrp/uQrw9sTiJ4SZHnPZuM/woZPIF1Bj/x/O1motwl?=
 =?us-ascii?Q?eE9odfj6bkZxkD2XspG7HtU3GuMPijWI/rajcxN8ckvqI8hFKvzh20js7uBq?=
 =?us-ascii?Q?GWQ0fZCDGYvPxsO3M8SmgGw2e7kA06uDKGK7Y2BbywEFuytEa7FZEypcvrth?=
 =?us-ascii?Q?gPQd7ep+q+zVtJdYTfK3htSEzPffncpCX7ALQNF51DR8b5g0Wih8L63Oce43?=
 =?us-ascii?Q?dr1m1lqvEGZMs78lMotcFzN4aLJvNR2Cl1451WFGEjdXSOKpmNs68icY4QZ8?=
 =?us-ascii?Q?y6cvqPDkazvWdur6Mf3iPLFZUm6tx8DOmyz28XJT4ks2S8+gbl50IIdZRzQc?=
 =?us-ascii?Q?H2Lzxf9g1haleMVVNTsHn9Xjp/JYpuWUgcF4MZH+DibFXzc4o/dezblyrLGs?=
 =?us-ascii?Q?MD5jsDRGE8tc22ywaervTpApJcwaOx5EE9PosTHpbj2RU0etW+UiLeBnGXN4?=
 =?us-ascii?Q?skNtzTxhrmEhLF2jHZoiK5OZldCjyEXT3M6oJB4o7fiaVuGa97g61fLqx/5h?=
 =?us-ascii?Q?uoaw67nJVWu6aIpmmMiRkT8HtlEMWB37OYhh3T5ULJLXahivgtn9nJHPyzNP?=
 =?us-ascii?Q?E2GqyTb0bRZ7cxzHXxzINxnj2evJofOHpIzMUPWTSB5ZC3LG+iIbovDZE1xP?=
 =?us-ascii?Q?26SCMT0fq1UYqGNv7lngk0uERdhtRGk41Ye/GX0cUsHyomin4NwV73j/zGcI?=
 =?us-ascii?Q?YLO4LA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5935e9ea-2f11-45a0-3965-08d9d0a631a0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:46.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9/y3O0Rllr0KPSCdw7DoZf8y/gg9WEdg1VIlA9spFZlUByM19ee9uIUEnshG/gDMISVsJ19WwZcPL2OEbmHSFLqKYBCLgZ6TkNwLric7eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4261
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=662 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-ORIG-GUID: uC3muoxp4Ud5NqZkrJE5lydhP346tQ0s
X-Proofpoint-GUID: uC3muoxp4Ud5NqZkrJE5lydhP346tQ0s
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
---
v4: Initial version
v5: Rename to machine keyring
v6: Unmodified from v5
v7: Made trust_mok static
v8: Unmodified from v7
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

