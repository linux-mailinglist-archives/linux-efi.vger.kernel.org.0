Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9671345B351
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbhKXEqH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61952 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241046AbhKXEqA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:00 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2pLtx011710;
        Wed, 24 Nov 2021 04:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hUKlxTtOvzeYb4U8xz6F7qPCsGX3tNuHOoDdP07nEbU=;
 b=LsUkA9ofj+xcBrK3X0Hfr7/8p+/vX8D7dkzDRrxldUHIw7qGckPC2G/J0mMKnWOU0Zpk
 i5i/Ht7FdaObzOXvZxpbhhoqzrObq2sn93Ugj5mzyDVPL13At9NrgWoxuL4tR6BBdoGj
 0oMDaBY8+4S+dLE/Ai25lhLVtPNjz4v+I70AKFh7OvRhYzji1RUxblfqBl0464ugpV4o
 +vmCKV5eKWBrK4b3l4/NZhOzLbTdf8a9A8JfVTTbwkjCm8RF3RAArb46p7GlYFP4IszF
 X2l6lKyAxCnENoCNED0erTeQQLdAjZBh7isrlnu/dnWu5Zix7ZsX1DU+1Cj5W4KLj4AW HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gje9f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4edg5036823;
        Wed, 24 Nov 2021 04:42:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3cep50s6k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0m574RQi3lbybSv5s7P0h84RCq68jZdZih6Hu2dWTgCOJu6Q/afjlTzKWm90PAp+Xk/uV091Cg35jWCLqWP7fuqldoagTriQZkiguXqbRYL/IFb4x3Q4bkedcHdEPckwZa9woXQ1K0cBLT8NAfiDpDZs2jbsUjPNAt2b9baF3xYC0t1vt3bb2RI+QKp0KaEQxTzATTy+Vg0F8OINwdLJp6OAvIHoHRJe876HH5pbo60u9ytb24/z1lokiST5oBnCXUXtPh2B3kMwtsv+Y3hJQJPZcJ6dg2r46uUpu3DsuyPjW7YidHH+NbQ3gSuf1O3X4miMUeQSwEWAeb4X5edMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUKlxTtOvzeYb4U8xz6F7qPCsGX3tNuHOoDdP07nEbU=;
 b=eDZSnzZPmVPT3Y2mj9rEFC9ixi/FcQ8KMLMN8dPOnQgUb0dEFNyjd5iMh+ZrpCCYvnEjB40uBlpMhhPTvK1KMs2SQJh8Li5trsTQA4BgNpfr9Q7Vb1c9/McsqnaxXkqZYLn105egwWNXjd70XIScfqp30ZweDgawtne4E+hvG5jJM1wosqaSZpG4G/kydsDV4nL/Nx1v/YBvP5nOFrsQxC0nA1qz8K2CwkMtG5OpnJRkrnZMtY6ubQkXMjCFxuxEyr+nFafMNk/w0DZqOh6QEQNeV5kH/YCqRhpjgYUdUGQuqmT7j1IGwR2Hz8XRUwTKhgIlfKq6uyev7y8Vwqo6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUKlxTtOvzeYb4U8xz6F7qPCsGX3tNuHOoDdP07nEbU=;
 b=WnKhdkI3B2KTPmxL3eCjARuimnfAhiZO63v1dILMNUg/B1QlfrkJBXRAp40GU+jm+12sQ264O2RoABBW61d8AqIop9Wdy7ycvsquK/rQxnaWiY4yZDx2u3IC3rIRCKWO6i+Z39QrwMUzeWTe9a3xeDbxzwkq9M7tGL7L9KljUMs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3894.namprd10.prod.outlook.com (2603:10b6:610:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 04:42:28 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:27 +0000
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
Subject: [PATCH v8 12/17] KEYS: integrity: change link restriction to trust the machine keyring
Date:   Tue, 23 Nov 2021 23:41:19 -0500
Message-Id: <20211124044124.998170-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88512a71-2208-47ca-7959-08d9af04d134
X-MS-TrafficTypeDiagnostic: CH2PR10MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR10MB38947BAE01732B16856F1A5E87619@CH2PR10MB3894.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPCFkDtQhTFGIpI2j7wJ20RVhbSbwYrVJHvan+G8bys/fe9Ylop8is/K0sei3WQR2IgEATUgIBjoOSlSbI8s3xdA0dR+0KE+CjZHHXhIIApAX+9fEg8JyeNmcOtL7nvyzQJwbeFPI0K6um2p97pyqFZ/rlnxYq/bTrAcMEEYG2j3asL7NfMTA2/YsjljDjz6wHWWv5nl9nZD4Y7vOiME3j3rPVbgSoX5Su7dt4fd7jnw38usGLoVbVrfD7oVqIn79xy+ujNgHHCgCqE30V9Ek8kRdPFExZu1169x669fRHLIs9NkJVGs05I14h8dLw4um92GEiBiyRguyGbifOJ4C7w6cdMyDgkgzgIgMUhnjZRjTfIaM17Y9sDwhbGq+7rBIDzYxwg9/MH8tGWACzlGhh4N1UPmlYLrdO0c/klPUA5CLUpvQeGrydr7PJDnJTbZALQpb3ZOIw0dpUG1P3eJKZXJ+aqLje3BqvBouzv58fkSZ3a9kfg0tAcmjBXvMVtcGmZceJJFFvGio+zjGzz9WzgEeRMHmWrHmg9fYzCr0bSSrdLEENtPk0K2QPTBt2QkZ6X9jtruDa1zA5H/8hdFtOHDuKffV+MJp3HtOr16PYpR/f4h7yO/yZcwiYtRZyFSqjYS8fSGDly7PKLvYBQym7SkXKQkXIwlPqfCUIs6aNKCeQVLtr7XndmbtvcAgl9dNvwmXX8QiNFX/WuYfyN5wyHjB+DwAG3dFM1K4QSwPfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(921005)(36756003)(86362001)(83380400001)(508600001)(5660300002)(4326008)(2616005)(6486002)(186003)(7696005)(44832011)(26005)(8936002)(66946007)(52116002)(8676002)(7416002)(2906002)(66556008)(66476007)(316002)(107886003)(38350700002)(38100700002)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bKYSUPR3J1wpXf6OFFpXPC4mJPWlJc0/lo12ZAIi/c+YvTUB1Z1IUossAqU?=
 =?us-ascii?Q?lqnwxL17eF+Q+TjSqY+3krX8Dh3FdY/uRMOT7PFp0JNbzSfky3DIMyu6SG/z?=
 =?us-ascii?Q?6a/bOB3fgvsNj0CXjxgg5Y98uOSdCIWnT/px7IcKZ5erAu7ae8QRWe4R0mHB?=
 =?us-ascii?Q?WQ9MsKTA0Rg06JbS0b+n3vZfIOxaR6MGJAM37OiznxjdtOZgYSrWTkyiOSTm?=
 =?us-ascii?Q?r8/rctHeN/5htKBYMmTOevA6dGKGsoWFGf4k2VLMTKkfmXyLFukKBJPw0gVy?=
 =?us-ascii?Q?Dn862NbnsGKhPlBjfCcHMHSfNcXSI9vIG2soHbOtmqdIN5PxnUi2r0DmnEK4?=
 =?us-ascii?Q?X9hTTg7nsAEYsEEe1hQonWmH82M+xogfgPI1Y8fUg5zQ4sWEOuJDVJP0Thxb?=
 =?us-ascii?Q?FipfZO3toxXjGjBtrFHwhfxCIvhS+8A1PVQ9kFSTL112HRSHR/PhIBa8Pn+Q?=
 =?us-ascii?Q?LKnTbwLDrpuoddarQSREWPE1k6ChorjqUote0GswFcDx9brG/s90f7/1/W34?=
 =?us-ascii?Q?fe+Nel63x7CrurnxO+5zWSHWqCsVaV/ipUUHldw1+uQIAZAGezqXy37wtpSb?=
 =?us-ascii?Q?qVKJdgwX7Drvug+IhfN+d7Wd/UAqYIS9WZyvKF91+tbIRgccZTm6zoKJYLiB?=
 =?us-ascii?Q?p8tYfkwUJ05qdo4w/rh6qccmYEF58GJloEjvKzr6C2NfIASuoMnXCG/aNZjS?=
 =?us-ascii?Q?UqPgnYQNz8IWVGXfNThGUmzqRlQYBo52YKIlD7Wj7kE0SIlRJ5mBcDDkmwm4?=
 =?us-ascii?Q?GqS5mZuphL25Kivl5gNUfSTalTjAevjl2g4W9CwgIfzvtZN3dahvZmAUmEja?=
 =?us-ascii?Q?CP2PgYiPHbvVScei5XmbIamjgqn4Wcd1oQwT3lPca3IUeVKa/n54lwUUNcEp?=
 =?us-ascii?Q?9/QjfWmS7ieeBG7QPoZ0+D251VH02msYtL0mDEmCqVdWSjOTs/KW+niI0RpX?=
 =?us-ascii?Q?wpiMl+jhJenkYs68fUu7nD9IY2n30955OSxhXrhDRG0hHuFfcemVjoZ7y5J0?=
 =?us-ascii?Q?OfOu9NH30QvBrzaoJKoU3DNoJF9QAHMBxNQmksWnPWRYUX9JMULcf4b2jBER?=
 =?us-ascii?Q?yrPRyYyAERGRl/5cE9Se83Xur+sg97R0gVGOifZgKSHr+ahzBY2TyfLYhMvo?=
 =?us-ascii?Q?Q4WEkuXw3USGxcJu+0RZNkOhtr1jK6xnkN9MPHt/f8x5ZasteJW1sVjohfca?=
 =?us-ascii?Q?VfRWIMxi6FNO9GjuCSH0/ZeBRfA83F8S0mSy79dwAvdike4S0krq0UPdLl4W?=
 =?us-ascii?Q?mXzGgx80TjPqpG+oaQPotiU0QHB+0fDygic6P9V29sBmcaudkUttl6juYCF2?=
 =?us-ascii?Q?wFG9k4bEu9WTmvOprfrChFeTOD/lqaCfUJtd0xvvEo3Qr0uWAazqv8IlhPOQ?=
 =?us-ascii?Q?5tGuM5WnPK/htZlwp69HJ9KeI4RwRRpD/BNeCPcKVJ5mdAmP/vc+oaUj8VTm?=
 =?us-ascii?Q?HU3iLkwHUK2uUNiKCH/DcO8diB1Smr43++uPL0jXcoVEao442bN0UzzpgU1Q?=
 =?us-ascii?Q?2KuayNA//sDLmTHNGEfdNMupd3yYslIB5/IhyvLjIIM9hExJG0K5M5W1tyWt?=
 =?us-ascii?Q?PUCv4NymHhAm7OU13HubeeKey3n6aAKDZv6jZh7a0H6WEL4pg5eAq64sktQ+?=
 =?us-ascii?Q?9Yoh6634OXopY1iQVx06l5I5QWLjgNDaEYZg+xN38qSMQDq5x3X596ajJOwj?=
 =?us-ascii?Q?AP5Nag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88512a71-2208-47ca-7959-08d9af04d134
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:27.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elI2YMwJMB9iupqwmESWJ0o56qMG1B3eRXL91zjlq8/O5TO3mzZIMDA7sPM1BdPcS/k1uuiaqATDiTE5KJwpLEknUeEPCVBdY9Jgope/fnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3894
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: zZ5l-7G7ta7hAKK0aKHgEjdDQ79EjkZ8
X-Proofpoint-ORIG-GUID: zZ5l-7G7ta7hAKK0aKHgEjdDQ79EjkZ8
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With the introduction of the machine keyring, the end-user may choose to
trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
trust them, the .machine keyring will contain these keys.  If not, the
machine keyring will always be empty.  Update the restriction check to
allow the secondary trusted keyring and ima keyring to also trust
machine keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v4: Initial version (consolidated two previous patches)
v5: Rename to machine keyring
v6: Account for restriction being renamed earlier
v7: Unmodified from v6
v8: Code unmodified from v7 added Mimi's Reviewed-by
---
 certs/system_keyring.c      | 5 ++++-
 security/integrity/digsig.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 8a2fd1dc15db..07f410918e62 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -89,7 +89,10 @@ static __init struct key_restriction *get_secondary_restriction(void)
 	if (!restriction)
 		panic("Can't allocate secondary trusted keyring restriction\n");
 
-	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
+	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+		restriction->check = restrict_link_by_builtin_secondary_and_machine;
+	else
+		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
 
 	return restriction;
 }
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e7dfc55a7c55..74f73f7cc4fe 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,7 +34,11 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+#define restrict_link_to_ima restrict_link_by_builtin_secondary_and_machine
+#else
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#endif
 #else
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
-- 
2.18.4

