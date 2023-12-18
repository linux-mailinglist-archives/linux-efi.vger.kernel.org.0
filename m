Return-Path: <linux-efi+bounces-237-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D00817977
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 19:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC241C21F20
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584005D723;
	Mon, 18 Dec 2023 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LYWkakQs"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2293A1A8;
	Mon, 18 Dec 2023 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmmEK8Sul4Mpegh6xy0NZeQqc4q0EDkgkWzkFtvhSkstDLeTEscb1zvPjkJ61JfNNKo6JKWU8AbS+L5Z4jYSVF58VGmpdGZhWWwPKslYw8/Ih/RZLpu9Mqo421oo7Iv/KriF9n31FKc+7OyZ5tsFyWT9AHALcBdNsy5+cu925vNeEZq8u8Zq/LrWSPNUhzfwrVoFoJLZ+z8v340+X66J5Z5TmZxNYiaJs64QSg3ajO23ddaIWHJ2Zv/uH573/NR/QzzEUlfX7Nczg2Xqs93bV8SXL8fBTd++Pl7qvdumwRn1RTMbmTlRJzQvA+A0HZAfe4/tLQNgpbL+P/f4Y3/cOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf1ysJkY53/5yMSMZ2n8+EpSN+yzCaWmz4ldnPB0NZI=;
 b=klvRZW9/1HKwVigWoiW3BfU5KK7ZyuRSvIpVQM7zSAthcohzGDhxkf3BhhjwmGd1YHt5JLymYKkUbiUnyAawwn1A4yvVW4+jhorDNK3wcS/TWYjQpshOVYlsbEUh3zjtf4B3nhYrV1506qtQDpvUEkoc8Rozt95NYQaX9hibKJMZ0yOyc909DGbOQVnUZbJXqqlZkR1/LSwwYgeflq+9dySL3653qxNXMqq9WPp/CpwMg++C+o3oztlXUkss2Cnvx1vX+91Cv6tid1ZbGWpR3xzqPtmhWoUEJwWJ4eh+7YmYlt8c/luiyl1OojpsRRaCKCUJfmZ26FFR4CYSYuUNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf1ysJkY53/5yMSMZ2n8+EpSN+yzCaWmz4ldnPB0NZI=;
 b=LYWkakQsW/UI5EboWI5gwC6hRdSF2VX3VroaAjamaAgXAl0mM+HEBe6zTKfMoVaIVEEMYGgd3pDAdmRcb/rizW3qzXwxQS9Hpe7NYOmtuHPbIyg6MyrYGXsJiFcyAuBDq2/QaqwfiSg45229RLW+RL65968GGZHnxjyCfF14Kyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 18:17:59 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 18:17:59 +0000
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <4cb5c275-566c-9414-7088-1e91378a409a@amd.com>
Date: Mon, 18 Dec 2023 10:17:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7c09cf-21e9-4b92-616e-08dbfff5aa5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dWCdpcyLj1Kv/Nygb2ev41Gc5fA7liw9WSci83fcJZatedpShCnCjh4AWNnOgXKnu6DmHruAtW5I/2LrQhVhEQZ9LfPb//ocdDLHS9nJQNp3tmhK1eBDTFy3AfaLJPfIwdvpvG7bPfXFpeEDnjAmTQnFeqgJ9nawX1Hg5cLTrlwGromaYsCa9hz2zFEWTEUarwqBh38V0yWpbJc/3EqlBaYvIDQOGRB7DGuggJEd15Qms5n5OvfmLq+3VbPlWfaJdc62tbo06DcD0SNkjGzY/VvuRnHItgdMA7HwM91JmHDOe4zJp3IlicckZBQ/RG9u/UiAAHWb2gVZltEhJmFB6KRsINBMoQcuevIOMO3qCaS/6eIlSWm9UddSv/BALRG0pIneRw7lVhRlHgSrqw4K0G8pHZKeEMnoX6/rcIld7nfq/zosmTpze63dycJy6013QiHplmkR/zdFbacxWWz4FHryENKeez3oJIa+OkrB4/bCaI/RoAggAfdPAkSKBfhKXJ63xNbyDzUJn1pZlb2I+RiPMX0AgfX252fHu8ie1iuwyelc5l6RwBkIELnVGmmurc+fRDiC1TNFr6+q/D+Gw1npenMo8/rQgIeKHnbKjhAOjIwOCFAHDg6TKejqbE4eQkOWPF0Mir1Ij4bjr0p6uA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(54906003)(8676002)(8936002)(478600001)(66476007)(66556008)(316002)(66946007)(4326008)(41300700001)(6486002)(110136005)(36756003)(31696002)(86362001)(7416002)(38100700002)(2616005)(2906002)(6512007)(53546011)(83380400001)(26005)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlJpY25EYnc2UTNHOU9lczBXdWl1eHgrUHdqNHBjUnI4L3NxbW1pYktFZ1RB?=
 =?utf-8?B?L0pVWGhPd25YZFlpV1dBTyt5YTJwcURtVVlKNTI0ZnpYeXc0M0E1eDJGWWo0?=
 =?utf-8?B?LzNMSzlLSTBVV3JTaUZqNmRZUmVZU0czMmJjcnhTbGVSeDBEYlRYT3lLeVZl?=
 =?utf-8?B?aXg2K1pQdERPaFluOWViTVhmNGx1eFpjY01mNUpFL2FmbVZvK01jYzN4SnZ2?=
 =?utf-8?B?L3B1ZnZlVFNPMmhPRmRpeXRmRW5QVnBncDVxZDlpMXpqbVNLSjJPbnFOeVdj?=
 =?utf-8?B?Zkd6c1BvektKOHk2cWhrQytZTXluZ1JyaG5KMVc2dnNNQ281SVRya3puaW51?=
 =?utf-8?B?L0Y2bkYwNmllbmxRRExrckdrR0pWU01xWUREWEdYcGtVWS9aVW11dDRaR2E3?=
 =?utf-8?B?SG42ZWYzS0wydkVlVGhpYzkwLzA1ZHZwVDlFRFcrKzhOVnlrcHZVbkYxTk04?=
 =?utf-8?B?MFhPNExZcUNOV01tQkNRRlRLNGxJbVh5NW4zSlRBNGlVbVo4OURNaWVram1y?=
 =?utf-8?B?RElpbm1GeHQ4Um1odVRzV0tMYzdsTGxOMkFpU2syZklWNWVrNy9TMEsrMmdP?=
 =?utf-8?B?SHdaU0xVTUZKS2pSbFI5Q3BYL0xQY2EzQ0ZkOFpOeG16UDJ6UlFZRTNkMHF4?=
 =?utf-8?B?UTdFYU1QQzJzL080NGN6dFpjY0hUWUxhZVNNYmdJNzNZRTRxNEVEVzdkY1Uy?=
 =?utf-8?B?YXdvaE9jOWFHamxhaWcrSm5kQUI3QlNxM2duY0JVVkluYm1iN3o1RjBObU91?=
 =?utf-8?B?bGpZSnN4S0pvYTczN0duT1gwaTJ3RmN3aUltY01Xa25neGRUeklRZDI1TVpJ?=
 =?utf-8?B?OGt2aTR6UjhyYTcxWWZySVE4RDhhaE5wSHl5OTlWdmRjM2FQeEZjYTc0UFJ6?=
 =?utf-8?B?K0dLMTZFc3RzOHBGZ1FLT01IRDdzQnVmSVJpd29BSFAyN25uRzVIV0kzVGcr?=
 =?utf-8?B?SXpRTmRrbU1sb3pnVUN4RVAxdi9MZFJzWG1UQ2tRZzVqTUtEUHdHMzd1Ykw4?=
 =?utf-8?B?Z25JZWlPS3pMZGwrWFViTjEyTUh5T2g0M0FNeFJYc0FzSGRlanRzVjJXeEZ4?=
 =?utf-8?B?TmhwWkpncnpzbUtnbVdZRjA5bnB3MlcxVjEwdkRmUHVYMlovNXdRM0o3cXYv?=
 =?utf-8?B?SDVQcTRKQndHU09RU1BJNm1tOUJuWGlYTUtkSlVkQ2VrcE9OdXgwVktEUGQz?=
 =?utf-8?B?ZllpcDRwQTRPTU9sbmhiUERSSWpWYTlPVlh2T1ovMFFCM0pFKzRxbEZHVG5w?=
 =?utf-8?B?VnRQMHRjRlo2Z0FISXJkTFprUEswZGJHV1dWQUpUYkZkUmlCMTdOZU5XZndk?=
 =?utf-8?B?TDlrcXFvdm03NndPeDJyT0FUSEExbE1tcUtnZXdOalRPUFkrS2lLNGRhdnJO?=
 =?utf-8?B?R0Q1REsvVERVd2pFOThlOW5qNUs4Z0JBUG9sS2N6U0UxMlJqUTJKNktVTkhu?=
 =?utf-8?B?NFhpcXowOTBJTnZpMW5ZR2RodG94RzVvTXcwS2wybGpITlhMZlYzYnI1R3Nu?=
 =?utf-8?B?eFJURDlWVVlPQlo5V0FJRys0T2thS2JGQUl6eUp4UzQySTR5UmRMZTdvNFF2?=
 =?utf-8?B?UVhBL0kxU25DczhLUjgrR0hFcFg0NWdVdkV4NjIwZ01GOGlrdHYyOVBRK3Ev?=
 =?utf-8?B?aHFPa3hYMHlScThRYy9mWTlRVTdoMUl1V0xrVHZQaEZtM2NRS3AzUXRsUS8w?=
 =?utf-8?B?aUl3cnREbXA4cDZNY29nYXNJeFNFd3VGWWo5UEpBVklYUGhFTm51SkNBYmdF?=
 =?utf-8?B?YVNNYkdHc3Y4WkZxODRTQVd3aytFbTBKNk5BemhWcFNmendhZHVQd2NydDNx?=
 =?utf-8?B?eUJZa282L3hEZDd5dml3VnorV2tWMSswVnZMQjk0UTA3aWNrb2FqV2Q1cDBK?=
 =?utf-8?B?enFHbTh3WnQyemovSktiMWd5RzVjR1lqUWkxV1VDZ2tWRTc0RWQxVk1qVExR?=
 =?utf-8?B?TVRBSXc1c0YyN1M2TTdDTWNweW9MdnBRSnBobHN5a1lkVU1NbjlSbTh3NkMr?=
 =?utf-8?B?clhid3FGSVVrSEVqQUdOL2Z3MEVoUzFiNmJUcG1Va1VVRWd3KzFKakhpMFll?=
 =?utf-8?B?NzAwcitHZTRZVGRjVm5LeXJFQ2ZKODJ0TEltTHBISThZWVAvQVdncGtYRDVn?=
 =?utf-8?Q?kuCbVrQo5wXxtCGjAWJCZ91GS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7c09cf-21e9-4b92-616e-08dbfff5aa5f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 18:17:59.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kt5qFfoyTq82k+h84zMI361vXF3Or/N9qOr3M0OvuQN8U1WUdLYhsCKgVQuZNCNgfVLCA/0IL7emmeiz2Vku6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

