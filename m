Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126054B503A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiBNMbJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:31:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiBNMbI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:31:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F84A3C1;
        Mon, 14 Feb 2022 04:31:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EAOfLV021646;
        Mon, 14 Feb 2022 12:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=wG3Sk8QSAzzJrueFASVqy8zpaBkSwJztWmhE4jF3CjI=;
 b=LJFREnWQkjliGS8cW0fGR4j+woNqBcfYNfRHX7ggYJLKqUa8+wcYIq+Eqa/0ahQzktej
 I97N8KLe4gWblw7ETVFyb9d6zIqD+1v24U7Ocr9e83AwVhPFoHtG/zfxusWzeTK6knU/
 UkMoxite46JqOnQYgNFxNTWyv2GjPvoHNEUHIDpEW0fExgMZ5seRU8NzPAEtG5RowpbM
 Pb8Iaj1xSeZg5kYp13H1yf5/Ub4o/q94I8A3nAAS9ZfWbdQtfwQ6IyirSecidCAYcH/D
 IQ3Kq+by41441zeSosMtXe6J8Coh8xnXzaSkWCoFoYZGuWkALXP0RJ62LyQl8H3cOOvn mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p24dqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:29:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECG305165129;
        Mon, 14 Feb 2022 12:29:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3e6qkwkht8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:29:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqkjH4He1bwEKiQBJ4ucGoa6y5Le2Qcteft8L7aa2eQ4hoSUare0L7waBlFZvnG5L1lamV7I/TGd9Ywdfz5G4vh73v7I3oTglw66CMPHRzr1jjtKeOhHetEbOD5zbnrlsQbV7upeblbTqpYXODFyLZN7hS5IzdfAlLhz1rFkgE8BE53cLf6P8f3zs9DQDUvHNtYqLmCbefuPHtNsjMAGnPmd7+ZNXOcRaYNeNz1iANmkwxMrUeuTNE4Lkg0pXpUokhcmayBErJbLHB2NXovrj2eRWlX7UVuc1gSXtyVMw1kEaYNaO0EdnV6E22SehmEgEPVTy9VMbmKeqgM5thcH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG3Sk8QSAzzJrueFASVqy8zpaBkSwJztWmhE4jF3CjI=;
 b=WHaDdwZGdFS+JxQCa8eBGsAk6ZNmUxqjURDkbm46hO2vBhyLD4DU+/pgPwqg6YlamG1f9f89XfK33TGuDoT+HMFrZ7XHLKte+phUj2cmCsaypisyDpPTLwWOsy5TYDnnd++2e6l/CPBzdZtcEnp768P6fLkxXArX+NcgAv8Uoh+ekJKvm3uyA0zFSQxuy30y/ZkFVCxqunt+1JS0S9OATjLZ8YrtlHGbkdpkGgY/Rf3ii9MQdk/ekkH5juo8XiXH01ykG6KdxiHpDpAUcNSgX1QsKE/xajC2KMMuPJ0dt1t3Qwryuax5XxnlvSwIC/tDbVukuMbWrFDyH8Oyur6LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG3Sk8QSAzzJrueFASVqy8zpaBkSwJztWmhE4jF3CjI=;
 b=okuXzm11BZhGkVlgnxx/60nXZ0MJANMwq/n/oNuSrNQdZx8b8Jm4tXHjZ2c9mL3hI1WGdsa4+VW3Oq+FeOgY6ePWmHM+9w/JDVMXvkLatbo6pz7i3sfge1kZIKGhSgG4GfR52jA1EamzPLRVQxeslqaJZqrGyVS+7AfUiv8bObI=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by BN6PR10MB1859.namprd10.prod.outlook.com (2603:10b6:404:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 12:29:09 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:29:09 +0000
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
Subject: Re: [PATCH v8 15/17] efi/mokvar: move up init order
In-Reply-To: <20211124044124.998170-16-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-16-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:29:04 +0000
Message-ID: <m2czjptywf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB6PR0601CA0041.eurprd06.prod.outlook.com
 (2603:10a6:4:17::27) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c80d9777-2efe-4e7d-8e5d-08d9efb5993c
X-MS-TrafficTypeDiagnostic: BN6PR10MB1859:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB18598D90B3BF5C8BC0FFA8CEF4339@BN6PR10MB1859.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AXNfcCCN8zSckY7d2km7+oCysNuqZBoTByuh7R82gHHBUkfB/4koevtrF3x5SiLz6TcMrnt6kQmYHtJUl8RXRo7/PjVSO0mvSeCqdQ7CFAX0QOs0FzqNxXfFwdcezA3aKcGW9Nm0XDZwqtt0m2cZ+eKJqQsy20uiZqEPsC1s0mYTg2LpQMy1wF2eeBrJwO+n095gWdUTIBC+O6KMpL4+rnBuP1Bqe02I9xwW9spfETbFZy6evxx3zwnkYSiIcW1AGbHRPp9cVJNDj+DBEG9HQlaqz0w3yvJ/2BMrD4Pm+FUalJSg8k+H62IjI8qJLAWHHjmR2Pvd9xEc08b3T26OTA4W38FwYmAA1+gB/pHG+gDbjHC6eJjZAfTTf0R8a3gk4qgrjqvBzVA6p1jCku8aOOUyJAaAwC2UEwjA2gtJ2NP0PaTcLizG5hbFFFK0tt6q8TT4oDj42ZMo8tacCwhM0IcgwS3hKW80sCnc3wbxuwKpHTS/O/fsitj0PurmEDbmtOa2i0LC7L5iVbeoXdB8k/Rc5I21rvzNd2RAVZ4hiijHN8tBQjaXSrZ+ck8yjnl9WoouksXivYtoXKlRTMt2bx0WwTrxw2sFW8qGo7yl/tWXrr5dwDJnJ5uBg9hoPrkU4NKp8aOl00Mgizzvhp8xvp9s3aZq71bRXoyjRb16SaVWahzmbinf+2B24pv03A0VvmwGhLw9wXNK45L3PuJqxgcxtM5HiWY8AlGwPo0Ihk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66946007)(2616005)(107886003)(66556008)(26005)(8676002)(66476007)(52116002)(6512007)(508600001)(6486002)(86362001)(6666004)(316002)(921005)(186003)(83380400001)(38350700002)(38100700002)(4326008)(8936002)(5660300002)(36756003)(4744005)(2906002)(7416002)(4001150100001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2wvDg4EpgbiVeUlVLN/keUvT/lMuXGyU1U3oKfydzjQcBlOv4gSR+4Nda53?=
 =?us-ascii?Q?I1RtwOWULT9ukddy253L2R8KdJplNrCo5188ym5ezHWRFkp80oTriav1IUQz?=
 =?us-ascii?Q?53Bqnb2VM8OJd9UTpmPkwvX3MqAIKnqOqgtbtpvnpEpeWookcBulkRiE1Jn+?=
 =?us-ascii?Q?klHWsJiWufQtinODBw/spI/ve7xe9mVjrhccAPKlqfBZsm5nhyumIbLMmH1j?=
 =?us-ascii?Q?/pX9HTlWT1sLDST0xf0UXDAa6R44ArPsT1SD63+5RZGERXNNXCL02wQRwGyJ?=
 =?us-ascii?Q?EMCRjHqHRTsfNIdOwQKFRgKzC4rFLwHOBooCyCPMxm0Jnhq0wpKgiakX1P76?=
 =?us-ascii?Q?J2z6yLi+CoQoHrgPAHxUMJWYpBBlIWlheLvloMSHtlAoh8JWaKoyx20LYoyO?=
 =?us-ascii?Q?a+1WfF26ftYb75dVqiVnAbxFfy9itHb3VRhrcvgfj7werHO77AxJ0QRPxAFx?=
 =?us-ascii?Q?T2nEZEQ3cRNC5rA7azIF6VaohckD2yTCsRBmO9LgxBL+1W1yL28ykTsKkWMH?=
 =?us-ascii?Q?D2jYy9eXFqmnQ3l0uyWN24j21jLKNNuhXN5WBH5TboCkRwh9A3yn5XEH+m7R?=
 =?us-ascii?Q?OlDX1q7jNdpePOygryxFwePewCPFCALCfxNH6lzR64c0bkh7niEXBmqh/fNe?=
 =?us-ascii?Q?X1FeCJIM/rD6RxV9AeNWnQ5g1lp4ZjpKLawNhS4cYjQ7x+yFxjAKW2ZXQHMX?=
 =?us-ascii?Q?YkNXgAoKosLBsrNThU+dytLNHibGlDsGuzzsi8lz9tuIvQCU+/nODEIxRO+l?=
 =?us-ascii?Q?afBHrWwP00wFerwxXm0OKOzXGuwOBmo0YraSrZI6/VmQP9o6GIL6pic0Uy/c?=
 =?us-ascii?Q?lqP5UyCyrNhtXH24tTA4jyYB4PxPa3be9bii1IrKnEu/3RikmWkdzFvkfchP?=
 =?us-ascii?Q?toBxEAB6EAbb24P8TaR0mz5i38KQ7erqkv2POqNYzxXNFk6ZRppSIBMK0Oxq?=
 =?us-ascii?Q?GmC4Rzvv4Pay/r/AjABmdiM8SmergJoVjluTRldp3x74qNSsXzzSxUcqTf1w?=
 =?us-ascii?Q?085amRJn97y9NYjBiWyyS7UCORtBRvojjPOhpH9g2/NjxUw9puvn9/zUskw+?=
 =?us-ascii?Q?Jrte9AXOrNB4+n5Z3J+npQ+ZTddcpoEPveVmKcbljbhbdR57HYsFD5EH1ajc?=
 =?us-ascii?Q?uRlwx0cg3kVzVq6QvCaqWxqhIVqoEoOvVcduLlij57BzUhUVqiSNFg/98AG1?=
 =?us-ascii?Q?Ac/pyTWF+/ibnugeeR/avHaVtu7Bn2CnwOh3OAJpPIXFdxde+45AyzOcy6m6?=
 =?us-ascii?Q?CGr5NC1+NtOcsRc0Dh3DGLflsJj8100JrPuUB4h2B6zvvxX8+p6xEAHnf8da?=
 =?us-ascii?Q?cPlziUivG10GNSiMyuUG6lA41RnAeLSMQVMuC+HNBIbf95TBZa0n+HkjBEpI?=
 =?us-ascii?Q?x0yDIiOL6qL+WIp1NZ9aF1bUeYPdNtyR3OSaEmX45GHpDdLZmawuslnFwa00?=
 =?us-ascii?Q?uvFd0psFgcJScWgrUnwkK5WAmIzO80xnI9q4QE20sVwBerv7DY5BoDZ67u1c?=
 =?us-ascii?Q?8SLBatSJgmfnBWlp9PUtnTxlhBweYYPdscTTucNeK/cAUJHKJXZpV1GtLX9W?=
 =?us-ascii?Q?r2rMsypo61vphMp33+jDmEL4HLMnQp5G1O9zfbx86Jj5gYAo9kLuxp0wO8d1?=
 =?us-ascii?Q?EUXDin6vG3x8GdqE/QotNOY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80d9777-2efe-4e7d-8e5d-08d9efb5993c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:29:09.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gK8mgmvXnqRO0ZcBibrrT7dv3r1qY5ZgkksKWYGl7TaPZQkRtyIikMXP2Yon00ttJG5/FnEsfUyA/QRAbLq1lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1859
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140075
X-Proofpoint-ORIG-GUID: zWa8fN9TZ3_RpzLBwmSrjGT96OQBpNUw
X-Proofpoint-GUID: zWa8fN9TZ3_RpzLBwmSrjGT96OQBpNUw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:22 -05, Eric Snowberg wrote:
> Move up the init order so it can be used by the new machine keyring.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v7: Initial version
> v8: Unmodified from v7
> ---
>  drivers/firmware/efi/mokvar-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
> index 38722d2009e2..5ed0602c2f75 100644
> --- a/drivers/firmware/efi/mokvar-table.c
> +++ b/drivers/firmware/efi/mokvar-table.c
> @@ -359,4 +359,4 @@ static int __init efi_mokvar_sysfs_init(void)
>  	}
>  	return err;
>  }
> -device_initcall(efi_mokvar_sysfs_init);
> +fs_initcall(efi_mokvar_sysfs_init);
> -- 
> 2.18.4
