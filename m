Return-Path: <linux-efi+bounces-308-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E482366A
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 21:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53301F25D7E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F481D53E;
	Wed,  3 Jan 2024 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhtjFRDN"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD841D529;
	Wed,  3 Jan 2024 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hROHD3hYxl5gc8DN8TQ3g5aM550Stj0tbYHLKWX3DpRdKIb9rFVXWkiUK6eR46O3+6hPOw8VKRht6OG8SouvTZ2l1kz5fTchA+LjqrwUysy6DB7oiLS158Ygt1R3ZDtyYyNFBwJD7eKhRBVRa9pRzZ/Zzp7sKW0UmI/7rDLxvK6ZHk5+6OLBGl7fJrXPA810NGy19wCAv2Z94uI+ezY4ad3klk++AK/O3v5sqkmaETbCayYgUxKgfQnGaKC2D+mWCs50W2S/fp5nKc16ih228gfnT1ewAUNyl88AnIwOe9ayVCB2H3xNFoP0P/hRaQm8iXJDkDzHybrKQh0Ar/P+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra27MRHJ8y1vAxVoHx+i2A3NjU3Yfmwlbwlhj0gZFiY=;
 b=fijAUrnAhOAqAl8JAN9PGiJOeEjLuFD260NxKnANEE0/sL1abSzIS/6lv2fW/v3oZz5FNR9z0hH/pmX3XN/N6/JMtjsOY10LgeU2W3IoWjDJykBgJv8zsZGT/O6EoXcNqiKl/Ymkck8qWaPmCP6Hk3LWO9hzSRLVQqoppVoGBc5sAcvwboHu0tu8k2LJjk4G8psHjXSoB0h6XC/M+tWC+7g3GkOphaKy1Y74f9yESmq9Clk006nkgCts0/L1Tp1AZeB9cD1ma47Ck7m7zIqUsrjD7rHrKaZoKeR19+a0wLRRLdQB2AMBYAhaS49DCWn1dWINuENYJ68BsuRwCYWVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra27MRHJ8y1vAxVoHx+i2A3NjU3Yfmwlbwlhj0gZFiY=;
 b=vhtjFRDNznphQNO58ILWf7PBve7QAqTXnVAH8uegP7DiJSeq4jfp2rplABohB3QZkgzPcrZib8hGmVoR7pbXI/1mU1kRPYVOpufzfORl3yB34VfY9oxrfoM31p7aMQ+rPZxs86vMki2KA0V1f1tJfuyWWbQdQdqCQA6y7tegyho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 20:16:45 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 20:16:45 +0000
Subject: Re: [PATCH 2/4] efi/cper, cxl: Make definitions and structures global
To: Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-3-Smita.KoralahalliChannabasappa@amd.com>
 <65943a1da3368_151dc1294c2@iweiny-mobl.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <e75e6c3a-c84e-a64c-d438-cae15d2e1f62@amd.com>
