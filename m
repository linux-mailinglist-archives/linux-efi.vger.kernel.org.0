Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE76FF707
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 18:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbjEKQWP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 May 2023 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbjEKQWL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 May 2023 12:22:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCDE70;
        Thu, 11 May 2023 09:22:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDx0iM014453;
        Thu, 11 May 2023 16:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FYZBHJ5WM/GJAvvz9a/w7U0yFL16RRRR04UtpOA0TBk=;
 b=vOgKRXc4Caue7BN52te4VbauS6klluSZLyxyXQg0pf5DjIT/ukLrH7/2Ek1BDx1QHU40
 I6ma63MZXB+MY27x2BycKtElLZ+jaDlcJdG88rzBEDK+dEy/g+ReQ/yKzFgNPmVO7BKx
 Ti6Gt2oojGgf+DJi54oIdUACy33XmtT68CQYwnOwPIbArO1WRZIro87qAgHZcf7pdeI1
 iZ5GcScqo6UeySj4gFb7Pb5HYq68x+eQcOxH7xonJGtgg74M823xBVv5TQIimUFsG8h8
 7tCepm4SWeMy5eTTOa8XkOE7IYLJEP/x4fcNfrxMBUMRuleIhAyvDTNVaV7dJA1a/OJx 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77c7pg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 16:21:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BF1Be6024117;
        Thu, 11 May 2023 16:21:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y6xmv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 16:21:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNDRD2d4onF4nmezMuBhqIiLx25x0BcGwsziWKk4s68wrLKxzR1SOzZO/k+M2AnRhkNM/KuTyhrANNK3ab03z0zCzns3uAwU7wFGL17OF6MEHCwnjP4B6qkwhduVW+DHrJxigtqIMs/UeSblnwef5MusDxLcM7J/XgEga6Hji7fQHdrpWsWlBg3Wpkg5UyMt1yCPdkrb7Ivg1VPme29vKJVCf+UmZT7Qifq4w6OQtxuSjQ19s3LoQAMqPaIdyJq8ezcuJYX6u0DUh0zktQcFjz6JiROmUvIy9ORUq5kCByRiCsQ8qjZxTCEr78aarWpY6U8LrayNoBCYKRWO5n/0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYZBHJ5WM/GJAvvz9a/w7U0yFL16RRRR04UtpOA0TBk=;
 b=hLdasxVtzo1c5RGssLvc6Bmday/ogGOQZzQIFAjloVCoEWEcmiB3qVYOZwmVIWsexhU9CYY9p99FlUMD+DgxXtFgxmdfxMAxYiDsJvTzqIWl+v03zb7qbSwMPwT8fAyHN8vRzqVA2nAu2fOJJ3SYEOjfJ0OpII+26nw2aT0l78QPRbsAmWas/1xvVLahyUTbFrwjvKcdieG5x/B/XvuHkTvygsF+6a2rNcU++uVMgZ9R7ZfnZSF0Cpcmgdh1ucv0HyAumJZPOVuNcb+UQCsszb4YQ6KoLXiiuYb2shZojqU61dfpJSUNOQ+A84Efc/rNqQxxyhSbAFETMlYkJkYjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYZBHJ5WM/GJAvvz9a/w7U0yFL16RRRR04UtpOA0TBk=;
 b=ZNryug5MV5UXxouZm0gyb4qILZXSmUagAVuNoXiCyXz3aSnGVLSNrr4KSG8waOBXUS6mLeOUZtjD1Vz4h8Acp0pZEl8rQNnFm69Gd3OVzqtmjYoX6PqmoKxXydDFUJlYqY5Pf5H1iDbsnkQTKQE/zElegT7ztuKrX9/Wj8ozpzU=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by MN0PR10MB5960.namprd10.prod.outlook.com (2603:10b6:208:3cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.36; Thu, 11 May
 2023 16:21:28 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 16:21:28 +0000
Message-ID: <9fcc3c02-f33a-9d8f-35ea-be8d98fbbd6e@oracle.com>
Date:   Thu, 11 May 2023 12:21:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-10-ross.philipson@oracle.com>
 <CSIYV9UAFYWZ.3KMD32LKER5NS@suppilovahvero>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <CSIYV9UAFYWZ.3KMD32LKER5NS@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0466.namprd03.prod.outlook.com
 (2603:10b6:408:139::21) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|MN0PR10MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0df477-4e23-4272-a98a-08db523bc5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6rsg8qQhAAABgvzfsVASJ8OH+jnRQTRUsLR/nwY/rRiE6FtLXdvo5vCd3rLui1o1tlNER083A6yeUEgryi5rgwrq2KFHXK+kC2dlnRXzqvZ0NkKSXgxVA2c6mkEH03wOMPdZwMOAVnXQcXC0VXAzqLBPh0deBZXID7pHwzVpxaQ/l926pZ8Ljgr4kWPTPtZQxlb7iYuVSrtpd9R0AwJHxLyldUsG4XU9xoKIJta+FtB02+CdcJtPDt/YEOOT3X9TeMEqSVad3Mh/vrAXhrz3LvbisozjWo5rvKgZFTfR1hWca42rgw34MlWYmSjRQlF52TqsKvv6IvEZTsjVwzXoCMZcrL1o55Ae/YFVVsu/0FXvNrYBfv7HWUMRuPI+72C8YHccmgqetaMLzydj57fybXENvLQZhKOrHxI69oKaLuc0WK8feapLZyHEXPjI4YwD79NyxrOWmlvyj8FnCm5LzH+CbRqkXoLCJn4TeqRg6mx/v7+6Tl9rO4OUSe7AFYPCut4ViMl/QqnTNI7bvmZ0BN8Ybgi6LCkBhNiaemfZNsdGFTrP1F0q2PAK5AWBAOz/BS5N/eU6nzfHhftoUQFxYKuXLK/aFyYS6BRim+uMmnRWVeXvGzWu0ypa4uQxiWqUqxKr33IKmxuV7aTKFF58Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(8936002)(44832011)(7416002)(5660300002)(31696002)(36756003)(86362001)(2906002)(66556008)(4326008)(66476007)(66946007)(316002)(41300700001)(38100700002)(2616005)(53546011)(83380400001)(6506007)(186003)(6512007)(31686004)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUY3ZlUzeDc2elp6MVJTUGJXME9QSzJDU2hwVktBQldweHRtNzJVa2lubm0w?=
 =?utf-8?B?UGRVRUNoSFpXeDNMVXh1RUdSMXk0Zm8vQWZYaVJzR3RNZ2hUeVRBNWViNGN2?=
 =?utf-8?B?QXR6bGxqSVF2cXlSTkFkd0l3YkMyMXFsRzF3VDFOTzhJQ09XVTlncXFxK0No?=
 =?utf-8?B?WlEzREZFRFhTSVFsUXZGMkV1OGczNUhzSUJvMXdaMmh0MUVrQjFOK2pZTXla?=
 =?utf-8?B?bXZZam0yVXdrQ1NaSkVSRDRrbjVsUkdzZDVDSCt6TWl0Z0pFNkwxMEdsTlhQ?=
 =?utf-8?B?VVVyeVJUTUVMcG5DdnpqTnpldXlhcW9hSTBnNjd3UHRhK1E2c21Waks2WCtX?=
 =?utf-8?B?UXRHeU8wUXkvZ0d1NThPTks4OEJyamZDcHNWNWFSY0VMbi9FMmhiM1dNSFY3?=
 =?utf-8?B?WW11eVp3ZFVHVElXTUk1L3NWVEluUGR4QVFReC9tQTVsNzUxeFBmKzRobmR4?=
 =?utf-8?B?Vkw2QkFpY3pORFlTdmNRaXJqcGRTNUp3cVpzWitWRUJHZnNpN0FyUjYvUDQr?=
 =?utf-8?B?Uk9uSG9seG8zdHRrSEd3SDZRb3M1OUZpdUhNWUFKUllYNG9TUVZ3KytSMVcr?=
 =?utf-8?B?MjBWRE9CUlBFMnNyUnA1T1NNcWFxZC9iWlVsdVVnUzZ1b2JsU08wWTJaWEdr?=
 =?utf-8?B?bVJ0dXUwTXZnSTVVNXg3Q0NBbXowbyt5eU9oMkFlc20ycGExMU14RUFUREJM?=
 =?utf-8?B?UnJJQXZTVzlBOHBJYTh3WmRuYytITXZtN2YyY0ljQXZPSnRhak9CcjI0NE5X?=
 =?utf-8?B?ZWpYNDhUamhBbmczZmNoV1dNVnJ5YzVwY2FvV1JRTXduSkdCYlZQRWsxd3hG?=
 =?utf-8?B?OE4zNGZzeWNhQnJsVFFWQjR6d3N4dkYrYk5jMUFnamN5ZWtCb3ptRXNnT1BE?=
 =?utf-8?B?OHRQaVFnR3ROVjdDdGRQUm9yTlhaNlo4cHZQMXU5aHR1SERNeW5UeTljVGJZ?=
 =?utf-8?B?bm04UXd6MVc2K2V1UkNmWitrd2lOclllTk9JS1RacGM2M1RPL05jcmx5My9u?=
 =?utf-8?B?RU90Z2tWaGw4QkRXMzBQMVJLU0xHNWFTRTVnaHVZVEZ3dkwwYmZkdno4Q3Vi?=
 =?utf-8?B?QnRtTW5iYVZyN0lXMTQ3aHhyOStOemhDQnNRUDNseGZMajFhTFQ5ODFVYWZF?=
 =?utf-8?B?aVd5ZG1DeHA1eWJuQitnNFp2RkZNSlBIVmZ1aUFoVjEycVYyYTEyUmtjRzJr?=
 =?utf-8?B?bUpza0M1SFJvSnNJYXF2YUdRRjJPV3dITmdtbXJDNkQzamVrZHI0LzN0UDB0?=
 =?utf-8?B?Q1FDVlJzZHBLbzdGa0VMTFNxOGpGUlhMSHBhUEp5SUowTnZHS3dwazFqM0dy?=
 =?utf-8?B?eDJ5NVNoRk10c0hjenRXYTJsVFU1OTc1aU5yYTgreEJWN0htMHlXT0NTV0gx?=
 =?utf-8?B?QzBTRmRBM1haRTdFL1ZJRUpxMmN4Z0JxRnVGS0hWOGg5UFY2VllkL0F0SFNn?=
 =?utf-8?B?MVdUUTlaNXpVRjVOcWpNM3U5VkJjZHZhWmc4Y2RONFB3NldtQ2tZOTEzbXdp?=
 =?utf-8?B?RjNEd1ZnMnV6dFlzaVlQTWdPbU90NFNSbDZqYWZkRlM4OHBNU0Y0eGErL2Rr?=
 =?utf-8?B?NVpkM0lsWER6bUh4eTJqcjJGeW5ta1B2Q0tqbWdMS09IV0xmeGIzaktZWG81?=
 =?utf-8?B?c3FxR0lDYXZlOElFZ3lxMlpMcS9BMFdQd1lmaE9HTS85ajFmVG9EWjJkTXVT?=
 =?utf-8?B?bkF0MEhMTDk5SVU5S3A5SVZKNkdPZlhTR1FuWGoydXNkNk9wbkt4QzZzVGJy?=
 =?utf-8?B?ZEtpWmJrWkNjK01iQ21kV3ZaNHhkKzhhUGxFc0trZjBlTU1iTTBBazZlOU4x?=
 =?utf-8?B?aWlIMXVNUWppbU1rS2xxbjFIaTZNSzdjcVFLTXo2RGE3ZXB5YWJ4dmw3V0JY?=
 =?utf-8?B?RG5CWmo0bXlXeU52OXRFOWdTc1BwS2RqcG9VcU9OOFBpYjdtYmVtQm50TGha?=
 =?utf-8?B?NGo3MisrVnRQdG1lKzU5U0MvT084b1FjTnUvczFBMGVXNzRZNjRXOC9LQlZC?=
 =?utf-8?B?em52dlJYWW9YdjlaQURBWVB3Zy9sbTRzYmdSSnhySG04Z2ZCSUJzMkpnL0Yr?=
 =?utf-8?B?NVF4L0JNSFpmSDRYUlRMcjBFeGZtWVdyaVB4eEE3QkVhV1dFcy9XWmRFSjR5?=
 =?utf-8?B?YXp4MHN2MzR3NC90QVJxbXhPTmV2a0tGMGRFdjVIVkc5UXFWMFBVRVdQOWtB?=
 =?utf-8?Q?MEq21Bv1hAd0KL0Vle5QnMU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NEsyTnFNaGZKekVLWkV3ZFhHYVpMOHBneEc4VnJDN29XVlZoK2o4VmlacW9o?=
 =?utf-8?B?SzNNSGU3U0hhVDlXNVlHUVp2ZW5CZHlEd1Faa2ZEN0VDYmRmUks2TUhVbXdC?=
 =?utf-8?B?NGtZR1ZPTUpCMFVHYlBmVUZUZXBxUDJ3K1I4ODJERVA1MHJDV3B3M1FvbFFH?=
 =?utf-8?B?UE5CemtUekY0M3pSMDZKYkttUy9tbERCNlVZMHIvc0JURU1SMjFoNzRhQjQ4?=
 =?utf-8?B?ZUc4MUc0SXdaSU15aEY2UGVwREhudndwK2hiRkhUWXEwTzhMNlNkZXpjYWVq?=
 =?utf-8?B?QWR5cEtjc1hReGgvOGw0cGU3d2NySS9QcjhTajVNNHNXZXF5OUpQTmNGVnZr?=
 =?utf-8?B?MlgxUy9WY2p3bU15ZEpkanlRNlZuYWtpTVpDcXlkSjJER2VtTFl4VkxNRFBF?=
 =?utf-8?B?NW94UmVjR2tLaEZ1NEpWSFk5V2tSa2RadlAyVEFESXNXdUpncmhPd0ZwT0xS?=
 =?utf-8?B?TzdNV0Zxdk11eXNqLzNnS1dNTUtWY3UxblF3eUx4RFA5a1QwbFVveDRpeWJq?=
 =?utf-8?B?cGU3MjIzK3ZiRFdNQTF5MmlCcy95d0lROTNLS0t5d2NTMXU2SjZCUkpLSXpz?=
 =?utf-8?B?dXRETURMeUY1U2VyUkJLNCtYeVNrZ3RtZEtEWDRFc0czMnV0TU0vUCtOb0Za?=
 =?utf-8?B?ajd0dGYrRFRkMlYyR2xBMEZ5eTRHRDQrRTdkTERCell1YWlZc1hOTUU2V2x4?=
 =?utf-8?B?OHY1S2U4eTJySmZYVkxWQ3VyaFFhTE1Td3VFL2hoK3BmRUN3d0VnKzhKN1Yz?=
 =?utf-8?B?T3FwWE9Na01HVjMvU1dKZGdXb3pZTHZhWUFZMGhWSFdmRFM4WWRaQSt2SFFx?=
 =?utf-8?B?T3c2VEZUbDVpbzV4VW9OVzdKOFB1WDdnZllJalZCQkUxVFQ3Y002MTBzUFo4?=
 =?utf-8?B?VkIzZVVvVzY3YTJBb3drSVJITlNqRUJIWTZIYUM5OXZOQlJBVkNLU2lMTUor?=
 =?utf-8?B?ZjN2dGp0Y3lUOVI4UEJCaG9oL2FJc3MrbG5WWW1KNnZST0NyUEhRMFp6VnNl?=
 =?utf-8?B?S0ZWaTkyNWprOW5ORHhnUWRUZFQyQmZKa1V2L0tlZWw5TnhsT3RuNHo1aG94?=
 =?utf-8?B?V1FGaFNwYmQzNmE0d0JnN3llYSs4cnd3TGdMT3gvWXFvNlhRY3AwTWVGQ0xZ?=
 =?utf-8?B?RFE2TXMyUGxYVWEzdklDaEVBaDJhcUpXYU1UOTFBUjlxQ3hBU3dKcU5GbVJm?=
 =?utf-8?B?OG1GWnllRVRaNWN6dHVLQXpnYlNEVEJuTHVHWWNvalZNbU1Zb2J2RW51Wmkw?=
 =?utf-8?B?bGFmYURURDNINmZMSVdoYUhGQ1VCRWFTdFRlT0xiU2wvZHloMlc1OXEzVlVw?=
 =?utf-8?B?TCs4akV6SlJqZFl3b1NqTVpuTE9HRXdncldubm1uUzlZQlo1REh6bFpsYjVi?=
 =?utf-8?B?WVJFbE1XQkNzYXpGU1RhSWJCbWhMazFUcXJwSk1BUVNRMGxsU2IzRnE5L0lp?=
 =?utf-8?B?VXlEcm4wcUZ6NE1qeXZjQ0lITWhZMktOMHliZDYwTHFncXg1RTFsbVdOMCtq?=
 =?utf-8?B?ZEZnb3VFNFZtRzVzTCtSRkRROFV6ZEhZOGU2eS83a2lKaEJtVDNLcWh4OHRh?=
 =?utf-8?B?VHlGLytjYU04K3UvUGhsdnpjNWw3eGFPUDBCbTV4dCtYVFBTbURZRHNHUmlw?=
 =?utf-8?B?Z1JML2dvRDZKUzkzNDBTK1kzQ0VJTW9BNXFlclVSdEI2VzBNNExWbzdtOW5n?=
 =?utf-8?B?dGtaa0tia21HUE1rd1pHa2ZjU3MxdHYwN2ZkdXhuVkNKS2g5cHg3RVYwSUh1?=
 =?utf-8?Q?cbau+zqVK2hV6mHcX0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0df477-4e23-4272-a98a-08db523bc5ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 16:21:27.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9XAunxWOOO37Hd3G13zPmTZOOakm7+llj5uU5w9JlA706TU6jg3Kzs5XXs+yqsd8a4YCvK2Z9+EPbVTrYq1i5SVA5Z5AtM6Ak1HE7+HMIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110142
X-Proofpoint-GUID: 4j_0nWKK4hmIK1XuRBkPhZLMQKMrzW-j
X-Proofpoint-ORIG-GUID: 4j_0nWKK4hmIK1XuRBkPhZLMQKMrzW-j
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/10/23 18:55, Jarkko Sakkinen wrote:
> On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
>> On Intel, the APs are left in a well documented state after TXT performs
>> the late launch. Specifically they cannot have #INIT asserted on them so
>> a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
>> early SL stub code parked the APs in a pause/jmp loop waiting for an NMI.
>> The modified SMP boot code is called for the Secure Launch case. The
>> jump address for the RM piggy entry point is fixed up in the jump where
>> the APs are waiting and an NMI IPI is sent to the AP. The AP vectors to
>> the Secure Launch entry point in the RM piggy which mimics what the real
>> mode code would do then jumps to the standard RM piggy protected mode
>> entry point.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/include/asm/realmode.h      |  3 ++
>>   arch/x86/kernel/smpboot.c            | 86 ++++++++++++++++++++++++++++++++++++
>>   arch/x86/realmode/rm/header.S        |  3 ++
>>   arch/x86/realmode/rm/trampoline_64.S | 37 ++++++++++++++++
>>   4 files changed, 129 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
>> index f6a1737..576fe62 100644
>> --- a/arch/x86/include/asm/realmode.h
>> +++ b/arch/x86/include/asm/realmode.h
>> @@ -38,6 +38,9 @@ struct real_mode_header {
>>   #ifdef CONFIG_X86_64
>>   	u32	machine_real_restart_seg;
>>   #endif
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +	u32	sl_trampoline_start32;
>> +#endif
> 
> Cool I was implementing this relocatable realmode blob back in 2012 :-)

It is fun stuff :)

