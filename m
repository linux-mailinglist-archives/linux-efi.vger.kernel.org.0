Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C985451CC0
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbhKPAWS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348497AbhKPAUN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:13 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNNmcB001717;
        Tue, 16 Nov 2021 00:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/5NuIxD+XV2XONuyuvz8PErITGHCkY5jI0gcJLNHf6M=;
 b=jVULcMMpwg4uxqm9OWcKHDiwY6TvXFM8g9nXVEMSi1IX5vylHqRlD2DNG88Jul9c/l9D
 XQIsZpbdCxX1VWyYobFnpnpblSfkWqrvaE8Q/Ak80P8yH3tT20hIqu8ySycH7YMu9Pbe
 2TRKKfAcJJvvQHoBNDrqnPnQw/S2W7ahSVJ6wmf0Ee3RBAP8a8o6aYCBbCbb0xflwhtg
 ftJoEQc0yogNY25pPSXgq51CWZFMO3rbbwFob/+8gDuwuC3stu405IOEr4FSd5t6D3QV
 guisZFvtmrLE2ONxYjat024aGEkSlAQi2RmTNMIZ8vJeZl/Tzefzfk9ERLpIrzWh8C38 Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3dwwa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0ANmh073035;
        Tue, 16 Nov 2021 00:16:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3030.oracle.com with ESMTP id 3ca3df6jkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDDiOW7jujNKM3zXsF+KoxDZAW/sFZ2C14k8faQfKLgoglE6mQ2w+x1/5P6AWtRiNG11Y2ezyxzgiMJAbdPCoHu1ae14G3oRrcXc/XMOHh9Y7PMk3TO4xSd3i4zmlEzxakx86iKdKbc3hyPdGnt2qt7nQLJi55kw6/Dm3/yhefOsM+X6ww7bRyVyKKy/BbvC7wdKHrxTHqXglH0FRAnvgK7VREiWoMx0C0D25Yt+olV7XZ4Rw2v3ichL1/De4hiQul936eeqGWix04LjYXXy0DqRl2xzESOe3HPOe+3YFMfYoQyZ0UTdHn8ohcf+qg5tp67C7ieSbut5o/EeWIC1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5NuIxD+XV2XONuyuvz8PErITGHCkY5jI0gcJLNHf6M=;
 b=ZLbkREfqhw09xrTSomgN4sWXeE5f/rUCsVb+509BJu2g2/4uAGteNYTFUV6yGnCKUwzsKLbaKn/xRMRccYh6yrWrZ8qmI/L6Au8knezbqZfpKB8fZvm8M4zRlgd+6Z5BFT08gByPSYP6zRtXjYiIe6jeXpqTqau8FAmSIKy5qPtwU3AGn+RaquOhfrMSIIDcYgRoaiK33fEQL4/WZFjFDMWa+OJJ9ynuBnqNSYWXPf1kHWhUHKN3bEnmTKmT7p2q12cBmRQVJGXp1aumi1Yqe6k2BUcth8PGyR55JLQP23a1eCnZbwc3hbQLzDJgRywcY7loroxxJnvUOm6tPI/Ihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5NuIxD+XV2XONuyuvz8PErITGHCkY5jI0gcJLNHf6M=;
 b=qKo+qIARWMYx9np0pf1iSUCpvrZ54Q39fLsZpU5P52W05nbCVBe9SkxQPnzjaSf/eQPSnDNeRQI/x/6n7cscK88gZM0n6cBNnxujbg+HfpTd1zfozQSk1MH5WN2sO2bTOrTIZvNFNwJWbqDxM0NNYOz8ZuOEm/09bHJsi/djuWc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:54 +0000
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
Subject: [PATCH v7 16/17] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Mon, 15 Nov 2021 19:15:44 -0500
Message-Id: <20211116001545.2639333-17-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ecc319-8ccb-4cb7-b0db-08d9a8966531
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB52763F4632E515DEA9DB3EF487999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UDaMCZDDzEwQPi8S3bnAt+T2gZhmUaGwrnYp9VOmT9WgU/SXY7cKGCNynv0CqvJSyhCJtmF9AOwVLgolRbdoNrh1Z+nqT68MYtKeeQjZ8lY6fpkQI2AtPiZpRSBJwNBcinNQIqaKw7xU2hz2FaF4pJZRt8xbWDh+V3gnpFngshurZjHeC5kKCYxB2582A+hwCj6jgF/mv+Cpzpx4RNKT3yicP8S0zJ0lJDKQNlci0YCR+adDy6nwZNHoh5H+57nWfT+mi47TWM9VH8OLTIoAZykw7qd8C/meqN4dd8pYCE7lyTFcf6wS+wr6N/yYoTDWgM1+K3ePKeeAYRY51uWGebXf/sw0GVBtfuZ8lTTRCFEs022NDJqBxgXjOTBiM6HDmJY4b5AvdA1CVohLrQKMy9duJNWPJCoExKXUdVAc/lD/VIJqgo7fEbJYl7lEueXFXj20jnhp5/MJLLs/ep+vxTHG+PKa45cKvBRtsJbJKUyC7JIwmUFA+1n752v3Tb5xTA+r16tMvyHRwsqEVBhtIa5JxM20GrLZZLD5MFVwr0RB1gc3wwBCdQX8iyADwBF7cZvFA9xpnGVKrcVvCjF1FxvWHv7Mew2AnBkEMMuqRaQ4l/5tYabIXpVcFCvNXZEieJgRdCJYto7du7wnt7G0a6OyZYK7Ci+2tuLKvrXNVao5bILFkeT1q/6iRxfKhm4dSVfXvfQmfZM6xy9n5kpJlsVOnDGtgUOFklmlCpUKjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?laa0elK2JdrLgk0ac6X5zOJVMo6/fbM+ytNh8ZeR8kBu3yut7YBtrPeRQny/?=
 =?us-ascii?Q?LRXjFNrw66IgRl9y7wAC2AYTUhTZAgUPI0JlpfJ2UMZZ/XUuFf34EGhMpsOT?=
 =?us-ascii?Q?kSFSGOIsELNI0+qhAXjNF7clath8c48OVwAMBQERj59QngduPFcU7WWUt/Zd?=
 =?us-ascii?Q?AwdrXORB4G+nK/2zkgeRqrVvQ/xihBN8TBAKKOJxZkULrjt++omLzHl+8m99?=
 =?us-ascii?Q?lm4Xh+LAFP/prpiRz7co9tHEwRmznoQx7kSSXkzTAKOXrgdSDFRbQK9bQ4r4?=
 =?us-ascii?Q?Q+M2k1WzxgLhibxwfE62IHmu8htfhXgwktSNE9JKKkjt4dsZZ/jI+SU0BaW2?=
 =?us-ascii?Q?HOGd15Pkd2DwLjbxvtj1R1+epo6Gp9XodgABRJf/ZgOQpq1UJ85ksjqadUgI?=
 =?us-ascii?Q?3UTtZusH35iWt8TylJ36PCRWVruezZ5RPchby54qpQtmY5dPaLnRJesLWdVr?=
 =?us-ascii?Q?6+ASJTEApZHL7Zzece6oKJHDWDlURGaJH9BFXIW8tqDofYGAgHsK4UK66kMO?=
 =?us-ascii?Q?7lz8O6DP/VgZRNj/zHyfODlJJvhINBXbCHlW05xA/UUTpJUUHMiiPG5Aw+jr?=
 =?us-ascii?Q?TciEXyWeZFQcPqbFZvs6kRZh2kMegjYZVQKJcyQBnJrzMmCATcYgah2aOHXB?=
 =?us-ascii?Q?NBS1bO8Z40GGk2klaSw7qZkdR2DlvEe5WWBhyT5YvBYw3NHjdwsp4zfHt0WW?=
 =?us-ascii?Q?lpAuGOKzxYHXLgXLAmrAVNLRRn+eK1xG88v2u8v10Zt7sTI+juBp+VqGDTNg?=
 =?us-ascii?Q?vP8uCoWcloRntHIhkUpNhMJJoMOCg+9gc1iKm8oA3WuqYd9m8BQcjZshh8nd?=
 =?us-ascii?Q?OMNml0ZauBcBphBYHTz92O2c8c2lzTwSwfBtVlT4mc4WeOcc160DVM8UWJkP?=
 =?us-ascii?Q?7RiItg54o8ty5iaXIkSJNsyfpRqCAz+DacxD+gbUUeQAQ6I81moMqn6PIgMH?=
 =?us-ascii?Q?c/ypgYkBSW8EJhMIzbuJqHseiPYaZycHZnWOu65Qfkaj9Nzs5ZVOufepEr2/?=
 =?us-ascii?Q?8bETNN+aC3hkMgpoQvpnFQ+DLVCvmTZbCaLTdwArSWUYuKEMDR3KrD8G4bXd?=
 =?us-ascii?Q?cjQXue0tW6jSxh+3az5aT2e9XYRc1B9JHb6+WfZq3QzlMRswGzQG6pf6tZLj?=
 =?us-ascii?Q?57ZcIXmrWrAXm6N/DzizpzZ8QRpt5+IOWsDN5AtnOW5ayzMtklN3imrlPZrA?=
 =?us-ascii?Q?B+H/ZQhj5wL0HWnmSobfEZlykRFq/ISEswxUlKzame1amTc7/bF/fyEOjYwT?=
 =?us-ascii?Q?tHwf75qU4TPh/vjeEv5jpSKuAVma4qF6y4CAevDrPvio/7e0laKcE0f/JSpt?=
 =?us-ascii?Q?OZ9cedzEKrvbRHWHaBE9ZxlCyI/E+8G1ym+9kuV3YPdJ63Mzg2o1naLxG+dV?=
 =?us-ascii?Q?URgbDkcaIFoyn2uq0toANiO0Ygark152Cej+Qk354NJRCxezt/GBCevUHZli?=
 =?us-ascii?Q?bLeO/elJJOCQmuu6cAMLZHRdBzpup7lmC6jniGAqLNG9Ue6nM4kzr9AzkGJy?=
 =?us-ascii?Q?QepWdZtJ3Sqv0V3uOFphTRXS571fiKwYyZY+QGPxjM7qAJovLf63u/y4esa0?=
 =?us-ascii?Q?5rptPtUv39US/3MHkTA5C+91SC/oLucWyUmnc44mwAMOKPKXWviRd1oaQoXN?=
 =?us-ascii?Q?L6ILyMtE6zJbMCXW/4fKR2LohkIUsGRXksbdxwIzN10iVYUB1cTfnHwpvdYv?=
 =?us-ascii?Q?2rds+Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ecc319-8ccb-4cb7-b0db-08d9a8966531
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:54.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkt+X6qJH6MlCxmT5qY682GwTyHbAScB5tF5uTtbVuMrMKzTjrvp93p4U6CoVw/aZjJecxSGbtZIPvbww85uEGtmpLTzJbwz3DQbqYQUfsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-GUID: IoonEpr3HJebwqOnGpdM5nrbISFuL8t_
X-Proofpoint-ORIG-GUID: IoonEpr3HJebwqOnGpdM5nrbISFuL8t_
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
introduced in shim. When this UEFI variable is set, it indicates the
end-user has made the decision themselves that they wish to trust MOK keys
within the Linux trust boundary.  It is not an error if this variable
does not exist. If it does not exist, the MOK keys should not be trusted
within the kernel.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed mok_keyring_trust_setup function
v4: Unmodified from v2
v5: Rename to machine keyring
v6: Unmodified from v5
v7: Use mokvar table instead of EFI var (suggested by Peter Jones)
---
 .../platform_certs/machine_keyring.c          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index ea2ac2f9f2b5..09fd8f20c756 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021, Oracle and/or its affiliates.
  */
 
+#include <linux/efi.h>
 #include "../integrity.h"
 
 static __init int machine_keyring_init(void)
@@ -40,3 +41,21 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
 	if (rc)
 		pr_info("Error adding keys to machine keyring %s\n", source);
 }
+
+/*
+ * Try to load the MokListTrustedRT MOK variable to see if we should trust
+ * the MOK keys within the kernel. It is not an error if this variable
+ * does not exist.  If it does not exist, MOK keys should not be trusted
+ * within the machine keyring.
+ */
+static __init bool uefi_check_trust_mok_keys(void)
+{
+	struct efi_mokvar_table_entry *mokvar_entry;
+
+	mokvar_entry = efi_mokvar_entry_find("MokListTrustedRT");
+
+	if (mokvar_entry)
+		return true;
+
+	return false;
+}
-- 
2.18.4

