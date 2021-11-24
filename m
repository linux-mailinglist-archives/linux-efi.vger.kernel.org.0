Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C2045B35F
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhKXEqQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1158 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241062AbhKXEqE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO30Eht017974;
        Wed, 24 Nov 2021 04:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4vziZsm9hsEsnh0r7QZUE7lhPwNsHADwKbloYVm06uQ=;
 b=0v2w5SzGIl5zllR/All6Z51HCyOXwPF5xQ0PxnEMWt0nSzk6h7va2pRxuT4Jxfya72Wl
 fQJbsgRPZvc/1Mfgnc/KnIY8THxtRbUq6oiZIphRUC/LMfJYzmzliacGUG3kVqwRhRwJ
 MvjYgSV4hVnQf6Ls1mjr13DS5E5g13c4K8VR2qSp6+oKtPqptqAJCmAMkkludky/QKSw
 IPvRe5X02V48zuY3FtUJMdpWHnknojgbCgSieWJLGYREHG1ZugSqV47cnFcRo9rA4Ata
 Muf297fWRepSJbHwU2IAU2bfem7UfvUB+N5NZI8A1Whe2RSoE69F5BHwix97lYioSS5y XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg305dpfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4edFp036805;
        Wed, 24 Nov 2021 04:42:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3cep50s6tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huDjw1gDPn2HX/lif8p9BzwhQ9/ItXdr6tKIZFXkbfF4qsvzSCQ4VGyNc2lKXL4eYxunHpJye7DaDx5DtxFLDCCOLRUTpwGcVCT7rdDXIxpSn9CCg52NiOHXeXrBQqBImaPlNhlFx8kj74ODdBIKp/HCKnXRi5l5Sb+TS/0TRqQknKLvn89J/wgFW10DnAxDcXIHcogeb+yngKrTIdVJenRyWKzyZn3EePOButxHMVhs0s0UkKxFDWDXStrKYCxNtnJ3PFn4fCClY+wAGvKvy45aFXdnkykjfbIgSlstuDJ+pyGjD7ETeA3UewK9GSEySFE4moxWQRGRao2BJuf1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vziZsm9hsEsnh0r7QZUE7lhPwNsHADwKbloYVm06uQ=;
 b=OqTfEn4GLI4eGvoyE4kwdUbAyBm+4/0D0VAYWus1P9/vJewCmrcrNA7V493wavyZSx5frOxU2RHclbuTrsMVmgQLFBELhBtCxKXmDCZPzSViuNL/f8aEqweH/V6e6DfapoCZVx9TdJSkIyAh4JeKibvocT0OInqLbRJzaxQF9rFeSyVVAGEqSaqJR0qz4cshCB/dmNgrUSVwtPMNFvfzOFdHNBXNfbGN0Cc2eZ/dQPyTe4/3NdIjQAVbwHI9n/dqIhu0nROZf9TkU/ug+ElMhWm7wU3xx0oG7Bjn2UKRsLyQZn3sPn0Ctl0j7JK8QkL6EM3drwzolnX7LGkWTvLTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vziZsm9hsEsnh0r7QZUE7lhPwNsHADwKbloYVm06uQ=;
 b=pg40p8f2XXKoMmkSnYTXYgevscC48ikbeC940ofHSES69PlFtv2UdnDrbS9IsNkYv7Cjx+I4Rt9ZHldJbG+tMsKeGj5ziUaVSskApmnkxf+tT/NMaiuVHCaW30W2k3Y47g3S7Fm1P8NHdtoa+GkfzSKOaPZiHLFFrizScdb89gM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3894.namprd10.prod.outlook.com (2603:10b6:610:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 04:42:34 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:34 +0000
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
Subject: [PATCH v8 14/17] KEYS: link machine trusted keys to secondary_trusted_keys
Date:   Tue, 23 Nov 2021 23:41:21 -0500
Message-Id: <20211124044124.998170-15-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24923dc1-08f3-49ae-7a3d-08d9af04d53c
X-MS-TrafficTypeDiagnostic: CH2PR10MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3894FD5173A9C7D7504EE79287619@CH2PR10MB3894.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENN9i7FDtmyWKR8r8VrdEeXlSD6yWjSMvU+T5o1Ei7vOngDeEQY8J2KsqSR+gga4or2o2E31AhiS3wcEka4mDLO62GhDIsO8hqvNMkr4Ct1t4iz7gHQcZeQvzh4zjkQqnAY84Z8QefEg3xkGPhROLiqdbuYUnOJeAJtJtnPu76ydiOn1RTxhZkRQaCrDIy6QIpQpacyVDX/IxSZbWXiOhLLB1AUCEiZmjr2VKg881nWvTrK+jdIk6SgyVYXznhllKQqBRGSv6E7K84/eZ5MMUj/PqxPvTYmwccxEzcVXz1fUVCjWUSEjJ1HUv4MNZ/1+4EGpHHrq4E0FV/Hr/0XhyCnGntyh+6l9jm8odFxH47l6mmNQC3b7vGzAc8Z0e1uHOWEAgGvYQZXTBFq3G1uMZXtZQEdvA7GLbVEasZPOEHAgcFor/SbHByhQilVQ/eiaeCwuthDQ2nFRI//o71bqKJLwa9gO95IdgyLKK1hahCkoCEfpPux/5E5zPeLEDjsUpoSdnTyOpvZh8yWnyrSRx8252wbM+nbdw9yGXzkfOGWxTPN/gzdB9GTjzRna08t+jAEKS9KNY2Nvr8wlX0dMUZXAmbPICpDlazl6mhLrPigiQa1AFYskkH4ENS8NbODU/iCwTWr33Gy4WjcQWyKNXbdpwOGjkZcMfPPjnb5LfGQwb+s0xLAPvI2CkxrRoqUJYqEGolbt4TAmp+u44zediO59NNtVjSdogDY4KEkBy/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(921005)(36756003)(86362001)(508600001)(5660300002)(4326008)(2616005)(6486002)(186003)(7696005)(44832011)(26005)(4744005)(8936002)(66946007)(52116002)(8676002)(7416002)(2906002)(66556008)(66476007)(316002)(107886003)(38350700002)(38100700002)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUwxmUvyC3BiBp0z2P4h7SiKBS773hXL5xRmepH200SK4PTLI9u5lL6k1ZT1?=
 =?us-ascii?Q?A9bexjlufIvWDUNGFnS0tzOvzGDmzgSitL2yWUJaHGs/4yOovZeMb5irGSJe?=
 =?us-ascii?Q?rqeMPwvM3gyK8GG2BNfLUNuuZ8GX35FFwy/y6+MujAd2XqKH4H/geyKVph7r?=
 =?us-ascii?Q?+WTxfd5akSuNBak3tfGaTphYeCNFxiDf2csQQtzDY/PT6PCRLRHtr4XfOEt3?=
 =?us-ascii?Q?Qvw/YsYz64/h/PApuYTbOu1m1yivA10xJZrLIX+KK766a6zDnGHeSZzc0X9t?=
 =?us-ascii?Q?RToBOt4+BbhHBfXcg3CIzUTUy7xNdSSOe3NGpQZVs3ibrssdZA0mGMrDQGAZ?=
 =?us-ascii?Q?NMfofMXzYpLHaeb2UVHlVRKkRSE/Mu84RPOCGs9m1w5ERT0YiJkvogKDBL4E?=
 =?us-ascii?Q?U1r2G+bbOGw0JRdmq8RibDZtSxI9TXbl+GmCpwOLeXO/69JxlxfuU5YTM0kP?=
 =?us-ascii?Q?MlPL27Ax/++E20jbtW001jVJo2QwMPFd446WgnilyHQTWaWomMd4lnSJvd6H?=
 =?us-ascii?Q?g7RaUw++CbyyfawXmEdg7Yxu5H83Vg04AYIJt0k3a/N2FQIJ15N/dfWBS1Hn?=
 =?us-ascii?Q?3iO6vfD6WKXtYosu2Ql/n9OE3dPADDLM9puO7AgWZN1GxpFiXsFaqbYaoBAe?=
 =?us-ascii?Q?18Y5Wnu9/cIwZGGS1J8lUvi+2+BfuUot6EC11ySGFwBDfCtYDz74iK2UDDmT?=
 =?us-ascii?Q?76D0JLftQyB0Oo+zLDIQaUz3G0c5u3lQ3gnJm/XfIEv5WCBzRPHH3E/3/eAB?=
 =?us-ascii?Q?fn9UNjOKyJPP00EN6/duGZdt3L+yXYHB8OPcO8X0dTYaSrIKi2v0LzvXVD+3?=
 =?us-ascii?Q?hxDeJvNuaY+gHVZIX/QQQ/6rZ+1NhrY6E9/jLJ/pdJ6GzzHKYk8yMeNba7Ub?=
 =?us-ascii?Q?tKNpGBddsFy5gKrFmclymmd9CpuRN2cS7+mPEvpySWcbP12LOSVWlYt7Qd5q?=
 =?us-ascii?Q?HimMN+pTSYysaldU/S1MWA1sxAVPPJigwrk8Fh7InbJYGGH5lwxyJI/t7xmN?=
 =?us-ascii?Q?K7ZV2VJMTFytoGwBprdewqHKSayGJ1bJQCljgPHMXQVVI9Ef2WGsqKUNqKwB?=
 =?us-ascii?Q?L/GsEPOtvLkLMWjucWwXjEIAgl2AVlP3NUB4CdWNeZERvRTwnevomP/Tgjvf?=
 =?us-ascii?Q?612V+6dOfmkeNKxc1ng0iPN7hfEG25/KrWCeq1+ZzeEohtqP6bUdubZfS5y+?=
 =?us-ascii?Q?/YkazDHNk+1MPt+dAFYMQh9FaSXZNNAPg4hkIyNQoajz7ugFurTno6028zUc?=
 =?us-ascii?Q?kQUUh4PTbkIpHz7EOB5/Ogp6BXeiS/QPttVPbHAjmK1wtKYYL7hIntcwNvGp?=
 =?us-ascii?Q?cpecygk6N+qM7+B0TGgNyAP7JInsxI+FQWNxZfj9KgeFpcNh5h7Ypb4SY5Oh?=
 =?us-ascii?Q?yo0d+8ZQXkg1viYbYQm/+jatHNbpLFwh/XzXpNi2ygI03eYt03E/6VNngD1A?=
 =?us-ascii?Q?FhUaznyuAu7hI61q/F2JIdLfMuW1Exm6SOWBQevAcLjmGKljujXxBCQepuGs?=
 =?us-ascii?Q?i+JeDwul/uGYOYT0ia8YYkPtDUFGe++NgYO8f0YmH3OlvE7ro79BP3gd3nNy?=
 =?us-ascii?Q?VEbKeN2Zrv0BFPCkz3FpD5pDttuV2taZACBg4zuYEUKVXy27+OIm52tNSrS/?=
 =?us-ascii?Q?/b7HxHxEMPzIO9QrGlkAKZSKwLku2i7F9B8H9nh7PmQuU6cdkzHGIfFZUAvM?=
 =?us-ascii?Q?gzERyQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24923dc1-08f3-49ae-7a3d-08d9af04d53c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:34.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUpAPXTEHBbEG9vwX52HUTO/Xlr5ttJX9Gm6PsGMizskEc3eQznGQwtbHWlfcmNaslk/J52E33/urU7Nee6slpMeZ9w7VOChDUDK+JS5U/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3894
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: M2xTQeEWS3EmWVSzX1gspJpaIyx5J_mK
X-Proofpoint-ORIG-GUID: M2xTQeEWS3EmWVSzX1gspJpaIyx5J_mK
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Allow the .machine keyring to be linked to the secondary_trusted_keys.
After the link is created, keys contained in the .machine keyring will
automatically be searched when searching secondary_trusted_keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
v4: Unmodified from v3
v5: Rename to machine keyring
v7: Unmodified from v5
v8: Change patch subject name, code unmodified from v7
---
 certs/system_keyring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 07f410918e62..463f676857f0 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -101,6 +101,9 @@ static __init struct key_restriction *get_secondary_restriction(void)
 void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
+
+	if (key_link(secondary_trusted_keys, machine_trusted_keys) < 0)
+		panic("Can't link (machine) trusted keyrings\n");
 }
 
 /**
-- 
2.18.4

