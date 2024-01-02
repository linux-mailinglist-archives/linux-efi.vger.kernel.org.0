Return-Path: <linux-efi+bounces-291-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6097821E7A
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D577B22258
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1714AAA;
	Tue,  2 Jan 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1+gM3uHr"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C261426C;
	Tue,  2 Jan 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVkbBua2ETyE3E31eiTinrK77pvweH4WkWPBUHc015zpKLlZuTOJXgEKE+bSDqbxH2Eb4lGW2iJD/6ccKIkabQw0boeSnpfmAVevqD4f+fIlANQzykRGzZvTwvkFsl54M1XDaQwOEJiKdzcBaDMiiVAUkp8WmRAqwr+rReZpkocQvD+8Om4eqXepqPwUMoJ+ih2IKtWfM1dkhpxKVM28/psA1f8hTx0dFND23Tqc2dy/z0lWk3z6QDaigAnieMcD8JyiFwTMUXztuzEKNixeVb0yZJ3v8qcunZlHzm8zbTDe4W/dc1y88Jm9qfAQBVb5rBwB/AwEEuO9Jdgfjpv8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuG9NPxbcGbUzzTUflCp7xrOjUbOtxdWUbzD1FCQKo0=;
 b=eBlpWf8yoQe3wOSxmKqhaCKycACUE8D2kL8XrjZg1asU6IyizhInZlUXZcgQOQpIO5xoIVh1SnpGYUtTJdxxvA2afRafCiCOoJBIdwM9DRy+ArdBIfEU57PvTRLl34lAgOXQ/oI3T7LjX9UbWMcim2mH3VDBUO4L28LtzBtrmIWhJdkMOxGNUKG5c7hSa1EDuuOiNN6xf/ZjmkLwW3sxby2Ea+rE6ynP98Wqz3rU5s8Cl2HhNTBzxYy0PkjSINRP57dXYKwtua7Z8hw04Th1t8lVVK3OmZd+OT+hpMp3m00EkddQ8IOkP9h/0NZb0vus5yCrwWOoE0htkIhuxJj02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuG9NPxbcGbUzzTUflCp7xrOjUbOtxdWUbzD1FCQKo0=;
 b=1+gM3uHr6pPfRP5M6KEvjwM3p07HZTkMCNNVvulTbnO9BwRBRYL565vB27D10QtTWw3LreUkkgi5M5eyzEWEXeP1+HNd4dUidhF+XN5PuOoHV/bKmbu7KVpki028Bue/1rjQ4uQPhoAc30K/m1O1DGgAiINT+M5wbi/xkOQsSnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Tue, 2 Jan
 2024 15:14:13 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 15:14:12 +0000
