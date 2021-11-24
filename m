Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD645B365
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhKXEqV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8262 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241174AbhKXEqM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:12 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4RBpY006040;
        Wed, 24 Nov 2021 04:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=qsSHdCnesWgw6P5qUtyD9ZQKk7kKRCyx+Xa4vy7iSOU=;
 b=ML1/HV4RgtM2UjOO8wOdUo94OGjjA4kXYIfURz6H8cHI84JC/l1A75ZrAsaTnchLTMCc
 qAiCeBUKwejaIRavTriAA3EGjjpXaJWP6m5OSnKX8B4MCoNl3q0mUVY29gXvz+ejmUH8
 qgF6GQk44y/191WWNon0zgwILwS6OhGRnWAMxv82YAEFSPs2euKnGWhmGriGt8ej48Ek
 mnk0iwQMPxM9xy9GvSZhfte8XXrZfsNPv6iYJ/VxDPMcZfURq1MWFYwE6yFKOGU+maHD
 0mlPmMTEQqK1IcsCc+ulRO4hRG0ysF77mN8zyfWL5xXMK30DL8luTK1nG4hnQ6nIdkMq 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46fewk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4f4Kr025271;
        Wed, 24 Nov 2021 04:42:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3ceru6amr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQuV2JRgWWOMlhXok/L5Ww+b+OrfLH81wUkMxhKF7JqLAcoLZs3UwIrdFp7JvCu6IX5skFvaVRJMkME8eSrGarVq6ypC8nG5j9xWqW2hXnfaaXHTlA6g0lC0EBvraBpFRKPvhdfbU+IAyHz7a12XfuKaQooZd4B76W1lSGuwoTv7nubZtwcikm7+DaFpP7KjJhyiMsMeiZiH0gMEg7ynxp2ZVFma3VqwWJdccxJ/FWnZgnoflHSZqGJoqBjTKIgliB3waAJJoTTefhPBPzXRE8w5fm8ODG51w4bEqPRLq5wls927Y0X9FHaxoAA0FTUWgBKj0EfokEZimQdL/HFhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsSHdCnesWgw6P5qUtyD9ZQKk7kKRCyx+Xa4vy7iSOU=;
 b=i4yTOWzSVs6Mtian+idS34lTcjWP9mKGcIuquRwG/pEaqHFOzVDFU+/rX6/W9qnxpoJIBktmky4Rm6PVH69vQD+X00qemkj1BczHxw6Vv7zRWgyQ82VsD0IkGrCxksLU/L5EQTjQvn7S9LS4rrbbIKCHol6InvnzWl1WgoB45ZI49QaHqVz0PgYh8IxNZ2FZ2PDCDipupjSAnw8b5TcCgXidfXaofRpLhe0kob6mmDFCFQgE6m4L+8mig6UYspnXbcbjca5GkJ0M/0TvHBrFhFeEcAbI2ioKELPX+OfG7En54EFxD1ikg8hqnHqSTkMRtvu9rxz91wMKrANMCDv/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsSHdCnesWgw6P5qUtyD9ZQKk7kKRCyx+Xa4vy7iSOU=;
 b=vmRd+xJ3P/w8qDbyPyfbmcxTuHBZRInt3qbi7mKubwzTgnxRzGcI/SfufOS5cLjzcyA1cIxs6UQOTpjoZEuLDYHrDxY+rNIXFTrHBcm75+SbO33Y4Mg8lhISLQTFfBI//uWBqUjATZLUnl4HWssxM/c7UzQJ2upWuj+l8q1BgsM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3894.namprd10.prod.outlook.com (2603:10b6:610:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 04:42:43 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:43 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v8 17/17] integrity: Only use machine keyring when uefi_check_trust_mok_keys is true
