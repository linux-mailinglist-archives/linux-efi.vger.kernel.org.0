Return-Path: <linux-efi+bounces-307-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F42823609
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 21:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617221C243F1
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33FE1CFAF;
	Wed,  3 Jan 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="csZQ54bi"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B91CFA0;
	Wed,  3 Jan 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFjStIDMCFIV5eNSmzRgUogIrCbRkaVbkDFG7I/a6iyVQGW5mKEnuQ+WVJpP4WlTQ0bC6bzS+DdnnoIAjtJt1isQ9savr8tQ2bvIIiEmkGCrnV78+d86Hn2ZkwjcVzDo/4RVMCjcBN5crvUuBxNwWVWAztTfNPi075+0mw9VHHvCG9qT6nKRf0qDUoyOMCfd6wGqBkebiInwp0LZc8fekaF7E9wod573NEoe1d/xxvMtxVZoQjVFuEzp6dHJ+OkuVBSC0b4RHmZ2F4j8z1mg2brAjIjHDhrIlBLtUoxfZk3uFTM+EqP6Z7weQYZtF6vL9PWuxwvj7XJL/jlxp+8+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdl7JK343d1aJJwkxPY0cmhBsKm2s6MaB+xwXY8O6zM=;
 b=MdmngFAhhKoXhubvwv+uFYOXOv34TVgcEEZTInL95viGA1nk1z44AuSAksADDxUhIwPzfHtXc6PAGwwstLzKe2NAMqmDLXujxLmrkydQrc8w2qjdRq+O3C2Oga3+diSnYsO0nysM3N/GSMyy8WUAQ17aYdYcayPejKITyz43nY8RB6euHEIgWbC9RhzSJnVSjT+YuS6iRkyJdgAmruNMmXOGr40zjfCw1GgQC+o2EV7FYiP0wDazjL6sZJpnyy8BRX/hWoyvYBmtXx1oiiuHKwb66Xiyh2WP1VpC52xHLLuBYkdHwpVElibAumch1L2EnBvKmDzge13wmpp9h3H//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdl7JK343d1aJJwkxPY0cmhBsKm2s6MaB+xwXY8O6zM=;
 b=csZQ54biBdP/PcYI2Z7502qUHac1mOqdeBbLwhhyvl8o0rHJISZCR6PKrjy38lQqup4V8Vg8caJgg27cJe8Cj+OR8HCdC6rAbCkeWgDNVA8/cXpyP+w51x1aYnq8r3i4DI9U+92syMEmNtaVnYcoDHMS6OQo5+DOR60asn/sX5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 20:04:05 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 20:04:04 +0000
Subject: Re: [PATCH 1/4] acpi/ghes, cxl: Create a common CXL struct to handle
 different CXL CPER records
To: Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-2-Smita.KoralahalliChannabasappa@amd.com>
 <6594387015431_151dc12949a@iweiny-mobl.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <321f2cd2-ec64-3def-857c-61c4054f8be2@amd.com>
