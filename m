Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0849C196
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiAZDAM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18628 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236736AbiAZDAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:10 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMnMlh001973;
        Wed, 26 Jan 2022 02:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=buHYZo1Lk47XcLfgsnK+nEMTcS2B+qK7iLPY5yNlI+4=;
 b=EqOh5rh3nuw5eHXflvKGTAyp4KW1X67ZKaNHXbTE1IHBLlV/PNwAgLZuR4hNw1vGyfHU
 ZVCxhuGoi31cj1Kpvax+7B23TlBYsawOWTAvx29XLszxETZJ8UcTznzjpnNph/3NFnFw
 rOlefrnulHgk4k0MJ5lDXQ0BBSH20OKujgt0evZUwe2jaJCHXqxfgVmL9MwqSRU9OqSJ
 CRoX50+07hhEA5vm5QpKFy21c9dN5MYutfrqnHVGRNoSa0yq36Q0gVuX4FA1phOAx1jr
 H6XYkv066TAuZfrNnCve6pFrWHBtlYcPc1JMr2ZDJLvH9YfXz2tki6W16oC9dyqCk0gq 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9n9cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2pIZc181301;
        Wed, 26 Jan 2022 02:59:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3dr7yh0ss9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVuNYbwIQ4je68hQjBxlXgEhF0/X6hgqfyu3QA+InXUBMn4a+bzelxGzAcBpMSS/NuqkEmRN0qonj09oPXpcCNAb6i4yW1fqa/RdpP11Yy2Vlkvzj8h9qVtjqLzqEDdfM9SkofSKqvstiIf/Z04i4RRAXxEogGNenhL8PhCQtwrDVDA4di7hRQrvTsO4OWCpKV2OIPu175TrbA0U16ph19ium1avHNtmtORBzDL9lyKHBUxTHrESKzNHE7C2MMKBZIrfRksW6lHW3ccZ8b2KtduDP+FkCWdL3rxmd9jveuIKFo3FjGstaFpsCYGuWg/olkWvaNvxzCWs3mF8HeYSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buHYZo1Lk47XcLfgsnK+nEMTcS2B+qK7iLPY5yNlI+4=;
 b=lD2Y/Y2LaNgyCCEEqgXhK4tdXqP31+ZUQyTFGiZgamjUq9fJWHnbBXYsLlmBA0XaKIVT8DnSupRe4BLaGK7owpQ6pcqFS5JwuQxXM7cQxwsTqAStEQS6bdpWG+Os+TknMQuiumO4QzYCZ4RVrzo4hIx463Q9u0nEDsfR+sQ4Xm+YvUOELAotbnrfoMxps4/tmpXHApW7C6L00FLBQme35Wz7T35+jRXk146xjztQR9fvJuneogZkkbM4692lH3R4Lkm47MMvG/kbIX45324blyIul61M0y7d9sNG89di9iN56GgJbyrW6Z83vfMMwqRrmDpPK8xWOpxnY/XornB1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buHYZo1Lk47XcLfgsnK+nEMTcS2B+qK7iLPY5yNlI+4=;
 b=R82v7VI4Pfx/ejfc0mVwo2bqkIRRwx2JBssU60wSqJoTAb4zaTdvPq0J0BR9R/i6AV6NgqLMg2ItOaWDNvk1HYc69+36U504bJVtk9iQN9ixNsE6E7un4m8YCNU5AEKVMmWQ0Oa9waOJlzvBx+N32V8rib/rBrkJPbzp89PcfpM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:37 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:37 +0000
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
Subject: [PATCH v10 4/8] KEYS: store reference to machine keyring
Date:   Tue, 25 Jan 2022 21:58:30 -0500
Message-Id: <20220126025834.255493-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf80a2ae-a437-4d83-1800-08d9e077e363
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4654BC3485B98C4F1644E85187209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZF38vvwph6M30hGYIxXdBmv18y1q1a4Ch5dxSGDlnVnVnkJQtGbR7363l9hstCduGk7Z51eHgCI7EJzHpbw0fGJbOeDk5mSBI0WCfSuwrGgCQHwV1bfMrrVw1vYnma1G/EPGVBzfJwVQWmxgNof2Jy+Wa20g+pCi0DIaskTbuDj+XpkjxIEPz4uy0aFXXiURoFoCX0rvCu/Es90B2sFdpM4aun9VcpbptSSosKNzD+qBIglwn4kglS5PIgB/bB71ZZ9LFkbczNS0NF/isO7NZfqvlWo18ifjdDL9MVGtutN8GANKk2q2mVyChz0JKob2Wnhgts+J3RtcGO7Moup2s+dn/FUVdXcaJjJrK4NujHWItHEmOdlpRrC8AtsUR87pBgmCpxxezeUKAyJRUK6stnxiIbdf/QGYv/JZlIKdGqHvnFvUDqzI59BjM3qX641C2uABB5kpqB5/s2i6gHmI+Q6qYBu+kGwTGQmxTXB4Cbnm/4sDhmx7WXCE9VFYLZQX8Vl9Bnt/k2mxFMaCFY9eWIBJXsMa+9B7EFsy4WrPIp8z5JhYzdswBuN+68/VExFkL3sxeek1EPPufBU4rc+jku3R0TTu161ezxrCCzQkw2DmSaUl5APqu0OX2r+cVNmbHo2Nx/tnknlUQ0lHAk58bd4dJI+Ad6kdexnbpiYfk+MoHPB675qdwlKQAjwj8ZpmNvNa7YDZ9GT9Iub5FrM7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nQPKPO5KnvvIeBMp1G+DnhH2bCrjrTAp+KexMm+bZbY2agiwpzd7DItIfI+Q?=
 =?us-ascii?Q?Az5KpOieR77/IB6YNwRsxh12Ff2bbY66wj1K5q1atkws7juR1t/uwW46bm3x?=
 =?us-ascii?Q?7smCmk4ncSHOmKS2fLZfsZrcNQHzWgRyuDAwsu+mHUCaQuPmO3LjnNYQ0FeQ?=
 =?us-ascii?Q?zlQdPyET0dHzhuUHxQo6HiEDd39AZCe33HSUcA01rtcIIgF84mObERdd8wQ4?=
 =?us-ascii?Q?+AVXs48AoGgT9OCfJDIEJis3rVodTq7uKyrcVOUzUPzl2icZN/9durSaI9+A?=
 =?us-ascii?Q?UebYMKknBj6Kn1qjYhZh9KDjSUImGlZ3sJL9RltCQu+t0DccseT7RQqNTAYQ?=
 =?us-ascii?Q?ZJvgfYZAb5G8jLQG177i3MAdGsmTkwkBMsZtCVP1oJvIGRKx1tA3f9aaW0cb?=
 =?us-ascii?Q?0ukyXa7VTQxexnBfcfBCl/f/LFZZLUtXoF+9cShoo0IPUXMzn58GTGYW5wt2?=
 =?us-ascii?Q?WV63VSkIlecQXlkLZQLowwEK/f4IOESE+SMdjbazH58MevysfgxmkmPsPEVV?=
 =?us-ascii?Q?GVqeVK7rxupSjNwdPZsp3ycKBTCp92dk7MbP/w3tcAEaWo8XO/G+zXarLYPp?=
 =?us-ascii?Q?7m0SS0qtkf0SZ4ypTLI/qb23c3UF9hz0zieVqBAfnQX1Y1avKrEH3wvb75NP?=
 =?us-ascii?Q?jgaErpLcob6bCLJarrx4n3w/4gpWuHOVlBT/lIWAunS6A3cJx+e8AFJPVcxJ?=
 =?us-ascii?Q?Cz10hQwZ48m8bADGMAEy/J+/6kbFtFyh4BIADk1kJkT02pD2BLhzb4lnZy1r?=
 =?us-ascii?Q?PR5G7HXZHmWbbCh2xRe9JPqmiMDCnFcdlYiSn3WpxWHZoudj2njZipqmyKYy?=
 =?us-ascii?Q?8VIyiMfs7FG5wUis6dGAG9kHL6u/0pLq+aoh3qdF91K28NWaeC4CelKpapkm?=
 =?us-ascii?Q?A+L9lg7YjhRiTt0mgv23gqB8Ac1bbBGUtOTCsUpLooUQ5x8x0hoU/IkuU8vQ?=
 =?us-ascii?Q?mQglTT4uLPJ4kdllhdjC2E7/sdH97McsAnITqbJjBzIWmKo9eCN83PJRIP7K?=
 =?us-ascii?Q?o5u1Zp2iG0wOqhWDmxxVvTeniQ15NEZFErw/RPKiWcJbet9uRBabN2ZqppmM?=
 =?us-ascii?Q?OFwLZ6FO0J3rfbqiS2/ctYpNUM0/cs+8ftB0wEErQOkUpw4B0PYT+EAnCcBE?=
 =?us-ascii?Q?dsa9exnGtzY7hubJxCPoNdufvZgwluFypWDPcQnabJtTOZ0Bl6c3FpokWGXT?=
 =?us-ascii?Q?vyukZbfQ2n48CDqChTRK4ke8lFOkTEHLhE+8Sr+OAwRFxXtpjdnRWMRmodyI?=
 =?us-ascii?Q?4TwLr93eRT8Sia7iUZcvIfSRbhMsNVMHVGrM2qMdr3QBOUzTm4yYTjuddcEU?=
 =?us-ascii?Q?cbGXlo1YAxz0OU7fF4CDUL1UhUMQh1xBO5P/EXILJF9MlD/T+j4V0779xllb?=
 =?us-ascii?Q?sp1nhZtmhYCz9IRc+L9xSwiZqO3dyJ1vBpc9aTDHXVxZ/u6Mm9pt/KXj0y6r?=
 =?us-ascii?Q?t0zohvs0MMnPbGzW1I6uuiJsgIRe3Loy2imVi3hcfxrEVTHg1xCo9Jrtqc5S?=
 =?us-ascii?Q?8a9f0bSL63kCjvYpNfQtid0zPcl1mQIwjztRNSt2Ba5rAzrowvRLY20t8hR3?=
 =?us-ascii?Q?+Rv6Fjr5TDmYFlTX7/HwGrwVA9wTsIMWqqTEMovLJUMPOQ+IyXiRpiVQMT6L?=
 =?us-ascii?Q?2JNbCoFKZOB+mKpDYER/3HIPZHjLLA3EdrwwCKDuStc2D/6S77YEUJbVoIFl?=
 =?us-ascii?Q?wsPxM/o10vvF8ZIP420bzGZuHo8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf80a2ae-a437-4d83-1800-08d9e077e363
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:37.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fQ9OTyPDb7IYtxA1RKUfOlD/QaQ++DrthgfojfK0w4rTHaH+tx/ZbpJC1CzpoYpU9qg3H+4wxLKALygSH4yHFOVW5HrET+adMffa24aLh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260011
X-Proofpoint-ORIG-GUID: 4b2HZbqVaLU-S80c8y82mpmeqmMbq7Yl
X-Proofpoint-GUID: 4b2HZbqVaLU-S80c8y82mpmeqmMbq7Yl
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Expose the .machine keyring created in integrity code by adding
a reference.  Store a reference to the machine keyring in
system keyring code. The system keyring code needs this to complete
the keyring link to the machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
v2: Initial version
v3: Unmodified from v2
v4: Removed trust_moklist check
v5: Rename to machine keyring
v8: Unmodified from v5
v9: Combine with "add reference to machine keyring" patch
v10: Added Jarkko's Reviewed-by and Mimi's Tested-by
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 8 ++++++++
 security/integrity/digsig.c   | 2 ++
 3 files changed, 19 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..08ea542c8096 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -22,6 +22,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+static struct key *machine_trusted_keys;
+#endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
 #endif
@@ -91,6 +94,12 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	return restriction;
 }
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init set_machine_trusted_keys(struct key *keyring)
+{
+	machine_trusted_keys = keyring;
+}
+#endif
 
 /*
  * Create the trusted keyrings
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..98c9b10cdc17 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -38,6 +38,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern void __init set_machine_trusted_keys(struct key *keyring);
+#else
+static inline void __init set_machine_trusted_keys(struct key *keyring)
+{
+}
+#endif
+
 extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 2b7fa85613c0..7b719aa76188 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -112,6 +112,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MACHINE)
+			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4

