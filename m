Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E8949C193
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiAZDAL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40208 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236717AbiAZDAJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:09 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMn8pm007700;
        Wed, 26 Jan 2022 02:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ebbL/MQRvBkDiQdk+IkVjNxl5ng6KXIUAY9HyAMVJPA=;
 b=djsqk6PEBF3tdhJJvLmTuwFROiA/+nlSSfS7WKom4f+5990KV4kp7yX6n50c/ufEIgDl
 7xS1ZjXQdB7t9JSNBsn+iqPrHzAaFHrF8S0FiZt8Q0ZmouSA2MNvkPHek4xDhSaoygnJ
 B4oJfx1qEKAdbDfEdgnFiTPdrKxCL91zNxks7UtNjmJEvHTGOwqDm8PsmTDwxJMT8Ex8
 3PGA6cA3+kjM33crL1EQSGKtFRqu6IInxkg4pDgyc0KS9i4FZ23s2J3rP4t9FX8Y6Oa5
 HU+aTvhuabSq2lbZMPxbcjRct5lks4sqIymPH9fLqaDJLVRx6LjgGz2moFa0QDDrG7aO zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s4x6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oSlx068380;
        Wed, 26 Jan 2022 02:59:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3drbcq7v5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+s22/4f+y3+wnmO1h91ayLc/6kqDDCqr8B8YO1j0DbC5oYBeI0Z2BfjNQLabCfBFnNMuV3Rpr99V1PsOv+03Ro+hyxEsYnB7BugqtG+27tdkotDdwwU1K1SXtuRo1AAsd2l8HCBbL00vpRfwQEBpZhuqRzSrjU79HSDkYJ3EHnyImLHPR+vDC3zVL38Cb79vLmYXd0BXL3xFASLjP8oC0sPdyPfjyKziMhmWDjnl6/A0DYMVhv02BrY6knw6dCy1Zt0ig7rwWtaUijLqK7kebN/HXHzeGjVk1nt3seIX24PCT6X+NjlBtyxbxXwWdof/aaZ8PY61iHjZyvaPgpNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebbL/MQRvBkDiQdk+IkVjNxl5ng6KXIUAY9HyAMVJPA=;
 b=d4Y6aMZfu3G3QxoEveJb6+iOYgBoQ04kNv9GwyTsIn7THk179m9ZnSd26lBlANtdLmseinFa89bygeQy/Og3eW/JvQKkVvqAG6Zg9Ng7Aqo3ysV9OmYVogbsn74RN7/rvDnGHKdYzA/1IE/R+D0hxg1kVyvO1+c20+mYtX12m4Jr+YOti3dyEVOR/c74qi/nrDb+Pp54pF89NHz/rSmA/GHXpaVLcYVJ8m7ej3RIo6A9CNAOu+75FZTx62mAeU7EVq7CjWgIgZgOWuv8W1V1MlJ6WzKwyiory1D1m9znbxFlvoJsW/2AGe3LCwv6ZnCCqplQTJLV9qEyf5YJDzdYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebbL/MQRvBkDiQdk+IkVjNxl5ng6KXIUAY9HyAMVJPA=;
 b=SK6qxf40maVRCMoy+xDbiWnwpCOgukomyP5G3dxgtrKRn8Wo3WRkvJBDpxfgqY4ymh1tWn9P0NvO1ObQtPugPqeY3VDyQsVGkL090XinLEDK8ZI17gr2S9ogtLNi/eXqbY3lcl/GexpaDFrULIvcmSTkm1JaCf25zEjVJlw9uFg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:33 +0000
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
Subject: [PATCH v10 2/8] integrity: Introduce a Linux keyring called machine
Date:   Tue, 25 Jan 2022 21:58:28 -0500
Message-Id: <20220126025834.255493-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79d61c9-f8dc-41c2-ac35-08d9e077e0e8
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46546787F32D5CFB0EAA155D87209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgeqS6gqZXjARd4pV671NAS3ydmTa0tptnzQzXiCeNqfxNHBGnE0Bz3cr4hqbBRwSmMMjqt1rhtKL87n2MLxZhgAlcDOWzEI150pLUX65mZz9zS8gnCEWNQX68Xxma53H4FTzO8DTvNYkFfbRim/S0qhnkzh0MdjIUN+3IrW6iU8TjQawUnX5gGZOPsFaiifA9c2DEAKrZdrthT7IZZfMY0oQr8lG1SU9vbhFxr+glCePLVWezMfN1ziAFfL9C93PnZp65MwT1tCcY/KLl++LUwsZB/UDxQsknrU+ESZdvwmnXleIcuf9xaoVu1eKN554j+Ubr3T4toTq9//HpyBZOAL2NZT4+CmvokxG0XwXwHGi/Zm4cIK0wr9L5HUStEgl8fIixoSN4a6erwZDCX1xocu96JKpe7KxS2yUHZcFnvkuKDYEv6G6Q1XvVkfK4Ff1GlbK5fCZbHIA1q7UlXlpWxhTTt4HPbMG9h+l5yzkjrfGOv1ZhWUAf9LlHB+hUs8GnO/TK1s2FdGsNKGB29yR1V3jLKghjXhzAj4CI8VgCIikjN5AWf58slUgOP/tiIKL+hhju48Q9xBfb5dDHRWfRFEGheOUVikUkhVKwlX8fO+cTwm5yyDGdkVVkTFR0isX/Lb1WWZzThKO7xx2CdybFNstdp/Y4FR8oon/MZNoUgnUlR6VH+KFDm9k2RGs+AEdt2+pAhqxnCalfIq38KEPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YycTbv8GI6lgWhrOCMf/f1rz4PEZv5XvF+O9DClaM4giBXGrW/SLi8qdGjT3?=
 =?us-ascii?Q?H4HJbdyfgasHOFB7ezfHIXpml1CZXM27eUezfeJ+NjTFPkxLHPXO40piaIlH?=
 =?us-ascii?Q?b2isxCCIZOjnS1ZehvLif9P2JXSg9GWOER3nRDaLeC0I/cIWWn5ySnqjMSDC?=
 =?us-ascii?Q?jeu1xsxehAl1SA++WzcnZrKmPVxTNY9vhmGfa8fS023bxW15YO+uJKzjsTKV?=
 =?us-ascii?Q?dk9MDHj8sa84hYJA6aKsV4oLjkuAvnld5RckLhI8naZkMiO032V4D6PnPfd/?=
 =?us-ascii?Q?PyDFWNQmqr7TFmiPeZPOZ2Ur3NICT+4pqK5DglvwCgBaCiiGj0NODZmCmooB?=
 =?us-ascii?Q?dPzVTXTqo35Y6/3bxyw65R/A00Prq/Bhh2kU5myfGooVHuloDIC62jVoqR4E?=
 =?us-ascii?Q?5MYw4Wbt1rtingKsqYtwPGY9mti8WlhLTij64rjsu+rfXEYpJ7QgOOlYCnDt?=
 =?us-ascii?Q?Sez5ws8Anax33HkmuM7z3iIoYLh+wapyq/bsfQocOr5D7eJ4yI6RvhTyapZN?=
 =?us-ascii?Q?+5huViLQVjYtbr3IEsHiP9D2jyhp6HZBjfblRbO9NT+4OjqmW2zCF6e4lmeU?=
 =?us-ascii?Q?leRCtz0d4McQmM0sKIQzcz7EM9+3bhnCVAkmuUYaDmq7WdJPaj6PxfZ/qJ8l?=
 =?us-ascii?Q?KNshp4xq7uhWO5Uvj2a1Fv1TkQ71tXwkVfB9hiUGH+1dSsLTQojMRmI7HjiF?=
 =?us-ascii?Q?JDNB9FauhqlfffmlS6WKYfLlBsMyoboxZh86yxCQFV/mjsVnjKGJU8R6hpSI?=
 =?us-ascii?Q?565KREQoHsurTyRHOUOdYwT3L27BO6NPd/o9+o2Yk0T4Eahd3ADdoo5HwoLW?=
 =?us-ascii?Q?lRD19xkvY8VMvmSEcvKMCbpbmEaY16UR+96lLLQ/XJDJ8wxBdMZKJbHKeD8/?=
 =?us-ascii?Q?SniSEpefGFacWrcm3DQxm0lxEwXyfWLTzpDwgLgnsNTSbSMYF3VLw7IdAYl/?=
 =?us-ascii?Q?RgLpcZ/ERa3+2Ev0VxmIDk2vfVU5Yl37iJhA5ithLSc9H8BhClwd+IdNKorf?=
 =?us-ascii?Q?1PformrXHhjg8kpLDrPT7DfjJrZVltfzVDde0cNxgxdI9onEpUFLgGjJmrnl?=
 =?us-ascii?Q?Xfrcw+Q0sGz1ySBa4m+Z6u5PIz1PK5Jzzga1sTtGcinMfl7QwJGP7Hkfa0q9?=
 =?us-ascii?Q?Io7g+cZO3nUidHRitjOKxs8Aa9nqePklyhcaqLBMd2DYjja+RpMlpZAiU69+?=
 =?us-ascii?Q?z2sCcW+YttdZqbNt5YQQRhAmxfPGw/HSetbvc/JSrw/ZCM4ilr3ONPOaWyDB?=
 =?us-ascii?Q?iRW3GzJSX0Sp7uhEicUu4H5LQNsfKXESep+GtvpE23FFr/eD9ZL3uYjDzrOp?=
 =?us-ascii?Q?1sZ0XCUIS+gz24XONsn7ByhuzEUPbC1iLnpRqtPUB699SVgpstCvhL+AFvty?=
 =?us-ascii?Q?Xm4SOKWe9B3UGzqfgA/CoCWflhLionLh7lEpgH5FN21p+O9e5aSd//w6l2Dl?=
 =?us-ascii?Q?9PbL15bA/65ih7rOuQsVeYrX4KmvdrbrCDW8AhIaQEn5kDfbYL2HITYlzNWx?=
 =?us-ascii?Q?erufkgh6mJ8DVNUwGH1IQ0HQf8QYi6y80ly9jl67LvUU0iyIhUF5OJxuKRHv?=
 =?us-ascii?Q?tYRo3s3aYGvS1nOW68SUP2+AcP+BqW7Mt+u0hYbjPtVAsF9FJTMFarR/qHa4?=
 =?us-ascii?Q?s2izUNsWnvH7Ekiy9EdP/XuSr+XC9vQ9PoJ3Y0kFcngo08/8ryo7r901t21X?=
 =?us-ascii?Q?sIw/AmrB5z1XPBvh2wRtdV/DRL0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79d61c9-f8dc-41c2-ac35-08d9e077e0e8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:33.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/7Xi11hUEXuuE4AbF1coOc6ql14jqe+5UDU/vtqb5fYfqzsYcRE4cw7R9JdY2q54Jl8s93pG9dsLDfSxbPvGz5zQSB1x2nMa7V6sa08UuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260011
