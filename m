Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02106485C88
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbiAEXvu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43462 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245574AbiAEXvG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:06 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N513Q032380;
        Wed, 5 Jan 2022 23:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=qhaiuoscMrCdKDZ5kfEtc647pOV6jruwyhnlcfy+kxg=;
 b=OpaZ6kufQ3BaPONm9NzSmvspjAoTeF835VO5u442lECPjkRnCFfp8NsUCP320f8Lsu1u
 mFxCfSRR2atINY9zQJZ2inl0T/8Qyc8VThDjIFy8UKSGvdZLaioPXxfGLgcn7MhRLno5
 Xe4ERKYu+Wvyc+AfuzOVaImg95UmI82d3b1MPW9nCPzizeiOp3paAryCNDSTUPym5A0E
 FSGDaxrsEst+xmpwZh7emUnxXJuKs6BlDLcOSnzN0CJrabdjTq+ABBE0rNXbvQ/RVLv9
 JSbHrmo/spJay/LP/xhq5FRfFKeVd50/N30X8oz+NkOBdVS55q4iZSaPQcwawn2KIoVg 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjr228-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjfZ3150022;
        Wed, 5 Jan 2022 23:50:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3ddmqa1j7v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M67h9JTd2dtEsoFj1knCDYNalp6jYBtou2mXYRtYnSQZGVxKC4cQq3ccBMLFGbpQAYgMikbh7ptdEpe6S5VVkakp6VXpxYMUsS3UajfljHKPREHwaQ/hmTAawh4zuoHeEeeyiUbSKYrY0FArr9yvejvGZ8qr1HOvFoNAjtWpLCTqK6OPOulLiDG3N+Zev/f588wUTmBPc2dqHoVWA07qm0rIC3ffyt8vAs4FeqkDOufez/cwdPMXhue5vbYIQA4FZf/dbcL7NawZC5XEIWURlpFYqP4+AEFbbJQ6A7jCeLTKpsqNstmxwa2h4b6XVDFItp45UArNbUFfk+QRFVW7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhaiuoscMrCdKDZ5kfEtc647pOV6jruwyhnlcfy+kxg=;
 b=NYCf4XPU9th/yDFAvLuDSWU4gPplUil4S1awnMevz+pJK8HqN6HQEhRBhR0Uc3DwPA4AtG/AzJucwzRmSTj2H1P2PhE3VhNdrP/p9Xdy0tAxsJaCIq7/EmEkO1P3rQllcA6yP1VRHrGskCA+JpOD7GzEkgpegLudiw4IgPLjEsbvwJRsixXrh5LMgPoASgNGsLrFrmTM1MhP1yZfAEqMi6mriZalz5Deuxg92NSBeff0k3+bllpeTpHthJFNbD9NRy1vkK/GcdxhihiRLF6LxQTiKkS7+JJG0xzGJrGLFqCMQgKjiX0yI/ROfC6FPK3Z9FP5hQRIbighA9CUfa0k6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhaiuoscMrCdKDZ5kfEtc647pOV6jruwyhnlcfy+kxg=;
 b=aSYzXYvls/woRL65AD1lA9NUsQqPFJZbctS2e+bk+4fXDu8A87dWcZWBXFilj2DVrZSskLFN8x24sguA0LwqWgUzQaRRMkkypiar21slfQE4Pat2Inw5EcLoKZRvEDDUmsAjqFsgKoaAs7AY1sB28fYVj+mPHNidN6se/k15bmo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:32 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:32 +0000
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
Subject: [PATCH v9 1/8] integrity: Fix warning about missing prototypes
Date:   Wed,  5 Jan 2022 18:50:05 -0500
Message-Id: <20220105235012.2497118-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81dd07da-55c5-4faa-79c4-08d9d0a628f4
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB50349D28F4F952F4C3CA2941874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5cgA3eYW9AgKOesWTDr4O7uV2S7WwSXX9k/D05H5yNxfpU6cXrlF+YPbzz9k/9Hh1KgK9oVfcjkhikuiUbJZx2HxqU3O1XES0kTyhWCkZ9U/Rgt/EOEUE0NAk4gvVCf8K5cpqgyBDgoDdEwyE507Ox+SkhOiPSgPRwNchYzJ0Hz+BX1RYrr2yjds1iELZqA3C2JALgQflpsL3ejkzgcAObUhLjfzvNYNQ1b1VE1FGFuczMa6Wj2wtTAHx2sUVpH05O119PorRxqlZvWu6z/sL8ThKTEnhs3YCroL6mwKCZ3u4q3CYsIEZqkACoguzJa0vfIkBiA8LuQkRlsk7bjsW2HYXvCh52w/DL5eDg6zSwAtaUCxa9yaERFW+7F+NEPJdjbHrtsIx87C2KvUqm8qGp/NFSCrQ4fgADDdFXpzVcoceZ5a8eI/sONN4H+Eksuk9VGXf54he6LsBzjLaxpRUfMUP0yGwgCEN8ZGsbQRJhzQNrdEaF+6CDSneZosO0D9hZkz2RoJuIjng+U8wYfQ6MEazrZ6uBUfzB1ctuZN/8n2fh3yRpLcOp7fHvUGBLbLuDNP8NJUTISuu7x3p48I/WGhl9nK4+De9J7nS0SAaFdf6qKtL3Bt342YtHB5xGfAyFLxhSjB/ayXPk2dNIpx6rWQpmKlWlyyM/+/9UtfHHlqSPAkr1o5lAf6TtT9LcvjnP3lhCdZDG3znSu/Eb0SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RmgVBnts3JAWLbKkC3CYGYK2Sxgjy4a0Zpfi1n0LaXTcEfsRL0FIrUJFJDc?=
 =?us-ascii?Q?7anfwW0kHjz+fV5ccFU4ovSW3s5vvgMz+SAM19PuLa845wkhGBM55WnQean4?=
 =?us-ascii?Q?AlpHvHcaE4HSb8FMulvg8PxiSvtQABtVzsbvtO7eC+vsel4My1nqSFoT6LXB?=
 =?us-ascii?Q?4Lu9SOE2cgwGU6x9PO2rf0pWIbeMThhDQyVQ0hhwKONgzfRS831P+QrsSGQW?=
 =?us-ascii?Q?9ygPDm4LN6bXR/8ZsHSc5hpJXMYZeN87/1fvSSu+J/oOH8hPxKNo76EbueM3?=
 =?us-ascii?Q?Xyo/EQVmQiBgE64Oh0JBORFcDnBYNet5vurUO1bm7800usnifVnRyXlQLR2t?=
 =?us-ascii?Q?RbcrDqf0fZ4RN6Milt/zryTojPghpAGU2K1U+YB2xAPuDUu/Eba6FpSPAAV5?=
 =?us-ascii?Q?4rvna0ETGFJS4Rx5oDwU4kEwE0373JmJc6sfDJru0VKI4VWzr0v20ZyIPX+o?=
 =?us-ascii?Q?G937zCizAmyBIQS9i6ONxr4QMuU4yHHH3KJuSZS+uyeT0STHtp+ezsSDuZiz?=
 =?us-ascii?Q?dIHYfAcKRRJpcQJzl5siSBt/V09ZB+gB1aC3YBS0dbxt/5aQxB7WFH+JMTu7?=
 =?us-ascii?Q?c7iANYZjAfvW2s3tv6j4isnz63fpwz/MSB23Gas9DjSZhj29kL1AtYePQdAM?=
 =?us-ascii?Q?H9W+/ouT1vsAexshBbch9gCIe7i6qrB9aVFj8iFEgehGmGTqxMnm2eJ3osQ2?=
 =?us-ascii?Q?sWavOL5bZoCrtpvythCnl2cWFN937nfTJEfbXCmR3WEdzslf46rr0ZPxSejM?=
 =?us-ascii?Q?s66QLENBVxHt4gXMrWAd1liGNHj5x1pnGsqfzVB/UyPngTSWW63aU5T/wA//?=
 =?us-ascii?Q?RdoYny+IhFZMKGkOtP1pxgqdj94axQZAdHWrXKLraIVM6IEFekndyKdRLq1D?=
 =?us-ascii?Q?wps4wt8mj1tMwOUeR4fUi/61eQ7WneZs7ksKIlqphUkium59vS0zWXp3TEUH?=
 =?us-ascii?Q?kQbGutvzjH3bYnnzlatU9LqvWmEuXycYtfSItwfj6EYdHOBSbLTFZoeBsyRo?=
 =?us-ascii?Q?pB2tJ5Sg16Tn0s+bYlnXvKnpUf+ndc6clFSlqF5DcM7C0m8VKeU0VFvVLkwb?=
 =?us-ascii?Q?snBNKdiGZnwy1xeJYjhDLTnEuzItZyRIaqzmn3azannLiz5yJ4DOxGTiNCV7?=
 =?us-ascii?Q?ilITescAI09FuwYei6ZUelHTsAs/p9keAOTy3uRQ0DG/hxuysxmdZLAexhBU?=
 =?us-ascii?Q?0ipK81GqjVek3MV7tvCtPS/qHQMhyLJUVzSy2/AoJATB1/6GlKaZ5/hlcHaM?=
 =?us-ascii?Q?kREhe7FLYqevPyZKSGq5vCnFJGi6iUTh48mn1BON0WNJlYO0x0+VGSiA/5Cy?=
 =?us-ascii?Q?ZdF/5I2Bw/qymC/aWJL6f1Uu9+16LfOQ91cB7G6H/gaSz2rlP0VxcwQC4Ub0?=
 =?us-ascii?Q?RqypN6ae5OuFcR8JHf5jqcKjeBr/K1ZlUdVq8fkLOC8CqbxzgKPgVmZR+2fB?=
 =?us-ascii?Q?EUqh51lF4ItlFeuIu4EdRVGnX443ySG3cdSgzJhdExKq40xdSWdgI4s7kPoC?=
 =?us-ascii?Q?xsY9fzrP/sctasvX+Cj9H3K2LV6DSH4KgZgYK2cyzbfpSRHJM/05sLaR/+YC?=
 =?us-ascii?Q?36SEgaMn2DQw7L5DOH5T7Y5PFLbywCpnCcKNSCS0B8AP9+Ozqkfzq0Tn25bO?=
 =?us-ascii?Q?siY8nYyEFtSWOEDPBSkEuIA5UPgNGQ0V4YsRtzXe+t3oG4cfXjzAIm3FJNC6?=
 =?us-ascii?Q?8oarqw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dd07da-55c5-4faa-79c4-08d9d0a628f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:32.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk/jPpS8+6E0vLfstfN9jkUH0b6orpOc/nkcr2q7DIME6H2R5LFyUGoJOhI0SrNeAzEEaygH9rKWjSltlOUXDae8Cwex9N2XDOj/3b+Fn+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-ORIG-GUID: K-YdHiGYpLdAEuftd6HeGCBRoH3JxaGu
X-Proofpoint-GUID: K-YdHiGYpLdAEuftd6HeGCBRoH3JxaGu
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
v9: Unmodified from v8
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

