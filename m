Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3E49C19A
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiAZDAO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42602 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236735AbiAZDAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:10 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMn0am006704;
        Wed, 26 Jan 2022 02:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VW0/x/eiTqQqHzXyIRnGefAfqYKGGo1jFIfenhKIN14=;
 b=GVg4cbsnbilnyOZI371hSmILTH9MyLjS5LPl3GR+y4UVT/n5319hLAPFiKrX3EvY+jzA
 y79XQpKVbk3r62hACKQwGYSdqfNHLLkdfwcpY451VnGpSGNLkmVbejwx4KHYd48K9mwD
 NOZ2SoEPBl7hT+R7Uk7BZ3p2pqlduE748g+w65725EwFtvzd04LcIiKKnlu9TNVgm6gx
 ZoA++qyNBar8eiO65DvBpKFqD9iFezSiFwp67C2JPJkCipeoxq32dnYPPVhKRZJ1WyAo
 gff3b5flWHWjthjRCz0djuJGj7W/5yT/20JWYLsTKa9sPYLFJPNNWPSVGQBhLnPFfvmv Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjdgra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oSm0068380;
        Wed, 26 Jan 2022 02:59:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3drbcq7v5n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccrtp8GPDDBMHzc4LZ9FLciQpj/QI9E8w2lIHxBKvtOYHIyNxxqdVRBEbxvvfAK8vf9r1WYv+Gq9TX30MMrRVCXBAAEWLfdDLicUkD78AMglhZxqLElStoUA2dArKYDpUqqJy7dO7FLWc1J8t/pFT1lbkGy0ltxpp5xv+1WASydsBmjoq+nW5g427IzlQJSMaAVYM4IKfdWJ8H8m4v9VgGU/pwxAL2skpTWCyuZue9PNB1200EOYURlUz8U1JLAFOXi0REwTNTL5r3gCDctMC2tmAKfq5hl3cZhGUonyjoeXgvGfTkjQ/re+dIREnxWMs2X4lshzSHNSD9lILNcK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW0/x/eiTqQqHzXyIRnGefAfqYKGGo1jFIfenhKIN14=;
 b=Awy2vBD9Qd1ktY+2LmX9tlsf+Zi3lfkWgvfgxtVc4tLvr1Slf1E+1oyksMPH9WGHa8iBR2TCriBMw/xvvgfOZyukE+h5auxHBFLhNY/uRpVMwsLkPMse28Cwyre1A6eMbuEHb0YfF8edL3Vep93g7bElBC0UYmLtklmd0WmXQxfYpXFMbr+sWrPgodqWAuhA5SD2CqUf5HC8DSWVjH5WFwjhDOqTIcHKv75YrGTjvii2qPivMyTKmZVSEGlsxnh+ay7nj1qfj2iNhpm0tRWL1JCgyoIRsuOpfmGZUvTyewCB0Sv4Itk81kn5yjFUVgLy2P8+5tclcAVPSLSTn+yrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW0/x/eiTqQqHzXyIRnGefAfqYKGGo1jFIfenhKIN14=;
 b=DwdWgABZGXU6lrPFWF1CkvpD4zinnQBn5tJijb42eoaYQWBYO5gf7qOisBKYP9E7EVVJbrgdNE0O6dBzn0WOxA+NG8trmcDVLdEnDNOqQ3vrtFSP9F3PrTiOvJpqlMK9Gp62ZCNJHDhMGrKgCdchUcujCi/FNdFPeLRMmZ/ueco=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:35 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:35 +0000
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
Subject: [PATCH v10 3/8] integrity: add new keyring handler for mok keys
Date:   Tue, 25 Jan 2022 21:58:29 -0500
Message-Id: <20220126025834.255493-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126025834.255493-1-eric.snowberg@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59aca902-8176-4507-222d-08d9e077e221
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46547C62980B9C0F77ACDDD587209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NS5Nm1FwSxM4SqTFHXhpCm6FfffALQt7y2MK6Ye5JQGmX2k7rcYpffnS/tXwdOAnxu5zgNUwLGZNg+l/3rTyi3esLK+xK8OyxZh5Jr6u8zL2qXOyyyYj3tB0cI7jFe8PKtaoJ2VM2W6LtxNB5IPQkMD9qhZ927PFo02+PvZMiFEj9mPdH9NazN8b8S7bM53FY9YG30SgpKmwKE9RPfbe3IW6uEm6m1C9aeKkwOUkNxRc9ColJtDOuUGALly13Gn5ooqlyifHT9yq6A/NqN2866zLNsP/Y0A6VoW2qRjvRTtloZGpO/j8IeW1aIBq/J94ua+rD1ukdRQelJFN7k8k0hPmTJnSkGzVHYqUYMkDt+nswDvDVoWsDFicH6KVdaEMtyZRL6rqYlb42DYMxJCGuTcbWQ22Nfe2p/QE7xW4RoXK4pdSy5uHYZBz6OU5Ky/5UxhUwNGw9ab8EfQ4ob2BJJxd7O/NZfYyduth8MQaAW71dlqfYW2aodamCSQz9WYaIcoO9ZzwSyK+vQPDGyiDy7bW5yQQF0FXN96lCag2rvhViVYIEIGN19lnicdDRc7j9+jLoXLxupgb+sJQpXyM/jJ4VlSQ/CwzR9y4trShvouudIgOja7Uk18oI1VcJNSFK1W2vjxlebMtArqbRzTnaRZlDl00D0ZTy/RXPCoGQu+2ZWdGjqi637q7hIvDi3AhzWXaqLAPza4IWOYY/EXWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6666004)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFiMObFiyxHkONZYau6pHgkOtB8JWoc1nfgvS3d6iQBkgDh6rOwpKXLwhh+W?=
 =?us-ascii?Q?NeDDFTEMaWU6i7X5o3xpfRLNVf5faH+Rw0Bn4FAkKWymQb9XBfI52mmv+4Tj?=
 =?us-ascii?Q?FgndAcfHoF3ocLEWScFc/Sfze/CmA0w/k7pmQGM0bKln3NscDpepn0P9hzh8?=
 =?us-ascii?Q?4JpUqcsiN9Y9Va01IptEg+MQ3CRRSri8v9gS3bmZ5emIoR+w45IuyVuPNXdf?=
 =?us-ascii?Q?OTVfgXMbhqKlhMSvSmSpB0JI1/hZrnYRpUiFNFbYevN+EXslY84B/g75+5Yc?=
 =?us-ascii?Q?STOwghOCdMTcrygVMm9NDo204XN3QPFGk3M+hVOrDCREQe58HnqFhcxyQOyP?=
 =?us-ascii?Q?uC2PA4KxVhQTp/qUisLVTgj2Aj8Y/vBJew3e+4yeB9E4I/Wqzi92ItGQoZne?=
 =?us-ascii?Q?7wzaewQIUqEml9aGvim0JBd1gEvUqMt1DR2gpwOqMpWJfqi7SPnp6+4hwUYG?=
 =?us-ascii?Q?7anV6S1qfh2+wDHHTWMVxmR/Wn1PS2UVggdh6ZcQjUDN1g7Zt8m996C1g68u?=
 =?us-ascii?Q?Q1/Mlt5kaME032WnvoPGQFRi+sIqcBnj3JKCJSk7dxv1gGf32L9QulsxJZGw?=
 =?us-ascii?Q?pv0IbkveLngJHckTDmJb3fieyzDftEUmbigOzOxkfGDy9znFMSHctXSWmIoo?=
 =?us-ascii?Q?GTraMELJYqhqmtsLnlgf1R6ugPcbPem+zHJnxjtndMWT6F4VV/US4K2v1mfV?=
 =?us-ascii?Q?W7si4+lGMAvb1+MnXoFL0XEDTaDANyaLtoFaaYbdbULZucxqFpqNipaGm605?=
 =?us-ascii?Q?kpFwDYor7SNCJq7FtUFBkmq14aaLZiNslGIWyO9sRTsKUiFq9hL98PEqNKXP?=
 =?us-ascii?Q?qfl4RXfW0kWRZKm3krn8SD6qbBSDD7nU6mDRtEr3Yx141k2c4B8rlQV2QK40?=
 =?us-ascii?Q?/iKJ/IyrNb4yKIuJZz7jJdp7NgyQGT/gfZmGX/Lad1M0q/EAMvaNaK/ymQZd?=
 =?us-ascii?Q?EE+BKSrU5tPiDyk8c/cHokuiNey435D3q6DOU4osdPmFYX0o0BS8+ubKPQTp?=
 =?us-ascii?Q?ryAGQcOHu+tDQe/Gu45vpaLrQo46BebodhNbd4apH+4vhlK2RAh8tUUMil23?=
 =?us-ascii?Q?SBWhUJ6AP3l6GNVYIGp3nME0l0GMeDy/ScEEGofjy3ntGwXaQ5FoPya4OCqP?=
 =?us-ascii?Q?Og3GMvZ7t9441DII/KJps2w7wHdzusoHf/Bk4ApnQOXNcNt18xOknj1eg0vv?=
 =?us-ascii?Q?INlfUFLjT8IiiltPABEOJkJyrbUoqrkHmNxQ5aB9/Jn2S7v16MftPIjVdgW3?=
 =?us-ascii?Q?Ik3hqx9COJSq4/hWzsEvDI7N3CmViKVNsSO3jvLDOpif4yOEIOiqYW9icA0i?=
 =?us-ascii?Q?s5niw1VYhT4F+/RR3/PZtw01YPx2hKhlaw1s2o/UMzaHmX1gkZ9PbDP9pfzf?=
 =?us-ascii?Q?Zp678JhlzsDV9V85L+dAiVmgT28N+9Xq2rsMxM0cCyOf358o6gaBq3aJ/uLf?=
 =?us-ascii?Q?j2si58Pr1BhD9Rr4EEZEcO2vlzldN5NYOfZ/0xdkQLmfme+4UYlZgkCgAM9H?=
 =?us-ascii?Q?nkYsPPSnetWS9SBbeTUukvg4Ytoc7QpONGiBI6gAwkojC+CWwpmgtU1zGHqH?=
 =?us-ascii?Q?vEyW5vblW9rEVbFAhCnY6/oetRiGPRbS6XXPHSA+ReV6ibP5KOAYWCIuxlcm?=
 =?us-ascii?Q?N6ZVVrzwsMCP/f2/GOv20WC/0RQpvNlS8vYqvceJbOhBfvWM9JnyNAwscV2m?=
 =?us-ascii?Q?14ppmYLck22jpqIjNgLN2lwTgxg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aca902-8176-4507-222d-08d9e077e221
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:35.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+6JcME8qd4YcF/UPzkn4/MtfYj/4Vl8h1xgWnHiYHRl6/K/0xlkj83W5W0ne+bG8sM9inZ0QAbfl+9Zo2ea8vCltYGjWFoXWGu8dKcC1IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260011
X-Proofpoint-GUID: XYrVKOwCoLo7or6S5qeX5fYXpk6d8lt3
X-Proofpoint-ORIG-GUID: XYrVKOwCoLo7or6S5qeX5fYXpk6d8lt3
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
the same keyring handler (get_handler_for_db). With the addition of the
new machine keyring, the end-user may choose to trust MOK keys.

Introduce a new keyring handler specific for MOK keys.  If MOK keys are
trusted by the end-user, use the new keyring handler instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
v1: Initial version
v3: Only change the keyring handler if the secondary is enabled
v4: Removed trust_moklist check
v5: Rename to machine keyring
v7: Unmodified from v5
v8: Code unmodified from v7 added Mimi's Reviewed-by
v9: Unmodified from v8
v10: Added Jarkko's Reviewed-by and Mimi's Tested-by
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
index 08b6d12f99b4..5f45c3c07dbd 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -95,7 +95,7 @@ static int __init load_moklist_certs(void)
 		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
 					      mokvar_entry->data,
 					      mokvar_entry->data_size,
-					      get_handler_for_db);
+					      get_handler_for_mok);
 		/* All done if that worked. */
 		if (!rc)
 			return rc;
@@ -110,7 +110,7 @@ static int __init load_moklist_certs(void)
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

