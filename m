Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734297DFD90
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 01:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjKCAcQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Nov 2023 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKCAcP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Nov 2023 20:32:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04911136;
        Thu,  2 Nov 2023 17:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHasY7AHnl+oen+KFb7/Tk9l1jz3IRBfyBoBbE1KYQnAqgGzsTUazAeJWqTVZ9g9rOLnJkoqX4y4W2AAEmQ9uZ8bSxsw2O+Qmv+lfzWWXDkpjp+L5Y1Ed7jx1EQU3v/P3bJqSY0vXminrN8F0rpXA+VZMVV/tl9lKJCQsJ1ijQkA5WL7L3VfJtYkWtke+bJanYNPDsTy3qrtioP/0REXCiV/w9wAs5IxJh2MxUsMWMh+YigtPu+SYaQBgRB2RpZ0gyP+pJ+KLmvLbQ/nTn0j7F7HvrXm9SDx2jvZvMtJX2Yf38Oikknk3Ea5rsMU5U/Qee2EFPgV7qxTuoXZE1MwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm8mwatYWdCWZxGWADK8FveDRnVpPUQApw1JTBDZIXY=;
 b=jm4vZmQHWq4hZjvbICrd5VXXVggNzT2n3DgqHYFo4QCSAX8LX0NbC46ijI9EHApCwd6sm1BKwPEV5AEpu5rwcNQqpGWKmdXD5MjQbro33ZIhIIEgyvdMi0WgkqW+ih8uQPaULB6dg3CdVjyOmEKstdoVloWZ8PTQ9PsIPB4vARq8tLoxW5+qLnoqfgZxHQTWqisHeuosrOB7Q6GKkdl7OApK2M9K/6yVzi/nJBTY9agY4rejn+7YzCG/5dtLxWFDRs26ol0Lyq5YgQq8XDHfUl4NpfEgXLxkOXXZBAZ8E3Lro/Cp4c9ljRQLxyAvNwASaj2tb2EzLRkQJChY7oKGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm8mwatYWdCWZxGWADK8FveDRnVpPUQApw1JTBDZIXY=;
 b=i3AelLfyVY1otWedRZngklAv4DlyC4RVCYJP97w+y+xexBbEVquBWtkRLL24r6n33ghrT2y7hYvlA0ImGCbzV96v0DBgVbuyMJ+m8OvPDzAv4/S2IXgLZi27udEVKqHzPdeswhcM5VgPGXsDX3Na1vMKtXDtMjuRZ4uAF4Yv3/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 00:32:07 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c%4]) with mapi id 15.20.6933.026; Fri, 3 Nov 2023
 00:32:07 +0000