Date: Wed, 3 Jan 2024 12:16:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <65943a1da3368_151dc1294c2@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 937bc9e0-70a5-41a3-210e-08dc0c98e857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m939gpBqFzquD2JEKhl3ypf4/IZmhdooyVkltyK5pMtI10l+VyQlGJVWqsmEZ3zy9Fvr/1dxvCFaCvBGESKKdUac5tPfOGaTfQ6TI4RGip5VVUuLT7oZqVDYjz3SiROlcS5MFC+TIx21E3H74/bZbcfvRrLRnLrRrkTHOFXl9s6IhfFaptwf/32kqXdirq8FFqj/zliPK5cMugv1WGDFU5GBHK69lx2E6Ep1lCh8dlq3CVW4+aS4+FnzqKYTEpponL4AB8YoHi3GvAWnSm+B1YpPEF6g4R04jn/DynJQ0ORc3GKu1BsnpzmYkATkhicGDAwZIk9vuBEkURXlbN3km/g7jmAbptqYLrhU/bRnHlhH3lLhOullMHlq7wqdlIi/AyGOpM6lRCZqXR8cJp6WvqnENtwmztA+Zdz0m4MrrV0OGWzn9L0+1+UO0u3BLQpupcZPm+bcllu6HNPXswisozNhD7dT2S+4qgnN+rC6FZuxnqNuIdS7b06Ech9GpzFRQHlSciHMmEvdg0oajV93amvHLAS8ENtCWCNCwCB95qQcPZScvMsFm6mdAsfdpqQBolOMsp6X6nipoD5QVylOAFjpX4PFL6p+YkHB6aUmQ7cTSpwQlnTJQD5xpvAtvKkKqnxWNmTowmq/wF9gTDBjgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(36756003)(66946007)(6506007)(6486002)(53546011)(66556008)(6512007)(86362001)(31696002)(66476007)(38100700002)(41300700001)(2616005)(26005)(2906002)(4326008)(5660300002)(478600001)(966005)(8936002)(54906003)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG8xWjJraHcwVnM2dVJhazg4VzlEaGZmU1hPMHE3Smo4aGZ5ZmsvdTRkdFpp?=
 =?utf-8?B?a2JoOEV6bzViTWxtMlhvdG1WSVR5ZUVhZ2NOMUNRd0ZOQ3RmdFFYOG9sZjk1?=
 =?utf-8?B?L0pwc3hqWTMyd0kvRUZWaEdJWlljWUJZelhTaHZjODByYitwNnBteE0wRmZq?=
 =?utf-8?B?enc3eDdWYWVrVlhrd282N21nMERRYklxbm9FOEtUSWxBMG0zdFVRYUpza1Ev?=
 =?utf-8?B?Vzd5Yi9tZllWQlZvTUNKUXNYRmVTeTZ5ZmJhdkRMOEF1WktkanVucGs5dzRQ?=
 =?utf-8?B?RHN3VktPa2hKZ1JMT2hta2tUOHZpdlAzUC9QaXp1amNnMUpZNGJYc1c5dTZV?=
 =?utf-8?B?VW9UOC9FbXdJYjMwM2FJKzQvWURMUVZjSE82eGoxcEY5TUlGb0VsSXhYRDRs?=
 =?utf-8?B?ZnY4ZDdHcm5kWmJ5a0drcnNXZkRwUmNhR242S0tJSVhJMFJzVWJFL2ZGMHc1?=
 =?utf-8?B?QnliblRGK0RBRU03dnR4S1c1NVJMSFBUVDVaM3JWUUR3VDZkTWxVVzkxU0x5?=
 =?utf-8?B?TFlqb0JBOSs4L0FaenpLV09rOTZ2LzdiMHdMMG5tTDdzdnpjNUtibURPNTRm?=
 =?utf-8?B?SmhJdTdSTFpQbytzVmFhYlNBZHBqR0NNajlRTE9DNEZXUHJRTDQzSWRQUUw3?=
 =?utf-8?B?VTdYWEtkU1VWekV6NDd1THQzWktpSTV1WnlZRTd2aURVbnJhbFUxTkloYU14?=
 =?utf-8?B?MTE3aGRPUVlIU0VjczRQZk5FRG91cXVXdDQzSVJuQSszR2xwcWxxR253THRG?=
 =?utf-8?B?VWFENDFLN3FLUUFRNFYvc3QxcGptdGVaL0ZhekhTa3h5b0Y3b2RNTWF4UWU4?=
 =?utf-8?B?aXlGS0lMTkhncDRNa3RSNC8yK3RnMzVDcGhsSmVSaVZ0QUVBc3dJd3dPQ0VP?=
 =?utf-8?B?WlJ6bzBTQmwzSnBQU09nVGx3T05sTDFuR09PKzU1c0RUR2xlOEo5aFRHeDFr?=
 =?utf-8?B?cXlIbHgyWWxMKzk3L2I1TU56M29nNzhYcWpBSDFtbjBDWVZKTEh4Wjl4anVX?=
 =?utf-8?B?dWNFTUNycHp1aFRoK2VsODMyZ1k3M202YmNaVmRJcm1DQmdPTzIrVFZoS0g2?=
 =?utf-8?B?U3hkR1g0NmhwSThPV1JpUjZNNHBaMEdjdnAwU0dCb2xydzhFandoeC9YVTFV?=
 =?utf-8?B?MWxIcnJkZzJTQTZwRWFuUHlBMzZ4TUpSNE9vVVFscWQwRWdDay9tanNHYW9I?=
 =?utf-8?B?eThHSTVKWlNJVE9NRnR1dXR0L3ZrNkpZNHI0UGNFWkpQNXA4d3lTUFVDdUd6?=
 =?utf-8?B?bHNXWUZ2RjdYMzRUdGZjMnd4WUwrVWU4bHBta0F3NEdhekVYeXAwbkp1TXpu?=
 =?utf-8?B?b0RIQjBvNkZILzdIbWkyVEJxaDh5MHl4ZXowRktEbnFuTnNYRGNhOGNMT3VR?=
 =?utf-8?B?akJQZFZxV3UrdjlGVnBmc2g0dUUrWXRRZGZDZFlnQXU0OFlNdGlGMHZuTzQ3?=
 =?utf-8?B?RlphTDFNZmphenBPa2IrTHRVakJjZUV5YjZOTXdNOGhiYmtPTVhCeXhjbHpu?=
 =?utf-8?B?YXdRZit4enVtOTYxM0dHQXU1WndHR2JkVWNvclB0MTB0ZjRkZm02V1hrcW5O?=
 =?utf-8?B?TkVkcDlNc01TZmI0S2JaYWhyL0xlaktzeGdSS0hWelRBNkMxMjVmMDdUVG0v?=
 =?utf-8?B?NlhXTk12ckdHdFEvdTV6NVI4R0ZTNHBsS2w0b1doQ3B3UnJJbUdyRW9CSUN0?=
 =?utf-8?B?a0k2dFFRTStKMjFqc3NnNFQ3WXRtWVBRekZDZDFMZkRhaXhGS2pKa2liRFlm?=
 =?utf-8?B?OHZhRExtU3dYd2ptLzdWRVZOTDVLVGZlRjc2YkhRTVNNUUFkdHdSdnZvOHRQ?=
 =?utf-8?B?cG10eHhOV0RWNFdJMTFCOGlDSVVIbE1DajF5VzRIcWZyRWtUb1BSbTdwamU5?=
 =?utf-8?B?c0FiS1ZnK3FKT1dHSXB4eFViU2lHVFY4bFB0YlY2ZWtxT0tBalBLUE5tUzR6?=
 =?utf-8?B?RThtTG5sVFhrSVIxSjI0elNPNDA1VisxUEVCM0hmL2F6dXJwb3VRbmpyYitC?=
 =?utf-8?B?dWpsc1dnU2FrT2JrRUh4NFExZXZ5N3FGN0ZRK205OHNuK3Rya0VGOTEyeEhp?=
 =?utf-8?B?RjNhbG1tcXQ3NWJ6cU1yb2VWN2RTdXkyK1ZOZzJBRWRvdGJNUm9wMzhwMzRo?=
 =?utf-8?Q?EqJ4IH1dD6qNlLZF9/8kE6sIo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937bc9e0-70a5-41a3-210e-08dc0c98e857
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:16:45.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jySqtrIVXU9DRuUzJy2j1WOBs4tZ0E1ZsbkyBAhOiJudssk5khYZXR+Stl15q5kEhuoqBCXt7yLZa0wL78M5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