On 12/15/2023 3:26 PM, Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> 
> CPER records contain Bus, Device, Function information which can be used
> to identify the PCI device which is sending the event.
> 
> Change pci driver registration to include registration for a CXL CPER
> notifier to process the events through the trace subsystem.
> 
> Define and use scoped based management to simplify the handling of the
> pci device object.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---

[snip]


> +	switch (event_type) {
> +	case CXL_CPER_EVENT_GEN_MEDIA:
> +		trace_cxl_general_media(cxlmd, type, &gen_media_event_uuid,
> +					&event->gen_media);
> +		break;
> +	case CXL_CPER_EVENT_DRAM:
> +		trace_cxl_dram(cxlmd, type, &dram_event_uuid, &event->dram);
> +		break;
> +	case CXL_CPER_EVENT_MEM_MODULE:
> +		trace_cxl_memory_module(cxlmd, type, &mem_mod_event_uuid,
> +					&event->mem_module);
> +		break;
> +	}
> +}

Is default case needed here?

> +EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +
> +static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +				     enum cxl_event_log_type type,
> +				     struct cxl_event_record_raw *record)
>   {
>   	union cxl_event *evt = &record->event;
>   	uuid_t *id = &record->id;
> @@ -965,8 +986,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
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
> index e5d770e26e02..e7e9508fecac 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -802,6 +802,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   				  unsigned long *cmds);
>   void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    union cxl_event *event);
>   int cxl_set_timestamp(struct cxl_memdev_state *mds);
>   int cxl_poison_state_init(struct cxl_memdev_state *mds);
>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..638275569d63 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/moduleparam.h>
>   #include <linux/module.h>
> @@ -969,6 +970,58 @@ static struct pci_driver cxl_pci_driver = {
>   	},
>   };
>   
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static void cxl_cper_event_call(enum cxl_event_type ev_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	struct cxl_dev_state *cxlds = NULL;
> +	enum cxl_event_log_type log_type;
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
> +	if (pdev->driver == &cxl_pci_driver)
> +		cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type, &rec->event);

