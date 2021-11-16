Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30220451CDC
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbhKPAWY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63642 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245206AbhKPAT5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:19:57 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNPK5j001710;
        Tue, 16 Nov 2021 00:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WKr+L3SiHiLLrIGBrmdwA95NgNMVutskYKzwxhu1iUQ=;
 b=hU3qLNoAgzX6TuWMIZHr+P/nZm+FzYJyCfCNRyfCXuMuROqeOJClOZYMBpUPlOuQf5Fi
 Xo0TJejMSHzDF3aDx1GGbUaEXo5o2tcJpdvSzWojF9ZHCOm5zSjFEKEVB10pVvyTQCE0
 jYX67ezbagXeLemhdp6qyK2ISVZp0Hwjnf6Vgvy9RUpf+EecckxW4ff09vbh1W4wuqzW
 e2Qy8CaMZEsdfkjR7AofFeG0651urVhGXGXwEitLiKU2Ae0kR0iSFqCLj7zv79ioCDWY
 iyXREY/ijTT8dkj1fFO7b1KGjIbxLUpuEuaFsTbKooJN5fYbGfLsQ/PYDDtjPXqzEhmY fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3dww7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0ABPV136170;
        Tue, 16 Nov 2021 00:16:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3030.oracle.com with ESMTP id 3ca2fvcgnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdV6ABhZbL75rFMUglfrtnYRbhjZc9vVgXbfyTkpACs2/KNLsBsfh0kMCrXwKC3i0lf4Sa4o8m0P6ixTHxDyG1bNIzvbVj+ttkeaHKaH3Nzxsn1B3cNjnZeXVcTWNK4h8E8RKQK5FWcNfdkkxcNk7IWP0xOrGG+cSomi86vSRY/n6j2ALY6woDscZK3NEwJvxE0M+COIQlwi4vkE8JN9aQRlUftnvi3ocjduTdl6t+H79ict/P9/zBa9hkiftPXvb2votSrn4g4TQCSl5fqXslCqP6Qeg3ZmkjqoPsUebgdr6TiSoMoNPFFgcNjzz8lKNahvWfoOabGbSfbmsAa3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKr+L3SiHiLLrIGBrmdwA95NgNMVutskYKzwxhu1iUQ=;
 b=aU6krOf5jWFTPbMiuoZYIHT8bswMBI3bkARWfiDz7KjANDV8DCbXazt7tGQUIJ/uzHpCkyP+dr2rjc8cvP+RnyJfJpo9U2k7rEuWTltwdbJM8UIuYgXZwTVC/iJ74IIQ9tWqXeFVvtOKCinsxAEGbNQe42L7XMR3910kTKCUwbgBHt8XhB2W/93VvKX8qszmww3wruuYXq3z4zzVRqmYf48NhId2uxxpOgRi42rNjl8aN096Sf4GtPMfBV55IxZurLT/2+xOKzNH/T3cf5haX791C8dn56C2SyYvuEiPuH5EfjC9lhUFugytstvKEk+N04ITMfbF2Cg4n51TEc+NRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKr+L3SiHiLLrIGBrmdwA95NgNMVutskYKzwxhu1iUQ=;
 b=JMx715oEwE/2EQdVUot0R0XRU+V9CpvZUlg2p3HdD1/zmREnaDyJ6/rBaYy6skvqXFKrlKOUg82/XKbgFPGKkYKBluSuIAHU/tBJa/LRHsjS9MtSqDD3KQHSEXZb0l7zcNvs1dWOyfMKEdq8g3Riid1JNOLOryK37UfgM9IHTm4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:35 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:35 +0000
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
Subject: [PATCH v7 09/17] KEYS: Rename get_builtin_and_secondary_restriction
Date:   Mon, 15 Nov 2021 19:15:37 -0500
Message-Id: <20211116001545.2639333-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2876c05-0526-4e0b-8b03-08d9a89659d4
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB52760DDE24847D2A8B2CC19B87999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gj9sjxWSSdm1U5lmmzJ2CQDePaUAkpHyjx5QEqBiB3Pex8T/ilZIBU/EVv2CQ8xX0tEFuZIGvZsDIyKeqoueix+B6bBlM//+P93zh21OEAH6InWTWwTMZl65FxdiPiX4jS9Yc6oOuqSSF5ZDUGg3Mng3u/Tcknp6I/Z+mXs8FLP33EblEmAggJXoB0EfM0tZ0L5iEp2zxaNq9dc549zUDRHnVd1x2NaSTZr+bFCi+lg98KZwHo2TAEDvueq+hEdUxPI7Di/e/n9k3ovZpbyB70YSqZne5niirl1HT6alNukc+iQuzn9yFA8icoJUYZ4j5bATmYjZIIp6onbpcTEeuN1SiABp1fCJwgTNJauzzSkJ8+w8yuqBxOEYscnBPdw3Cv+CW9d9zPEjwGotEVujL0KI2Ha8NAi+0uaShslMz0sSAG2BBaWyqKHvL2DLih+gD+1FLfn7vqLGUvshGNT/SD2kIvJUyOKziKceamM7bLA5tBPecn8DFf/68I1Is0iiO9vGRIGIxnUhf5bF50v4fOqLVBYZE16+xHTUmTvE8opfYtUNq0X6q2EKPgFogVLyyG4dXa1kNM2M0h/F36oo7333UXF6JntJV056W3utadVERWpL6MuudG8ulQ3kc44ynYzWDx7PNfKrhWVZw6HeEIK5m4dLhgaP3t0t/avXbUkqjxmUBhotwxDCjy/goDD3NhdbstcgcWr8+vtaERTmMVU/9+QQYYE0IYslN7mKv5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?khKLEIA3KrCh2LyGmeT9kL932nOqSlp/mGm0TEtkUrSkYR1tSiEDvK9dWNiY?=
 =?us-ascii?Q?DLeZ4O1j5NfJXn0ckcK+cu65E1AKRw8suQJ4NfYJArDzNEuQqT7Mak5VqSyA?=
 =?us-ascii?Q?q5HoEpxzEskG0p0VCZEdBudodoToCLhZ514LjqntobqY54jm2e6AR5jEXy9V?=
 =?us-ascii?Q?upRL2oKGw4GYbseo8ScX0hXhjUmJPhMSmhYUfie9Azh9odVaRHxvjsbZ5Br1?=
 =?us-ascii?Q?Bge6iOSUOwHnKo4ger5ruD8wH3+q6+IVEEldkfZguEo5An/l8QkEGZpsrwOh?=
 =?us-ascii?Q?qXkxxi+g2pBmLzBbERaN2POZGYGa7q36KrnnHVB2UV+2KxmvuXW+vg7kYxiA?=
 =?us-ascii?Q?rElWeGZ+F6gWdavUUx6xnmw2vi/wa5m8EOJKEwSfO4ZTft//HqD+Ruiox+n4?=
 =?us-ascii?Q?cgnTMFVJS2bwFS+2dozOff2VslGLWKRfdr0gclUaJHrWyFll1sx9hz+JfkaU?=
 =?us-ascii?Q?adVV3avn3c7mjYisKYy59PpWQ+01WPsj0rAOCZMBskgda9WYyN4xQFpAeurS?=
 =?us-ascii?Q?cggU+VK+w1EPzbyItXBFKx8mbHhAcXbl5Mho9V6FdDpfi4Hj6IwzArM9EW1Q?=
 =?us-ascii?Q?2rf/AlB8eq9lEPanBMbbjM6zI0eZKVb8xBXcfZGS7eONysTwQ4jUR0cWhM5m?=
 =?us-ascii?Q?bKS2U0VPlysmQbvPCpY7k/hyFe/I0YgqeV2mrH0KZnZHlqNG6TiNEi5UBclK?=
 =?us-ascii?Q?DmRmO75JVCgjlYMHr2lw/DsNtXfzUGWyY1rXUVRNDTHLArNekHnWcmTZIecM?=
 =?us-ascii?Q?Q7nju7nGCraZ6ZFmq4vOH2C84P+kZKymkRO7ktD/fySmK9LGWZKhuHux1fyG?=
 =?us-ascii?Q?LJQ2L9IiqqFXkIJyxfLVyDCI+IrYYDTPmABbWAvYFOqTcJpjCHCospkDoOc7?=
 =?us-ascii?Q?q1Ix0iTmF6a6CFNK4Sh1mWdiB5agfgdNc4c59kZY8AU8LM2+a0ZtR7yT7J8d?=
 =?us-ascii?Q?7804D3kliFvJm/jyE2l22bZq2zmfbasCmLtseTFhrpliMQBlq2QdBKQtHIbo?=
 =?us-ascii?Q?14UMoLzoxFjzu0jiDBQQJliyLonseWoEujFjg1zdDV6QATsE+E1SEsp8AXTu?=
 =?us-ascii?Q?c+sMnzp6V12MEvhPf53jrhaKufgpOnucXXqQ1pa3FcxKhyC4uGiZLvGdvwQQ?=
 =?us-ascii?Q?LnWs7/LElOLLciPaqLqp0eC5eAbzrWKLNdQPCqXSojCVVjkCU2sAh0qlDCCu?=
 =?us-ascii?Q?syN/xfNwJvtQmTMMYAH79KN/Itfibo2Z/nxdkuWzBKIhiLhwmaT3Ayo2adkA?=
 =?us-ascii?Q?te4ZxI1q+iQUYyx8wNWJeu8dhaIH8uGz2tN6oMUj8JrJQhSU09K3Ckq7pd9h?=
 =?us-ascii?Q?E5gxRYBzrDM6eHSjH47cX3zwS7DdktznhIDkqbzlbf+U/FBjpUgX0FfX4+m4?=
 =?us-ascii?Q?XvrHruvAPc7fms31ri3+UptFyxmdvREqaE39RSiXfbp5Ss4Wm6fH1NgH5Fn5?=
 =?us-ascii?Q?91PzTbM0/8Hu5usunnJ9CELE9ebKBAXdRwJWtU9MncljqLAH2Cnm3qIdrxwF?=
 =?us-ascii?Q?28TREKrmt+3aVEMCdcDV23Xn2Lax5ibDoSH2uCOs6QvngC92oC43L3YQeK5a?=
 =?us-ascii?Q?VCDDsaEsUibueeDY1lVC32/I6Qq6+j5L2jRYx75ph4a/oQUY9jy+NjghcVRT?=
 =?us-ascii?Q?7r8l9kpiGR7sykDc4LfYQRJqFPMlSGniLNQT+OYEKKuP+rfW0Du21+fsUSQm?=
 =?us-ascii?Q?Q4yXdw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2876c05-0526-4e0b-8b03-08d9a89659d4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:35.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YezBITHUXYRv7WtUu+7ozJbW3a650lBuardSHI5ivTgjH0lH70yfR1hdOwuajg9XzT/s9MWmPS+MmRc4mrxvSc4yDs+O3vLNUw3/VXX53+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-GUID: -GqJGGjQYdYiNMLIBKbsOndNyVEdkuGg
X-Proofpoint-ORIG-GUID: -GqJGGjQYdYiNMLIBKbsOndNyVEdkuGg
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To improve clarity, rename get_builtin_and_secondary_restriction to
get_secondary_restriction.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v6: Initial version
v7: Unmodified from v7
---
 certs/system_keyring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..8f1f87579819 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
  */
-static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
+static __init struct key_restriction *get_secondary_restriction(void)
 {
 	struct key_restriction *restriction;
 
@@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(void)
 			       KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
 			       KEY_USR_WRITE),
 			      KEY_ALLOC_NOT_IN_QUOTA,
-			      get_builtin_and_secondary_restriction(),
+			      get_secondary_restriction(),
 			      NULL);
 	if (IS_ERR(secondary_trusted_keys))
 		panic("Can't allocate secondary trusted keyring\n");
-- 
2.18.4