On 1/2/2024 8:30 AM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> In preparation to add tracepoint support, move protocol error UUID
>> definition to a common location and make CXL RAS capability struct
>> global for use across different modules.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> [snip]
> 
>> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
>> index 86bfcf7909ec..6f8c00495708 100644
>> --- a/drivers/firmware/efi/cper_cxl.h
>> +++ b/drivers/firmware/efi/cper_cxl.h
>> @@ -7,14 +7,11 @@
>>    * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>    */
>>   
>> +#include <linux/cxl-event.h>
>> +
>>   #ifndef LINUX_CPER_CXL_H
>>   #define LINUX_CPER_CXL_H
>>   
>> -/* CXL Protocol Error Section */
>> -#define CPER_SEC_CXL_PROT_ERR						\
>> -	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
>> -		  0x4B, 0x77, 0x10, 0x48)
>> -
>>   #pragma pack(1)
>>   
>>   /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
>> diff --git a/include/linux/cper.h b/include/linux/cper.h
>> index c1a7dc325121..2cbf0a93785a 100644
>> --- a/include/linux/cper.h
>> +++ b/include/linux/cper.h
>> @@ -89,6 +89,10 @@ enum {
>>   #define CPER_NOTIFY_DMAR						\
>>   	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
>>   		  0x72, 0x2D, 0xEB, 0x41)
>> +/* CXL Protocol Error Section */
>> +#define CPER_SEC_CXL_PROT_ERR						\
>> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
>> +		  0x4B, 0x77, 0x10, 0x48)
> 
> Is this shared with code outside of GHES?  I did not need my GUID defines
> outside of ghes.c and further becuase the events are defined as UUID's I
> chose to keep the GUID definition as local as possible to ghes.c.
> 
> Can you do the same with this define?

Actually, it is shared with efi/cper.
https://elixir.bootlin.com/linux/v6.7-rc8/source/drivers/firmware/efi/cper.c#L602

But this would be something to look into. Should we continue to support 
logging from efi/cper or just confine it to ghes..

If we just log it from ghes similar to component events, we might loose 
error records from RCH Downstream Port and other agent_types which do 
not log device_ids. Also, I'm not sure how useful are other fields in 
protocol error CPER, the ones like Capability struct and DVSEC len etc 
as the tracepoints doesn't log all of them.

Thanks,
Smita

> 
> The rest looks good,
> Ira
> 
> [snip]
> 

