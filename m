Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F74B5015
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbiBNM2z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:28:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBNM2y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:28:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4447D13E25;
        Mon, 14 Feb 2022 04:28:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EBS3Gn031171;
        Mon, 14 Feb 2022 12:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=SfgD/i0FCuGmytNWxvWCGcAlRc7EhaCu7C0i61b8BE0=;
 b=u3jPfCcz08kHE0y9DetGLgw2rCKnIUSMqmG0nZYlUQM090HO6rl8iUxdthRRq+qvPvb9
 i7OU9uQREJTuFZGnvk7XQ8ZW/rwAQ/GN1EdDRpbqMWu/rho2xQDdhVCjGsj3uwNKQxLM
 bTpV/ivCxEOVzxW40+Th2/pz800nFPugaY/3wrAnm5Fn/HLBPI279xej9TKUtpPUcxc9
 MwIfmuxe9NtdEJndgWzaHmcYPA2WPVwYAxKkUpKOcfw7lKQ3CHaevyhq+RGjalrAaNBm
 LOSRImzX7kY2RKqMu82V9QoQQIgmAxPyYHOev+6tYa6mlLVrCYEEy/EqIaB/Cl0iH/bP +g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbv53m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:27:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECG2qo164958;
        Mon, 14 Feb 2022 12:27:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkwkfm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HasJQV1BgpPxXOsxyLwV7pZ8oe/7Ft9mbwPmZhkl06AOvNWnu67pF3iQ8X73rlahUh5m2AgUWY5tLkVyp1ijXGP8CQdr0sQrWtPTuNZFkQIkyNwYSar7xBQNtoCA9oiwAT74PehWBQItlM5tZwTZi/UxO36B7X3apRNEeoQh0cbyjQeosI6D4n64Oay7qaYnYo9fUpFIx9FJNcBb7t6SFARfvT/+G59Tb1Q06yAOZAYCWusq5ATxfdv4WtkOapItbiVocaopwthfLeCZkH30198QEQVZVT179m21hhZsiqIG4+uonOneEXkmtmBuwdpzaGnS3WMqkCufiKxlxuj0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfgD/i0FCuGmytNWxvWCGcAlRc7EhaCu7C0i61b8BE0=;
 b=AgW+nSZjheZOnLIkXkAeGdBNPjhlyt1dF5ZOMqllinNcU0mg2lhS08mnxJhHZv+N4jNUwes+DPR/Vmi7AbdtloAUjNao9K0i5Vat1tE+Al4T+c0Cv3yNP/9pvQ8XHXnWWTJU1HLJ50g4Dq1PSwBv1IAxTNIIemD32Z8c7YzOfxmMDdEhIq3kL5H6mh05MTgsHEFfjhurwyFi7krveRLOlM0KO8PeCbEh9DLqLBJuC67VXhIn2UdCmR9CaFCOL2810DTBGKCWsqd1zfCgQFehIX9kjVy8QWua7jdJkTHrLpyTSl1FBQpz9M32rI5oSeau2q+BkByBfOk/pW0CMfSobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfgD/i0FCuGmytNWxvWCGcAlRc7EhaCu7C0i61b8BE0=;
 b=LLwl74YDJ28aQk68EwTHMqWfUIohR63XMpfRKOUw7cWi6JuT7rDSQvHOjY7BdYIV5/39iXCpd36TUvt8V5c3CH62OY2FnTwRx5fFQkyzMDCawz9d3ykxgyjdPrIDE3ah4+btxk/mMH3T/3dw/O62CC4u+9R09tQlpb2+QmegJjU=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by CH2PR10MB4037.namprd10.prod.outlook.com (2603:10b6:610:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 12:27:22 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:27:22 +0000
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
Subject: Re: [PATCH v8 13/17] integrity: store reference to machine keyring
In-Reply-To: <20211124044124.998170-14-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-14-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:27:17 +0000
Message-ID: <m2ilthtyze.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB6P192CA0017.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::27)
 To BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b85dc0c0-590f-4970-c56b-08d9efb55998
