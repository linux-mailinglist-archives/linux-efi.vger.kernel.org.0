Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A97485C90
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiAEXvz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245577AbiAEXvG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:06 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N4xkU009805;
        Wed, 5 Jan 2022 23:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=QMEi5O3Jl5Afjymh1AR4uk3WdVIfSf7Sv5iPeWL0JkQ=;
 b=YUDQFF0pO8LsmJevMQ+lRMfcjGLk8+YtQm4l7FIodg3uykmV+phm3EVrgM0V9xRAwzu9
 MXSsyGm0yBqoOuG/eAwS4+1AeXF889GCVWMgxmocKMD8oSFtuLpbQxX2sQSzrdCJT5EW
 H90idhtdQ0uqpNM6fFH0iAUgcmlCBgkTTtLlAE5fu15MPurHTcv9qzGi6f1oeeStvVYk
 MD9UdLqWW01mFtL6GVdat2qAMPqARsyaEODDyjk/GLkqQ/clDgzjGH9CulEWUthx17ZQ
 K8JQqozzsgaJEu2eVEe06ycO0VL0KGouS4N88z7uPa+F9KLPef2Ay1y3YYAPa+kow6iC Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpp81yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjHnR177004;
        Wed, 5 Jan 2022 23:50:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by userp3020.oracle.com with ESMTP id 3ddmq5shb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwjr84a5/PlYxQ92ahUB9ilmDypAEK1XUb0JoYEKMFjs6tCvFZ3mzW9kllwBUlB2uYqOIIbF2TMKBpVSF2zv2zPeJL3OBRPk/FBktaVyw3jpUVg6IkIhi3gDDweJ2O99MXwgdJHIrnebcZIJQ0w+nkNthjxsuhUpOuZoqWrQFhS0L1U5re/jFXPd6AqUcVteMw2FcOR9iogKAmdwQ1bxmYa6cP4zt296jhAgD/eMOeM6voSLicpqi9TFO8K/W11Q2Deppp55RCwZ9i0R/OFO7vSw8lpheU5qW7Egz1Og+PW7R//uNIwKiudDkRZJv4GOgEx5oGbf2vgpu5IdET21JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMEi5O3Jl5Afjymh1AR4uk3WdVIfSf7Sv5iPeWL0JkQ=;
 b=JIRS5t6JfL7fQpNK1AryL1yJIg4BHWmI7iTXW6IALJqdVUbrpIFnFb/Cm2pgdQlYzDHdxavEhFTPr/FSwq2Efa69OyQ7059ykN5v/KZU+aIKAS75MQUNTcvCy5B20Ygo7u8VRqkdPYA9AL8QlGTC0YvHUcGDeYItIJEdWonyK6TSmAaA3hxGiqdD6tY6zzB6TMOBpb5ERecrsRjc+wNMRO4L2HS5JvV0nt/I0jjci38gAKDSd8jGS+zv8vxdY7OBA7R4MhcbDjq2lXjy4AZKzb8hD4z6nbLg0+oVsXhThWAf0dmIgK2UCmpAeEuj+5ZpIBnHyqpB1t5PpVN4Wgq9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMEi5O3Jl5Afjymh1AR4uk3WdVIfSf7Sv5iPeWL0JkQ=;
 b=hxZy+vM2gsOrmyQ2EMYQKYbhOr6qNzAcgKkTQPd1zh10cXYrahIq3c6X/NLRita2Mg7RY0Ee4Tg4W39fUrh9JdNT1wsWbgVbBX6t248ozuqkhYfo8ehmOE72aLQqBBK5tn8T8D3R75eUpmyrgVxcZ3wr9OU89oq4otICiTegLrs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:34 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:34 +0000
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
Subject: [PATCH v9 2/8] integrity: Introduce a Linux keyring called machine
Date:   Wed,  5 Jan 2022 18:50:06 -0500
Message-Id: <20220105235012.2497118-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf19a74-817c-4b4a-043b-08d9d0a62a26
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5034FD2020C8EA6DF8F8F89B874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oD7gbShQI75/HawdJXm0cZQH3zSSxO7WE+9uPz7mOwodBwrqQCcms/z7o247VVGahthhDQae8+2HhDT9bGXV0sgfVTOuxQkVm6aXEIOhjsOYHjQBXvr06QEdla2QA9Zen1tMkk1ZPYp9YfKgeDZBeJESniqacE44LnpzyCmsrF3ZE4RR7NZdrjvZ54h0FeJYocfHzXsO8hqTWjdg5v3mFNrxrydwYpuykCaL34QXOpV4ffQt7RN+Q3do93MQjYfX8VPgzp5JDkPTL3R6Dt8pqrtWeO1AYkk5SgMUniKhiDxLGahaUI7SICJ2G0H7Ym+EzRQ7Sa8xpPvIkN0kq+WwWFP3fEClcd4ozG9WqBYdA89bqAl2z207EM2s6L0LY4rnmoJKcFCmwLjIgiSN23yNdvDtBtDWNCvroN21UieCu/ZZJ7IYerl30jkt0D+OO6plW7nj49dQkO2P6KZutboIUhZ7esp7o8WruC7c4nVX7tD60N37tITcCTzEWHYkHBW0Zqmb+UgAKWA3qN/Gxk2gt92Gd3LsZFnjTg1FGtybHzZbxqwxRTNqdVYJtEfTcXGTbRakSmnMffaog8DFdHLc9DeY7UfyuSB8fVEeIAUwx82PucbiFWThZvwvqc4qzdkyuLWIe6+kyYdlJtY4ySluVQfJFzwNYAVYjGmjQFMVXX4rYao9Qs3uB6ZUht/KVVUSj2HvnVVT9Ttc3L/HaMD5PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UEcPBf8x38qO6zvTBQyKx4hjAh1yluTTTST0yh7xM/TFxVLeSOyKKNtAKaa6?=
 =?us-ascii?Q?UFtggCPSNob0mcKnYsrXl69hlloABlQYhW/2OglfsTbT8/JeDxe10XW64AHV?=
 =?us-ascii?Q?kHL1gRb9kpbVdd9RMlwNUpVpLrgbGGi/UPxkNiEkLV8+W+XE2tgyNjKif8iX?=
 =?us-ascii?Q?WufdycBjwzZWhvKiIQJeunJcmLuUv3AYPatLJ289GqZ2ExTGtYgKBfRpjqJ2?=
 =?us-ascii?Q?7H8UHmx1Z+QnLaSO0lBEgbNaO6Z+55HNy3/6E9GJB23BsQdMM5pPhNdukHpI?=
 =?us-ascii?Q?Et/GbyElNooAWF+gByQ3eJkvjLrTGAtwQOMhcEpmQQHl9gfqGcx2w17rNxNV?=
 =?us-ascii?Q?U0+OWyJFC+RY2S2fvWDc7tlHVNwdSaJLmmoVS/CNctyXkW5cPj07Jr47hKqL?=
 =?us-ascii?Q?yycIx1GLSsP00zzdJLhenlqODFD+yAF7iSGQw4sZ86uuNridgpHve1Wu6La9?=
 =?us-ascii?Q?TINet/XPoajCwCWEzDiuDWXoL9AGpB7UMPzNTc50X8Rxz1ecO/PDMZEZUgpB?=
 =?us-ascii?Q?9kvp/mAh7DFQZIIiQvPtNHpKftp7EmpCiwcbVKDb6v4r4vef5m8w+NMWSXdp?=
 =?us-ascii?Q?hvzOJ8GuhqwJtIqwWb/Fzw+Fwk30hY7KWemHGWVMAzSRs+gDxvG2oLw6cg9+?=
 =?us-ascii?Q?LQ852JhPLxNfAmWo1FreZ3OdUCiuQVxasT4wt0gJ/gNwOYQXqNh/AVMP+as1?=
 =?us-ascii?Q?+c8f6/TKzBQQm3ypWXUmtMBzPjoI5A6rXANyU1HetyUoBeQhA7u5YPnwTSXs?=
 =?us-ascii?Q?1fSXttJUgm4KqIiUjq7PkUjRZctqt0+9HlGCs5lKLssuAr7mOhzb9Bx3Secn?=
 =?us-ascii?Q?ftt/oPCOkmT8t22GOLcHW2SI70kQl1HnwLNib+bRN2cdonIjLo4RvwFVATOi?=
 =?us-ascii?Q?oa5g2gBQrWU0sa8qWscJbu6HzJIdVr0ea1GUNwkbNmu/CB3Uuy9p0pENQg7X?=
 =?us-ascii?Q?78xQkKDW8dMCIADa0nKLIc7CMbaw26AHUb3LO7ADt6Gmcf9j02WXiLnIu49G?=
 =?us-ascii?Q?TrnrsukyXqpLwoyTdXIwfxNP2uka/GWVCgweysATae3cxcv6dweuHBWeMUWs?=
 =?us-ascii?Q?BerGGfgB9ezMX5Zg0yoHxR9AVj+oD726YPfrpdxVqjecWiCWmauu1Vf4yLoX?=
 =?us-ascii?Q?4s65oXSwwQ97rsxAclOadkZ6kM26VJMRUz/5m6lm6axFFbENwJ6S2dWJ5rHu?=
 =?us-ascii?Q?UlC9r1GrNlheBie5w8OWQqhJRZUeVc+m9HLhVCileFTKGi2Tj+rg7NRVucmV?=
 =?us-ascii?Q?J1NKNWfzuqgOpIbL/iSQnweRtvq0poKVxP+ksRUeiCmtZcl3OEUDWo/deTpU?=
 =?us-ascii?Q?laeOnJnItaK8TvpBzGWTPe0UfI27p5gvo64OUlTnhF0nmOyxTzW9ZAvVlukt?=
 =?us-ascii?Q?s0RPo0Ssqdg/rrOl6gH9EifALO8CppJATw86HNMmApEmkgJw3lhbvB+m+efF?=
 =?us-ascii?Q?yLUr8QOasVNx7P4KvBa3VskZVpcCkhdY2hs0CK/q7yJ+9zCwe/AnZXolXfkT?=
 =?us-ascii?Q?SDlnrDFuMxQGSOkvU+iF/TW2jFXVpMWVy+YG6Gs1nhiue7BBey7AKi729cj7?=
 =?us-ascii?Q?807FYLPzjerxwtCUEdy72X0kokwGAHLiaf18tCuY8G0rLYUWQNnhnjZSjEJJ?=
 =?us-ascii?Q?wjXpWY4lfHXwYG7/z8Mem+hMq4Bn+w9jGgxMRgWGH+1Zqlwf7prN1EN7JW2+?=
 =?us-ascii?Q?esulcA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf19a74-817c-4b4a-043b-08d9d0a62a26
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:34.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63ExE4Lj9hxCb7pVKJOsJHORu79CMUkqGod1pGqaQlAiP92DBl8lQwDPeBrfYmyHLwK9rZA8PxP+/K7csNvQ7pSGJEmhyQY8pBGYXg5JXaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=730 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-ORIG-GUID: _G7SDdvkmCFLEdSrAsfR0wWBY89J13q0
X-Proofpoint-GUID: _G7SDdvkmCFLEdSrAsfR0wWBY89J13q0
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
     have been removed.
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
+	bool "Provide a keyring to which CA Machine Owner Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on LOAD_UEFI_KEYS
+	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
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

