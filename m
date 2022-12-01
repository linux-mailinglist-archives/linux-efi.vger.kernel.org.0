Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612FC63F342
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 15:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiLAO6e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 09:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiLAO6c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 09:58:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F03930F44
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 06:58:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1EY1vm012060;
        Thu, 1 Dec 2022 14:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8cvyJVOtKIZp5KK7/JummqZo6vmS9gCi6boTjhEktF0=;
 b=NYhQV52IVdW4C62RRG3zVOM/16D3GG9lam/wDRbKHj9EN2UD1MJ/J1uwctiEHkplI/0C
 uTnUwEhauerxl2QmqUAKiag8Cwf/QvQTBLHqm+GYkLlbOlTqRc5nj4DjpBZRLeiwW/N2
 9iXJ7Rr9HPo/mzxA5a/1kvj/kN2zfN0wx4atK3PtVuudrl5a1LtnR2csaMhpRknOon/F
 KzF58zsIHwsVT1uudLuzRlYrpDZ1QnL8RGgQDRk5lizV8+FQllhkqlU0+44/j6vhCNMQ
 GVjIr2DoBsi/GtbXmcpxJ/cUgI8gfRxwC8l1aOoZa8w97qJOR/VMCez6qUf7QlHciUKi lA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2wtm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 14:58:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B1D3Gak036708;
        Thu, 1 Dec 2022 14:58:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c20aefg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 14:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jltvEJOHNC3KrPgi3Uu2aTRRpSz0ystOaOCBZbnaJMkGzQOCMSpyQqBxJAJjZVDuoWN4x3nI51w2BRrqrpYXpRp43Y6H0XqlinaFw2V6r0QOF7jCoonSQIg87IhImj2bgzAPhOt/ynSpBJ4D1lWcGCO1iYFHZAPvz8kdDZSDxu4O2ik4Lsc0o+ZPghtTnf5wD2vB0H4uf8krz3IyU0kx6DZFniSL8XWr6YJcz1TX6jemJCLZZy14pzUlLtkDyrdJrUkSCGTORw2QIR2+P/QkOIZzNF5QWQ6UfzD6uoY9Jnl5Ewrr6zBtfT/JMUBjPLATE+H3fLI0rRnGcDpTXAKDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cvyJVOtKIZp5KK7/JummqZo6vmS9gCi6boTjhEktF0=;
 b=nmLv3j7iPheJ2Pga3dZe6rcTQfV65Q8qNyxwLJ8CfKOOldIBbZsbv9BV8mhS2IiyJptwabSsUTSfyg1vi277Fx5bOvQqUShQW3hK6t6s7mwnmWKVjI5RGv2XreKBSy3qcef74yAxF0XVWm86jtbv5mBnJZ4ndN/m09zyvpE5t7Ke6ygGkCbUlk/c8ONTd8ojBV5R/1HBAcnzbm2EpR03CO8PjOD9bXLp+/Anc7tUisibIBI/tY2rYiGwPEjLQx3tbiIQvrDBDwtvDRzoyCB3BXmSrKbf9U7Il/m1V/XgeiNY6BGtVYx8XRlZ8IYvGba+tONesy4nM74G/YgM6joLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cvyJVOtKIZp5KK7/JummqZo6vmS9gCi6boTjhEktF0=;
 b=UpNeYg0c/UBSiFZtzQza2hBEsPyQp1ZpVtMfR20Pr8PRmMTe2EAUYQrX6Wd7XQtvysMiuuZSFnBaCERP+KK85ilHopYDmp6ECEUsGxBUUe+FejvIokXVmSHFX7U7pJ3I34w28WXX/vk9GGyuuNLnzFdDLkssOS6GC9Re0jZALM8=
Received: from BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13)
 by DM4PR10MB6840.namprd10.prod.outlook.com (2603:10b6:8:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 14:58:15 +0000
Received: from BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::8781:9b5f:7205:b8b7]) by BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::8781:9b5f:7205:b8b7%9]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 14:58:15 +0000
Date:   Thu, 1 Dec 2022 15:58:09 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Subject: Re: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS
 header
