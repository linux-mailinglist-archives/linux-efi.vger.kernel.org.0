Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9A485C7F
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbiAEXvn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40488 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245570AbiAEXvF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N51vo032378;
        Wed, 5 Jan 2022 23:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bNw5T2SnzPzUMDoAeYYwoxugAs6OA0EbabISVE09Nro=;
 b=tStS2LZJellguQ000YGdch80wVurjrUAe/E5OLHtzTv0GaqhRPCpplsewC1XgwNJHFzd
 XTs5qJBRJjggj59lojYC/ukrmXe0RFZuSTh9ynb4pqqo4nUJ5E0pBb3gem9tGzeAvzh6
 1/GXwSKsWEvxM3b+akbPLGIK4VYD5yNMXUf5h1FWwki5hrWK5GUgfnRXU8FNGIE9e4MC
 Q+2zukPRuEezaLGfl81Wqs3D12GwkBl1YjgltAN/H5fWGga2TjMtMJiO9TSK0EAZtY4V
 RKL2/Y06QVzzYofuBvNMXGzYbctAE/W9VyWiRd0i9/HiePwUwB7SbGlroQ0D75hbELNt Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjr22t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjHlY177030;
        Wed, 5 Jan 2022 23:50:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3ddmq5shfg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoL9akT20ockzu1n6SXGjfcQZlRFcvUidJSCnMfzKvgglg0JmaOuUTgu1i64pfZYg1M4zcmpPAESSAokc3iBWA2zyoC7qlltO7BTtl0GQjxzYsCRqz+cV0s2NcClqWWdYHkcN5fuUv3iNexUnraxV3TMHBHzgbQIwc7IpQFvzl1HjtBEwzk3OFHBGYHVd04nQjht4qS5hC8VSLR/vAtHjyYveHNkWgzQEwv6yM0U9SzU0eL6NiXT16mVV6rpefKK3Vv+/k5TzY8V33xsOfuRTJss9g+FlPygeLFyIF/JXT8uIuSGtQp82mzvIWs1Cp38Ho7e47KbdkqYT2qjyh4KZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNw5T2SnzPzUMDoAeYYwoxugAs6OA0EbabISVE09Nro=;
 b=Wt8sGFdarxsYxXoC+cqX9Zl6bx+FMydCsj0go3rkOW7kJZN6ZPFEzaQjbhGq6KPIze9onlb/3l69gRTEBWl53LgGQYJOSxyVa9HcSQZEhe+FFpouPxLtJ3naP5xnafBor0wASa+j+votBFb5Gg3n6Gjdjuge58BiqKVnf8SEQKsQ3Oorj+LcgXMq0fFOLk1DIAoUwkBypzZdCWxmbKF9q9izs2xHsEzWKVRkU5rdWFRABkm6rL25c5oc1JM50M9ZunNCkkSuTvqSGWPbdRs2TEsQXMY989StrcR366+RBv1xc1FZG16ipaw4yhPPtkpduOWtNsyGRaS6rNIt6bE0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNw5T2SnzPzUMDoAeYYwoxugAs6OA0EbabISVE09Nro=;
 b=tstO6O3+Lf7UBK/K36p4V6xcwnRq0DPslPsVniDCstr/AFtUhNhkPBgNJL96JPZh/Njwgq8PbVsPYG6pcMxiQonTPhG8B11as4UmMbMtiYm8YLaX7M8IUMfydlFxI7MMzSaETTPtf2HR95xQrcu/LRSwEpsH4ajxRynjfYLRSac=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:44 +0000
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
Subject: [PATCH v9 7/8] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Wed,  5 Jan 2022 18:50:11 -0500
Message-Id: <20220105235012.2497118-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18b43839-f972-44b1-44b6-08d9d0a63067
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5034BA5069686458008A3BCD874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhqzKZ8Bf7tGsZz6BuM5dLuDXhnJM0T8beRTGp553iwC5ElcfCfJlv9ixxTnErAdn2la0Akj167qBmGTY189NsCcc8KZsNi4ZsPiQ3VVjWF2ZWoywl0dm6Kxcjz3oi/RIYcv7Uq1C8U2qpmxxavIuD83+NSrrxQp9pOyXQHBpdUH4sqrzi9XelWJfwovmgcvn6PU88Snmm6fXPuL/8h86pHb34R8IoOwCUyRtMZ/aMieAAl7h2jdhqXacsk9OzPuNG3TGGC5+ZOqlxXfZ7glwl6TJ6dXPBW/QsMjbfxA7QrDR9xU2i9Gczt8QkYoILj1xIaePFoaGYtzedD22oNDPlgqxj68xzLP6gJW7HvJ3Dyabod44BoCZJOhY5RQPBjjzKayjR3PJtlV/DTV7R8UtgucQ6qIee7iae/GD9RFtadbg/0U7tGL0kAl3b5DjlFgsBQkpZyIAbulOC9f6A9NZJMLKBCGeQLmR8OIiYYVolylbOseVeUNeBMHckacXSpvQmsRcWP1nmfpKm9w07CMVXG0nXJcif1YZ9gSWqZk9aAQUJo/EjJXHmoB4/JkioUSWksfJaSSODeuvneUgmhoUm+P9cpOSWAJYtSAtAnUlL0DmPTCexJyjmAgOmUtkCWIK0TCaFVkJiwOx3k/V2DK4/OV38SK4sE6HBTcCkuD1ukTLlEuj0oVBzkIgRqGrkFaLRLizDzByX+Oa0xBzH//zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?em962W3d1M1vKALmj3HdRsQL5rsStZih0p5WWZBLGoL43CFltPrVP+99Lt+M?=
 =?us-ascii?Q?7N9ILJpnaanEjXck2/nukik+0IHJJmWTojHC61Ot5pyFApNxbH9L/8thndyy?=
 =?us-ascii?Q?Q9bMuxryttTgfEsoFNC9liQTxJdnmtcIXtZq/SyhDMwKxE0Fi3h2LuJ68ehQ?=
 =?us-ascii?Q?JRHOPsHlmYUoc9WDrvyO52kKk1FjNzMGF0evP81uuPMoqeca+7gkEX5ahuH5?=
 =?us-ascii?Q?sJoIlhgaZecNsF3kii7umiB2qVV/q0IKxO5As0zG/jgddirhGFu1Y9oyraA/?=
 =?us-ascii?Q?OZVnp0H+LGlXl8qoq7MTOmfao9d1oHLQ4sOmwQQGW47Nhj5n3j59Jv/p0WUS?=
 =?us-ascii?Q?jqZhijnaM5tz2C4GV3KMxl7AzEdJEKU+UnuwbN3qVcm+B5gDltIuMsOmu9sQ?=
 =?us-ascii?Q?LXym7u9fcj5MJqGY3qp/rE9692a21WtsjNAEwJxyf5uAOvrbUu/HPo370BMF?=
 =?us-ascii?Q?QtPe7gRVGKjvVOtaLY8bS8jQJJna6ntFZc8Ytjz9AWksiWIU70TqNOPULJLS?=
 =?us-ascii?Q?mw0fhUtFMQq7uGQXqiOX8cnoE/8vPxK9UkN4euqzOlXWU0Dm7I/EAp4O4UuS?=
 =?us-ascii?Q?ikGM+Ls6KvkUFpfsGytVLfTh4NBgK/dymOOJZBhhJ6B1rc/JTL5XPGYTUrMc?=
 =?us-ascii?Q?J4qBqqXbJ0kl4T/wm/FXlQJkrQnPR9B9ybDFeaVrH0DY+QjZUHWzC+SFTgvi?=
 =?us-ascii?Q?msegv/d1VvZKBtQd7vAhU9ZtYJe1KnHZF+GWXgFQt/tFWW986rfG2zlhWolG?=
 =?us-ascii?Q?a82HaAmC/gVjvMFQ0yz9xMxSmilME5GaYmCll1cVgYnGTnjuKLrfNrPK4Ia4?=
 =?us-ascii?Q?GT1Ygsv0jrn6ZA48PzS3PQ6SVK7edc25dFsZsZMbShr0vpLRQa1bHro959ji?=
 =?us-ascii?Q?udOtQ3/MUTu3jnOsqMxpO0r8Hsfl5UOkdrAvtI3VvsnysCpcX0MuoVpgsO8N?=
 =?us-ascii?Q?2MrD5YyEQRw8joT6bohm26S5T2nYIueNcxvjk7/b3i3co1ouY2p69PtdUYZY?=
 =?us-ascii?Q?BnMtMwacxlySirrpzn/VrbicS736BhQUO3KcUopJSm7GaU8uOb3BloUyBz0N?=
 =?us-ascii?Q?+SsfWbKw7xR2sFW7f2UAbGIUS923zDhM0dsEr8r4DBgVdUjhGb/MPUY6PWv8?=
 =?us-ascii?Q?U6UkxjSDK9weUxGHspNHrCL99Yroedc2OWJ3OSeIY0UYQ8gfJ4Tv1bjH/UVY?=
 =?us-ascii?Q?i/sjQzDoXx0jtmLqbK/UIHTmHspXOF2xuS4ssoONqndxAIBNWoDnoYaBYVdJ?=
 =?us-ascii?Q?LNBs/oN1pM97nSsYgFD3mk3SVBLbIQ5WIKt2nX26hkA/fVDkP/0lif/4u2yU?=
 =?us-ascii?Q?kvu111hnesvNs794a3alqLaf1QEiIHWh3LJ6e1rOsU6s6NfO7/HUOdplqXpO?=
 =?us-ascii?Q?fZey89iqNGhKDor+Z0MZPIuTqI7CU5xtYUDHe1EXIBtw2u4dBSI6zxn4npmj?=
 =?us-ascii?Q?/Wq/80LX92odo/NcY1LBGwfl3YATOGc/w3RDusxJCyNZ6tuzjkmg0xOmO0Bd?=
 =?us-ascii?Q?1SCJ96Xk0Ld3WT0Y1OpISix6t3GkT8CSZZ9Z1CniDR/J+mB9CdenQtdbfUD/?=
 =?us-ascii?Q?Re25gDobSl7/XLw6g5LWFVt4ll5fNWAUPNu+R+2MMjcm/boZ42gYj8TYzybm?=
 =?us-ascii?Q?OsGuovRa5ao2ht77d+7MWEKHFT06I5SbakTWKNvNK/awRSckcODhzf9PnPyV?=
 =?us-ascii?Q?lVl9Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b43839-f972-44b1-44b6-08d9d0a63067
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:44.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi3UFU1l8eAuwm8GHXSE+b3uhHuWXeSDuqyyOPrWdaEMRP9qh9j+eMununFwgdn6OcDkcHwbi1VlcGBwetwP/wkuc/WjZw0H84IFvnlHkX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-ORIG-GUID: 1I6LxVyovOFrrbmOWOH6w6ORNESiX47E
X-Proofpoint-GUID: 1I6LxVyovOFrrbmOWOH6w6ORNESiX47E
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
v9: Unmodified from v7
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