Message-ID: <d286ae7d-ea83-af3e-7df1-8ad83fdbdc57@amd.com>
Date:   Thu, 2 Nov 2023 17:32:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC v3 6/6] cxl/memdev: Register for and process CPER
 events
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
 <20230601-cxl-cper-v3-6-0189d61f7956@intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230601-cxl-cper-v3-6-0189d61f7956@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:40::22) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1e1a34-ab5a-4e1d-d3d7-08dbdc044f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60W4UQhIAWOHQcViS7Qz82YGiy0FqBPamV/YqvYGDz7uKpUWld1yTtK4Ev4M8dhoc88Xl27sJMrSMLnXKWCaHVHKh1cXLXFUHnF1wv5MZUV8FtvqwOqZ5Vqf/q7EuyzhOw60lbGFmnBR+fSaX31Pvdn5hktKfdmBZGq8j8o2zzfSQJuGyQULEv0E1AxnWJ9x7HxJNfRc2ThvtmGau+VCeXtxlXr8MP35qtAwQeEbuuAXzuLj6friCPI4cjOipQPiLr5mnD509ejvmuvgHzcwIz9CkhUU9r4Nm9nIN8j4cU3T9ylgBVEWzU8vaO+mYj1p3GhT65YRWn+7ntlNxH/NW9up+Lg69Y230/ngo672tCVLOdzgqreTcNbBNlNUgkkihKSXsUuEGxZfUeG686788sAKXF4GaUl2PTAtccEJoPM/4B1ErvTryGPNr70eJeSHTZDcO9+aNIqydnDCgr+1e8LTVbz45UzRGtziK4JRPSmny6uE4qH0ziRybW6JF86EBKNlE3wvtS8fxGAct8eH1ChHmljoLrANvgLyea9b9NH1wX6xKiw+5mq2s16MNdrjODtynqOje4lnJ9MHB3ZAW92vOBGjwa7f0PHd+zczwYZbF5L7z0PWVlrNam3pVugCLHJ0fm6HyubrEYtqdlriTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(41300700001)(7416002)(36756003)(2906002)(5660300002)(26005)(2616005)(83380400001)(53546011)(6506007)(6512007)(31686004)(31696002)(38100700002)(86362001)(6486002)(54906003)(66946007)(66556008)(66476007)(110136005)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlSb2x1bTVPYi9lVHdrNFZKQzV2QUpRanJBYzkrRnJEajNiQlNnVEFQem1J?=
 =?utf-8?B?bzZHd3VwcnhBRE13dU5iUEhTcEVMdWFXSzdhb0V5dmFLRVZJa2thVlVuMmJp?=
 =?utf-8?B?VCtaUzBkRTdJR2kwazkveHlkeXFDeVVLUHhLbnNJZ2VOVHRPb0dWZlZKemxM?=
 =?utf-8?B?UGk3VTltYlh3SGV3RDZNRFBKMHpEQVdzQVkrOUU0TnNEM29HVmtZNGJ0Rjdw?=
 =?utf-8?B?amlRRFVQYW5QMU91K3h2SzYzYlFsT244MGpPcGMvcGt6ZHl3bkdrTzZkUkNJ?=
 =?utf-8?B?ZHNNWmFZMDZST3dHN2xEclJzYXdmRW5qVVVpb1JEVnZqNWJWNWQvUE9ncnVs?=
 =?utf-8?B?ZVhuTmhFNnMrMW1QTTlwNVZrYlBva21rai9PQnc2cVpPUmtsS2NLZm1wNDFC?=
 =?utf-8?B?aHcxMFVFNDVaNjlhMFFjN1RGV1dtZTdSeU12cndZNktxOFR1bldVNnFWeXNw?=
 =?utf-8?B?OTRiQnZsVVgxUy9iZ24vN1ZqRTQxU2R5TFdWVkZRSzgyTVpvd2tkN0NmY3B0?=
 =?utf-8?B?VUNhaUdWVy9pUEpJeThlN2U0QmR4WTZrZjhQek5FUHBsdG9XVERidjdiMnA5?=
 =?utf-8?B?TzdVcnRYWm1VUU03dEp6VTdHVzNYSFB5RFNGczZCK3pzdHVUVEhNRnF0U2Y2?=
 =?utf-8?B?RGNja2RGWlF2MDBYRk1ZSHJpWkM5TnRYMmxOdHRTNWtJUDRqalVjeWZKL1pa?=
 =?utf-8?B?c0o3bUY3U0NVT1UwNDAza096a1JWU2VHYWlzcXV0cGJtU3ZoY21OQVMzdVFD?=
 =?utf-8?B?djIvSU9SWTY2a2FRY3d4ZzlWaS9OL0N4emxTY1Q2THlNY0hxdHdUOGw3SG9z?=
 =?utf-8?B?NHZ6QkUydm9RRGd5eEpkTFZZSUl5cXU0cEdvdmJzdnE2NVViQVVzMDVKYWIv?=
 =?utf-8?B?VVZmbjFyTkp3MEtmRUZtNlM5MHI3VVR0MjV0cnFVbXE5N1ozUHhGbUVhQnZX?=
 =?utf-8?B?cTlzeEQyK0VIWXNkVHd4WGJ0Y0NLRnFDVWRvSytHMHlzZEJTS2lzaENmMjRE?=
 =?utf-8?B?M2JNRVhteXZBVW4wTVJORk9JWk1mTGZ6VmNPNWRGRGFVMWFLVWljYXhvOXcw?=
 =?utf-8?B?aXlZTzkrWi9EcjRXVE9RZ2x1VDljaS9DR0RPT0pYeTlVWEZ6OGlKSHkzd05Y?=
 =?utf-8?B?b01BRTBYcm5YekxlVldwd1FySEVnbXgreXNoQTA4RG1WOXdPUnFZZTVOa01E?=
 =?utf-8?B?R3NhdUtNUkIxeGt2VEYrNjFBZG5SZHVYYlJLNkxmSlhCOHQzVGlaMVYwQlNt?=
 =?utf-8?B?eFpCOU9tU3VJTTdIbTI2d1RET3pUVVpCVm1PbjNUcjZYY1J1V2pUN3kxckVo?=
 =?utf-8?B?Qm1CcHNLS3FyQU9QMmd0aGZCMUxZV0E3WlNZaEpwcmpFbXRIUHBNNEJtRC9H?=
 =?utf-8?B?R25xdS9Ed0FoQ2ozQXlCRjhDc1VUa0NKMkU1YSsxeVdnNzdMU0VPQ0IvYWJk?=
 =?utf-8?B?Nk13NmFBVlRsTmFEU1BMZE9TZE1LdW1YVFpaOUNzOEFkM1NBMHdoaFZVejBt?=
 =?utf-8?B?V0NjcnhyemV2MTVwNFBjaFFRcHo0Q1hYUW8reHNaWXBrUG1ZYm8wV3hZTU8w?=
 =?utf-8?B?cXQ0aEdmOE9yYmZrWWJGTDNBWk5pOURyRHNUanpkQmN1QmRPNmZqcDcxeUt4?=
 =?utf-8?B?M0xnbEhCRzA1NnM5TzN0bnJXdTBYY0ZkSzFQZWZseUw0NVRrVE4waEd5alIy?=
 =?utf-8?B?Tk5oTDlxRnNicE9Pd0NjcG9RaTdROWFaWThhTW81RGEwY2hIaVcvMnpGVGFR?=
 =?utf-8?B?SE5wQVZVbTFiWmI2UUlmZmlmYU9kTG9HN0Q3RTdyaVQ1NGNTS2NVbENkeHMw?=
 =?utf-8?B?cXdsTUZ0SDZITjIralROS3lhN0w4ejF2Z3d3QWN5SjdDK21LQmNVemtYaVNS?=
 =?utf-8?B?TGNsb3dZUTJwRHI5NDBORk5xTVZ1aEYxZDhBVmpsS3puUUw2VnFMZmVjZ29K?=
 =?utf-8?B?eDhoTXpHUTJWTGpZdlZGU01lY0t4Z2RFaVpCQnhyeEJrbVdLUHBKS2RTaXFZ?=
 =?utf-8?B?djZWdXFqQ0VtcXduYnJCUzVDRXdpdXh3Q3c4L1RtK1B6SlQ4YVBYdFhuZ2dM?=
 =?utf-8?B?cEw3WEFHem5pY1FMNXRndDlpb3FjQWU3c3d1K3g5cmFGTlVjM25hTFV0TkM1?=
 =?utf-8?Q?fUG2jm3BAi8UrP4/7sk7QSc7/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1e1a34-ab5a-4e1d-d3d7-08dbdc044f78
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 00:32:07.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpqLftCRujq1ygidoAexXLtDUfCIwIQwyjG5/rO6wZWmv26LXUDLCKKEA847uch0usjgfNkVqNFKBbwenqljPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/1/2023 2:11 PM, Ira Weiny wrote:

