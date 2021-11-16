Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6C451CDB
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbhKPAWR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14926 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345988AbhKPAUI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:08 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNHFKX029766;
        Tue, 16 Nov 2021 00:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=OeoeTOF1SZCnCC1c8qpZDdoyUVGX9pjbHGVQCxC5Kqk=;
 b=XePAmDHY6wkMjNauyKLDqIuDx7VGPIrOrUuNTbp1jc9HdXH7Xkr2SbV6IVWkpI2QyvRh
 8TKD/4uilKsl2eOa8pG/T6iLNCTHRppBquA2Y75SQTe+sgWvaLP8futUgdIiRVnYjJgi
 a9+aSWj5l50umFVoxMwrlSlT9sVp3AaNNKhc3NVj1unkV3SV+d/F2fKs3XanfQgaBpwJ
 Ax5HKv1VAU6lokNdbvDzt/l0G2bTsgu7dx0FpiQWxEy6GPv4woEMJ7VQFB7uunQdcPeh
 lelyeKhZcDPUnMiZ3tIfD2MnUCrAKJbPERdHmRAA51RyNEBzeq00GOjmP47K06SAn2R8 nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnp3se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AAre136099;
        Tue, 16 Nov 2021 00:16:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3ca2fvcgy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOwAJzj89fCVpbSL3h4NWmMl4D183yuOqyyxu27C1Zx2yAn/8zAmXGskLX4r/4xuYjXx8AREkLPdlTn5BPhRADY9feXoXh+M7wsm8qH7nBVqU6ios/srPxJbaT40D/l63u6NukdOHWz2FHfKs/MXfW7xqqKktSxcNAS0a0cdoCiciLiQmgFj2l4sF1bzVD5ZkFCjfOwK+sC5g5DLt/2pLhZd8q7S58TMct9IBTDIyZ8iR/KWQJGt0to4uE3fgRiU1mlAFQi/wUOuboBFQHotAYJZA3Rq1NrxFdwvytxahRo0NgMZtNH2LdNo2BXcQ7ZuHpDRegHW/9iF0NNmEnF4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeoeTOF1SZCnCC1c8qpZDdoyUVGX9pjbHGVQCxC5Kqk=;
 b=akhLIqDpO8UdixqsvKkf9NdJ40zYi+n3EdgcJFTYFyyVWZPwgjoxMZxiVUp086KAKYgKS2lfXRR6zMhv3C2NldQesd0ZIF7K4BwzTtKyI1Ocdu4r1ZuFf2l2CxCfv0+upFWdR6ZOWUvdO6myE1ky8q55CV1zSOdRktbVUZeXcKXEGj2wnAjqPdEs+HYCjVbUGo4W1j7xEpBIdvLRUNx+i6WiSgvCg0SNej1cwuBlp4Qm2LGHvPbhpenNU1DK8s/N1FXFLn055ct58S52YyE9/DcQ3FIr5sI1SrsrlI/9QKA7eNed/AAo+NpT4mtQ+aLyl3V70ikNq2LX438Qp+Cu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeoeTOF1SZCnCC1c8qpZDdoyUVGX9pjbHGVQCxC5Kqk=;
 b=iBcIFSdzAHx8boLeNVwr5XnhtjhC/ES5622rB5/DoZnjQpaPltP+dYp6J4t8MQmYDSXHqhRQ+Y4uboVpt5+r3dymHVp9sM9Za5XhpPmgPlBvm7Nwymdn4sPwSsL85qwhK28Y8mumRzYOtdb4jzIspW/fQ6LvYER7vdkPTETzvBM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:49 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:49 +0000
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
Subject: [PATCH v7 14/17] integrity: store reference to machine keyring
Date:   Mon, 15 Nov 2021 19:15:42 -0500
Message-Id: <20211116001545.2639333-15-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 978c6326-1a33-4a6d-59c6-08d9a89661f4
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB527696DD3915D84CC464EF3087999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQ656LwZXC6SF9YP7fxvqexv+l+CL4dGVtylPkHTSxccNUVnS1XFp/pdZwYY3TGm+TpoyXK3Vtm81V8Mi+fBzKlwypwsFMdlCWfoqkqhvsgI7n+jAxU9ScjMtT0YV4sXWZWDdysERVRyy8TjAI+txmLMsifSwN94jcAsIF6bArwr5sct929vqulKDsae99pDF65h8VHf0Bt6UYHdVvc1BIXxhVKdfV/0y6xjegHY8MJ3k/SudLVnsbQMSBOluZftl+Fcrhouiz2gdd+D+FtEwXgDDzrxLxWaY9KUS75U4ND9POQyOaTdCZjDVa9PDQPlz6UVgp9tvCv2K92IjMH8qp/J28SJ/aQP2Bi0v3Z/F/Rcu5Yil6pSUwZqEIJ5Q83Er/chi5jjuYskKqqTzzgI9gquYQJqD8tdUFM98BzEudGAD7csbmF2oITkH4yO7jVIqf5jcBrpu8Dy9UxbZ67sFkZkgj5KxUhMzhrZ6lQmQm8m8lDLuQUJHS1DN4OSgtFMcLLYm22587em1BZMSwO+l5oTPBWafrSpomuLl9vpKfkPT0HSdGKVZb130bsH9Nd9JlQyI/W5a+8jke4wNDowYGccknB5hIp98FGBohTjY5JUzX4rhDlJBP7i6/rok1bGYFS+jhEFovNEmhPJbsWPxP7J/t90Qa0H1GHog8JObHHH4Ggd+ZUz7LKMzQ+Mg2AVNsRbjWhv3UewcbeDW4CLZNI+lckYyFydGyLU0BeWinM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(4744005)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HL/kihU9Dz/ps3iZ617AV+LAQ4udPay1mYhm8REdionQkMdsXNzWenrWIegD?=
 =?us-ascii?Q?GYColgjZpOxhhSOOb24A1fjtK18+G22r8tAn3jaI2nLZLhVd3mH5qzwsiWaU?=
 =?us-ascii?Q?SL5KEvT9tOnM4Uv/7XMLTChmWBcTxZv2yr+t/ggx7bcbEl05MUzCh5M5zRvZ?=
 =?us-ascii?Q?GqgDP+215rZQyTwAPzAgsExz+JXdq+H6/WDVt//4xotBQX/CB/1Hdo2//6qI?=
 =?us-ascii?Q?zdiYeRHD5Qtbc1AMKTApyTkwt0mia9tc3kl9Zuu7Tlya1obOZCMWvtC+yEMT?=
 =?us-ascii?Q?zY3TSrA95v7tp/lb8Qp3Qo1L7KJJ4BvJO87WT2bfnz8Z407lHElPM2nnMR2c?=
 =?us-ascii?Q?DuXL9XLaua/qtmHmX6QFt1JawWdduflC5QKsUK8d78d9EabJoT8qIRJEzcbv?=
 =?us-ascii?Q?oBhWeqE+8+YSXxP1Mle9GS007YaKYe9dyUQmT7H1dofcm7SrvjFSJF2ev4AK?=
 =?us-ascii?Q?ddANqPwI3zWvkz03xmBPikh1yjYqt3kn+KvEU2gwESj9bwVpOUMbs+VjqJ9L?=
 =?us-ascii?Q?zX5sWSQ1a2yUf2fC7/ESD1oPc5c6139pTjg5vKTE+gJFBfFscIbX8aUOgtSA?=
 =?us-ascii?Q?nZpY0XGNVG4PwqDWKM0m8xtOb74y79fLxWAGGaGziLzX3FRY1fWaNmlT6hxA?=
 =?us-ascii?Q?/I7gpkSxBpLOaPtGnegmoxr8MiGdcN4e8YT/F5mxNnNarsYcty017R3IIjDb?=
 =?us-ascii?Q?UktufATrbLKN5R9r3+ar3Eddt1LwEeuU5js6/g6us1PGmHLBlUyBUxvi/KTr?=
 =?us-ascii?Q?vuTQ08Qmw9XrvimNji/iVNOkmvlhlTXEYgPC5kih3NPCzLCZ38A/eQKiP+1L?=
 =?us-ascii?Q?HgAoyE4mooouVVjsyeDKHpLSJBW14Id9cUTDd/MMxTu79WFvHcjnDK5Xgp/P?=
 =?us-ascii?Q?3U0ZNORJT3D5eUq7aP+KNQ91mlFh2Y4Fi712CznXBzmM6NGfDZqKKUp7dYWM?=
 =?us-ascii?Q?g8iDdPjEs2YkN6h68eAtKlhxFJbGKbUHxLatT0l8HUZvxZbAY5BxuYEJ+h6X?=
 =?us-ascii?Q?9r8JN9DNdjSOVOE7Wr9pabKmcJtBuNcHd3tkpO0oxctCvYXmim9b/6GIEfBu?=
 =?us-ascii?Q?igN92wGvwuCm+Cdfcb8mwH4pJdir5/fgHf2lYYOvUw/ge47GkrzIHgL0H0cA?=
 =?us-ascii?Q?vj8c2t/4lGJOtZKOzjVNIWAWQpemkeI1G/LRsWfYQj58J0grheajAYIrqbLL?=
 =?us-ascii?Q?GY/g6mtRAXBsbheE7YInLhG2GoWA9lbeJhN/O588BRJQnx/0WLMYc3GZ5hRu?=
 =?us-ascii?Q?UKBVs90t1NmDCInI4IFtOmSx019wULJS9xo+WLmfv4UyrJSzBIoQUkaQwCdq?=
 =?us-ascii?Q?PChvSJKCNFgaCKI7U7UZtvHlurfOmcgqigVda9OZ+VJ6+eNY0PS2c+ru1mzM?=
 =?us-ascii?Q?Ddtn9/bKW0u3gQ5oDEYIv7xzKwFYOGQHnvz3icVGanJA2dXWUPlGdga8rk+Q?=
 =?us-ascii?Q?rnDj6IlsL2krmD09Mg7an37hsJz3K9c8NAXHSlsc/yVscRTswg+ODrP8CWFj?=
 =?us-ascii?Q?e/n8Jts87nYMMDQmjpwaRjX349Ar1TsojlJx93gorBj5qqXDMw1TOsbP6sfT?=
 =?us-ascii?Q?hocLM8V3o61A1ub4UAYhYSOR2duzlCjUxNK9Ru7TPA8i1frbCGn21wv0Ylt/?=
 =?us-ascii?Q?Y758Kd+yEp9qTzyEIMo6hjX9altQSQ5uJZMuqmeCkzctkliOOQslvXhhLefA?=
 =?us-ascii?Q?RFaLuA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978c6326-1a33-4a6d-59c6-08d9a89661f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:49.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7vYpqNc+wyfFEMA2Eckz4GheeA6fPq8VdV5ONkEnQEE4/6PlUT87YT2KWM8FuHDwOSFlJfLcEEZn+ljQb0P12o4ngsV9DxkPcRzr3fSHOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: qEVf_Cf4JcmPX6MHI25OdA03U_Zpygfh
X-Proofpoint-GUID: qEVf_Cf4JcmPX6MHI25OdA03U_Zpygfh
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
v7: Unmodified from v5
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