Subject: Re: [PATCH v5 9/9] cxl/pci: Register for and process CPER events
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <80a5515e-4eae-37b7-08c1-03573ec4e37c@amd.com>
Date: Tue, 2 Jan 2024 07:14:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df447c0-298c-4045-fb4a-08dc0ba57a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hu7ZbmZATMh+d83b43jq2qhYwnTXcex0SM/6zLswJFKUGyal0HxeGodTmnsdUoyi/20zbEuaQwwV5gq9uXLASgYU2KRwOqAYfUuuYaxqO8iLCN3UUrH3B7RsmN8LCx7AxVKnin0EBJgGSXtRaxmxppbger41kNLACXFGLR8bsvw2BMXxrCcLxdubgasKVHsn1D2fW1x3xNt9ApnmmM5xyL7ADTd4NPFk4+1IaX+QZaMx/b7+X3H7Fu+kqOmEKlz1DuV/71OIPlyUf5kcZ5bGPYBZKb8Ku/sBrzUHkdHS4zzxv76kZziDBQyuJ3D2mbMG+gDTzh50yzrBCOQCBEz+GhraTarugBzZFmRLc/Neux97t6fvu25G25/ZNwELa7JRl24oUGU60KL/mfGbYgX89mQHQ6jwfCpc8YLnMOKWMWJ/LuJqKorVPfs2qJrjt+k/pp3MiBeBa8KajY9XkwOdUQlHFiL3BVJ/Xix6RSwMmrQaYs3K3Zo5Nrpj93MIYgiToAeAlIvLOumZEKEL9FVSX86icU9M/7mi9gf1q0NoveVsuhONXSwkgTkwTemwGbkC4rxtnpWzFr41k+tL9ldA8r9FI5q1RFMGI3xtKAuYJYjSq1vCeq0yToPZICZPJBNznN2s2DDPRvH57aCFqkkmyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(31686004)(5660300002)(66946007)(4326008)(8676002)(8936002)(316002)(110136005)(66556008)(31696002)(54906003)(66476007)(41300700001)(86362001)(6486002)(53546011)(26005)(36756003)(2616005)(6512007)(966005)(6506007)(83380400001)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1h3dnU5dklKRHlQVTZEQ2Jpc1prcXUxdEIwdkpGOXNEcS9TeVB6eTRIdVNy?=
 =?utf-8?B?R3pHdDRNZDJnVC9qdVdHRXZ6cXh5Z28rQ3NNUCs2RWMwVDBqSldDcHBnRkdE?=
 =?utf-8?B?K1ZQME1zUjFTY0Joa2h5RGlLbm81ZnYzTUNqcWJwOXJEY0NQUGpzMjF0dnVT?=
 =?utf-8?B?V1BCZmRZY1RCUXdXVXRKVncwUFpuVHpsN2hxeXM0cnZHeitHQTdFMm1mQTJi?=
 =?utf-8?B?L3hBTUFRUjlQNnR3cXlFb21qMFBLKzlLNnNvZGZ0VlJtK1VpMk9uSG9rQity?=
 =?utf-8?B?ZEZiWkZ2czBESVV6b1pKMGhycFlDWDdsUWVaWFFaVERuRUptR0UrWHVXVE1Q?=
 =?utf-8?B?VDg1YVRwYTNDSzNaQ05yS1lCelF2eHNuQiszOUR0VmpBQ3ZVdHdHelZCd2th?=
 =?utf-8?B?ZWx3UHlUNGNrVkRzZk1lUENKUXdaMS9KTjl6d1pkVVdRN0ZtMVdVWTcwcUVJ?=
 =?utf-8?B?K2RiRUc4ZkUwUHNCTzhqUUxURGhwVitlUitEZVkvNjZXM25hS0lsamNENVpv?=
 =?utf-8?B?WllOWTA0RUowUXc5cFVpS0VDZjg1bGpNOUZ3V1gvWFZsVmdIN0oyUHE2S0FO?=
 =?utf-8?B?dUs1b081SkYrbVZQa1BhN1NVcGMzdXR4UlVQdnU4c2VacEJyOFpuZ1FmbGZN?=
 =?utf-8?B?ck1ndUxRNGlFaXRETSt4d1YwOXlDYzYxUkR1MUs1YlZkSGMwRVVaVUNUWU00?=
 =?utf-8?B?RlE2ZU02M1c0UUlaS1dGTVBjNEhyVS82ZFRyV0ptb0x4Y0NxSEovM3ZZZzdC?=
 =?utf-8?B?RXlsbUR3K2JTUDFpdDlZUXZNdld1TzU2cHNQTllqZ1ZxcEl4U1Z5R09PT29q?=
 =?utf-8?B?bWNjTUxqM2JCSUdoTVIyY3F4b1JmcHA4SHMvMFpXVkxuR3hPdG9LY3NkRXds?=
 =?utf-8?B?OERSdEEwVThVUzBNZENFZW5wTFlWNFpaVm8wL1V2NjRqMndkbURkbjZiTWYx?=
 =?utf-8?B?SVhNN3hDRHU2aHhPa0cxZWN1cVk5RmZSK1I3ckJSQktmYm9VZVVqcHFkb2Zl?=
 =?utf-8?B?NTRBN1YwSDRQQmNnT1p0TzZBakdITzRnbnc3REpWSHltd1ZBMlRPWTJvaDV1?=
 =?utf-8?B?cksrRFhDeTIrNENrZExKSTVUdnZ4VEEyNDk4d3lIY2hsd0hJaW90OXl5WmNm?=
 =?utf-8?B?TFI4c001OWR2N25aYmp5Wk5PeWxlMzNZQ1RyQkErdXk4bGZPMFpKMS9GSWxW?=
 =?utf-8?B?SFRrY1ZRNGRjcU9tY0s2UzZKbVpWZXYxQnRGR0Z2OVlzckN2STcrTUJ6OVNh?=
 =?utf-8?B?S01vaWtLV25NZDg1YW9DVnNmWDIzc1RKdVlRMGFFQW9vMEVWUllNeUh6c09h?=
 =?utf-8?B?MU5uZEU2QmlLQmo4Tm5ySzVzQ05OTEVPOFBnTDMyWEJuK0xLSEt5U3Zscm9J?=
 =?utf-8?B?OEszNm9yelRhdVZtZGRPMFBQbkJ6b0crYy93WGJiK1NWdk41UmRVWXk1WjEy?=
 =?utf-8?B?S2xDSllNVDVvdkY1R2JTUkl1ZVVseThlZ3BuSWY3dXlZS20yK0czK0lZNWRj?=
 =?utf-8?B?UlNtODkxUkF0ZXpvczRvOU9ua3VMSDd3MzZLNlFPQW9wY1VCVXF1WStNWEtE?=
 =?utf-8?B?aDBoSXI3bVNSWER2b3lBdVMveXhDb0d0bitQbXRvRDUwMGRGQWhXMldLSzBo?=
 =?utf-8?B?RGtneVJEVVVzZm9zRis5ekpnczMyakJzMlJLYnpoYUhQTDVhRWx5cGhqRUF4?=
 =?utf-8?B?LzRqcXltcTcrci9nVjU0Ukl0Uk5XZTcwc3RaTU9FOE55S2hQaUxuTkI2UVFh?=
 =?utf-8?B?YVdxdHA3ZjBxamtqdkF5RUQ1YWE5Y01jVFhCSTYzVWZtMmkrbTRrRndEakxL?=
 =?utf-8?B?ZWpJTkxDVXhONFluWTRvL3JOY1hUTStKcHpaY0NuRkR6M3ZNbDkra0dBOFpO?=
 =?utf-8?B?eEExU2Rhano4c3ZMUWx2b2tJbVRXbDQ3TVJCZHVwdVR0RkFIdkdDK1RrTW4y?=
 =?utf-8?B?VFlZMnhYNk5wazMwcEZrOC9EczRhT1V0NmoxYTVSdmpzV2R2M2k5M3NRQytq?=
 =?utf-8?B?N1dvOFk0THpxYmRrT3RFNEIxbHhFbGVUMHJUVGF3N0pRM2pmMDM4WE94ZlJm?=
 =?utf-8?B?eEFPdWJQRitOb0hlTHh4QjRWY2srejE1aEFSQmlLV1dtSjVzLzA1NGJOWlU3?=
 =?utf-8?Q?Co/GQ2z/b8OaN/7v/ET4ur3av?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df447c0-298c-4045-fb4a-08dc0ba57a0f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:14:12.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5Afd7HfpOHbQlFSUrx3gwCGygn4auo6jhFZKH28FzuY5h2B9JWUR2EQA3cApbekI+UF36IJcZNbHPFLPZS23w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

