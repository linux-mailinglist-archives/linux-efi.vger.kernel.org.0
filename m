Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1F6E1546
	for <lists+linux-efi@lfdr.de>; Thu, 13 Apr 2023 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDMTkQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Apr 2023 15:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMTkP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Apr 2023 15:40:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B55FFC;
        Thu, 13 Apr 2023 12:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3NtqMvnvFg5crjKyt3lbg6pdPjHIZcDTqDSc2bbFhly7h3qkVFgKO7YOszFU6d3MHdXMv6Y8X47J42DMqTn4QipS8SqyNrujYAn+S4o6l7cTyrMj8OaD4XbMwySUmIIC+iMF01I9SxLcXyCe2l5B5nnOSrbTmL3sZcAPqfOUkzf7J4aVcGxExBxCuckQ5JgMKm72RzybnE5Vqoyuaf7LGqzW1ic/LVjMwUY3C61xdWJ9GkWT5jhvP0D7EqV+kHKP1lmmBzlP5ESge07N2a/GiTNFox8eJb4xyn++CQT9AOuP1BvKnorstWPV47nzce2C7FSpcZ/nhgddqp6aVqiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6t39aT3mvkoggfkY3A84W+xNdD0GNa/9jSZMc2nMoo=;
 b=RktDzs9/zTR2u+ZpKMKIcsw7y0Vp82U/3kW6H3cZcJdM3iYL/vAIZRYJ6pNeAyw2gBQOPYxwN9fNmTFC1Ee6HY4pYSEXEBZ0yXgp0+NWQe5OmzGKbyxFaGZ0wkGkFy13ueA0BjhVeSnsT1IkU881YS8IWSJ1xj5yfJD9wBsu5cDpjLbqp+oFKB/4QySFeOpxT92BV5dGteFEF6qkvCZwiQ+8hrrvvCBod5dgWZcAHGh8NJqfTiQKLDN8b5fw3LyyQ7BwaBD0EkRir+BjCwFNVgWzwwUOR4ndHUDc1P/2yYsPj1nHHSVMXSDoJzT8v0xhY7uLprVXkfqT8KrZM5+WQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6t39aT3mvkoggfkY3A84W+xNdD0GNa/9jSZMc2nMoo=;
 b=vNIvk4ENupAGyvgcU4T+XENUtU9fC02PjoW9HKG58v8UGZ31gUkJEqoJT8ye4dvayu3Se7kuxPPPKl7ozUKMUQ7isRu43j2L6vcHCx0Y98Hp0pK+8GvJnQWpzhnCUp15tEH7DpumuO/kKzWGVA71dDmZ4NkCzHgxzRmmy287zyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 19:40:12 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 19:40:12 +0000