Date: Wed, 3 Jan 2024 12:04:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6594387015431_151dc12949a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: f3247b33-51bb-4414-2a75-08dc0c9722e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YGEPiE8cb3g5CFpiKWGXS7AxxE3eHEezHkIMdB0+LI2MannpnKAdn+eyGcfj/8LP8glDI1y9JUY8X0N8nC0Zb4dYij8v+MSN1QIDySXJmSMAV7d3Fsdd6DrJjY0Ty0IUqmLJvIBYHioXWbvRYxBsY5E1Ck5ybyH1FO2pwOTHIAPtm8lDbAwMVPfPhhwQe4/DlTT6dBE73JXFOeFCoT90trA+0A/jLwdH3Qr1UC77+Ta8dRC3/FmlGNIA2fBF7suzIAbqhcXp8BuieT/6JNX+iUc1t783T/2MS35Q72TaOEJ6ca3dzKnT3oH0/ZAUisrE8iw8l+9Xyix5B2KEuVjH5JwTY9Ps/AJlh3mb9LH+U16wgR1d7jaANfUjMrjjZ9Ub/RKv0ky2irNCjg7OGd5ye5EZ0MOvdKAIJwoiba738BxtFuA5Z2eHX6UxbGqCEFnaFcmmevGilPJS9/+uQ1zppXkQ5Weaw2eMN4IZDXy1m9In4Ngajuv9ChjxN8nKm+g9kk0et8MGfk5gFTX8LHZvKGWDGTiJ9ebSFva6KYMg8pdsEJGm5U5cx+3K+Wkg0YoF3PCphXCO23uYTCZsi+X0LAZaa/Gie6vtkmfwblqHQuBfbXpKkhihv+5M6B5JKjPIOz8/JYESJjRXiNUbm/abjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(38100700002)(31696002)(86362001)(66946007)(36756003)(6512007)(53546011)(26005)(2616005)(54906003)(6486002)(5660300002)(66556008)(478600001)(2906002)(66476007)(316002)(6506007)(41300700001)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzJad1FaNDI4NndEam4rbUpKL2JRUEtidmEweTVRN09aZTJ1VGVhK0RNVTVH?=
 =?utf-8?B?YUhlWEVkVThXdnduOWs1MTF0TUNrbDZiU1g3NVFCekVXSHN0VnYvRlhjK3g0?=
 =?utf-8?B?cGFmQzVnbUJRTU45WFBtejhHRGZKUkhHbTdycXJ4elBKRzQ2cVhpcXduSHF4?=
 =?utf-8?B?R0dqdTJ5VUNxMmQrU3RndUN2R0t4YnUzanRIaWY0b3ZpZXpMVUJzNnZRMjRJ?=
 =?utf-8?B?NVJNU3ZHOUhIWm5oNHEzRmlpSERUdGh5aU1HWHh6WDRHdmhSdDNSTnRGQlZB?=
 =?utf-8?B?TUR4a2xLT2loeFl2aklTK1oreTM5KzExRDVrdmdOTG1ETHRSNGYvd0o0Tklj?=
 =?utf-8?B?YUJ4VnhpR2J3UmZTeGRqL2ZmdGUvOXhONUhCcXpycmdCQjRQeUZuOExiYXZw?=
 =?utf-8?B?ZTUyWEthdFhRdXh3NjVrNW1wazRKSW9aM3IyUDJJbXN6ZmRCeXU0OUNIVWJi?=
 =?utf-8?B?Z21SSk0zaVQ3c2RDTWtxbEJ2aGsvQ01sM2R4RVJUR0U0a09yU3BIc0YyQnpO?=
 =?utf-8?B?QWdDQXZ6UHRQcUNYWkVVTy8ydDR0alVlQ2dBV0twbUp5ODFqSzhqY052ZUJ0?=
 =?utf-8?B?WHU4NUtFaTNCaFJKYWpuQXNmZklQaGtaZXpGd3ZLNnJDUGxYUHdEWXBYcEhy?=
 =?utf-8?B?aUkzMmdLR0NwZDlzRFIweGxzeU1jM21nL2tZdjdIZVBsN3NXNXRTZ0ZlTEpM?=
 =?utf-8?B?S1hQK1BaZXk3VWcvMDBLUFo4cSsvU3lzaGFwSmw1cURNcFN3d2FtSEk1TnVY?=
 =?utf-8?B?ejVlUEd5U0hyTnJtdHF6WHFicm5GbEZYNWhBVEtWbnFwUzlJS0h3bzhBVVU0?=
 =?utf-8?B?Tms0YVVaL2NDNDdMOTdHZU9jeVV1YjZQdDNTZlpHalBhM1ZDTUVSRk9XcW5u?=
 =?utf-8?B?QVI3MTFMRUhlLzQ5WjU2cWNubmd3VmRtaElyaTBScGxsRXZwamNvdGFqTklZ?=
 =?utf-8?B?TENhQU1hU3IzZEhFemtZQjZxbnowcVB5c21nM1lOQzNZbW53c1Iwcnc4NGE3?=
 =?utf-8?B?NXJ0MUsreS8yL0Iyem5iZnIzUDdaQTVFUXByNWVNa0c2bHVjOGloUWxJT1NX?=
 =?utf-8?B?UFlQaUUxUkd6K2FXOU15bFFiRm1ZYlVuMGhteUo1R0JnUE9BeU9nbGRxYWdV?=
 =?utf-8?B?clFNQ0JIeEkwMllaSkh2SVgvb2RQRlJXam51ZlRkeGxLMFJpVjVSVy9Qa0NN?=
 =?utf-8?B?YjJadU1MZGs0bUtla2NrblFtS01NdStKRnVnMnYxMXhGc1BraGd4R1o5UVRk?=
 =?utf-8?B?b2w2UWRwL1B3cUx6YnprakwvNERTeEFKZEkxcCtlWVJIMVVScEFjdVZ4OFI0?=
 =?utf-8?B?TjdqS2lRMmNJWlBxUmtNeWRGSWVYdzZhNDhvODVOTGFYc0sxZjJIQUdXUWhI?=
 =?utf-8?B?QUdNanpUMkg0NVJYb2JtSnExNHlBanlIajYrbklzMnVKZys3eitBK3NQZnBY?=
 =?utf-8?B?Q0ZFT2NlQjdPVHkvRk8wK3VpZjFnUWVjcXdINlZWRnN1T0p3ODZvN2w4VmxT?=
 =?utf-8?B?NlllK0Zxb2xZS2tNWFdzbnZLSWRVWG9mcEk4MlNnQmhlQXNaNmQ2cldBSkl4?=
 =?utf-8?B?cDQ3cDU3WGxCOFdKVUFZVEJrS2tEMVVjUCtKaFJjTjJBNG1FbUp5ZDJRdVk4?=
 =?utf-8?B?cG8yQWo4alNNRTdhd2YwSXFhS0RWbFduMGJDZUdHcklLU2tGdHVmb2wvSDM5?=
 =?utf-8?B?dXhDWnQyaE5sUnhBSC9hZVZHeWdBZ25SaTVvc2psbHRwOUFGakg0WURSL1Fn?=
 =?utf-8?B?clhmTm9XQjk2RGJSZEk3anN2NkdQT0Vmb1BxNTV4bGFjZW1iY1JxcnRoTWZS?=
 =?utf-8?B?TnMzTGpHcXNWb1VnNjFSbVZBdHQ1aVBFN25palZPYi8zS0lBbFc0NHFyTUlY?=
 =?utf-8?B?d2lhdHZUNHlOV1ZhMVBqMU55VkFSQ1ViNFl2Vy90U3E5Y2tLZGtZVmNDYlhM?=
 =?utf-8?B?R21sbWJ5YkhvMC91MGhjSVFxZERaY015cnhWZGFHeWNteFNWaHhOZEpkWmJs?=
 =?utf-8?B?VUVMbDFyMkNhNU9CY3RwZ0V6WlZxSkx5dHJOTEZrRDFCSCtLNlR5T0d1eEl4?=
 =?utf-8?B?L3B0MVVYYk90dUQ5V0MvbHBrYldsd0pNYzgzWGR0SGdsV1kwWk1KQUV5eVlx?=
 =?utf-8?Q?oMcBAjjq1fUNLx142h0taYJg/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3247b33-51bb-4414-2a75-08dc0c9722e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:04:04.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruUCRuXUUlEr7zcPUytk1UVkHv9cOUKlobfxpDFzSkf4UsLTN/PcP0AokmfLIAlTvVX/N8xwgBH9i2NRCARmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

