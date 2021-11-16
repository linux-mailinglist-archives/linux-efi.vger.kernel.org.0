Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C708451CC8
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbhKPAWO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11264 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240885AbhKPAUF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNHFKV029766;
        Tue, 16 Nov 2021 00:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=RDur2duLYJopEx/61zZX94qtsNXff+nIwq2N6kSXinQ=;
 b=Gey/P7bUlLhVLHDyzXVSw5D5+f+fQtGmjUM5GHJVWvfHWphqcDK6Kxg1Wd78kz99NEmp
 8f1Zsr3AVuNq9Qmfci2alalig35bnDyUF+YLmP0c44LPmL+Exitmos1SebpOuloEQqjb
 rtNsH9kifUHk9GUzl1nQJqUUldKIH8IYtbmgw7Sy/qpn9w3EOGKn6CqLYeHaG7lB6D6y
 612Te3pcJFYNUu/2OQNtpkl2gtsE/nM/S86z/3ohu0FrWgs1u6z1f6n63a1nz/xipt4t
 dUmhDxo38RPsdn2ySpwPnPZ9rL5f9Eb5BUk/YufuLw27sGQoaNbo2hSDsAzavd9NQh30 mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnp3s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AA85136051;
        Tue, 16 Nov 2021 00:16:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 3ca2fvcgwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPJx7rBR84NbuGTDzdI82QEDP2wq6YZZH5DNSN6YpWCVWzNqEgd2+7XqVIDr8VlCqUvjtbr6giIeAPS3WRAy8cOsZ6OL5/C27GTEWnBvZg/2+YoKtlHttVzFT+5TiMDswPD9ACuokN80WK+6e9uNPOIfld+U4Y30AUHb41feXtn3mxnLjGNswdMAt2wJC5a/rrSmKilg1PL086fNBPDnCPVWiP0VP75QYvsOcv/SJLKcyE+lzRN3w8Zqjyp+6lIaTwOcEKaJYxpJ11rhClLaNd5OZXSBIchBAVMb27lNEcqb/lVVG4A5Rmo26E/pEdsfPqL9M8iKNCBuYCHfNWNNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDur2duLYJopEx/61zZX94qtsNXff+nIwq2N6kSXinQ=;
 b=iYgrXx6no+TrHS33ZCjpLfYTF15NQ0E9LcK4PiMJ07QFBC3HtnvqpwBsSpB6nCkKQHJZwrQxqqs77CsHd32fns6INNlaKPRGV10T3zbzd6aeKqjp4gSXVBB/OsVLV4kjrASkXOera8O8A92eW/M6N4Y5CaKsQR+wd5pixiZNjxqi6NA1ejWz48OHQxCaGOY/SxH2XyOwfRVEQcc8rbtsiI7kZ4g9ugQNsRb/C1HCV6TJ79Ybby1Rc9hI1jEQuN15c/4amD1EtPUN3FbA1Pq2+OKT+vXDUAyU+HDjrxjDS7/pGpDH0eBXr5tQnR+jwIEyo+4CHoFc0gdbxpHQMMWZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDur2duLYJopEx/61zZX94qtsNXff+nIwq2N6kSXinQ=;
 b=KobQjhYzgT5yW/UR6y3l+Cbf7twXWW3ovanCx0HkHumQWMCyjdn5u1ABPevUIc/ncuVT38xI8O/ZsaUL6IcgLOZdZ9SyQNDGCCA2V5PDSknBFia5/kOtXM0WDb8c/x6i3vCiJW/+UCCshxkGWOmwv3ktg8eC63Cf7aVOG1hBt4c=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:46 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:46 +0000
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
Subject: [PATCH v7 13/17] KEYS: link secondary_trusted_keys to machine trusted keys
Date:   Mon, 15 Nov 2021 19:15:41 -0500
Message-Id: <20211116001545.2639333-14-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2513e2c4-2161-4214-8ca0-08d9a8966035
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5276C21BA393EA0E8714E25B87999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVbdQDsVdvfvtv9Olski+tlZJuMwoYGDU/8wJiTyskNNqAoXJQAamh3vLAhM6pR2GCKbb30rzf9CZlkSr5QB8BsxfciwUQpV6Vk3KKQ7HWdTzJSUlBYyYX79v490IGZJlF/NoiH1tO+ayI0665RmkJs+utre2t787rBisDeUNGW7rLz51M03gYIHlVZew/P1F5GHrHdKs85krYI0LYv1RZeZiO9bO1h/rRX5Umq/Vg2PClQ8UFIOp7kjDOwtFV9R+jcBUW1IHIU9QKuveUYKLgaZC1L+jCLycsoJwDp6C/t9b2AjJML9ea9aXGWi5tkzRGtWUCYcPAp/bSRZENYaIn8GRjEpI2bHdmMherp6A5MgJxTsblGETvBTwUm9aIjtmy03dehQW1+hTrEXxRdN1sXtjHXKBiN/kMJ5iurgi+N79IX1M5z/HToDH9VIScreJ3Cm88yJllvV302Qu3otmfuqvKxhRVQza6Ssv3V8ldPreI0PeXUm3wGXicfe0StRBq+ODUHvmCWRKYsw7QaaHAe2I/fKOnKEzkCK22RQxS1YY9XcOtkTze+vvy1btwmOG3OU/toYBwzRgjuCYdVQCVJCsDhrgVZPKcMMbzAKtrJ1W9YM0GK5TcxnZ7jMrxOlw4AHUy6nmBcUriNu3ED8LlJ6eIkfBDAMllcSvGzlWlZNFc3If93Y6EFQgCar/EZet0K7AvBsEbZuvgBEOmOlFM6Md9gzNQU9InY9uQ+F7g4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(4744005)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(4326008)(921005)(8936002)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rSqIWFIS6I0i25WYGYhf7R65UQwZlS5ZHX9Hwvk96WoLo8HB9BkWFN3QdZrr?=
 =?us-ascii?Q?E+dSodHdLKa1dbk5BrPBXmVi76GSIyyII1afcjvEujHVJvJYHswl2SvXhUhR?=
 =?us-ascii?Q?JjFiJax1mpFz9rxaFdNVqSEpB69aJ8ARbIcacKleUoLsZ8ReuHGxznkMbZeX?=
 =?us-ascii?Q?WZdLcpkg3z8p2N1FWhXrZEjAiaabHkMuTkjaNSAvu2sh7s9fcgS1vXqnw1kt?=
 =?us-ascii?Q?EYR2J5weY98JAy1/jlVnlMIGzpagEL4pph454EA0yC6FsFLg6bINZ1VqzqNk?=
 =?us-ascii?Q?ParQK06SOwCPDw6rtMfJ48uwgYEdih8HFNWFOdu16oRCiQJTQG3Qqx5PKfbu?=
 =?us-ascii?Q?4d87uixxL9/jJQj28gBI9tcOxCt9rb0Oe5PWz/g14bzkNyvlG0M00YkisB5z?=
 =?us-ascii?Q?Mex3cLhP5vUbYLT4R33tjx8y//M3CT6Rc74X0cfoGuYxiQ+Zw+eZYE7NU190?=
 =?us-ascii?Q?rF71qMPwdlhxBxRgfOvdSYOwDkgr+dU9p4LsPkiL+uFluSWSQj4OdgU9gmWB?=
 =?us-ascii?Q?dgi7YsaYNN2Y11vRRIHfkAmAX7aQgM4rh27/bj849ZnZKm5CR6B1a3pTdvMm?=
 =?us-ascii?Q?RccatmOs4rCUARLrke4N4tTKpZpYGAqwYoQvq9eolNengg1oydgg2ILKfLSA?=
 =?us-ascii?Q?42Zh/YRav5eRmUH1Hj35KaDXwnPhJyQuOO4M4KJ0xCTCOoiFTfTB0jiIb5+Q?=
 =?us-ascii?Q?7KiFFvu1O/eAsA3szl9C0ccDnqOxyIlht+7JVUGCTx7MMUdos0LwL39pW4w3?=
 =?us-ascii?Q?DuKVnHg18SGLJtVome9BZ0yxoobCh6C4TNos8Tzo03Kwhk8IJYWHmRJrdknZ?=
 =?us-ascii?Q?Q0KqLKkAi9rr+ePULDqGiIWVqxDoAD8vnBxxW+jsy84lWRG3XOfFUfI5edan?=
 =?us-ascii?Q?GqyRxOeC9vMPAmq+NA1lJHtCzzrrGNIw/j7oeqsQ9ipYNGAUYMgIqDNUZr/v?=
 =?us-ascii?Q?U4SBSXw7bPJrfk+ZDFfKI8impG6k1UynI7xMn5I8SVqlwMuZLiMSWuO3+uz0?=
 =?us-ascii?Q?FpxcMsVSlqE2DDuCQIqWPjTPqHgPEb5PKeBTzdXEPJ4lZ6iCOXLBnwDX8JIP?=
 =?us-ascii?Q?BLmWMmrU6NkPLX/eM3FR2ognCS6ehcMIHy6m4Bje9JKDSFR3+OQKbHCg3cP8?=
 =?us-ascii?Q?ldnAko72MTPmrpeZAPlEmLUfP3tschfvcP083OMncxW4jzseiRPeA6kPs5AV?=
 =?us-ascii?Q?DOBZ2IAFQSRpApejdQtuu6/N4WXXDLvSD7F8ngqsEX36F2cGyUzxsT9bx7S3?=
 =?us-ascii?Q?zQUHj3NGor1mAIUwIkQcGNj4TqZjvrXxV36WUM6ToGYs3aqmf0gpdVQURfmh?=
 =?us-ascii?Q?gGkhH8/gVqIYJCUmqPEWosrYbsZYcIivnOldvvWpG8PbWt1dw3djWfbbLpt7?=
 =?us-ascii?Q?6E8Diz2dXZtKGL1M0ggy95ldHVRnjAuRMVimeGIbN0YKFSZLOwyBvQ8p50m4?=
 =?us-ascii?Q?NZ2KzYGO/+OLPTUOMUYVoVc25Qo0NWmBMB2P+Mz2eqyqkNHOjBwrFpebYBbr?=
 =?us-ascii?Q?IzOKXKrcFBCqueQhfxVwKIKFb2MJzgpnRLPzNJ6EHvE4QRRXEA3PEvRjrZtQ?=
 =?us-ascii?Q?GGt1DB9whjnZQvPln59ADukCqyEUsUvzEDO298/5lX4rF/sJvnqtQDWSsai4?=
 =?us-ascii?Q?OVZrmVOaVWpZUAS7FSHei1oWVse6mMPTY6ToN2ivd0CJaxOapwShnXf2qzvb?=
 =?us-ascii?Q?CZwqxw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2513e2c4-2161-4214-8ca0-08d9a8966035
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:46.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgUE38seeKAZnji4MvMQQWcZOimbux7H8/oR4j7MTjrvZCiptZZB4JNI+7W1tcMUkCOdAz7Kbzwed21VQt7dF3EUMd6e9YUu4HxW4GRMCB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: SpvDiyZrPM71qvNvaWvqdoSnOo82sqP6
X-Proofpoint-GUID: SpvDiyZrPM71qvNvaWvqdoSnOo82sqP6
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
---
 certs/system_keyring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index ba732856ebd0..2a2dc70b126c 100644
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

