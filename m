Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828D6451CE2
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348007AbhKPAW0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62122 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236400AbhKPAT4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:19:56 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFNPK5g001710;
        Tue, 16 Nov 2021 00:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Zbs+nv7qDOFsSHUeKjH51kBTLYFB9i5N+yzVK77AZlM=;
 b=fOidVO+/s+eodNM4TLTDaOK3RL7YKq7e9fLCWOFeJSD4ncHJXx2iWn9Da61NYeA7bImK
 bnHneZjbLg+OEdM5/LK4mBJD78BzPkz6fIcmXrr+LzcaWyzbkMBbfAJoCwVHkc2zggsb
 ytJJZtbbFswwkNRGrY9+Zw4Jpu6BLeyO2i4pT8PtJoJ3leI5Kz/p9DkoPGXu5zMQC0JE
 js7AgAEPgTwyYQ2/QN/fBOzzLtnAxfx5NCjkhinF9mQyc9RVzms/DU5+nF9y5tNIz/8C
 6hpNSHzo/uT2qxUAJkXkL94g0eJkauJfyxPvwMd+GXKnRQLvLuPNhjoq2J2DkXHTf8+L 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3dww7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AAOv136124;
        Tue, 16 Nov 2021 00:16:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by userp3030.oracle.com with ESMTP id 3ca2fvcgmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFEBc6Kg9EPKNusqHcyrW6W4Vd9ACgRwGUuZZ3+VAniXmBSQg7pNxRJEcdAmdpWBeJRaWwFp7N+bLuu33LILJYErh5ThzE2einBIuZ9EFntnUjww6lrzxc63xEBVF4hDIzv0IZbbE4oCeA5uzH/nyrVLbRt6UMR53/0WUqYJvp9ZGaqFa9y89oqWFG8kts+WiRZuXMEzZHRPkwVbTiga5UtHwNtMnEp6B8pfNDTC8KnEiHNHxJcTS9bjvkfhZGC3nlfk5zI/9cVItDwgEt5k7k62BHXQqJYUXhUsLw5ymDU4cY3G3cQBKDVLa2FlV7VguREENC2GfNJsDoE+qVdN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbs+nv7qDOFsSHUeKjH51kBTLYFB9i5N+yzVK77AZlM=;
 b=maJkjfAZtPfOhy1+F5X58N/6+BgE254mk8wFwBnU9cWJIV60QPD2aUGVe/bpZNrTWKOGVjWsiwZ7dRCV65WU8VfCxbDWGkrkNVX+sXm9/o0WbIuYkEAofFoLvHi9LsdwoChz5TYwWEd7gW9c+/fMbw+6zFgdKrgcYi/Gax6Fn/nKq6d26rioPHjNk/slCWQ7K5vsXxka5AcrZyyLxhXkDSfrD40lgY2/Vpmvlayzw+dbrfipfV2jqOcOhbvsSkntd9rGPG4VxW3SQ9xL3ukll9vhiB7N7BjRK6xcV1X+hqVRnCn4UrbytD6EQr8EwJAIewE0jPdGt3ripf389PR3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbs+nv7qDOFsSHUeKjH51kBTLYFB9i5N+yzVK77AZlM=;
 b=mAiiBjL71QzkkChtXzPQzz95u5RGRqo9vgHChsSng7Ob5F3xyBsYdZl3nXyLPXqmy9w4LzJRxcwMVLZbhz7LlMHuINeHA3tjgmGaVuR4wmSFZ5RpbZr+1mpZnjnyUPnPPRMFPEwnQN+2Njhp+pBdU9a1Ttgrz2MTszzCbaeQ2U8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 00:16:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:33 +0000
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
Subject: [PATCH v7 08/17] integrity: add new keyring handler for mok keys
Date:   Mon, 15 Nov 2021 19:15:36 -0500
Message-Id: <20211116001545.2639333-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211116001545.2639333-1-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0a77727-23a9-4805-2d76-08d9a896583c
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5276416ABCCAE7EC722C7CD287999@CH0PR10MB5276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IzgfYp24+zeUKoer8vSgcygIt8c6V+G5wyDjBf1k1LL0An+6CM6TQ1e0FJlA8d4WCw5VNhTi8ultqYYEOD2ISdoY6T+sleetQzIbYw0i+mjwZc+54e6ImwQfL62Bio9Dfw5h7kKkZu99bxiQUa9jARBgsEm7xy8zg9ZoVtYfMWUtPds1GxiTQ/J7wUaxJJcgH6a/cl+AMVJ4HUYwXHTawqzaZC81khWGAm/S4SieNJl6rSq9eY2iX6/wyOCl5MCCqhvUN/zdDxEVhCwrqu1Px4UQcoIYC8H2Clwg4lmwnSa9tgj4YB5fWZ30tanuDwnbkGPUQ65yQggzcuskJ1Mwc/1kUzOI6m0Xpy42Cw/nv0c4kkmSahdSXmbldR+uF4sFdnaTMI9Kf6OHTMNAtNsTjYxHq7SDqhnYqpbjm7Es/iSXdn0wFwO0E94QWZtUYIsjpHHf9NT4TRsq5Gib6a72E+0Z+HxXzCveYTJ9GUtq0ZVxpFC25YVh75Rnh4W1rV/gYEcEdB35+B9rxw7svgPqcdErjFedwAFb6+N1PxqWQ7GeiKqKrG+6vdVXUgfdNNL73rbU412mmwm0MhCbvrptD/ZKdLeWvYbn8g+65HyPtmb2VTyiPDHRjM/OMhdC0xjVnHudCGZ23sU6omJoV9dFWLW+j9WO9T6inqe/PW0cFnb57AOqVzUyWBBSEoIC9XpA6O4WKdxbDVV2xUSGvRl5fArKrS0aYZizWmvBlLYkDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66946007)(508600001)(7696005)(66556008)(66476007)(52116002)(186003)(2906002)(26005)(1076003)(44832011)(36756003)(38350700002)(38100700002)(4326008)(921005)(8936002)(83380400001)(5660300002)(8676002)(7416002)(86362001)(956004)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v3uTK+XEPuCt7S18Z4utnHUENAZy5VMijkBGhzyGiVwiFqbBto6s6iT7dkSy?=
 =?us-ascii?Q?WCqe4isP5SwoGFRyUmFxHHdsKp9wZn8qnxiHh0/fW2Linb59dczbF5WOcwmv?=
 =?us-ascii?Q?5tDv0lIzi4DcgG+9APBQ+mZJF0foYA8+7fAsqvyK4Q7lRlu8dn4c2YoTz7Ud?=
 =?us-ascii?Q?KrfjvlLb5pbNaci6bz+PtPIDQdhIzqXfG4wODlcZ7SMDMHmNEhFCJka2uhVh?=
 =?us-ascii?Q?s/kxw4O6ZqLNBIzkvTXCib0uTQMByRNRFenLOTvRB2qj8ny+alfF1aj+55Tz?=
 =?us-ascii?Q?vyMnGV3ex6EPm4ZEiSw7Kksrp4wPkQ/QtqX1y20rDCdyEB0k34ZU6/vFmPfe?=
 =?us-ascii?Q?tk74RuIm24UO1dIJ5iZLDSI8U6emqyQuTR+5BemfLxLr8z0D1Z6qkqxOQIt8?=
 =?us-ascii?Q?BpyqvrSRV765FXn6A+1ysdYajHR+mi8GQh4k0K5/xsu8bNR0lhn5PIbOBoPC?=
 =?us-ascii?Q?IcOehvoonZp3Q0SGAxX7SeauvWQZh5Kp0b8+qpDm+UBVHGWEt9M8/J8JyGAx?=
 =?us-ascii?Q?P8wfXQ74S/62WGU293colsmbIFdlRiH85BilnDTP8DEQa7rVb+Qgu6FF35tc?=
 =?us-ascii?Q?yiWuFiDnqRx/9x8UqHfJPUa6MV1aPFgTKA6cVL47C79I7v9gz4q5EsL/7pvY?=
 =?us-ascii?Q?9eivlaaSC9364wm3UnFOtn9PveoBPauoaFgjyiml1ZVG6G8sMbAt2Lo1jjWo?=
 =?us-ascii?Q?/wQLXeWS9vcnIvpqCV8H7xvgzTW5xsj3vYvtOQvWnJ/6hEb9rRlXuU2yHOvs?=
 =?us-ascii?Q?t5b3PZu+UX6+z09BZZBTEBZwkqlnhVGMomIkksNUEcaHDZgOQOMg6QK6tRK7?=
 =?us-ascii?Q?RJ/u+6U4X901fPWjpSX9+8gVaP1KZ13J9Vr1+HyhDZ08TM+dGfeeT1VxnnOu?=
 =?us-ascii?Q?evWzSDcUMMj9XHHHL4e5pCONZr5y7c30pMmZ+ZjY3AD2nvTvALKSgeurPCC5?=
 =?us-ascii?Q?UjwUDC8TwDtGrPJ8y6Q/l0ccOcR90F4oiYJOvZgLCCXSg08r+saH8F5c0++0?=
 =?us-ascii?Q?zzlQXH35QhECxlZcUyjI8y+uVee0vSRz+MOYRwwejx55DeRGMhBxDRWhI1iP?=
 =?us-ascii?Q?w1/i2DHP0rHHfOh8DH5AsFQ+D7oUtwRwEc12QCOHjh8eE77b5SuiO63JelpS?=
 =?us-ascii?Q?EV6HrKhQH3XrlBB9b1fsXwzpKiVxjGS+kTQLP79XZrXV/g8f0hMQwPrJmFnA?=
 =?us-ascii?Q?A98xtCkfkzSVcNFcrO3Z42INzvYAkXV3rx+ei0fIU0zokuI2cnfDJeGZDjyN?=
 =?us-ascii?Q?9LHPpIUu+9Zb5uw/jaakTGru/iTsnOslNvSaJjv4nMja1dDEWMgxpEergBRQ?=
 =?us-ascii?Q?ncCiMosPeZcPLUDz8Fsuqpl91xfnhWXKkC3cGbeeVtj4qHl1rwdksHQs3ues?=
 =?us-ascii?Q?nbzQqwS7UHn/mYShZ33FY0cwsWor+/gwlKTodrHUWE00PHBkE0HqXi0xCksS?=
 =?us-ascii?Q?R0Wsy+nWo7NBOmBlwyiE+ESTNEA1MfLRCcUFOUTIz2FyZQ0vZbaVorua8AIm?=
 =?us-ascii?Q?yWTXEBencNPjh1ESMOaapTA8rZhKhG+i1ETKq7XNnGsuiSuHUVdZ1tEN7Tpo?=
 =?us-ascii?Q?ByO6H+9nhce98WDOwyL3rYMQ3eSv0ZpVq8DpncUmmM/j9gk/XOQsi+Rd2djn?=
 =?us-ascii?Q?8RewC0sMpQBAtokzP+OFaTtwDR1CuYKbhmzXr8RKi93FZndDR+bp5w0AIYA+?=
 =?us-ascii?Q?Rlwvtg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a77727-23a9-4805-2d76-08d9a896583c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:33.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx6zNvXlvCbaYHttQv7BWdVyd4qJCEucwwllC6yBIUHb+fB+JdFhGdFUlxj0psA/gQuc90fjerV1wSOz/ZXUcIRLI7wG+S7LBrixHC04NOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-GUID: 8KO65oPvbHQPjPI5OicIuXU15Ezvv-bc