On 1/2/2024 8:23 AM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> Currently defined cxl_cper_callback interface between CXL subsystem and
>> GHES module is just confined to handling CXL Component errors only.
>>
>> Extend this callback to process CXL Protocol errors as well. Achieve
>> by defining a new struct cxl_cper_rec_data to include cxl_cper_event_rec
>> and other fields of CXL protocol errors which will be defined in future
>> patches.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> [snip]
> 
>>   
>>   static int __init cxl_pci_driver_init(void)
>> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
>> index 17eadee819b6..afa71ee0437c 100644
>> --- a/include/linux/cxl-event.h
>> +++ b/include/linux/cxl-event.h
>> @@ -141,8 +141,12 @@ struct cxl_cper_event_rec {
>>   	union cxl_event event;
>>   } __packed;
>>   
>> +struct cxl_cper_rec_data {
>> +	struct cxl_cper_event_rec rec;
> 
> NIT: I would call this something like event to distinguish it from other
> record data.

What do you think of the below?

struct cxl_cper_event_info {
	struct cxl_cper_event_rec rec;
	struct cxl_cper_prot_err {
		struct cxl_ras_capability_regs cxl_ras;
		int severity;
	} p_err;
};

Addressed changing to sub-struct and copying the struct rather than 
pointer comments in patch 3..

> 
> Other than that this seems reasonable to me.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> [snip]
> 

