Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EA4B5079
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbiBNMnY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:43:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353378AbiBNMnW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:43:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFE249279;
        Mon, 14 Feb 2022 04:43:14 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EARqrF021223;
        Mon, 14 Feb 2022 12:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=daekriFGJO7mFmYQrwCc1Qi169r+P5nIdd54i7kIWyI=;
 b=BzcjmHhRwdgl77r32VMOwmNC2w5y1ksb9cCrgr1dlQSapttTAVJndipuzXCouaG0YPIc
 2Y1ZR/XlEsGHRewjGRWcVrcdUpksZnIdkTF3wdRzMkSYMCzvJX4Z4lrnX/C7juVuja3e
 W7iQ4CqFEqBfYst4OEZWBayqIYFKJBeiZZPahk5K3ZrhGmKGshHVwAWQOiHPB5zp3zec
 z12iaqw9efDPMbLLgowql/XGPdS53QaoH4zdy1cfV3I5kHjeANXYlLhdiISJs6pkDhU7
 +c1VKXw5BB7JfxfcvLpkUiVF3bx3RwoBBzD0RKahfJr2Dp2bE8o+juWYRzVXKUizWvhC aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p24ens-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:42:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECePXn159179;
        Mon, 14 Feb 2022 12:42:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3030.oracle.com with ESMTP id 3e62xd1r0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmU6x5IFj5sr9LZpKE5XuKLVoOIi0fICW/up0nmzpqjhAj9zfPhKbYEtcNiV4pjoFPXwII20j1+S5d3nR8S4NJeoV7FVqswzxEiZ+68kEhcYYO8L2c2smAKfRsoEJvd1gBAUfTBNZVmNzx+t63Hdd8d0X3fgg/wPHnGdK9IMGU7+Djd5pPPBY9/3Kb8lvTngOQCf0ZqF5lYr1aseySzTXeuzR/LaQa7ABINUz+18FcTAvv1pFUFzTmr5ES6A7IRkK7Si5cvDavKviSaQyEBKvBsh3wk/pJrlamCTcQ3MJjKbVWFE5XfIBTNnS8BXTk6x//lwbTOZ0TQDlOeyjA3p9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daekriFGJO7mFmYQrwCc1Qi169r+P5nIdd54i7kIWyI=;
 b=N4pS/eMYV2CZOD9sOkSRIswJIE/LRImtc3K2WHL85Q8TGN2WgYEcUZCkD2bhDHG3dZg6pbdqUPX5G74A0wRLLIxHvVLjmqNHJ4CQ4Y28iq3+2fpQBKrS5e6G+VgDaqDsiX8pwpsC15VJS79GeplqkQPrVA0tO0Zhwm+A5Rw0YA5cTh+EjvNTfAr0N6Lu7sLaBwrAr/lA/xQFZoIg4soLDGwiY9vpBJt18/6I629UY34AAQxMLAp5frBRTLl9wFeDsvcIrXcZC+bpJ9ws1m9uWZNZnTSM5nPl0IEeo+OnlBYTqt9JFoorVssQROduQf18aPXHEDog5Svp5a/pHdhVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daekriFGJO7mFmYQrwCc1Qi169r+P5nIdd54i7kIWyI=;
 b=xeuYpwTE4ACeaT/diparUujge4S8BZFRMwGxPZvQZQ2vB8guiJSMC5JbKs0uM/ZlGHtK6+2MWlTAfHuD3kIYs5t5DnLCkPUIYFBXgTU3AHM62nd1oEmDQcqn8klxQT91RUVSp1HC+s3s1TtbQrDprdZ6dRH48xmNrJ/ROAI4Gn0=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Mon, 14 Feb
 2022 12:42:09 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:42:09 +0000
From:   Darren Kenny <darren.kenny@oracle.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
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
Subject: Re: [PATCH v8 07/17] integrity: restrict INTEGRITY_KEYRING_MACHINE
 to restrict_link_by_ca
