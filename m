Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7144B4FE4
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352870AbiBNMT6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:19:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiBNMT5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:19:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C36488B4;
        Mon, 14 Feb 2022 04:19:50 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ECIHPY023929;
        Mon, 14 Feb 2022 12:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=E4G9Ht5awb+Oc94G3Z2SbeuKHnjAAzYxEn6hJkqXA8k=;
 b=0tzsoTtwmjQOvNkTtLDj0bFKoBVzXohKlhW7YiaCgKDJj6HbOQ6vhgokgLa6epW5vXh1
 jEfTdaRZWFLvcUo1U4emXh8tTaWnKcWvQyNAMF4CoS3Rium0uZXtYutGnxggDG0TH6Zb
 vwbF+C8QydniKDPM3hxz67s3A11G1zXezvT87ddeLGECJfJdub6JqFIlpTS46ZZVQGdG
 wtZHRaYm8gv9RDgJbPh0qj0iMg6Fjncpfrb39+1wOFJwsYgwzOlZFpNCM10votCXe3XZ
 xxWRJjbwsf7ZkjgMA5EKiChJ5mKJ3y++KCI/OSzkEKq87h4t47Hh5cAGgSdUsaRVoH18 wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbv4e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:18:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECGO2Q082563;
        Mon, 14 Feb 2022 12:18:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3e620vvdrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3tG8ltBR5qxAqRA2pvA3vDuhRhuR/N+9JH+axWaluYcB6p4Nza92yNj1rcMZ0TVhFIpR4cEXUudQ6Tgwy+Txlz5u9eq/1Uj87B2D+ysqWpp+lo0BQhBM7F6OFZ6fuj/AFuRGxdjpF9NgDnGxg1MflMUI62pLR9bY0SrYSr34yio7AcAuT28RWHio6MBodtmg80vDMJshiZ46/aHrYZr1GMWTCfTdZwUfE1uKcd01ENx4ou9d64KuAkBC0/Omd5DWvQgC4BOOAYNc2Pu4EJ90IRK/amPY9VrTYKiuT4Kb7EZyosn33pEmSupz5o8VPPzumOtyQAGput0BuJcWCKDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4G9Ht5awb+Oc94G3Z2SbeuKHnjAAzYxEn6hJkqXA8k=;
 b=lVA/t5y1LWf8ff+UDqOKk1Qv60bqlWYLpAneYz8f/yI2B3zI4ZXHmt/hiZVgo935ULFEcaWSISO+HX35k+rmCseGqphKC9vQOStuW+7bSnjt68qZQYmcUgl3nDbGkIyOa/g8StwzbnnJZBNxsZSPu6YZz2+qJIzf/Fry+oD0OmPpuUxff/FSkzAW/3NvlcYmZ9SRpceJYEzLINI4qF5Fw5TJ1Qf4Q9j8MgXMfDWi4//Zo15gKGu6dBexrKwrnJpfWZKFVfjwyUwP7f6SvK+rvCato+qOGjd0zYGCukjNPn4bV6kwuqDX0hhCtpDRN+INJqYtM/Rq35MGY1wq2IvLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4G9Ht5awb+Oc94G3Z2SbeuKHnjAAzYxEn6hJkqXA8k=;
 b=bZcSQymx+BwGr03XLykqNxH1MlURHR+1hjOLBVnLBX0gIly7J757LHxxFZr6/I2T3JIdXixMl0cybFUBPOiozMAPXNfam1QpaqEsc11hmgKZgk/xndD/sqYeh/DMIOQQ05JIU7Gbu0f8010NEkrd+EgO6FsYk3qiYmq+KWXo9fc=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by BN8PR10MB3186.namprd10.prod.outlook.com (2603:10b6:408:c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 14 Feb
 2022 12:18:26 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:18:26 +0000
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
Subject: Re: [PATCH v8 10/17] KEYS: add a reference to machine keyring
In-Reply-To: <20211124044124.998170-11-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-11-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:18:20 +0000
Message-ID: <m2o839tzeb.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB6P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::22)
 To BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4526de3-9aac-4cda-ea82-08d9efb419d9
