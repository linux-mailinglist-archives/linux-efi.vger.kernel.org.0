Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC8451CB6
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbhKPAWK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54540 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347963AbhKPAUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:01 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNXeJS013778;
        Tue, 16 Nov 2021 00:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZK9b/FSbm04oyCavKF6mYnKOuXnw+pCxppnHqU+VGLY=;
 b=rGFV8Daj8sqW0ANfo0gEM9TJtefSK2XqC7CLSa5qGo9P6h5bG5Tl5Xqgf4YhP9L/NeHt
 Fxk2tkViU3DMwk6v52S7hd1t83hCpzI+F0VGVFURhW2q9LwjMQvhwMdq5bqNGcUeEvl1
 MXJWdsk9m6gevNMsKwuQ5zC80BUkfAqPFVRn9WLmPjidNDgEGwrb/SlM+oFySlyeXTwZ
 JQ7DzfomgevK/HwzrXMsJGUKO8GRfytZEXIuOVvIARcr30lgeTH9MXEZ6MvBOJuU3KI+
 N/qCoH2lahlV6/MdQyw0xNEYmflp5nwTBUciWDnM8EpuvrunPq0vf3q8c1qSt3803TdI lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbfjxpbef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0B0XH046194;
        Tue, 16 Nov 2021 00:16:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3020.oracle.com with ESMTP id 3caq4ru9ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCTcbTftM20JgUw3zQpT29lGh+6wBgqlmOyRIN+LQuL3zpGUGwu+WyXyZLv4fWnRZy5xys8fd/7EWbGFpWVqbzBESsBdRj9krQd//A2eXNM5SbFeCMqfWgW2g42b0DINFrwJlHGYr5i7N6Iwo1jBdcLhG+OT0LhZJBnQL8nZkjQRcaDITzdbzrKXhRUGpV42YYzOUOlDZg+TgKPZvr6ZBMF5GUKVgdfkVzX2C2JaS+vGyoJy9o2a4ZICOjPuJm1ZoM3+9xFw6kpT6tyD2ypuVxMEIl0kt1hJx24ZJrZXY6IMwBS25BSGAboln75RG2Aw2SygDZm8VS+e83RYxOg97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK9b/FSbm04oyCavKF6mYnKOuXnw+pCxppnHqU+VGLY=;
 b=eVzjc/iXOLHHDD0J0gKJiaKmG3QBNKMnRc0s97VrctEpEnReznOkpp+3ICIy0FFGv0Wudn5h2Q4NEMEsoLpLVFceTHxTj18jB174KIArUyKtIjpQhiM+bUllShAFx8iBWx/jRP5xBhRjZwsLOez9HSCjiAyKFnkSVEMjWS9oZ2eVdf5zN9sGo8hgoIA+TcGw0IYfZgDsDoqTtyHU8WdBfeoGmYWsHkCMoWmV31okNL0mXo55iD0BoNuQTV5mwQtHES+5UXvqYsJNLAmfBG/R/AohvRnW9o3a8y8hzq0UvwBGh/tF9gTjxK3g3INbYCpSsi3n0Z56F0Cz1p6T5PuzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK9b/FSbm04oyCavKF6mYnKOuXnw+pCxppnHqU+VGLY=;
 b=WXxhY8qgcC7XkYPCDNmh4DN0LW/76/1JqPySjAxNBDFYJADXLTnV01eitxSd1H7AvrIlba4zBgjcOE8mF9pSbhmLELJ2mKU4djoat9zhrHLVSD+FgqOYUdriAfJy/H1XLnTEksIpV/FIHemx07elfDkTsJNBY+UhxP0nN+paygM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:27 +0000
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
Subject: [PATCH v7 06/17] integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
Date:   Mon, 15 Nov 2021 19:15:34 -0500
Message-Id: <20211116001545.2639333-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 048d7d6b-27b6-4240-43b2-08d9a89654e9
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5276C5527345335843AA3DBC87999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFWQNFgz1d/vNMXA79J/OjCXEAvbkPNSLP4hdE2yYSW8/8abSiGVb/03pI7g8jfHWGlytIXHPXk35KazcQyTMhKTRZG7y2oHQ2mcY21stlmz75a8EX0nKHHpVZiutl7yuTrgr3abp65TtI98qid0tqW/iptAZtOPcm/eb4JLFz8/eCb87AyjD4XFrY8cK9H4C4rhaP2kfJlqVX7qH3/4LLvyI5l9dSFN75JJ+lJxv51pNr5U+Ngn5Zv5WsgVf7tBBXG+JmSWMStvtUqLGsFICu8POrJtbJzWhbIp7Eikasaqiku3npxqXijRxlIU5Dx5zrIx4YVrhw7bQzUaOuAwWqcNP2BGxuRwydWhViRGswk96osqBMJdviPCW35KuIe2LYPkLlVCOOBr7LOVdTb2dX0D1a3Yha0oAxevOVtHqMI7h+wDktxeoanseB1KkSK71G0/VDIoSbdq9yOwbVmbnA+hVlj6PBVBKN+plTOKTa1DXglfL3Pc5kitaRoWMrYWLjj5wvfChb1bmEjW5JkcQJPFbwATe4K877mc0Nk2CEsl2o6owkX1jMFBA2Y6wBuku8txEnlZprLI1cIXPylAljyogl6IeYoHCuTW115ZBIy1x4O1dLCDofDiF4tQcsMozIvWcx9mZJEZAfV/cYeqBoqNQEasuwoshcBH3kGmMxPvMmzFNcMthLX/svS44NYnUdAgBkJAE6BXb6bCUF0bPZgPl/XHrk4hlMHxwQVRKPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSqzdgQvNyaGxm2cK1JMM5os5gbw9MO3ySgriem+T0QEuq5+5UVL7V+LOYA6?=
 =?us-ascii?Q?1/wOHFOhbIA6LJi9dps9Ay0bH02luV5r+tQ87rWQ9EHrcVLVhfgS9L9xoVVW?=
 =?us-ascii?Q?G7MscSiNOPQi+y+5D8BEePZiV0wH9XY6umL6uO37cBB8gBpgPsrCaz13G30L?=
 =?us-ascii?Q?ICyvkQLq9pRyjDUi2uyjRku1RFaLkYYPRQayk5XGW4AzYpJ71xDsE1EcdKwK?=
 =?us-ascii?Q?/MscMUQD+WToPNFSvKiuALavvGMGUz7V+6CUcC1V4YV4a6yR99Vo7OYEe9My?=
 =?us-ascii?Q?sBSpHs2Ti0V1laXIl/TYxFFzHZyLPdSjeBQ0W6mobgaYKHI19WTsnJNv81yD?=
 =?us-ascii?Q?sxrnpKhMuK7IxIAwjojvFZUPUqzMUY8U3K8pOqs8en+TLhdsbGJk0vAMCTm1?=
 =?us-ascii?Q?15GcrF/n0eSzHMkSPRHEoJhn4H9KUKuvZZyutiZHORzmdonuAQqMBBkDVnmF?=
 =?us-ascii?Q?xVQwM6MW6kjSer5aqor7qKjBsSbKBfc0Oh87kToSx+ytESGFB6LM/DmoMXXE?=
 =?us-ascii?Q?4s/fPQBNJkmw1A3SYsgyuoz77yGjNhjXp7jUZkL/fUQ1w8YE+niYRA8qfOgZ?=
 =?us-ascii?Q?V4Dh7KZiVwdUAtmWYZfglDX3KnJt6c3jEvxVCwcvjtVUimJvJYkuTrBeuuEL?=
 =?us-ascii?Q?cW+9yhAQnW9sMhpYmjX0IJeE7Ij1OiybxnJ4MClDn0McOB0OsnbsAz8ChSAS?=
 =?us-ascii?Q?UzTTGuyUi/yAe/TRs+sPGKA5d7tfpKdMbDe5+Ex+DqnHQe5ibyRdElTmaVC+?=
 =?us-ascii?Q?tUg0kRQh3b1G9PpHylyrtJprC4UhNGqjA+l0m3tL/B4ktAz68ulV8Zx8onWn?=
 =?us-ascii?Q?qmoIXPLNxLHn27Ou93hiIH+HcwGLm90gVPTFrPNkTaCuZsHjja9fnF9m3F6i?=
 =?us-ascii?Q?NTxy55X/GQAbilmX+/MMvXNZke4oOqyDYIYw4bIodonBieBgqJr7BrxJFaIY?=
 =?us-ascii?Q?5OSVbU04j+BqnFY+s4El/U/Jn2H1ntTkOsMosHIcUNJUYRakzpeVH23j0pyd?=
 =?us-ascii?Q?J39SeiZ2siV5JeoKAgTHhMmiYzmao83ByBw0N0uEkLtAa0lP+5TGpohq2038?=
 =?us-ascii?Q?vCYjLBSo0mrbylD/mrSbcg2mSXKjfg6XeGBMevu0M52z90BcDtkDHMrGpDGz?=
 =?us-ascii?Q?xDHGWoXox3AOQJonHnOy7VjPk1wqsICRBiVmufOwO+ksi5FwY2LyBiNwiorZ?=
 =?us-ascii?Q?XWIgOAu0jd7exgq0yHxIWqw+qFTsiJXAzVpma+ijyd8FZ68M9Msdapr+ebQM?=
 =?us-ascii?Q?JNbVL2qHInr1eG+pDYbv3A77ENUEwGBj0bXTwE9SEtk3nPwERjIOXUsz37gX?=
 =?us-ascii?Q?Mq42yATm1WhklSl85q0bXbpkRvvmGurQY89XwS2ebQsihZzeUTfTh+qvO7ni?=
 =?us-ascii?Q?CHtum+dedX3aJCqtHD3bcLLzmCaChNqb/BnEh15Bok0MZqiJ5o2MY9Ggxv/Q?=
 =?us-ascii?Q?qzZNE/DXbTQ0Dr14J0gKLnS2/rJxbsbR4LO/CirowzOwR7Qog9IEAGuIRFJh?=
 =?us-ascii?Q?q8Pk6t6mh31dtyluvEm/LfBYdEX36yU8VTs4XcFrZZ+i9UiQF3Hyv+bDWX5j?=
 =?us-ascii?Q?3vxI77GRvfVZbCrUw+BZUQzvnQLstfwZX/mnyV7b4io8Q2u0a6+xx0cNssZA?=
 =?us-ascii?Q?rWFdb+fC3kp1Dwmf5mwUgwb7TbOqPOvQ9zgcCDx+StZgFwHCf/f1pkHAi8Tc?=
 =?us-ascii?Q?sfq5yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048d7d6b-27b6-4240-43b2-08d9a89654e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:27.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5Q2bRnoWpHDtEvKyZp8pDia7TpZSMIg9FrMxZF9+SC+FAOfqA6LCd9xQcZ1SrNno+SAZgDeZTCLn1Tj3USxCXwIwocze08p8KgXpRhF4aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: IUIAz4gGrj5yIyfnK-YsNQ_5y2REHYT0
X-Proofpoint-GUID: IUIAz4gGrj5yIyfnK-YsNQ_5y2REHYT0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
restrict_link_by_ca.  This will only allow CA keys into the machine
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
    keyring gets created even when it isn't enabled
v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
v4: removed unnecessary restriction->check set
v5: Rename to machine keyring
v6: split line over 80 char (suggested by Mimi)
v7: Unmodified from v6
---
 security/integrity/digsig.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 910fe29a5037..e7dfc55a7c55 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned int id)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) &&
+	    id != INTEGRITY_KEYRING_MACHINE)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
 
 	/*
 	 * No additional keys shall be allowed to load into the machine
-- 
2.18.4

