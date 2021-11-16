Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6AE451CA5
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbhKPAWE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353558AbhKPATy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:19:54 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNHFKB029766;
        Tue, 16 Nov 2021 00:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=r6jlFALx4QhkrsFTEgTPRs14tJPwa3/B8j4XEJAgbtk=;
 b=gvVWCfDBN15ofXQhew1VC3HVlI19M0krvqGhpFkHte5tiu9Vv5Qi2lKkxKgGmsm+77ov
 I4JcqgCJec1qNpSn6ODOwz1GTJlCvI4QERVm0cJyNVsCopRf7I4jnQ5km9XBeZG1N3yq
 UiAwD6x7C260k9u0Vx6p37HBNenmnExIZiOZ2QHdbhM0gng//VWGjsxl5ZEnkK2NdEYl
 8LLJZiApoSOmgI2xkeP30za8TlFpqcYzjS4OmIVXrzIxHptco4NCwmMwjApvNzi9qNbX
 6HM6BX3dRVyT3SlHHSPgvvqXhA/uLSvoI+/0sAWc8IXjdKS8RMwQVAhgTk/Ox7KkrmSM QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnp3pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0B1JQ046349;
        Tue, 16 Nov 2021 00:16:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3020.oracle.com with ESMTP id 3caq4ru981-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6xvYTtAl84BDJr86ISEpLoPbcBkPJA8gnosrOayCPRQZiX396wBjH+W2V0TKiJecUS7FtuIqQIY1qezvx3q3iakaoZrQ4YSLtAuHOaKg9lwxtPgbwJMxtDzpUk3sms/11DZZ8OXC4nzWaL3xRsjBDToSGffwCPhUvZQpLTYYzhcszDVrb+g+UKA0VKC/y3c8hrwc1aMSsOUDJS57767oRF6YhmcaKwqwIM9UrvgPuD+9d034/+1PmNrXzUnSXNPHPtv9ohjSYTZJ7o6rOqAXaL0+jg6G6CbGUPqSL9vyFeeLA6pXhSPk4anFUCCX6ThLAfs2WWPzJCBJpil2GDWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6jlFALx4QhkrsFTEgTPRs14tJPwa3/B8j4XEJAgbtk=;
 b=O+TmjrqwJt0EW1fp/S/yLIQhkLmjXBR6j9r2fccqm57XoUCTpl2tt4biR5KY0/OkG42CVTmRHan5c5mKlMwlOu/38beQMT5GJa1acXDA4epbjCGDaClL9FloQEURYZguhANwA/NgcqlLXQdErBHGRWKwDF7wowg5yvZTDWxwWQu7DkkGf4caHtsjj0YU7TabtNnhS4PsXxjausGMp7MestZzFtV06+go/4dcZJZRx80WRzELqykMqYzlEMUhUqtE53T9GC3fa0K0EO6ZTtnCOkS/C87bfzglKNyMql/uF2QzR8IOv70y9YKp7eW+QLFVEx4fbsiNg6m2rUssY+KD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6jlFALx4QhkrsFTEgTPRs14tJPwa3/B8j4XEJAgbtk=;
 b=fgnF1AxRbkTf7IRyUTfzWNWtti4v3gOYcDduAaAyy6Jc4iE1iXjkmFivnpWM2qaUDqz6FVugPpOUQDX5uGmUcoQPtRrgsffsaw5qm4fMR/MjUZ1gbgq7a+c0z7f6VbouHw1mbZ4zhsQzu7+dr6K36ct1Y3FJguKcRf7lQnjvcwA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:22 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:21 +0000
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
Subject: [PATCH v7 04/17] X.509: Parse Basic Constraints for CA
Date:   Mon, 15 Nov 2021 19:15:32 -0500
Message-Id: <20211116001545.2639333-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c58018-814f-4df1-7292-08d9a8965176
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB527697176FB414C9A9045A3887999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxDaA+B9ADRVDxxlWatpFXf7lFbcoyLMnCjSLXFLx5/Kfgbaz8juMtj8QC82EYQu6tMLgRZw2mZlmRNZSfn6rCwf1k09P69MAwfSkJSWa+B6K2lJdZusMGKxp4Hltb1/PuZHNKXhNFJ/qnlrKQLjLYtYQWh7sxV6lLuoxaAONscctncB9OqZGDEb9pDEkNhNr6frLq41m1tLG8T5R9bfuo7l9uqzXcNicW7oUvP44MXg0MZ4xKPCeVR56rvqlJ/6NTURSBFwScn50OZ3hVxrWEu1GYPL68H/JS4CsLYCkoRqztd8qPhg9r0VQMoyp4TcUBqVYxdxnxxpJu7hkT45TziPdRxnQ8xt/Hrq6CcaMbzqSejbZXeJrI2RqZdBs5Nk9sOl/7B/em5LlUXob+NegUg+pxFEKJQ9NJ0bF2u5gJ3ec/GFVSy+981Lv/TiaTVuG4IP28GkHYfJ4ND9bRo+QHwxv8WSoD3ot7rTdQxiYN8HLXFUzvb+jzQjHryPXvpZr/uJa17CtummS6XBAUc2MEfIjq2TsAj2B50Xaj21TTSMVb5MoYh9fd2fgS7soe9HNb6GDgtALPPLkA0pgch+QRmkdvTqndGJnv1Kwzcf7K8f1i5n6pC9+FesjGPsTizbLFbso7N1MsJSntuJlQREZ3SrBJ5+2KnpT0xFmfMpcYYsp/1k0ecvDzmZS5PmM5WpvNSvC7M6tF0Ru/gSLvUKyFVMPq1jkoRBpHDhThF1uWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KC7C6i0VSRAnK3yQpP+pcA6L1dGJnc9LfunLIYMLpE2J+PDfbzhRD91RnUgE?=
 =?us-ascii?Q?83BAZhPPEABpHSOdn+bsgerIev+GW250dSGzkqxElUl7IbnYw2kAvXfgNDmG?=
 =?us-ascii?Q?9nJI3OQRTzUZQAZIH9XqiSMHNOtNiG9yorsholirQoky9tASWTzFbyxFhjsv?=
 =?us-ascii?Q?4rQbGIGOpzCkm4PO9j6msOve5sguWHzCqGSZCwnI8I052+O/UifEC+NFhqn3?=
 =?us-ascii?Q?BDoQIjuzOAoze45ALUMNBVSHTzWrsiVyTZXP5o/uDuGF51rKgV9o51sU/8Bh?=
 =?us-ascii?Q?bEL35Zwgy+qW2D0aZ6FA8YOjQrRr936Xp18rb13mAB5QvinqY5ZhPCzOgrId?=
 =?us-ascii?Q?R7MWWReX0AdGtVrkwiNvvLYA4HP3FQhkZsAjk8LJPSDVy7BlKIatX3nBnN6i?=
 =?us-ascii?Q?rm5EhfMvbzVHC6Ct/4qtI7PxNCBddJTAJlTVJO4Vk9B2bk960USg+dGB4Ivl?=
 =?us-ascii?Q?OQSMbX0DdV3CJZh3jvPvnwI7LXCqwZsU4KBkRhQo766Mv080Jjtw4qzbFWsv?=
 =?us-ascii?Q?QesYFfF/AYCMrwlr4zC3N5w/TneX52jgJuIguKfWZ6JjBlgdiRUTbkdZlGuD?=
 =?us-ascii?Q?yAm9/LjRNB/QJXbO+qzAcORdne6/foytAgdOJoJytGwuj63gbVOsj0/ymcyi?=
 =?us-ascii?Q?SMXmlPtPkZgKgr2YyuNqztkxhTPH9YHgm5+YM7lzWaAKSb8d4R53A4NfxX/6?=
 =?us-ascii?Q?JMCOi1nGt+ZD3bXqiqiXyLT6eJmDIzvvWxFIh2Yr8ZLSpmIRgfz+xiymDMXA?=
 =?us-ascii?Q?l2QBkl4WFVs8Bb+xQSDSoEM2XQvy5ZmPPsNSwH+gCLA4q3+LH94u8F/OxO5i?=
 =?us-ascii?Q?H1b/vv8f8nhzdiXGQGKOgQCivzQKc9qOyVoZLMwucatU/F2HDZq6Vy7WxeXN?=
 =?us-ascii?Q?G9bqiasn3vB3I9dvghA1sLi0VYJi1fdSTFCw3fhxT6tsnqLVmsLdkpuytzGx?=
 =?us-ascii?Q?wk2sYdOz9AeFBJyatUd4AwwVDfExFEBb7V7Tgw3r8wIPJ5ByUKpFvyVG6C4b?=
 =?us-ascii?Q?pcr4FawASUcqmJbX4C2hGBcnUe363rrIFXdnXAlbe+xnLP40tMAsMFFzJCgD?=
 =?us-ascii?Q?dHk2TJaRpGa7ppAC3UWDtmAjQ1rvxxBlq1uLL+Q92jj7v6k3cCU2wL2FjU8k?=
 =?us-ascii?Q?mnOiX1Q86EteRQlJ1OGfeiwS3a550S9sNMDUQd3yZVHk/rWZJZVPVeD+iVP6?=
 =?us-ascii?Q?vAp0DwwbVnQyycxanPPABBukteWHf273GgVBnaKaEkmxP6NU22XzPZNfdIay?=
 =?us-ascii?Q?kZvsGujX2HLna9mDIs71jauoTnP1GgHIltAVf9wjBYsKc7zVYluDq0f4F3RD?=
 =?us-ascii?Q?ppd2t+tnV2NGerbZZzSpA87EHblBaPTToE9B6l3d1x+pNTrzzkWesEE8vKgg?=
 =?us-ascii?Q?WUAz3Aj5kp8dFQAvZOKTqMxAsav/M4YDUhfoULIdY2GKu0IbVNRJJ6fYKTeN?=
 =?us-ascii?Q?wx0Rz3/KbWABiHW91ppJqCk/YfiMlL4lxJS7Ahmky+yLxhJOJuziVhLUu1Qx?=
 =?us-ascii?Q?Xo/tzELwq7ufiuYnF14FVo/z8EApO4VaXwv1630OlGAEludJ0nPcrFGWidkF?=
 =?us-ascii?Q?HVrOsgjMhaZw+YnqRnJ2I31qq83t7hsoYcbxUhk1cYJ8O6/WQ63+e7ihhy4s?=
 =?us-ascii?Q?LLC8tAZocfUKbHmJMfwHcEaTnDTlvAUgeC8gNLtv+fMLFZWM0XB/9x1+e13O?=
 =?us-ascii?Q?5VVJuw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c58018-814f-4df1-7292-08d9a8965176
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:21.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4X7KaHW/Q97KceZpGeJVS9r5AwsjwsA/gndnbsdCz8YIP29boR7Wtg5BnMfr+MBNZ6FVFyBRgLBradNyzhBSDWIsTW2zdGwgUD6oE61C6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: wD_EilYT-t42tzV921DGM39TcuOdGA2o
X-Proofpoint-GUID: wD_EilYT-t42tzV921DGM39TcuOdGA2o
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Parse the X.509 Basic Constraints.  The basic constraints extension
identifies whether the subject of the certificate is a CA.

BasicConstraints ::= SEQUENCE {
        cA                      BOOLEAN DEFAULT FALSE,
        pathLenConstraint       INTEGER (0..MAX) OPTIONAL }

If the CA is true, store it in a new public_key field call key_is_ca.
This will be used in a follow on patch that requires knowing if the
public key is a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v7: Initial version
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/crypto/public_key.h               | 1 +
 2 files changed, 10 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 6d003096b5bc..f4299b8a4926 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -571,6 +571,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_basicConstraints) {
+		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
+			return -EBADMSG;
+		if (v[1] != vlen - 2)
+			return -EBADMSG;
+		if (v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+			ctx->cert->pub->key_is_ca = true;
+	}
+
 	return 0;
 }
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index a9b2e600b7cc..61c66be80995 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -28,6 +28,7 @@ struct public_key {
 	bool key_is_private;
 	const char *id_type;
 	const char *pkey_algo;
+	bool key_is_ca;
 };
 
 extern void public_key_free(struct public_key *key);
-- 
2.18.4

