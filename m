Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2DC485C85
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245654AbiAEXvq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42442 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245572AbiAEXvG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:06 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N4t9X025707;
        Wed, 5 Jan 2022 23:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=iw0HknLHxTV5r4HSvMPxOZfsqdTeRLp2egs62YY91mk=;
 b=UxxUVbc70l1NW+S9N/Rmw4lY6fJ0bsVfM2F2vYnB7S+Ez6kcqqlQ1KxxkRYT5J28ADlq
 EROHC8Uw14MoionGZNsdPT9o0m8tYJjPYSTHUwULw3TQMYNeSxgHGxlsxXZozHGp1CGd
 QwqR7R2WV9clWKORpZeI+rwxxlPXBzlxRt2/ZStbiuWCWPXOVcQuN7baCVIr8yDZ/8QK
 ld+UIUf+3YEzjft4+I+EJg4cano0MuqVsxFFqYyO0JU+H11SujnladXripJHtZWniSad
 Wc3Fyp7sFdYlNMJqCvMCsG+VO+hyO7XEQfxR7tNfwCMQww80k6kM1W56Vqpz8mGe6dYR IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpmg206-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjevO149961;
        Wed, 5 Jan 2022 23:50:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by aserp3020.oracle.com with ESMTP id 3ddmqa1jfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4h98pNDwGzAtKItgWyio56L1yolbvyLYWbgUtXUkIjsKb8zeWr+9booOJYy68kPrKJbUuef741Z2aM3vpLqtixZYgSF5zTAAnCnpWWkySrouvNBxaPlb6m7hu4A4K/5dmDG7FINB5c/zciGHubDhUju50Rrvh3bIV+pTJg3rPUthLaHIvnuD/PKvf6M33WTIgSHxuVz4+V3PVbKbSC0ORYZ+FebBUribMnrwlES6Uh4VsnnD4m5fQMjZOml5jnsAdq3acCepU+VNCiuDf0akuWVRMsFtfxPrYgqTaJsYHfqLayfDE0ftMLNNAmQQFdmArLGAdBXNHuyuePGNYj2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw0HknLHxTV5r4HSvMPxOZfsqdTeRLp2egs62YY91mk=;
 b=fySb8RO+c8IygmWk4+Kvsnx7Bz5b4MarojdD9YhkTZSPuSA16xm8qEb3vaLJtwSJ2edVPpnjOO0eWeiO5qrS0gokalizUCuwjL21uFll2SK4EvgWC4i+sU/l32nX5wv03vG1w8iR5cFw37OBFM553ANR3+fw91b+HS9zuU4P80wpJZLMotd55GalGBRdwwT0U6MzX9iu4lZ77TQx2A0Z7waUZjcDtYUfFjS/F8UKdC+DZs6jdpX/6oZtP8Ju3wOqQY0vym/AWT/4NzbRDhMezRHlRiNJ0dcct3MvlN0seegJXkGHc3JUbXtkmAZWSRJUNjUAANXc/7g1c40V7v6EPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw0HknLHxTV5r4HSvMPxOZfsqdTeRLp2egs62YY91mk=;
 b=HjjlcaaA0XpHETOsWsRckJ5edAkN/2MTkQZ4AD/th3riDVqSMq5VQ8wrqFhgCC0l15T27cfPHXuHkJim3lbtr/yEM6jcxHuQ7Kzn6vUPtnH/uDH40IwOYaIOmFnJHBAKJRFXfRhlJxUIxFumo8YNwk93hkCT+0Iq9ZI79NrVdgE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:40 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:40 +0000
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
Subject: [PATCH v9 5/8] KEYS: Introduce link restriction for machine keys
Date:   Wed,  5 Jan 2022 18:50:09 -0500
Message-Id: <20220105235012.2497118-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3598c9ef-39b0-4400-ca4a-08d9d0a62df0
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5034B64A4CAA8F3E9E546700874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCjQo+4w8bHYhu4s9c6sCxrMNOaGt9Y4CU0zyBner/Kx2jFi/VMBKuuuDy/W8U7UHIifpcRjTW4j6u900ixEq/j4A0zjNpeZe/otfk+KCEm5i/0HnSbkfqYZd1pX9hBRhwciTy4WflSZ42PjhLrhxsIIjVX8Q0DpwppWYmgh/tZTpg+NEr0w7DjZx1g1AiK/gXj/1fX/UqwSTlAcI/rINqWaOajptfPrGKZZ6FEpJNp39VmIS+gS2AHoYWheoXOo4Tnm+3aYqctpAqcZ+YqAGavbgu8mE7CwcouNU8wJN99TdUlIOCeN1Bjv1YsAJGOCNecVT/pBEChkbXR1jTDOAIx7jrgoy3gIR6rSuaM/Vs+tfJ1Nc1s7fcX+WZrtJ4BTo11G/tOeJ78te3Z1vPYolJHUBRJ/Xe5yxZuG+/65PJ5RXV0PEzw2Rax64jQ7QRUHRdhkFVGJyEC4s8KoB3q7uq8XOlnDvgq57EXMltcs+T8irx2Em6gRjs29BxC2GVvlGrA178L+gFRCCXs9v6jgJEI8/P6ULvn/JGXdVwfXtF6/7uvRetMKy2qVlGw2zvVs/QEG1/tJ+1gKpPM90NPKpDa1o9wYnvzoDx0z1r9XiHMlAREeQLH4YDI4CISGfWWHIxi3kFVJjzjH0GBzpjlhpwTsYWS6gNwaYg6mhTt8WM5rTJz4KZHCCDXu0RDHDOWou1rWw7U1oL7UeuSJ24fz7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AwtpY4MBn8bv9pmo8/TBCCA1LN/0mn1IquKAdXYJGykJPSrTw1sa1pW7fCQ/?=
 =?us-ascii?Q?6slt/e4gPEtyc8pym2+hxHT5QDgczS0lJNRKB8CRH9rLQVq8gEX5ehACgGOx?=
 =?us-ascii?Q?J126DtykFBNEwr/041TqtpeZzJjY+1Ugr9lmYQqVbEMnPlJ5mTtsiZLd874T?=
 =?us-ascii?Q?AWAqhX1KJLDEaZJq7CsKZX8PZc51KVQRHwfkhRuZ9Y9snzQ90PI0VmYO9Xia?=
 =?us-ascii?Q?tvw8dWh0UTmXA6rlegCckjdZJ7smuvAhj7lVkI+n+HgAQP70krujmMmtHeyX?=
 =?us-ascii?Q?xTl4yJ6h6uOtcoLu25oBthYCDqVSLHUU1w5AZq4LlFHQceTnk/KfFfzj/cG4?=
 =?us-ascii?Q?Q3ZPLxzEj2tsxobRafp2M47bgtm4HxmpWoVCKYNBuD6O2OHdU0MJA3lxbQxn?=
 =?us-ascii?Q?f027E6S86NBWQge0QC1MYUmBcPnEWJORJ/1vZfhiln39bPyycsyY97+OwviD?=
 =?us-ascii?Q?HwRfVW3M6CpY+dJczlLUxRbl1IVx0UYawUKxr8Tmf3D2wCjERg11s2ac1Gen?=
 =?us-ascii?Q?3thIz6873jOY/uM4X3pF8Eg/TB45Um+9SZbSZaY6BlM5XHLpmvf7iYgO6KUX?=
 =?us-ascii?Q?ajDdKs7PkfDzu1t5akTbN9EwpWkky+c779diReAne1FYkARps6ZDBcY5yZ3r?=
 =?us-ascii?Q?ihkJqbcCizAJp77ligiQ/btjqegfkSTk2ghJz42j/x1k78a89/Rfa2/bXVeP?=
 =?us-ascii?Q?G2cMK2psKYpEqROpikBGo2Hac3thPwVFMkMzO6naDnODsAXos9+d4ORm0oRM?=
 =?us-ascii?Q?whElvQ3aTk2+EMM7Dwz/ri+xnnGrDXlp6PKKrlzMneSftwP+hxx0D2oEu4ZN?=
 =?us-ascii?Q?xriJMu0E2Lj43IFr4g+e+JAdZwX8bBrMS2L553ZcoOr4HzCqomHkKgGxYZq3?=
 =?us-ascii?Q?zrh9rpDeWiMTanEFDsAle4W88SDT5uunfvqk3dc6th2syJtoWisixIXN+O+X?=
 =?us-ascii?Q?mu5CcGy+r3SHpqqQscm7sLy6a3fVx/zpOnqXTfPunhISb7tBVJhzY89Ikmzr?=
 =?us-ascii?Q?5ojJC2eRfbOxjaQ+nZMBcDAabn2aRUtGiBnf/sH64uhjivpa+Udw+ML3kZzJ?=
 =?us-ascii?Q?JIr6In73qAgV2E1icT9MFno2HYfE8ntdHgdk2BrsK09NKijiLfG9EIsc3si/?=
 =?us-ascii?Q?xKkbmEN+Ba8J1sEOYNtEsUxsIc3g7ipyXJmfHVAsGz4EN1hB6zKwdVKkb35x?=
 =?us-ascii?Q?YQqd4oL08gTK8gtt0DSHfmsKB3YND9m3GB6ToeMSByX0QBKYq5oTNPZagGPh?=
 =?us-ascii?Q?WHEkKxmf5vdeqeNf4DMEPK1l0e4W1KXAGMmtHwg8JRBv67ZK1fubqtdgyjUp?=
 =?us-ascii?Q?RmUTdyZf471ZTbRtLkcAGZaMCDa6CCWAMMzpNQUYbte+bmZnzloJaIYguFao?=
 =?us-ascii?Q?T4DsPimcCRl2lfOdtLTgjaZo7WhoWQ9InlBB0IQoNTDjs8chQEv125eiw5qg?=
 =?us-ascii?Q?dd0qVWvzWDxq/QI1qC8uk5yaTeP/a/MbljJFeFvEqjClmEfUKRjzJ532VIlZ?=
 =?us-ascii?Q?BNcE4joUCS+Luk4TBDIqTyy1trFYmh/OUzDcu06B8IysIcISlXODH5gHhdmG?=
 =?us-ascii?Q?+lUQf6+28CX2RFg2uBcVCUJ/JfysWG59zP9pD0rSTh0FEY8fSOHZdkiqWmEA?=
 =?us-ascii?Q?Kr7MwYNXOMeLaSQ6MoNu+IFThXurHwCTPS0pOTjPaYhz+vMCHmurBgHr+G5i?=
 =?us-ascii?Q?+0p3mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3598c9ef-39b0-4400-ca4a-08d9d0a62df0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:40.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qKPWKbUhOF/jB+zakLjoFFvv0xhCcE0cVmEyBqnhm5pQlxLuUfkNtCvs8qmZzsHJStLQJf4cvoMRvdHAwoEFPvDDXrztmqnAWu6AnSFDLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=667 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-GUID: NenaduIauftrxUhIkcc7vDJZrDTate5i
X-Proofpoint-ORIG-GUID: NenaduIauftrxUhIkcc7vDJZrDTate5i
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
allow the secondary trusted keyring and ima keyring to also trust
machine keys.

Allow the .machine keyring to be linked to the secondary_trusted_keys.
After the link is created, keys contained in the .machine keyring will
automatically be searched when searching secondary_trusted_keys.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
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

