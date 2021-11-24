Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749F445B343
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbhKXEpw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:45:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48540 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240954AbhKXEpq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:45:46 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2fhmP011762;
        Wed, 24 Nov 2021 04:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bvXxjYGT3h2SNgYJLIBmSebaLZWXkiEYQkpU0HByrOg=;
 b=lnlDfL3xbtRWKnBbXDUX98/hkrt3O1PcOQoLhAzn87var60sYXFqq+Tn9iNTTcztvtrG
 +Uzq1XTVTNDWOLuZF8Imt0CdB0ye1XNu57/uHQOtSeLC5vkckevYBCFjGkVjFoFDFjp6
 xKW4MMyyzg1uW++aNpZo2725aXxpbLScrVbcf/b+6inLWAGOepOAy6isjNM1iXZg/AK+
 m1BSSHYHdl7S4Kmy/2bWqGwxxA44u+AXdi5e0uTEOk82ElW53Tu1dC6PfALzRjTB3VNr
 UzENUuKO70nY8nFOwg/DuoK4IffagXQ+XMX2CQ2pNRcsP6XwZEgzjV8oYyzNTJq2sOZA dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gje9eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4edig036824;
        Wed, 24 Nov 2021 04:42:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3cep50s5wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKqlLMphWkz/kl89lSwKaqDc3ZjyA//zJtgqtTc6USRO6uTJSiIr9Ed9+HYOhVPgP6zW19Q7Q2e/0P0QSxyIXiI0lkeGJK8MFfTFt2r/6qJvjnmiGZFYXh2j5Bivz8UeHybdRMdZnKXBpcFTViNrZQmHCfjT0QLC8ttUb08gxi1qNy5toYqiIBcoNywNQrg/uyyrHsym4ipDL31fIoUPjI3Bx8ZKtPDFJrskC+FTe0kYs0WfV0DHpbuTlXsMTGiXuWzZz+bWI/j6jeCrutrCcufR6kOYay/FpIsbyf9by04Sk7/BMtcqPnzLBefZmjkdi0wczKDIVea0BINSOGArvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvXxjYGT3h2SNgYJLIBmSebaLZWXkiEYQkpU0HByrOg=;
 b=ZJV7+c/UY8M50jOHFTOrM74logit3fbq4oJZMJj2+swCOPKeaImHR0ajSbGNQ7Kb7fhD1yBcNeCdwOHeoIm1V7LlsWpHdulI12C5Fo5bW6puJOkgL5e1s+5501zA3Gx9WM+7FBxGNo3mhOfiOVqE7z1dP8jm07L1QclVhuOu/8IBw5FFekYXG0AYxF7uhmougW20N3dvvL56mLWTV6KV6VzB/v9/oNIxJryj+Ym0aoSZBf/kc9bwYyNwT5UUTAK59MmHyFNm2CTD/ZAcHiWdesSv02hJn4oJ89BVY2ZLYRZmq+5QHbLJS9jAEVyDeVQlX0TbPmhV6p+LglIwVQuxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvXxjYGT3h2SNgYJLIBmSebaLZWXkiEYQkpU0HByrOg=;
 b=sZ7v3b1nTyTH5KDl0MnAhI1idk9ASHmFFiRhSicrmzssFQAupfYjwHZbG7jTeNAOLivgGo+yUW4Ob4oKhiFfs9puz6BC1y8BEOVo3m4GwpC7YR5DSMeUrDy8KQtpSjyCR0MRkhCF0gwwz37wtXNznEN1UFyVFgZd5G/QDjWqeJI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:10 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:10 +0000
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
Subject: [PATCH v8 06/17] KEYS: CA link restriction
Date:   Tue, 23 Nov 2021 23:41:13 -0500
Message-Id: <20211124044124.998170-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03347e19-07b4-4a97-7783-08d9af04c6d7
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB3957CC7C9BE04FA4F4E1C94787619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsNptWKhu8LpBy5yteVaVXkoJE2TeDnjYn8+npyzlsY6VTJIZv4Sw9z4Fv9NRpTTKSvbsYUaXywXfGkmo9baN9CNgwNG3Gxwdcm3qG8DK79NWblin0sqzG4UoDVyYFoCHQO6QqqEpB7zbfEwX2EZN4or8OyrRhL1/VQhfGe5zS3wL4Ah6fkUQ7WbjGh95c5N5p/m1FdRgNtki7Z3MkttA79bQ5FDPcXXBtRW8xSoy6XOEdRUj7rL6LTtXMdrSgsMzQSTXONc+gVwY3L8NkFyaOV7SQDjUI0h8NObRuRGHBo5uLsmOp3DnwJVC6+aikbAqGLGu/ogfIjig8QEOTGxMd6dCEiwJjwIEfMx17TJc5W1yujUKYjPxhCebIkEOJFCsbqlrDH7fk0sPeBGPaQ+VbgsodhGBvt4C8psn8w503krlmEj6LS+4LxyGguIY4fE3wYkHH0kUaS2BItYuEl91J9zP2NIsOyDEBkBVZClhxmkfU2Z65bYzZN7a4DHC4Rc6LSf+3UhwaR2Jekxc3xppBQPvkZjzrAQLc4yy3XfsqcfrWwQSNMc02zHKsX0xUpkht4hNZQsXB8Y/tKo/7L/gVPYyINUtQq2m7EYpL4koBJa7pG9oTM7HjDXWIXb0XAuEPF4N9apLjZw2/OfEvzGaZUifw+MAqtIiQBkeYfTLx2vjHB7aEwWZTJcuX2L2I39ytIG0lBo6quLM7x4CHyHoIOeldhK1QvObHaWMzd40AM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zl8CPIHU86XDwPJrATuCcAQnXIJFJLlNnvQVn0r96F5KR4djx+izoj0mdq9U?=
 =?us-ascii?Q?yq11geLdv2BAT97PtY8EJC9b7Vx6khJmAGgsVqPljSOOEv+rGREkReYP2Lr4?=
 =?us-ascii?Q?euNbStJZgVdoX870IMwRpk7amzlO3os9Me5HjmqD+WJshBYb8eqbU0OBQupr?=
 =?us-ascii?Q?NytgmkwHeo7xbCzSNgcS9tZUBc6g3zwRVaPeOi60lOfP1ibqVhEipy/nkTj4?=
 =?us-ascii?Q?ZH6LUPSIWV91E2t7Ti4hVpeWk30/8HjdA7hf20rZ+ZJ5pJjriD5IVCcOGstV?=
 =?us-ascii?Q?NHTDBvgT8HGNUG6M1VP+yBZZTuP+PHw20MFW7kalLojrJuoHq/XwqUKgjOCN?=
 =?us-ascii?Q?UFvAhzm6MWITXydgRKoqIY+I4l9HjonqW73SmkhNKuvI18mLHLxUrHHoW9vA?=
 =?us-ascii?Q?iVME70P44v9nGiDh5ccmtW6e3gu0GndhNNqiz3chR6+wZcuwW2p/pyhiZwtQ?=
 =?us-ascii?Q?MFKkmi3WfNHBn/dAIkxF3LmnZ1IHD2vIW/GSROtTp4jXzRoKky+CeEnyQU1N?=
 =?us-ascii?Q?/s8sKiZe4NLN1Wl3hio3vz1IrDYzS/tUKoa7AZ+DJX1pyvl9pclqVtUyfDgr?=
 =?us-ascii?Q?VS8MqUBVu2ybSnOYRohK8UnTfA6AzTha2P1t4D785bP8wp3znsFewSy6hJMr?=
 =?us-ascii?Q?N7uHbNnLMFDyN6Ex82pzaYvFCSbnOqEs2Agq9IQfvj6cnYMiLduNpdvFToqa?=
 =?us-ascii?Q?m2RzXfZwGBKLgblUClPYfsg0jllZYOTx8bBxEwQNuBD0hUkYTjhW6kW8Bsc8?=
 =?us-ascii?Q?GKtNUcudwEUNJn/AoHwHW8lbms/mYgdovhy6fHBN+xUCoTE8UhQ1A9UcvapO?=
 =?us-ascii?Q?Sch0275I+946B7LM9fplxENObGulcFi3BVCOWmFuh4pGAVAGeYurETLf4wSr?=
 =?us-ascii?Q?mdN7KY08sN3eQ101NKw839Us1HBjH/H1YyWUbqjh6hBh/xufzc98lcXIXk/n?=
 =?us-ascii?Q?reSc+YTR3Fde5qyXfcHW4RAY41mVUzHlyQ4t8cK/j9drToGfZyYJby083656?=
 =?us-ascii?Q?jjsh3XX2jEmaoDXY3iyGdnmd/nCP93FmBBE0T2t2cYNx8uB7n8oigXqIM9KF?=
 =?us-ascii?Q?50WnXfxltC+8Zgh4Abo7neaa1x3x1RHysHo90eq51BHtfyky/mkYFlMAWrH4?=
 =?us-ascii?Q?vsfp4kz4a54I6MDauKUvkNZaGburT8eL6wx2UIj8ecbGzFIEYiqrQmh/1FfO?=
 =?us-ascii?Q?RkQvQUzIQ19XnTQv12wbl1z9n0eF6QoviXQ4Fg1DXVnmpDlm6LIzBifZ4OA2?=
 =?us-ascii?Q?iA2CyIfJRe/XTO9EmfKVJ7uND2TIPJovIcN439CZaTTzIsJJvuqWi1y2/GL1?=
 =?us-ascii?Q?a8sBCId4v845kuVFXk1+sGhu24uh0MA3330Q4wuMNj18hcGM8ozzW5wppuZ6?=
 =?us-ascii?Q?ygjDxD+4RxrDPpaQe8ChbLcyzBQ0Bx5CEeS0uLz1lV+sr7CuoSlrgv96Vfnu?=
 =?us-ascii?Q?iyys45kgfZSm+1rKoo5DK5vPu/IvS8rNQExR8yyzoOca6WrDHlXFXe44JbII?=
 =?us-ascii?Q?OV2Mz0PKo3bkx3MtoVxvfjexoYhCiNMn2Cdlcg2ezdhQmCieV78RZBXicRig?=
 =?us-ascii?Q?3O6d8JmqduhbxI/dgS2ne+4sRjHhBpBaRwJtIRDhXQMCBNY2P3e8LkScg508?=
 =?us-ascii?Q?u0mdKAt5b5O891SMSV2A2UByRTFo89hfQJJgTLlz3tROA0MFKKtJJuupgXnf?=
 =?us-ascii?Q?wEZtQA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03347e19-07b4-4a97-7783-08d9af04c6d7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:10.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVTrawcshi82ZXvqc0HqX0WmsTJcw7xvic1VOxvf0Po66HOpjd5WlbMLPmiR3LQPSbjmtNZdadfy+cyrDBgeM0Sj9sFfjSXzUTwtVoVda6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: 9ZIcgZvZ1sto9nTS8Q3jghwjasXoP6Id
