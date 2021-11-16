Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B13451CCD
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbhKPAWV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2590 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352850AbhKPAT7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:19:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNITT3029761;
        Tue, 16 Nov 2021 00:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VZh1SqSllrJuN4tkZKx6ulcpLx3kJowSmVgBS2Q0Aa4=;
 b=dpRJ0VLcxJwjH8W9Pc7DQOipTuQUxeJ8RhU1eoQZvGc1qXtjTkNG+sdjPVyOVpYuw7Cz
 na0TIXyIlWyZfFBm4gk5eQjGzUoGdJBIPHGG2/9/qSBbhuAGGqCkXdnJze5RiriuC3Gg
 dJUm2KvOY14cywsYeUAjIkiKvMdQvZI0TwyUB3fWvEsorhnxJVHfpjHfIG5W7c1ng8k6
 3FLQLQdjWqEv3FY2v5nmA3KwPj+ilWhI6SUzpiCIrfh05VMjZZCO2UPUyZi4Sqze9wKT
 1wSPwKtgDzMITkHe8cOI/RTS2Yn4fZWDZzsLD1iou6nM2HoFSrHHvKYvhKY6tnfhwaDO JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnp3r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AbpA176543;
        Tue, 16 Nov 2021 00:16:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3020.oracle.com with ESMTP id 3ca564n42t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea4I9XfRceT4f4NXJimiyuCZgv5dSkjCbvJjvwzmVA1OwgcE3jLTYs2rF0cu7ZPEjZzgmcDpYTpbDRbgTU3CA9ldA0B5JcWUn4UxS3pJ+lBte90INuJD+JxQm8A/MuF1FcuSuqGGzJXDtzE4OXzYK7cf2LR64uvCS4hKBHygcak7UOWy6R5X5Ntw0OfXzknkST1yy1ODjaYbAf+Rxd3+C9I2di6095zi+kmHNtL9qWzY0lGZxbzkt52ozNsfS22BCcU8Oh1zvBMCBCsPuyvSYG4pKSV2If61RAcp085oFtKjWHwDUxO4CkE16sI4ZuN9n9ACEllHu9ocnBitnFsadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZh1SqSllrJuN4tkZKx6ulcpLx3kJowSmVgBS2Q0Aa4=;
 b=DhF6Bvw5dIykw+kBybCzgfNEkSaiF+wZENMcTwvCD+tJhnFjz7zDOteAQ7Xjc67d/D24dasRNw7biXBLBZBjtw8xBzk0jJPSG5EJ+m+PgxEqxvd59EUugiO5+uYkJ9ccxl7uuBSfkOPy7VA/4RPjMU0tuKjsGVm2UXpPPX/RnsdmjwCxFzFx+lh1eCic9dJkRrj+IMh3JFTh+eQxb7419TNrbyh6em/1HM+O0jgbbqSyVSy9JIV+IFvB+LqEz7ilT8bYdjD1ARFRJEpUpbVe+WIp/BD1zlh02tPcoO762HqWaufZuoByzW03Sosrf/qaN+floFZtJhVbco1Uqt66lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZh1SqSllrJuN4tkZKx6ulcpLx3kJowSmVgBS2Q0Aa4=;
 b=suHDEmgFXGoBVFsHuiYRi+Thj7hRAyZKyQBr7jroEuNBYIsL0mGBUWQmitI4x4RvmgEYD+J1zhqGV8d3aBA8yT4/w+/MGLen2xrpTKhpmoGy8CgJgeM89Epusn3zKhfaQrgc8MIkpuF0/7hZsJi9mzjXUDWCdYQAnWGobJLYbSI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:41 +0000
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
Subject: [PATCH v7 11/17] KEYS: Introduce link restriction for machine keys
Date:   Mon, 15 Nov 2021 19:15:39 -0500
Message-Id: <20211116001545.2639333-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427e04d4-65cf-43be-ee81-08d9a8965d01
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5276622162BF9207ACE4212B87999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWd7QpITOf7flXsS4rMLAmiUw18QdfasrEm+dU45Z8svIyXeFB3VR7dNKs9tjQ4odX7MQLD1e2K7kIlQIe3+2nnkJRX4obaWRXicDyNPsrJUEvpTBIDue4HDr3q3LDvY29IKnqbq1mPHpccgKn4rKFvd+1zFk5+i2hd3045/i3UXmdSkOHPnKErd+NDdDP7AJoh3bNv5h/LLKSBoqVLy0NzB2sGrJ1AtmOnYY8qWDm1F2Z+Gb+8qEhtYKgiLw8MQc4QUqXUYqFyyMc9RMLxzF+eCenxk4S9SDWlOKy3QIp13onhiONmmUIkYPpk5de9NPqPk1tJrrDCro6sEH1v9Qth9oOXdX0qAYq///2L/aGMFVFui7rY6FoQOdntJJ4NcDfdeWpKKyXiiQ5rCBzem9yHokLE36QeG2JZ1af6Easnf6cEZNUDem5r4mxqxYyK1mBJFy8E63SH1lO2f/nENwAhbBpmgOPIoqSwzZYutg82AB7ITUA7hmmnupQc1CPgRqtRsgIyre1mMNApG4hgl7kAcU9yjg3DPca3K2XbioNU1HXML64qeVU2y8RQ3rdSyfytOtc8ppokuNUsDpyg4E7T3OpaeNoHTlyBHQyd640ImGmwh31PlTIGlVoM5QKIf5bY7tL4vl5V0NpBEBu6lnQOR7W5tWPXt/Il2FtDe6cJzoK40m9LA/msqChMyeh38dd8pCd4blp6qVFxwZ812qAvMIdO5whpsHTYGrnJNRwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(4326008)(921005)(8936002)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XAho4umKk11vw0seWxeQXCShvdaWF+Hec2RivlolhzLt3pvwDCF5HxYH3OLR?=
 =?us-ascii?Q?aLdKDPEHxP3FJwCO/YUkLDleWzN259ntJjM9D4ecX59iAvndtmd9sEd0JzSh?=
 =?us-ascii?Q?RhOK7nZE5RGLcDbO185du5WZssHrwZ8MuVDOqSr0d+soVqKxyPGBVglLoFVs?=
 =?us-ascii?Q?ZqCPQUyEEQzEkuFEjFkOGNGC7Oi7ixdqpq9ZmeQXyLNCGYSjbe94DcR+c+eC?=
 =?us-ascii?Q?nGgSpCM/a/mYQdW0K1sTM/JcgSEmSxhBcXGC7ZNYRFobFsEdzX1gvl87gTMm?=
 =?us-ascii?Q?5ZBrGXxxvogfoUtMrEFbYz7QZ0jscJCgbzHJG8j4/13R1Jge0ZbBXgf6Jq65?=
 =?us-ascii?Q?zAh/yDvqIvO17nD29hQ/TU71dyFB3IZdMsBiy5DqB7n2OlOd3fTTasQXQN06?=
 =?us-ascii?Q?d44KDOLB5qbYF4I0boSk8nXc/pGyC3ILCUJ9VGcIgJERpxjUJGat+08fw0m8?=
 =?us-ascii?Q?D1LYcprybvJ57uKEz6Z4P5iy7OH02GaJ/w4beQkkRx6WOYYDU15E70czFB4f?=
 =?us-ascii?Q?1BoEolbpL3uLqLgYhv0zCXUbMhh/Yi8rK4pEZTh37Qw3We5aswQ8gG+kKzRG?=
 =?us-ascii?Q?rrcjUbQmk23r4SPR9JB+rjoCZHVzHEZSawNIjDebZT3OECrBKh5Mh9K2M9SL?=
 =?us-ascii?Q?50GLDES9kaOPcj9MtVtNqzHH2yig/6A6y1TdHXnIepAn3CItehkTr5O6XlNq?=
 =?us-ascii?Q?fIiK1SQIejcB/qzFAO8+wTylLB/BAp9cD8nUMrroGpqfV7uzeh2cvTuwQcCS?=
 =?us-ascii?Q?cPJ6yOIWXMHcphzX60q1frZ5BGoL79FlYC+VeezFc9jzJwZ9uHacOUR2qYc8?=
 =?us-ascii?Q?dtYONoqL4jsjtxbqPLJkHIBrUrlztDqwVF6YdvDlQIMJF/iTxC9nIqj4H5iW?=
 =?us-ascii?Q?uFMcw0RVXZz9bMmQtB8i2QP0dk1GqHfEI3gjO9rwVKApGgXIf9DL4qZ+pkag?=
 =?us-ascii?Q?x0umbuSAoH17MVDMJwWh6j/LGMdBVtu4DGj8q7+Ud5OoYHqMW89Gzq2/23Q2?=
 =?us-ascii?Q?55WTTvOuy2q+7KfyvYLAIjUcIOocNUPUjmAAEqWTkJ1BNfIWcLjM3EYubPkF?=
 =?us-ascii?Q?Sq2neC8/KdNIbbySJetRX7X+kWvmuqH11fScKDwg661uMPxHHbJuW5T5SbTr?=
 =?us-ascii?Q?It+oeq+RKExryT8JmIhvv53bP7IMLXSprQNECI9QeUYoGk2G4+IIUnp2d3rx?=
 =?us-ascii?Q?+uwdDxFWKbZ4nRHZdNERgcZiIEru2+n6BnW/1cmtu/JPTEPOSIN6ETTOSk4b?=
 =?us-ascii?Q?m8z1JkT8vTiigJVFZNV2g123ZmthIBbetvamuTeMiKaMgC6ITBU4wRIWp04X?=
 =?us-ascii?Q?M4w4Pqwmtx2apmS7B/sXyjfniCQOcO9+soy3Fm9obRyYI3bSoMaFtoSe/dLV?=
 =?us-ascii?Q?bFWhKIlaekZx8otir0e1ic50hQp40IYLHxzyyClKGV2xex4Qv8Z4addeI+Ly?=
 =?us-ascii?Q?qED3hJpIs3owS8AgrpdYcjBinU1rpa91W3vPlaV1+Lw9bLJuHEstfqNwPu/h?=
 =?us-ascii?Q?2UM/LLuZUouWWBFGNrOlfZ+tTH++G80WJxLIYyKlbSl/jaDx9UWlpkvs99Pw?=
 =?us-ascii?Q?DN6A3uc3D7iPxMRAHzfRpuGCrtQkHgF+buPhsHL9F09ZyaYgd4iRzjlKL6bu?=
 =?us-ascii?Q?HzbAHpBrUAOoryuhjo1yARSifk1/2njiq6z61sxlKXlswRN7kvy78sGvb8dr?=
 =?us-ascii?Q?ZOMYGg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e04d4-65cf-43be-ee81-08d9a8965d01
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:41.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWp16Uq2FFdUMNfUnrzuh0cbAntE+ruZcslAYPUqQKYKxytWU+9AOBWCTyqSxz+mM+BphR4ayilK2TzQKO6idieH8D/zUmOE/xa97Qnx9CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-ORIG-GUID: KyM8pv8S0FuJDq9gVlmBG9w55SLvqrbX
X-Proofpoint-GUID: KyM8pv8S0FuJDq9gVlmBG9w55SLvqrbX
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce a new link restriction that includes the trusted builtin,
secondary and machine keys. The restriction is based on the key to be
added being vouched for by a key in any of these three keyrings.

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
---
 certs/system_keyring.c        | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index bc7e44fc82c2..71a00add9805 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -99,6 +99,29 @@ void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
 }
+
+/**
+ * restrict_link_by_builtin_secondary_and_machine
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
+}
 #endif
 
 /*
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

