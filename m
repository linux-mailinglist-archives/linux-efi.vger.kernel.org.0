Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59760451CA7
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhKPAWF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5892 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352635AbhKPAUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:01 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNNR8x007673;
        Tue, 16 Nov 2021 00:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=DpFCJng1SZ7t9XjR+uU6XhXYX+8jCkgECtnfcJNwenQ=;
 b=RX9JgbnqdfGAi4crKxQvxVbp/PoptXQA9l4onc40eUC1WlmUyGzxu5sv3Mjl8DygIb/6
 2A0MTAYZGEHXrdl9s9WN6ufcwDZXXQ21G430yr7KP3dc2AJ5RH5OGHpmeN2dL7/OPNKn
 CofQ1P7I2jw0gDjYBraX3A3QPRxkLGinKcsXtbebmqLOF3olNJ37TscWr0++iJqyIH99
 tAAeiAVWF1FlhImyg3HebccfIkG27GSwdMN974oBgu2yawAGa+92MeFRgnqr/luuciEA
 OriMa0qB4gkhO+BJiKevsORGe5RSCosMkNnYt8lK/SljRgHIFuYOiELxwQCRz4iTWpPV 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv561aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AApH136120;
        Tue, 16 Nov 2021 00:16:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by userp3030.oracle.com with ESMTP id 3ca2fvcgu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gcnk5ar0S4fIVj0tiC//bgAyCczRvkaWY4uffIQ/MBevqxqeqV1dnCOoR2dTSRNQgqk4mMdxbNTcVFxkEczLwFcvO6jy3latYisk8cF3o84upGodTVcsQfS4qSmpGIpi+Vp25YiXDZAAhf+V7ZJyXgY0wjv58nq/2uKtdFfNRw/OwKjkb+FnU4UL4VezRFHQWZtXRHdOwh/LxyiC0BpZ12Vkm9yJNW/CeGW3xh0DOsXOq6QzXOTmDnO/Xb+9AW+nxVpfg6TCKXhmYMeLrk7yNRBz8itIVqTHEzywxLcJXUZDBTqNSo81Z5GuR4DUwsw0NHrqNIHMRMmgPeRmP+vfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpFCJng1SZ7t9XjR+uU6XhXYX+8jCkgECtnfcJNwenQ=;
 b=O0l+fgf9g21PAtMZ3StJTKuqO33DYrxNt58CGKTjlUOmXruky94DMR2J58+tZ0Z30JQUK+V80MHwHkZaEiCJmZgToVGsCZk77YEGFz2vzdZCf2Jg9CP6e9v1eFOti4enf1FKSXyNWmlBc2d1Wv0LHyPtGZRrVZ5tdeM20jawiajTSF3w/PUa5AQ+heWXZTJGdMXYy/QONTAxvi3VO97yiXDu56HqBVcsydh4y49U+nhCdugzC6I+T5PWoiXMePEXmvq0PYelvKgECLM7Y8AMRfuI4I6E2Go2e7K4oUbH0tGfY4qjxnI17yL9nZhm8xK3qpY1GH1kmQ9iFTOpSw4a8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpFCJng1SZ7t9XjR+uU6XhXYX+8jCkgECtnfcJNwenQ=;
 b=L+E3JCiTgkjopB/cIiI+jn0JOa482I58esoRGBb0ejlBvfnBXspUjZsypM7MWmGczzr35ACIhxuItRiEA8X7DovIUh7kYUxrPtcQjKP6mtZQxmacokmVENkGS2jeJzdkjJiFdg+Ghe1UbqLq4vRrFSUH9IE8Hf6rtqpwlfNGwW8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:43 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:43 +0000
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
Subject: [PATCH v7 12/17] KEYS: integrity: change link restriction to trust the machine keyring
Date:   Mon, 15 Nov 2021 19:15:40 -0500
Message-Id: <20211116001545.2639333-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3843636-d09b-4169-58dd-08d9a8965e96
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5276D3FEA5F9B7FB8CE697B087999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63+F7UcJy4sFof9qocF3sMSgFZ2A/7spsYllmwOnpR2C2pNab511FwsKgnrMwSooxIou6DvLSlhbCCdVDm7YNsfam8mU5iV3zGkgJom7EOFGreGUPXGBvSclRqFN1/kSEDAmyDw42ANFvMIoPy1QhV0dSDtbDuZv3kET6B6ixip1eSIXE1vL8R5Y+H5tvjE4RLs4gy078lu3VTozz484W6qRcAhadNUTYySf5QG1GdZ2YmSD1ddgswcu3xRVaXkAgV7mpy325ZwyWf//0+0StS6HnoD4kvYcwepAGCgdgtNN5K8jeO/y4THMEi37mHCF3KuIN9NvJzQiUQ9mNfiCOtLgLKgtuy3+rDSWsJW6TybvrlLTrERd1daiibwZurnrJ+CTdYKL8VEKZhgq6nJ1CSZdTscn16M2+GDmav+yPveD1kiL7rvJzxiF5vrrAX4HSjeKmBJFeYZw2dGIh0Lvzc95u6Xbt5lOEsMDIuh3TQcgPg3ROxE+EQnhtp97O0x1oBdrQng1j1Kesl4u1fnrJNtv+dYz7Unq9hOPZ7kIuF9vej6C6ieQgKN1+J9FXE7w5g/meS5JFIs6oQBopQme8fW29A8GDTui075hMuEHyLBuH9bhWDxzcj3PLb5f8a66eX5HUmVLl9jOiu/4j8gk6nbRQjpHsSjNqoPTxq92GKS/Mq1FE8Uvyah4TznVcx2DJMnieC3podF6BC7jpV5ThYrk5IIe5l2UybwGO28egKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4yhO7rEzPGq7WfKkdixUMVGbA99ZNP07LJmqs1R5JyQMG9BdboSukJ5M5GQ?=
 =?us-ascii?Q?Qcaz0Atlb9nyFKBQoa1tvIwabHJ+ucMKGEe3oeCeHnNZTNwgvznO1VJKVNly?=
 =?us-ascii?Q?zyTEkEEbLziioyJ1z66UB+kc8EqcUyotILLXjwSSL7zsdR/rMJEiAob5JcVl?=
 =?us-ascii?Q?lgIBlSW27y/6URWgzviRLLogaDQj+yYLWoKtxYIGOii00CivA/GS1q04GTz4?=
 =?us-ascii?Q?vuqVJB7FWmbKI0q4yCidPdl7nG5k8qrLbmCvVFMxJporsTBu9Gi6R9traV/4?=
 =?us-ascii?Q?CJtIWrBxNx24yLbKF4BlNF7MJ5fVxk4PSEWO7LU9myZ5wWEZT8dq2cRPyzwA?=
 =?us-ascii?Q?HkcDvCOgNRAnz6z0NoVG3nONgoQ3JILVZbvV7MsTnxHD2zyzb6+iC8bo5yyM?=
 =?us-ascii?Q?4+btY63dYUO3M1tNXk/V8om9Mum6xFNBvdmy+Gr3q1XQuoWIhUIykHfhr3MA?=
 =?us-ascii?Q?fIz1+WmVYcl2f38DOD8SyKwY+wIMmmEyZhzpSxQuwnD+l73zpLWiXWP6JSib?=
 =?us-ascii?Q?NilE0uYcJKHUuJtw9Nxa0D9ZOruwkXx9RTfetksN21BsQzVkhSHIXHFN3dgN?=
 =?us-ascii?Q?Cd6DvT4Qx+MfDclln+ELYAbWQmEaEYu0Vxy2LMEsgFjqLvmdCgEtkti1lzDR?=
 =?us-ascii?Q?wdhBe82Ucdz4JSLD2tQjUIPoQGeG5sqFqthHvTHyz8oy3JlTggqgp9+UzOz/?=
 =?us-ascii?Q?7kx2tRJGurmcHBB/VcLOfLTGsUZpXLuWc/TDQGFyugWCXfke/92PUpeVdNxP?=
 =?us-ascii?Q?wjG5HHqyapOc+zYZxKv/vrQgkFEZvJhn3XEZUUi2mrR2g6ezBj9cLhdHYsFs?=
 =?us-ascii?Q?Msi1+g6t0ms0PaG0hXgws3KZpWnq6G+lREIvpIMtHf6Gq5o0Cq0kgdKaYPoj?=
 =?us-ascii?Q?ZjStU9TtqYXstoGZ6iPk5aH6P5C8ZddxTPlmsG2gHI1VmLjBCYVGS4xBydE5?=
 =?us-ascii?Q?ytaXPPPBvJasIESsfOio7yvk6xPQ7TfxMA6MxWtocwa3u4SHeHCR82y9rq3k?=
 =?us-ascii?Q?f3jyRVeuXKiXnBp3DHK3qs4vOqq2wZ9Sf/pPFDEz58tRt5di9xKyCaCVEDQY?=
 =?us-ascii?Q?HetW+b0vNZKH7mTUqIHtscQ4fBMi3QPI3XAJf1TyjmZm6ccN8fXArnD6iHwO?=
 =?us-ascii?Q?KJBKzyE8d6BVstT123Wto6k9nF8wRUddwVMA6FnO4VhqxEeIDITHoYBAZ0+A?=
 =?us-ascii?Q?rY9XMc8xbMLBqpS1/JY7n0Fz8YmvpSHszYmsUJu2tP/irIZ4CWQvWoql6VZU?=
 =?us-ascii?Q?vHtWk4emuRs5vlhqiZRqdFU31iYjWSi9ifkxk/9OyCxes8Qw2EmqUzQIxI5R?=
 =?us-ascii?Q?fx4+VsTowsFOgpXrwQsKBec2u/d9v1Q6cbl1FljV8q1TGps3R8l0vZHTzjfX?=
 =?us-ascii?Q?hhXdpiaSeeLVyTBlibs0XTrVbPqtes1opVS7EPfmfKoLaOkxC60ju1KX144j?=
 =?us-ascii?Q?h8Jv7QRqNMCE6l9/OokAi+P7Y4nxZcUV5RqGcwy6dstG3QlKn4iCR0eGCRbx?=
 =?us-ascii?Q?2n+XZdjAcWDqgRjirPSXjsxCsnnZJe8+Bb2CDybCBkp7o0aU9MBg6nJz5/F1?=
 =?us-ascii?Q?1YHfcycC95jpCx0DYY7WGT7Jmswm+jC+qlGo4nX1PqM+gqEKrH3PXvGLNC5O?=
 =?us-ascii?Q?iIaX6ptdcNJJdzegoptqWIhkrNTS/ADz7FZEVBOa9Til1/bTBzX6BlgF/TaM?=
 =?us-ascii?Q?54dqlg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3843636-d09b-4169-58dd-08d9a8965e96
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:43.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDvdWQT1WTEVdSkvaEc0zEa7dysYHWI6vBlzYlioxo19mxQXptkOl4loQSuN8DhRH86qAQx46oWH+ycchQVcdTrELnTCb2O967Z3l12oRc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: y38LPB-CWhK8OmHNpSkzKah73e7ynMiu
X-Proofpoint-GUID: y38LPB-CWhK8OmHNpSkzKah73e7ynMiu
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
---
v4: Initial version (consolidated two previous patches)
v5: Rename to machine keyring
v6: Account for restriction being renamed earlier
v7: Unmodified from v6
---
 certs/system_keyring.c      | 5 ++++-
 security/integrity/digsig.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 71a00add9805..ba732856ebd0 100644
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

