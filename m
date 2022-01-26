Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8286F49C1A2
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiAZDAP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43614 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236741AbiAZDAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:10 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMmudU004068;
        Wed, 26 Jan 2022 02:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=H+8l6AxwN9VVcjTjbSVhZ0qL7eAFSgSLcKDCpWgNk7k=;
 b=mosQpZs2VMLzmtKpUO0PZXv6Ko2ihYhjmSd68bfrF+s4cL3PpUw3KVy9ZnTatXjrX2nl
 +3ivxOFV9cdBV0f8XegUjwSg2S/olnRXkQEOAy/mDgOxiGOz2JsY3Fa/7LFM2qUZBRyf
 7kjKquSpe/QF5UWhZ0DQqVpdw20+tcsnkkCB/2TriSHHVDid0z93OdJe0bsnjHR3MZkQ
 3UbEVYWsXg7i5wmjH3faW2zbd+0pJxpAsKH+Nh7Gdgxo5G+XP8PZkmwFxJ0T0LXRvBhc
 rcLnz9PP4YgFuZJgBLvzyK4P2+jac0i4FjJrwYC3SsHP30BirahRkhNja3GkOZ+l90Op FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaad0y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oSsx068412;
        Wed, 26 Jan 2022 02:59:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by userp3020.oracle.com with ESMTP id 3drbcq7v9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeYz412b95kenbbYhabDsg7g91gH/2vDBYngahcLpEwx48PeSGucJ+EwHxZm48FkOEP9LaH7g7+AgkQFP9WUFKRLEa0WAOdPANbLkSJGx+L2GCQJlvx3LNrWfn3bXDM0fjq8UaNG3LBj08LnUibI5g2HaYpQEbM79SkMxc6CDSJ/Z/IFH6IEsyJoHZHRKQUBNsYF2jcw+8S64yiX5j8BtfNxTnn+RC6BnZSPexZXfrta7RkWka2hhzI+UsMvCXlq3c8SISK+izJaMRvXCYYaMQpoQG2FISFddhwHqu6UairSnSLGBgBzMDwdwS9yz3ZVo+gqVTRTCzaSStnLNHXEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+8l6AxwN9VVcjTjbSVhZ0qL7eAFSgSLcKDCpWgNk7k=;
 b=hIi/DtB3FT5S/zDANw7YqjEgwsmWyIjJOAt6pOwz4QwTpmgBRi109gvyUwhm7q1/3ZIpIKcyK44Z8IdA4QMk1ePfuuWdVOPRTjnR4yoP0vlLPXnBxVRVy7jgeB0l/Jjx8NoDCEsk97abesVs+HEQh8AUcdAzFdl/361i2ye9oPnnPnKUAqSlbkPgEfeImnve3iUQIA+7eG5jyKxl5OeDjhH7Jvnmvs6GQJuJX7KHzqel9LrVn4kkHM6IFn4iu7rq8DLyj0nGiBP1W7CSNYbTeuRq14ROych/cBg2++0bQ4ZVt73bi9gzWsWfJcX49/JoZz77IePYgu64BXlHZj+RGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+8l6AxwN9VVcjTjbSVhZ0qL7eAFSgSLcKDCpWgNk7k=;
 b=navtGca7Re8kRbHw6PxiPZ5FTohM6cRSHZKk/T2AgadpxpE9jYnVDh7n/ZjL1QfPa51SExv2xrM1dFy8QJAUDXgzhKLhnwT7JUUwYgL7RKy5m6NWZFoSwEZ+4jVV/XVcX1lt3XdnYBSdiv5GP91092teXjgmEtP3wMuuRBgUQjw=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:43 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:43 +0000
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
Subject: [PATCH v10 7/8] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Tue, 25 Jan 2022 21:58:33 -0500
Message-Id: <20220126025834.255493-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a13ff737-526d-42db-80dd-08d9e077e715
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4654B0D5D7A4019C6FA06E2E87209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpACXYjqad4Kp7fJniDBEE6j0FiWdfzJbsrY65jQTjLZTmv0DJ1EnmsgDO+rp5OeYgiW+JFy3rBOhbmLRnH6kAJkFHunTWP5wePZ9xzsSClrgsrJQZM4zUWLU79qyQzQfTzlI5kcSpjcV4vHS7+TEGPDtjbiGzHIcIve0kuyHFIA5J95beIJv4WRw6Z+faWhQ+WmNS9WPz3EHC0iYJF8NxrEf+kPjJ+zdA7s53DxjRVNMweybUBjj3wZ/zafLSmEwnEt7QcYfSkQtt1V2Z+x7qZyo2lJoLvQXVlyqiZrPvfmvxOrCYvG7MxfEF8VyMq63yU2h4eFRUdcy+6+vj8TBajp4XZKyjYsPyEvRyhDONUCMVqaaI7Q/tcPgOLlMyhFBKecHA9Wp6mOCor/nnxg63MpU0PC5zDelY1c6oekbNdRuDRke4Kr9BPaOwS8BuH4C3I2AbRNclg6c3X52F6oLWPPBEAWbmflJN8sIMrdT0DfSfb/PV/US8bHD2KRLvEm7NyvTwl+g3fPxWmzeI1Q3YiJVpA19tgGoIxfiumLcguCLlyzPYE8VKA5ouHFQCF/vNFZmzO93HRHDw6AcEbdJiLKUQ/1a6KYwsz6bJFyzYjlEsZAOfH6W90uvwpBYgagFglo7SmXskOMHCn49UHCdS1UFNtuuedpPLqU6iwxLqOodX2U0LUZYTaw1KJwzTLjOynbsSthpuE9pnJAOHb1Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TGbSMnHPPJfAgqpCNctSRHkemqXhBkCjxvbSrH57+wzU2y4fthxoHukXdwW?=
 =?us-ascii?Q?D9+Fbm7lhwJV49gsfhgKeXJA7+89dxMYIJ7hrnBbs9mTmmm6W9s997JiS0R+?=
 =?us-ascii?Q?+YoJwrioMEwCr02F0CNL7zg48Tqk5bXPLN7+QX5TYX3AdZF75y516zxcrYHj?=
 =?us-ascii?Q?Kr8bs2Pa3/4THQTRUcdKskv9MzXI5QqLo1d0FDQ2kMsUZs7pPRIssGy4+5oa?=
 =?us-ascii?Q?sO9ad9qot3hJuwiIFbY+FWeEEN27rZLcVXKPZ50HxnyHZnD4JIuu04VDUg6N?=
 =?us-ascii?Q?1ziEfR8f/pxqWB3HXDmQkweEjsNtCdgFYHJ0JlhaLw0jkM9MKbk1aq2wYz18?=
 =?us-ascii?Q?86wMQH7T02HJbEGBTq0AUriA0uz3nbp8RXfexvCG4WVeSwlB5qoe29PMNQXF?=
 =?us-ascii?Q?kIG+4O2fuEf51GPqAIG+IXdMl8Lb010EeHk5b3WYxO5UDc9nvi77v8H7HP9S?=
 =?us-ascii?Q?g7ePx3kYnNp2IABiGVc/yJwpoJq5oRRpiEFN08xPSrGhjBiA/npT4w3YNio8?=
 =?us-ascii?Q?OpjxexQUDMHcJl/Fd+Nkrj/g0i3o5kWUeghAh4llgO1UhEqOLidu6KvU4q+G?=
 =?us-ascii?Q?xV/jqw/ouqYbkDrM68OU7wtkyDmpzJpIOSvomGypgxi2zHFgp38u8gLV1giS?=
 =?us-ascii?Q?VaJe6IGZ35JMgmIPoZs5klKtmLIuatREGJQ6rJia3C/Wav7M7Bmgrj+a1a7l?=
 =?us-ascii?Q?AP/9IZoewQinERJ/5eld9tPTiywZlwvcdPYemJ7sA5whf27Lyxtj+IDdYRps?=
 =?us-ascii?Q?ssxeopmwBvvJI2ygp8UeBhrVHNocQT4OKKokT6hFsKbhCyjj/CUQUm17wIoX?=
 =?us-ascii?Q?OTH5a3uwaO/HIUNg15ER3XEx2pbstFReF++jzYOwWNr9omzLwOfQtgSA1sxv?=
 =?us-ascii?Q?Jc5Np7mAiPygWbs6KSqi4xjCFjnnu4Ry2bFa0j+aoA+t/s1kTV57b65ijDHE?=
 =?us-ascii?Q?B5apUWpwRiRsAQ1iHqfHXQfpSjWY5G2IKMZAI/qtgGtA0HRvQ1F1Q1BTt8X+?=
 =?us-ascii?Q?QZ16hKxB6PKX9KyvYU66xI5JZYTzH68C14vyhbQnKypvv8rdhhzVyjJlK7JB?=
 =?us-ascii?Q?ntOhzWb2blAePOn2NlknIgPPE2bwWOqp5QFrJjkZcazTR6rr2RAATUy3VYw1?=
 =?us-ascii?Q?B4qi2wfYnF5wsa8vOYAjwoiqf8WO47a3sn2H2iexSnLLbYXJVVfu32wqD80w?=
 =?us-ascii?Q?fNmSo4gBDWKNW7VNdFGylpto0J/hRRAnh4LZEcivEsYxYaSu14bwZ4NqB+wS?=
 =?us-ascii?Q?MJOogmMboBuUMjB7t1JLupEGOrq5GKCHp2JegTU4tqaM35goUUarrkguCiDl?=
 =?us-ascii?Q?GONsi12dxYbECGKtjQyaS3z3ghcxQs8Ue3mLKULi5K+Oo7VJjp8T1WGBwqO4?=
 =?us-ascii?Q?pHJ8Al1bFWcaZiyAtLuPyPsnjzBgOeho2dyKjcCTECy46VhWlsx0s7txqR8X?=
 =?us-ascii?Q?IcJIQ1+Pz30lOw3684QtxXtcwmYPXIjVP+a8HjBjFRcLIgCA3JE31/JLH+GA?=
 =?us-ascii?Q?lZRTocVozBIVkNjZJUrhwrY1zbBpEBgUGz1EVM2nmtX8Oy6c4ApX2xRm/TGs?=
 =?us-ascii?Q?ZCrgV29QaeDZi1XB89r7c0ueTz+PL2GLydqPZwFlL5krkT15Q0jsJ0g5vVpx?=
 =?us-ascii?Q?AYX+33WNdy3nFCIQqiyNTbijbnkWxmWp6lU9xq8jitn+o7/BVgwrnHbaN14F?=
 =?us-ascii?Q?MMD3c91F+o2m/KQxB4VUlNPvwno=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13ff737-526d-42db-80dd-08d9e077e715
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:43.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPKdQzJ5IPWgXtY5Gwj3PgqLMNyQFZ1HqYLc6SXXisFecnYaj7HHT0a14yo92K8UeuSlZ0/gHqZc53kAx8kYpueRXJJ+dvnUfhlOPDZwRbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260011
X-Proofpoint-GUID: g8PBvEq1UPo_pR_QWJmLNHZ1fw719aWo
X-Proofpoint-ORIG-GUID: g8PBvEq1UPo_pR_QWJmLNHZ1fw719aWo
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1: Initial version
v2: Removed mok_keyring_trust_setup function
v4: Unmodified from v2
v5: Rename to machine keyring
v6: Unmodified from v5
v7: Use mokvar table instead of EFI var (suggested by Peter Jones)
v9: Unmodified from v7
v10: Added Jarkko's Reviewed-by
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

