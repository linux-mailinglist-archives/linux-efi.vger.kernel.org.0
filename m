Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C018B6E26AE
	for <lists+linux-efi@lfdr.de>; Fri, 14 Apr 2023 17:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjDNPSI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Apr 2023 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDNPSC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Apr 2023 11:18:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C27AAF2D;
        Fri, 14 Apr 2023 08:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtZPpPJpYd2Y0qAlBBBC46NZIHUUf/yRsWfYXaeWZnJBYJtOyGESDBs1sZ3wg+0LCwF0p13+h3ZNixoWeRnn58jJf/8AePEBFoGFe5h6vC7a1IwhN2nTeN1mMLbuV/hF8sL+pRjUpdE9beFRCT++t7MMlz+HzoMWBtJQt9k3GrpuDxZRIcqZIjQAeg6R6lx13FfDHMbTM3zPXH4pTXv6Q1ZDKwNg8EUKfzQtL4cTZex+Ch8GuiD/AqR9eBK8U0+hxapjHwVZaHTpq0IVg/aI4Q9FvMjNWGKTDhOPPzXjfpCUXln4u+0D6LiyzHPfHYgfzsNY4ksKG45prrHJ6APDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK3mbf1ba+HawRcXpyCTflh8P7Oo7VuXF0noBYkGU6Q=;
 b=H4RyefaEiDHUdGbdYZ6qrzDhTuOFPLDrpZVGy9N1bpRmKYWLDXcD1Vj5c4HZ+6mkXNhn03MiRLpEf5yPzp+F2ZKQn386pkLtmeO02z0Ase17sG9RPd8jOBwwMeTmkh9bVY2tGOS4Zsshhpu4LFAVp+FXMcYx0lsvQM3oeQHX7Y9/9CQAEvWoE1vYFRI62nZlzgTENvWss+3vfZsFJEAg4Xx/lrcx5hoHQXbTPfYeu0zp85aFr0Xl8J3l/EEYUwonBy0p8/DFy0PAxIBa51kuBokY0jajIDr9r0OpkoT5luX/buwzHGzfYVsLsq7lv3xNmJUctyRxdong4Azp59SpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK3mbf1ba+HawRcXpyCTflh8P7Oo7VuXF0noBYkGU6Q=;
 b=2wgn6WYXenFDQDAQ7X5cKGC5FCveCs/SiDjcQxGEFj2qSozciRIIwmjkkk9PDz4/kt970sy6IXDJW/lrxnv+Nneet+uRWej6q9cimTuunP+1tVuBJ9zKHfSuKkRmvTfY4VuBOXH5Xd1AEC8pwIOKtfa319O9HZ7peOmMKgG2SSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 15:17:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 15:17:54 +0000
Message-ID: <b6ca629e-f4d9-9f31-ecd7-6db6d53b8d55@amd.com>
Date:   Fri, 14 Apr 2023 10:17:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use by
 modules
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-3-terry.bowman@amd.com>
 <20230413170816.0000333b@Huawei.com>
 <9d66afdb-40bd-4254-547e-05f6481dd550@amd.com>
 <20230414124805.00000479@Huawei.com>
 <aba5d2ee-f451-145c-81c2-72595129483b@amd.com>