Message-ID: <9d66afdb-40bd-4254-547e-05f6481dd550@amd.com>
Date:   Thu, 13 Apr 2023 14:40:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use by
 modules
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-3-terry.bowman@amd.com>
 <20230413170816.0000333b@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230413170816.0000333b@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:610:58::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e65e6b-949d-4483-2f38-08db3c56e5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzxCnA99jKOjJRPUOWRoqBGgVTVIrCdcgyPNEd1x2jWKr9+Ss6lQF9qXT6WLTMqPWQBnfmC7xgNsTNxi2LjOiLo5XE5w+Hrko4/dK/8Uq+K/cEtnhaZLsht/vStv3DGprUQ/G/NUb5ZQZPptgJx6D8Skr9VyIuDMO5CCEuk+VdBkl+mZlvhwYZp+a6d1JAZArjVtyAi+g0bujtX0wPkSrw7+5m4CBXO9EaeZN2OvhwnKk8CurBxvlBgGj09aNyZzFu3rROlcY4znYcsNT9yl6N0f/jtvqf0CLPRIlCy9THoVcHbde2SKMjueNQmAUkNufiLRk382xC9qvb3JFpnf0Ci5emgLr+8BWzQj6N1PUU5kokuFC5fDhwin37tDVtyhch10S2GkF5Gy6FTrfJ6tiheTk5irnBpar7tcCK4CM1Mv1bHmYTmWdP1NHrKc8lqnMpC5TTkeMZzg4WLkGGtMdO8vopyiUFobSC99undYdnARQlWlC0QyMpQwEd8pOV4MpjlOnmdGhJVSWz+ZReoKy33Pv2jNKNLfTbV3MBbJHfI4pSyLsLveQqRXHbxLjcoh3pnaAAjU5ifElkZ9yz6uW/sWFutKgkmgz4mgGsjd5JVk40WFXCjy8nF5ExKbwKFa0LfrzyAnBzm+i7RFiNxJAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(31686004)(31696002)(38100700002)(5660300002)(36756003)(2906002)(7416002)(6916009)(86362001)(316002)(8936002)(8676002)(4326008)(66556008)(66946007)(66476007)(41300700001)(53546011)(2616005)(186003)(6512007)(26005)(6506007)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlWb2FNV1YvRnM5Z0N3UyswWHJpd2lQWjR2NDdsSlJlS3ZtWXN3ZXBQU1FH?=
 =?utf-8?B?NUU0V3Y1cmhVZHdHZXpmOHJ5em1qK1RRaXM3RlY0QW5pM0RnU1BnVDdIdXNu?=
 =?utf-8?B?YUxOTUVzcTZYekpTSGxnVGdLTi9zTjl5QS80MEp0bWhnYm1tLzBSZ2hQYmMr?=
 =?utf-8?B?YkxjSkxnWDRLOUF4M050c3M4QmpYYkw5elVOMGd3aFUwUG5nYjRkdnF2Wmsv?=
 =?utf-8?B?VER4dGV3dHFtWFlFcDRYOUdzdWlFRHJmS256b2xZRkMxMEs3V3JEMW9sWWVD?=
 =?utf-8?B?VXBvMGFIQjU5MUYvNjhFQXpPdFkvUGtsQXJaSGlDNUg5ZVBidEg2OTRmdURG?=
 =?utf-8?B?MEZ3TG9CaXBvSzlGQjhjMmVzUUNzYTZkMVVTc1dkNGtHK2pUUVBhZzNiZU1a?=
 =?utf-8?B?Q0dxL3hMeVNiV2lWQndCdzlocmNBMU1halFsWFFlQ21SRE9uM2RTcWtSTVVp?=
 =?utf-8?B?VkJoQ2JmVkxnN2toelNHS3pPRDRaMmJPcjBZK2VCSkJOQzdlaHlhVEtqbDlk?=
 =?utf-8?B?ZEM1cXpjeHdHelFLNUlVMnYvWHNTNXplWDhqSytwRVByY1BwK2doYSs0VUpT?=
 =?utf-8?B?U2RqSWNYM3FlMXFXTTlxU2QrRXFjWGgzeUFra0htUHZYVUpDeUMrS2oweG5p?=
 =?utf-8?B?U1RpWDFueWhDSURFZkdNQ3Z0SnlqOTFhSWNNNUQvTTYzbU9rL2Z5aGZzUVJW?=
 =?utf-8?B?dVFORk1HVFlwa2pzZngreUlYNW1weExNOTN4NERUVkNrdnhySU5uaUVxMzBF?=
 =?utf-8?B?TzRvamxKY3ByN290cDlmclo2d0s3Q2d2WjZqYnZ1TDUrRmZ4K2Jwdjg2V01k?=
 =?utf-8?B?NWxka0ZXejI4ODByTXUzNTM0L2JGV0QvWWs4ZnUxMUk5SHU5K2pIaXp6RmFZ?=
 =?utf-8?B?RFpXbmpaMWthaW02Nlk5UDc0dWl0Z3Nsa3JSK3Y2S1VaaktFdy9TNHBIbXp4?=
 =?utf-8?B?R2ZBQUdQaTM1RTd6U04xTEpjZUpEVFhYN3ZXakgzMEtZM0s2cFNESFZwNlo4?=
 =?utf-8?B?eUxHQkQ1a3BSQlFIK0VBc3EyM3BhNGIrSFMyN1NlMzk4ZEtmNzE1WE5Zd045?=
 =?utf-8?B?bHdhMVBubEEraVdGV3RsQnZCODJhaUt0UmVZWWkyL3FvNG1BNUNQSzdJYXBE?=
 =?utf-8?B?ajdCV2JrZjlZUFpqb29rYmdRMXhoZDJUZ1ZLRTZyRVBIR3owcEhVdnp5RlZh?=
 =?utf-8?B?blIwcDNVN3BXR3FqRVVYVzNiemVZeUQvc0ZuU0dPckQrQlhxM0RvNVF2MDNo?=
 =?utf-8?B?K0tURUxpTjNHc2N1N3ZYb2pZaHI3a09yZENIb0RwY09Ja0JVSWEzalBxMDM2?=
 =?utf-8?B?NFFZRTVhWW1ScU8zQnVNbkZSb05MN2Z6eWtRUUFsWmw1cDA1WDA3MzFwSVNL?=
 =?utf-8?B?dlR1Qkd1Wkd6c2VBMDhYUTRkc3NzSmFxeTJ2ZVhNQ3pjcWVpQ1dWcG9WQkM3?=
 =?utf-8?B?c1ZFRDVEK0J3bzZHKzlYbERZM3BTZlhQME9WeEhXcjNaUzlBSWZ0a2pEbTRS?=
 =?utf-8?B?UWNyU0p2WWNhTWF0SWM1ZFY0MlNCUGhtc0FYK0FXNjV5YkR5OHBhNEEwYjFT?=
 =?utf-8?B?UFk2dUIySndBZWVGVWhNdXN5TFY5aXRVbEF6R01IaEt0MVBYTGszdHYyVldE?=
 =?utf-8?B?MGxML2tyVE9QUTVDS3dBWkg1bjVxRkVxZGtZcktOV2RRZ2tqdHR1NmRuTG00?=
 =?utf-8?B?cVRhbnpwakJTaTc4enpRNnQwaVRlVDEwcWtWRTFvb1FZRk9SQWk5UGd2YzBr?=
 =?utf-8?B?OHB3dEU4RXZJMnlRQ2hia05Ub1Z6bzAveStJaXdHZ3lxTjRTTFlyYUk3d0di?=
 =?utf-8?B?TCttNzdUM2xEV0R1aC9lUGhsNHpkUWM0VHRrV2FrRGxSbkRla1JHM0kzdW9t?=
 =?utf-8?B?UlVDSC9vTU50NUxWVmpTVDlOOEhVL2t2UytrMUpKY29uUG00M05RVXRCVWhD?=
 =?utf-8?B?cEhyNHNjSXdXTjBVcXdpQ3dwSk45dlZ2aXU5aUlPMjRuK3pQZmhISlpFQlNT?=
 =?utf-8?B?aEw5RzJTRzRLeEd5QTUrM3REUGllcjJXWEM1LzFiQ1BpUU5GbE52QTBrbmhC?=
 =?utf-8?B?QmM5WTJpcS9GNW52SnV4dEJTbjBDU05GY2IzZFdBNnhRajhwT1g5Z3ZoWTU5?=
 =?utf-8?Q?4+Oa7xIOnTewV2B0MmNJEnyXg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e65e6b-949d-4483-2f38-08db3c56e5cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 19:40:12.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/zmmuHej3mIs+UIXlq0atJ8Zp8uxcq7qiKvOHZL7YgYKqpZfSNF2pHv6d9bTUqDP0Zbqx7r5G7W/2neTK1rxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jonathan,

On 4/13/23 11:08, Jonathan Cameron wrote:
> On Tue, 11 Apr 2023 13:02:58 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
>> logging. This is not currently possible if CXL is built as a loadable
>> module because cper_print_aer() depends on cper_mem_err_unpack() which
>> is not exported.
>>
>> Export cper_mem_err_unpack() to enable cper_print_aer() usage in
>> CXL and other loadable modules.
> 
> No problem with the export, but I'm struggling to see the path that needs it.
> Could you give a little more detail, perhaps a call path?
> 

The cper_print_aer() is used to log RCH dport AER errors. This is needed 
because the RCH dport AER errors are not handled directly by the AER port 
driver. I'll add these details to the patch.

Regards,
Terry

> Thanks,
> 
> Jonathan
> 
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: linux-efi@vger.kernel.org
>> ---
>>  drivers/firmware/efi/cper.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 35c37f667781..ff15e12160ae 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
>>  
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(cper_mem_err_unpack);
>>  
>>  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>>  	int len)
> 
