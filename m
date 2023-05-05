Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715B86F87B2
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjEERf3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 13:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjEERf1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 13:35:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900C3C34;
        Fri,  5 May 2023 10:35:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345EY2Mm013289;
        Fri, 5 May 2023 17:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=q821yn/ousGfB4CcEWvKmM9ItU2XzLAdrczSpivfAP8=;
 b=cfrXPxxbnz+M3SJxJI/OKQ4EXeRPtPEaeEd6eh9cucRmBuW5IB+Guy3z5zRfHY7NPspa
 qJ7pT69t+o40BXqcdA6reOzGsbSu8xjvd+wQlw+vN3nF9eMk+G4AcbMsp6QOKKwu6boj
 SX7FpqDNLwpts37CR5uOX+ZJt9UYpnhfVLh5NffUSDbZmxbtZIsjF/LTQ/sGaRZbvWIF
 pMfUKAZtAmciqTQY2wYJVnoyzKN+o1CIDRqfxec1xZsTKgCCcBRaTtvtRZgGtp+5a5h+
 riGxn4ftkkdv9LXmuOkqBQX+KCCKBgdJJfDs6IU4quksGX93tp9ddGbaXRtNP0PQR+CY 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneddau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:34:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G5cXE027258;
        Fri, 5 May 2023 17:34:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgepra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTOp9yjKqpHsvc+ZjwlNlPUqvGtxmjwjtpxrAeP8JFvKtLf5TSaFfdVltL58KjsF8Z7HCSGSok2GBQg9LDuqJpJPKtm0ZJrCJnyAcI4+Z/6j80qll0GzCYPtNfRlXIp73n8HMkLuynoxRvTEba3+4wj9+4O8+i226CaVjWk3HBSO5rVQyGI4noLNl9Isj5UxcLuFg6bxyuDP6+7Om/13qFuCNCNzIF9jHSh+5ZbB5pF/vWxziFuyoEzQvyDJOJbWhVKSFI4mol0Ur9ORQ/Wk2G+va0Osds/QjiL99mdl9lIt0NRu4SjNdZ9c6SdNicsLg/z6uRHb+jFAz3eik50Okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q821yn/ousGfB4CcEWvKmM9ItU2XzLAdrczSpivfAP8=;
 b=QzqloNsvZwBDDYaIL22wMWgDcxb2rShe/QlOuyh87Jqh5fWOIhLRR/YMaty1yJ351tqOZagnGHlhrRLgruDdedbcSpDj8FkGGk23SujYVsQrKmJwgHawSQPFOD2jNKNZsVZdz59wG3LuDbU/9DtS6IXeykpS7w+K4SW2ks9Rn5B9UUt0KuNXDxpeMAJgkBNf6g9dRMUqe0rF3+sHBU17sZECzM7KNYOls5K5hwqzxoOVLhxmNTfcOMqwRD5be99Kdsygfixi9R028MYv8jh8AhI8ZlW8LSncLVHeUoc6JwJOTFFofOuaxasoGVIKbBjOAlDk2oK28gf/UC1jktzljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q821yn/ousGfB4CcEWvKmM9ItU2XzLAdrczSpivfAP8=;
 b=InvA4KI7ea0qYN4tocfG1uA61KDX5oWM54LUm0GG2hUe0l3NxS5gCVgy/awDQdNB5HOxql687HUL7+EmJg94usrPzvWVWNLIt6iMAGsXAwWmEXgCbVLd8D5y2DToKvjpB4Msz0C5oyes1FkJWcSNhkA/oCuVMgkel0HyWFPD11E=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:34:51 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 17:34:51 +0000