In-Reply-To: <20211124044124.998170-8-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-8-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:42:04 +0000
Message-ID: <m235kltyar.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0357.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::32) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3397007f-33ef-4f7c-330d-08d9efb76a63
X-MS-TrafficTypeDiagnostic: CH2PR10MB4133:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4133492AED7B726093BB3507F4339@CH2PR10MB4133.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VW8H7sMSg/EyyxFIyiphtEzUBsUGfICDZ/km7XxhRMHhiPJYZ9a/dj54REv/xv1DmAN/aRhtfJC2dfSar3MYCxfCXBERtcbOebdIEEtcWOg9B7yQ1v9cP7FBzjDNjYZYejXMi0o76CSNOmnEs7WWjcOac+6Rl4HpcFYVYNpDWdYzyhRoBHT5rnVfpvfukBD+VvmoSbteWT6ZSWzRRuGlHr9yFhVpy8ETtymyLJ8QgKiVI2quZ/Vxbi6ZUjtmPrUoVcFZ8fH1l+MtjKrUOYU3IpFjcboPs5oDJJp4GtSw05evlHG9xNksMcQeZ8Gyj7lkSKdhb/1mPttbKBtGo4xK6T2gVGgeuzA9W2BIk/KypqmaA+LWrAvQseIEoKcsDCG8Ml0zi+cdZYdo9BxvEUq0hObOvkV7XAbNaQvNZjRZDA0gzwXVk/y6rh75/qGm1Fw2NgM29mH0NH+cuZt+xiPDJem8qVxJrOKrr5q6JCXQ7A7pNlEWiTK556kNsfC3GilvCHC6pKWHr8Q9KqPttYexU3/vaVPX9oPu5RkZ0BvuL9kbqOM4Lw0Ms43gLsUb8jf1IPwqWBdIlVlLZadH6XmB9xM1jNOcusKrZDqiSldzC0XPke/yMauU1koApAfMP5by2ot3dBaUz4jlbCUXPYSyXuV/CcW/YcN71fbQKmAh6ThJR3Ypb+Oaf6s6BxOW3o+vskh/wkemUjbruGCpJkHYWrsjfGAMqo1sPCb/UIWdd3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(508600001)(6486002)(83380400001)(6666004)(86362001)(6512007)(5660300002)(26005)(186003)(44832011)(2906002)(4001150100001)(2616005)(36756003)(107886003)(4326008)(8676002)(66476007)(66556008)(52116002)(921005)(38100700002)(66946007)(38350700002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6RtZ3J8vKJeJASZ2qsoItvy4dNoktqN5UhIZa561h5+3zVQq+mNDCPw85Fvc?=
 =?us-ascii?Q?I+9eTEiHPblSGp3VFhFCU7I2fEaT0ByufNjrwSWYq2dPg9KPhWTT7RlFvDgo?=
 =?us-ascii?Q?oXbSIL7HIxdFYz+R8X/vakjFkOUGE7oK9MAF7YO1SQIFAeiySbUtIJjZIGiu?=
 =?us-ascii?Q?M27Oe4vqxdZK++Y1flaVBj0nxi9jCDtBiejJ3Ecm8F9c1x0vmnygfy7v7fd3?=
 =?us-ascii?Q?OrUMajLM0pjI9Zhp0/kpBnPfyFWZan5ooLyvzfqByH1L7++clQrdLGXrIdo3?=
 =?us-ascii?Q?rC3qioaWwrdPVnxWRcnRvzoXcBJ9VEehQr14o8RqbApRaJTqoPSdUNj655xP?=
 =?us-ascii?Q?McTmI3YL9PHpXwegecCM3yZS2oUAAz5xIVFHmOFQOIqiNVxur+mez6LPGGI/?=
 =?us-ascii?Q?FWlTg2lWiVaJOMxePzSPoCxmUKg5G98eUi8HWL2ZzPL21UCNWXZXh0bb8K1L?=
 =?us-ascii?Q?w0B9bOSNIwaTQpvgCacRkWVC3iVLdMMFvFiwo6btRIYp34pVWU8uFP4uGBv5?=
 =?us-ascii?Q?hORPZD8ykHOyV1Z/V8lmxmyXqKR+TdHASX790wv9agGtQZP5sk9/jsLHFzTy?=
 =?us-ascii?Q?Gb6Hir0VBWnXJhv0ki/BKRs6NyRBtVW0CCz4CqyMXPPwI0iRb+ddxqOFgvSA?=
 =?us-ascii?Q?0npEl5iTE3LLdHUBstaU80RJBhownZBBkYXrPVoZTzfuLJg2vvvcHpPqdKKp?=
 =?us-ascii?Q?ARxiCVwE1VgY07ke/w7Yqa5OtW4/4V2CQ9RuuU94P05QDALAhg/0yoSg+16q?=
 =?us-ascii?Q?1lYrrZOEf2++je0+xQ8hJgM2hEt+heZTVxjqy0WYS2QBKbtnu5L6fTmY9CgB?=
 =?us-ascii?Q?CRTiUppyWt/1ow1kDAtprtozKLx+AdSnHwmhRn72nXVttKBLrSgkiHDgsm5w?=
 =?us-ascii?Q?YTU5+iTegjkScY7ck8Zr7y3bh1wjOUeF3QMGLmhr9RGvvNgtvgCCcyBuS+JQ?=
 =?us-ascii?Q?I3G0IrIIb0WyhIUBIPTxJC/9Hcf+c6HpJXyzDLJoFc0ea5bbVpzlfIXq8IGY?=
 =?us-ascii?Q?b4NR3BFSu1bUdGkyvyw5dH6l5FTHIwQu+U68T73nQJzYFMa2rlPtsfP1tE/Z?=
 =?us-ascii?Q?125NUTa5GaerTRB+W/+vOL3cYs+664Y2PYIqH7fTJl//6QE0z2u462RAgV6d?=
 =?us-ascii?Q?tHPPHWZ0d69E2p+re/VJWyVeuqy4FDuZvehVDO8aq9x2d/D3enQ/gH3AL24K?=
 =?us-ascii?Q?PnH6LYIBdu88KdRY/FSZfWt2H75NgBGRJ/wTTErGaf4vSLrifVW/CO/ENUzp?=
 =?us-ascii?Q?bIQrwFHiDYOcyqyxTy5uBuRSwPR4ngzC4b8JdiV4hVCzu91Bx61rMa/UNVvQ?=
 =?us-ascii?Q?SjKY2UWaVJZXAlLD2kRFe51L4kr4VvIL7F9XU0DV1oJ2Tf9tZnF/NvMHUqIH?=
 =?us-ascii?Q?ZJE81O/q1lJO0fSxg+Dj6EEs3iBC7uYY32UX7EMjoJPHJfnMuHedwY9SR951?=
 =?us-ascii?Q?2UDbOSlgTNMGCAy/oG8ZaCa+CtJ4EEAhX4/F0pxwlVC8AqLUTROMkz8aEy57?=
 =?us-ascii?Q?Py4dBFhKRQLR7iwrFGa4qI+A8tFLvE68ssnChdeIGSpFBNzcWAW9k4HEPT2x?=
 =?us-ascii?Q?mT6xjeX6D97M4m6+KRrteqSgmwGECwsdCF3JFRaIrRyrovgOMKrDepP7mv+L?=
 =?us-ascii?Q?p3IickMWbjAFiD2FD6JYctY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3397007f-33ef-4f7c-330d-08d9efb76a63
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:42:09.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtAMGUWJ4bEXovswJWWETv8eayaQbGsVMdeJcWOleFpWrIlBjMbMUvkI/Lauu59g7KwYAvdRycp7tZg1gLWLwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140077
X-Proofpoint-ORIG-GUID: XBoZB23hP8yr8X7ONFW7_sz8bF1hzhmd
X-Proofpoint-GUID: XBoZB23hP8yr8X7ONFW7_sz8bF1hzhmd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:14 -05, Eric Snowberg wrote:
> Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
> restrict_link_by_ca.  This will only allow CA keys into the machine
> keyring.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v1: Initial version
> v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
>     keyring gets created even when it isn't enabled
> v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
> v4: removed unnecessary restriction->check set
> v5: Rename to machine keyring
> v6: split line over 80 char (suggested by Mimi)
> v8: Unmodified from v6
> ---
>  security/integrity/digsig.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 910fe29a5037..e7dfc55a7c55 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned int id)
>  		goto out;
>  	}
>  
> -	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
> +	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) &&
> +	    id != INTEGRITY_KEYRING_MACHINE)
>  		return 0;
>  
>  	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
>  	if (!restriction)
>  		return -ENOMEM;
>  
> -	restriction->check = restrict_link_to_ima;
> +	if (id == INTEGRITY_KEYRING_MACHINE)
> +		restriction->check = restrict_link_by_ca;
> +	else
> +		restriction->check = restrict_link_to_ima;
>  
>  	/*
>  	 * No additional keys shall be allowed to load into the machine
> -- 
> 2.18.4