[snip]

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 44a21ab7add5..37add91068c0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/moduleparam.h>
>   #include <linux/module.h>
> @@ -748,6 +749,60 @@ static bool cxl_event_int_is_fw(u8 setting)
>   	return mode == CXL_INT_FW;
>   }
>   
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static int cxl_cper_event_call(struct notifier_block *nb, unsigned long action,
> +			       void *data)
> +{
> +	struct cxl_cper_notifier_data *nd = data;
> +	struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
> +	enum cxl_event_log_type log_type;
> +	struct cxl_memdev_state *mds;
> +	struct cxl_dev_state *cxlds;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	u32 hdr_flags;
> +
> +	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
> +
> +	/* PCI_DEVFN() would require 2 extra bit shifts; skip those */
> +	devfn = (device_id->slot_num & 0xfff8) | (device_id->func_num & 0x07);

devfn = PCI_DEVFN(device_id->device_num, device_id->func_num) should 
also work correct?

> +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> +					   device_id->bus_num, devfn);
> +	cxlds = pci_get_drvdata(pdev);
> +	if (cxlds != &mds->cxlds) {

Do we need a error message here?

Thanks,
Smita

> +		pci_dev_put(pdev);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(nd->rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(mds->cxlds.cxlmd, log_type, nd->event_type,
> +			       &nd->rec->event);
> +	pci_dev_put(pdev);
> +	return NOTIFY_OK;
> +}
> +
> +static void cxl_unregister_cper_events(void *_mds)
> +{
> +	struct cxl_memdev_state *mds = _mds;
> +
> +	unregister_cxl_cper_notifier(&mds->cxl_cper_nb);
> +}
> +
> +static void register_cper_events(struct cxl_memdev_state *mds)
> +{
> +	mds->cxl_cper_nb.notifier_call = cxl_cper_event_call;
> +
> +	if (register_cxl_cper_notifier(&mds->cxl_cper_nb)) {
> +		dev_err(mds->cxlds.dev, "CPER registration failed\n");
> +		return;
> +	}
> +
> +	devm_add_action_or_reset(mds->cxlds.dev, cxl_unregister_cper_events, mds);
> +}
> +
>   static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   			    struct cxl_memdev_state *mds)
>   {
> @@ -758,8 +813,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   	 * When BIOS maintains CXL error reporting control, it will process
>   	 * event records.  Only one agent can do so.
>   	 */
> -	if (!host_bridge->native_cxl_error)
> +	if (!host_bridge->native_cxl_error) {
> +		register_cper_events(mds);
>   		return 0;
> +	}
>   
>   	rc = cxl_mem_alloc_event_buf(mds);
>   	if (rc)
> 

