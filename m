Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB1451CD3
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbhKPAWP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20458 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349509AbhKPAUJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:09 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNPSkn007675;
        Tue, 16 Nov 2021 00:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=U7OOz5N2hC5TSXo+gtgewDyrpOY65vzFXYN5kYtI1aE=;
 b=BCOcgD73y2kufsUi+4XmoDAkvZc40JkQhIz1jKrqQYNz/lG2xXIGEPggEKjKrdqMS3wy
 lrLxZkGQeXp8OZqqbe8ogObGnxqmH1PBVeinFRikRI+TJvu8k6f6auzFawEBz/O0JgbA
 y5g5hMZ5fU7k/KOmnzhb9KcV9ojkL974VfdZf+YEX0pqStKPORwlawi8cWgRYysOiTCZ
 BzsQEwKpBpIvYyOb1IXaFGBsfq5G20YfxgkE8UE2EHP3jWLSvkWxyQb53JR5lXzphNYQ
 vNsw+pwmoOEBtQqMA2pmLuyILKlco7AusBKM8YfMyP+PZuNznuBYd6GZ9W9U1PcgnxLp Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv561bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0B1Ys046368;
        Tue, 16 Nov 2021 00:16:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 3caq4ru9t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJauXUx7eDr4cg5ecVzpcBWXZfpzUNg5ghaKb9GGBPn/mLK74QJv+RSmWDskuAOjGO7HuaP6yiqlzcS7LPMuxO47TKpoCccjUayu1CjXInrbRyWA6rtjgO9Qjk/77sNbvyV9OA/MovQBi8FEdvxh8KYGIE4aKtCe1Gzp6utvuj7LIFbK+VY+cOGT0o+qNGMuUdIEn7Eya0tipC9HWfu9z4PylIocGYkuEjnE1shDKq5Asg+F7NpYjS4wVrMoXps7LVNxkZe+lXb6qqWm3n/zOq9cyNm50Q6uqpvpD3oCzP9sb+KB6r0HLtn3PWfvxK5ZCqujpMNSM00OJ+Nyh6sagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7OOz5N2hC5TSXo+gtgewDyrpOY65vzFXYN5kYtI1aE=;
 b=T+7TZIFGppx+JVJ9vJpqmgyWcUJ/MtQUNUDG/KnEHOF8XDY6GyDLF0Vct/4xIwlP/ybW/bwAYXa6GSP9FbKcaDbj9vFFdhFXGGe1szlvIUQEfJj4ZpY+EWiFwsCqUQm5dN4MSau6lYp3OP9Q1JeJDlHyj6uglIWBgppAFo0WzeEn+Su/amfL0WWdGB4haOQp5t0GF2WFTwB3+LAScVapa3O/SKjZfzlN4E6rgiTrtjYgjO1y5it6aCFltdKoYt53yuHgqZMp5RpL2230jIBR8bvsLykwGM23aQ2AD/nzgOPQDesF3UQCvLTtBjFv6BoYDYBXpKvc/9saenmelkqn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7OOz5N2hC5TSXo+gtgewDyrpOY65vzFXYN5kYtI1aE=;
 b=cZAex+YSY1DDwXOQEVPDSq1/txxWSH9JARuhhHjf8/QLTLoBdJ3MTlWX88k9/a0M/tu5BFk+oIrkuQ6ajLA/TjpqA4BhVE/EqKvL8Lc7AzFxSHk34i6V6L6qbWNvKso0PX7WlMBIH1vIXDUHOomdw02YRnar3lbwyp91OGAb+Wk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:52 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:52 +0000
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
Subject: [PATCH v7 15/17] efi/mokvar: move up init order
Date:   Mon, 15 Nov 2021 19:15:43 -0500
Message-Id: <20211116001545.2639333-16-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0f5eb7-8ede-4b81-feb5-08d9a896638e
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB527673759FC61B477B5DA8EF87999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6Ai79a1QTM9gAPP687k11UXc6dJhJOcVRWV/Za27woUxzPHRplFLcX2x9TWC0IqQhFr1A76NfPdHt/CLPpbCBqPfs4jNsqOKFI9VT5dvTiveNoADmlljAeJI+tssalS+tutNCQihqFbvL7Z2kC5F69U7Ti6o68ankqnfUidSd6iQ30VjqIrbawtsuHYcsaQeC8MNWUMd0dM5a4mBI3J/pvgMbcT7IPuuikVoDA2rtB37yT+RP7xvbzhz+NSp3v7FHwTkBG2FChhe+GWfbkauynpfsDObd7nVA/OS2u/bmzFVydr+wljTwWMyyQM8t+Mjn+SVRe3LlnJr/GWaZFYWWv7c7LCke+v74Jdc3+sING9xGPiRDibhxx4OP01VCq3hlsf2yqATGMEzL+DJ9YDyLNJj9bi2UE5Eu6d/X747t1DqzKmBqk+mNk8cPcTaG398sSif31evKWf+6nUwv/OX/YriH7vQYD1SvBnoXEmptvdqxy51SIfd8uhb6GzyUSSJpC4DLQ7tXdhlUvwabGSalY6Cd9Tuq1y6jvbqnBHT7wn6+twqmZaJJczlj7LFFNz7RmMoyvzGMZWI0xyZ9VkGRvdeh22Dq/lemf4P1D1pmrUbrEPqOZU5oV2NyEr93UcYQwMeoqnaaTWtLRO8zvArkbO6NY99UTTpVLYj5n5Jm/eakdQtaxQtC03EdtzS7utvAkkdfvamHStdeXboej76Ibrppt535qINAZ05+Pc9hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(4744005)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0ZI9O7W0djkEaNEeCy8Is7qnorryRi4cOcyBbKZZsRqkIJoZy60REeGX+rL?=
 =?us-ascii?Q?vcAKKQbvmirDNl9PJEI3PgpMlPwaDztEOgNtjrJGHtJdU1VGnLDfaOuv62ve?=
 =?us-ascii?Q?MF811w1YfIttIZMRjdnui32glq1gBz6oeseeL1pXbvhFavOQ54YA0Vj2IWMm?=
 =?us-ascii?Q?HYc27Q09uKbEzcFQ5VYW4vnHIexbdsoMGefNiAQsF28dxXTosATGXzMYlLU3?=
 =?us-ascii?Q?TVOZfF8ywfisgAz3cJMHiVb4nQxVI2p8fYDfYHxtbQlelEN++pqBV0DmyhyT?=
 =?us-ascii?Q?yeHQo6LhCJi4WPo4AzvIZO7DoE4okz4WB3q0iuIPt+k6kqru9ENXiv5ceMc1?=
 =?us-ascii?Q?5eyYWf72/l8KUWjk8YvCr7ySzfbuIhA8NLU5qRtIns+FOIDw8nOczbZXzf2h?=
 =?us-ascii?Q?gLg+blbNPsxmpxPGbw9KcHKR3ScXw4ZMI1B6r5Syvx8+eNqbkDZSes9gk3tW?=
 =?us-ascii?Q?sTNBLMGPLK6eU97xX+7PXCx0XkU0cj4qO09vrRy1h0/wvt2cMYwAC2sXb8O0?=
 =?us-ascii?Q?u28cxLPlzA9+lbbgWFvrAS1mC5z7uClHMoyzZ5IK33qXjNvs3rmxykoH92Y+?=
 =?us-ascii?Q?VE7ZRoEKptYT1lJwDMLMwmwV+udYrXXCFMPN7pH9Z85EfbYnXXPNwmt09fMZ?=
 =?us-ascii?Q?Bp8RlRB5+YD6N2VJZvBynD2+idaXDdcqvDmY1wiLHaJumxIJVOOvWLo71xbl?=
 =?us-ascii?Q?/SCcINzVWVkZveb0b+OyuUuye0M0dWCczxagEnKSwKHmbmDA+3/qkg0ljJco?=
 =?us-ascii?Q?ELRqu7NFvp1wiYJUh3vm96VK+hOHn3Vw6dIhr/v5jX+l5mbC5sH+RT4no8Xm?=
 =?us-ascii?Q?Ehq2w5BZWNyZmR6ubhz3CGOZg8cWQY0ZxFsj3F5WUk2ixx7cxXllxwR/zwaK?=
 =?us-ascii?Q?xGo30B2WVXfSVQ4WqgpNhrTKAS/SuxtQFiXHBaC+qPjk09U+GkXCU4I+Orfh?=
 =?us-ascii?Q?EGhPAXBZ2MHzTberMeaSME4Di7oxK58JTjTnuSWzUFdIWjEa5SHyDPF7uHvi?=
 =?us-ascii?Q?zQCA8wFpTr2LMVAPJ9wiHRboo2r6NTa9pxMT3J/CCoFx7dPT2dKWL81GaWS3?=
 =?us-ascii?Q?b8b8Kh4Ax6wlSWV+2dNtevnWvKHF3Que5yxpYoTCRMd065OnU3wVNCAog1vi?=
 =?us-ascii?Q?QIaRtxT2Iuefs3Zc6XQNkJtWSkjTrf6oqRYBJGfdgdzmxbQZA3nlNpRdjBC+?=
 =?us-ascii?Q?7LaHcXd3W6FCbn3TlQzVxh3VqS2r8fGzkyhfE4uljhuQilsrWahhGFbS5obc?=
 =?us-ascii?Q?C1i7v4bYwmSLT71mwDVjUMOn0Rl+zGtKyDGB9fvxLb5D18+5i3yKSADfVOsE?=
 =?us-ascii?Q?CuavUFFz31obL/uYbabBOU+7NBaMAu5udjRWSVktLkNGmHf8ouh9lZvJKpV9?=
 =?us-ascii?Q?H5SF1eJMl+UJCZocwlU/NzVf9XVGRa+ZR3QDyk9dX8h5cOAExnGAp0wtoor8?=
 =?us-ascii?Q?s/Y1LbqnScBa4lscBnWuXbr0WQLKTqraX6eNajW61C8waMnBb3Vuw1ErKoQQ?=
 =?us-ascii?Q?16PttLBMaG8Ten/pnbK+CJDwbwmr6jatnTVkrj8vjAgVSwl1FR2uLL76Daiy?=
 =?us-ascii?Q?vIwYMSnjDazzlOseeBt+9aAsSKCA8kVrotiyE6j3du/ArWgUoAlvKQCpgzMC?=
 =?us-ascii?Q?6H66Z2OVwzoYXOS2yOnyLWbuCwqm6ryr4isn2OSXXVI88qVMOntVp+jxNWYL?=
 =?us-ascii?Q?Ssijaw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0f5eb7-8ede-4b81-feb5-08d9a896638e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:52.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtjDKi62WnFxEsTGUwl3naNbJgPPek2HV2l3KY9/fHIsGAwqeBdRuFrFTKcxawnM8FoFwgZPAQ/0IW8pICp9kNka28J5gaWuwdqPW8t79eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: X2ivz6U1tWHqo3LpZa69OM55fcTQpXhz
X-Proofpoint-GUID: X2ivz6U1tWHqo3LpZa69OM55fcTQpXhz
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move up the init order so it can be used by the new machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v7: Initial version
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

