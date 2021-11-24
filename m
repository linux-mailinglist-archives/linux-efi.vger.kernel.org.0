Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5013445B336
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbhKXEpq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:45:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234585AbhKXEpp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:45:45 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2xVs1017989;
        Wed, 24 Nov 2021 04:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KLpRB1cGYDUcvbeqsx/XmH1lHNSjBsK6VNGjn/B9LVE=;
 b=PVTg5kRrS+OhXxIuFNvrmTXQNIzTPjivihOhIneWXtFI7KbZyuQPR9S0r9ubBfMnxRt6
 PV+b0+0nVRrv+xPizWCbwxuDhUnP4t6lGETtPvdDEdmf4OJumakgcAzw/hEYe9/6Ju+2
 jsgzVzPHEBp1eP/O+R/oqpO//sNF7dGQfzveyderr2JmFhJRbZ7aB4lt9PkmFO8ZdBLA
 HL5Ijf2CgV6CkVNufLbiqL9FHz8n35VbND1tYfCPM2LaexqJ1R6hgT/mWg1tcoJC94SA
 H1qbyhMrOBowgAjaVIXmanjQJ2tpT5MiExvXD3PauSwg5pWV6ept8atSPhlIQnxExzT6 fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg305dpdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4enQk136963;
        Wed, 24 Nov 2021 04:42:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3ceq2fbuf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiAnJEp1+3T3DKxfmpldtkfRHRkoeAFh9P+oL+ZQiiDA1fBluyoRFXz1b5krDIOtMF+tJC8w8SW2AVF6bBoQWb/CviDApsWhZfoq2w5W0ZC+Aw0QEu39xgYNkw83nQveuWEllPuYhw9kZZY/wGUxotT7fZ4rJpDIrs3ZkVNym/eniP9QjEw+8b135AQAMfxAMEJ36fA5XbhMuHgqEyPEvHhAE+enOV54VQUfdCucICWWNXO3jVSFtpy31O0EJfU6AWU7CE7ACjQYEdq4THBvaWZArTc+XONrWXbB95EHIdJtlTSykpuXsWq4V6r/dJr83f741kbOT8y+jCeHtvWaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLpRB1cGYDUcvbeqsx/XmH1lHNSjBsK6VNGjn/B9LVE=;
 b=m5thF4Yjok1p4v2zFZCDyf+35SG7yAiDwY3xtZxvVLafDwLi0INDJjN2cfHWGvIRVVKUF1LwrFMeG0e2UftPAasA+IfcHJyW1ugxrz0mSnN1XUs3RjjfI7zjW9S4l8iEb3s5R6TKt7/Ei6SnEKRKnSJj96PJjEI8DxZdo5sT7iTXXZs+hs1xgVNb/lAaqkTiP0KHbG4bKcCvASrKYvSorK8OAceFc4VrBd7YcySYvS94W0W+Gh0D6tYp8foyCDcOgd6Wj/KLywcK+IXmVrF0tuLH49Bqn4o9TIg988HINAWMaz3N1kjhelcIJVluTgXYqHAiBNGrpqahqupyTuTGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLpRB1cGYDUcvbeqsx/XmH1lHNSjBsK6VNGjn/B9LVE=;
 b=bqnpWSrd4//OTdhoMuZ48IuSkMaZcMi2fhniWIKOFHpZmxH4SOJlZ1cXD8BOhlM9/iS4p8DAADsSrNTQ9vRGtW6IE6me4pm0f3nSFbWPVtYx1s3qdNVAZwxPuMSyEomDF5ayL0knav3N5MM+Gf+aXfwV5NAzS2BjIopImxfRkBM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:04 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:04 +0000
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
Subject: [PATCH v8 04/17] integrity: Do not allow machine keyring updates following init
Date:   Tue, 23 Nov 2021 23:41:11 -0500
Message-Id: <20211124044124.998170-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bac9187-fa2e-4dfa-8932-08d9af04c30c
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB39570BA9DCADF450075E66FE87619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpzq0qeaI4+St/zdBWfKd2MLhfp9YZN0ZTgzsXTlo4rdjtCuOSBpA8LJMypFFJXFN8x+ubz0WHJXcldhVxXTs9vCoDwpRgHRqec/QsYSTpYI0cN7hacBuqnLtdcHlrgd18TN0inKHuhp5pyXnZYhMrqpPmECq33LJUfHpZlsZzfu87xTscj6F9N36OUea43bhMwGIgbKw9+5VFa4Scq4Edb5ZStrGe0I550TZyNYyFUAbkF42LzmoubKyzSLsbDoDi1DGkvxEp2IE0VqOZcBkINTZDe5NG/ZxY+/I+Nnik+rPqWPe1xlJfRVSDLs+HSa6UyhFIXjd0VDuT80/tK+BKypVg+fj8dCUw+iaSul/vK8XcwXsWr01zo6E8ZUZFZQ3wkjE6CejeOXbUXyroqYVl5YCOTqzIWDkYmA2xWU57H0zfuPmDcHxPTLPbtLVvsBQhWzVOwQ8H5rcvFs4ymMpnln5GG9g1jl7VqQ5tAFZm02mkorqivJbGqnO6YoxZV5/8OX9gsboohi0+3LMWEKeFwAZ187WiCLjfjwMasvMMraHDX69/isQi0Hq5tSIClP1Ys5oHR+nioOx3QooMudFluQqEM6LQnyXEnU0fMLLeAtJcoeRbwAKZbk9lzTVF9o4pFSiENlpJlfcCqsI8nMe5l426a7QBzbvEij11oqnVEJxXEygjsJvZcSlZQvW5dA0Gax0dMHzdFy/Q6U+17c77hRlBOCoSTYQhlX128Fpdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(15650500001)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AlOX9FNJ6ys90aHOl8f/6e2OWD4dCZgbCqWE9En/lSfZmZYxE+txRYJzAIRl?=
 =?us-ascii?Q?M8S+/SIXCYwrkxDw0OJ4hALVBy4glVY2GLgpE29a7HiN2LtUz9Z2c38CcsH7?=
 =?us-ascii?Q?ZjVOlUe0QrOAHU2CJ0GYDygvhfvNK4R+OTGOP+ctSsnb7dEvFetB9GsS4RRM?=
 =?us-ascii?Q?X2hS9wt6+5NI6h7NLUDeHjQuXtbrXrlxaLsmomICpn/d+/7pOkjzH7UUTr4u?=
 =?us-ascii?Q?Pl/U2G7h017ZTGq5gc+HF39r9wv1zo8V1bu1BGxRKh6NdzERtKZ/l1WT2dWI?=
 =?us-ascii?Q?3JJ6+Y4SsNxAC5V8BksiJdJQgiRvMGdtfB9vstTo/HvYNGOUPDC87r8EWFjp?=
 =?us-ascii?Q?MCdMtfg/p2bQXyDjnE0EamcudAAzMKWxN1Vx0a7NBc28dEJJ+KtWQeV/LCyz?=
 =?us-ascii?Q?WeDVJQyyPqPNM/xWt4gXrC8ENxT6iFbKQlwHY99swB91Vfx/qPvcUdJI8rKb?=
 =?us-ascii?Q?nOymA2gluf1G9j8rIAg9cPOqg5gkcDOtwtI4Xou5Lfen3USaMt2praQKR5RR?=
 =?us-ascii?Q?QYcQ8TrvcdfOgn8or4LCDuII9MvGRZcLP4RMDe+rQcUTbD3Fk2DcDTV4Q0r5?=
 =?us-ascii?Q?SE/BKHZNsu2S0ruwVlCOUv9gyq+Lnm2Ba3xlWR30avFF9rDguRtVf9r5/3Xy?=
 =?us-ascii?Q?clpe2KU2nK/v6dANMlNuLA3d0l2ToEJCH+M/xnj/Q6Mo23zbVN5p64gPdxpW?=
 =?us-ascii?Q?7LxYc9ogria0xL0X2Iirg0dwVBwYKeach2OQ96wHN26rhcg4SH5ZmBCi1GEt?=
 =?us-ascii?Q?43HeK8O6OaD3a/re9uluvkfLuo1jQnXTOoblkt01VdWcEYl3JJtYDOiEgxSj?=
 =?us-ascii?Q?MgJ2FrqCGs1c+d0ObP1uozSS+OxQdaXvyTi8TGhCSkSgJv6Bq5KAJcRzIV7R?=
 =?us-ascii?Q?xvpS0I5wej9foV6P3N12Abcc6FTMwJFyaHMnKGRUPJ8VXrNahqdPqXcSXHRH?=
 =?us-ascii?Q?WSETNkKE07mJLBgvhBis46i71IpXp9V4GyS5vpWSs7mR9Tj6vPYevVU7/vcf?=
 =?us-ascii?Q?ALzNUgF1vCcO1Zj2FW+D6tsk/0ozOVlEzb8tJ715AwX+1JDaMRfz7nQ2HYX1?=
 =?us-ascii?Q?7wPRvq0YoDTBYnMLs+qcIaMUtLPp6kXJoIqhSRX+d4rCnhNmhYfR2mXuvPAp?=
 =?us-ascii?Q?xKFhMVlANTdimG1tidTETK58YtGb+LdzpTUTHgvRQo088IrRgdBvBqwS8Zg0?=
 =?us-ascii?Q?JmzvJtPFVfmeTy5GJhr2JmD0KaDeb02Aw7FckQzB973D9KxKLALhLWEBhSXX?=
 =?us-ascii?Q?0jWylA2zIcSQPUwBABxpshev60aqejP/87X8tHffvL+pqssqTrem69g0od1J?=
 =?us-ascii?Q?IFBmUyPyovDW0hQTe5a/cTnm4XeldoVvM5jQdDUCL21SfkBoOxKffYILZyaU?=
 =?us-ascii?Q?Gzl30e2DxoNX3LZ2IM9oSN7JuT2tAEJn38YwViYPTW9dQK/tdeA39egiMzWI?=
 =?us-ascii?Q?v1wKnTQi1IDYh3iTOWM9hntTM8cAKBmBDYr1wZkTlTGlAGIs98Gkx353+ZYb?=
 =?us-ascii?Q?m0mAK1i33qRbeUlW9i2s+gd99lt2pgOGGFN9b8PQFLvxzDr5eokTW2yrDx34?=
 =?us-ascii?Q?J7PR15aBDmkITSGAqFWBhYZnPSieIhOvUh9HK/BMdLmztKFCRZOr/QCY56fw?=
 =?us-ascii?Q?REnEU8N2yxiHNLXno0QpH/XKDKyfbZBuhuwfKSdHvqAnajkCN49UIBoPI3Em?=
 =?us-ascii?Q?dQw9oQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bac9187-fa2e-4dfa-8932-08d9af04c30c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:03.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RIuUa9wdWE/j65m4vio5p/uzND1iHqk1iF9m2acv8Nq/mn3SAnmF2FHpbqexe6fSggm2TauMh3jGPv/SSTD2Ov5QO3axKJlvPTEjANwLi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: Pp4dHcrNsWgZ7Vm1EnoVOb_CInAOmdRT
X-Proofpoint-ORIG-GUID: Pp4dHcrNsWgZ7Vm1EnoVOb_CInAOmdRT
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The machine keyring is setup during init.  No additional keys should be
allowed to be added afterwards.  Leave the permission as read only.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v2: Initial version
v4: Unmodified from v2
v5: Rename to machine keyring
v6: Add additional comment (suggested by Jarkko)
v7: Unmodified from v6
v8: Code unmodified from v7 added Mimi's Reviewed-by
---
 security/integrity/digsig.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 8c315be8ad99..910fe29a5037 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -140,7 +140,13 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
-	perm |= KEY_USR_WRITE;
+
+	/*
+	 * No additional keys shall be allowed to load into the machine
+	 * keyring following init
+	 */
+	if (id != INTEGRITY_KEYRING_MACHINE)
+		perm |= KEY_USR_WRITE;
 
 out:
 	return __integrity_init_keyring(id, perm, restriction);
-- 
2.18.4

