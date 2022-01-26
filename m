Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28C49C19F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiAZDAO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43288 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236737AbiAZDAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:10 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMn8v7007704;
        Wed, 26 Jan 2022 02:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ySThEHNMp2v6MxARykWra1hpqPfHpaDkvQhWD7hNwfs=;
 b=HSuGnSqmg40lwvLx0UMEcQY1x8hq4C89wX3RNSjBTz9Tn1FgC1YR9h+OrJ6n28ihyTKh
 pcP3E3/WMA14C196kYTbcTVrGOtwP7oGWLhBfLrQUFXlz5yZIqhxua0hrNToiJOLbCfm
 aRezL46DT1Hb6OaXLLhLQ2MsxUlPnMpyl+OUOHr+H7ryryrnR3eGNAKgbG5u1/qIkpfk
 3uBy6E8nO+qGxDYtJ0G7AQrIDfdk0c/m8na3Md76jRCmBr9f5O61uLGNVgTnzTtqUxMS
 0Yfk6zk0PRGs2eAoKgOh5sS4t+5kP81wNcx4iHuyfq0jwSD9fgZXAtjZG8P+rU6TL3VW Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s4x6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oS7e068311;
        Wed, 26 Jan 2022 02:59:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3drbcq7v4f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTtGTLQQVrGuPkfSYfg2iHvPcaKghJzv2Poba65MTp5Ks9SDQq9bcnhykVSphO0Gks6aXGp/9tUt+2GGzJo/TYOghhJVADa3Djk6XggtpAXkPT5EoIE8y6PD02EM2bgD7IxV88UnuxJz2FQ0JBIXZNqzJCL/OfpRC69XWSOjAZygpytmh2xuqxRR0wwYqDiWyFvtpu4iTuhoR4p/MP/2oAjlKMN4FrgIyRx3cgTpuiK6mEVoY17yx8e9Nt4ipl6Jo8/1zcqGsmb/sVTJINcOPgD4KglvRDWwanwvYLecCVuyYUNe4JXHjo29C70lN3TZwOkNNXiLGRAmzOhWnmYu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySThEHNMp2v6MxARykWra1hpqPfHpaDkvQhWD7hNwfs=;
 b=ZEoeHKeYntpMjvtSHcA4kvtP35Lv4igomDAq1gYS+LQ38rORYo/jc6aFGF9Pio3cz4T4WwJHIcxJnDSWyfB445KSBqfHmQ0hrHGpCeBX+CZTgeV8TLnB8nXgllATYmL7ZUl/5+QXlzt+Kynj3/2wHdrSTmbNtBFQ5Mc7TYK1oYqflYxpYA1OwG6rD9kPrpGygCfyHKVOex20dH0ebnI6fGt2wwGgtow4pTiX4flQT6e0UOu6/AxU8xtQnaX3zYQDCE0RHNtDTZDPNc1JwEDupD5vO/Gvs/6TloFuTbiqP2DpMRgTBQd67hA3tvhjwWgZyIeRLQMeOlY99jkdL2sEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySThEHNMp2v6MxARykWra1hpqPfHpaDkvQhWD7hNwfs=;
 b=Zl9qqmHOHtBhzSUH4h6F4IX+lzOCjGrYEtDo2LH2H/IqaBOnzbDVObcB/ucRTTDRKv9R0J/XWg6YABzhtIgQ9NvPgQLlrocEjy6KpMhRMeu7d1hJmVyvf8rTrgWNPnHla6x4p9UwGH3HeghntiF3U1fFdOOaOLFQjmV/FIyR3yU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:31 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:30 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        nayna@linux.ibm.com, zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v10 1/8] integrity: Fix warning about missing prototypes
