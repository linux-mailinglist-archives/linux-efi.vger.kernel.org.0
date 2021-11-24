Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36845B33F
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhKXEpu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:45:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47694 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240946AbhKXEpp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:45:45 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO2pLtn011710;
        Wed, 24 Nov 2021 04:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=xnEwvXThkwoWyz/p0kAfm8DNajatzhYt2fjx2KY9n/s=;
 b=z9tuR0MJTY4aW6VRubBtS1d8qbPrXnNDHDin/x1HtIJLwoTQftrQQDCA5tqZ2ia8mlQ5
 0Voi/CTq4yibgxUwk6ZlPXrz31tUQP8rmpqXXHfETXP/vtgKRtgXMTGeKuXofnt2yB2o
 FBVX1KIOUvj5CgODS+M+KWS+G/I/OguDX9eXSe9jB1vG5sgUO4b4dpT1jSy9vDMdMtx3
 Pjpo2npDUUpiDJp7Zy8wYVWvFfZrP9fwDOSV1TYQhuDVM1yh1c+uSyjdSX4pReaNPI/1
 4nwM+TwNF+s0nWmUAeHSOhB1932uOEGavg7PHkMnAmGDCMzAMlsilSISLOyWB2MeSY4t 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gje9e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4enjX136975;
        Wed, 24 Nov 2021 04:42:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3ceq2fbufs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY24TV4dMm3CS2PrFh+vhO5obuTMk6kgsf4WQHclfKFcb4JdJsamoa1Ni8LJF/Jr2kEc32cbgsDbYm0hoU10D1iLgk1UdjDxSL6QHzcyVdm/5di2wsQzGXpDTUUIiv2jLVbO5nV4qSJ89FoL0/0Wk1skpfA0EfmWylAGdkZcUAWQhl7j2Aoat2hcy5ZYOSgeEOZOfom6dfFr1jEKMwiNKJnouk0/jvaV/TYlhftKzA+uj3R+/WkL+uav+2G7PT7dTY6ylv8ARqV/Lnv/KcQO4LLNp+KemUYukYdUBhBaKYF37ngVnGVIb1aLIRM8sVUUx/utGGb4KtvmeFQu/w2j0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnEwvXThkwoWyz/p0kAfm8DNajatzhYt2fjx2KY9n/s=;
 b=H00lDPkc0+ScwMyWYnf5OPWys+iSjNftHhVHYjLCTB1a64mjj3D4x6zmADivjz8Fo6rTxeMxRIQYd8bML+RUvEQ3VuGj1O5rnkb4pszZH5CgbshJUsmW8pyHwNGcA9p77YfDs8wPjIyfazLZBKQG5YtCGyb0rqShTUcrHR1LQWorubOkEeRM45HIwxrRHpp+zcL1LLPDcZaPTXfnkFpJWzJc4JKv39DghWU3iyQFQDkZyoGeykqXyUkhMpDsS5p4JTPMY67uWrRSrnrchLZYQqIThzfB9GGvb2xATTO36pKqQhhGK568y2rfjKWTIA7QEfbWuj9pUrXesDaexj5YRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnEwvXThkwoWyz/p0kAfm8DNajatzhYt2fjx2KY9n/s=;
 b=pVAP97b8/9C6ehIPxe+ypZh+/kWUr4Ln5vWGCA7JguayFhIgxXP8vGGU8qX517ipVzaNgn2l+u7N7CB2SzJZlryN8DDdjx2Z5PQFc98fBxzuvkT58m9dFHCewZa/GHKUH99h1i0EZvIePTccu5Cw5PRkotvjhWKVvfigvGbqgLk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:42:07 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:42:07 +0000
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
Subject: [PATCH v8 05/17] X.509: Parse Basic Constraints for CA
Date:   Tue, 23 Nov 2021 23:41:12 -0500
Message-Id: <20211124044124.998170-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211124044124.998170-1-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:42:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c439d02-3b05-4009-fc38-08d9af04c4da
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB39570853A6864106C72045AA87619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ta1Jus2Q03wrBIjHI+LR1zFJz62QOowUP5OzY3eKM2QLhhpgKAxjNgLDnsONq34v2q+Dvs1LbuXDmZ//KLbEgVNDBnu/q5I7XKAi8KbvUD7L5NgTdZnYKkUDVuizE1SosCLJ5Io7UDyormnMH2tS3ZPWW3Y8MpjFBrROPGxFlUyfFf0rBEqgnOanekKfb4ALYVWByWuRXeJF7URyTujdXxTJmzDPk/vqB7cF6Pd5C0MPH7/H2/j3RUkPmSUKrcsMQ5krZEYfkeBxyRuBsGamVnXgj6BFLTm+rMIg182Lc/okjjWpm0LTHCZ2LMG4ifY/PuwO3KY/n5xtqhLqx3ePFlO4Anr9ZaJ3mXIseckXcxb1x2Iy+p+QRvizMeiCue2pQ87RMW/J3JRYYRfFJ7nLefGPV8GNmjIqhHt5uFu2Gy3cFogXCjTFTxKY363d0A3oVJFptjx/PqvDCi5/9AVlfJNzjvSDbKDmvrfVKvVNSB2rmKdWlhoKXnaC+VghL3RZZFUk2DPDcst2cxxZ0kUU1HAfcI6s84lc1HhDCFIkF7U8rH16rvyWVGdtK+anzIh+Pik7hEfYwS5cgTZIriZUMt5p/9xScafungR9LNqi8nZC/MfBpgRwY9IcSctduGluGOXXsZoYEDISHa/rUTxcWHq1NtNcfF6DaUD6YO/lnihqXLwq0PGtEyNTs1SQcXs8qypO9mVnAoKaIOl4vApiLeub7gMv0HO9zb9eh8MD1TY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8kGnXol7D9A87D5jJdFM0GO0tubKcmgBVPnHP/UbCDrcHaj+aOclwCxJ27lj?=
 =?us-ascii?Q?kblKDNpduRDa+mU5b9C2hcpf0X+CHujBnnpCG69vtxCqeQSF7NplczOgN6BY?=
 =?us-ascii?Q?IBIBLaGbNyffr+r/c9AFakgP7Rd/3YVQFSe2u0ciDJRw4CeIHnsWzwpIUvL/?=
 =?us-ascii?Q?KD2udt5EWc7E76/gk1Kwi6bbds3lCtgOw2h7zEWa0M0tjG1pv92ajUzZHiBW?=
 =?us-ascii?Q?YydTjzu9ffv1TMxMjiR6eh5Kqn2g36MIUqxEtzz4xJSvLdfuOoaz9T8O2jew?=
 =?us-ascii?Q?DNClIB8AjQ6GcrPBaulLRI3QWB/WxPEnxYUDyplwhsJoHmM91MTA5VpTYfjJ?=
 =?us-ascii?Q?aQg3NShIGfqjodqDdKWQSczV4Q36NHdknIyeyra5PpRq1KKnBASfqe6rR0QG?=
 =?us-ascii?Q?TxIoRGJlDfv5HYFVFvgjq0PQZnqwBlVZiovuvL+7etqTcQEAf7AQOKIaB8cp?=
 =?us-ascii?Q?CnGoyNo6vhiYQyahj987iyzKPgE1n+AXcQULr1lDd0wcgews3FvMgdoDmXBo?=
 =?us-ascii?Q?9mTGS02kxtJqslIpOLZDfCDSCUbw8+IhOTMAZbK0Vz88LIMako1/AzxkCPGw?=
 =?us-ascii?Q?+wxgplUHW8A79v53o+derNM5C0+cNGu2A5blCaDgoY9MBZCSI6qCijaWqfWk?=
 =?us-ascii?Q?SpgAKaJva2hzIkT2BDlKZjCjBemM+ZE/IncipciGbeGhwieCraPglmEN8zqD?=
 =?us-ascii?Q?EQ57agAmQD4xghK7HTiYRxBjrAASnykzXJFjqrLEcL3K16aox5Q1AYmJ/6L2?=
 =?us-ascii?Q?Oge53oiixtNPDoQR/6DnO5PtSwRk/FZoEuAfgOewAmrN1TFVXcP8QOpxs7ki?=
 =?us-ascii?Q?e4Mi+5uCh5qr7penEZX261pbRdMMQUt32Zxz+jmuYqjjzNUADgHAAtD8p+54?=
 =?us-ascii?Q?N1/TLWUPjUSPMPNMVnrUXfTDEVcKviA/ILpPFUTK5goVCh/Fh1wEEtYElSqS?=
 =?us-ascii?Q?HHWghzxTR25c9M5muAe21cOJSxlJmFv2R0/lRIf8PE5vYu3E75BYOjLXl+MI?=
 =?us-ascii?Q?shs1cMVU4CWS44Xq5vWBaUMyDWoT8wqOgNim33al/sJKW4wtb6mgLkMk1FFj?=
 =?us-ascii?Q?rRuIOFDYZcweReO5VSBGumy0z19+rxyEJ9IZPOtwSb9cLed8qQ4Ma9oZGOfP?=
 =?us-ascii?Q?fTcRTrDzOz+41Mk9H6TnxSA9sloaXKppqtRiPx4Q4U2gJABt3kU1NIy5U+Ha?=
 =?us-ascii?Q?WoGf9Ua5c1eUHEbdF1kucK3FTA+K6UuuURupXKglEg9MZB7aFJbR2DreFuQL?=
 =?us-ascii?Q?NTIpE3YHHnr4K9tE/YFbAkzAgl3T6knK7+HhfVRM6vefxpYCUecDNepNZc82?=
 =?us-ascii?Q?2Vbf0dwrFrDwhFoFgCGrt65RvaCanS3bqnEDhX4QFXZxNKGYM2X9nPkFarhC?=
 =?us-ascii?Q?YOyFfPwLFeMi4kljefYZrMzpPVuUrP0Oo80y4IOYklWxvPz486mCD5dTg94w?=
 =?us-ascii?Q?DcGPdZxVas4Ye+vGmZCXHUDNKVHs8hsIDIjolL1ZxIcYwWJFFJpyPxPklokT?=
 =?us-ascii?Q?Ycv7AIPDIUEznaNLl4rDBakXBhNZsloyifbgdmnMojX5Q7f8ofhNdoXCTX/V?=
 =?us-ascii?Q?XZuLqCv4EJDWdjs5SkaouSy3iAERpCu3lwIcTiYISnelDHiZH3YiSUtR7jq6?=
 =?us-ascii?Q?BL1Vc9AnJIjz52V2SW33T0F+2SDJPqQ/ZWuhqLWq5uK+t6pX5jKLgDPjB6/q?=
 =?us-ascii?Q?HeBJWg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c439d02-3b05-4009-fc38-08d9af04c4da
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:42:06.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjOHWxFKgSspvNH1ZvPwcl6AeVWF7JtwiYG9eDoJ8g0jucGD20d/Tuv46hYL5cRpfWXVPQUMpImUwhuNyIRX6LAzNNn1cLoIuizOemCAXqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: Co-t4PIr814KqwtStCG67L458RpKEMLq
X-Proofpoint-ORIG-GUID: Co-t4PIr814KqwtStCG67L458RpKEMLq
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
v8: Moved key_is_ca after key_is_private, recommended by Mimi
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
index a9b2e600b7cc..72dcbc06ef9c 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -26,6 +26,7 @@ struct public_key {
 	void *params;
 	u32 paramlen;
 	bool key_is_private;
+	bool key_is_ca;
 	const char *id_type;
 	const char *pkey_algo;
 };
-- 
2.18.4

