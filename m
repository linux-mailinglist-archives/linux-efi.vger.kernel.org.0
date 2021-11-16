Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE0451CC5
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347812AbhKPAWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65476 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352142AbhKPAT7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:19:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNITT0029761;
        Tue, 16 Nov 2021 00:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HYVB/EkkAgybGxUM/55xpHO2D86RkkBq9cobL+8bo14=;
 b=YoNNSQlFs83Qx4BgLc2787wXK5/nZh3GAfdUd+VlGZgNRIqLi7DQnQ8Gn35TyAnXCFmM
 mamCVFNjfSSXfKQxAkMZUub4gb2eLW1lPg47XIOhEHf1Nq9CH9eU85gAqzv5HSRQZtJx
 XjZ8+8tDBUkM57agrgoxduKj1jR6B61bLZiBgZHc+y6qlXvTcbQP4VB49PeoxTDNJ1Dw
 v4QN1zC7RFcdyPQAmg2PFhi769N2FNNdGhAAZ/fM/qY/8WLJEB6NzYbUGT7SCs7WcCMC
 HoUnO/3Zg/qBeafJ5hVVP+nyqYv4d20BoXrJIshTYki/buX3I2XfTR6OI+ygLCU6eaz8 Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnp3qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0B0uH046198;
        Tue, 16 Nov 2021 00:16:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 3caq4ru9gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONcHstwjrGZwSiEw/wdCsPLVefsNtsq4CT4+alVhWtBfOuHAI3T40IcNVvYoR8StOrPFja2XrWQBZRpWu33C7d9/3oT+rhnFPivyPzMQip2kjkkmtxsmTEoLVBF2qHHjK73TqeIT3q24e+YW/RgzIRTcCBPusKujQuJPJ8cv+oyutE31JG7lB9uPi6Zwf+l8p+jQOYkPICtNlXCpuXR0QrattaZFU4/AdJS4iQ6cTsvt/wAVzC8SCY4OkF74kSRcVLCuBdxUV711hhWHDvHDwAudqviOUit7IST4tdzvctHJqnP7SihjrI/gl2tfyKCxP787VaXJL4pcSFSMlModiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYVB/EkkAgybGxUM/55xpHO2D86RkkBq9cobL+8bo14=;
 b=IrihphKWIt/eOJoCa5isvJcuwaMXNNaSCM95cDYPyxoqmcaEtG62EYgYwcim8jAr59Jx8/qY8iCHNxaOHqt84mOMUagNXYgVJY0+uBofhrmCrfHNbhbkMStLgHNxRr5IaXsAvd687o0cvz5u/VLFP8qP7zXmL1hNg9W7rSVvm/ZpiqD7Ty8nTPQg6GgZfG/Kmcm8e6ONgBKMdBGphVbPHl0IF2QHAcvaMcEP+OAsMsYZtq0mqTk4hK/wMG3wMQZLt2Qi4jP3v56ST5DRMMUpkwwXp8uuSNIma+Nl36P4SYCZDJZjO/4gLu1sfWGhnzoUs0nzSfI0q0OHq+xQcv440w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYVB/EkkAgybGxUM/55xpHO2D86RkkBq9cobL+8bo14=;
 b=laFw6l7v+PofEpfBBOWjd5NPntayu8PwJa5qnfoHLavLm18ctvm7kjazRxOxiK0OYXlzEsJMoWhMcyIYWThbDO6hWQ9Ha64uVkcQmF3m13GHIcqKKdyz/190w85IWkYi4viFwpHlLRkdjlEF5A8U73rCXKEfdqGFB8RrhROz7IA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:38 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:38 +0000
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
Subject: [PATCH v7 10/17] KEYS: add a reference to machine keyring
Date:   Mon, 15 Nov 2021 19:15:38 -0500
Message-Id: <20211116001545.2639333-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de3fdd3b-f61a-4871-a12e-08d9a8965b6a
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5276D9225AC0718DE5DB715A87999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1FOSC0P2ulYATH70bEIVQbCfQsR2qQViZvpsEn1V04QWbML2uPJUjwkjaa+dxXKTCizj29qcKYKATh8kSPbD/YNaHXWPA6s4CBL1t5/I4Mjv+NwFzba+q9ZMuMnk3QqeOk6BzCR012Gy4GbX6UZTl/A3OrHYpVyQ5Dr24Ki2mhgukAWl9QwdHUJJXLcsy0MgcNpzm5EWGH2+qLi2t9Jpz4WHK1agUlfbmW9Wbha35eUdaOfFqY1wWTd4qgywyjK6Sd3mRWKeidphSLXrPbBng8ERP0zb1yLpoTpVe73lOYS8vrRs1D1JCKBlXoRJHQhk832qpLD4wSPrmhkC/TO6uvmNbB/6qOAQtVB4526lZ/D4PAHfopafL8ldtpk+Lvt88FQfZxCP9F196O2HdVWbQIS/NVIJXq9tU4G/e6PonObVDxad51f6hp6Tk0SdxWUrNPiItkSG15P479XTrUx9dlunSiw5JHwcIK8UIxmYCf5XBhWClizO9XakfyxRpO0e9kceODf5w4G9aE8AD/WU5AAC72tuAEuPajXUtQq8/dB7Dq7CFvAYQqgeH6NBgLfKGU+2R0YDkP9dCMYgvoqm0J/v1ajF2YWBcLuzfTu45Eoj1mzejw9DwkITId7fee2ce7nMZXONjC0zU+QwoI5MxlrL49jCu/od8OP2oIP7aA0RthL5Wg/Wb3p7Q+sPEu1ceRUxwZe9A//Gnqm0/Ul1ByYLZoqCJBg89k943S6+AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCqvUn0uR9K0b2Fl4jIf3HViwCuRC7vnMXZH2w7iwB+SewNaIHgXn+DBM0Jt?=
 =?us-ascii?Q?lNH/8iPZMAHxfui8/zIAZb0xCuemu58ufgNYL8CoSnD9SsgQAPJUzi8Ys8Ne?=
 =?us-ascii?Q?qaGo2D7up05GkvQTT9ZxVglhcUfEsDRwFnIGQo6fphCxPiYUUP+23z23TQgO?=
 =?us-ascii?Q?bCJ9LgBK1QLBVdFOAxlCem6ts/NssgH0KMiqvXW6XDQZmbf2a7Q2qbPVzzo6?=
 =?us-ascii?Q?4ij+ywqvtIuJahTfCdIr/umv00DiRAO+SFXqdg2AewnqHkmiG/5LPlAk612o?=
 =?us-ascii?Q?eUT4BGrjqkeolsVfR2t5x+vHOq7m+L4rWSU93lwcpJWjmNbi0CqVal5DQgHs?=
 =?us-ascii?Q?IEdr6J/piKQEmBA/vYZscC6fvzeRYavBGcRCK+B72MiLkKDH8O6VbkPeYMAf?=
 =?us-ascii?Q?8o2D06WdDXOhvAYpoG12sCS1VnW42vGhuTD7PJS0Q81RlO1pYTQ9SE/DF93y?=
 =?us-ascii?Q?js6VZO+2GOn2JikG4Qsw3wNFlPpO8ew6nuY0Dn2n8cP3yCWjdTc9yF7U3Z+r?=
 =?us-ascii?Q?ZZ/dFstPBrj2T4Ym4aQ3JqybxQODfPbPnWVCbFgNPmIxe9yVtqcroVPnmoeF?=
 =?us-ascii?Q?2X+seRAkNAVVC5fgndNnjyxBm1MCXZ2m9gCSTxdHveAhvFeXcxQh+K758hDV?=
 =?us-ascii?Q?YcrJpU6D4+8cIquMCqogsNUtkacAPCk04cS513rWfIWfphgi8Ei9qwnAK7vx?=
 =?us-ascii?Q?a047tcAMYliE82Tl6ZJ1mKwRXW6RWNi8dKkfLYc43BXX2P7g8Ok1e63MxMRX?=
 =?us-ascii?Q?aWAOQBnJrm2fsno2vkJ1tdv+LyCd1RjI/IrsWvh9V0rjmbIKqtCWdYfly8X5?=
 =?us-ascii?Q?TX8u2W6xVFY1P7LfvoHooERP0Ebu065FtUONw7oUq1cC9UOPdsE+D89b6bhy?=
 =?us-ascii?Q?cr8R1WIOPRRRCbiBIvQaWKhFEuLi42bushZ1B0wQ48973kfctxQMnNV0MjK+?=
 =?us-ascii?Q?rLn+8ga+ZO0Yyp4bdNQBWRiPtCcpDIWpZmmWzZm2Tg2zdu0OCpw45Ip2TrwB?=
 =?us-ascii?Q?k5JI6tPAgcOgge8Eh/F2CSlIq3g9f1piECVTYLx7jKCOKbATZ422EuYZF6GS?=
 =?us-ascii?Q?bfryXokTI+Rh0oqKJhf+/fvM+FLTDolEz338xuwx10mA16hrOM7KXAYIQ6Ak?=
 =?us-ascii?Q?xMmbWzxjrp0pfRCGgDstwsVnN0VexDVWZdFSga+vr+EpK0j5NWvtwsfDAE6V?=
 =?us-ascii?Q?ZwbAp9Tw0M0k3sBJQDRDYU5YIMLZglthI9hHNaAQ8nBBTkQ5LjORONfIYwUK?=
 =?us-ascii?Q?RXqDY/8Husm2PnBk5FzbY8kySN7pnDUX4xRpY3ZWI5PMdOoRkyJ49AX4n0vM?=
 =?us-ascii?Q?dMlAx13IooqxH6sbCeF2fLVj3d5VFTvBwuczOJ+IW0xMyMjZOB48NPnGV48a?=
 =?us-ascii?Q?NTv27TF2naZ12W5dMXLXsfWvKRzyTOv7aTsQTjKZFSnKFagNwQ8S+LRbO10q?=
 =?us-ascii?Q?7bb+u82uRV8+mOC3lYBGXq708ftE8ZEL6yjkDdjuA0hAIGa2Q/vlaw1CPNw0?=
 =?us-ascii?Q?xsefxnNYYE/CHLpXJsllKbiRqu9DczXx7f6xjUElE4KQPWtXh3NiDHge2U8/?=
 =?us-ascii?Q?9OJeTg7jv3ymClBCJRO7DM2QdWhDBD+YtrFSKLtCJZHu9vwKkH2ZgyIGu9Yq?=
 =?us-ascii?Q?smx/llJyCc1DvET/tA+fryqWVJyPB2Jf5PCgBebO1iwWJOtTuKkKUd+5Zh9P?=
 =?us-ascii?Q?CJKDWg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3fdd3b-f61a-4871-a12e-08d9a8965b6a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:38.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytz49Zk6MTMraiPbmiSnLl9dndNVEphuxSITmLCgiAQ/O+0FxXmrxmueeDp5YcCpFCL6bu4ujwuLLiydQonEkJ1c39DaNjGpUWttdtRbZ4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: 99r2Qnuo7JQ3W6rqeR2tjnI5QMCAqnHA
X-Proofpoint-GUID: 99r2Qnuo7JQ3W6rqeR2tjnI5QMCAqnHA
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Expose the .machine keyring created in integrity code by adding
a reference.  This makes the machine keyring accessible for keyring
restrictions in the future.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: set_mok_trusted_keys only available when secondary is enabled
v4: Moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
v7: Unmodified from v5
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 8f1f87579819..bc7e44fc82c2 100644
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
@@ -91,6 +94,12 @@ static __init struct key_restriction *get_secondary_restriction(void)
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
-- 
2.18.4