Message-ID: <3f04625b-b035-c86a-8aed-201dce6b80d4@oracle.com>
Date:   Fri, 5 May 2023 13:34:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <ZFUtPbgvG0qifhnV@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFUtPbgvG0qifhnV@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:610:10e::18) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH7PR10MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: efc91ecb-a2eb-4514-201a-08db4d8f07a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIyRcks2875EYAjeuMfVChPZVqE1BfE6MvUlBIMJBAiFO0kZ1q7qTsTE3ClL0hj2dic+QMu6ocdVGPvOeX8YiOf6Yw5yWFOQRWpWMkLMajN37LBEVu3eh6EKtXLUOQ9DP2Yu6KnihCXLyUwJmjOgm1bo1V5uzQZLbhEpue6MBcCQF/Rv6FOmEX/mOJqfA19MWQhUYokQZK8NeYDPniAuV+56F4IpNjKQg+ygBBOzwbQs8V7dHCpIAoWLfkSo5ewS2z6NygmYBWongYouMuJNx4GEKc9jR/ibi9OCrilekqORUYJpFd2b1KPe39u6Socb2X9EQT7P7N4JcZFs0VhpM+qUJrL5LHOWmiKAj7zUwRDxItUzM/dYseKBYdxdMblNCgyAs27DgVvNvhzcDzX5P0sJM3N5tFGiRE9s6MPhWsfEUImOMMHFmVTRSwhxV5TdC96HPlZkiAs7sFMpZkQAhjUL5Xa0RudLiSifXYsJe//hkiIAkunK3PIZW03o+2DutuATo5gfXlDwSVm6/0xEU8/dNdNp89+s5M4uHjeXit34ClqmkRs7Rp2buoMyzmeSdlkxxqYfgXmr1380mG7pNxxO14n+VpO4Ur2qENQVmxf2cqc5WgWhas+hhCj8I6TZQtYq+TBVOjUMBTWvQ3EGrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(31686004)(66476007)(66556008)(6916009)(4326008)(478600001)(66946007)(6666004)(6486002)(316002)(31696002)(86362001)(36756003)(53546011)(2616005)(6512007)(6506007)(8936002)(2906002)(5660300002)(4744005)(44832011)(7416002)(41300700001)(8676002)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9QeEpaamhJdkxORHNiQVV6L00wcUwvUXd5YU94anVNU2RUdkUwa25kVzhJ?=
 =?utf-8?B?L3pIWEg2ZFJGbnVaMk53ekRGZmpJZHB3UWlCSUlrWmxkU2xESXNnVjlEczZP?=
 =?utf-8?B?MjlUUkJyRnIyT2NNaDJYS2J1K1lZaWpvK0VnNENjRUpqSVRUN0l5dFo3WmVp?=
 =?utf-8?B?MERPdWNwQUdDdUFQMVdIQnpMK3RsYjN5ZStGNzJlckd3TGJJY1FGeWNkbldv?=
 =?utf-8?B?dXArTStQdXgrL2xHMDFsdWptL1ZoNFIzSTFEMjliazJFNmdCSUl6QzlyQlFr?=
 =?utf-8?B?WEZDQXZnQlZqQUVLVzhWYmZuTzlvTzZUUlZHcGRJZjNseksvS2JyWUVLREdN?=
 =?utf-8?B?SmJpWWhjQVp6VHN5dGtmZWczdURDNTlvS0U3WHFYSW1reFVZdjUrTnNYWUsz?=
 =?utf-8?B?dmJLZWZKTGswMDVraE5uejBCWUh0clJkTzFQV1g0SzB4RXVnQUdJaWFlR0M4?=
 =?utf-8?B?YlFOdFlWSjdYOWZFWG5HSHpXVUxCcVNEeUd4dFZUQkhVdTIvcEtOSmFBMTUw?=
 =?utf-8?B?SGFlSDdaalJPREhJSUZhTGJaUTdKSDAwRHdab3ZtZWZxc1EzM1pnbjBuL3Fy?=
 =?utf-8?B?T3lIdTNDekh3dTVlM2o4ZnVuMERrR09mOGZqSjBlKzd1L0FBUE5jN0ZyOWF2?=
 =?utf-8?B?bWdJU0NVNlNJM0F4clZEeTJ3NFFWN0V4N1d5QmdmdmdGc3ZRamFlaXZ0TGNL?=
 =?utf-8?B?akhxRDhQQ2x3MThvd3pmQmxaMnhHaXRKUEtJTXpBc2piWGZpNGR2QjNUaldY?=
 =?utf-8?B?WEF0VWdIQVpNNEdPVzZiM0xYZ1hTWDkvaEowbXVBalRERjgxdlk5b2tzTTlD?=
 =?utf-8?B?c2hSUUdQVGhIZ2k3elV2c2IrZ1p3UnpJS2hHcnVJUElPSjQ5YmU5eUFlQ3lY?=
 =?utf-8?B?bHVLRFBLcVVaZEFSU1FzcnRSYitQTEFWOFVvQ3FaUktZenFzN2g2TmJ3S1Q3?=
 =?utf-8?B?enBLYkcxay9SaWoxR1c4Yk9EcVhFdzg2dzFLTjJqV004UUFEcUJtYUFmUmg1?=
 =?utf-8?B?Z2Q5M0VVZldTcFBJdWFETmEyVTBkaGJDdFNxc3ZMcE5KaERqUGdTa1VwNmtJ?=
 =?utf-8?B?dmQzRHBiSVBHK09qNGpKRjdpV09rSnU4N1lBSGJZdGVFWEIzWjVRcDdPK2Ey?=
 =?utf-8?B?eTZHMVVlaitSdVA2SW1vUEp1UUN5Mlo0b1BIdTBOMFhObVpZVGhVYVkzTFlB?=
 =?utf-8?B?RGRNMElOcVFBek1mSCtiei9sWWwyLzBuMVVuLzlSRmpFYUNKL3dtcUtJZnBQ?=
 =?utf-8?B?aFZDZlFqSjNIQjBlYUVoK3pnalpmN1VZcXl1SXNTcGVQSmhLa29NYTJMUG1N?=
 =?utf-8?B?VGwzZ3JtZCtyS09KQUpqbE96dmtxVHFjdFJoc1htYnI0WVZVNnR1VGhEcllL?=
 =?utf-8?B?Q0F5MDRMNUhoU3hmWTU0YyszUURUWHBDK3lBSTZ4UXZYNk9jN2VuMFBWeS9o?=
 =?utf-8?B?VXJERXhtbExiWHNCYzNuOHVCZTVtQXdCQ1ozYWpheStlazZ1WXFneTdXeDlp?=
 =?utf-8?B?eWY4YXNYU0kyRGx1ZUx0dnJSY0ZSUk43VkZ4UENkak16dlRXcnZ3Tlo1Qk9l?=
 =?utf-8?B?UDNRdnhQbXU5TnZTbjlITHZtNnJxcTJsUkliTDlveVN6MmU2Tm1CcVlXYzJH?=
 =?utf-8?B?RHRhRFVGZk1KaE1TcEl0UHV2ZUYrSExaLzhNdzhDVjFhVDJYUGluWHZjaEU1?=
 =?utf-8?B?YzdvQ2N4MjIxU0JUaHVzNk5KVHVsdngyMm16Zm9waXd5Y2VwREVPaVNQVVVH?=
 =?utf-8?B?cUVxWkNlRjJnRWN6UCsvb25lL1hwTzB1QlAwTDMwcGIxTDl4ZlcxalUxbGIw?=
 =?utf-8?B?UkNmZnl3YXcxeElkV0ZQVGhvdkhGRW9QNVQxUHVsb1BCazdTUU5ZMlI5Mk8v?=
 =?utf-8?B?emsxRVpuL1FwV0NMVWdxRzNQV2laYjlzOHVaeitydURmQnBnNTFtM081RlRz?=
 =?utf-8?B?ZnFNbnNwN1oxNjJ5RU40bVNFc0d0NWRmV3lwT2VpZmd2YzIxYjhXbWhWMGdJ?=
 =?utf-8?B?R0pyMXdKR08zZ3o5b1FFc0tkdVN1bXVLNWF5UVRiQzQ4Wmovb2l4N2RkQWxP?=
 =?utf-8?B?OVpia0V6RFF0SkE1L3p2QkxLbkcrZVlvL1l6dU1xNTVKeXBmbzdtclI2Ui9W?=
 =?utf-8?B?aGxjU0hZMEJpRUxJR1dNM0NXeDllUHZZRjMxRnQ5Z1FETVNHOEpENEF1RjV5?=
 =?utf-8?Q?6GHxNTT7id4h64Xr3JWe4F0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDJRM1l4amVNOHZaY1FFeWVndVc2UEtxem9aUHdZbklkOE9xMTlMZUs4Ukc0?=
 =?utf-8?B?b3ZncWw4M0ZEclN0TzlwMUVHRjAraDZPTzdHSWZ3QWFtNEhKZzMzdXkzL0dQ?=
 =?utf-8?B?RVN0Snp2cGFxMUZ4UkNDVVBxMDFId09XY25DcjZUOG5aaEI4V2pETytOa3Vk?=
 =?utf-8?B?WkVJcytkdG5XTjVJd0Rxa3BKTU0wWFpSRlpLUDRVUzBaR2tLVDVXOG94a3N5?=
 =?utf-8?B?c2k0NkRlcjdGcklNMWxOcGxLRkhMR3VOVFpyalNuRi83NkFkRHkvV1dDSHMy?=
 =?utf-8?B?UlFHZVZ4TFh6N3NKN2czbGprMnFCUHJKSUJiS1FyeUlBTnVLbUlCdUw1VFJ1?=
 =?utf-8?B?bTNtWWxZTlB3NFo3UEtQbGczc0hZc3dOaVNvWUlsa0c2cXN2akFhdjR5TFpt?=
 =?utf-8?B?Z0JTVVlObkZtSmhlbEFzNHBmMnRtbGcvL2hNT2dTNVgrR0t1QWwzWmpqeGh1?=
 =?utf-8?B?UzhncWRhcTJSek8wUzBISmdwT3pmajBicURReTlRRHphMGd2eWg1dTB0cGM5?=
 =?utf-8?B?VGNYN3JpYzBXRFhhSTBsS1lkVHZGRms1aFVsNjc4Q2F5dDYzOE1jc2hLM0JF?=
 =?utf-8?B?azhYbTkxbitubWRPaFJhdEdNYjBDUFFzV21DTm5PUTJZZHZaMklqVnZubkNI?=
 =?utf-8?B?aTh4T0Q0bHdTR0FQNzZQdVJrTHpvWE1iUk9WcEM5TDlURnk0d3NMdUNRNUl6?=
 =?utf-8?B?S2k4b0xFOGhHOURWNHJzdkpLQzlvMmxFOG04ZE5pUVVHQU9qbm44VVR0b1NL?=
 =?utf-8?B?REl5QVU4Z083TVFzTlEwRUQ2dURQUHFTL0d0dzV4d1czaFEwWUdOcWRKc01x?=
 =?utf-8?B?NEIrY2JSWjYyeWJJVVM1UEJiVkdpZDFwS25mRlBZKzZubmgrVjVMZXpkSTV6?=
 =?utf-8?B?bkZSaDVuSVJFZFNMNzJsK2g5TFhxQWEvZ1pJZUIza3Z3WUZic2V6TzBpbkR6?=
 =?utf-8?B?UXlGVVRVTWNLVVZhKy9WdmFIbnd4RHJIaitPaTdMTU5uT0VjZTVHWlAwK2JO?=
 =?utf-8?B?cW9TRUQvUUFBYjc3V1U1QUpSQlE2RUsxMmMwT0p0Y1JFMWJ5ZEp4cmtuaUgv?=
 =?utf-8?B?eU1iLzJyL2g0Tm82Z25uWkpUSm95RGNoaFNFY0FzNENxNDhlZWR4RE5XWWJQ?=
 =?utf-8?B?aGxBTEFQbURwWlJRUFlRWXdBTWFaYXkwdnI5azBQS0ZHeTg4c09pVzVMYkdL?=
 =?utf-8?B?ck1OVndMMEVKRVFscWJ2UWgxTnRqY3BEWjZSSDRwSExNVGpCRFdhbklEN1hn?=
 =?utf-8?B?WlMvWllYOXhzdDZ0WXovazBLRExJblM1Y3dpK3pxMW5GRWhBZnQ5N0E0YnFO?=
 =?utf-8?B?aEVPOXdOT3JoaTRwTVI3SFZxa3ZFUG8xcnZoWHZPT2g3OFZsckhYOXFZMno4?=
 =?utf-8?B?bEN6blR5VHNQZVd5b1F6Z2taYXBud0Z1c3FxbEp0R1FoU25PaUc4V3lRaVdJ?=
 =?utf-8?B?K2Vya3Q4ZHVnZGgrcklnRFFqbHVOM2NuendDbkVhUSt6cjB1YTIrV2xRVGRF?=
 =?utf-8?B?QWN0MHhVWkpFalZxSU43MHVTNUloVEZyZmN6Z21NMDhYaTdETks0ZUtnUC9N?=
 =?utf-8?B?OVRsUWQ3T1pBTkMzajJqdlREcHFhbk83Unc3cGp0MnVCTzVjZFNhY1I4NFdu?=
 =?utf-8?B?RGVGaGhyRXlxeDRWT1FwblJUN3NmUUFacjFCVWI2OFg2dm8zOGNsZ1hKOUdh?=
 =?utf-8?B?cVFNbm1zN0pJekF5L3d2T3gwdHRIdHhkSDE2M1pBdzd6T1hyZDMzWjRZQ1lQ?=
 =?utf-8?Q?SYO1otC9RZFOncpWmM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc91ecb-a2eb-4514-201a-08db4d8f07a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:34:50.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCXXACRG13lML/ecsUs5g7oiDLymlwFSCJ07rxR509KaO6CdOUlvdMWAVzZBsxFPY3PZDTO+SwSXRRnrzbb7uE97gJK3+/0wYsSacIeQea8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050145
X-Proofpoint-GUID: 9uWMZiFJD5atAHOGyfhZH2C-w7Y3doHv
X-Proofpoint-ORIG-GUID: 9uWMZiFJD5atAHOGyfhZH2C-w7Y3doHv
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 12:22, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:
>> Introduce the Secure Launch Resource Table which forms the formal
>> interface between the pre and post launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 270 insertions(+)
>>   create mode 100644 include/linux/slr_table.h
>>
>> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> 
> ...
> 
>> +static inline void *slr_end_of_entrys(struct slr_table *table)
>> +{
>> +	return (((void *)table) + table->size);
>> +}
>> +
>> +static inline struct slr_entry_hdr *
>> +slr_next_entry(struct slr_table *table,
>> +		struct slr_entry_hdr *curr)
> 
> nit: The indentation of the line above doesn't align with the '(' on
>       the line before it.

Yea I see there is another one above that is not aligned too. We will 
fix those.

Thanks
Ross

