Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0272845B379
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbhKXEqE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62652 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241047AbhKXEqA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2xVsH017989;
        Wed, 24 Nov 2021 04:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=snr3xQmzBk/LUQDKPkNtwD8VZ8jb68osOi5mIh434bw=;
 b=Y6Bmo9/kLsKwdqIQQvfzbckRh7sK8I+5Heevt8bauv0RdIzntZBfQxeXeBSRWvKK8gG1
 PPhGyeEdZ82FguXSI4GnHdWLQXZD7KLi0mf3K8FtYjW8o70Z73Uz9X8p7Zozk4tIIVqu
 G395h6OVNgVe2/ksRAKbn2YFCZjmybHrBr9azFYk2bu42lbmIeNuBOsbxg9NXHJG4Wqo
 eyvGujxsVDbDeil4YIYlvprHzUO2ZOG0f02kestnwi5KjvZbB//7JsKSI3Y91G2K5knh
 Xc6Auwr9tGT7q9gvPEYghRcRCBgEUJFMLKNdzY6ow9XO61sGWoWJdUaoM36OF8q7Ox04 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg305dpfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4epXH137205;
        Wed, 24 Nov 2021 04:42:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3ceq2fbuq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+WLdDMpTkU3nTv3+ILTQJg1dw3elRxTJRSEbfv6MUnCGePAjdF8NmGamBD55Xp6ZVFSz2k3GxzfIyX5IGcMQmAPNkdemOI4LxweI/As3Y5IlRL8CMtp2OaMOeES0w0eErUYXBTaMXHYXZWZzH9z7x9s4D6RAj7Wmz2WjLrFp5PC5rTGOm31Qip7r60WFvuzF1Y/MFz1aYl+7hEnNwBbBmUPeVE5I/4pZIcB6IJBqyEUqUnillSMrDRBTGSTtxLLvVj86uG0EYBaPjVsNokAGCW/QUy1wOb/H5o5U82o5QSlgaPXNPX04bigr+TdvV0QUfyTD/H2/DbX7bcX3mXrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snr3xQmzBk/LUQDKPkNtwD8VZ8jb68osOi5mIh434bw=;
 b=EQzF/6RipB9QC0i/EzKXFb/oc+dDYoMO73X4/+Ww2qrniZjpe0M7DWc8EPDadqWqxHRquYml24s0gl2G5nSherWrj4oQWA2TksLtIFYH6A55W+aGBUsfyNsxCUk1Lz+zmEjREHFn20KSgH/yhJXJZesgDND4BMKHw3UNMNdowHmwL3BvsQqKeO3WQD8LCDi4rNYdluuapzbER4QP7pgurwEaqF8axONmC75FZdw31Lz2EAhd9lmCQMKFMFdyRkzlJWYv0XBCqDfndrD6QtghZ57O4AZ2Oc2X5OC6psHD0QBcMSz1/Q32JHIObwQWBs2UNTi7IcQWasPtYZYv+ck6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snr3xQmzBk/LUQDKPkNtwD8VZ8jb68osOi5mIh434bw=;
 b=KUML0XwllLW9x5jQOeK9lwDCioUBqrVgn67pw3zh902f/deFlfjFEIMikh42SOAzIgPprqd3ir+zdhs3yfMCHulWWoz5kzD516NlOLsqkWnzEafpbhZoqsEZUfelcr+XzeKecDe3NYZ0+aRrw6/842BnIBnktxnWGtLH2Uip/T4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3894.namprd10.prod.outlook.com (2603:10b6:610:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 04:42:31 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:31 +0000
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
Subject: [PATCH v8 13/17] integrity: store reference to machine keyring
Date:   Tue, 23 Nov 2021 23:41:20 -0500
Message-Id: <20211124044124.998170-14-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeae2ddc-3305-47af-e0fe-08d9af04d32a
X-MS-TrafficTypeDiagnostic: CH2PR10MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3894D7C216E8683FE6826CC287619@CH2PR10MB3894.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lUtTBeMJdOvdWoaHnVEJ4y45kHu1fBZgZZhAsUR2VgxrXamj8uKEcI7vYnOWaw3AzT79n78AIAd4HA1lIihpEl6pYxY4viIU570mqKdmvzfd9OIj4pOg4iqNDemBpPOo3cP8dTYwIP/0OOCiYFM51PYJ/Xq8/Mcrfw2NEAX3PpXsq+iBH1ctfCFPSWrSuQ3Yuz/jPmuvSvpjOwC+7NdNkr7M8E+oQHph9KdaKxUmefYGKi8PQgthTlbBOGId9OLWfQ58vmQp92lozJdPtY7GKjPyy25qeyiybhjm86PEyeFzrB/42DcSmaJRNqO2kXV7YODv3PyyQUmfeW56ORPxxCltFjqi32sWSJNy3c6N64n5aCukyZaEImcHl+eA0MjwdLp2lQR0zVAKKOyn2nmxI6illV9Bd/bAcVOD2yN30qlLPWAp8UE9Ph2akwUO+SuyQ+RFAL0pdwuShQMyDXPaRz47uETD1Nq0gvUqqB54TUmjnc4asC3qvT1AlmgfgBeU+730CO/rNS6MmFABh4e5QgwekfxhmkJSNVHuzPrQ1O8I3MmFhzNX8CTrTlkCTyzlDkvK0Zzj74P9hohP5GeCmMCBQdYa6PYhZYFdA+iiSbDuRdy3B7wOcBjnoRowfveFJLA8tZXEbpJCx9LVWg0kwBxQi2Kzq+wOqZSW42mPd0I55EA3VgC/JjtmCuAC3AAvf8lsXN6MrssrQyPwmaQAS9e3FcFiveZ1j6ewJb1qOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(921005)(36756003)(86362001)(83380400001)(508600001)(5660300002)(4326008)(2616005)(6486002)(186003)(7696005)(44832011)(26005)(4744005)(8936002)(66946007)(52116002)(8676002)(7416002)(2906002)(66556008)(66476007)(316002)(107886003)(38350700002)(38100700002)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdH5e+nvujvRQ/r69X8tfxVl9LUZOVYmgtZeJTWt3gYAiCIjW8jf7IPd3yH2?=
 =?us-ascii?Q?IZ5Cguinb8ne3NHbKY/U7P+kiFL/vXLwOTdKuYUvAC4XrEfoBx0L5ezw5MTQ?=
 =?us-ascii?Q?G+aJVtcjyOqvbXLAs/mZ5LuOYOLYqBuviJjE0wbNh/re4Mdq3/DYDbCf6fAP?=
 =?us-ascii?Q?3RkdalwomaDFtKOITvPgJjXhOaqfCpwGx1EmLuoaZ0Y9ABQ6ZfZiB7yH2D6u?=
 =?us-ascii?Q?OHypitawUztkGzo7oe9uWN6tFZAjN13fHn3DBBgfkGQ01MR59IeIQ+aK0xRe?=
 =?us-ascii?Q?Oipx7RA1Oy3uk9xEp9ppF6/YF7jDyBTulobImzWpuo4I6Ms3SnmrmBoDYPzD?=
 =?us-ascii?Q?p5nyGu7APmYK9VEWEE5WUtjIZL/lDuiAxvvLvyK5wjTJKeyHZ/gsOHtTXxT3?=
 =?us-ascii?Q?Xfn18o2Zh+H6AADE/J8D5hkoOgANK0Pk6+hCvt9wy59r+E7+3faUn+4wJvN3?=
 =?us-ascii?Q?g+gvuFXDvWWoWbnIUZFxvdnKY0j15y/G5iWky+QeMGgleH0tFPEB3JoLdEJ5?=
 =?us-ascii?Q?BulWvKgaZmwwfenvyvSoONdmN8XfdD5iTOT58l04VZ+tBn4JjAd5MiIWZMHn?=
 =?us-ascii?Q?8K7i3U+9/iKsEcExymiLk3I5mCfwJGQo1RWBVAnbcNuw196X0z7bjPnYB7tg?=
 =?us-ascii?Q?rRYrSlA4r3G4fhB991ZUCJkogyqr7CkKXryGvH6Kt43U+Z4luRetMzLlxNwz?=
 =?us-ascii?Q?qDe8/zJ5cb+oR9oLTqMAYV//JtHc4ynW0EstZGCv7+0QtnhJWuZaR6N4sCBZ?=
 =?us-ascii?Q?LOha3r8gYEt4HPggn3Tz0aDeI1ngW4KVbWqLNOT6RuadKhcx/WuWyn9W9px+?=
 =?us-ascii?Q?cpr2sEWxsJen9q5BoHr3gVylJ/2ZT2w1tlc87tNL66VCC8Yfm69Cjm9h4sCW?=
 =?us-ascii?Q?00gdSSUJn76al9OMtM/o2Lf9z+ZCKyM7qe1LpHvj9GtPv8lVcv1gGnPoSVzg?=
 =?us-ascii?Q?4Bj+ZYwP2WIm98oYVpKGRUhgJvCU0umK2HUimDlUUy9UNz/qm7/CuRZVkO/J?=
 =?us-ascii?Q?/0VQ7D7PfLJ9exUOSZy33yM0s+ceozTPXQCnOo15y2jx2xYG0kLZt5PidOp+?=
 =?us-ascii?Q?oRmHN/RcNDBFhKIWuP1ErThjAiI1hwJH0qPpnghR8OQZLDJCSql5JX17Wk5z?=
 =?us-ascii?Q?oBeksFxWXvfpuKGn9L6wj/wsL882WxfAsTw9dDmJsLWO6nVVxbPhpn3pdYUS?=
 =?us-ascii?Q?aNojo0d02llHuaVWvW87CcvAfNNDru7UyRNr1+8zWulh/mUc/DqIUTJLSk39?=
 =?us-ascii?Q?l2rWWgKybZIVHUjVJPEMw6T+KafqyKKs9u5nxQ6cuzoiZ1S/WBo/+PxTeNz2?=
 =?us-ascii?Q?noCLcYCOCu6mOYXIaDCcDkms3JUYsHU/EzVyA7gWQrAZQBWVEZsx7b/jiLdF?=
 =?us-ascii?Q?p/+BMB4oQxboohFV3Dda/R3gv1RS/ufIdojoa2m3i1o9Mij/psEpdgmM5DBV?=
 =?us-ascii?Q?9qwaWfIzze7qsSRyW6knoDj3i89+qUzL4HuOX5ctKop/srPARXF9duOJsD+X?=
 =?us-ascii?Q?4XfZ4lUSh0j0kX96BxNlAB5ziTE91+F+aw1pE8wCWMrNhciwldcLW82tmQaL?=
 =?us-ascii?Q?Se9BK3rS7XZEpJooawyXAKuwJMIcomlReCwwYV+AanrW68Kih4dSfMvp1z/r?=
 =?us-ascii?Q?5C9bF5ethmemiANrBZMcq168BqrUYKIgB2Dm3PVDvb/rue3vv7obMfVo1/uK?=
 =?us-ascii?Q?tw6Vgg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeae2ddc-3305-47af-e0fe-08d9af04d32a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:30.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eXKT+VMeKg6mHKKEAw5a+KYVcVjeNWqgwY1IYe1jd3LfSl8gxhAwDQMFGkJkn8vR4AXYVLI8PZpxueUXiQQhDl6JtstqY0N0WO0U3KzWp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3894
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: e_C2tgCCP4sucOPTNTG3ZMkfvyqRIxN0
X-Proofpoint-ORIG-GUID: e_C2tgCCP4sucOPTNTG3ZMkfvyqRIxN0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Store a reference to the machine keyring in system keyring code. The
system keyring code needs this to complete the keyring link to
to machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: Unmodified from v2
v4: Removed trust_moklist check
v5: Rename to machine keyring
v8: Unmodified from v5
---
 security/integrity/digsig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 74f73f7cc4fe..109b58840d45 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,6 +116,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MACHINE)
+			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4

