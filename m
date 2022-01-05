Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3357485C97
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbiAEXwE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:52:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21086 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245546AbiAEXvK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:10 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N58RZ007603;
        Wed, 5 Jan 2022 23:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=85t9lE45oZAdWhOwZN7c5wL/sqiZsyYbYkitWW+aeUA=;
 b=ZDWeV8Q2Hnra/ot4wy9w3SjWpNvRZ+SZaXiA6Lku1RQBlUOHWunBe6kfMARDIOZ1bAKX
 ojinFbjO7MBWTJ8NnOJmU1QpCK5boSHAdi4zgVYw3uictWGhdT9qJwjXnfCIhjbMchpC
 adCdi7JQcxGryuqwi4h9jggy5ssN/BLpOd3Qoqx4yQzMYMzd9rEMkKK7o+/wPVvnuRmw
 DXk7+wBLiAtPgA3nIsd6YotciFFjG64opVhDDSkVhiWlQ2FWf67Srb4T2Xco5EtgXfjf
 8Im7NEf7KUoGTDiKZiR+XzbWfqTcrvAcJ3w4MA7V39CoCINnPF3rMgE65sGACvnQOeqE wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpm0203-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjfZ6150022;
        Wed, 5 Jan 2022 23:50:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3020.oracle.com with ESMTP id 3ddmqa1jc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLft5uXKecdY2z6IXzdstBu7uwPHOM104T/yqbOh6lbZiv7K8yzINP4+ww0MBsayjdbl2SFlFHJmz0olSNP10duHdqRtp8iwqaC8IEyUErnwzX9dmYMKfjycwJmXieq3mrMm0Lbl0rl1HVGuhJ3TsvT3eccD27+You2qpO07DMk1K96pm0Srb6QVI2fieXTrWh9Lfr93IsQPbvxfvd6MNmvQ59FChPZhVhAy6S6foUK4VtgOcTCQz7Jsb2ZppDSSUvEWi33vb1EuguFscN5NU06nAO2CwxkfSc+bN1plYuEo2U+7Vg3j1PJyVDZx9wN/wXILh0WHEfhuLcQXW0tX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85t9lE45oZAdWhOwZN7c5wL/sqiZsyYbYkitWW+aeUA=;
 b=YjRRhzcVzoggVyxf3d/8liX9/MO++uv/F31Py8wfsEgZd5nUgIfJseJCoJGo2afpvPWan6pTdE/5IItdYaSogE/HAvVULRrJeNaCHB3vz/jvwvxNyehMRIk20pQa22KFG2M1gNvqAdgsP0kyWlmJiSTTT0wbjgT3GyBIlRKZqqL1vfsXHdfDxft4IOCdiqBwwqOgqybh+1pr2rRICjxvGPEtfi6dY/BOBOcfCh/d1lTqeCAS7W+8f7VP3yiBXQj+tRl18suVkE7WjYlV5STqtVtJct3ZYrViVbWLBSoB+SQE0T9Kflob4tTBEQ1UMp+kFE5jfK/rjnYmuGjdqPB4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85t9lE45oZAdWhOwZN7c5wL/sqiZsyYbYkitWW+aeUA=;
 b=oiaJPBlWa2sZEVOCEsApksxOZKrc7LktBk6GF6xGcDQGLKysjs7ITpxGr8d4xZpmk6G9n0AfSV2hZDV6hTrduXvAvr+IxDGtCPqCB8S26aYJD3TGjfWtQl1vwVQkL8tXYVvQlf8txp2YXoOl95NsRYvAeXIg5cEPrXVp3mh5ffg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:36 +0000
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
Subject: [PATCH v9 3/8] integrity: add new keyring handler for mok keys
Date:   Wed,  5 Jan 2022 18:50:07 -0500
Message-Id: <20220105235012.2497118-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903d22aa-4355-4c40-4ab6-08d9d0a62b76
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5034B52316383F9F9C3C8AEB874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RVa7+gISnrQSomBnnCWhwgZ+B9HJolyOFoQUJaAHvrvMJXVywYWJb1MC+fC70w7FHSXPl6KjXYfYYuTyyNPNqUGJbcLSesGzT176sXz3nZIeOOI1YU/KalP4YGNCJcu1RZsjoIrtXZtjo/MXK8PaPzs2C5XI+UMLyL+eTtWdBmlv+xd6AeN9TD4hF62OtmmnNuvDhdwOwMmqDfQRcTcBcj8B8MISGd5x1IHHDKUzTAeHMSBjrPK9VycF8od18tVLBVDIukBI7ETmZye1fZWel2XijGrPIC4u8NhPYEDSwMN3vWIp5P3u4shYbwd+DVQLpzuwY61cZszXdtkDsRf525qu2RjaZBVjHjrkzqLF5Eosk6pc/sGW4wAarliF1XOCpuNlHGCJEp94CwcBzdL81sIlv7ZS31ZXDBkFAqFptnpXUoNbEND9PY2T6f/xSCCBVUvOovGwf01nW3JagYgccUkJJ9UONPmt6tw3vkhZOI8YF2ViomFCI/VZwO6H7CBeb4AEeM344dagE24JbSLBSCqZFFqaaM2wCBA/4Yd3CwFo1cViVqRlHkUGYKEneGEmfVpSbONMxjzeaJgu1djM3rSPvXi7Y7wZ2ktY2OJVRUL8AYyCF6qtboZHmMrmeZOcOC+GHqzLk++SlP37o/o1TciVQhoTQ4EQEmXeavtuOqHVKBlpF/b6v7yVMgzsuGUuAHtsusmLdiIrjYVlMGY7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GByRbHJ7gjJgu0ULA5LPqdM9adGJMK7qrbcOZ+jO1Uor8oM24bEAH3VQ+7u?=
 =?us-ascii?Q?es8xHWjBqtsjWLjgNj5SbV84V0Ve9WtdlpoXQR/fX4iTDruWJ5AsycptnYVI?=
 =?us-ascii?Q?kbju4RmBxGbdH2xif51gcOLfVma1ZPItVHePAVvqZdMULFKSmlD738pr02jA?=
 =?us-ascii?Q?3RnV40tG0M7EYfxbMTnUFm6u/pWbXL9Hnfv00l/y6qigTyB6bNQ259OHxoAs?=
 =?us-ascii?Q?1GzLvyPy3tD03/EMYPTJmmjNPpWtAD2bR0jJqtei9rZhou2yyR0IGRjv4Tnd?=
 =?us-ascii?Q?EBRoKc5k8981qcCaC3HIhOjtGGDKEVaV7kHrYE86pNiceC17Yu4wqBjhEle1?=
 =?us-ascii?Q?14WXLxxsgGPqool4iK3J+SGdvfjYKB7CVv9R0U7+5mvzRdbLUk2HmOQ0mKSH?=
 =?us-ascii?Q?BsWRhWaAaRBK0AVBuJK2zcN3NdQzRCgQQGhINFHMwF/h0HojhZeT2mT6Vh1B?=
 =?us-ascii?Q?Ebb84MiWR0YAnsYmNaDnvmsWjo01kYmKqhe948ZBOnQ+ys3SDXzNmyVUkucv?=
 =?us-ascii?Q?USfgJnTkIGIxH6GIfThewA2yLPirqV8QSdnSWyUEaKqRkAxcNV/8wCLBld+0?=
 =?us-ascii?Q?W1PhVr0tz3joIko9rf/vSCG0Z4QhzEj2ZgWR1ToM+dood1ziE1wJMe5lVWkW?=
 =?us-ascii?Q?0Bb4mvLcHmNWeHH+lYUs/Ks4ZyjC3ZNi/FHivGkXY+7TOJuHD2LN5diCXWH8?=
 =?us-ascii?Q?hk3iN48BTjuFLocaISms8PFljvWdNbQcRg1BgpW3/HdVY1C7QrnvY3aBNK/I?=
 =?us-ascii?Q?Nu2xJL2p7vkQvabDp+tJQNgBcs6p2SrmS3lq1qmNsNXoNbzBzyBLymhWkYGd?=
 =?us-ascii?Q?Uo/yToU5Gs2Uo0sZJ83+OwnmqVnjOw7MQZUaRYOIRZvu/HCfgP+fHRsxZE5x?=
 =?us-ascii?Q?ztxOTU2vocvzP2OOq4VhPYbb/MRrL9LHv5XisgDK0kqDuKxX5weBSHmaqlit?=
 =?us-ascii?Q?mDWi++W8w7P/6n8llVAwDzf4yGaIB6yiOFro8OaBjvrelIWrtNCCdGrlApO3?=
 =?us-ascii?Q?rcqAqjIOcCMAnwsU6cn22BhZkDlGGkyJOzhLOVxRrLlq7QbgBPhkzF1uyujS?=
 =?us-ascii?Q?QvI4SWBUr2mgwGh3iN0d/qbT95eU938pz/FjniagrMLeIsIkof4XS2/SOXbg?=
 =?us-ascii?Q?pc6wU+tBDXGL8+karVaGRIpi27kHYpba1IQjBI7qrFpsD5GZ4Mkk/9IWARB6?=
 =?us-ascii?Q?U/pLXPixVqa0QpUpbR54G7o2eflGijDTGZSDEtx+bRonkMkPVteFl8J5uTej?=
 =?us-ascii?Q?0pXPHPNvyJ0gVB2pdHrgfZW1oBzSOXEBeslHhkEKkmBP8dxhpY7HMwV83i2r?=
 =?us-ascii?Q?g5K4aPEEJ7RK+UOqLz8rZ5gSxSBzJymcK9+QTMutEguf/8B7ieEicfHWg6YH?=
 =?us-ascii?Q?isqxI/D4Q8spKj6Th+cRVJ3iqkhKlux2iKZRXyc51BarG/1X7/vQ6pD5LN+v?=
 =?us-ascii?Q?ySCmhpL8fBcV4LfRGWQrI5sg5MxJDq07B2tSE7UOKx9UINAiuS/+ZGAtQDle?=
 =?us-ascii?Q?OJblMSAEpNT642NjMsCsfdmrnsaZlARXhtn4JCf/muVgyi0XPNF9SOR9IBEr?=
 =?us-ascii?Q?ZZnRd12hI5ApKFsvrgzJP6nioL5htN35v2oBJvJT7NMgJaUkP9+NznINbrAT?=
 =?us-ascii?Q?LRNpnooOluJ1UaUVJoapUlnNaYVAaPKr7q3RTezbKpnhbr34+YIa9lKEmwUX?=
 =?us-ascii?Q?N84FXw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903d22aa-4355-4c40-4ab6-08d9d0a62b76
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:36.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSAOTmj5RqjxGt14nwmUEWOnDBGrevngQmAVnXShAu8wER/WcXgmTcElc6QqQpB1wuPNv6fuxJK6QWC4qJ9VKcT61rbbBYTfUJ+tnIGKOyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=687 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-ORIG-GUID: i-y_TEd-lIPWUFQip77lv0sAyt_GRKHB
X-Proofpoint-GUID: i-y_TEd-lIPWUFQip77lv0sAyt_GRKHB
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
the same keyring handler (get_handler_for_db). With the addition of the
new machine keyring, the end-user may choose to trust MOK keys.