Date:   Tue, 23 Nov 2021 23:41:24 -0500
Message-Id: <20211124044124.998170-18-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdebc47e-3ada-4ed0-3bbd-08d9af04dab8
X-MS-TrafficTypeDiagnostic: CH2PR10MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3894C00CB68A109E3C4C767687619@CH2PR10MB3894.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SmvSwZTgRn3wjtdQpHvBuO8QAPiFnYiXRKMmKNQAUo1b81rFspQm6tK7AJXRCrvUvRUAqoFOB7oJGSORVvww/wlpA6RJrdMOREQWM4HPmhv6F8N8d6zsUjpnm/gwuPh5fKWkHXWxC49+UwG9CQh6B/Fk244/eaqEE+JZs2As4DW05AhWgFJEq383BaEpQfpnrl7bNjvCP7q0iJJynmGI+z+lbNdBUoFQlQASZqpVm5NYvKrvZL9G2zVtDPC3myVxYeCj47klc2WBnYeT+VeoRy5b+IssFuUBvYFYWNQCoQXU7LWujbpRWfFCt/EuQRt8tb9MDrID1HWzyLP6TOuKdHafMXoEjhf9Qat+37MAaMk0lrugfw9Sx1xfHkRFhc847JkaEdv4WFHPk6w2m26cBfzgYXlAZxJ15nvw3JPjpPRv1wxfu4eUCuFFGpqvArTmuOymjV/c8UWigL2knXq8OrmMknlEZ2r1ljnL49zd941q2oG2BhCkpZmts1HsjCvRCjYN7EZSUlpqf5Cy0eCM0vjyZB2U0PiOz0uO9LBUNXqZHy8E6Au1cP+ISzmrFyD4kaKUAIK7/EvxS9hXGajKoCrZB+WngCwYwvsT2twHKd4TSZAzxqy0J7ka3+zhu6BXJPuGfwdnnjfKQHzmKVfF509Np+QD+LOrESuyq10YZkVvKW2t168XrL5Ql0cmDWMMTFEnakeV73UgvU8tZfY8V43diuUOgZWv3t3/frHuMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(921005)(36756003)(86362001)(83380400001)(508600001)(5660300002)(4326008)(2616005)(6486002)(186003)(7696005)(44832011)(26005)(8936002)(66946007)(52116002)(8676002)(7416002)(2906002)(66556008)(66476007)(316002)(107886003)(38350700002)(38100700002)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDCXmJxa7v4fZMIRCTfFeomZWDWenyLsxe4QAAvte4BfnJqXRInr4V3rBpuT?=
 =?us-ascii?Q?XAz1Kfl08ssAdyjSZemqA4SFb7sTgtODhbRfdoqkWs6qRYkLdTBdlwraBmK1?=
 =?us-ascii?Q?Z8+96vxuGLRXMtM1rl9I50xyQQw902n0icNQQAXFczelbUBlIbeYft/9vuI+?=
 =?us-ascii?Q?Ap5s/W8kfj7ODS73gn2p7EqFqN+7WfkhxTuoi1l8MU4ge74WRLN4SNbE2NvF?=
 =?us-ascii?Q?mLKdBLubM31QmoLp7kX0N/63JP9UmmrqiF0frbctJswjhaSxIeBWhvqN4iT3?=
 =?us-ascii?Q?QT8u1IgQvj5mnuOg0iQjkuXdLJ0I8g+XIzT14LHrB2iVBcSGCLBIa0OB5rHM?=
 =?us-ascii?Q?rQiuJ38IXANvKHDzOXSWO93OsddGPFFkGPkq8c6dQgRBnn9ufhqw1bxu0Huq?=
 =?us-ascii?Q?BRNTjtIgmvbj3/ZZwSX9LAh8TktoOMdJcmwKR2bnsQjglN6JC2gWuy6xzyfi?=
 =?us-ascii?Q?47N9m9Fxc4z6tK/LbWi3ejFEPQU1c8dGBYpSKKjvfN7Uozr/Pu0PkRDi5a3F?=
 =?us-ascii?Q?SeOIUOhsHDO/W+Jo3H06l2CK6RLklZy4arbu8EP8+2JJAUGJDD6m7o51du1k?=
 =?us-ascii?Q?zGgciL+7DLipqaQjaXu2UMxNKjssYoFi3D92gKFXeqwXW87sCq8pWXeZyJPa?=
 =?us-ascii?Q?r9zSNkqjKSR8JnokZ4pDzuVWFIHu95r4+S5PzBwCW2Wh0NS0IB8Lm7XQFceu?=
 =?us-ascii?Q?9vZMixLpe0AgHV2+Il6z9Y3wDvpPIYGkCCrmap6YrQG1XgprjKAUDaYgrjU6?=
 =?us-ascii?Q?FNDjYwgCFWhw62TcXLio+w1nvZIVkTLChdsj2HiN4k5STSYBRzQY68BLJFRc?=
 =?us-ascii?Q?sS/qyXOizYlgRIkE+hlqxbK2LPAbpN8V8KRrBejIUr8ZgRRItGzr6ECzE3O+?=
 =?us-ascii?Q?tZO1aDTbtiDA6LvjRJPynmq2GStGAaylWDteqGLOVh6M4khV3AGC5L7Y56wK?=
 =?us-ascii?Q?lwCKmFej83TXCCdWfCPkuA5sedmdxrKKgjrzFM+2NPXZoBup2LHhxr81cuUm?=
 =?us-ascii?Q?uMk7aKSQOT5hQAvvBx+X1qM3twNG6/npiPMifdYUfDpp8y0MP6kRHuhqGJEZ?=
 =?us-ascii?Q?rcEvhrORroCaK6zQTOU3clFvIYj02F0GBcHb7R6g3ldHAA2BAb06F/+S2HAb?=
 =?us-ascii?Q?KkF8/sLQrZaLwhRZQUlZfQLH6lZyEwk7HOSwTrHDiriC64ShTBeZjNRa7PUC?=
 =?us-ascii?Q?zJ9QK6XqtkseQtx0yGeU6GPuM4drOOqjD1/MTBSwR8rFyKKz0yZ9KmN9tlvK?=
 =?us-ascii?Q?CiuJq84X41T5yLLU7pGsPHyv2E+E8TqguiGAQZBjuDUCCpqiWaY4DrOUHTUI?=
 =?us-ascii?Q?Rmz3zsYhw9/5dl2J18SK/VjESiJ0UlFO+9SnTU7ehnsMh6u41gUnRmBtdMXb?=
 =?us-ascii?Q?GBR/Yajn/vjSTp4Ae0l87+RCNTe1Ny8REGbh8Yw5gdqH/C28E6MSFdFsI3wk?=
 =?us-ascii?Q?hHPBmllZ486YCOtFLcIyfAnxQgaPds04mkECDQKYfNP5cYuFIJxk7i6kNfpE?=
 =?us-ascii?Q?3EZ/9xV8PCzdOXZ+oM2GCx97n153LETTC0FwGmlZMddhli4VjmKnborv+lPa?=
 =?us-ascii?Q?SJUhrrTPG61cASh/vQ63qc05MJNN/PZHlzANu1J23QwFNTjMStlO8nVc1Hz8?=
 =?us-ascii?Q?HZSPdBp+aop8rhgvFdcD3km61xInmdl6x3tz1JtVnME22bnKh4Ft/4gcHUva?=
 =?us-ascii?Q?gIBnKg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdebc47e-3ada-4ed0-3bbd-08d9af04dab8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:43.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWnfESMjZMfRBXk5EN0euX7e7G6EC1c5tSAcHlvesaHRgikIuuVZdmOnZL7ZeCodv9jg1W8GfwaR+Z3wh+Dan3T/GhPbQOfmPVNoyS7ZNK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3894
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: j_A-TQTQxQGnAiGpyPclqzu6L4JtujUE
X-Proofpoint-ORIG-GUID: j_A-TQTQxQGnAiGpyPclqzu6L4JtujUE
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
index 109b58840d45..1de09c7b5f93 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,7 +116,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
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