In-Reply-To: <aba5d2ee-f451-145c-81c2-72595129483b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e95e93-69f3-4b31-461a-08db3cfb6b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axDxAj6V1ncU4iI8dkoL8uFkqULxLviprGvix7SISyVVvicnlMLanBxGzleEIw0fCAnBboyn2TCjjpiZP+thmW3KEoMTbfQulQW/bsOAOVeRUSfAfKvhuaQNf7SKWoUiZCK3ZgsrF6i+qpDEdfz/L95jZ0ZqSFlHzHSjFwchCrQBM/129XZCXyUnT8AqXJ3pmeSP5laNmT8FV0kA71QRu4qNrsQ/xuXy8TYUfRFPFRtdRow8suLS8NgSod0zeGjsEC4Tb4tQGIyHG1ZX+EdKhwQcRTaRG1/IKgtujFzb66QWeuJiBovLuwB05SLbyQuaOYv+XKIjHX4gvwZ/B6oCOKj1zEaUrkJJDRooHktobdxAsfOB01elz+IwxNDsAQTfaXsb056fllw1rCQ96v5s7uhYacQkHakJCgIsM66Z13e3NY9F6l5HJligN1hZhYIVhj4MT5zqAGay19UIsFnxzybeE/OH/miJKQT5ZfO7obn+titr9d3gRLgXokqrcZSbM7HbUuGKOsoArG0CacW7SszVUoDhVb/d9MXz/HBUw9vDI26wtA3p0j8RQN4LBSkrGm3prLvt7xe015BXYHxhII7vdlbKpLevWVc4hN8DzjR1j67VjwVZcRtDHGPbaetR8TxcUznEtO0gh9cs4VQPaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(316002)(2616005)(6666004)(6486002)(4326008)(6916009)(41300700001)(478600001)(26005)(6506007)(6512007)(53546011)(186003)(66556008)(66476007)(66946007)(31686004)(5660300002)(8936002)(38100700002)(8676002)(2906002)(7416002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0V5cTJ6Q1c5R09JK1NadmNacWxEVERaaDBBSjZFdG1xRzRFT1M1dUU1cVp4?=
 =?utf-8?B?OTJoVU1SbDYvT0YwTFBYVnY2VG1vd1lBT0MySWdGSTJjVEJwa2JEYk00QjZ3?=
 =?utf-8?B?Tmg2RG0wQzdHdlVXeW5mOWZOTlZhVzh5M0RLS1kvV1NyVjYxcExhenB4K1JK?=
 =?utf-8?B?Nk5rdlNETGpsenVOcm10aGxWQkNRcmpDM3doallLd0dNRjNTRnpUQkhBMkI3?=
 =?utf-8?B?OVorL0Y1L1h0cTN4ay9NSTVzWlVRMmQ1R3EyV3lvTTFRL2NuSXIrUHBqc0dp?=
 =?utf-8?B?bGx6OFRlSEFxZ0ZrcnA4VEFBWVNVYUNrc1pDemJxZGpDTldjdTUyc1VVRU1z?=
 =?utf-8?B?dWRjU01sU3llY0M3TDZHaGVNMzVIM3ZpdVB0SENUc3lsWmsrTkxoZmFlL2x3?=
 =?utf-8?B?M1BWMlRJRWhOQ2dCRWhLMEN5d1ZnV1l6T3AyUkFNVStrcGhub3c4UzNSR29E?=
 =?utf-8?B?L0l0T2xETllOWEpvNlg2SHg3ekJ4NUoxOTR6WWZ3dGdQL2RYamg2ZUp2WmhH?=
 =?utf-8?B?V2VJM29ZQWxrbEVpcEFpblRzdUpUTTRsRXJBMjgwcXF2WldOUDIxanVzWnpO?=
 =?utf-8?B?alpVN1V6cndIT21mMmQ3bk1WdjAwaHFvSUVPWU5KVG0vb3ZMVDI2b1NYS25O?=
 =?utf-8?B?c3lRaVJDSEZDelBOa04vNEFlN1lWM1kxa3ZzdEdTZ25BSy9tRmFvR3l6MUFF?=
 =?utf-8?B?OGFySWFRdERHdG5hTHN2TTBYZy92U3JBa05EZC8zRHhySkxVa2xKTzg3dFU4?=
 =?utf-8?B?WlBFTmJQMXBrVU9XbnZQNGVwTHJndzhIRUp5QUZ1Mi9JOEdZeWZnZ2FjQi90?=
 =?utf-8?B?Sk9laUxNWmQ1STdCOEFOU2kzRE9LOXRja3E2ZGk5em5pZFQ4djNxMExqZTZz?=
 =?utf-8?B?M2MzODFCNDJUY040K2pkSkg1ZHZpQ1EzQUxJYWw0SGp1RHU3UWdRRXRQQk9V?=
 =?utf-8?B?anRaWjdvaFlBd3A0cTBlZ1VtcW1LeEx1Z3lKOEpaNlJvWktlNFpBazdOSTBG?=
 =?utf-8?B?cFh5Rmc5NHg4NkxNK2RkNnZTQmd3TkJYWmZKRHhFR0dIZytZS0N1eG1JczFI?=
 =?utf-8?B?cmNDS1lnUjlURzZ0d2RvMlVEMmI4MHZaRU95WXI0Zy9zSjBMaUFUelprRm9w?=
 =?utf-8?B?VGkzakFnTUtoZFM3TkM3aEVEdUVQelNsampJODh1Q3BqZkVVdGw0cEFQcTMr?=
 =?utf-8?B?WnNQbWpPc01neEZnaHBDbStKV1JFVXYzYWZ0VlRqQTRDT3AwMENJRVlkcjkw?=
 =?utf-8?B?Mk9aaVBXN01pN1RXR1p3Y093Q01ZNTlNMlVzY1JCZ1Z2VDUyNWlsVDV5Wm5C?=
 =?utf-8?B?OXgzZlFjeUwyZWFNWWd2SE42Wi9CMndoSm9CcXFrRUtPZWkwNTRBMnZURElw?=
 =?utf-8?B?S2IvMzB2b2lrbW1GSnRYSWZXWnBOVHV0VW1MNkI3bUZjVnB6VmxiRDhYMG9N?=
 =?utf-8?B?Yjg3YkVIMzJBZ3M3dHlMLzZWeFZJRno2Z3dBV2N5cTZRTGNzejkzZlRvN1Rr?=
 =?utf-8?B?Z2lNTEwzeFRIMk9IWVI5ZXRyMUFmT3UzY2c5TTJCT2ZhcDZuYTRmdldVUkEw?=
 =?utf-8?B?eis3cVorUlJTaDlVMzQzeHh6ZkhWSGJQdTBuNk9IdkhqNEhNTDhrUXl6Y0Nv?=
 =?utf-8?B?WE96OWdoRFBKeGNzM2lCSnc5bnRsUm9TYmdIZHI0NXpmY0ZqYmptbW9xckgw?=
 =?utf-8?B?RDEvbnN0WGcwRzJ2bDBFcjJzM2NRZ3RjYkhqKzE5YkN4WThwTFk0RlVWS1BP?=
 =?utf-8?B?b09zZDA4WDI4eXlRYkxZQWhYcjY2NEpKcVFCTjVWaVlzakE0VzQrSkVTeEpL?=
 =?utf-8?B?eTFINExYOHNVTzdJdUlUMFEvNXJHZWRiY1F1RUFLQ2Jvd2IxVjNEYmJ0Nkx1?=
 =?utf-8?B?cmFEL1RlTEozQjA2SnRUUlFrR1FrTkE1VnoyRlpXdHA5dG5hamQwZGFYbzFD?=
 =?utf-8?B?alRHNjl1c1dsRjJ4cmEzbjYrU05zT2pHNGRWemlSSzN4aGVuYzdkMDhyY1NE?=
 =?utf-8?B?MEl2QnZvazl2VDVROXY2WHlnNEFzWHZ0c0hZMWZ2RGNFQlVmUngyWmk0dkpL?=
 =?utf-8?B?MDc0UERsb1ZRSjRoeHZtZjFwVkExNlcxZzQ3RlAzTGlwTkFNMzFkRmRVVFNK?=
 =?utf-8?Q?QPtKUH+8wrK7m36EZl2IIjbSZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e95e93-69f3-4b31-461a-08db3cfb6b9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:17:54.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjR5a6kB71tkue6jLAzqgfCSlCM+4IL63/7ktKhEyrhKkx6iXeHIB0BoWONGqakF0uDICEy97eSD6iwb/OA84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 4/14/23 08:24, Terry Bowman wrote:
> 
> 
> On 4/14/23 06:48, Jonathan Cameron wrote:
>> On Thu, 13 Apr 2023 14:40:10 -0500
>> Terry Bowman <Terry.Bowman@amd.com> wrote:
>>
>>> Hi Jonathan,
>>>
>>> On 4/13/23 11:08, Jonathan Cameron wrote:
>>>> On Tue, 11 Apr 2023 13:02:58 -0500
>>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>>   
>>>>> The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
>>>>> logging. This is not currently possible if CXL is built as a loadable
>>>>> module because cper_print_aer() depends on cper_mem_err_unpack() which
>>>>> is not exported.
>>>>>
>>>>> Export cper_mem_err_unpack() to enable cper_print_aer() usage in
>>>>> CXL and other loadable modules.  
>>>>
>>>> No problem with the export, but I'm struggling to see the path that needs it.
>>>> Could you give a little more detail, perhaps a call path?
>>>>   
>>>
>>> The cper_print_aer() is used to log RCH dport AER errors. This is needed 
>>> because the RCH dport AER errors are not handled directly by the AER port 
>>> driver. I'll add these details to the patch.
>>
>> Ah. I wasn't particularly clear.  cper_print_aer() is fine, but oddly
>> I'm not seeing where that results in a call to cper_mem_err_unpack()
>>
>> More than possible my grep skills are failing me!
>>
>> Jonathan
>>
> 
> I see. Without this patch, if include/ras/ras_event.h  cper_mem_err_unpack() 
> 
> We use 
> 
> 

Testing shows this patch is no longer needed. This patch was required for earlier
implementation calling the aer trace macros directly. I will remove this
patch in next patchset revision.

Regards,
Terry

>>>
>>> Regards,
>>> Terry
>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>>   
>>>>>
>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>> Cc: linux-efi@vger.kernel.org
>>>>> ---
>>>>>  drivers/firmware/efi/cper.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>>>>> index 35c37f667781..ff15e12160ae 100644
>>>>> --- a/drivers/firmware/efi/cper.c
>>>>> +++ b/drivers/firmware/efi/cper.c
>>>>> @@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
>>>>>  
>>>>>  	return ret;
>>>>>  }
>>>>> +EXPORT_SYMBOL_GPL(cper_mem_err_unpack);
>>>>>  
>>>>>  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>>>>>  	int len)  
>>>>   
>>
