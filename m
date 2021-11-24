Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2851B45B388
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhKXEpx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:45:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49410 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240961AbhKXEpr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:45:47 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO30Ehd017974;
        Wed, 24 Nov 2021 04:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=vXbaDwbvqrki0Z72mfYDTmwq72frT8KllnQcUTmkhFc=;
 b=X2ym2q0AKQK27rM/9NJXoeHRwr/Mxi8Rkeeam2/iQl6A8ReVFOwHsrp/dNG9qoNyWkuq
 EokZjbV1r6lvOs/6I6mDKu5Xg+CZTeHKyoSdN3tg2zfeHlw9qSfp6KYqsWDrL08eutrF
 HS9g1h2o7Wbn2RTFLtb1v8cwyIedBQY2ZAGLAg5KlQu3Siosy4W472r9z3ymXiSeOHcD
 +xcavygvAalraXTG2VEQjGBr4DcJrK+FJocyflhl+Yl0Uyebevv+663vlyYyqM7C2GcT
 RhF7ifBgSt90Ix5/DXBTSW+dri/2Yo8AC1ptnQrPw2TiY7t/gvC9X7NgKpE4z3yI/pGs Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg305dpdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4f4j7025303;
        Wed, 24 Nov 2021 04:42:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3020.oracle.com with ESMTP id 3ceru6ama4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAuiybgD6HcbauuFH9EYxALJtmYDALuY0oNAjrDa7uv6fbLmmiGk8lBGkONNE4HXZsA737q0TViavzJPZumgmJQajgVT3XxkE+JIo8kezsLT2Gr16xlFBUx9XbSHfGgwLqb9DvFOAT90trtJj1xskvhSHM7IEis1xo4g6Y96b3TgpcZf2YCQkmntIZQBg+9tQSncRvQgWq/JRIepGTiVyUt2ZJvzsxVD92jszaXg4p2Dcf0f2sgWyGSvSBNYtdy5bYz7k1T3olu+cpyoZ+ZlH1vT73gZ+KlM1buMgomEx3Ac5WjyNnSkyklNkovjrjbxAAzDNkwzOrA+RkwreA4mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXbaDwbvqrki0Z72mfYDTmwq72frT8KllnQcUTmkhFc=;
 b=I0I8iSzaSU8jrta84vY6CEA+kDfiFfa6hYLU0qkmeDQaOJid4ZCBmOm2hVmO/U2e8iuh2Me9iZsezyZ7cDkPNwxgApbVZITv8KrU6KUb1Ni85LHJSodiyPjZoCy6Q+30099rNYJhvsK+y+BHHo3pYEyDLHik2pJa+is0SeWgQdHJ28Laxw4KBjWEPh2Pvct8ebLHQGONsnZgQCyZPapOyMCgW+NY4orXd1GVQIFiMX1dLYDzJhZMm95NPqFVskYZ2tCSUcDyC+6hcTzko/A3BEWwKxOjPJTK53ipAXb3AkIdLnpu6B+HmlaMZRjPmIZ5QgUgp70YW2Bd3H2kBMdg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXbaDwbvqrki0Z72mfYDTmwq72frT8KllnQcUTmkhFc=;
 b=KUiBfnG2wHNkdBJz5ts8AoYtXer0hWJJ7rzzYRwaK5lSwbUNqbrqNo2bI1PXzYoI0f2Y2usahoo/f4QdLwbOCT1g1QnO75JO0LtpebeJBXCfQ7lbtXd4DTO6eU0CfQ8M04zSynWgnDmKdrtUpLxFr95xsKlZPrTKoC9dd8UGCNE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:01 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:01 +0000
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
Subject: [PATCH v8 03/17] integrity: Introduce a Linux keyring called machine
Date:   Tue, 23 Nov 2021 23:41:10 -0500
Message-Id: <20211124044124.998170-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:41:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1969bf7c-262f-4b99-3221-08d9af04c172
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB39574051ECBE1A1703C81C3287619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TYtR9OK4OBPLYLNzBLgIxP6MVsTLLe5I3cdS13YeMPaSMd25n6NqBDqtwB35u6b3k4TjPyDqqLCI4CB55pHzpYvwt9i4CQgxEHOyXPWGTzfZ+ztq8Gqq9KspflJBNvGnJw9CdcortoN7MOvGs/cmJjG87G77gpacbGuZIpEwizhqXJSA8D6hDHBTmGyBc5rjrOz+iucSrXUsbB/7Ca7dAfV+OLYZ9zahmVNgdMmFac4ch0ilA7RQ5mAUa4HnJh9xevyJ6ARUoKQDUNvU993TnIKOfZ9V4susQEzhDCnwuFOHu0uxeupwjpehYz7aGuo4eFjKdI3Y4InhHo7FAbxx3L0LjiqmZXIYBu/CxXi/QlhiGf/UCGoEnnk8bJL2y93lUmgnEkJb/YaFubXu2CWOSAQuv8Rh6XZ0rWMAanhqGEQrSBGNNz4frEeusfpy5jru0ZqsInaiLuyazXAayDJY3RNA79ROf8xJNC8h+E0NKPSnjE2wNCrMD5FyUFMkvaGm2WFx9qniLJpR5oLrZzw/ff5eS1boXgs0+vs5B2Jobimtgoaw3+6vTGJ86lKXiRBUU+HQgO9bDG9Ud2ej5WyEYhBRWq4Jks24dIME1BKPu3Hi4k1dV7KaH4s+cIUiFPe1zcc/OkEXOth1qJmBC0fqj8nJr8JWX8EssyiimZezqn73Yeemo7LamAw/Z6+I1QwGwXMyG9qOz7UWZrnQxlJ1+NrL7z8HimdxOkFxhAKa6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FanqufMJdOGC4dbtniej58hqB8dYkJ09WOjsaBiT+5fwulCJn9S/TeZ7v6Bh?=
 =?us-ascii?Q?N16QrvvTAFLH4IevajSbMTuLVilg6lPZpEjd7rdsgaKzJwaUDuE1aW+Wvoeo?=
 =?us-ascii?Q?/6GOKWWWpQmRBuOwHC5zBu6iqqcJZbvAiZzkjGGzlfsuDkemST0yrFWAVBXM?=
 =?us-ascii?Q?J0U8CzZmpvi5efgdo5UWut3Xfha9AfhmWvgfR5xD3YJPdeOnaEfr9oXlQzU2?=
 =?us-ascii?Q?l4UyFCAobaoCAIw7o5Z4cD4540FoEWA4zd+UqIPnJyiLLpG8FkIJGf99VJ5s?=
 =?us-ascii?Q?aj19Rn3eCR+r9WEdOy3yYUl4zLXQwwXOrie060gTPjXznMMskIVWUu6fxLVl?=
 =?us-ascii?Q?RBbG7Hg2LQ9RjYzBIj0kRkQpzQ19Xwm/jpSgympSZAXFdRzN8j+Keg0eDCwj?=
 =?us-ascii?Q?X3M71DLvMwaU+7in2EAZ8q3sUZIXZ8Wb8ucye/Lt5Fv2GFzM0ucZzTHT2nL8?=
 =?us-ascii?Q?k2WIid8AzNfAL4R2a4VcR5s9vIwgd53sP0yeo0E88BYt8UqFewgFz91adxN5?=
 =?us-ascii?Q?8pm4f2JdJkehHMMSdqKXGJ67GR/pVkQ3XtZoL1sYqSn1tLkC3qgd53PiQBAS?=
 =?us-ascii?Q?14OI24mBWqRLWH9teMgXo2clEG5unPrcbsqkEUzmrFchyF3JasjYHIjzH0A3?=
 =?us-ascii?Q?ALCoqCHhABjGWBPpkj65OiRr2rD0vOH2KR2BtfEWCCtfoNsgEVD0quOHjROJ?=
 =?us-ascii?Q?cLau9GcoC+ZiIUNGwaeexvjssB57QjlTjwk/5w11TOGbQaFWGqnNOCRz4tUj?=
 =?us-ascii?Q?+W6zNziQPxP50szMsTLyY7UP++NlhkEY4En0YkkGdlnCrO7EUX/beknHpO0j?=
 =?us-ascii?Q?I0GW9vQGO1kdE5Lf5L0jYTc0OscVFAh54rII8JxV/kycIQjsx4EkpV4eRwmh?=
 =?us-ascii?Q?awZPNVZqV3TdVRtDnMiSVPrHAk41TDEZXlHEVcY9qla/VOhWCRvqZ8zvQdtq?=
 =?us-ascii?Q?WTGP3IHRVyfiw2iUKuqadDBLzxexHCaqXc73whdydQdwyiaWpRCKepc0aNt+?=
 =?us-ascii?Q?FtFXBtV4NitaB6PPCoBBaAOn+1dlIYAAoxBvJnxn3giVMR+FnAESl3zYDVMQ?=
 =?us-ascii?Q?wfe03aV3LzoO9+t0vrj2ikfWP7Y3BmXdxl+H0amh3marF0c+QAWHnZv4Klb7?=
 =?us-ascii?Q?lLMxQa+TncwDuMr1KO+O5seinoD3D53nB81TIyVBS74BFw1bgnfwzIpKk3W0?=
 =?us-ascii?Q?c8a6ai+KY5QU4Y7jkH8GVU3PhOPhBp5qWmwhIs80G8ssHqxBm1TzCb0Z67WP?=
 =?us-ascii?Q?W6g+4b5u4m0CTfQJxAk6vtBpUcUWVbiPLCVba6AeHUtcLypDFbbQwQPZKYGs?=
 =?us-ascii?Q?frploy53eQg3VkQDD2kDwyF9VmRR67aXkvTfwLk5IxIL4Qqlw6wCz5ajzD3u?=
 =?us-ascii?Q?TIIwkLg4tF2q3cfJaOyY6Rs3LMxzq8JKnVXj50iF4kCNTpGYarw2jLU3gpNV?=
 =?us-ascii?Q?VAmcQ0mMZH6oKHW+vWn8Ai5kBs/GGV57B/461LIFhgVcAjm3/2mwv6lU9jZN?=
 =?us-ascii?Q?KaW2bIrVMRcrXhyhKj0taN6qYIwN6wkrUBQQEAp1PJA6rWJqqVpCeN9s2Xn/?=
 =?us-ascii?Q?RND811bnysXeit2SGw2V2XliJVSPKFv/lDBJjHhn4bijqDNUm4EQe53TbRKh?=
 =?us-ascii?Q?dUi26WjDLxjZ/BNO14dnJYx/gQWtPR7buFXm8Zw9A7CHGjsgYjo11iVOGHuO?=
 =?us-ascii?Q?Nih/wA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1969bf7c-262f-4b99-3221-08d9af04c172
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:01.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/8mRqaJXAWon9195HeB1V8otn37+1ONT+FUQi2o3ssa3hzEoKSZ5xZRTkFXXtnyNReUsk/PIeb8/VOsculG3OVgm5V1o+pKbWgpRez9WjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: b4ZcVZQM4ZCYITciLdS2XokJsefzwCcC
X-Proofpoint-ORIG-GUID: b4ZcVZQM4ZCYITciLdS2XokJsefzwCcC
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
MOK CA keys and not the remaining keys in the platform keyring. This new
machine keyring will be used in follow on patches.  Unlike keys in the
platform keyring, keys contained in the machine keyring will be trusted
within the kernel if the end-user has chosen to do so.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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
---
 security/integrity/Kconfig                    | 12 ++++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   |  1 +
 security/integrity/integrity.h                | 12 +++++-
 .../platform_certs/machine_keyring.c          | 42 +++++++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..12879dec251d 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,18 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+config INTEGRITY_MACHINE_KEYRING
+	bool "Provide a keyring to which CA Machine Owner Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on LOAD_UEFI_KEYS
+	help
+	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
+	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
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
index 3b06a01bd0fd..8c315be8ad99 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".machine",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
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