Date:   Tue, 25 Jan 2022 21:58:27 -0500
Message-Id: <20220126025834.255493-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08cd10c9-d6aa-4a58-13bb-08d9e077dfa9
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46544F2B5815E814EC3FA95C87209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +V+mS8Tj5nkXyYzXIyPnUN/Y8vYv6oGTI98iyHkSQSyej4vUbOfcmnaspLhS8nFy+kYNF4FiQ4wf1OJhrFeQLthLDoBNsU6W1Fhq7af+j6r6LtO+ryojcpgVnfRVsy2okEUbmQqhIYeQRIZAsXFr45MCJpRryRk/ZwyNSpNyzrEL+iFTH4xWe88XM55HYE10+u9Fh1yc7sArfYfjEpnCylj0hzu5Ez6SkOt6QlCbYrY/QlLiPj+vpbKr9wAdXsqzkM0NsCnG7cK7Lz8vcOVQ46c0lsfP478XqwosgdzFxKZmb6DQ2ylRqPMZowIFUwrdAiJy6D8IqYLH+1ZH7TdUxnvS8cgA6NlBEvHdsbWNvCo+Gx3Ols35lhsatY00EqXoiPm0tDpnQxPo9ymtAlru4jb1gTW+hmkG3jox1TaxTfvgDHHahVpeU+duyGCcj49tAHkxBsJBpY3YwIvcpcg1+fOILpCPbedVdCHZo8UvSMLzNAShECw8MBeGsPT0mOmCplKErNp7Qu6hydlW8AMlGlPQlEnLNhteERwQBemvZhkf10p6iQII4PoS8bPv6IuLX/OfG8QoC2I/tWSIaH33pQKMZ6k0ZaWPTUcwJEb6A0k9/IZdH7IfVQoTQHe31XT/jauVk6QXzIdf6vHlcJKB19tfu0A0e9NOh7Fo6gFiEH82uKsTs68BTVPpATk8wQPEs0zSaQLJzZsxiTkKrvJjNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IU1WcfUI26qjaHjShCOIlKTbks1uUHQZwLyCRp/daHQyDKIkGOhgeEWy7//h?=
 =?us-ascii?Q?aPT7cuSSreB/ACHoFuYoQVuFsphpoEuQt2MeRMBoe1psWgxaSm0neVhZ9FIN?=
 =?us-ascii?Q?XOahRGNzCBqgaQQVLQSW20sJm5boVQ2OncPM26+UrUQeIK5daGmD3ilfngm1?=
 =?us-ascii?Q?XaBlDCDqhz3E6dom1EaUuEwZSoGqavHaYZXtXNJI5Dy7NxkgT6eezSmMKY/A?=
 =?us-ascii?Q?16UHn//b3wrY3B1W34EVG1XjllPZkKQTUNqfoXGUvThRS7sOIDv/8mDY9NVK?=
 =?us-ascii?Q?LaZQ+5iEukVh3QZJ9WXI8gNVa64VJJYwxPopO7rwaQbDqyPP0m/5YpgI6PqY?=
 =?us-ascii?Q?LWbhiuBB1Nu/DE6+vbR8RYxfgZe2xWPYQZZyNAHNOZ3zQFyqDM1q6pt3Xy4V?=
 =?us-ascii?Q?XINJ1r2eFz3+Cff4HaSfs4b7kdrt2GViLx49Ln/VAlef4NlOW4+0IPyxXOMb?=
 =?us-ascii?Q?SqYe0WPoQs3zIxoxTv2u4IeZb3vW+G6M2LSIp7lr+azAHykV52MKS6YtmhF6?=
 =?us-ascii?Q?buYDU7tPP2Gqh0NjqYDeGaRVvdH+Pp76OqVKd7DzJgCJABhFmWAnxIhZhQIr?=
 =?us-ascii?Q?EgcBegZvtM2KFaLJHA/gyVX1Lu7F/FbbtsDvOVNggxaKZ4SxKV/3N/WGT8w2?=
 =?us-ascii?Q?EXUME/ToUkdVM+ol5Ny2DmlU7Wtw9NiA1berg3voRT4B45m0ebilnkfpXCG4?=
 =?us-ascii?Q?QUwesB/31ISj3n8JTxS8yYldtqClwN893AH78gbvliYkBb2ueLNHsRz7Je+p?=
 =?us-ascii?Q?NkYMPWYk552bL8sSLvYVUpSxW4R3YJadx351Yd50uOEZlU70l7ctpzO8HRDz?=
 =?us-ascii?Q?UB5iWxsk5sJQ3YEUL/E4YXerCj4ag7m913GtboSwGF1aW34WXqeMDJsZIv4K?=
 =?us-ascii?Q?Le8HkStpD72JYPlgrOhbOEpS8UcUib+1tugsRMJjOGsXGp1rtoFI+b9ck8gy?=
 =?us-ascii?Q?umfX/aocxmT9ZnqMgNk88B2g3V4T3GsYNp5ojpahlx8F+9Vbo2dUtB5SBi1V?=
 =?us-ascii?Q?i3W0xSKB5TAJl+WUsJgp5IPrWnOv1VuM/vmpv8nvUkMCJD7zlARkKpusVUzU?=
 =?us-ascii?Q?v3RLlHiHpDnx2RRDmA6T2tYb+X6L9Dj1NASpPaVYICrYNEJNIcgf/9mQvm6m?=
 =?us-ascii?Q?7OglzS5FwMbdm5lzaA46sh7lSfeE5LNVFyMjlw7ynmKRMbwFXAEs9EmmJqb1?=
 =?us-ascii?Q?lk/19Ds0mSEVaV4mVveU11nfLnz4iX8jzQvUfiIbp31WW621SBWBtf9y54+4?=
 =?us-ascii?Q?xhIjh+9+LrDD1EiTVzDts3ym50FNFO2J36700iB/BSXYfRcWNdczVwAo+Pe7?=
 =?us-ascii?Q?m4uUUGi0J7wxTtWyWi3CiruegnEu+O2UNtts5SIXx/JKkHchJcbZYlkD3/CB?=
 =?us-ascii?Q?ZQnjt34tIzZflCrLXLwGl9yQfgH2ANej8bQfA6ixFulNMeFmqXxpUhIq53Nw?=
 =?us-ascii?Q?0tEY+2sdhB8RgJ7m6ZS4dU4M4XJ+Qt0p7kgtcwlXvU+aYz5T//TfwPKE7Lfz?=
 =?us-ascii?Q?nxrtCQVi6wUBBlp1EH69un7B+P4gch+w78Em6pKE452Jdfr3WxuXoOEx/Ix7?=
 =?us-ascii?Q?pyOAckSgoNjErmb5HdCJJu8Pe98VcG0H2aZGWu9oSh+tLs6QSubWL2Ch223f?=
 =?us-ascii?Q?aYDl2h5gPWmFM5tkzNfc0qBL4MjczM3u1fUvWsV7Js3Yg8jBXJ7qtz84Mvuw?=
 =?us-ascii?Q?rivylRjJBswaUerUyMPcn/FLJks=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cd10c9-d6aa-4a58-13bb-08d9e077dfa9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:30.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXNqFCYYy0+y7xgRuhp019KeHM2MlsaGN/z6HpX2hNxtcCwvMC1HFCnmOnR0gxiRtrehVZLczdpglEYhc58z9P4FdXZjkBb3THAlO8J9eck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260011
X-Proofpoint-GUID: 9-1jgdk0ZwmpPJlMv9N7xxvqOWdiKQrs
X-Proofpoint-ORIG-GUID: 9-1jgdk0ZwmpPJlMv9N7xxvqOWdiKQrs
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
v7: Initial version
v8: Code unmodified from v7 added Mimi's Reviewed-by
v9: Unmodified from v8
v10: Added Jarkko's Reviewed-by and Mimi's Tested-by
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

