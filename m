Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739B949C18C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiAZDAJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38998 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236714AbiAZDAI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:08 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMmudT004068;
        Wed, 26 Jan 2022 02:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hsRlw5cUEmCQAxmM3T7lF0RRf8E+tm9TgS/qrdHKXHg=;
 b=GtmGtZvNeHJ/3eeJJt9a4wT/3PIcMKuguwq7WhhMknQvbykerEG2Ip4mFhIpylFFXQp5
 1YugunXkAoLmG1eWKk3MSCLRU/BBZ8Od4vNWGJfOkQV0cTDb0ramnNX6JsdiB4t1SgCR
 ut0EyKH7zW4k6iI9pZOT626DEwH0kQ9M+z5+63melvOAxGTLKLVb8ADSmZt1X6yy6uhX
 E3lmK8nb6FZ21M4CChWCsjfioNplv5xutIBszf/z0yOWP6GSYX3Qg8G5vJLAiaaVRo+Y
 pt9EqAgFV31VUhdUHERR4AMcfCcorwHrDpAIPfDFkZVe9YNCYn3MZj2SNnatT0WxuTNt 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaad0xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oxIC079584;
        Wed, 26 Jan 2022 02:59:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by userp3030.oracle.com with ESMTP id 3dr720979h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5O1SS1SLgQ1yOaX81Knvv4neAIY717vJ8MWvg7/9O6x7qM3o+1uW+6KNsymy4c/XptduHz7Oi6hDGI/ljT9Au3In7jUOnGf6QdTzMVFYN6t5nc58Fzi7XlHbWPVYbuGFfRk94dZyn+tuRde7WdyL0AJdcjcbSULsBIwtcZhcIPqzpi5Tp7A/8byPytJreUgZymQJcE/hu0tf/JJ63zfWH64MY9ec5DhwKygT5q8KaXN3Z8NET7me5wrHXF3ycxqP2Y4O+hg0KYkr8s79h6xYq7l6OLJb8QWPhtgZSvipNZSDyfKYphXPvoyWi/t1UJ+FqaBY0Bd6vsWrHDjPh9Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsRlw5cUEmCQAxmM3T7lF0RRf8E+tm9TgS/qrdHKXHg=;
 b=HLhJ53l3n8ZOYjIHg5+g0g540eRKY5s8IdsRrR8ucOMYEDv+pt9GEcfZjVocViFk4PkbfJ1ukxUpWQneqBpLd4BmTleWajo4P4BNMq6pTHi7ZiWq5nXzmtoGwEPIVpPZLUcrn66eSZ4rq22kG5eG3GlkqpiDbFkXMc7/xrrZthq6GMvoPs0ZbyGFuBYfUyNWJzwLDmVPTUSkUDCkGEt5W2mLQ7jZGgbFkNG+Lkxb0axRgLc/FJiV8m7J03wbEcMxdIbA5DRILMjwPewVfwllhw6tq4furEmZGHPkuUQod2fmIUntI5CL06FghcWfCWl46pNGp9WmElbJgeJlgREw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsRlw5cUEmCQAxmM3T7lF0RRf8E+tm9TgS/qrdHKXHg=;
 b=B8Y0qbhpZCyCY0paCa1cHO7ke7Ovoc1ZDaMt/7h8IHx0RIgv5NRmzZvWXKQHW5xkiZoUmHw2uC9yW4oLqSagCh6G9hW2oFbYPPyV6Lc5+Q+6BF7Xj+C/R+5BI8TD1UTGd8sX5h6iNKc5Z3JQEks+/jO9rJhpHRCL7BP21sAeeU8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:39 +0000
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
Subject: [PATCH v10 5/8] KEYS: Introduce link restriction for machine keys
Date:   Tue, 25 Jan 2022 21:58:31 -0500
Message-Id: <20220126025834.255493-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39d77bdc-4d37-46ab-d1e8-08d9e077e496
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4654C33425BD555447974B5187209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQtA6gDIXthsDnE28XKg1E116mnFRKVEN0PewcnjuHKMBfrTRrQ2CYOrNbjfZgfzC8QaPHKZkBMUlPynfExcLZwOKfxSTcMwUEJkh5ts4OikaCxuRpo2w7NLmO0w3ssobDDq6D8pNLxM3kiSKzZp3OARlRgYqgcgoIvZ4cfDIswTEh78LrMw58t6Q6oGtHHNfubr6f9Dvx7P8KIjV8S8UuPBekSCHFR/TovdwuA4oGvh3EktvLYDyIGAHNADfz93zmcH0QSe8WnYHAByLgudxW2uODd6PZnZfUGXMeL8Tsd47668igT7c4f9RkPD4O/yWAWcldhlbZ5x9gudUHxO08Dde774PJSqgEvke4YpWc+ZGDj3D5+IG/ZBkqP8iJmc6/sxpKD/Uo1qJ5GKkIVAek/1J2N48+mIxdUBk9LNloJb7RmW28tbgbe5qUkgsao2bFiknLHeHfgi8CSAitgOpetg/HZnHVeA61bvxs4kSEVAZ8Rx/+5NT2G2t3dcrtu1Nq9agwvhw99N0JqvLOLEcLxCriJ2tluZfYKugub7r4kbKZZKEtptQgVdGh0c8PYhBfprkhLeW6WDBJbEx1hOUuAAfF27/N0hD+2XFHFiPs3VwckyL6gNNWevLrRCaYZcQVQRU6bZHW/kytm+EGlQbp6TQdr3TUNddXlbT60HvI7r7iaSAfMnJGEJWkSOnQXK979pWQbosJ5jaP8oYL93mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?35tARddnRdCo4qFJen5sUMvkOoXv8PUPdKPRQ3rHvqfhKh8tb7y3tjzaAlQD?=
 =?us-ascii?Q?EE9wtal311uIjlkRqBI4sH2H8ty4ZwXHAT13Dil4/SCRvnKsRvpHH6jrWskM?=
 =?us-ascii?Q?pKil36DBl842YfwDfF/h78C0+kJxq2Jt32/81AY1zhfDvsTJ1eCBM81oKCfr?=
 =?us-ascii?Q?jXH9GRnLXgaLcKwPAGH03VDZFtUPg3GU6TE4S23YdJJFjWfUKU/mM5MdaqjF?=
 =?us-ascii?Q?lI/9wcBmY/BhiLj0KJwe8XbmOAvvZJB0jdo5GQg0EKMWwFdztSKQuuhoiwmi?=
 =?us-ascii?Q?UVoFgwkXGkhODDnDu6VTVlQlcxYwfz1I85WcIXsQbPu9eKQWGO7cG2bPwVMB?=
 =?us-ascii?Q?h481Yi8TeX4jC+4YZLISTuOAq7BDpAhPv4wC4S2C7pittWKTAilUlY9PwOhT?=
 =?us-ascii?Q?qLmCWAMcxR5EAxTiyw7zyTnG95ookOejADfUnKlS95ccGGeYSXlFpgLFEqve?=
 =?us-ascii?Q?kxeHVx90NFAbglhnsKTE+bYC/5UCmUrqaMfksJPRpWPNp6MbASc2O/ie0byB?=
 =?us-ascii?Q?yrrIiawGoLs2v+DmOpo2ieEjgsOSiP8ppnatMhl5siFR7DMMj4m7BZYTfrYX?=
 =?us-ascii?Q?OWPEtLRmwWMm1x188QTm7gItHKHrPtLkDBToy/Ly2tqBpp4LLy9ZT4LoowjI?=
 =?us-ascii?Q?IG4PsLL94T4wGBsuSNhaC4Bzciu1sLb2PNs0vPXM1yBHrmHYZuSdSw2D6qMp?=
 =?us-ascii?Q?YYRjbXOrnJLoFS8cVCMf6/f5Qj1DzElSSBa4f9uPiUstCMrq8o6cGocyZww5?=
 =?us-ascii?Q?5I+5H152QsT+g2z8gVjuLx4z5uY8VujiL4Pc1VJGEyDsOZw6LAXuJRo8Q/jx?=
 =?us-ascii?Q?yt88gSU16kxcX/UekZRhSbJgcKQlse4+fVIg+o8W0Bgm14sOzXQ0x+Exd1Rt?=
 =?us-ascii?Q?jPFEC6juNN/CGsORb+rqJPcxpE6aUVvPsbIYRjjvwZiObUjRAhIC1E7yL+hL?=
 =?us-ascii?Q?wjlCUhqvsR1/ZCg2TJuHSiT7ina9fiNSZgmupoCuzj8dK7jFbT/yiQJq0Tc5?=
 =?us-ascii?Q?F/8Br2ZTex261DeJNF2zGE2384hsw6e8S/vHJlFb5EHL1o6GL2giWtiFK/Mr?=
 =?us-ascii?Q?tmqapLCK/WrSpE7vKE2RH1GsE0UVgcPadsw46ts4DvwtkYolOw3MpxqtR5Lm?=
 =?us-ascii?Q?o1pK5Bs73ZeG070882d83Sln9EnY+78SbBzulJZyRYLeTdGhUacBF8lLEDE3?=
 =?us-ascii?Q?F1AaLuaiFFiuz5WhDG2RtkyNlWtEFtn2aMeJZmR7Jss8vvtVZoMgcmHglIy/?=
 =?us-ascii?Q?CVkVQfPn8R2+sPDoapSmDq6RtKqaveO4U4743JHCHKHrArO9GIcWLHYMVxbR?=
 =?us-ascii?Q?l5XaHrA5FjW35JquZphmiGh3+be3hGN/xatFSTO7PBm1cB0oD3zT4iH+c0Qc?=
 =?us-ascii?Q?Ik8PAXZ1AsMgFc9gAUOZ/YoAG8Ey/RCgbz5FLzKwur64CjYYVv8dQ5UbkVOw?=
 =?us-ascii?Q?R0Q6yFWLvrMxp7TCucvQtROG/m41O/7Xy6z5hI6wZowxUejL9RRZrQu/N0y7?=
 =?us-ascii?Q?IqBTMUHW++DDSLy+sO7uLppDy2f/OQ3Xmhdj2Xnkhi+jTRMqpyPijWxJZqea?=
 =?us-ascii?Q?xqegUZBVC5KvaJYb5CbtRkYyqQwKEzYdVqzCNNgptV8ska1P0f2F4gYvxrto?=
 =?us-ascii?Q?W6Xy6iuIc3rCtC+ufRqzMfpOSfF2EQ5Nqnc0yBi1YzhQANHbq4v4pHVBqN89?=
 =?us-ascii?Q?zCT859iTQKG8nFwN9+p9gbLGSao=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d77bdc-4d37-46ab-d1e8-08d9e077e496
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:39.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csKMGBhyv0xMdFuSNx3Q0pLXbqWi9tCAN6ZdrIXC/e161KJEb78p7Q/j1FzMCoNeewv2USDDU2kG/byzkvMS27HqnZPN9/E9iSbRCbHgC40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260011
X-Proofpoint-GUID: gIU-MvK34u7jZQs0F6IjOpblIhxxai41
X-Proofpoint-ORIG-GUID: gIU-MvK34u7jZQs0F6IjOpblIhxxai41
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce a new link restriction that includes the trusted builtin,
secondary and machine keys. The restriction is based on the key to be
added being vouched for by a key in any of these three keyrings.

