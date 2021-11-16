Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7F451CB0
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbhKPAWL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54658 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349330AbhKPAUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNIDI3009034;
        Tue, 16 Nov 2021 00:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Fet5i3la/BK4/vZ12MuOCx+XE0c4VFKhrHPBinrioSQ=;
 b=Xvu1JbRD+QdKcEUUUK36Vvxsipum2Jd8NKUHWIhDaKJleNU/9mbCbTQ9qFFgHL8hHw9K
 V1VYFzvINYQfckyQrZ7as3lMQGmCpOZXBbc24cColkeJ/QS0+VjTiz8IAyWGeF+CHSox
 a0XVM1SiPwpXilmK/Qtumd3seDS3Nqc5lMurnBJv4RVLI5VkiOa1YA+mysgy3QHbzlsC
 TLSm78bpLMr5fJ/tmvaif1Lmed/O10V4ukKD+FSA6KGiGFKlz+mKDIKwiKBA3g6lcBPD
 Yy0VrwgmgfnfOuO6cMwSqFhcJeT2OT181DZ+8fl7/BYS+nj2VCcET44jTwlUbh4TO1UQ qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv7xb35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AMWm072890;
        Tue, 16 Nov 2021 00:16:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3ca3df6j08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9p7eJHxwa4+jrtB6eosBfClkMYWrzxop8MEcoSBhApHrl+VGz836pHd+j7wuZGlbRdahOtzxrWwh0+MiSce5xYHIpTuzZG9XHc6fVXjzEjYK6SJF0PqzyMw8m/7zpTGE/ZXtIwLWUMj3+pY0OARKHEFkfySOEPxSthc0GLEK62Gosrw9H/hcfos+JrAj9gODT3YFgzPRRsNimVzq5tooL1Gn6Y2kKd+SSLDykwGNjZX6luaUBCkwG+GeKAnrjf+Uq9l6akGAydY7HvWZFMNEvk8Vdv29kKca5FHI8Y5e3w3iqfHnHMlRc1Pi03ZpqluOSNLZrDSJ8sw0zdTBAuUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fet5i3la/BK4/vZ12MuOCx+XE0c4VFKhrHPBinrioSQ=;
 b=TiYb0pNALExsfN764GH8P/IhKj635XM9P4d5Tn62jisoOtMXsXNM+IHLQfPL1ybZ/K/nk8SAf6+rKNAI3o+a2Ms3ID2v6n3zm/kKeT0hfIBxjgCPxGcpuZfqtDjMm7SB5CTa+yNxDEBWQKt95lGk/MsO8F6yiTsYjIK5XkBuQ/Rc3+BvqJxiKjz/+/jaAvZZhyI1XsttA1cEwBjU1bZXOt7jP2P1lyL+L/sNUVTKAJiQFIl9+blrYTbBKst0E+DR5JsRsGLg5iYUGPNEP/sy497gWA+XLxlLIHhJUjqD6Adscwu9Bu5c22O8CtouAX2IRkFFW2Ui0/BJEdQ/lWKrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fet5i3la/BK4/vZ12MuOCx+XE0c4VFKhrHPBinrioSQ=;
 b=YOgjf824j0GswmGnOmqhcrUED7JEb832Arj82hdW/zsa4mRjFZdY4nyrAOCfDz0p2kp0Q8u3ggp/r/FD+To7PCnXgH2TOqF+q2E2Ux7RLBZ5C6WxU0UNvqLaSJV/voQLK+0SY3lt7Tl7+mXJWw/efZlae1/orThzSyZnqlt4ymg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4358.namprd10.prod.outlook.com (2603:10b6:610:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 00:16:16 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:16 +0000
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
Subject: [PATCH v7 02/17] integrity: Do not allow machine keyring updates following init
Date:   Mon, 15 Nov 2021 19:15:30 -0500
Message-Id: <20211116001545.2639333-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d081df-dc0b-46ed-0a3d-08d9a8964e20
X-MS-TrafficTypeDiagnostic: CH2PR10MB4358:
X-Microsoft-Antispam-PRVS: <CH2PR10MB435880D271A1FA0B2464F5D487999@CH2PR10MB4358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52G/HxY0Ps7uB1wUQKhLwHu28yRkDxV0jwBXbMhQlH25OufbDpdrTI8M5JWIlqr/EZBSNrAY/8PW3LCgbHf6DSfZ2iwqh4i+xgymTh10s+1/XoDbdcp12Uz8I/EvW6qYQ1jBmhLaGAltQoZhwXGdVw1JecSHZn+Tzut8HwzlWGPw+9tO3j0Xp5YmTlfvsEKKd1XS6duilhloo12K0LcxTgW6Gc/7/X3L2W6K/t3WrfODa+p9wMPv8TfRxxSn2fyPDaHYtodr+286o7lrDw2kKUbsDQQSCm/eOXVE2Vc46kGqE5t/jsXjHvqy4IEcV7V32Jo0mbr9wXdOK1p9Bqr5nvpKbDLJg5K/eNjQ1btrPMLYW9mgoatJ3NuStvs8vc44J0UCGW8kyWL1m+pQ/ykgZHmUQ+DqLn2oE+dFZeXqUv7bK5nIVBnsur2+gxRxFVJTnIOP6B5fVxvjEcVd9aTROsNmDHsEmTWPJhrtKNBTtRftULDBdWQLb6KHnxFBpyt8pH+REBSqf7CQYjtEw+aqF2V5yWM0pZcscoZ4pgz+VpfNbA87uih5fW5OujBRe6/Lf/iyeZFvMJNlXhAtTeJQT8lcgKGLirOdUjsWi1CA3O8X4sIVSpaSBkkPdX4Ypi95kacUth0Of55oNh6L22F3zvhvUNu94AmOQI1oYuyFWtHIUWiTY3W03rUJqTL9/+cu8y9pWVz4JtI2BSpb/dsG/lccvBRJZy57KPGaJeKxRSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(38350700002)(186003)(86362001)(66556008)(38100700002)(8676002)(26005)(316002)(15650500001)(4326008)(8936002)(83380400001)(52116002)(508600001)(6486002)(7696005)(5660300002)(921005)(107886003)(1076003)(44832011)(6666004)(956004)(2616005)(36756003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pg1TGehGfSqUPpgBxQlBbztWKFmPrW/hJjkI4RdmzKu7KViOyYCKwgCG/CVI?=
 =?us-ascii?Q?WrrPfQqv+iPnMg0o9FW+4C9i5/YQev4dIEaO5rzo64dC9cIPev15J1LEphat?=
 =?us-ascii?Q?uWgxMjXWeOGv+NmvE1EO6AJUyXioIRMqpsHxx5W9HowOqhCeRUOGoZ0ZMMqj?=
 =?us-ascii?Q?v/lodBwHYtdpJw59MRvef/qyMvlEF5VAocwvSVM16nhPwHp1GbIqzeXsfcl9?=
 =?us-ascii?Q?VlPhgORlI9ydkunWftphewk+9bzLUxu8MWIeqr7Z9vtZkxvkYU0TuDrCWt/B?=
 =?us-ascii?Q?du2UJ70h3ugzDHh6ExR1HDXIG1xWvW6gRiXKgOsiA0W6USJp8hmz6Pa9d5sK?=
 =?us-ascii?Q?Vakd43k1mkwXI/LRo249S17coL72NapcB/bMa1pJMdQ8wQDsz1XSj5CJNIl1?=
 =?us-ascii?Q?OIzFEDoOjxroFoS76wnfaW3sQsgdqCZDN28yULvWnsCq4zIzsOpdCsxfsYwl?=
 =?us-ascii?Q?CCRpKPDPff2csOGHPdVd8wJjmOilGpVJfy5HHkQoT60P22a+L2NiFqclHpd9?=
 =?us-ascii?Q?7CmBwVsl2YGZGG7+M3Z4PLEA/UC0ZGeqZxHre33DW0pJY+lwKApRHGpqogQH?=
 =?us-ascii?Q?tHhAJyh6a3oGBYUEwTy5xPYBwrKHSWIMfd05EmowIxeOWBEyabCsATG3hsxw?=
 =?us-ascii?Q?BCCXtvwK62JNzj5qo9P/IL3syEMGtrY1V0fBXk6f3Si7H5iSaVm7hkplxoDR?=
 =?us-ascii?Q?6RUNJnz0tHpNLjEWgkH8SvR7mAVrKJSjyF6jLGoimQnvigO6BSszodfohBCU?=
 =?us-ascii?Q?z2tzMgM2vp/gKFFT/7Opi+AAb3MlF158zCSQ6LOmgtc10oZvc1mOF4X25RcY?=
 =?us-ascii?Q?8nm3pGEhiJ7Ujk1Vao+k9e/aHuJaD6DekBzbATiQ3X63hgTNKnnmvhHKRFU2?=
 =?us-ascii?Q?KteKyxUm8PF6QRcYnXg6X12UvxsTRYSxoRJhm8eWyU2GZ/6qd+UBZL28TUA0?=
 =?us-ascii?Q?ZZYPMgkUZl9p0GJbn2m12ucdKkHVZxdz4WT1Qy7Hm/cvrWd/wMLuXkx/+D/T?=
 =?us-ascii?Q?ys+lMFUQt7MF6ztYU1NiucL3LFPNTrWJr5ifkTZV76Yp+0/iarXbz7RiY+Ml?=
 =?us-ascii?Q?tUumo8xqeT1VhTRq4iMBt1Vqh6Z9XLv1gik9Ahl2HCASbBxxN/Us7OD4NjZ/?=
 =?us-ascii?Q?+GgCkxZK4hU4kiiDq3QmLemex3YDWVo7nD1muWuGKWfA483ZoRZotUWinyZF?=
 =?us-ascii?Q?UkcWCciqMgPwnSLrnOuGDVsz4SeJrOQ6AVXwTy46St57Vxehi+AtmGfv4142?=
 =?us-ascii?Q?2wQGtC0/JkBGd5hc45qnePEJLrYhQ6aVASpsuoOs1pojxrwiD+rJnT+U4R2H?=
 =?us-ascii?Q?8c5ErT+gTleAd/l5VvgRSwQrFLR31Cs3tPpgEq8kxQDdbHv2z2KNtPMrJO5S?=
 =?us-ascii?Q?1s/t28An3GIfYbk9XbfV/ZBzJUH22UC1c2rkAEPZzszY5DYdrGAn3ef8vgF3?=
 =?us-ascii?Q?8hpzrvUAxuzoRGLnLnOyW6jNZFQ5XhpBWh0d4gdUUdCPzBfuEJVUGH5JxgRD?=
 =?us-ascii?Q?UEmTDP4n1vls4RFkpSNlIaqN0XOVACAe1x7QnfjqSOJ9gx18x4IR+F6QQcP1?=
 =?us-ascii?Q?AXdCegzV1Lv96MIilIutqSbzPwjs4VDHm5ZtpYiKx2qEv8+Dopq2TImVb2nd?=
 =?us-ascii?Q?/gytPyNni9QFqVrndKARw2tszbn24qiRrrTl83qN8brCL/PVk+jkWXpoXGP7?=
 =?us-ascii?Q?8bGQsQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d081df-dc0b-46ed-0a3d-08d9a8964e20
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:16.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sRJuEU3UlMJkpLGlnqOcXytDk/R3mrvGknCP/LA43ojym2XhQHHi4TiD9Z9WVp85y+M4RzntmYhLHpRo1UtwsuZyyevFXjhFc83Nnr8Zdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-GUID: x8qLlAD1AHl-JO-xonlvqtW0YqtQfWzi
X-Proofpoint-ORIG-GUID: x8qLlAD1AHl-JO-xonlvqtW0YqtQfWzi
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The machine keyring is setup during init.  No additional keys should be
allowed to be added afterwards.  Leave the permission as read only.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v4: Unmodified from v2
v5: Rename to machine keyring
v6: Add additional comment (suggested by Jarkko)
v7: Unmodified from v6
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

