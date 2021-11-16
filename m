Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3625451CA1
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347282AbhKPAWD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56148 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353441AbhKPATx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:19:53 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNNR8h007673;
        Tue, 16 Nov 2021 00:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZGxaux3O2h/UxHDxxRko9/8hYIcYj2uByWULJeccau8=;
 b=VKtnBwsetRNWK2k0+wb8ACHMaLFxTrqw5zOf0VY0gfMtCNJE2+7cjkU6vgnxGOgjgRzq
 EWbgFpsixVEI97vHLB883dbWnywhnfJD3eEUfWFirukiy0juAiVBWD/n3rkM/6z++if0
 ZN57ZbWficKxvtVq/uYMH/YqU0udKyr9O1Y/OsBSE1+uKijLhdI4NK8F64Y+0Hs3emwM
 KfQnLe6X6mOJLunYt3lMlyiuTbDm1gnMx+oMuZS2TyIxDrX5kyfmrk6oUKqxvku5yjWn
 TewM47hQ0yJax51I7gjJO37NZq4sToW4np/gBDt9iOH2tGX0X09UfNsJF0hCPp+l+VON /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv5618t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0B0Za046215;
        Tue, 16 Nov 2021 00:16:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3020.oracle.com with ESMTP id 3caq4ru99e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP1r6FAfTPMULYfWCUFNL2TVV08vy4kQ49K6OsttmEszAS/axqpmutE5AypKBiU6p5YWBRs+f60moXxmMU8FO5djehlZ5jBQrU5nMPAof+kw6AxP29CWA4lNEaW62jHPkKxRnKcmNwqwDNPmmgYNuXyIwA8utNiL/2q7rAbi5RBxJgmODniSYww6gSBolXAQ+ck6t/FGdnyqx80kz2M1acXejGPSXnw4Nb2FO0CkNZocVEW31rdHhrDVBYt9AEhLH7FP1AAAgoOSufoz3kyipsabRzCRr8wltO0iuceubWpa0K7h3V4Bt3aF4FoJV/Yu0K1pdCAifh8yVA9LIu8fcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGxaux3O2h/UxHDxxRko9/8hYIcYj2uByWULJeccau8=;
 b=Yut9clokJcZElBtsuE/sDDzICyZ0ywU5c3GZlA7CQuPPAi1Av1A7mPT+6iK4PMm1wLfiA3gJQP4imjL5HPs73EgA5X20qIe7fbcrQTuJH3MuStLywvvZuGwH+Dq5IG9Ctf+RRuU0D6HksTScjVejcaTPgUBtOD/dxbjXTkf60AslwCrWPSM8Dj0reEYRbt80CDDWxrH30NYnIG5tGXEBc79+UqAeUjS8MrZ4vuZR2uKw6/258Bn091tN3l4d5pBjCdDUonWSrgCKYSDjXF6ighEY2exjCT40mh/PfRhSs3+aWZlbUxFS0QgFVfu2mE2VZxmv7BTYafCuhF4sERm8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGxaux3O2h/UxHDxxRko9/8hYIcYj2uByWULJeccau8=;
 b=ajmb4aGNWNWsElo98e6hkGBsx0o9RBgESYCzMWrlKSQ7UmcR1RlxGBVxtm20/gr7P4LqBMed2Ab0Cv+kcq0HzfULPVoMTWn3QhTGNrXzHpuPM8SAC6wgWanh2jY+D0aZoeBM5/eK9qw/5VZCPwWuP/GXpuI06KbTW30jcTusams=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:25 +0000
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
Subject: [PATCH v7 05/17] KEYS: CA link restriction
Date:   Mon, 15 Nov 2021 19:15:33 -0500
Message-Id: <20211116001545.2639333-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee514baf-4fb3-42e8-5d4a-08d9a896533e
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB52763E0A07DF7C4D80B5A7D387999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMMXPqd9W/fhDGukWsjRsO2lmkW5wDyaRBlkPDhEbzbURpeq9BBdE9LuPPQ1gPp6Tr4ACMsSeFAr0ZatkJL/Cvsu04lcCA8Gs5w4cvRpXAeVCWf1720Lthc/h59R6zNWO9mOoHLw6Wg8lncOKJ9A+1qu71OX59q7zUwfH7LFTpXoO1gbKRaG/AeKqt9VTblOwjYqXQ0dxhZ4v25QKVbdQ/eqANeQfdUKRw4IVfsgvBStEANd9k3JWzNTJMKK8/CrvuleaBLC6gDS1F2mwsm13VhWFqy6rSE/fTsayvZXq1koA1pZlP/5zOqxvx5x/1l0ldjW0PKABMBkkz0YmiRP/DThl6e5wO0yiqPkfkvCmS2zF4fAYa/dLeAfNCqnBW91CUeKzvIET4wIp6w/VlAm2HI0LQ0V/k/2vpetufK7A7g/UCoMnoGOjM95K7QIJT7EnKShfn/O5RcolAtayOh31l/TwDo2DTlMfbCvhdlnd8cb+8l9/+Grf+hW2Rw57ytGkXzRK06LAnbr93TCPprz+5ZET9A4JEbwUzlT97BIeiE91N1zorpfI+zN63Hvx4TIfzq3gKB8sO8jUFncmrGsB7Rh1S1ZvnJLDAqzBSQB8EY0U5bqgXhRbGXg+fF340LB1QBTgYrPpNPeqM8XFZKftSxTcGSeg1nGg8bXqPMKCtM9z3YTjB4001rwJzpCZRMj1ob4B6JPtkDReVw4k13fGQxoU7uEVw531q1Iyzc7URQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(6666004)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsfTyvmBcxWXgNuZ+aYYrE7aI+geRfXJ5GopTEjmxpz6eu+vUrcSSYwZ+NCU?=
 =?us-ascii?Q?YHkFKPt0gPo4Nl1NYF6n4B6IxYGzaqivpHo+unEaR6R3zHb5tYg2vtdryVWt?=
 =?us-ascii?Q?AxwtWi4HIrnmo5UrcDBLoxlvzZ/5SN9AMzMORT8nfnWTgnAu56LyH4Vo0/wp?=
 =?us-ascii?Q?l3ZXw1BeoJaJNR82Hs5iVYd8Z7xPDgoFltLzFNvOIASNxSjrOHBBFtMx4y8B?=
 =?us-ascii?Q?He9lri0eFuEcjDwFCGASQPB3vfDsmb+9qE4EVIb9ATvZqY4NhUeUqHzky6nQ?=
 =?us-ascii?Q?FYOX5rDZKQSlRMxR9rFb4Mx87qAdtwZKkwldV2SP/6ZSKizUzkOskgZ6VuTc?=
 =?us-ascii?Q?L22OscXobjnpce9YjoLcR6XnqkRQhy4YRANGu1LCAqacAgR8E8CDqTn0wybE?=
 =?us-ascii?Q?NuEGFfoO9EfL53czErspGPjuyUDg+Qd91f5AZauycPOCUSkV97Fbr2H7uygL?=
 =?us-ascii?Q?oYdniwKt+Wc5AaT8JPOtGtEALgUn/vn1OLUDyRdgP/LRU4B4TMeO/QYICvi+?=
 =?us-ascii?Q?TcipoHgVAiCg92W8nZo8YEt8LZIvQVrZNNFkGwCagdmGrZM1tE7ZG9Rv4A0I?=
 =?us-ascii?Q?8jpAlNrhsd/5btIiLO+nrpOmY8QAXqc60u7rpyrTDj3JnKTfAie3w/1HSvcm?=
 =?us-ascii?Q?JS6LciJleetbvaEl5vG7ZKNmPOGK4TCC/VhYwUz0MzaB3yRKGpANAxw4m580?=
 =?us-ascii?Q?ERgWyrSk6JeVFuvLOT887dIIkC/HPGtNFDwwxbgFpNPGwjQKsZJ7dA/iA3IR?=
 =?us-ascii?Q?gHL8w1bf/OJdx5NCuFjFXRNKWYq4+RTzYPwGrWXAOF5v66TTg1V/yxiOviOv?=
 =?us-ascii?Q?jU5toTj1k92x1t8MJseek1LoCyucsMMEBauekNvSMNzXl1nxAKqGeBPxT3Ho?=
 =?us-ascii?Q?YvDMzAuIKw8SvdZd6s1Bc87WDJdZnjqlN94So4dxSRyTbAhbaIp7SJO6j8Q0?=
 =?us-ascii?Q?cJ6W7tz+LMlg1BGoGudr5QPY9HFdQRDi8DAtW5pYPuWCoYdl2juieJ4qebSi?=
 =?us-ascii?Q?MkFBRajSwupVW6+/Mggic2BOMjI+142efdiNEqhgXzYlBoEnb1WBieHkZE0+?=
 =?us-ascii?Q?CyipvdMis6yIest4HZDD13fVn9sGNZtJD39rm/uQE6ESTA4fA8gRxTAWZPsy?=
 =?us-ascii?Q?vGQe+W8syPyQyDcjHTEhRi0onpkmcFV35gzTien6BGjHuWbulRoKm0PTOQlo?=
 =?us-ascii?Q?9dwfx8jqCyl/dnNEfL22b+5vyCk4mpmc4ZmRMQBFpoGJYibzKXvies8I4Ggx?=
 =?us-ascii?Q?shPmVbPUn4PC6aJ3j38fRa3cEMqHh1zWdq2l+7pX78OpaqsUp4qR5S6PpMEW?=
 =?us-ascii?Q?dEyBQdL+XQbscjqDc07wVvaJuIb5wIxkkcyiagEj447HMyZxTcX5xaqVWMjQ?=
 =?us-ascii?Q?x5oJpcr3UKj9HhqQH8eywbXJP9reiCwsffdkI8BLyxXIR+z5elEPKqZMxveH?=
 =?us-ascii?Q?xXB32XUOaKVyPRGqaHFak4QRIB3NgskKAbh+i2AF9rALrRt167uGqcJ9RY4E?=
 =?us-ascii?Q?G+wFCvK+Dh0klO7mymmZ87dr5dQKj3AD2uuIZ05HtzjvvK0gl7KsXknyXW+o?=
 =?us-ascii?Q?WfUqTGD7GYHmWVzoaNC2bA+ljFIMDis47P1o4a1B8Y7RtSmye4ByTglPG4ex?=
 =?us-ascii?Q?tSA64fOu0Xjtnsx/QMKz/hVeoJcPwDTZlj1LtdPvTdZS+pwtC8LGoCFcmXmG?=
 =?us-ascii?Q?s2dl6g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee514baf-4fb3-42e8-5d4a-08d9a896533e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:24.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKw5eTNujBLQpPq0/pc4X4XK1gUsdoSRXnbJbQHM0iV3pSnlUzObt8ltSnnzjL3LDptIYkgkVhkmiqG2HR6xmABWXLdybsmRj9EeIPfBrBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: EcQ6973E1rIge62BLoJYw7ZPQD83W54i
X-Proofpoint-GUID: EcQ6973E1rIge62BLoJYw7ZPQD83W54i
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
---
 crypto/asymmetric_keys/restrict.c | 43 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       |  5 ++++
 2 files changed, 48 insertions(+)

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
index 61c66be80995..1e4fff6b7820 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -72,6 +72,11 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
-- 
2.18.4

