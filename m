Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4F4B5052
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353239AbiBNMiT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:38:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiBNMiS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:38:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB1C4925B;
        Mon, 14 Feb 2022 04:38:11 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EBDv49029601;
        Mon, 14 Feb 2022 12:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=69ObOTcHVGMsRwHlvkl39NShg/KOGQ3KsCZ8OPM6x+o=;
 b=ypYfiD4tgdyTiAdHuFFl/aPRoHVbsDnti0gXT56VoilrIJ3+sdSYRjqILzONH75UadCh
 fOFWuW6kb53UaY7Y6aQMbFQIzW12oZ10jweBCP4GgmbBqB99apmtJFmPAQJxH85jybPU
 OFG7/sn5ejm+iAqlFdG0hTQeuBhm1sewR0qhxToQQ93ReqUolhBp9DCh4Gpv1EnPGjTc
 mlkHZZB9iofVLSZVX+ZsaIeE1qg90/NYPFLCEQPa/jLEE00oicoMh7m9AYo1jiGyuW1t
 4GKTe8RHQPY06ScDR6N2OKTcQ+vbewa+wdeVAS7VYT6CZkH9Y8bF51Drq3ymkF92/dJB Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g14ba1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:37:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECV1vL012073;
        Mon, 14 Feb 2022 12:37:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 3e66bky3q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEd8Mk0iYrP8vsZNdkSLQrSrIB0NzLDTRR68vd+n4XZ5aGYeejNR2pyQdHl5GEqjRidKPeTFXgmid+opRD/8mxjmRcZD36Gn8cV+7y0zDCqhvx7iXkDm4GKH6JJJqnTZ5d2o+XXHg78L1cxvI2uMvBMQax+naTaVM5ZI0L8gpl0Pe2BICU/txFjJRAq/vIlzP36dj8P+ZZTWfuS7SdKBM/GEJ/kCB72HYV2phKVETwSSfferSCPq3cHqe8iCQiO0AvB8DoAYigaOfD/eyFeVysikeFdHNxI5pxK84zR9wHskceLSrdfJact0pWhc0cc2W26X4jwrroyrQth1F3jcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69ObOTcHVGMsRwHlvkl39NShg/KOGQ3KsCZ8OPM6x+o=;
 b=NyBndi/BhI4gHQgOqFZaailPTDfbuSFzofRkJPAHSu0APhGEetBn5oW3WtSwxVAuip90FPrzMsV/3lYx6ik/W+PdrGdUPgXgZJbjIKUZ3iyRajPdFs667JTfTqkhMa9RBAyjSf2dHZZKpICas1uQuJX6xmkbf9SKPTab3U3DCXzMiZY5pCo58TSzvInAFBkeEm127MVgFTGUaxrg1tAiP5WLx0xjxJF9I6FDlMuxUIAfZ/VdOY4u9e772X1Dtek+OsC2uWd89FMGqOwqkzOZMqak/+o02YFOh251EjIi/RnajSvfHHgfDWVmqYZ28N88PDFbkzhm9TuMW8QbV/T3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69ObOTcHVGMsRwHlvkl39NShg/KOGQ3KsCZ8OPM6x+o=;
 b=wR86c2bbxu+78ia9eJXN6kyGhaSCi3mN8yKwgX1+b6P4IDdywrNhdrsR3cTbfspWJ5pqKN9Vo2m5KDPXiu54Dsjqnf9qoVT5ndHkP1YUEgYP3+bCKcjnauujlLkynDDyBO6Mj7r0SYUVm30c8D/Iv2MpinAv4mU3foZhh/zBWIs=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by SN6PR10MB3437.namprd10.prod.outlook.com (2603:10b6:805:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Mon, 14 Feb
 2022 12:37:07 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:37:07 +0000
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
Subject: Re: [PATCH v8 17/17] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
In-Reply-To: <20211124044124.998170-18-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-18-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:37:01 +0000
Message-ID: <m27d9xtyj6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB6PR0501CA0004.eurprd05.prod.outlook.com
 (2603:10a6:4:8f::14) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6705c8e2-d503-48af-eada-08d9efb6b603
X-MS-TrafficTypeDiagnostic: SN6PR10MB3437:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3437B04F68763241845844D0F4339@SN6PR10MB3437.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/b+Kxmq44KCQHa/0rF//dO5xv3hkcP0JgPmYb/qm+pGTEt0gJ7g8d/le8ORbHbQMnw/G0PyGsD9QR6uguod4ZIb/VnA57DjZF615tQO/o8+45hBZmZBMioytV1EMmnYsTtyy+QeJsNiZz2gYVMzhYaDE07E9l/pX2yoOsjxaxntIO/YvFAwrD8uaxn02PksKno+8Gfya1oyMaK+/lkcx6MVHHQNjIrnfBFZTZNldqw5uGwkbKLICKVAnERbC0gSyFYq+sEtJQUvART7EuIeiFXbTU25sHGZLIaxhgmnwO2ZRbGwEVRi1fMVQFEDyo9mKvyz0kiIGMLHpuZbIaQioa1VuejQS+urBaWeT3yae4vE7NE1yLGPeJ2Qo3TwPMdWq1aMkY5cGDfo/GD5seT9QKPMzDF54p0ma+vxtKpZu92QBI24/qpB0qqOYUsDKaw5xwOK4A/hDvT95GEF2YHtjvDeneU0IVVqetWP5obO7+fhj/lXa8KVg4NpT5X1eUvVaPzYoTMCVlG5JDGt13cFG1+hlixjL1X3SKt7xWijPIM4T9RQxqTRdFItNBPeVi/pr5W8M0Crcf9EmGmhGaCq/M1OerfZBzwtgE/r2oolc1qoWwVsdQ8WtvHYoaFCNGtF2qUYCzf7wT4ctQ62Z02V2hbL0m43qVuSflBnPeX1wbwwA2m4vTluuEZNLOeFO7Ao9ZssQZ9PAhVvuY3nYwXhBJ4SBsskbISh5e+gD+piT7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(508600001)(6486002)(83380400001)(6666004)(86362001)(6512007)(5660300002)(26005)(44832011)(186003)(2906002)(2616005)(36756003)(4001150100001)(107886003)(4326008)(8676002)(66476007)(66556008)(52116002)(921005)(66946007)(8936002)(38350700002)(7416002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?41joNoDgTFxLT40lUBiyx7gpIe90Pm+G20zlLpg203lon0gc0DtTUj+/T2O2?=
 =?us-ascii?Q?933VOL5anKU0Jq57Y3UcsMqGBw1Vf/v+bHefYsyE2+XND/+ColfQ1pmV9Bx9?=
 =?us-ascii?Q?Sfs6e+HNCV5tRxtaLrV5rmdB5f9OH1MEaaRArp5I/QZ6WvLG1Y+TeH9IudXY?=
 =?us-ascii?Q?lorFqret+PoXiqx19x6WyXLrwCPla4E5gmcMoRGfuJ5Ot5WP4ctA9/P2eGVd?=
 =?us-ascii?Q?MbyLHSreyZL3totYvKZNDnHLKQoQf2rylc27/tmPOotzRFFxwLETs3DfKLxX?=
 =?us-ascii?Q?mU8crjqlH2ZEtv0uZPHND3Rl/QGTjDSM2Nyoxgor7UWEYDH3YDbA/T7t3E9y?=
 =?us-ascii?Q?ydF6q+id21gv0NZt+0CnkjyTV1b6kZkCnkoFEM/Ff3p60ZMfgsyLEbKik0ho?=
 =?us-ascii?Q?2zKYSyFjJ/AmcAUCI8Zgv5rfJ8mjhaBOIApAqxhxvrPP/vKN3JOSwppc8USi?=
 =?us-ascii?Q?OISb7D3AqS1YBFJYtILPynwdFzg/yHtamRgv5GT+hFLPIlkXcQLNAvj3SKnW?=
 =?us-ascii?Q?8Jy9HPqOgB2lEBHrS+SHcLYSZOx+3Xi3K7UMrcAZzQtspV050d0toUOjJvVv?=
 =?us-ascii?Q?mUWh8Es7Io70yX2aTSlXJ8Ii1siCyy7lU9AqnFUrNiZBVyPyPpg8q/mzwa2g?=
 =?us-ascii?Q?W4fq6d6d1ShrJNAtKkwa9hTXHILxGOBbV8JVcsM1AOLShcHQLRETqZjv/9Vy?=
 =?us-ascii?Q?s76QR1x2HfipUE+UmBG2Ga7EqI09K4aVkf7hOYEuV1NUpYCwjD2QGX50vHbb?=
 =?us-ascii?Q?LQfgZwEpxDBG4pzkFnrE8S4VwZ5VRc6BEXP89GS6LjDUSAoNq/Dxkr+t9Qo7?=
 =?us-ascii?Q?sIt0qg3KI9VLs52PT5s4EYJ/bI5KxAKb9PrtQp1EgeMh+i7oV3SinVhgTQWL?=
 =?us-ascii?Q?i0ED3Iq1kWXbTjWdv4CqM1ZTdw2SnZd73SURRUcvHfNY4hYR8P/3n2q/K45D?=
 =?us-ascii?Q?hq5ABKGjTJmaU2Q3ghYDXtyGh9qPFNRdVb63QpJHBpvSCa68fu3bxiFVylt4?=
 =?us-ascii?Q?u7dDL4wKxjsw77dfRWH5DErP5d0hRBZikG7AtpSSh9iPtvoj/+IuWMVg2y7R?=
 =?us-ascii?Q?pwCMHn3+Dfumj73jyVqcr/hXh86BFZYQsuuqWUzQmq7+CW4XpQVeAujbCA1L?=
 =?us-ascii?Q?/90RGc3a32TgBcTcaVL9oKaR8bxW8oTztT9qUqAklA0wrSEkGKFtb7LSKrVf?=
 =?us-ascii?Q?vPgskXE27IMBNGozj+zrjRRsN9B0nvJpoFtaludn0JBHkLckkJSmY3i8ftZH?=
 =?us-ascii?Q?u/kUy+/3OPRNr7u5KsMAei9smPl8iDPsMDI28HKQw2k3TODqcjU+a707uz46?=
 =?us-ascii?Q?II2V1VYH8/jtIK2uo9Iszjm0sCaKiyreJEllS7NC1kwOBQLn6tK5J4lkQlB0?=
 =?us-ascii?Q?ZI6hEGkNeeSebyRzQyCPTbJQtRQX3OaumnMw2fo92a0dNa/qkJw9eMqLErdn?=
 =?us-ascii?Q?AYr9WPhfl3nBZ4SqqvxEu0RGAmWJ58znL2EOiR7uicpdjBnRBAbzjmwTZlfB?=
 =?us-ascii?Q?lZFVdd5Cl9cxMsOs9gVIqYDDeobmPTdq//6D2PpfOSYRTvjp8Uk8A+cGRpVY?=
 =?us-ascii?Q?krvD2ZKA/m1/CKO9LVePki+QESyTpyWbewSSD/9tNcZKPt7tIOCbDTGV2hlt?=
 =?us-ascii?Q?eWcs4zNKs+4mOphE2sppIRc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6705c8e2-d503-48af-eada-08d9efb6b603
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:37:06.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr0HlsYV/BScHYYjtEH8NiJ9b/5vCoMb1qjzQuNZV2DlR3cHXNMAJs70iyWWAEVcslWHHoxJ1HQphBx1Z9nFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3437
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140076
X-Proofpoint-GUID: Jhr5DRR5SonOkFsBXJSxseAXO9LhoXO3
X-Proofpoint-ORIG-GUID: Jhr5DRR5SonOkFsBXJSxseAXO9LhoXO3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:24 -05, Eric Snowberg wrote:
> With the introduction of uefi_check_trust_mok_keys, it signifies the end-
> user wants to trust the machine keyring as trusted keys.  If they have
> chosen to trust the machine keyring, load the qualifying keys into it
> during boot, then link it to the secondary keyring .  If the user has not
> chosen to trust the machine keyring, it will be empty and not linked to
> the secondary keyring.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v4: Initial version
> v5: Rename to machine keyring
> v6: Unmodified from v5
> v7: Made trust_mok static
> v8: Unmodified from v7
> ---
>  security/integrity/digsig.c                      |  2 +-
>  security/integrity/integrity.h                   |  5 +++++
>  .../integrity/platform_certs/keyring_handler.c   |  2 +-
>  .../integrity/platform_certs/machine_keyring.c   | 16 ++++++++++++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 109b58840d45..1de09c7b5f93 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -116,7 +116,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
>  	} else {
>  		if (id == INTEGRITY_KEYRING_PLATFORM)
>  			set_platform_trusted_keys(keyring[id]);
> -		if (id == INTEGRITY_KEYRING_MACHINE)
> +		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
>  			set_machine_trusted_keys(keyring[id]);
>  		if (id == INTEGRITY_KEYRING_IMA)
>  			load_module_cert(keyring[id]);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 730771eececd..2e214c761158 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -287,9 +287,14 @@ static inline void __init add_to_platform_keyring(const char *source,
>  
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
>  void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
> +bool __init trust_moklist(void);
>  #else
>  static inline void __init add_to_machine_keyring(const char *source,
>  						  const void *data, size_t len)
>  {
>  }
> +static inline bool __init trust_moklist(void)
> +{
> +	return false;
> +}
>  #endif
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index 4872850d081f..1db4d3b4356d 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -83,7 +83,7 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>  __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
>  {
>  	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
> -		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
> +		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
>  			return add_to_machine_keyring;
>  		else
>  			return add_to_platform_keyring;
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
> index 09fd8f20c756..7aaed7950b6e 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -8,6 +8,8 @@
>  #include <linux/efi.h>
>  #include "../integrity.h"
>  
> +static bool trust_mok;
> +
>  static __init int machine_keyring_init(void)
>  {
>  	int rc;
> @@ -59,3 +61,17 @@ static __init bool uefi_check_trust_mok_keys(void)
>  
>  	return false;
>  }
> +
> +bool __init trust_moklist(void)
> +{
> +	static bool initialized;
> +
> +	if (!initialized) {
> +		initialized = true;
> +
> +		if (uefi_check_trust_mok_keys())
> +			trust_mok = true;
> +	}
> +
> +	return trust_mok;
> +}
> -- 
> 2.18.4
