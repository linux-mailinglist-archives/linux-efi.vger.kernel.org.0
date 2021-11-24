Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69D845B364
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbhKXEqS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:46:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3790 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241093AbhKXEqG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:46:06 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2vhEq017967;
        Wed, 24 Nov 2021 04:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KshTpDO5KzkSzwU6DyhzNW2eanPPaAMXQ0sjS6wGVW0=;
 b=NL2Qv04TUX8HjafHaflvhwXWa+yEIRLniJHlqav94Og31VSOnbuoJLLJchETQ+/K6tU4
 cD56pZGcECzgdmq5WuCyFP/bGXH34400ZZejszFYaXAPi/P3bcEceOgaUs/TljtGzenJ
 asUVjsUgwKpoWklExn2IXlV4QT3V+5l/imHYWxgOSEFM4gsqtT//q4DmqeKmx6yfTPXi
 HGGraYQ5G7C5ybmvKZcSpHKZc0xC3eJMRsw9YtTG4WvQIjgcP0GWL3Uz9tWKhNcZ74p4
 KJGKMwtqjBg6SbBIjvvBCMttpMf6Fvwx/ZRxfzYxAszAhW2JRWXDSUg0VgggTVeVRM4r Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg305dpd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4f4Hr025236;
        Wed, 24 Nov 2021 04:42:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3ceru6am8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZGbOpA/Swi5MNU0nGwfPOK0oJunTaHJTDanDeB+EAbtWpEX8owbZ7j8VYORUq404YB543+AsIkioBYq+us4vX/Z/bvdC4GF0z6x+uI3oyFmCl5hc0MDe6l4WVK6chvlKlnJfzfRjpYjjvH73/ACsXcb/P1wySMPicIabcPWA+P8hCbx6xZECwYlLxOsD4acpkO0R+G9naU86zxWfR5nwB1smxtM4aeZO1aGYo2FRGsi4O+XNbAkM7w0C47bjA8m5jB8ZmUTOTMoMX8XsU248A3xAeuSywUqKEUNGtYpCP2I6X8GbawcZ+7lf86wr7R9zXyhGAcZvknRNucCVa+nSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KshTpDO5KzkSzwU6DyhzNW2eanPPaAMXQ0sjS6wGVW0=;
 b=ZX24CJSGlw6SYIsyjB3tyRcpcK9V2tV58E0ifUmEs+Uc7lI3GJ6JRXteQ3nF9Wb8tVrtjUUwgpz8bmdmb2UbQw7JeQFQKNdjFqj5eJS6eZ6TCqi1PX/EV07eI1CSkx60FYfIsKuk4PEZkZZM4vAQThdzDPAc+pfau8cDSUmqb3+1Efn8xDEEVwHl/4nhpHv+eu8C1mpHBuczwpXVdrgGeFSWo51qmnA1XsG88LmDs0ZeKA7LzasV40IRoPyOTz3B55m4IaBsVZYnyxyAPt79LcIQDKIpc84RAAv/jRQqZ43H0TuiMAFG3+aNaXoL5srWP+P5g7GrspjHq/Iuppe/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KshTpDO5KzkSzwU6DyhzNW2eanPPaAMXQ0sjS6wGVW0=;
 b=T+JUj4R77sIjIlaATQK9qmWaZ68DAcH8fnVW9wgSgzTBbauanzL1H/Q3fJwoNZbMdxXebWYEX4Mbq4gMFtZB9R2FjUH6gIQCn9qgysFjaV2B9abxlw49kLzb3TIzCz+0KgvNjgYijasAidTnWNWBbpi+9aj+7ZgjIBaq+cSvduo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:41:58 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:41:58 +0000
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
Subject: [PATCH v8 02/17] integrity: Fix warning about missing prototypes
Date:   Tue, 23 Nov 2021 23:41:09 -0500
Message-Id: <20211124044124.998170-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:41:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247c203f-72ad-4014-834e-08d9af04bfd4
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB39577C9DFDB332D3C0E9A6F687619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7rcBXg/gm2BQQpREvFVxqMvttaMnrtTPpByYKCO5ixPgHKkcR5iFoFWNBU3jiw9gj1A1Yr+aGV3fHBJdqJk6wl9Vk2fRVYEpEy/uzSvmXhUo7DyAF9sVhaBKebhcvt/wN7OtoCHpkvxcKxDVvciaByomgzBv/Zyq6M+FSRZfW87OF/Jz3YwyuLW/SQTn2ZSAusSWrif9Z0Adi6fbZNTTk2sGomDdqcCFuwqDhwiDdZLDqq4LvKcJR2aMtssmM0ef4vLsYKMu0E+PqBVHKc1feSDGNcB/oHviSm2U3ek7X4nQgDGY7RY0DWbE+QRxRVrkSwA5HBI5bz/4mgxvE3TrjYkGTnhxtiCxV1fCHwHABeZtSgYdsvaB4+++aCHar+Gd1rtgkZ8WWQfx/2QR8j/ifDaIFmeyqfpldUg8EAlGEJZal3qZ76i31K+Ur4NJ+bmBquLxR5/6G8sJhBfNcbt3zLdN3f0sd+DjGnNX3vavmbM/XNSRcxU2L1KDKogFJYhSVW71XFC8XpoizYnQHS5ehQva7UtXmWMGuj5+3gqjPZJoCWuNs4itxE67HvlmLbHMoSsVWldnR/+7184aYbvrNcDgOjj2Z29POkZoZURnU6mTMKjrt3RYIYd+pRqr3w74QfMgnY8Tasno44t0qWSUM1b7lhlb1jOlJ7yhNSdqjGDQb/2qjtSRzm6NAMdwG5hoiJPNf+HmqKYgMdrYTuN2h7KxirX56kbk7V2GYW22l8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8ShooSxg13yg5NjL7CzOVaTKypcTKizbYThKmzcGiG6SSN3YViyOmjEY7gj?=
 =?us-ascii?Q?mrUAwc7lST7nycDE9zGqozXKmambzxITjMAAK6Nmo82mpMyaNspZMGA9c+Qr?=
 =?us-ascii?Q?gmz5isULLkjmFtYqguHcSg8pYB5P4KIqzQCgh5xulPIsVDy6YWOrm6DljJtr?=
 =?us-ascii?Q?cCd3+wylNvlJ7cPHyRfCHD9N60I/yBCEmg6h2eZ2bWDewMSZrgG84qlWH+lB?=
 =?us-ascii?Q?bjUzh4l3Xa4gTfCglRd1jJ6Yd8CqO2+iA+bs0Z7CXC8e5K9aj45RDMDCZN2c?=
 =?us-ascii?Q?4e1xwkK71FoVPIPBEmZfynuboCQ2hMNd2B85cKB3Vh4vh6AjjIITjl3dXely?=
 =?us-ascii?Q?2kCA7gm8FiXU3GQ801aZZRgnwpskmbfCVFDI5wrcWd1iBhvt8dOTr3agYeHU?=
 =?us-ascii?Q?+ts1P6NvhVQsgezIQu2PZDjxBCrx+jPzHqsh4n4ysR4Mys2kzzvUYBfngRRK?=
 =?us-ascii?Q?sK/kFcXSfDS0e3dMpQtLf765ZQFDa6m2pYW5GujbQDGVqBcdZFK4SBySBvNo?=
 =?us-ascii?Q?puIFzCYIcwcfIHPomNAzIlC3r/eT8S7sCoGSeOUibATDCMZXzCve/UNp0maA?=
 =?us-ascii?Q?XtDun/EAOvd/pFLthCPJsgGCvH6Rn0/vSYhCz4SZQRw53S8I4vB72MfX7UJH?=
 =?us-ascii?Q?DkAG8zrJ0n7kaAHspQw4xYGiU5wQbgfErc/mqwILl3pGBNv00rfa0/Ydk7xp?=
 =?us-ascii?Q?fCXwAjEv0bjGI4FcCjkulz7YOQca5qUST1b/HcX3cb2d8zA49Hz2N35C/tV1?=
 =?us-ascii?Q?fohq3rrnAJ5BunRcmurM176waVbcnpxd1MtdTpPHy3lps1A9I6jzjEqfmD1U?=
 =?us-ascii?Q?s4hgV7PzeGbYAAB0LHgQlSZts5XneNPrKfHQLn7Z0EpMWZdcHyrxr0psF0hj?=
 =?us-ascii?Q?W4AhSY/k8eCVOjHGbuQ19j13psEpvTEPlfkR9F23VxmLh1pwZmZU/8L7wjfF?=
 =?us-ascii?Q?qiWKdT9C4xEaC2XXJOYmeb2F9o5c2gmlltDAx2f29qy0wf98GSe1f2flxgzz?=
 =?us-ascii?Q?iY7cqJ64wxhyZolp/FnV9mK1t7gARTY9FexmN7ckm9jXEa7CzyUPNCmihTlZ?=
 =?us-ascii?Q?EtiiEQbjLwI353VtoCKd4A3uR5j1DatrHzEWERGv6xsJIre6YF1hizAunN+A?=
 =?us-ascii?Q?Q1nhg9z20mNsNhJ+s0K5dmLTxvIhTEjxUe7MkXXtSMbVRyl2bEebuJI07vvJ?=
 =?us-ascii?Q?fIaVId817a9Qx1UCqJFYjgCkJSnJzR8XBS1p42gfO5HcsuXikfaHnzWEGUKW?=
 =?us-ascii?Q?NMu3nH1DUppnFRFPwRQ4iUClTfi6UzOhIVbZhyXZlUlo0BwG3eeCYe2mBw9g?=
 =?us-ascii?Q?0dFfllXtlhSTVaCT8HW2Ja+64hs1rzwswkLrdQuuG2jx3qNluAqTHS0rNoA4?=
 =?us-ascii?Q?TKmcsWEwn505/2sROJcl2im/i3WEbTSVkqYhnaWZlxkENwut4jqyxuhtseYk?=
 =?us-ascii?Q?h8HDf3V3xjgRpQ4n9RYK22HYlUKWx7m2RsK2xsUoxFxp8h7cNWZmG+8y8xUJ?=
 =?us-ascii?Q?iTyiv9aYMBF2yyIOCNhMURuRZ1dIa3r8OSTgeczOipokk9zlatdNZSa8Pcc4?=
 =?us-ascii?Q?iFQxsA6dHiO5+FD0craVAfjIszPUbq+XyzhDO3VqAocgUozC9Zw01HK7EnsS?=
 =?us-ascii?Q?ZjfXyiBPcaCUhxOuhsRT7/9oq75brMTbWj80CGF1HvHS9MQLzLdl+gxeIDl+?=
 =?us-ascii?Q?sitnjw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247c203f-72ad-4014-834e-08d9af04bfd4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:41:58.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG8pp3VYm2a+WmMwK5iWxoO+s/Ke4eO9JpKqKxkNT+lBemn4XjruR1HCpJTJEjOFgiaSYlMBUyn/XvsSAtb4nvMf4UCbqI26lQTpt+HoO3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: AZLGD8RpId_qpZ9c8Znpjzy0FRHZJnra
X-Proofpoint-ORIG-GUID: AZLGD8RpId_qpZ9c8Znpjzy0FRHZJnra
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v7: Initial version
v8: Code unmodified from v7 added Mimi's Reviewed-by
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

