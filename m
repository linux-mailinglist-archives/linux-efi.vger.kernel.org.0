Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6445B33B
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbhKXEpr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:45:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47262 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240532AbhKXEpp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:45:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4RqBk029976;
        Wed, 24 Nov 2021 04:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rl09tLZmrDubEtA1E/PjCH1B2Vwg0EodjnyFR/cKoBE=;
 b=wEe1Cr7ZPxfasSU6IwhsVVWOgGcv1t7Rc+CpQt89nwfu19/RR8i9sdH7Zs4ExABV822W
 Z14xmKV5TXEVQTnvOgrwN1etu6/zQsL/wtl+xsLWVsfbS2DPdDZ4Oe+/mVKCHPGP2Tsu
 ncRuIhtAl3FqOsyXxtylgayW4ywkoHEWtcoBwz//EVADsvK0S+TGZVSD59xkuGJug4Wt
 FN3PR2swpMJJI5Gv+cDnnObgr2icRRk7EqUDv87i+bqLZHP+o8BTEalyvC8L1o1oLu7j
 ZEa6SmWJAIAeFP1voC1o6sLTtGmfj7bVzeNzjguv75vPvyo+VR8pgtZ0NT+nj4veMRlr CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55g76qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4f4T8025298;
        Wed, 24 Nov 2021 04:42:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3ceru6amew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZquMxMQY/pPyAau2m3PScV6PSXCIQb3CHOL5qJETp3gXnzEphUFCkWvX3JU8ZN4E1E/lzKqMXQwgEhF3m6rz8olhCrBDz4/SGJee1xqms2bpZQEtKxmgqb4vr80tFwjt88jUo2SSGhDl+q6tymIo8w10JP3m3xiG/GOeJ42Ef9svE3sj5ncZAjy91unLnB+N6Slly7v3RrAuocAeTeqQb0aUaejZDve0IlDm4oTReNQCi5IZ0MdTKomgJwbhgjLM+xaMLuBW4R3WiY4UgTtZ2Hl3jkJU3Kbk0oxyfzvKIMqs1KyyTX5zf8XkzfShrWKgDXFwNKi16kXLnFwvItEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl09tLZmrDubEtA1E/PjCH1B2Vwg0EodjnyFR/cKoBE=;
 b=OAJueotFEOG1a1kAoNKqKVq7QwlK00blTleZvF5IFir0lNgJu8382MZ1lkAis0gfFrQhzxkZdBgNUYowpPxmZvWD3tdbHb9Tge3F5pQ6fzNj48t2ms8xZe5C08J2/iLxNYVToZvAjVsSX8288NV/i4XjGZRpNSWxAtXJ/5ddiuD1i/43smij4+/WrVt0RSVvPAlBOucj7corTuzW+Tj+uoylYHlV0Z2m88aTN9Yl+xLFBWxGiqsMi1TwMzubKrrVOCfj0j4Qi9tdWFKmkhSSvbJJnrLdECdCpMOwD8ov5L0534k1duY/0no0m+aHugt5Ejdw2+3Emb6jTd729mwbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl09tLZmrDubEtA1E/PjCH1B2Vwg0EodjnyFR/cKoBE=;
 b=W8fPf+ERuZ5/l6D6iA9XrDwbPY+RI3oviCzzbLdSGe40kFnErYxqlK+p+Cur7E9N281K14uS0Eq/uMXv9LDC/vIzciEV1Iqi9o13pM4rMyGEYV/a8Lw7I2P1ntnDS9f6masDzxMhMZdqXH+NC7X00qqfWbyA4psbFZif+KjBIXE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:13 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:13 +0000
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
Subject: [PATCH v8 07/17] integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
Date:   Tue, 23 Nov 2021 23:41:14 -0500
Message-Id: <20211124044124.998170-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fe09eab-3884-43e5-7865-08d9af04c892
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB39574D9A37A53D6066D4810B87619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QS4eGzyd4iN8cVzs3ugxPbhXlVAAIg2e7nhD7V7+frxAgn27Eznmmo1l3uTZgGbtt4sqj5JF5//4DbMvxK+a/emCVRBvxxl4KjQ0P/PBAcjYKldV5FPK6p4AOwzPuooA+EX5SrEW3ZoV3bavh5MaruAEv41a/AyWYwbBmKnKn9QMlJMVbdNoB4uZvEQ+zca60q0F8Q4Ib8kK6Fi8Xm7Z9gKNAg6kJoe2ET8z4vje8FVT8qSzTjpEqAaYByawwJMfh/yME3M1ZGsQrbiLqYulQHMrjruuhsWhjAIfjzE2W8Ob7zGS4U4lfHhEw5FCp0OlkHIbUf6OYY3VdFGFLwQEZG1oqITYjcL7uZW/Pob8XxohhHIbnJ6wxgAvQk+Rl8ocf0y8GsolQ3a7+PA0kB2LCzdzE/1r/tyzS+i17WRzOY43pnEIuGxcTNI9cRxEbwqt+/MsZ4RayTKRkI+9hc9AzQJPYYDDxKryG9M4p2fn7FChaURHz+yyGXme2SU+HTfSSvkre482hzOYlgROip0xa7V8IjNHWplR+uS5cn+83dFbcSJmxxhGLUz8QS1hD/CMGj62EtaxlJAtISdWDJkR5+eyFnisMQUZD+zZ4jSq3AFO7PGSdR3BLZqrojgKifTaIrLFIw6TdyJACGD8d/Vvxar5U3thzJqZYp9QJGTNIGSj+RH2ssxV0m0IDG0g8tXFqBPY+8WY7mpynAU/C7tGSNMOUVmst3XFHVOCf2xH8mY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IWYt5K5JgM8aM4KA/1SIqB0VZzVJMyqO3fWncgzVu5U7AMNmjKlFEtYvzzst?=
 =?us-ascii?Q?mu9yKl6xUSLodGpRPPM+6SE1KNB17Xrn931+pcRBmULgh3AdVBX64wLRPrxp?=
 =?us-ascii?Q?kPcItUegxaP+PE2pzu7j0V+ogu4fx0OBpq6cL4zRfbUjj8jJ/+JAhON7NDX8?=
 =?us-ascii?Q?27xiWbDIPIrFcfHOtIqrfLjpv1Gjm71tfDcviy9JSunByGhOeRM0/bICIZ8o?=
 =?us-ascii?Q?nE3ak8Py5xvg0qtlI+WdnSxdGYmtxCccH/1AVCvhG4ouL9W/XW7LM5vb0Eob?=
 =?us-ascii?Q?ZqxYKCIgq3JcNmgNaM7pEoxytMh3TQwOrE20IoDmHh8NHW2+IlrU2UxVoq7S?=
 =?us-ascii?Q?Wk6VoUDzoT/XiBG6zofVOqQkYyLl9M+bYnNwXFjvbBcyzzM4JnYxJA7Wrv7n?=
 =?us-ascii?Q?SDjcNZebPlG8olrmBDdjY76JXnCpWWPRsHB3svz58v944mJn3z8CXXLLGweu?=
 =?us-ascii?Q?XaWzV1e5nXY6tan1WFopztSREsyeo+iPHp9aqPh581RSOJnynqSKNOjfOVnk?=
 =?us-ascii?Q?9i5VhmfLcqYjtuqUvCUp3Wn9LuYLaIjEmA/KaSVjAKPm/JEzavW6j2TST4Je?=
 =?us-ascii?Q?JWn51j3LxX+jJY+Z1437H1TCgec6j0/EY/rsxdMWYE+CCRkvpB0UMr3OZIm6?=
 =?us-ascii?Q?ss1TMYRIDJC1adl8DEFpi15rU5VR/7lpmaIKYLsI4YcvSJEH7VHYr+4/aqZV?=
 =?us-ascii?Q?9Usu3txnqwyu/7XBRlTSDH+2PRsTlQLDloKP+/Y/j61Dtj4pr4iKKGDygOgC?=
 =?us-ascii?Q?wwPgvs9goEfTd6BXWfqKZyCFBUD2Eab1OyEfp/vlLNZoxb++3s19nLADjAOU?=
 =?us-ascii?Q?KcMAyMbquof4TuPrF+iOFk0ns2BRyLc8eGCWqwYpLX3oZFMPwUyc0/CKpqZq?=
 =?us-ascii?Q?5LrW6NN51yRxJ2A/QExRGad7l36aj8xwQkx6KErMs4btrPEcTY69AhhmETsM?=
 =?us-ascii?Q?1QsRxgcy31LACJD8GWhf4C/Cr69E2S0cW8Z94ezSg3agc5w2dMrTo3Qbdc9h?=
 =?us-ascii?Q?M5wiVyp1y066QMeKNy58lgiz/uLENF4pTCLdEEuKmUWI+BlPshRuqBeHIE0S?=
 =?us-ascii?Q?OA49qsLX6BelGgz/n1c0LCAiEHvSRfeIm5IACr97dMmsYpnWHPJ8lr5FtWhz?=
 =?us-ascii?Q?zQJKyX2WukyyWWkQ0zu1nAOlvEuJkaZ9vOwPQBzFEMDcQuoWjOHkJ+cjD4Va?=
 =?us-ascii?Q?YHr5g/n+gfKZBY0vwH4UzRbtUpwLcgih6iE2A54aEFbxdXqX5at3dvv5ELGv?=
 =?us-ascii?Q?2l8wzy/wyQpeG98vfrK8xNmEElAgK6JUbZPYfDpj1hxfwq50Vp5l/AiVpAS0?=
 =?us-ascii?Q?1DyXUbHrg9+009CxpHvgO3GvEb4L68/8gf18CPdDtQl2VjH6hXdq76JXc8Js?=
 =?us-ascii?Q?mDsct4vMkufYUrKpqs27CsAZNs4e3rckwNgjLGN5mc75HnJNY2HV/ahv8u5+?=
 =?us-ascii?Q?+t5ThctghAYRtzTNvgOb/cl+B+w8rifPs76tBzmhpGmlPEID+c0fqXhrVR25?=
 =?us-ascii?Q?fN2zHhWg1R/3lO+QQrmS8tbJTG2Ic8wSOGCvhBDIkXY4QApm3n9/UgquJ680?=
 =?us-ascii?Q?8xFiOl7quZrMu8bqyxqu5Qq4EqQzgPVIDsgbkSZtIUprVzxde2U7KJcIjEDQ?=
 =?us-ascii?Q?h7s4NTaGoFK8fiXs3GJ8Qfg/yaIycg/yYSXb6sqfNcy+c5N0+JA8/9SRg8QV?=
 =?us-ascii?Q?izsjfg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe09eab-3884-43e5-7865-08d9af04c892
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:13.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aAc2tpCWHUMZeVb4vvZ5fjIL6mPZzdoUY06jv4Kx8Q3RIyvf442Y1qH6q+3VFSwkKv5n+hO1lfKOXRyBnEwZEbITXcGN83js9AiuAM3KFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-ORIG-GUID: 5xYJVHHetiEcw9BmYQgHpbLMfBbn8A2i
X-Proofpoint-GUID: 5xYJVHHetiEcw9BmYQgHpbLMfBbn8A2i
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
restrict_link_by_ca.  This will only allow CA keys into the machine
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
    keyring gets created even when it isn't enabled
v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
v4: removed unnecessary restriction->check set
v5: Rename to machine keyring
v6: split line over 80 char (suggested by Mimi)
v8: Unmodified from v6
---
 security/integrity/digsig.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 910fe29a5037..e7dfc55a7c55 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned int id)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) &&
+	    id != INTEGRITY_KEYRING_MACHINE)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
 
 	/*
 	 * No additional keys shall be allowed to load into the machine
-- 
2.18.4