X-MS-TrafficTypeDiagnostic: BN8PR10MB3186:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB31865643D4108E7BC57DC29CF4339@BN8PR10MB3186.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmJtHb9sHGeFDGkS2NheNwcLmp701LJYbeAQTpLpoVHNqIqD8/gvIUl9HiEssLPeIjeW3/rkGHSqzVAeSwSNjmIM48D+pBI41O6MIaHi5I3oRt2eFX8ET60viqrj3jxjRP6riYdpWSvzWK+jhNGjBuN5W7LZSZ3gVE5R+g8IWBZvLKFZCCaLq8fUCKaX+ag5L1omFH0+R+n36Me68ozLDrVoUsCM2/4kY19a1A/WyAqC6V2fgjyshndLtmNOSkG3KLJDqtP6XVVuFgkb/C3B24SQcJJuw1Qci7wggwNAGYYafMwOGo/C68FAOM3PftM6jmCtwyR4R+1SHXJ7EPqLEhTgp5pnLhRmoMjnUoWMqP4353HcWKD76F37/OsPcxQVWcS5rIOZj0KQXA4qi2AibV8YWjdbat07NUZja6Wok2kzhrYN7WgTs6A3svJg9HbRXhUuZX1LkVojmzxlQyhjJSviRVAftNBAAJ9aqK2kAnLNu1R3Bgn+9EfD/CGLdniLPREB0PAFCPUTkt16YvsvjDzt02fUFxUC0p5kY3Rcmo4hOrtmu15mdpTD09Rle3aT2cedmxhr9n5r4KdeG06eGnDWmavXpjiHsYgGb2ulGQk68bk7uYDTSEi1czKQhnxR3gK1fC/X5tKPh+HV6wRiKY1FtKl9dJHqSLyumcQFn2ejMmhrAmLA93IdX6fa1UVi6y54HkacQvAqFjCUr4a/FBRsGZhzchU2epnQmlZma5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38350700002)(316002)(2616005)(4326008)(86362001)(44832011)(4001150100001)(6486002)(6506007)(107886003)(921005)(38100700002)(36756003)(66476007)(8676002)(8936002)(2906002)(186003)(5660300002)(6666004)(66946007)(66556008)(7416002)(6512007)(83380400001)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9MpXWBNoqpf7Sz/Jtwwq0sje4MARdURCIJr/2qsfBLt+AQ5w6vsSdhIfIfP?=
 =?us-ascii?Q?5T9RQXcIdLGNw7qZJymXpq6pVInE6fdDxalP+gg7QF6n938z41+YkhX4iEJq?=
 =?us-ascii?Q?PWYJxIfk7pJJALAC8g4Teqlg8XbcEQ84ojTO1xM1QSgnMGhfKdekcvuR2CXg?=
 =?us-ascii?Q?g3NriStQbeY2QszSLJ/OQ7J72NseHsj9kg4w2vtnHCz33nLHNQGQxuKoGthm?=
 =?us-ascii?Q?7k7mzfQf8lmov5fUVjmWz5p+oMaygSbF1xqosD/tgcStNcQzBlxH9bY5KKm/?=
 =?us-ascii?Q?IHh2siPY9K0R9fG7KY9t7riQu1XSIUrlrxbiJpA5HIPDg0WyHCsr+0zjJBFu?=
 =?us-ascii?Q?Q0LXA7n5Rj+wpfHRRyGLdAVyRIWlzh/zxsxmyQQj4zix88jlb5eVi30Ix7ga?=
 =?us-ascii?Q?y5Iz88vA7KYvHrREavziNmsA66Iu+X3awTKoyXth9MlohUKchoe8YF1YQNpz?=
 =?us-ascii?Q?C4cmPO5d8YkCb2DWAsbcTxKndz31bvDjs9DFv0r3il7DHy9/kxTAYBJE4/mq?=
 =?us-ascii?Q?wBOpo3vsnZDZ1pix7Jb9X9jmsveO22i5U7Ixf0ysIXpnZUQB7Un5yfTwqAQk?=
 =?us-ascii?Q?ydge+2AL9dSgb5yBuiO2PmnUUXUOgT9UeeGUZaLW/o8BAK+U5M5qs+TGY0QB?=
 =?us-ascii?Q?HQ1qTDCJPCorB0sMTOC1tLaua8eNLzlMW/sk8jTevEnnr9nPuBuCUCQuEb7a?=
 =?us-ascii?Q?iQ+MPxERoUWvHqil7l5sEAAlazcBy8LVjGlUC0qVGTsy+OWv5MvjTuJ+3pfl?=
 =?us-ascii?Q?LEaSyPRanVdB/2+X4ascQKGsEJioZaJZ4KFYfZdcQ6zSGEx7yl0o11yIJ/ho?=
 =?us-ascii?Q?gtlZ//vJgmJCnV1aNDjNLetkdAhmeKxdUyqGFDcJFyPg8BZdchAw7FxKNum4?=
 =?us-ascii?Q?RIDbmRSHg6dr1Opc41CSPkSiGddqyvPN7AG9YOAsV5SadC0VwE99ZdIIDuS5?=
 =?us-ascii?Q?u/pCNPZX3xkOWWkl7uoc+EZkpSrtZDiJ8VZpJjdR9YeUfmZLOXFix4kL/sZW?=
 =?us-ascii?Q?k58AXUn931n2hlNRaydg+L37DZmBACf95lhRrjaCaRHeauu5Xpg9FJvrGdbV?=
 =?us-ascii?Q?xVs/JiyqTFC9RQUxh5vSURQEI5vKHyv3N6EO2PYNXUnvRwcsQZfY18pNF5hY?=
 =?us-ascii?Q?JtOEL0HGF9cE7R54u0PFdlKvAhZohUWnD/8h9wKbsf5uI6QBmKS6CKh7AOJh?=
 =?us-ascii?Q?Rm36KogAO2+0XvXxZcyC9gpsL9yddRsJDeylMJoqED01gFznga5aejf0FNsH?=
 =?us-ascii?Q?7qMq8drI8Kc7GHU4Nb0emxlLU5mq/Q839bT9CeYDFHuNPNZqwMyAnTj88yz7?=
 =?us-ascii?Q?QXRfGKVzcK1uvRppUDSqdeHEZyODNZmIdNk59nEIqHjOUkbKqLI81lo2GH+C?=
 =?us-ascii?Q?Nzrq51J2b+X57yYaHSS8+f41T2M520lhMFJGTuUaKsq7ljv7B6mdKdHEHUz2?=
 =?us-ascii?Q?wZyOsf7U9D/c1ExW9pKdfl28mKy+fBjVOF16hqyJjsf6Iizs3KwHVXXcVaBF?=
 =?us-ascii?Q?66ZtPpI/vBfv8UuRAzojHBSaVuvSK2KzoAx5Y+LjjUs9fxCXYbAj+LakN5Fj?=
 =?us-ascii?Q?s8YvUsij5fdKKCWGLynME6cdYwYCBxwfHvB27BX1gh434XFrg2LxdYXAVZmz?=
 =?us-ascii?Q?XGg/i3DI8z+WELroOMir2Lg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4526de3-9aac-4cda-ea82-08d9efb419d9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:18:26.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOuR6icegdXn+YoQw5Mg4bnLxW0Yze0eO4TrYe4P1mH6Pnv67NNhqbs/DDSdWdgdDNPboQV9YXvZbmIWUsO1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3186
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140075
X-Proofpoint-GUID: UqDwvWtGzSiF_AHOgmbjm5VCXqfRtE90
X-Proofpoint-ORIG-GUID: UqDwvWtGzSiF_AHOgmbjm5VCXqfRtE90
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:17 -05, Eric Snowberg wrote:
> Expose the .machine keyring created in integrity code by adding
> a reference.  This makes the machine keyring accessible for keyring
> restrictions in the future.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v2: Initial version
> v3: set_mok_trusted_keys only available when secondary is enabled
> v4: Moved code under CONFIG_INTEGRITY_MOK_KEYRING
> v5: Rename to machine keyring
> v8: Unmodified from v5
> ---
>  certs/system_keyring.c        | 9 +++++++++
>  include/keys/system_keyring.h | 8 ++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 8f1f87579819..bc7e44fc82c2 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -22,6 +22,9 @@ static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
>  #endif
> +#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +static struct key *machine_trusted_keys;
> +#endif
>  #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>  static struct key *platform_trusted_keys;
>  #endif
> @@ -91,6 +94,12 @@ static __init struct key_restriction *get_secondary_restriction(void)
>  	return restriction;
>  }
>  #endif
> +#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +void __init set_machine_trusted_keys(struct key *keyring)
> +{
> +	machine_trusted_keys = keyring;
> +}
> +#endif
>  
>  /*
>   * Create the trusted keyrings
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 6acd3cf13a18..98c9b10cdc17 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -38,6 +38,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>  #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
>  #endif
>  
> +#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +extern void __init set_machine_trusted_keys(struct key *keyring);
> +#else
> +static inline void __init set_machine_trusted_keys(struct key *keyring)
> +{
> +}
> +#endif
> +
>  extern struct pkcs7_message *pkcs7;
>  #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
>  extern int mark_hash_blacklisted(const char *hash);
> -- 
> 2.18.4