With the introduction of the machine keyring, the end-user may choose to
trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
trust them, the .machine keyring will contain these keys.  If not, the
machine keyring will always be empty.  Update the restriction check to
allow the secondary trusted keyring to also trust machine keys.

Allow the .machine keyring to be linked to the secondary_trusted_keys.
After the link is created, keys contained in the .machine keyring will
automatically be searched when searching secondary_trusted_keys.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
v3: Initial version
v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
v6: Change subject name (suggested by Mimi)
    Rename restrict_link_by_builtin_secondary_and_ca_trusted
      to restrict_link_by_builtin_secondary_and_machine (suggested by
      Mimi)
v7: Unmodified from v6
v8: Add missing parameter definitions (suggested by Mimi)
v9: Combine with "change link restriction to trust the machine keyring"
      patch
v10: Add Jarkko's Reviewed-by and Mimi's Tested-by, also removed ima
     reference above.
---
 certs/system_keyring.c        | 35 ++++++++++++++++++++++++++++++++++-
 include/keys/system_keyring.h |  6 ++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 08ea542c8096..05b66ce9d1c9 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -89,7 +89,10 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	if (!restriction)
 		panic("Can't allocate secondary trusted keyring restriction\n");
 
-	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
+	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+		restriction->check = restrict_link_by_builtin_secondary_and_machine;
+	else
+		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
 
 	return restriction;
 }
@@ -98,6 +101,36 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
+
+	if (key_link(secondary_trusted_keys, machine_trusted_keys) < 0)
+		panic("Can't link (machine) trusted keyrings\n");
+}
+
+/**
+ * restrict_link_by_builtin_secondary_and_machine - Restrict keyring addition.
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restrict_key: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in either the built-in, the secondary, or
+ * the machine keyrings.
+ */
+int restrict_link_by_builtin_secondary_and_machine(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	if (machine_trusted_keys && type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &machine_trusted_keys->payload)
+		/* Allow the machine keyring to be added to the secondary */
+		return 0;
+
+	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
+							      payload, restrict_key);
 }
 #endif
 
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 98c9b10cdc17..2419a735420f 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern int restrict_link_by_builtin_secondary_and_machine(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 extern void __init set_machine_trusted_keys(struct key *keyring);
 #else
+#define restrict_link_by_builtin_secondary_and_machine restrict_link_by_builtin_trusted
 static inline void __init set_machine_trusted_keys(struct key *keyring)
 {
 }
-- 
2.18.4

