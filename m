Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D737745B355
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbhKXEqK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63476 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241050AbhKXEqB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO38EDk017970;
        Wed, 24 Nov 2021 04:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1nsmYtI3+4/ks8z9rHRMknYrI/iOwgFypAECJWcFQYs=;
 b=mB1LoDk//YLed4LReUe2wcMMrCiv1XLC2AG0IE1DwhnCUvekgdsEyKV5ls4UchNShbvS
 esC8LejAd50BhMXTMN4QjT8x0jkMB2hzP0Tc8wH5BotnqkaKM1ODKrrDBPMACiHHVDdL
 91fyNrVvDXzKoA6LC0kYhNXnprgke0Y5+mQSk+ziwXo+qkRSeuZEay/A1DjSUJdiG9iP
 qmk4nddo9rwnFx6L919xRWe1p4mpfF+Ri066A5jYkTqh17ppIQ5p/lq2syL2AVyz55lX
 GB1P5+hM+hChSOEixgcOm7g9ZTWGQgn1a4t1gu5UxjXNom1Wc/K0uPkrx1miCU6hLxu2 kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg305dpet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4eeMg036966;
        Wed, 24 Nov 2021 04:42:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3cep50s67j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9tU+E3htlsy6eYjwKvvzKGISmU24Ly5kwT4PrcK1fhm5FQZZmPOhNHgl8pSKVaMPmFrROdKutimfuXXdqWaWTGHdOwk8nb6SS6uY+cLDVUoqasHQJQ5/8OIYEB/MVm0caeUtHuuGruRCDWdtuAwhCHMbRW9k+qrzZBfh0H+ZdvNDZfeFqO4ZYjfB0NdXJvOz8gzGrn7ZVgK3uobbHvN1atx+6iRxRa2kcTqw8ZiewguKNIcvrjwub/gZhtFJenOjE4shCRq3LZTPGbKlc+/Yk4/EZjIhBdAqZqYxBopGnT5kGYoXSu8MpVZmEyPDsh/0olNQvLdKhKketaEdf//2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nsmYtI3+4/ks8z9rHRMknYrI/iOwgFypAECJWcFQYs=;
 b=jLBFRiAROLrQXI/9eB0NabGg6QExpRRYEVj91P+mXt0C+OJZXMH7ja4UrtTlA+1qCqqgCXOKrgCCtUARcD8N9CS4DZep7zetfBLkHMLi1k2ntfv3ABtqBLkdc3Quur1jMx1ML4YFt9+dmGZXXG0ma0zipf6b9uMoeaqb7JDk4skBPWQRLvclMI6GE86JwAG7VYZZ9+4RDNxr6gCHLdi1YGvTgSoxXqodyYFm9WCcxTCKCAiyQeC+7HAONPzhgCCiipdBwtw/1mm84j4XTJJ8HTdKIXvCgTVDlw2AXd7jPatveovjjkqLFAs2DzsekAYguhVZqzvm674ABiUGWe036A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nsmYtI3+4/ks8z9rHRMknYrI/iOwgFypAECJWcFQYs=;
 b=A+7ZXSYJZVwXUg8USOoLL4/5l2CznWfaFI7tWpBduCTBP3An+OzaxJ31JyKJFbfIHP2NV5wwEUjVeF5r5o2hzhD16u1Q4DnvnbbDpovicAM08iyv8Ln+cyyTnXTaLfUhkbyoivr6Nrp2NLNQDF85dTQ97ebiMeervD/KwZA4fEY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:19 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:19 +0000
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
Subject: [PATCH v8 09/17] KEYS: Rename get_builtin_and_secondary_restriction
Date:   Tue, 23 Nov 2021 23:41:16 -0500
Message-Id: <20211124044124.998170-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5634b3-c97f-4614-4fdc-08d9af04cc03
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3957A2B7E1706FE89950568087619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKqAYgvYORb3zKQH35wNbrRRFm8nkKVIdCnBSDq74jYvqVE1qV0RPkIzD309Ozm/mW0loBdrGfse/8W3IVEkVh1kRP9OLQg3FYODm/PGwYAcK7xNhj8vWeXkaVEQJuhmkusOQEHhmf3vPh6gyeHFeX7aft/0VrpC4joBsNL5Cb+ngjhUZGLiei73TQtnwZIaMGlJWBAhCh0d2HUQPFJDPD7VkuMIPheTP1RPqOeG0ECWqMIP7S8UG6vBvBm0/GcBArQ3sU2txNc4aIZfS4CMiG8II4h1J81Sdo97cpSoVteYYKt5g7Us4MYCFWJktNPNQ7ezxKrE9Ehs+2KbYBkX6U5d0L5jnqRqwNfMxAqf5DnQ8UNCWZtI40mkvRhbKKdvMiVR9B90zYuBJ9x2GgsrsfwzE5LB0B+aM76CEB4hZxqFP7qUzxeoeKrpnB8yiJ6A0tmgdaJo7Lx9xJNsnACJftaqWQRZbl0e9yGoQp8/ltCQDa12fs9og/IIGTfeMBX2LUt4TPD57kZh7YTpsfCty+AExOfl/RB1g5+t5k06OGvEKKw1v/5wJFD5UrFrphB9yEswL3cW5P/0GlhxB6z+dTG5KviqE3zC63WoOHuE4b6WuxuBmDLazIrWHifptAa2SSLTzFHspG5OnN5XNamMPg/qjfU1lZNWeR/4ydTGtvn4va+y/CXc1Z010+uZb9mWeTFQmFbQ+UvVDMc7GUk0faSz3pOOzzZskorbeeccA9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6yIPQHfJ+5F98dpFm0nYDCRc47DupPSEFBUpCww5nJZzGWnkFvKBsgumtb3U?=
 =?us-ascii?Q?0ksd/aVfkWNjkkhIQ+L9zYI19F1UbNE2miSUhbQ/tCpcYzkjOAu0RTCr1LjV?=
 =?us-ascii?Q?tBiandRne+hYjBGYO/WXo7fu7n2r5H1Ups3quayBcYnM0MGQNrLGcN7njPNb?=
 =?us-ascii?Q?HZ2VYLWn4B80bcqDSJMHCjwXOMJe4nrd9Yt4tFoRZoQC3royaP1+l3S65ivR?=
 =?us-ascii?Q?4zC9R86i7yt5KpEICsCws0a86T6ihHR4W1bGG6mC4ivqmJuQrhZ7KFhqS5wt?=
 =?us-ascii?Q?vJ7n/z6b2csMMJAHfHwvrrW28iMDOV257HnwlF9KtR11qoCvc8Rsx44Vwez+?=
 =?us-ascii?Q?XcYYl8d9NsxMPz0jp/odKtKrUn8BvCfKaz6AWa6aw3zdM/5lmbMrAtmrEg4l?=
 =?us-ascii?Q?13nOzpjJUTXUAeM+ZRdGkNJ1o2GnvQ87pNvS+1VNYAdVdfq6/ttidc8VhudP?=
 =?us-ascii?Q?MPlqO+usOsRC/yv/7fAAwE0BiHX8pTdzygRAIpfXlyaNalJ6iCB1tWe7WKjd?=
 =?us-ascii?Q?NPdwuOyyavdWiE+ikPDb51PYuSANwbfHsO2VNQ+aJu5uNNjgXB+V54g9ZOFw?=
 =?us-ascii?Q?I4k7jMAXvcOGPGmkbdKJYuXo4tjfX7rQhLdEiek8CWcwEZ+7iRuKxK99zmZM?=
 =?us-ascii?Q?Xnhaw5Qk07Rg40tVMyRp2DqLWzY9l0grpagSrsLDno0hQCwsF81ZbtQWtOMm?=
 =?us-ascii?Q?7D4jZC3MbhkexR/RX5HfGQFqTXHUEJgqf274lTDzAloTifDGpuzFLJkLCDnM?=
 =?us-ascii?Q?dPeYECurCbYsRdo9+YRE3X2qyXjY5yfvJTi2RfQoHoYvC75WFsnLTPemSp1r?=
 =?us-ascii?Q?sW+C7oT/+oaz7+VzhJtD4MZsRbwW+PMU+0GL8hhz5dPa17E70eNsF3WbOkMt?=
 =?us-ascii?Q?shzh9xiwk8HRHiGYMwAh0mTylBc/XMGh83MUDpASPwSY/HKyQ3CVk+scKbNc?=
 =?us-ascii?Q?93BQqVDZEfBFC/aQBbP1SDuaGr5URwZf9CnTh5ML2kXYxUcN2BI0+cv5Hs7y?=
 =?us-ascii?Q?UnSitfZYc3FOFexvFK5zpMc0hKm3JE18xrcCa04utnq1YcFKRx4PdcFZbxWB?=
 =?us-ascii?Q?v9uh+ge9CjCqGQyMcni+GfHBzxflDOAMy0DjrVKaU1J/LKv8UIKxQqzWZM7N?=
 =?us-ascii?Q?O0hALvfP3OlZrKrOYvxXQXIzWT2wsm0PgDiFUWvTBYu+oHJmBGcLIzgQFy/t?=
 =?us-ascii?Q?oqOidR2Lsw+eLiH31yx9Gm7VtISax+O/pGrwJCcGFs6FLNFkO0q8fOXIY/6i?=
 =?us-ascii?Q?9H73RYRkyTzuCa+dBLr2dDHJSoFnZ0VA4tlgU4IAurO90FrEprkL80UgqarO?=
 =?us-ascii?Q?1CU09oBWcd6uaWVnu/1dj49lLDuy5G1b2kr8oPq6zbmeT+VtbwUZw541pNWD?=
 =?us-ascii?Q?D/P1wuZ0LBlQRKhWWMO4NkZpZIPiiUvzLteORtoIQDERpy0N7XV3TVoJhbJn?=
 =?us-ascii?Q?PEHwHLjP8OlbxD9dYkNAmS1f7dtWVpXzkxSqdO/GtsW1PzYMhJASaEjWhqmu?=
 =?us-ascii?Q?LfKbqFTurYQjOUg0CWGWXzkvo7uRdkZ4VL4O2c1Q0CJuZh6kPRcaAyAGfaoS?=
 =?us-ascii?Q?e4ma24y4NlqZDstc1r7bNc1wL1Sk4lWwPLfRIfYEYoZrGlADD/JMU49K9O0e?=
 =?us-ascii?Q?289SY3GK5GPMXSrB/voKNFTsIcwWVDK5ZqR88CLM/PDnHVCeOSEgkWRF0no+?=
 =?us-ascii?Q?JxVNoQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5634b3-c97f-4614-4fdc-08d9af04cc03
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:18.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4QXtEfX+9GjwEYxhnLENSVWTMjZ0cE/aRVXgspyc0diGwhuqgCGIUJX5fs+F4DcxTSibfYQIFtQ+I6NcutkTs5uz1UL+b8PWwOTHqFHeYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: dFrCczW406bMiQDONS-AWpvgFTjvNlWn
X-Proofpoint-ORIG-GUID: dFrCczW406bMiQDONS-AWpvgFTjvNlWn
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for returning either the existing
restrict_link_by_builtin_and_secondary_trusted or the upcoming
restriction that includes the trusted builtin, secondary and
machine keys, to improve clarity, rename
get_builtin_and_secondary_restriction to get_secondary_restriction.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v6: Initial version
v7: Unmodified from v7
v8: Code unmodified from v7, added Mimi's Reviewed-by
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

