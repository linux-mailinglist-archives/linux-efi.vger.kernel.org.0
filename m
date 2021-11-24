Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFE45B383
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbhKXEqq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3770 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241090AbhKXEqG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:06 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO30Ehv017974;
        Wed, 24 Nov 2021 04:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=XKM1ZSW0uNaKofAjerQlXRhjhC++E9LgA7yP5fsFVhQ=;
 b=goVGY5PULqc6rhGnvSa9YayHzyMzToUvxamGIGKG4vU8zQ6FnGgIYjDZFfpaUaklRvQc
 6uIxqwq6T4N4o/fGzDJ8gKYvV687HAYEFRJuESUGJsfHbX1MSWoyIo/NOpi/imcjfPwa
 Ut4HD6SyTAKokJ1W8u8SsYEu/UWZfHYzGzAuVd0/n9o6mZIj7lzDwjAv4nRqrEsJQOsq
 /xAQ+HWew8hsRHXM1yQ3716fgWaRDRRwH3BDYndott5PH+7oFbJZz9p12RWph6+y159C
 43BQJ5uzMVooH9a2906mMoBwmknXqjVDo+UalWV8hXl5hF5DRUXBD7F6qWBRtyZxH1M/ 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg305dpfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4ecKs036773;
        Wed, 24 Nov 2021 04:42:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3cep50s6y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgBymT8RhnbfUZreSZQl6A+JDGktS3pnfcuUVqd9r4T155RA8YeRpmb9uzSfjt25miaF5uxcJAcVhufIVzof/7PNARpgyXb6eS4u2trtX6/FV+JOMxEhM++fSx1XpkDmD+n34UsA3AnZb7lWy0UTy0faL+jjaH9NyvBVZnSHXdwK8wuTElkcqfN9WGyKws+MbbItqG13Jcs/xK4y9V+K+ozuVlWQpchaikAX75BaQEsSn30wtIKZoA/frxLLAuzTjGOtY2wmbsXsUeez1Fb2cAd6bxuIatv5sEDZ7v79qeVx62ksViCtJQx823cc4k/QCjDzuFKi4s0uTgy8G7Q05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKM1ZSW0uNaKofAjerQlXRhjhC++E9LgA7yP5fsFVhQ=;
 b=PIqJtX0UIWrR+W2BFIeGjdSVv06KlGtnKMFld0Dj5F7ZfsYrTRi4DOmSlxO6/tj8HEwHgSNKf7eotGgUT4D0WKFHCortp10oFUGQU2lditn5X0vtGTNs5iACv0tvg5TqMhloRxS2Ori3L3Hvw15WZewDjsOlrkfOu0FSW/cr5Y9uUYsSoPOsHT80AcdUGUSUicCGEtOYkim4rquuUlrMbtMfjvWlFZrmHZtu9/YKZswVdpgGfL0RtcJk0+h3Jn+pmFO1d0hWaAyDefWqyc8MA9OacrZIAtBG9FbCcO7iDEKT4wTuzP651vEd0RGYU5n/SnZHuQo8Ud/hqR5r5BxmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKM1ZSW0uNaKofAjerQlXRhjhC++E9LgA7yP5fsFVhQ=;
 b=zRbgvOsCKzlbOKf+0htPi/XisDcLhJX3+h5uuMb54ZHMlcPdAMne63RnZISKiM6W/s6kpDbAfL9VaZ+AqrPtWOQX4Z6lRi/ltYuk/0xPjq8Wk1ERIzXyGm138BuzbbpIJJZBSjz3HxadZTF8PsfmrQCp2ry8yQmFzl4myPB30sA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3894.namprd10.prod.outlook.com (2603:10b6:610:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 04:42:38 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:37 +0000
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
Subject: [PATCH v8 15/17] efi/mokvar: move up init order
Date:   Tue, 23 Nov 2021 23:41:22 -0500
Message-Id: <20211124044124.998170-16-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 609092ba-d2ef-449e-522a-08d9af04d716
X-MS-TrafficTypeDiagnostic: CH2PR10MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3894F73D3CCB9C91130D6FA887619@CH2PR10MB3894.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMaUem+BRBRSojxnJ/IbQzzgFnNebC3Y2qT4+eUFnvo4VypI2BzHV++T6FNeu2x1AfFT36zEjkCiZm4aCYbs1YddB4w6hfQVOIT7ki82kVeGtXhM0OErczEgb2S1TEqGZyw/YRnedTfjtiZi1JYt8CAe+KrKw5Z3BFZj4Q5Q2C2A7zoxA7P7VuGE1OKmnc8ce3Ymwi1w2OQ5qMnahUKbuaY/BLICh7T4EseUCklDBA0tn/r0vrQi4RSVG+yMVJqsp1eH+cM3vKkUpHi2sqforBKPC7IB7qhUF61ui9hWkWj33CAfEJmKg55sRbB1Rdippo8HLbwWHkjI9qTL1khvfuKI9StCAqeBwKehPGq/991N0fqYXjaSKyHrjbJu32+z2jGtK33AKOaO3EoojwYWDQJZUHQPyea1y82YD9iRUgs5juG2dZEmf0D3A+sLEByHeimKEjY2NWI2KuFWZBC3G2hncqpkvyDix9xxWwUXM5y/lR90zHgJp6vZoi/5hrSXbCWLITY8+XeAap+Mlz7HFyjjN+TsauMHcTM0yYb92sc+qTATHFgrQafBNTrAcqln21+wY8msEDTiBg8enf16NkBQiM3PR7SpIFAlhfPECRCjKTPbpNWXNQ5EtZ3zu9doY4Q9bwZNZ84+a9dSr28+a56gNJZNAKcGIjsgp6Wixg8JpQwVdLpQhSgRVvu6FQPxrVuphT4a7Y3TT5oUH/VDgUb3AozZJH/dsZT8zjKwOPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(921005)(36756003)(86362001)(83380400001)(508600001)(5660300002)(4326008)(2616005)(6486002)(186003)(7696005)(44832011)(26005)(4744005)(8936002)(66946007)(52116002)(8676002)(7416002)(2906002)(66556008)(66476007)(316002)(107886003)(38350700002)(38100700002)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZ3ovGvWqIhHMPIVTPvdjCiVb5S/lf9nrtEw8dVIv1HbJi5ixT7NGUbzBd+i?=
 =?us-ascii?Q?FoUslJPrx/wQmeg3LJ+bb6CcjoD0KD9DAN1peJEYOHiUQJp3oMh+4M7b1lA5?=
 =?us-ascii?Q?40Ip0BLZld3rz1+x1fMA40c4RudSkOmT+I64SPLOSenxpvpCnfobbiwuvXbh?=
 =?us-ascii?Q?4G6uv3XrDzbEdNJGAkv8OYwd9KmMjjMUUWOehWyWTbD8blhzUmvrQ8KCJg37?=
 =?us-ascii?Q?2xzld8EhorHi81aMLd9nwt7hxEBJHjrdkeOeskonsoa4PqPGz/UBqTmL6nu8?=
 =?us-ascii?Q?h/nVEcCaXZknbpRE/2INrjRT/is9rKs9to6+5k4sXvtXewtAb4cq94rsalO3?=
 =?us-ascii?Q?6oFLy/D13wGjfTdu2OBNEnfKzPlZfxYxg/XRRuLko1HbTkPImQ7o17F0NGyT?=
 =?us-ascii?Q?MPSFLjbQ/zsKg8r1gNpvldqC/v6qMMMPWxkhOjOV+ENiyUhI/fWFJAUyW9A/?=
 =?us-ascii?Q?Wz32BWJCQlFNPsPx/p/dQkjgpVCHf+0e5fm7AXSmjSD4vqBa0ca8hsd45N9i?=
 =?us-ascii?Q?mLTVT1VFNRqqqmSBzKgdvytwhd2xxAZXkT3nzsrNnfEsgQ2MJcpwj7qRprW7?=
 =?us-ascii?Q?OgNpeaQdJ4ZHthBUw6v22MEHva4AO1qVWK3LIs58lMdKmmWFuBkmjWlMAjLV?=
 =?us-ascii?Q?ffMg/YySUrYz8LwsPly4xYktK6QigfiAyvD/fXisrKgLeh0faV6FZEjwZsQB?=
 =?us-ascii?Q?wgqO4LVM5CjzegOnwmy8w22wCcI2o+f/E+Z6UN/+H5iwsVo10/lDVwa+stMo?=
 =?us-ascii?Q?PZYYdFnCnm3f2i/03QM77FT391W9WW3VKtEvypH1QEXyhiZZzcfZmyywz1aw?=
 =?us-ascii?Q?s5wXcnGEKPfMNFyfA6hTL4bAANp4gSx6xwRx5xPIHrU+09jZyzWmGuPCDLmh?=
 =?us-ascii?Q?S+bjRH3wGGa0fCUG7yjWazkvyqfN58Ems2HYsq9GQcoPd8vzbBQcTDPkgZ0i?=
 =?us-ascii?Q?3RkcTC8jTnhtwt3pC1pFIuQhonP6YblhWq4dCHbRxLd0JF0pfCG55kOZ+xAa?=
 =?us-ascii?Q?ja5Ouv+5fmeJEoneYpdGZrop6wXIWTPCcvu5sKWPDzDiGil7PL2zAkBinesb?=
 =?us-ascii?Q?gIX3MCvwmtAakvwRoLE+6AbvS6xLVZbZ/N1l1YWPt7KHD6PD8lDrvGiGk9BE?=
 =?us-ascii?Q?fmiZOPguK8ec4mFO9K6rAVJB+9pv/Y61OeRkALfgdzLiyh+O7/CNsySblnlb?=
 =?us-ascii?Q?xY0HJUdVLJQZy809uWN2gW6a1kdX5jh0zxHCNYP3+llUt9G7Yaeq2chqiUG5?=
 =?us-ascii?Q?kh+nYL/QQvtggBAkLHjyC8t6aOkAWUUW/WOdP7aHgC/7ITIj2DybJ89vfJyd?=
 =?us-ascii?Q?n5UBdoB3IJe1VQPr/M+bOaZl/7GBpt54eyPmFA8WOLbZbIWn7ZENwLWJpgeg?=
 =?us-ascii?Q?KG0dO4eRPWz8hVeTTG5Uk5NWxJicMjtf1Q7ktMAQYTbCINND+vKv77uNarde?=
 =?us-ascii?Q?jcmOu8MCozxTeK1mJ0FwEos1BYlMCLFpRtLlXX90aEJAP9zxwbxQgNzOdaXC?=
 =?us-ascii?Q?j7DefVOklCmgX1RHSaA/cP7485F9cbGC9BbGn8PL5INHvF5E0Z3kxKsneAEa?=
 =?us-ascii?Q?YzkoexCaVUUfUwV5lD4GpoZdIfa+2hibWuqw3UB3ui7ZJzgGAJNGO6TVk+Yh?=
 =?us-ascii?Q?uykm6QOEi73Wk9gj79eTPmQRlqc3BimGXXebIrm4eLxu1rJ38KhXAl3BArue?=
 =?us-ascii?Q?1fdsIA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609092ba-d2ef-449e-522a-08d9af04d716
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:37.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isEvDzf7Lube8aL+cX0RP/6D9I7UampU+L5tBMsKdALLzpoVeVvr+XmrsXPQqX67S+lQ/XTyKGYfQv+p9GSWEvBNt96z4SacAcAHmvyvnHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3894
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: z7t9CwEMuYeXJMjuSqSI1t3h3qX093ON
X-Proofpoint-ORIG-GUID: z7t9CwEMuYeXJMjuSqSI1t3h3qX093ON
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move up the init order so it can be used by the new machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v7: Initial version
v8: Unmodified from v7
---
 drivers/firmware/efi/mokvar-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 38722d2009e2..5ed0602c2f75 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -359,4 +359,4 @@ static int __init efi_mokvar_sysfs_init(void)
 	}
 	return err;
 }
-device_initcall(efi_mokvar_sysfs_init);
+fs_initcall(efi_mokvar_sysfs_init);
-- 
2.18.4