X-Proofpoint-ORIG-GUID: 8KO65oPvbHQPjPI5OicIuXU15Ezvv-bc
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
the same keyring handler (get_handler_for_db). With the addition of the
new machine keyring, the end-user may choose to trust MOK keys.

Introduce a new keyring handler specific for MOK keys.  If MOK keys are
trusted by the end-user, use the new keyring handler instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v3: Only change the keyring handler if the secondary is enabled
v4: Removed trust_moklist check
v5: Rename to machine keyring
v7: Unmodified from v5
---
 .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 security/integrity/platform_certs/load_uefi.c   |  4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index e9791be98fd9..4872850d081f 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -67,7 +67,7 @@ static __init void uefi_revocation_list_x509(const char *source,
 
 /*
  * Return the appropriate handler for particular signature list types found in
- * the UEFI db and MokListRT tables.
+ * the UEFI db tables.
  */
 __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 {
@@ -76,6 +76,21 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 	return 0;
 }
 
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the MokListRT tables.
+ */
+__init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+			return add_to_machine_keyring;
+		else
+			return add_to_platform_keyring;
+	}
+	return 0;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 2462bfa08fe3..284558f30411 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -24,6 +24,11 @@ void blacklist_binary(const char *source, const void *data, size_t len);
  */
 efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types found in the mok.
+ */
+efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index f290f78c3f30..c1bfd1cd7cc3 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -94,7 +94,7 @@ static int __init load_moklist_certs(void)
 		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
 					      mokvar_entry->data,
 					      mokvar_entry->data_size,
-					      get_handler_for_db);
+					      get_handler_for_mok);
 		/* All done if that worked. */
 		if (!rc)
 			return rc;
@@ -109,7 +109,7 @@ static int __init load_moklist_certs(void)
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
 	if (mok) {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
+					      mok, moksize, get_handler_for_mok);
 		kfree(mok);
 		if (rc)
 			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
-- 
2.18.4