> 
>>   };
>>   
>>   /* This must match data at realmode/rm/trampoline_{32,64}.S */
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 352f0ce..07d740be 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -57,6 +57,7 @@
>>   #include <linux/pgtable.h>
>>   #include <linux/overflow.h>
>>   #include <linux/stackprotector.h>
>> +#include <linux/slaunch.h>
>>   
>>   #include <asm/acpi.h>
>>   #include <asm/cacheinfo.h>
>> @@ -1068,6 +1069,83 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +
>> +static atomic_t first_ap_only = {1};
> 
> This should be documented.

Will do

> 
>> +
>> +/*
>> + * Called to fix the long jump address for the waiting APs to vector to
>> + * the correct startup location in the Secure Launch stub in the rmpiggy.
>> + */
>> +static int
>> +slaunch_fixup_jump_vector(void)
> 
> Please put the same line.

Ack

> 
>> +{
>> +	struct sl_ap_wake_info *ap_wake_info;
>> +	u32 *ap_jmp_ptr = NULL;
>> +
>> +	if (!atomic_dec_and_test(&first_ap_only))
>> +		return 0;
>> +
>> +	ap_wake_info = slaunch_get_ap_wake_info();
>> +
>> +	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
>> +				 ap_wake_info->ap_jmp_offset);
>> +
>> +	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
>> +
>> +	pr_debug("TXT AP long jump address updated\n");
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * TXT AP startup is quite different than normal. The APs cannot have #INIT
>> + * asserted on them or receive SIPIs. The early Secure Launch code has parked
>> + * the APs in a pause loop waiting to receive an NMI. This will wake the APs
>> + * and have them jump to the protected mode code in the rmpiggy where the rest
>> + * of the SMP boot of the AP will proceed normally.
>> + */
>> +static int
>> +slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
> 
> Ditto.
>