X-MS-TrafficTypeDiagnostic: CH2PR10MB4037:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB403795905345930406947A03F4339@CH2PR10MB4037.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rowwcx5NWvqwHdb1tb6aDiLSS5jJe0qdWRRzZZHG+rgylu7/FqFveMkb5ghDJARdYZes3WdUb88SAT5ZuUNQ5/vYVPTRHFExgJiutkIw7630c3j1EwhH3P8deKjHdjfJ/OO63iQOpYxkhx7EMm3YL5wUov5eofOdp2pxarXav059dl8tKi0I3lrBbb6ZfS7sOeSXXt480eAOUAaJB1wDwKEFLQWb/UeqvU9THjEu0rTkb81uWsmuYJ51NBG65HFl6IQS1HyqeHmYLBzTLVIOwB8Ir2e0bJ4os4iggUIDdbyo1EMICThyBOT+/Yji6bhvA7lhg9ZQ6IfOfgyd4qz0dNfsCN1vRWCbJg6IA4H/CFipDkFrgnO1jfqptaHwXa/Qso8GX3MiLLE07AAW80GC7D+rezlY8l5wADikXo4dZywWkCD9VaQQ9SDkXYFsXYcZ3uzqHjphVFetmu7FMqQhi2DzjGaotBweSyQybzLFizSRO7lfNxNSNNWUvfBwGAfEWT619QgeIXAyJEPxTViEXPTZX558UTDGmKfQxUTOL9+KYwIzDVB5muWpG6K8WTBetFMuEhK7S8+A2V60kDiyzBHAFlDtWZ0t6pqZA2Pn84giIzPgcCpKniayLNzmjk6CEMNeeNAA/iub/YXNiatC1MWZwaafiw1QDoeXRqqc7nM3PRMSRp6iJlWEu4yNLVFz8KX8G5GkUw24xSB/CIZOWMbmercZG6rw0TWLuJO9l2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(508600001)(6486002)(83380400001)(6666004)(86362001)(6512007)(38100700002)(5660300002)(44832011)(186003)(2906002)(2616005)(36756003)(107886003)(4001150100001)(4326008)(8676002)(66476007)(66556008)(52116002)(921005)(66946007)(38350700002)(8936002)(26005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzOr6SvbuCsq08hSrHNMwgbF7TRj/Iq0stv7k7QBq3D4FegnY+bGvCpng79O?=
 =?us-ascii?Q?nnkWXqr/mDMk1s0neLnt3cRq+Yalzj1xkPkRhektj21KGkJDuecxlmf9me2k?=
 =?us-ascii?Q?kkiEL0ImO75XV175d838wbff+p8IDWtvVa6UbQ5RAszlvEMUnZ9A95aa4vtu?=
 =?us-ascii?Q?4kqSKFls5CfXu1Mm7gZybr4X7/kkVdQo6FKnemL/rtwJqvprLDzuLyZcUuJq?=
 =?us-ascii?Q?h+jKq6uuIKF2kAZcZYls71JXlIH1rNFfgWMm3M1/3PWarldRSa8/nkLZTqS6?=
 =?us-ascii?Q?VbWZyCeVHh/1u4YJU6FQiIHOarKT4uFMMUAEm65SSF6sKvTGcVzZBzsNHlDR?=
 =?us-ascii?Q?XYrjI1QyXaNqeRmN+Z4kNkVHdH8nja+VZ2prJCZCEoehar3mb/BhQ29Kwa0R?=
 =?us-ascii?Q?EnKYL3Z1lGKb95zXN6hFctM05fZUa/bhIl2s7JlBHBqcaYnlkdCUWA+DYP1C?=
 =?us-ascii?Q?FE9lk/aDWylfqNsiCIcA8OfIZfXPvLCZS/iRbw+wGJHJ269Wj7QXoqCgBcc2?=
 =?us-ascii?Q?B5foYbkihusUx+ZJrKnAmEH3amnOZ5ZvcMH0Qj4Sr71QfkWmnH8bFRetjJob?=
 =?us-ascii?Q?e0N4+ETSyhhYnkaf0ZGlIpRWusmZ2xaLX1iIk3oVj1e3fsfQ8FBQ8bD1iTd2?=
 =?us-ascii?Q?AXrXBC2sobnXdewvwyD7iakxA+u3Qj7Bs2kQop3zcHyKEQXiPWuSpyb9ssa7?=
 =?us-ascii?Q?QvRKBKeOJXM+CMgxoMuWBxX/cOvK56gdLrK9i35ra+I1ari2GwBPY4ejky2C?=
 =?us-ascii?Q?NjT06hmrNBwG6VV79lrQWiaPh+L02celrPMBA8U9nlY31KlCIspqunuXv2E+?=
 =?us-ascii?Q?b2GY9YrIvLoXv7FXQZqbOWEywGsiBvSWhe5BbNoqnsHUfwUQS3Pyp6ZPIPlW?=
 =?us-ascii?Q?CWbQMuSx6CkCkHfUQ2FzH3V/548TAs68us+7Zs7t2Xczeyz505SHcFk/ao7w?=
 =?us-ascii?Q?NdSYuUvpRRjF+fqqMrcDzNvzvXxXYDEpakbHbiyw/LJOFrs59bPCVGLVdP3X?=
 =?us-ascii?Q?pBLG2jt0zbWkX9Nmo9jJc+te2wBzg3mwn5USeGsDA9q0vFEwGxJGmFsH0H/x?=
 =?us-ascii?Q?voDIqMBVbSKgODjhMSyum0HBsJbm2/dyXiL9LgBPHdrmybF4NCUijVEIEgrw?=
 =?us-ascii?Q?GpoJXr5xscjr1ubH9WpXc3OeY8mqKGaxEvuQVlfisTzkPChpcgVe0Dxb8ATN?=
 =?us-ascii?Q?Mxa1ZKtLb0IldnoMULN2+Tggl/KSW2ikp0p0SriqX8zIfkBKpZpudTmEdAoT?=
 =?us-ascii?Q?vQ5aX6ttbxMyWiG24WQdX9s/aHw6mPtkm2Gq/r5aLNy8ujJxk/zNdRUszyRc?=
 =?us-ascii?Q?vi+bLIv+kHhaWGhdOXYtFvxnaq1fjfQ6gyiV+KL6ikXXcVtRiwvHAP+JABK4?=
 =?us-ascii?Q?MuXap9JWFBICRC9v0AWo6ucmh8FEntn4bRmJsudpVIijI7dO98kp8xmfDl6C?=
 =?us-ascii?Q?TXMsVP55mYrhmI+9hb47wdSkAh6mqfHKk3ILPOJo+vg2BKcStPXKxYykzinB?=
 =?us-ascii?Q?myTluqIsnbiRJBgDub1q0H7pcH20hx2N1sRFlLSTueoXSmFpxJgkv4o5jM5s?=
 =?us-ascii?Q?6tJuaJLnjIk+WyKV/+qDKdsFsFdjpnp79uSksDVtcfnJBS1vLh2koxjYgjSz?=
 =?us-ascii?Q?Ra/EBVJl/NBg7N1oqqEwg24=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85dc0c0-590f-4970-c56b-08d9efb55998
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:27:22.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtmLecGToUHqNz93PDTL5/YMURTWRQqHbqbIOtZj33th67ke9iuYKxdx26qPxdHVNF/VDvdjjd9Us9lMMu2JLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4037
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140075
X-Proofpoint-GUID: Jf1VTBigLIZPUKyO2N2qoU72GzBg6waZ
X-Proofpoint-ORIG-GUID: Jf1VTBigLIZPUKyO2N2qoU72GzBg6waZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:20 -05, Eric Snowberg wrote:
> Store a reference to the machine keyring in system keyring code. The
> system keyring code needs this to complete the keyring link to
> to machine keyring.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v2: Initial version
> v3: Unmodified from v2
> v4: Removed trust_moklist check
> v5: Rename to machine keyring
> v8: Unmodified from v5
> ---
>  security/integrity/digsig.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 74f73f7cc4fe..109b58840d45 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -116,6 +116,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
>  	} else {
>  		if (id == INTEGRITY_KEYRING_PLATFORM)
>  			set_platform_trusted_keys(keyring[id]);
> +		if (id == INTEGRITY_KEYRING_MACHINE)
> +			set_machine_trusted_keys(keyring[id]);
>  		if (id == INTEGRITY_KEYRING_IMA)
>  			load_module_cert(keyring[id]);
>  	}
> -- 
> 2.18.4