Currently, when I run this, I see two trace events printed. One from 
here, and another as a non_standard_event from ghes. I think both should 
be unified?

I remember Dan pointing out to me this when I sent decoding for protocol 
errors and its still pending on me for protocol errors.

Thanks,
Smita

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
> +	rc = cxl_cper_register_notifier(cxl_cper_event_call);
> +	if (rc)
> +		pci_unregister_driver(&cxl_pci_driver);
> +
> +	return rc;
> +}
> +
> +static void __exit cxl_pci_driver_exit(void)
> +{
> +	cxl_cper_unregister_notifier(cxl_cper_event_call);
> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +
> +module_init(cxl_pci_driver_init);
> +module_exit(cxl_pci_driver_exit);
>   MODULE_LICENSE("GPL v2");
> -module_pci_driver(cxl_pci_driver);
>   MODULE_IMPORT_NS(CXL);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768bc867..290d0a2651b2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
>   u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
>   struct pci_dev *pci_dev_get(struct pci_dev *dev);
>   void pci_dev_put(struct pci_dev *dev);
> +DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
>   void pci_remove_bus(struct pci_bus *b);
>   void pci_stop_and_remove_bus_device(struct pci_dev *dev);
>   void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
> @@ -1871,6 +1872,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
>   void pci_dev_lock(struct pci_dev *dev);
>   int pci_dev_trylock(struct pci_dev *dev);
>   void pci_dev_unlock(struct pci_dev *dev);
> +DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
>   
>   /*
>    * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
> 