Ack

> 
>> +{
>> +	unsigned long send_status = 0, accept_status = 0;
> 
> I would put these to separate lines. Maybe a matter of taste but
> it is easier to spot initializations.

Sure

> 
>> +
>> +	/* Only done once */
>> +	if (slaunch_fixup_jump_vector())
>> +		return -1;
>> +
>> +	/* Send NMI IPI to idling AP and wake it up */
>> +	apic_icr_write(APIC_DM_NMI, apicid);
>> +
>> +	if (init_udelay == 0)
>> +		udelay(10);
>> +	else
>> +		udelay(300);
>> +
>> +	send_status = safe_apic_wait_icr_idle();
>> +
>> +	if (init_udelay == 0)
>> +		udelay(10);
>> +	else
>> +		udelay(300);
> 
> Magic numbers and no inline comment.

Much of this was copied as is from another function in this module. They 
did not have comments either. I will have to try to track down what 
motivated the delay logic.

> 
>> +
>> +	accept_status = (apic_read(APIC_ESR) & 0xEF);
>> +
>> +	if (send_status)
>> +		pr_err("Secure Launch IPI never delivered???\n");
>> +	if (accept_status)
>> +		pr_err("Secure Launch IPI delivery error (%lx)\n",
>> +			accept_status);
>> +
>> +	return (send_status | accept_status);
>> +}
>> +
>> +#else
>> +
>> +#define slaunch_wakeup_cpu_from_txt(cpu, apicid)	0
>> +
>> +#endif  /* !CONFIG_SECURE_LAUNCH */
>> +
>>   /*
>>    * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>>    * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
>> @@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>   	cpumask_clear_cpu(cpu, cpu_initialized_mask);
>>   	smp_mb();
>>   
>> +	/* With Intel TXT, the AP startup is totally different */
>> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
>> +	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
>> +		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
>> +		goto txt_wake;
>> +	}
>> +
>>   	/*
>>   	 * Wake up a CPU in difference cases:
>>   	 * - Use a method from the APIC driver if one defined, with wakeup
>> @@ -1147,6 +1232,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>   		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
>>   						     cpu0_nmi_registered);
>>   
>> +txt_wake:
>>   	if (!boot_error) {
>>   		/*
>>   		 * Wait 10s total for first sign of life from AP
>> diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
>> index 2eb62be..3b5cbcb 100644
>> --- a/arch/x86/realmode/rm/header.S
>> +++ b/arch/x86/realmode/rm/header.S
>> @@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
>>   #ifdef CONFIG_X86_64
>>   	.long	__KERNEL32_CS
>>   #endif
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +	.long	pa_sl_trampoline_start32
>> +#endif
>>   SYM_DATA_END(real_mode_header)
>>   
>>   	/* End signature, used to verify integrity */
>> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
>> index e38d61d..8bb4b0d 100644
>> --- a/arch/x86/realmode/rm/trampoline_64.S
>> +++ b/arch/x86/realmode/rm/trampoline_64.S
>> @@ -104,6 +104,43 @@ SYM_CODE_END(sev_es_trampoline_start)
>>   
>>   	.section ".text32","ax"
>>   	.code32
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +	.balign 4
>> +SYM_CODE_START(sl_trampoline_start32)
>> +	/*
>> +	 * The early secure launch stub AP wakeup code has taken care of all
>> +	 * the vagaries of launching out of TXT. This bit just mimics what the
>> +	 * 16b entry code does and jumps off to the real startup_32.
>> +	 */
>> +	cli
>> +	wbinvd
>> +
>> +	/*
>> +	 * The %ebx provided is not terribly useful since it is the physical
>> +	 * address of tb_trampoline_start and not the base of the image.
>> +	 * Use pa_real_mode_base, which is fixed up, to get a run time
>> +	 * base register to use for offsets to location that do not have
>> +	 * pa_ symbols.
>> +	 */
>> +	movl    $pa_real_mode_base, %ebx
>> +
>> +	/*
>> +	 * This may seem a little odd but this is what %esp would have had in
>> +	 * it on the jmp from real mode because all real mode fixups were done
>> +	 * via the code segment. The base is added at the 32b entry.
>> +	 */
>> +	movl	rm_stack_end, %esp
>> +
>> +	lgdt    tr_gdt(%ebx)
>> +	lidt    tr_idt(%ebx)
>> +
>> +	movw	$__KERNEL_DS, %dx	# Data segment descriptor
>> +
>> +	/* Jump to where the 16b code would have jumped */
>> +	ljmpl	$__KERNEL32_CS, $pa_startup_32
>> +SYM_CODE_END(sl_trampoline_start32)
>> +#endif
>> +
>>   	.balign 4
>>   SYM_CODE_START(startup_32)
>>   	movl	%edx, %ss
>> -- 
>> 1.8.3.1
> 
> 
> The trampoline_64.S changes look reasonable to me (with a quick look).
> 
> BR, Jarkko

Thanks for the review,
Ross
