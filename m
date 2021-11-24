Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4145B38C
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhKXErP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:47:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6486 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241131AbhKXEqK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:10 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4Y8e1029966;
        Wed, 24 Nov 2021 04:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BkWxG+y2SzGi+g+KjdeXKZpEBjv7VUde3CND+S+hRCs=;
 b=tHhChDyGiVjBbemFioq2DLrfUqPGb1K+N9DXQZEVfb9k/RmRVTr1VSd6q3Eal/6nltjn
 MzkOZTRLRNZz1/zqAbqVgeGJvv9yF60KEbaVGSqG7AD1N7uY699NIOQi3QsoAdul2BS7
 D8JvL94XwnXBkio9cHkuFG36g8j0xuBoFkyM+f3x5s9/7RI7ThrWscohMagpkufBzv5Y
 lTx3MF3E58LTn4tRqZuIhp05d5C//QB4K4UwBf5rso1HnezbK12BH6aR/gTUptJWw/aa
 xSmyRjrF01kDZIO+f2VyHkaine3OSiiE+ZMw6/cABBbcIPpUX6xtIuOu04/XFaXe5ndw wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55g76s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4fXmI181888;
        Wed, 24 Nov 2021 04:42:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 3ch5tgp3wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEFzgva76S6sYfFAuy2d7pL79fDhIF0oyAJRH22xRr8MQMyW4OQL2Mkh8PmE3aV0A2eqxZPXJdvgfkt14iYAzFYMlsXhrnVwdA0SNP3Ec7Sfq/r7+Y9cB7mQbyTWVYJ0Ct3ns2ethO/eLmoeMNVytZiUdEdqJFSJi8hl4DHzMD3RJQ7jg6Q07MqfbKx4akOYvuxWdtvrwyVvZbqAzqLXBgac32LXTiZSUFNERll8H9Mkfr24ToGEqtxHVKM9IqgwhkJ0cC3hnpGs40Xu/0IEb9+F+Eqw1+rXkfjDr0fYPILg2/BHPVsZIx9iBXV5KPfEqmATVnqw3UHbUU59T5ooOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkWxG+y2SzGi+g+KjdeXKZpEBjv7VUde3CND+S+hRCs=;
 b=Vjvab2Kkqro+0y6IWyjzUMSRH0zNZdBVCA2JLTdS+0zIEdO59DAEzI4FVbVPdnIn7QbMg9+EogARjv8iphjlWdwwj5iiH2wPV1XZrOF3b6XBmGcuwCssUs8KP7uJJqjeFHm2ZcV8kpZRfrEvrGR8fFUexNThV6nPZurY6OsFVwfXxI4pZs7/v7mcjbYmHeNUfSSNXh054LuXIUp3/H6UdMWbz8tyfEiW4v8xVYBWBvbfmOi8h4FpaGwBZaffh33tw1KAMUM6Dljdp+92AZkcUNv/KyZwFPrTMvmOtTPQ4Taprv+948VFnelIeFag5gThu/SLxZROTw2C+UHtxTn2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkWxG+y2SzGi+g+KjdeXKZpEBjv7VUde3CND+S+hRCs=;
 b=KhueD9nitIXl58Bea57r9aYgEKv2k0D8ngOKQ4l7WrpPdDhSmDFvt9GJtqQGn/fycvEEWH/5Axn28qXxbQJoT5TZ/vGr0ifpBYKneJet7SWLoolI+Zg7yRZftJUdgfJj7P65aY7dBdUjuWjniduiqljHRyqptTl3kFup13HOq9U=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3894.namprd10.prod.outlook.com (2603:10b6:610:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 04:42:40 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:40 +0000
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
Subject: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Tue, 23 Nov 2021 23:41:23 -0500
Message-Id: <20211124044124.998170-17-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5f183ec-6e42-4d5c-09b7-08d9af04d8ee
X-MS-TrafficTypeDiagnostic: CH2PR10MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR10MB389412EFE1E1DBD5D7A2123587619@CH2PR10MB3894.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBUnpw6aqnKioclsRNyVfPP2n6mHT+QUFKj1whAAHfWoRnuKZmfqXfK5b+MTSkG9dETGJF7V+7sRBJ50vnyWOqHG8i6M9bo0lt7RC84+pB8dPopdEOr4eyXfDSBSblB2c3bJ/WryrDyQkhD3nn44WP9XSW5QaQXaeji8MyhwJZU0ATsZRcPXnVY+ZMgAv4lVMQOYSRsHVo+9psw9vuPd1BPqRGCjbUbHeJpyOO1XT4ywoLHd18hXu+8lJ62p2Rbkt2s4ZesjSbo3kCUyXK87lIQIzHEH9rwZKEL+B0OKTdAWwrwVIsqPOep0m5cfoZiZyVuVzLZG/TptJJjds0R/4PLPh5e06cRm7q3cLu1JQpny6BqZav3quUDSR98bPYY0nUPce2oDcAYsj9cw5ZWUZKbuPhGbpOFUm8oK3ZlsDVWqfDe2bNBLpgE4HmMhCrboXmAVaM6mNnTXsaad9y6+lcZ+jd009jFYn6f1JEtcDvefQpFkIpTyRlG6ZmNrwNipuemFruya/mt1pVdy249YVE0p/zTwNg5fugGb5BnVGptURf5bdwNdch1hQWT7s0rN7SfzyyNhog+5W3J1vBhNNo8VtfEOoiC25AEdI4tunb5rujMxiWAnRQW/pz0CzrDqFEX7NGc+9zTaiu+mXxrqpy1QSvW6gdeLzKBmT1wB40REyE3QthH6Xs4CMIHgH1a9y7X9mUcXKxmZkPTIND0zSN/wB1tstxsyjL7VOj+LfVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(921005)(36756003)(86362001)(83380400001)(508600001)(5660300002)(4326008)(2616005)(6486002)(186003)(7696005)(44832011)(26005)(8936002)(66946007)(52116002)(8676002)(7416002)(2906002)(66556008)(66476007)(316002)(107886003)(38350700002)(38100700002)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5HrrjmmHcBBSqFR/vL7z5jk17bbM+tl1peqNcC6XZ1m7/MVbW3ak85lceNAe?=
 =?us-ascii?Q?YOjRsY2jELAHN53TtZaCWgBfaqEErvUXXn+JW1QTxeEXYpUl5TID1NtmbYjU?=
 =?us-ascii?Q?9OwyEaIXkO+s9GeWBE4z+uszdeLLPhP8QoO+z/a3gAUv+ieIo9B6jC8COpqx?=
 =?us-ascii?Q?MyxSTztp+UpUMnW01VaJkBr/LkvT0/5MjX8ZB0zFCeW41X/X+/tjrlq5AY0z?=
 =?us-ascii?Q?Io+QQXT2Wbk6zEsK8H2rlmdsdK4weMGROshpOZda4x8visRbfSyqLff/sLI3?=
 =?us-ascii?Q?NVLOlJQXrkHEA0aIGOOWjwpGPXXo/geIixlBHrwbu0xMNMk+F1HdvxBAsIUQ?=
 =?us-ascii?Q?nqzdP4wLXwe18FYwJGDy8liHRPQjhXu+HfitXTvv5RMeRDOrox5NBxe5jEt8?=
 =?us-ascii?Q?Uo9ItGk6AkrETPkHOciUj7jteFiVpPwLFkts8DgrwOV1uHUjhzbEnkj8h9gX?=
 =?us-ascii?Q?5Y+5xnhs9sG7Sx/hQ+PRP+M9VMHzAuq9XBnWZGUIj0icispGrNO7aebTHYji?=
 =?us-ascii?Q?IpsPBE1FpwN/BrqOaGbkW3Sjt8kCYGr8pDrRyQ2YMmCCVvp6K9HDsrTa60nR?=
 =?us-ascii?Q?so2+DubYlK7CGxpkqm2kPIxC5gCV/BRiWoklKCeaqgN1ZsmtgDJBCC3boIdj?=
 =?us-ascii?Q?KHcCf50a19ouu+emH2XeQkJ6oeUULS/of+osadxKbk+yygtYWcxs2v0vNoxf?=
 =?us-ascii?Q?FMVmLzapJhgY/J6c0Ft27YtgZhPrSnjJFRBXsBBQ6brbiJaDcqoN7zshM9rj?=
 =?us-ascii?Q?UuDO8y+QsH/Z7MzTNlI/iGA7egWNSm1NwG7J9YBfQ2BReBKGHsiQBmbl18qs?=
 =?us-ascii?Q?cAMH3oYEjwNDOHmse+2BdOqjDmrIrkq5mFYN3qfKEEscejBu3PTY/5EWgU2R?=
 =?us-ascii?Q?fHNi2QdeKwNWBKxXSmANLyKTINvAszdFse0a0MjKFj9v069yGkeqgpTQehQ1?=
 =?us-ascii?Q?iNcow5QfLGR7BK8Ao7NsYEiOgLj6kGq6FXPpuYrcIG0NjZ6BLVUQiyHzruH5?=
 =?us-ascii?Q?kL9N1qPTJcPNl70dPCeTC8W5PMXUKOsB5LVex2jjKp0xVlpea5QHeTOkU1X2?=
 =?us-ascii?Q?MD1/3ZePvE6W/MGxqH2DywdqkWT1EluM5B50lNJZ+vwH3dxmT1fDT3VMj/vJ?=
 =?us-ascii?Q?xShdKqfEGeUcdHzOUEv//NtuvK/V/3BIT7PU7l0e9df1cscR0sF4mpObc95v?=
 =?us-ascii?Q?vEEO968q8xKLVQk7KW3kc89EBaONC7YiEugdey3ihBoDejo0Np0KP1CU2iN3?=
 =?us-ascii?Q?Eypy28fl2vT4bBvlq0CKwtZz3otqbbXVqxzQm6DVyd/2cO54OL9DeUyuINuk?=
 =?us-ascii?Q?8bbtLWbbU/eBd4pFQx+ang1IWeXemJuEH7igSHkUWSiFXD6Cq6N7B4nWLlzN?=
 =?us-ascii?Q?V8YWrC87URyz7mnTe3nXSZrUeXi4KvcIkwjmUE0Yd5wxItN6+GsQlHx9w+Rd?=
 =?us-ascii?Q?r4u8A6w6uH8HESp1YvDtSWztWrqn5VbOdclIyhkMUk9GF0ezLpv/N22BWwhr?=
 =?us-ascii?Q?Hw+7Zak+nXyJug3y/TI2UVfjSjLvVU9epOUF42TskZiriRG5RN1ZsXG1MIID?=
 =?us-ascii?Q?yJU0ygf8ZALHTLYJbNpdcyE9iIhizbmDhVdHpHO6hsFY7lG7uui+JTogWCYQ?=
 =?us-ascii?Q?U/c9+Wse4xQrZ7MwYNcEdijwOA72cf6gdOm4s/fZltdHbeFThNLg+uiDPzDO?=
 =?us-ascii?Q?yiYlVA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f183ec-6e42-4d5c-09b7-08d9af04d8ee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:40.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1xlUIO2XG/5najwhuc3x3LkWkfRZl0APKIIQGCEOL7mEQ9gMHwMPbgnJSDTJCTJ727VFwEUDTTbbUROOlkji+5GTTo8qH3C4rCifOkMhgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3894
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-ORIG-GUID: oUjyGVnqnJIdUMNUkZ4oNKTEGuPd7m20
X-Proofpoint-GUID: oUjyGVnqnJIdUMNUkZ4oNKTEGuPd7m20
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
v8: Unmodified from v7
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