X-Proofpoint-GUID: YTdw-_twPxQyHVVBBMZKhmjPPkiaMele
X-Proofpoint-ORIG-GUID: YTdw-_twPxQyHVVBBMZKhmjPPkiaMele
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Many UEFI Linux distributions boot using shim.  The UEFI shim provides
what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
Boot DB and MOK keys to validate the next step in the boot chain.  The
MOK facility can be used to import user generated keys.  These keys can
be used to sign an end-users development kernel build.  When Linux
boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
.platform keyring.

Define a new Linux keyring called machine.  This keyring shall contain just
MOK keys and not the remaining keys in the platform keyring. This new
machine keyring will be used in follow on patches.  Unlike keys in the
platform keyring, keys contained in the machine keyring will be trusted
within the kernel if the end-user has chosen to do so.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
v1: Initial version
v2: Removed destory keyring code
v3: Unmodified from v2
v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring" 
v5: Rename to machine keyring
v6: Depend on EFI in kconfig  (suggested by Mimi)
    Test to see if ".platform" keyring is configured in
      add_to_machine_keyring (suggested by Mimi)
v7: Depend on LOAD_UEFI_KEYS instead EFI for mokvar code
v8: Code unmodified from v7 added Mimi's Reviewed-by
v9: Removed Reviewed-by. Prevent IMA from being able to
     use the machine keyring since the CA restrictions