Message-ID: <Y4jBATz+P0gxtoD0@tomti.i.net-space.pl>
References: <20221129175616.2089294-1-ardb@kernel.org>
 <20221129175616.2089294-3-ardb@kernel.org>
 <Y4i6YExOV80rxdhq@tomti.i.net-space.pl>
 <CAMj1kXEzzicO_V=ZKBgvWWFAoa1XNSO5KRZaCPYO1boT9s+Vig@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEzzicO_V=ZKBgvWWFAoa1XNSO5KRZaCPYO1boT9s+Vig@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::20) To BN0PR10MB4822.namprd10.prod.outlook.com
 (2603:10b6:408:124::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4822:EE_|DM4PR10MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a134e41-df3a-4ce7-bd81-08dad3ac796b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOzf9Ur05jcGkdoNC9hJtRii/Ra/2xuCb2t2uR3d1wQ+NZkGB2P0vGw2h3spxmXriSGKdvPqgUaMLBEV3wpTgYCrObKo5TJ53hUi/mMk3n1sB+G+5irk5xMuQr8etzizRfgCHujCtSPl1vCRvuX2qYnFZ15UxxjQM0soaF8rBCul/tRWdVVMUTiV30QsNRVuGdvVGW4Pz7iTSPbdmYzl25lyv92Mms1wcaq3SziXrHsiDONeQ+eU02iaaYtcaxEaEYWdSOxR33sNR0mKoX4lnxh2xqyEJ287q8W/fzMBo39noOkm6olKFx3xVNTr1d2AOBem8umGhhfGInR4ClBca6u0GxC8qHfZfNLyAZtS2DRMjTNBNU9KVyrxuMBx/gyWqc0/GkcTJT8gqya3G2VtyvJ9uwHC/OC02Vvl0QkXJlQaCaRgEQcQWsacCy8D4maWxmp0FlkCdNt8nbmjyjHeDgKVVUNavDrqPDBSboDv/I14zVUSm7vJLs4+j0NrvC72JZsx6J4l5NtxlGuwGbmmN0h/SVP9FAMIBSdj0MEZpZB3NoX6bDmyDG6LwSymbG1cJbxZ5CVflEI2/NI2WkOScsUwhJobN8C8zLUR700dkSBzL/oVpTAt93yHareEsg4CU1NeJGkS/+N2vWMcZdno18Ltyt4xHzcyzaGiJTkzHJETxRTbFHWjojv4pq+MlQuP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(186003)(6512007)(26005)(6916009)(9686003)(44832011)(5660300002)(38100700002)(54906003)(83380400001)(66899015)(478600001)(6486002)(66476007)(6506007)(8936002)(66556008)(41300700001)(2906002)(4326008)(6666004)(8676002)(316002)(86362001)(66946007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xTItnW7S8C8bwwjvKM/rFV3BKO9nnXY9dl9440JENAJ2uR2+oaZo5+wvdzo?=
 =?us-ascii?Q?DyM/NiWQUIFAnBUI36n79qtSEy//hUy26VZESThbY4lB3N5qtLtwRrXJCneZ?=
 =?us-ascii?Q?JxNkeaybDAZtl2SskEAcDVRZqzLGti0mtLN5OrNWlFZQ4/bu1WXM62Ji9QCL?=
 =?us-ascii?Q?TQYtPiGhAXu6txIUjKADHucH4pqUoBFNFmvhnbBFXYmkKXXWnt1jZotDa5/Z?=
 =?us-ascii?Q?dI1cZRSVz2rUlc74tcF+ll4PDVftgzj1iM20n/O4ytWxiELj+Ryo5945KF10?=
 =?us-ascii?Q?xvg0OAqfJTQmc5nmj7P24lMWvrhYjjPMRdoBfHqJVk59hAfpDtS3tNy8BBb+?=
 =?us-ascii?Q?3oNTer30JzLKTXXa0f60NccI/Ei7FEM1PfGiXhNZX6qcQrEUU2LJKmzkflFf?=
 =?us-ascii?Q?BZYiQl28NoVPVxYg0yqM8X3NiZggCq5KRKwM0bTQJ9OZxcgehgSjpz+BUnLJ?=
 =?us-ascii?Q?EzcIpmDNHoLI0pCytRVyW6rvoy6YL1T8/0mD3HiYc6H3BaAjgQQHDqNZelxl?=
 =?us-ascii?Q?pAEM3mOehvgQYpGLGCrZ3Ezz1AlHRoWE6c4JDouyQRkuL2aCpu3odit3uzfw?=
 =?us-ascii?Q?VomUoZtDUoqk0Gi0iQeMdFb1PU66LbsSMxW7o2VSAE/fzunQTPaZvHCze5iw?=
 =?us-ascii?Q?PAGjfCzHVUq4NRIzqMlp6qtd+Bu2x9a3wTNkoIJfJNfOQjJAseK82RjUJ3Ye?=
 =?us-ascii?Q?ZF4dU6/1CO9oFHq8P8m2401n9fIKHz+ZeUDzjiBhvUXbGljetFYShy1Zq1g5?=
 =?us-ascii?Q?mZn2uftxC0JP8NFmczkBuEc8QRgah3H9JupCmTpxK1FoaC1ORm/XakSfezVl?=
 =?us-ascii?Q?T1r/UuoOTdZh7v/xt0q4jBV6wf/JJjI4UVExGaj4ppFKSu2ZQZdA/puUHQH5?=
 =?us-ascii?Q?f41WGZ6Z6tnFXaUDruFOfAYpDDx6w5TmsBexB673W62ejSbcuTJy+xs2tTu/?=
 =?us-ascii?Q?AWO7Nr/ASM0mlLv9Jui/ABPeF0/xHsBzyySmOWeBkrHK5jJpl32/mNST+pPh?=
 =?us-ascii?Q?y6FwNUxt3F3IqTGjXo7S+88JPnUmDJWB8EC/Ejj7qFCyA7ORlbGmriU93qHd?=
 =?us-ascii?Q?2XRqsL9yNERFI8ZN181nbEOg8LE7VKu1R8AFVUav27a6B2aoJO96ZgXzlVVT?=
 =?us-ascii?Q?jsiLgymge5lweCjqEaYJyfQiZbFSCLrPFIaqC9etWXsROGDxiiw3noutQCEw?=
 =?us-ascii?Q?0xZ53PC5eZp6ptYc0Bdp1t+x98116WlhovGvilmOcE0jpuoUPYePponj++h0?=
 =?us-ascii?Q?xVxg/jKjJ4WvcKPataBR+BwPSXnTTpnBlUWwB2i+NOT8Os7I1U5PyqJMJW/G?=
 =?us-ascii?Q?VYOqcV/YZ6/jPXMcrZXamrdZt2YruA7EdlP4w15YbYTGJ0D3ivtQ/0U5CmSQ?=
 =?us-ascii?Q?9FMSyIQnNfz8kdF5A/mJE8pjhI5g94kHg9gzGdXEf9goBDWurL0KnWAVrJjO?=
 =?us-ascii?Q?zwpuV0+1Eo4jfHzVIAQ2KkbCnr0O4RvvAuJFTWOqR5JV4g6zFOeuiIKvwKbr?=
 =?us-ascii?Q?VFPb7geH0o4ZaPiYvYXAoPI1YS7kKjbknQWl+pFFJcCBEsmsECj+4yXkrcTV?=
 =?us-ascii?Q?1KBm4reoHEIphPxgkgPjLMMY4Mq0aIB6U+UHrvqC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NcNrATlUQBiGm3Ljv/o1ORP+H8/V3HXcFDc2lWGoRLi0RmmMmbAd9K6p9gNi?=
 =?us-ascii?Q?9UO90QoJfE6FpDjRlemlofdPwduqna6bOvkx2uglGSThO8JwV2PhO69OxnTW?=
 =?us-ascii?Q?ryKqd355EWg3jVoSK4zzcHe0LqPDNrIUD1JC+rhY250FaCeK/GKibzKNl4L3?=
 =?us-ascii?Q?7kdjw+MSprwoD0EaxZh/CFZihh/Fw0TZaaKgB/MWecQsbjtxgAyhyBMBf6P2?=
 =?us-ascii?Q?R57oA35XV8ersNaakNXPFMSeuBCTZ0v11JfikAbMA76P+YfGjUBG9ioYHjDQ?=
 =?us-ascii?Q?C3VKLor3dOLrsSwlJ7CKbECWl4oVt7uPO2UfvdUy6BqxfHyzQdZKH29stHSg?=
 =?us-ascii?Q?/CvUis/UieysQpKMFPi8/pCAHTG1ZNZ8PG92JD08vB4UKzmN9hgcstczGEhY?=
 =?us-ascii?Q?SANse75tCuKNhQ7xMs5GoTvgGqsu5Wm7uvuP84/1p8/qJAJn72D/ATwouZSq?=
 =?us-ascii?Q?1RF8MqzD2EnjGT9brY9BbAOlxoN/YcUUfsjnfDsCXJNFn/S7H+oQ3my+GwwM?=
 =?us-ascii?Q?mJs8YKqJlHo8kYo/tPk4bsxbAgJaaeXpLay7c5R5LpgBzjGyvhYCMGkii9Zx?=
 =?us-ascii?Q?uJJ6FR1AWFNaC1Jnl6d2CqRiyrZLWMIc+eCsoXGmgbRfazC9rMqzr5EpHy4q?=
 =?us-ascii?Q?+j4ZLE+ifOWXvyIxKICCLrWzYQcTNqVO9JjwVeid0gHg0vOnTU33bFkyakl/?=
 =?us-ascii?Q?CzWrcK8QLYrx6UGEfve4hky4iiBmoUo4+xrDc2ZAXwFw9ww3dDqhvAj48LuI?=
 =?us-ascii?Q?2nx1fgor7DF7z1M9vMQTnTcy/BOoxtaV3PwguWpVB5dVMydGj177jXk4ETCA?=
 =?us-ascii?Q?ppIQ4e/rLp78QJ1UlfZVfq2MIT+M7XQifTiUCVzigyJqhf2Evl5tY0yRV+wh?=
 =?us-ascii?Q?4SC7YBy25z5bVNcRN/Jl3atawqyQAFMstnXTwzeCqMai8ZjYkKclGagMmV5Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a134e41-df3a-4ce7-bd81-08dad3ac796b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 14:58:15.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fhm8W+xU4CfHmPvV1sxs9B8FxGfnoUf2m06mGFLyc+st8aNvSKloMIsrebVHlVigFUmA5SGwMH/Px0O0UtAdCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010108
X-Proofpoint-GUID: dspsFXVMN4cgwylUpPTFqf0bU0v7tonq
X-Proofpoint-ORIG-GUID: dspsFXVMN4cgwylUpPTFqf0bU0v7tonq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 01, 2022 at 03:48:12PM +0100, Ard Biesheuvel wrote:
> On Thu, 1 Dec 2022 at 15:30, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > On Tue, Nov 29, 2022 at 06:56:16PM +0100, Ard Biesheuvel wrote:
> > > GRUB currently relies on the magic number in the image header of ARM and
> > > arm64 EFI kernel images to decide whether or not the image in question
> > > is a bootable kernel.
> > >
> > > However, the purpose of the magic number is to identify the image as one
> > > that implements the bare metal boot protocol, and so GRUB, which only
> > > does EFI boot, can only boot images that could potentially be booted in
> > > a non-EFI manner as well.
> > >
> > > This is problematic for the new zboot decompressor image format, as it
> > > can only boot in EFI mode, and must therefore not use the bare metal
> > > boot magic number in its header.
> > >
> > > For this reason, the strict magic number was dropped from GRUB, to
> > > permit essentially any kind of EFI executable to be booted via the
> > > 'linux' command, blurring the line between the linux loader and the
> > > chainloader.
> > >
> > > So let's use the same field in the DOS header that RISC-V and arm64
> > > already use for their 'bare metal' magic numbers to store a 'generic
> > > Linux kernel' magic number, which can be used to identify bootable
> > > kernel images in PE format which don't necessarily implement a bare
> > > metal boot protocol in the same binary. Note that, in the context of
> > > EFI, the MSDOS header is only described in terms of the fields that it
> >
> > s/MSDOS/MS-DOS/ to be consistent with other places in the patch...
> >
> > > shares with the hybrid PE/COFF image format, (i.e., the magic number at
> > > offset #0 and the PE header offset at byte offset #0x3c). Since we aim
> >
> > s/the magic number at offset #0/MS-DOS EXE magic number at offset #0/?
> >
> > "the magic number at offset #0" itself is confusing in the context of
> > number of "magic number" phrases in the patch... :-)
> >
> > > for compatibility with EFI only, and not with MS-DOS or MS-Windows, we
> > > can use the remaining space in the MS-DOS header however we want.
> > >
> > > Let's set the generic magic number for x86 images as well: existing
> > > bootloaders already have their own methods to identify x86 Linux images
> > > that can be booted in a non-EFI manner, and having the magic number in
> > > place there will ease any future transitions in loader implementations
> > > to merge the x86 and non-x86 EFI boot paths.
> > >
> > > Note that 32-bit ARM already uses the same location in the header for a
> > > different purpose, but the ARM support is already widely implemented and
> > > the EFI zboot decompressor is not available on ARM anyway, so we just
> > > disregard it here.
> > >
> > > Cc: Huacai Chen <chenhuacai@kernel.org>
> > > Cc: Atish Patra <atishp@rivosinc.com>
> > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Cc: Daniel Kiper <daniel.kiper@oracle.com>
> > > Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/loongarch/kernel/head.S                | 3 ++-
> > >  arch/x86/boot/header.S                      | 3 ++-
> > >  drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
> > >  include/linux/pe.h                          | 7 +++++++
> > >  4 files changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > index 84970e2666588963..caa74439700eee93 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -25,7 +25,8 @@ _head:
> > >       .dword  kernel_entry            /* Kernel entry point */
> > >       .dword  _end - _text            /* Kernel image effective size */
> > >       .quad   0                       /* Kernel image load offset from start of RAM */
> > > -     .org    0x3c                    /* 0x20 ~ 0x3b reserved */
> > > +     .org    0x38                    /* 0x20 ~ 0x38 reserved */
> > > +     .long   LINUX_PE_MAGIC
> > >       .long   pe_header - _head       /* Offset to the PE header */
> > >
> > >  pe_header:
> > > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > > index f912d777013052ea..be8f78a7ee325475 100644
> > > --- a/arch/x86/boot/header.S
> > > +++ b/arch/x86/boot/header.S
> > > @@ -80,10 +80,11 @@ bs_die:
> > >       ljmp    $0xf000,$0xfff0
> > >
> > >  #ifdef CONFIG_EFI_STUB
> > > -     .org    0x3c
> > > +     .org    0x38
> > >       #
> > >       # Offset to the PE header.
> > >       #
> > > +     .long   LINUX_PE_MAGIC
> > >       .long   pe_header
> > >  #endif /* CONFIG_EFI_STUB */
> > >
> > > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> > > index bc2d7750d7f14174..ec4525d40e0cf6d6 100644
> > > --- a/drivers/firmware/efi/libstub/zboot-header.S
> > > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> > > @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
> > >       .long           __efistub__gzdata_size - 12             // payload size
> > >       .long           0, 0                                    // reserved
> > >       .asciz          COMP_TYPE                               // compression type
> > > -     .org            .Ldoshdr + 0x3c
> > > +     .org            .Ldoshdr + 0x38
> > > +     .long           LINUX_PE_MAGIC
> > >       .long           .Lpehdr - .Ldoshdr                      // PE header offset
> > >
> > >  .Lpehdr:
> > > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > > index 056a1762de904fc1..1db4c944efd78f51 100644
> > > --- a/include/linux/pe.h
> > > +++ b/include/linux/pe.h
> > > @@ -31,6 +31,13 @@
> > >  #define LINUX_EFISTUB_MAJOR_VERSION          0x1
> > >  #define LINUX_EFISTUB_MINOR_VERSION          0x1
> > >
> > > +/*
> > > + * LINUX_PE_MAGIC appears at offset 0x38 into the MSDOS header of EFI bootable
> >
> > s/MSDOS/MS-DOS/
> >
> > > + * Linux kernel images that target the architecture as specified by the PE/COFF
> > > + * header machine type field.
> > > + */
> > > +#define LINUX_PE_MAGIC       0x818223cd
> > > +
> > >  #define MZ_MAGIC     0x5a4d  /* "MZ" */
> > >
> > >  #define PE_MAGIC             0x00004550      /* "PE\0\0" */
> >
> > If you take into account these minor things mentioned above you can add
> > Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com> to your both patches.
>
> Thanks

You are welcome!

> > Atish, could you respin your GRUB "Unify ARM64 & RISC-V Linux Loader"
> > patch set when both Ard's patches are in at least "efi" Linux kernel
> > branch? Hmmm... I am not sure it will go through "efi" branch. Ard?
>
> Yes, I already pushed a version, but I will update the patch to take
> your feedback into account.

Great!

> The patch is queued up for v6.2, so it should be in mainline by the
> end of the year.

Cool! Thanks a lot!

Daniel