Hi Ira,

I tested these patches. It works as expected.

Tested-by: Smita-Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Smita-Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Since, the trace support for FW-First Protocol errors are missing I 
wrote a patch for it. I reused the existing registered callback 
cxl_cper_callback making some changes to it. Please take a look and let 
me know what you think. I'm not sure if its appropriate to reuse the 
existing callback or define a new one..

https://lore.kernel.org/linux-cxl/20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com/T/#t

Thanks,
Smita

On 12/20/2023 4:17 PM, Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> 
> CPER records contain Bus, Device, Function information which can be used
> to identify the PCI device which is sending the event.
> 
> Change the PCI driver registration to include registration of a CXL
> CPER callback to process events through the trace subsystem.
> 
> Use new scoped based management to simplify the handling of the PCI
> device object.
> 
> NOTE this patch depends on Dan's addition of a device guard[1].
> 
> [1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/
> 
> ---
> Changes for v5:
> [Smita/djbw: trace a generic UUID if the type is unknown]
> [Jonathan: clean up pci and device state error handling]
> [iweiny: consolidate the trace function]
> ---
>   drivers/cxl/core/mbox.c   | 49 ++++++++++++++++++++++++++++-----------
>   drivers/cxl/cxlmem.h      |  4 ++++
>   drivers/cxl/pci.c         | 58 ++++++++++++++++++++++++++++++++++++++++++++++-
>   include/linux/cxl-event.h |  1 +
>   4 files changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 06957696247b..b801faaccd45 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -836,21 +836,44 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>   
> -static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				   enum cxl_event_log_type type,
> -				   struct cxl_event_record_raw *record)
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    const uuid_t *uuid, union cxl_event *evt)
>   {
> -	union cxl_event *evt = &record->event;
> -	uuid_t *id = &record->id;
> -
> -	if (uuid_equal(id, &CXL_EVENT_GEN_MEDIA_UUID))
> +	switch (event_type) {
> +	case CXL_CPER_EVENT_GEN_MEDIA:
>   		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (uuid_equal(id, &CXL_EVENT_DRAM_UUID))
> +		break;
> +	case CXL_CPER_EVENT_DRAM:
>   		trace_cxl_dram(cxlmd, type, &evt->dram);
> -	else if (uuid_equal(id, &CXL_EVENT_MEM_MODULE_UUID))
> +		break;
> +	case CXL_CPER_EVENT_MEM_MODULE:
>   		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> -	else
> -		trace_cxl_generic_event(cxlmd, type, id, &evt->generic);
> +		break;
> +	case CXL_CPER_EVENT_GENERIC:
> +	default:
> +		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +
> +static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +				     enum cxl_event_log_type type,
> +				     struct cxl_event_record_raw *record)
> +{
> +	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
> +	const uuid_t *uuid = &record->id;
> +
> +	if (uuid_equal(uuid, &CXL_EVENT_GEN_MEDIA_UUID))
> +		ev_type = CXL_CPER_EVENT_GEN_MEDIA;
> +	else if (uuid_equal(uuid, &CXL_EVENT_DRAM_UUID))
> +		ev_type = CXL_CPER_EVENT_DRAM;
> +	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
> +		ev_type = CXL_CPER_EVENT_MEM_MODULE;
> +
> +	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>   }
>   
>   static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -961,8 +984,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   			break;
>   
>   		for (i = 0; i < nr_rec; i++)
> -			cxl_event_trace_record(cxlmd, type,
> -					       &payload->records[i]);
> +			__cxl_event_trace_record(cxlmd, type,
> +						 &payload->records[i]);
>   
>   		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>   			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e5d770e26e02..80076c235073 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -802,6 +802,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   				  unsigned long *cmds);
>   void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    const uuid_t *uuid, union cxl_event *evt);
>   int cxl_set_timestamp(struct cxl_memdev_state *mds);
>   int cxl_poison_state_init(struct cxl_memdev_state *mds);
>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..b14237f824cf 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/moduleparam.h>
>   #include <linux/module.h>
> @@ -969,6 +970,61 @@ static struct pci_driver cxl_pci_driver = {
>   	},
>   };
>   
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static void cxl_cper_event_call(enum cxl_event_type ev_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	enum cxl_event_log_type log_type;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +	u32 hdr_flags;
> +
> +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> +					   device_id->bus_num, devfn);
> +	if (!pdev)
> +		return;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
> +			       &uuid_null, &rec->event);
> +}
> +
> +static int __init cxl_pci_driver_init(void)
> +{
> +	int rc;
> +
> +	rc = pci_register_driver(&cxl_pci_driver);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_cper_register_callback(cxl_cper_event_call);
> +	if (rc)
> +		pci_unregister_driver(&cxl_pci_driver);
> +
> +	return rc;
> +}
> +
> +static void __exit cxl_pci_driver_exit(void)
> +{
> +	cxl_cper_unregister_callback(cxl_cper_event_call);
> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +
> +module_init(cxl_pci_driver_init);
> +module_exit(cxl_pci_driver_exit);
>   MODULE_LICENSE("GPL v2");
> -module_pci_driver(cxl_pci_driver);
>   MODULE_IMPORT_NS(CXL);
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 71e3646f7569..17eadee819b6 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -109,6 +109,7 @@ struct cxl_event_record_raw {
>   } __packed;
>   
>   enum cxl_event_type {
> +	CXL_CPER_EVENT_GENERIC,
>   	CXL_CPER_EVENT_GEN_MEDIA,
>   	CXL_CPER_EVENT_DRAM,
>   	CXL_CPER_EVENT_MEM_MODULE,
> 