v10: Added Jarkko and Mimi's Tested-by, removed CA references.
---
 security/integrity/Kconfig                    | 13 ++++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 13 +++++-
 security/integrity/integrity.h                | 12 +++++-
 .../platform_certs/machine_keyring.c          | 42 +++++++++++++++++++
 5 files changed, 78 insertions(+), 3 deletions(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..de02964dd421 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,19 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+config INTEGRITY_MACHINE_KEYRING
+	bool "Provide a keyring to which Machine Owner Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on LOAD_UEFI_KEYS
+	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
+	help
+	 If set, provide a keyring to which Machine Owner Keys (MOK) may
+	 be added. This keyring shall contain just MOK keys.  Unlike keys
+	 in the platform keyring, keys contained in the .machine keyring will
+	 be trusted within the kernel.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..d0ffe37dc1d6 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -10,6 +10,7 @@ integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..2b7fa85613c0 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".machine",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
@@ -126,7 +127,8 @@ int __init integrity_init_keyring(const unsigned int id)
 	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW
 		| KEY_USR_READ | KEY_USR_SEARCH;
 
-	if (id == INTEGRITY_KEYRING_PLATFORM) {
+	if (id == INTEGRITY_KEYRING_PLATFORM ||
+	    id == INTEGRITY_KEYRING_MACHINE) {
 		restriction = NULL;
 		goto out;
 	}
@@ -139,7 +141,14 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
-	perm |= KEY_USR_WRITE;
+
+	/*
+	 * MOK keys can only be added through a read-only runtime services
+	 * UEFI variable during boot. No additional keys shall be allowed to
+	 * load into the machine keyring following init from userspace.
+	 */
+	if (id != INTEGRITY_KEYRING_MACHINE)
+		perm |= KEY_USR_WRITE;
 
 out:
 	return __integrity_init_keyring(id, perm, restriction);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..730771eececd 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_PLATFORM	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_MACHINE	3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
@@ -283,3 +284,12 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
+#else
+static inline void __init add_to_machine_keyring(const char *source,
+						  const void *data, size_t len)
+{
+}
+#endif
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
new file mode 100644
index 000000000000..ea2ac2f9f2b5
--- /dev/null
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Machine keyring routines.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#include "../integrity.h"
+
+static __init int machine_keyring_init(void)
+{
+	int rc;
+
+	rc = integrity_init_keyring(INTEGRITY_KEYRING_MACHINE);
+	if (rc)
+		return rc;
+
+	pr_notice("Machine keyring initialized\n");
+	return 0;
+}
+device_initcall(machine_keyring_init);
+
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_MACHINE, source, data, len, perm);
+
+	/*
+	 * Some MOKList keys may not pass the machine keyring restrictions.
+	 * If the restriction check does not pass and the platform keyring
+	 * is configured, try to add it into that keyring instead.
+	 */
+	if (rc && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
+					 data, len, perm);
+
+	if (rc)
+		pr_info("Error adding keys to machine keyring %s\n", source);
+}
-- 
2.18.4