X-Proofpoint-ORIG-GUID: 9ZIcgZvZ1sto9nTS8Q3jghwjasXoP6Id
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key to be added being a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed secondary keyring references
v3: Removed restrict_link_by_system_trusted_or_ca
    Simplify restrict_link_by_ca - only see if the key is a CA
    Did not add __init in front of restrict_link_by_ca in case
      restriction could be resued in the future
v6: Unmodified from v3
v7: Check for CA restruction in public key
v8: Fix issue found by build bot when asym keys not defined in the config
---
 crypto/asymmetric_keys/restrict.c | 43 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       | 15 +++++++++++
 2 files changed, 58 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 84cefe3b3585..a891c598a2aa 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of CA keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trust_keyring: Unused.
+ *
+ * Check if the new certificate is a CA. If it is a CA, then mark the new
+ * certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if the
+ * certificate is not a CA. -ENOPKG if the signature uses unsupported
+ * crypto, or some other error if there is a matching certificate but
+ * the signature check cannot be performed.
+ */
+int restrict_link_by_ca(struct key *dest_keyring,
+			const struct key_type *type,
+			const union key_payload *payload,
+			struct key *trust_keyring)
+{
+	const struct public_key_signature *sig;
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
+
+	if (!sig->auth_ids[0] && !sig->auth_ids[1])
+		return -ENOKEY;
+
+	pkey = payload->data[asym_crypto];
+	if (!pkey)
+		return -ENOPKG;
+
+	if (!pkey->key_is_ca)
+		return -ENOKEY;
+
+	return public_key_verify_signature(pkey, sig);
+}
+
 static bool match_either_id(const struct asymmetric_key_ids *pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 72dcbc06ef9c..06e34d3340c4 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -72,6 +72,21 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+#else
+static inline int restrict_link_by_ca(struct key *dest_keyring,
+				      const struct key_type *type,
+				      const union key_payload *payload,
+				      struct key *trust_keyring)
+{
+	return 0;
+}
+#endif
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
-- 
2.18.4

