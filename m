Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5F451CC1
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbhKPAWN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54662 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351676AbhKPAUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNIfKo009064;
        Tue, 16 Nov 2021 00:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=P6HRZJmVz2XtBtaggcCQYwe9zcoLCReB3FUgmsAhduE=;
 b=UoixeSISNUuhxJ8FXpQ2K38WCsw/0QgvKrf2QPqluSn7rSZh46s1otE6UcJvOI/Ii2lQ
 Z9PMLhQwORj/jR7YyuEl34KCvkjiR/SFYwW0LCEzCmkMZKCbljOr9LAD1Q2oQBoAqYZk
 K+ZP6FqjjSpUNhrO71wFhKJ7Z7/pmN1mTJa13alDpAvhmMqiIk1IWJ3FFJN3pRLWW0HW
 7SLexx0KV1SVpWRbNqdZ89kqmC1A2bR7saJKi+R1/zYdd9qWIGLm7NNDN4WECwnvQoWc
 JhnwWBj0lRK/td8rtrz5yyKoGLz1lvgniX3shIIeATyqjV/iMuPGWVusikHZ0eyvk4Ud Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv7xb3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AxXY046155;
        Tue, 16 Nov 2021 00:16:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3020.oracle.com with ESMTP id 3caq4ru9c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+LnAJ3Yg/qW7RHB/Wmf3+AbkjDRMyst5SdwRLx1dLKcIfKpvpyhpEfrx4Q3qdDzIU0Q3OBTNYVcgObEtXvQPnwmi8BVQD7yStXqDHG369rIVHCJxvQp3mY9UwYJiuzZMKSSYUHzagX2iE/pZIqrI6etdEpXBJ6BXRKy3xHDxqJ1fcqgGwX8GAFRfFw//pCmgzoQASrRyTcVMrSuZwR4mipueHBTQyLA+tG25V02DHovEhJAlMJ9yr/oAvmBM3TWgutb8wu1Q+KbsuK84uwx2VHvuOffa4dZxyD7iFvP90K8hx5v313lgMGu+X3wfyeR6xfl9ucj8bC6OO8PSRa7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6HRZJmVz2XtBtaggcCQYwe9zcoLCReB3FUgmsAhduE=;
 b=iXeDbkD+Z71x/oXNyFUPCJ0gdsfMZA3e73bLYI0eLDfOZCoTwk8os0PUHMHxbbglt8ctnTxOsf81lugKYJU7/XaiqVgwV4+ebQaLbXNz/byq05P156l/XxnI5IXSW9s5+XZIK9vfg8+SYnIFigSVutLVTxuOe8kmBCvLcKZ0ybKM2ioMELtKH5kMwO29bui7oHfNTr4xlQLJN4CQrM/dcl5GH1ykIsSzsKw4y1zPWq8hNgXQJ0ZmkimmZD1Co380pyjxDoQpUH4IrNmdwcfHBk5u4izAh825LEUoNudd5Z+K4ZEYUiTm329xDrp01NNj5kRF0DxYvjetzmokWtWwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6HRZJmVz2XtBtaggcCQYwe9zcoLCReB3FUgmsAhduE=;
 b=gi6amRPkQcUOvywZ8/f7lVzUaTRRX4QTaeEagjSNyg/ll3G7y8WmBzadLKxhJ1ZAKv6pKp6Ikj8uXP/XqFmYVCFutChjtvt5+5uflhdtlH70UwuZSi88/Qc5yEIZoHiscSUeCEpcYC7f2R5jyc86Z735gRsXch3etZ/E8jzdusM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:30 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:30 +0000
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
Subject: [PATCH v7 07/17] integrity: Fix warning about missing prototypes
Date:   Mon, 15 Nov 2021 19:15:35 -0500
Message-Id: <20211116001545.2639333-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de5a1494-57e6-4c71-8e7f-08d9a8965693
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB527639ED3D64B39E5B39EABA87999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:104;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQ1SNUHGvGh0u8yMq92VHoRO0k0dyuHw0XCWbBQavoPNoHOyZUjToIS/Mxxm8A/ueVWVo9wJ7qWm/7RUDetpUTbzpqV9lSTp2PrHMuZd8sXh+4iuaoh+CbExdnN9VUzOZq8okSGHDjjGaB0q49Q8L36t+FPjyU1qgROR0Q1m/Mei3klNl9UgfGjr3XfbJi7gsSutygBIHDXBF93yZNANBKzeNbKUyLC7Rf2JKhAqLvTyNqcegpgGKB5zZ8XqWWIy0wXgCSdbL2cDh6Xm6c+H+/kxDJ62IcjwqPzjIb8jVbO1r+bkzTJLEqtJRYZmno3msmsK2VJZVd2vMU7tOW9EH/8xlkqXHlDXRjHNNMmBPEfHtbvdXaIxFd1zVjx6TwmROyaR1wztkaPZs1ZVK9w8Sik+0TxkG3aVC0gpkFUHdcSbjQZkPXq39BmP/iwb3hvw4raV7CWqzSzz3e5Pszf63K9cw9ZP9ZgNuW34vCPYSe9vs6BAKG36jJWzMczQwUC+uclLCADTH+deFsnYjqYYRqaPvCUZtQAu40KFXEHgRxYrBTEv7ijR89RaLC8MfBv9+Kex79tdbCaGmHr8U7get7UOph4r1aFmJa2HfHoX5ypAF+i/oPQWPIDlbp02SOfyuOIXI0Pm9GcmOg5/xRPZ1UJsuZjRXFzTJKNuFd8w5HGgwKAXeOXWJXLJF1WKwNJQZ/NMar/JkeOrAYr81O1yUFKEbJN4sNg2pOOT4PSDucA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rd0Utxx7FmGCvEB+7HyB+hNZS9RMR83hWkFJBqFhb3y0By3W/ViavU1NlQA+?=
 =?us-ascii?Q?RV8upa+QW68/bUooR9erk4BJZRICZF19c1sjopis9U6gWFQtWtWNLi8ekRnG?=
 =?us-ascii?Q?Xq09h06cl5eYSH4UNB/adI5z+sI73GFzKe15VbWkLU3r3mmRpoOJgsOEHN10?=
 =?us-ascii?Q?T4YGbNgyz+uXZ2Ku8fi6z3CTuPF1ePOERatBlk0ny+dPN8nw8OgyCMo0ilg5?=
 =?us-ascii?Q?qPd41CzjucnpcP9IsDze7gN22d8o//T2AQqwxjKofEC2kQC1PszGud+V+fXm?=
 =?us-ascii?Q?zsI4/pVd4CVVFh0VbM7Af/Ur/nin8OxO/+r1ou1ESObwKY1R0D/Pj5nqOMxo?=
 =?us-ascii?Q?/cVwyjdczm62ddzPOkIAHKfpDWjjzzbC+Bp99jubkIg5mDw4s8iZM1+Nmn51?=
 =?us-ascii?Q?Iemz6AklC5dpdFsUcwnseLmqPhQ+YriZOWGNnYBMYF/pIi1FBmAT3xt0gOBu?=
 =?us-ascii?Q?RmcWffQPFoyJwSmSfbR96Xjhqv2SrL+O/japG/lI3J75mNSPSEaj0tzwFTlQ?=
 =?us-ascii?Q?p18Ec8b1QPiB3Fn3hi8cKP2S2clk4U0SXnwHmbxD/Hw4TtlrMaKQWRVJGQ5Q?=
 =?us-ascii?Q?MaxrNQrjeVvth9eJt8/6VP72RiptUW7GU9CT2Er2T2QfcmhpLtNdWbZNT0+B?=
 =?us-ascii?Q?cfxeLYkdj3XCoH3Op7QvMRrFzrezr+Kwjv9NZHMb+snC/1XeBuHhYCKlmTZM?=
 =?us-ascii?Q?Fd2PKAGWESQ3LwhBONXOKDk3AWSvI84eY5f9N6cliZNOKeA4kLcup2Hcf/JG?=
 =?us-ascii?Q?ATaNO1TMuMrMLJfBc6Y3Jm3XkBT9XwReW3zZY3yPkl2sddimN+XciRQPKHTt?=
 =?us-ascii?Q?jPSokAKtiP7xZAyLheT/CwZBUqnS8exC0lv8k4OxKnT8dWVdZb1wF2D4taaX?=
 =?us-ascii?Q?HxAHPsNRJmA5IfDbc6n3CG6aa11p6VUA37lprG9Q0oMOqLqElxO5JpaHB9Q0?=
 =?us-ascii?Q?DBGDUHFui+VmiXJrqPV2++7dIB7y/40BkWRFpifHWOhQVysA7eBDIdyvXzOr?=
 =?us-ascii?Q?z98YP2gX2ZHbVF2xps0iHN1xQvA0TCLbMJraxzWY73w2sycJXUMSsWvdBChw?=
 =?us-ascii?Q?KIsMT3kvJCeVoLNQoRd1mtsxk1jGpTceMQJh+g9zC9b1I+4W8Rq/0gd8S/Wy?=
 =?us-ascii?Q?gb+ZOCuqo3etbtMs+IK44fHhrWexqOnM9rzNeJew/2X+xrU+cHnaqNu1eW2o?=
 =?us-ascii?Q?8XCR1Zl8lmlfZILCvOBrvUvr2VFL6yl9q8d2M0MA5CbAJEgQ8NdJom0EUoT/?=
 =?us-ascii?Q?HDAdSWj+Z/L9Lvm6iJwP2t2pW83uoGfGUnSpigcNuUHAF7PSehB0Cv6pDyvc?=
 =?us-ascii?Q?aa+1k+bBxrSNz6g8//kaxpZutqpzu6n/JTG/g2TsX3UR5VGr/I4QsEztAkkS?=
 =?us-ascii?Q?bEr/a4oopU9Rj5IzqgcWUwgo7vY+EmsIsD+aJDdwbquiiE1m+JhJ9820z5VK?=
 =?us-ascii?Q?cX8YsYenJK0COXGF9P+FywUvQzLx0njeM+7L8WQl99ZKs47QT1Z5wiDhiSKj?=
 =?us-ascii?Q?XZBxan7l9UVmgpiKVcQii/4H6yEpmCzyuwz9nvmFN2E/Mflh1/Iigo59Euk4?=
 =?us-ascii?Q?8ZaLWK8acGqmHgekIwZLnystXNr3/0hPs2bNRXmIprKXkYQhYCT3QwApaie2?=
 =?us-ascii?Q?N0mXMUgielQG4mjw4H/OePWiH2GMYa/Lk1ApwUdyuSvazqcbZ1FluEKz4qn+?=
 =?us-ascii?Q?3ppuOA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5a1494-57e6-4c71-8e7f-08d9a8965693
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:30.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9UsvDJPoXnVnjb2m/LsSSqXlMRW/pDQY3z/V5ktROeHDzHUioT6WKoedyHiu80VK1wfVpsEv/EwXJVqlwfx1fZSlC/XevHuHJDm5jO+F6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-GUID: DL-y-yc_duGGT_-9F4J_sBscxdWXugOt
X-Proofpoint-ORIG-GUID: DL-y-yc_duGGT_-9F4J_sBscxdWXugOt
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

make W=1 generates the following warning in keyring_handler.c

security/integrity/platform_certs/keyring_handler.c:71:30: warning: no previous prototype for get_handler_for_db [-Wmissing-prototypes]
 __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
                              ^~~~~~~~~~~~~~~~~~
security/integrity/platform_certs/keyring_handler.c:82:30: warning: no previous prototype for get_handler_for_dbx [-Wmissing-prototypes]
 __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type)
                              ^~~~~~~~~~~~~~~~~~~
Add the missing prototypes by including keyring_handler.h.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v7: Initial version
---
 security/integrity/platform_certs/keyring_handler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 5604bd57c990..e9791be98fd9 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -9,6 +9,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
+#include "keyring_handler.h"
 
 static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
 static efi_guid_t efi_cert_x509_sha256_guid __initdata =
-- 
2.18.4

