Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D726C7316
	for <lists+linux-efi@lfdr.de>; Thu, 23 Mar 2023 23:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCWW3W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Mar 2023 18:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWW3V (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Mar 2023 18:29:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE927D68;
        Thu, 23 Mar 2023 15:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0gT7A5LrZTCIUSq+hHghPO09co320ZrFLkt3byhzC28ahQMYStYpaZ2dGUBKXZxKJaLVZPN/24TnI/Iwrrc/LufnhKTdE5jeFAM//7YLkyHyh412SJGKh5fa8E2w6IucMQApkXu6PcAqta9V785+cTtdHMz/yRo+h/gVRqZq/5DApDLGAv9A9csiB8YO0MDjApPV/h8DuEltS3qvfJlqWd4mWHZB7aTTozPD9WKeeHAHk7zcVNTn8rRKQA30uGCHZYAJi2e64ZXdLfplyYh7FJa+uerHnNfwkyi7H3VvTyb4ELiFW3wZ6krj/jh7atYEUde8ciUY19UjLHg2MFJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFwOr765hp37mLihN9clLto9Gmb8x2ZlAOzwGD6FJZ8=;
 b=oKpLEF/FDTeO4ThptzTeJBfDVIX+g3VHyycOu5TIlVayUDqjKzIWmKW4hZL8uMpy86rgYP52O7TTmwRRUcQzKxmt+odPon9klEj+EbxmGCVibW+c4yDBuLJzgBIggVxsZHZKvNodljmQZr+NKjoMJS+1RoWVQOFLP3znHHxgEhknShYuRXr011J/XazrSHh9GLsHtLx6/ct71HLnE6OEHTNyuWIlHX9fopmTcWySjmWqaBtcDalRl2F1ditC3H8QqJt06mITG93mJ5xiZ4mxz2ecb8LrokIJFTrjfHBKGsldLWth8kyXOoFUavVvLgzEYnRjy3W22x09twgB+BCayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFwOr765hp37mLihN9clLto9Gmb8x2ZlAOzwGD6FJZ8=;
 b=zf8+OJokv8Al5ekEQ+sFQyoM2m/yrYDpJankqVaHTTv7awmVZidUsItfcLt2IZnjg/wC06Fl7bTGfv42Mv32OyWiq/GqhD54Ofpax7nUBNQ4gEWbxdftjqD8a+7LLHDMz3xwaJ6LNk3ciKSuk7DeMkY0TvzJ4B3f57ycPwjIL7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 22:29:18 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 22:29:18 +0000
Message-ID: <21797f11-0e95-da38-28b6-7c366c6727da@amd.com>
Date:   Thu, 23 Mar 2023 17:29:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/5] efi/cper: Export cper_mem_err_unpack() for CXL
 logging