Introduce a new keyring handler specific for MOK keys.  If MOK keys are
trusted by the end-user, use the new keyring handler instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v1: Initial version
v3: Only change the keyring handler if the secondary is enabled
v4: Removed trust_moklist check
v5: Rename to machine keyring
v7: Unmodified from v5
v8: Code unmodified from v7 added Mimi's Reviewed-by
v9: Unmodified from v8
---
 .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 security/integrity/platform_certs/load_uefi.c   |  4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index e9791be98fd9..4872850d081f 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -67,7 +67,7 @@ static __init void uefi_revocation_list_x509(const char *source,
 
 /*
  * Return the appropriate handler for particular signature list types found in
- * the UEFI db and MokListRT tables.
+ * the UEFI db tables.
  */
 __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 {
@@ -76,6 +76,21 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 	return 0;
 }
 
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the MokListRT tables.
+ */
+__init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+			return add_to_machine_keyring;
+		else
+			return add_to_platform_keyring;
+	}
+	return 0;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 2462bfa08fe3..284558f30411 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -24,6 +24,11 @@ void blacklist_binary(const char *source, const void *data, size_t len);
  */
 efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types found in the mok.
+ */
+efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index f290f78c3f30..c1bfd1cd7cc3 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -94,7 +94,7 @@ static int __init load_moklist_certs(void)
 		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
 					      mokvar_entry->data,
 					      mokvar_entry->data_size,
-					      get_handler_for_db);
+					      get_handler_for_mok);
 		/* All done if that worked. */
 		if (!rc)
 			return rc;
@@ -109,7 +109,7 @@ static int __init load_moklist_certs(void)
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
 	if (mok) {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
+					      mok, moksize, get_handler_for_mok);
 		kfree(mok);
 		if (rc)
 			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
-- 
2.18.4

