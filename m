Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2649C185
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiAZDAF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31056 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236678AbiAZDAE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:04 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMmuYU004077;
        Wed, 26 Jan 2022 02:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WlMV3zJ+rcIZiUVrqyeKB9w02g4pno5zMkV7P4j/tso=;
 b=Lf2WRvVptJiA6OkxUc1sizVetG/RVabUCSVqXUkopo3HDsdZlO2a65a79nbRh591HQvJ
 RqGvIQ3Que4c8drM5sol5in7M+JMgHuc0dbXeQxocYPQs7GbEg4BD4wiUPnq05J5ipur
 pU0GyZt2z3XJiTmJTNoaYs/42EcI1tpl7/YoULhkMANnkkr1OCt5NKYgeSW1Fj6Dr4Vc
 IR394o1jOmOetT1rKh09QFpo2SE4liID4PvHGvT2HTgAwTHQ0jOJDWeOpyf9iGyDT/20
 BbcDGNpz6c4nqIoj1tehza+scjE0HPMGQJHIlTcDV0r1fLMnFPDN8MoOayta19cEcave xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaad0y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oxIE079584;
        Wed, 26 Jan 2022 02:59:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by userp3030.oracle.com with ESMTP id 3dr720979h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmZR0e0Cl9JAsxjhBHYAlkRScAjZ+6EjyHJcLaasrfkvpO5ueqGfCrbYAaKBgvMDnSC1r5ryys3qXy3W+7o/OA67YAY5UqxfP2c5t4QCtfs4+eRod7hkG4zT7RiyMDh8pWzDcJF4KMLoyxndo4ElPlCoFRVRijYIgF9svyVKTOq4xQz99RzpLQhndF5FPQKyzj8izNOKKQQXSelgMNk5tbm1rOfyhyKPnb4Y6GBCqL7wxd1BVdwHEKpbeogr0DMjr9VwuS2e4b5vV2DyJULtS0Ejj1W30PTj7otMfJC2TOOFjLVqgONkzhLgMZgeWhpbqDujHumrFpck9MEOw0czgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlMV3zJ+rcIZiUVrqyeKB9w02g4pno5zMkV7P4j/tso=;
 b=nLVxZvCexDOzWEFc041GuL2OItIaCJMHJl760qNdsyTmlTPyMxN7xAnB9aYt19KSv6612aGdtG9T2V7BtB7oomRSw516CZSqUyX8Rrjxfg4D+azag1MJd27lfu5ye8PjhcBWbHBmY4f/0bPsz3PI7hy3T03cea8o282AU2bxnnPTNGWKaRSwchn6qoBrfC8+lRBNMGzDkuh+/ZuMZGx1wX+oxWAb2PSgG0kTxDgCk5+fEUQJ+XQyfOmELrdkZyBejVItYA/9xqt1EaY5PlQcbocz4mPCN6Z0qIcFBoj/WBE+9D75qe0DtgsOVxfSBVZ57/UtNFNDvLyXhtR8wu0Ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlMV3zJ+rcIZiUVrqyeKB9w02g4pno5zMkV7P4j/tso=;
 b=LD16EUnYaIhdnFzmHQNw2Rrxy7n6g7Ay2PCm2kjf56+SfYkpIBjTiEREcWYD0k6gDRZJsHE1B1Lr3db3uL9B20BFBR40dh+le4lJDwoXAhpVXgSgkesgKHNPXoj9E0m3bW+/Jbu2OyOQg0xWH0jDb7AVHNlEjpZWrw2SnWNgPlo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:41 +0000
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
Subject: [PATCH v10 6/8] efi/mokvar: move up init order
Date:   Tue, 25 Jan 2022 21:58:32 -0500
Message-Id: <20220126025834.255493-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b85217f2-6306-415e-2ed3-08d9e077e5d4
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4654158325C996B00F5CB56E87209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qSjIM1vFo1aogTBdTWigjsS2x+4ZSI3OPp0wiDyU3UVCxUMWua4J24VyFmFcLkG1Sn5DygeJ4fELMxrcjVPVfMWl5dM2qPT3b1n2NUmWtxDp7p9QrSox4yfCiz7usrmnFojxwFwYVFYfK8iLglF/4yWJBXBTSgFAvXCtVxGPr+ksr4IzHG6IhFQyGedSlktcU0RZXQaMUlI1sRXuPcGp6+pe4NANm6DEBZcIH/JKVwFAmmeP+jVH747n6zzVQlDo9sg4dnBENgoTfj54ROO14qA/LJArhmqT4Y5upUcfvfGd7MW2tL7frp6kPswhoD1t/lOBWH73gnq0lu7a6u+1SD1skhEOCgpvZ6qrxgLQAXXbwwJRMt1LizDsQcbZg0KMfj1p1QN+xHpjuJNldEf1DboollIlfkBxg9INNFpSN92IIqU0euXAaWLH5Ua5ky52FaihRwbDmJhZvrX5pX6S67uR7XJwfr1QhvmMLoYFeqJ6eCTGvf0XnxUYkHedOXEn4lUFDtEo5BEBkaGxqsWhVDhKIoIy5azhOdCztp5s4ec4WvcD8wNAccSnnTgM6fJ9oxuKO+F0T2F/dSDN1ZTaP0lAiK6NLxsTdebKXF+bRwzyYu8FvZDQ6FnTRYSwoBu50m6Lu9d5VnLMFL0uUUF9L0b1pDEYSZ2xEE2cfDj6i5i5AdWNW/TcBiSXTvg7818qdECKubtpVufrKNBtUQpEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(4744005)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzPFloz1B9tK9u22xj3u9sdk2fO5JIPS6Dxyo2O+vnOFs2S5gCAxLOJD7OtM?=
 =?us-ascii?Q?f0OOLp73BADhX2sr1kl/WcIHVQQDF5netmIftBFGTQ4nssGqAYe/pGIjpfVK?=
 =?us-ascii?Q?JSSd5X9PmYNAxjYYfm4Zj1w/u0dORR48ZK9oHIYDEdkEKJKLBbzbpu5eEh82?=
 =?us-ascii?Q?++zMvms7qpBHTuFx6oF1TRI98JoYRd6Sfu47JucC7yGDnOoewO8R4c65ngZm?=
 =?us-ascii?Q?8iVpnt8lr4jrGdxBrZjUTwXF+v0+loiICq4crNbci738d7LxBw2KP+AluPPx?=
 =?us-ascii?Q?HrtsWBXDOIiIDuuF1GJrmV1h5Wp6hutLAvADo73K3YZzyxr374tCqacDa59c?=
 =?us-ascii?Q?QnLiXWoelP8ZGkaYCI+pXRUPu+54kh8fDUp7KtvmY36VYa3T1Ju76+4ASyQV?=
 =?us-ascii?Q?pGl6fYn0WxzG1+ie/XMghinSFvXMi/KZ1OuZgTGmjF42IenAgz/jOQijMAr/?=
 =?us-ascii?Q?0BdTqbTuyoeKxxsGwFxyKBSTB2+sF0nOFj02ApTpIvxgZoiYigUHyumMcrsQ?=
 =?us-ascii?Q?vidXV/WIfsizm8qGuE7DSFsSJn9h9tkCzHGqf1J9VrHYpqX7qRLgB7RmpuVV?=
 =?us-ascii?Q?17uTGuxte3AVf0MIsDf4zxNFrVa4DWRoOZbuEQyxjNcGOJsDQkUulmq630Vm?=
 =?us-ascii?Q?fBiyPo6qCVf8Y90qqpj80UBkZz5XMCKoIyn8qp8nAaxx4F5gKlt0fQETOWup?=
 =?us-ascii?Q?MDRjl3bfQNwTkiHzAdCPxKTgR9pJAXt96PGE88c93/YzTPPXF80kYhge6rgM?=
 =?us-ascii?Q?PMtoMRlDnxAOlBdgk8FXFTisbVvKMNfIWryODITf3wAA3ThGgA2wPLPVVZCh?=
 =?us-ascii?Q?18qpZDvV6Jjd7HoX50TwUiDPl5/XeSmgtkWXruAy5HRc4zu9DP0ohSaPo3bQ?=
 =?us-ascii?Q?48dYvwgMSSobQmk2LusHHUglTULNsVU/bnNvK1u6XiwiUEARuaBegw+DQK/x?=
 =?us-ascii?Q?fjH+RZHzVe3ySJW/wh8llrtGOSHK+f8gD/bMQfopXfixNsQNbnf5a1R42HvE?=
 =?us-ascii?Q?6OAc0TESwGVvjUChp8aW3Xwcyi1hZll80EMIjAxusQpUBzoclUZSEPYB9Vjd?=
 =?us-ascii?Q?+1IaY6/sRNQmGs61d6UcY3ONM+4xWAqGI06NsLkAth8/Y2ikdlLsxj9eWfmj?=
 =?us-ascii?Q?2egEci5vvdLEXFoUT3kRRlq4apqQGACOeb0ToFxn4IXQqW/Qr0JD3NzCmdW4?=
 =?us-ascii?Q?5Sm/T4+utfNg117XU7q2taAbBbb815lwcUyzYJc2ostloRC6cOL2K2TXCwlu?=
 =?us-ascii?Q?YW48IfztXOsvIqyo/p67nCm9DaPMZ6Q7pMacBpRecFnpcydKBRBIeSvDpZ53?=
 =?us-ascii?Q?5e7todmWBhEb3i99bDrcEmK8PmmeoM+3jlpOQWQwLxX2p6FNuvUykivIJTlZ?=
 =?us-ascii?Q?EXXs9wku11cX49VkqLy7KqK/jthI09aLQfit4dJZaSrVNStzbduEhJUacBh6?=
 =?us-ascii?Q?0ngxb/G3kDS5af8WNNhrnsaFwKGwsqwIF+GKzhc5Jhmba+WPUVoCV6lFgOWu?=
 =?us-ascii?Q?W9BelU/oEGNajCgRqH3NDXZqEAmbVbVhWqdUs/sYckPEjgUOyCfgkrLqWd8k?=
 =?us-ascii?Q?H1TlyjDK1h+4OuR2SXfdrVOM/kk+P/mt6F6f+hJ6FcMB16JQhL7HmT5+dB/8?=
 =?us-ascii?Q?lU7i9Q1XphQemNEEaL22Mg03E454DKZF63p5OydMn6EoKjYUNQLfdEz3X3ai?=
 =?us-ascii?Q?Adsy4JRsGf6z4xZtzveJ2tyLalg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85217f2-6306-415e-2ed3-08d9e077e5d4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:41.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trEWD0f49yivHGwg6dSiNBMxcYzC+QbVVjxSRsGjb/YYMJWeJH6GRldUNcsvgc5sKvkAyx8DESTRcLISyZT3PkyQYjuk5kjUOwxdc14pMUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260011
X-Proofpoint-GUID: L5gdP7hmtuxs1fG59HA-iUFB7oIrGkot
X-Proofpoint-ORIG-GUID: L5gdP7hmtuxs1fG59HA-iUFB7oIrGkot
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move up the init order so it can be used by the new machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v7: Initial version
v9: Unmodified from v7
v10: Added Jarkko's Reviewed-by
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