Content-Language: en-US
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com, ardb@kernel.org,
        linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230323213808.398039-1-terry.bowman@amd.com>
 <20230323213808.398039-3-terry.bowman@amd.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230323213808.398039-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 7677b38d-cd6c-4cc6-e2bf-08db2bee0a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/6M/wT/LmPJjC4kQDcz0szjdbPLkJ+YTjKLolPuQzv2lUONE8aXSVHdDJ0JZBAuuGVyuCCg0tHLaanRdI1zl/EoOs6NGUsa7TBUb7XuBdnRL1NmQDQmzNxDOCcX9qbXcgvJlXSueQT1/H6CzWrxNY++BTuJy8UJMqj/F7C7cQ9zeIvCPmryvUV9zzqUM2qAmFBrmG6twqJ6fNQsS68NtFZ2JsaoDkCOyqRU16LRwpqVTrDotwQiQ8vnk71WlG5YUI0eWA9aZtQQA0oYplDKoZBbgzx8Ng5tLxDxrsLk3FQgakhtQX72xVTLoU8v4CKUsCwB48QQnCiu0+2JH7Deg+lrGwFRMndMRyG3Jj+H45+8j/k3SXqHsO542a79iIwGKZKXR21ws1XF3Imgj6/63is7FTpslT5s6xF9mnOYSCCa1zXJucosKb1c8myujVwt6f1Jp35ys3DspqDgTk1b9cSnxh+b1/viO85fWDzlNK4W7PYWxcJ+vKtuOwbSMnOWuIX/dkJePaaZsGxOC4Z9TJCBKR3PFOirUGrHA2bprktJlLSZazP+tfzt194o5mvFeyCIeydlWTfxNe6AiT84aRQ7p40Ra73rdpqHZIUv06DmnVbXbhWYcgyGDqPq+Qu5jrdofeJX18rzOPS2kdjb9oAEINKqizkdg8Ic00HAKtStjPFx9F1rK5GNxlzingzeucDx2xcGKn8ZqZNJK4MFw+DRnhcXdyoUmmLwGNjx7XaM2HYHkD7346bMyoB1YrSc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(558084003)(36756003)(38100700002)(86362001)(8676002)(4326008)(66476007)(66946007)(66556008)(8936002)(41300700001)(6486002)(316002)(478600001)(966005)(7416002)(2906002)(5660300002)(31696002)(53546011)(921005)(6512007)(6506007)(6666004)(186003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9PVm5Ra05mUG9GRXJDN09KVUFKOHgwL25lK0pwNU8zYU14VW45L2lFekxu?=
 =?utf-8?B?a1dkaE9GNDdDbXo5UUgwak1URGNrREdXTHFNb0Q2ZWVyYnkydkpLQWx4WVF0?=
 =?utf-8?B?V1pvUy9pYkhxVGV3bzBnOGRXZCtSN1lFL0taa0tCbFBaaXNleUJHcWJvT0lE?=
 =?utf-8?B?WWM4bTZLWTcrTUdtVjZDWS9hSjJWNHAvTGxOVzllYWpvQXRobUtsdzNRZHJy?=
 =?utf-8?B?b0JhUE94TWFYMElQYi9vODF6VnU3RVJDRjBCc1VvZWFSbk8wOURFa2JPL3dD?=
 =?utf-8?B?ZEpSL2x3Tk0wVGoyVW1uTm9kcjUxakkvMExXc2NzY1VuK1g1WEpPRGhQVnM4?=
 =?utf-8?B?S0R0dGtheFdpOEZwWVdIVW9BWE50aXluclJJZ3NYMjJIbjkvTDZXZWVYWlR6?=
 =?utf-8?B?eUp4WGpkRGp5U1VzMnlMMEpLN3JxamtjMFVCYTJwM05xOUg5MkhWdjNQVVYw?=
 =?utf-8?B?bkt0czlENnB2K0FsZFF3U1dST0xTSWZ2aWFvYnlJSjF2d0NpNnFuTC9zdFA1?=
 =?utf-8?B?d1ZEMHA0SnB0aW5MQWRlMVZRM2kzOENQcU1qUTF6NFZjMmtPK1FVZU5yYXZs?=
 =?utf-8?B?Tzh4UnlDRURwZ0VpR01nb0xRdFhwcFoxM3VvMWhEYU1EN080K2JIQllhdGV4?=
 =?utf-8?B?aENsSVVvV0tobTUzeC9hVGFIVFVCQTJ3WkFpTmlDS3BKRnIwM0pLQzFkUmwx?=
 =?utf-8?B?N3NHVCtidlFUanRTYk1WeHRTcVdtQ0Vqck5PZitjaWtVbmlJaTJCWEkwZGxS?=
 =?utf-8?B?OVJqT085K3NyMlJOejR2eDVqL2VObHdQdkpHTlkwSTVGS2UwUEJUK1RoQ0NV?=
 =?utf-8?B?b1FjUmsxamc4QWpwbWVRWFZnSU9CN01uZ2hLTU1heTdsT3lRdU5neWtYa2pL?=
 =?utf-8?B?TGRyVjBoVUpqdVJHZVh6Y0Y0QzhrQWdwaGVrbXh2blpYdi9uZkRJU2JRUG5p?=
 =?utf-8?B?dVdjV2RRcFBxRzk3Tm1vOXRNdEhXZTFsNUxtdnlaaStscHkzTFh2bVE1V0lW?=
 =?utf-8?B?Y1dXUGYyeWxpNTUxQmxXM3BTb05tWUV6RDNtTVRjVHhPRnFMaWtyb0hqbVBF?=
 =?utf-8?B?NXZOZ2w4akM4K1ROc0hUQ3V3WlpIemNZMEM5RFBXZkJ5RmJNZzB1K2svMGhh?=
 =?utf-8?B?aXNXeEJmTlVVMEtMWlRKQ1FiZHp4cm9uYjhhc2tuOElOTkVHdHZpZE9MZzRQ?=
 =?utf-8?B?QnZUZEowcTZpb3g1VFZPOGpobUZxU21RSnFTSWFoazl0eXVwcmdyam1sQVFF?=
 =?utf-8?B?NmYvajhWMFpuR0dKbkdGQ1U0RytWc2FYL0paS0RVQXJ6c3ZqallhaGNuallB?=
 =?utf-8?B?bVNmVWVONS9USVg5MnlJT1RIemZyR2ZMVmdhc2QxVmtPYmtNTmEzdEQxbnpN?=
 =?utf-8?B?WGtxbjJJbjRja1k5Nk4xMnhIdGU3RC8rWEVtcCtTTVV0anFmb1VCR0ZjRHRR?=
 =?utf-8?B?dlIxTkJYanlvYkJlWmRQcTdzd3o3N1ZTRXR0a3JjQWFZUVYyVFJqcis2UjJJ?=
 =?utf-8?B?U08vTXVQeG1nd3daZkFZVDAyZWVQRWVIYVVrUWUwUllxb05jTnlYckFsWENs?=
 =?utf-8?B?Q29tTUZvNWsva3lMUDlnYUkwVlp4eUJJbzlRdFhsazRmUFNvc284VmJ3WDdG?=
 =?utf-8?B?b2QwcnpUVTkxNDEzMjAyR1lqeGxrVkNxSmpWRnZVNFJaWm14VlpnRW8zK2Y2?=
 =?utf-8?B?V2czSkhhQ3BIYUdLRy9IeldYSjVPUzNtZUQrbVJ4OTc4NW5hK2NnUldzdHJH?=
 =?utf-8?B?dXlhTjVGMmY3d1FYSitOLzF0ZnZtd1pqTkNCSERmb3ZybUx5YzFFSk9PbGpV?=
 =?utf-8?B?NFBYcmJzaW03WFpzQk9kSTM2QXZ6M0swcCtLN3haY0ZQQmVlL2c3cnRWRnVO?=
 =?utf-8?B?WCsvYllDYVNxUlFoVXpST3A2SFltd25EZGhXK0dVamZYc3BzM0RGRmU2YWhR?=
 =?utf-8?B?RkUyWm5UaTk4Y1dtSzdmL2dLRndjOVZ3SW9Jc2NpSExibnN4d1oybWdwSHdH?=
 =?utf-8?B?bndGLzRnTE9KaVlJR0RHb1liajhhNGd1ak9nVXdIWGZYaStMWU9wMy9tRDhM?=
 =?utf-8?B?RUlrYS9XeEVMYVRaN25FUG9sYXN2UENkVnRhVXFORHpqSU0yNVRmUlJHZlN6?=
 =?utf-8?B?cjl4T3VXSWl5M0FjMWl4RW9qd2RXUzhwTEdITzNKUHJXT3JpR1lyek0wenFS?=
 =?utf-8?Q?DqVIKFg2l1Y7Xhy6U5MZhGUQU4z3ukmmlUABu8L+gq/6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7677b38d-cd6c-4cc6-e2bf-08db2bee0a45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 22:29:17.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1aoJOjKT/dFx4j6NehMjV/g1NfY1FB0nLQ/sJiTjnNXKAIaYN/8vSxz0kxIWDwAkx75F/kDCc6oZ0BYZXYMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Adding EFI reviewers.

https://lore.kernel.org/all/20230323213808.398039-1-terry.bowman@amd.com/

On 3/23/23 16:38, Terry Bowman wrote:
> |Ard Biesheuvel <ardb@kernel.org> Cc: linux-efi@vger.kernel.org |
