Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A68451CE5
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348110AbhKPAW1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57876 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353536AbhKPATx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:19:53 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFN9cVw029754;
        Tue, 16 Nov 2021 00:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=60O6rnQkrlw0sUUcObFEFRo6UsPfAax+n5OYP2BTs4s=;
 b=RJJCtEpHFWiYyRu4VP7kQyMSjzaIklh8aPTePj2wLtVioIWZ5Um5JLNrDhsa5RiGEWwX
 QtTl+G5g5k9GcF6NeGwvV0L1q18nixXnSKTuf9jL8Ru7N101VTeUT47Nc3yk3O8uTxJL
 pBZAxcJvTyXysJmefoa3MNHASwDLr+JMmptHRWq+uxYASTge9Xsr12T5VTgD4OWWgq0i
 Sp/npDwWVVrY5a5OwHN2h9pFQ5okgfWYb8P7iZatwKIKUUwPX9Ferh5xY/Hb3E5JiZgZ
 Gzj8Ve+xhMBxIBh099CocxKBZxse3P4yMjt+cj0Th/j80EF7QhuTINNutBZCIWE0crYY 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnp3p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AMOx072901;
        Tue, 16 Nov 2021 00:16:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3ca3df6j1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNlT7XCdjbgq9MX223nraZkpfTjco8tGduyfJzm1bTKPeyYVcbnubW+xUWL0SJPRgiD+mvXwSLwPu5s1jFRBaLCrjRXPYk9fHMUd9/mmC1k9FFHlAiv1YjX2S5Pjx8IIp/blFYwRYrvaigSNDevzH7c3Djlua4/vDojwk0jSSBqSyoM4jBKS+zze0YaiFTMxgwtig7BYFbrKwodKOPqyNjk92eKeY7opWMLVkTXC40k8/cu9fYOdGOBXnvWU2ssF5DIl8iJxEMAGv2upqRzkzdpuL1e5QblG+TnALU77juHGHYuTSy/KQ53kZz2ziZBL/Iea9ObzBaCtJZzULR6kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60O6rnQkrlw0sUUcObFEFRo6UsPfAax+n5OYP2BTs4s=;
 b=EIfDoV+Xkz4LxZdMsFPy76KF5Y48QmHcNeSz3hlKrSvQnPWh61ZB2Dca7vvm28dpa0IhiqQnr7VrqCuq/t3uo2PKdJIUiyY2qKokzEUGOxYtuRYk6m/y6uS1YKwSjDg6KtWIguIOp0VllRLqKwkzNWFkJNy3RQgoQY2H/20qR9l3jT8Y0ooMl22CcKdOV/R/GuUo3to3tcAtXiflYSJ69bHkiWjsn/hmxmhQo0fiYbY1C3nUh8+I5QZRXT7EF1Xu5n9JhiRhfsBPVeYCWCA/fSFLte4/Dr4QeHMCCEQoqQnAGnBoyLgVlCZhPS4clUYx8bqNTUyAbUaThqz7mxkXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60O6rnQkrlw0sUUcObFEFRo6UsPfAax+n5OYP2BTs4s=;
 b=glW15V7XnmLvnziud0sZUfEdpzfdbCCRaJzcvC+uqiqmfm4pcR8CeUqzVdcIjWHz+zsfQFANJxxmsajawnx/+ap031wmvqQZZ9y+Pg0U7z1xt9NNRkVGccYnBgwd9L0Fzmxt6yogI8aFlCyxPAkaZEnIksw4OcjmANiIXNMrIxg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4358.namprd10.prod.outlook.com (2603:10b6:610:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 00:16:19 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:19 +0000
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
Subject: [PATCH v7 03/17] KEYS: Create static version of public_key_verify_signature
Date:   Mon, 15 Nov 2021 19:15:31 -0500
Message-Id: <20211116001545.2639333-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84b92552-311c-404d-7fd5-08d9a8964fdb
X-MS-TrafficTypeDiagnostic: CH2PR10MB4358:
X-Microsoft-Antispam-PRVS: <CH2PR10MB4358BB5A706D2165CD7A9C5D87999@CH2PR10MB4358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd+ol6pC+wheqbb9Qir9OGgxQFa+4Ovq4/i5HLd7kYP7orFNNC8Nx5C1ocJWxkEoYDlquif57cFjUZUbx8aYJja/f7ehHqD4EUxAmuKrZ2aI3QucKczQ2D0QjKLnEwpQDQOFkSH0XGfRYpOslXtmI/vxOO1b/xTyA56i6wuODyAWbIgE2ECp+s72ejozMMkaX3T3XMBrbWGO1JEsppc4j3wNa4N9Mmqa7p+1n+YX/pnSjDnUdDAMFszK1rKnKMv2NqaRTr5v/WecXc3K5ykLpyuEJQFtWr5wsB+exlMdWuBLG/DnLiVswOUhjModbAH3QAL90O0+u5DxXUhFuSFyB6/hHyw5tTs3Ttoa+QH7R6sa1Lvj5wDK/VpsyiNQHR2e9wata1ffOoIfExjB8OiSAgcl3zPD8G+NoWZtzqM6gR/CqxYKE97JXoQq6KfPEwLy8fQ1Gnr/vIN1e4churqN+rIZOOB660fSKMBQ4FCgEaejHhGEt/H0q82dVfyPyUuOdBNii2+xDz0nMoG6TwbWz0Pp7B4ZVN7B3s1pGoqnZMvZtQPlPRERsYHGqvtBNpI+9ejI97IDR0eX5byd57+B+xdHQE1wiNIkVq6xM8CZI9x1Ut7MY70k4xBF2YLkhZSlibP5zJrDcDDDyD/Zayf1IWj0t6yM5jFJrVl8GxspSU1zbI+L1960bC+yhhglCwvuK3Nk0Lp34kIoNsN9EhjeLenDSx+v7D9LfQYXWs9dCRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(38350700002)(186003)(86362001)(66556008)(38100700002)(8676002)(26005)(316002)(4326008)(8936002)(83380400001)(52116002)(508600001)(6486002)(7696005)(5660300002)(921005)(107886003)(1076003)(44832011)(6666004)(956004)(2616005)(36756003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EYId2ypom6+PrlTqtfVqvlfU0+exsRxk2N1g3EQXwdPop0FM/k1AQLDwetJZ?=
 =?us-ascii?Q?+DkX0ohC6bbg7gi3h4+Ra4kEegIUbji9wKslJUpkKMuicTjzZ9HVZ+Bbks9I?=
 =?us-ascii?Q?YpcE/m8/Ze3ty4vhABimY+IT7XlmrhlRS7uEYz7e5Z5nPyB/+FLL33AusV5h?=
 =?us-ascii?Q?lEylLF7vd725dBDTCot99cps/Kg+xlkwIINp0B+CEH8fX+nTuaVzhkzVKcI3?=
 =?us-ascii?Q?bZUYGhmA+sJLiLWeaI8ld17Ff6NU43RYovWSleFkMhLK//vBs3k5bgygDmsV?=
 =?us-ascii?Q?4QprVmIn0YDSAlYs7QnHsZGL+kHNS81WsiYbdLfItP/qXAd18Ki/Fk/OGZ2B?=
 =?us-ascii?Q?2klUAvxBhuGD/wIbL4VT654TfrUefverl4lQzItTTWa08QhZb8TvKCeTCufQ?=
 =?us-ascii?Q?l0Bb9MQtQn83HvkRdx8BzVGl/J+VeRNO4GdB6RTNhAJffxI3sFb//NNgNNpD?=
 =?us-ascii?Q?loeZlJj/HnmBTZNRe9T1aPPUMXsQVPX1V1484O4TP+J6EMI/yTMZ99wNY4xg?=
 =?us-ascii?Q?q+FSksScSwH04UNEzHbHdos5JVybp4QtkgwkLkqEjDL8RPCT6G8YjWKAknG5?=
 =?us-ascii?Q?QMrjejFqLMaWc1qJmz3DlgRTJ+bxrtWgyhzQ8ej/1qbeoNaFlBzqtv5bsrFg?=
 =?us-ascii?Q?4LI1OfpyDMC1aCb71h0U64GTWrUOckPWcoOHhIhIdDXCTUEZtC72lvM+nSX7?=
 =?us-ascii?Q?UDxnHojW2HVlrUFandcj/Nnyi6s4i6Hl3tnxiHl+FRr7sinZdOiYSTnFzF31?=
 =?us-ascii?Q?09MDSA/dxNjgVjlmJ4yWIuQCg6uRYd6rlRDuelkHr/AsRBJ6/ldu1u1i6CUk?=
 =?us-ascii?Q?Nd8UJXgqGsGhl59MpJ3WtkPBSJRwHt8o2VfxoPzKytV/bvCJo88qCpV9GJ+m?=
 =?us-ascii?Q?/PQ3vw9puUEUAXD4TOfLJEqKZpS9BzEcYaMBG+kA4CzCevS/Q/+8kcARNEPL?=
 =?us-ascii?Q?BEfErnGVMfniyGxguPSbq3hJdm3JFHxGBygZFIkQqvVTwUe5Zc4MN4SpYLVR?=
 =?us-ascii?Q?o4cxB+UBs8Dr1EU5JiEEcyU8SVRMxRlrZhyBNZwx4RZG9pvwZ4CeZZdCaV2l?=
 =?us-ascii?Q?GgFgQnmP1qnU2Dufx2hBFEsdKCGbQuD24XfXxGtEyXIAWFObv5vghw8LLbBU?=
 =?us-ascii?Q?SDekQDSXktfVixl8mxUlRSga5uvhk9KxWsua0RfMF6Xj2LK4gmnOJHFzpT5Y?=
 =?us-ascii?Q?h+IM/Cw//fRjZY93lx5PaNv0FquRQT6/45rZ79JkCGKEqYkddmsIV7vvJ4/p?=
 =?us-ascii?Q?FUaCiX0wGEY3VnHz1Gy18Q3eT8OV6Ro56NKU05Bo+muT/6z2SBDW2GvooUwI?=
 =?us-ascii?Q?nwQeiYz0ya3dfjylXtEB8RogSTk6Jm/HlDSIXD4vEy0MXXR5kjOeuFGGPHNu?=
 =?us-ascii?Q?KfPJZBSvFdjMrBXiz+hYza9pUJvaxE6U+Bft1HoZMbFru+dMAU2Zk+vwDgt8?=
 =?us-ascii?Q?tV1Wpnbzs3iJh7kZTSRFjlUq/lbz/wzwAYpAqBdyHiZ2bFMYaqk+bTLwphzd?=
 =?us-ascii?Q?vQ+4afpkKdTSQlRh80d5uyPErsX7U+ZFhP2mY6QVTUc3nb8ATugFYkvbTdfG?=
 =?us-ascii?Q?z3DQZmB5m/fWJABc4UfS3BF4c1LhHTXu74nqI7ws87WClIaFX0H9IcvE717n?=
 =?us-ascii?Q?l/fuwgR9/e7D9CIJI80N9fb4J/fcCkLCvb3uYX3z7xIPV+C6q36/qRJpf88E?=
 =?us-ascii?Q?CYFbzg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b92552-311c-404d-7fd5-08d9a8964fdb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:19.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhZQFNpQyM6tZTP/670EJZTGT0upEy9zLPvC+IqSqzt3g0WaL7yAUfLBgfSP4tIjBSGT9fHGJnYjxUbIP6U1QIVKHugpWTPh0wb06NvotIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: fKrzdRgOC6FpbAt52txBX19_V_eR8QHd
X-Proofpoint-GUID: fKrzdRgOC6FpbAt52txBX19_V_eR8QHd
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v7: Initial version
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index f603325c0c30..a9b2e600b7cc 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.18.4

