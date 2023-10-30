Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58037DC180
	for <lists+linux-efi@lfdr.de>; Mon, 30 Oct 2023 22:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjJ3VD3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Oct 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJ3VD2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Oct 2023 17:03:28 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE7DD;
        Mon, 30 Oct 2023 14:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xlydx+fPCFutwTiKfr6h8M8zdrHs3qoBNC7WKLikyWqoB9Xx8ishPWruot6evxBkLFVPzXKTxY9RXjEFSGH2vayRKyrltDrZGKDgGd0oylERmCV2N5FxZzoeaoQZNRzQfdHRqWeBJCPjza1RWgY8MSPgNlyMf0ByRz1xigd1J+a1kj3QJ50KTnABBs0w/sq/6Eq+FmFuc6jvsZb38kAaXdxkQZg09OkjkPHKnAgkp7pq9heOnQ7388ioTNWMx3DL1gfmThOZvUixYN6krShEiNN3MwJT5CxO7OUAcotboln+j4xCQZ4HUhRRrQASw5MPhzxk/cnLl9Rm3CQyJIo6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwuPd4A2CBDQalcWn2leepawRzmRD4mCeMUdHyIzrOQ=;
 b=gbwsYqjne1GoKtZ60rWs6RKVdzrwBCD8KlrLsIykv7XDgTLyJWZ5rr+X60EgAwZlaG3QPX/E8bZw62dkOgFS3Yf1iQP7c5804iWbGYONCn5v9QdsDUdFv9rg8uhRnw7OW/EoB6b14iW6oVjtFzzKsLkfDYMSHLIcEDrYASu/xRLyxYBK9fDmvKzabZb+ZoSP6WzA+14KJnl1vJUL2JPhP0jgGGqPO1UCHI4WXgAI0T1ilTK9MwMfuNuagH1RqXC5/MIEaENHivyiQHbKY3UkjdwRg51tDOHTjQ40szwQm9shm+aynENUdsG2smCJtoQUAwKDhy5NPgzSeKcHzkq7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwuPd4A2CBDQalcWn2leepawRzmRD4mCeMUdHyIzrOQ=;
 b=hnjUr7xOvzBS5YuhrzNKKIKyj2KrzfIniHr8Lgqq/pgad23wWUPSmsL3J2fRgldciK0lVHuYY9nzVXv8vlc58+O30swk4sQkTzNJaM2TPxqMtLFmpLAlR6BULkpMm3n7wATEMMPwgN30VXHX61zi9/Xw8y6uST09kNC7dXHvzIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 21:03:21 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c%4]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 21:03:21 +0000
Message-ID: <81b90308-fdb1-3686-33a3-1e7ec42a7ef8@amd.com>
Date:   Mon, 30 Oct 2023 14:03:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC v2 3/3] cxl/memdev: Register for and process CPER
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
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: d7740aa0-1fe7-46b3-1f01-08dbd98ba615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLi8PaP9OEscxwQpmmo4eouWryFk3uStxhOfatqCK5z0gbxOBni5LUv5KcVd8EN1CsnKlOy8qGy68y+ZHE0S3uUwmgNMzD6VbfB4SmLOLS0KBxCBuTAL2fNf31CVIQKq0lD2ksVIPlIKb5GremckEN64JjxkUMEDZtmK8EiHSuZNaie2xLxLUcndTvePidCQbOzLkATtS72X1ZadQ+1ek7Em46JGYTtYgAY4WrX9TJYHK/1Nt1HTvfZ8inzCqt7k1pp5VrC4Y4R1nufisf+twOYUasxdKUKowozkxH9Q8fg6Brn0SCNLEeXtMrKbfv8U9JhSUUMjcK2P/dC3ZbUsQ8roWeEBO42muNmNWxwvPikEkBfypRw6XG62o7obvWUs0ilx2R5i2SCV0ASdMr3ZH2tu50u34S6lQUNlF5Mve/QUx19Ln+zYpNDpwZb2MJ6lTJ2v90cQLfFktoHBNJ/3Re5aDU5mfdlCsGVki0e1fLM490d8MAJiBrb74/O0vGApRxs3JFaRSh7oogk+u7DlpFxiDbpmt/6R+uuRpvorCxsaKh8f0s2WbtyDk6e6zogX+9y/sJQ8eLHee8B83NIk1jdmHgK9iWS3rIHew3gCObpQhxt0XGnls/IGtuoqU4iYjIsBU+mKik0412we7ueLAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(2906002)(4326008)(8676002)(41300700001)(7416002)(5660300002)(2616005)(36756003)(26005)(53546011)(6512007)(6506007)(38100700002)(31686004)(54906003)(31696002)(66476007)(110136005)(316002)(478600001)(86362001)(66556008)(83380400001)(6486002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpkM0YyV2NYaG8rekNmelVKclFuc2xKZVgyVlZtYXlDZ1NRdnhWSEVIRjc3?=
 =?utf-8?B?a1pPeHV2SVZjdGJhMUlJK1ZJUzhmSXZoc2hDMkJNbm5sMjYzUEpxczNFVUhW?=
 =?utf-8?B?WVZmSitUSFNGWUV3R1VROFZBdHgvRlIyZThtdk9LUXdPY2FRL0lFdjZKTkVw?=
 =?utf-8?B?S25DZDJHZ0dYb0oyWW1NM0hTd2gxRzZLSWxlYU5hWGIwMjVNYmdCNEhMZUJh?=
 =?utf-8?B?cG12VWJkWXplOW9LazhSNkdxeUx4OGhSdnRtOXc5VmZuODdlT3B5bnI1V0Rl?=
 =?utf-8?B?RGlwUXB3djBGNGdvOUpsSmhYL3VDU21uMElJVWhFbTlpOUJqSkJmYXpvdjRz?=
 =?utf-8?B?TWRqVHRoZVF6dVRRMEwxUjhaTnh3eGoyQlhSMXc4Vlh1RjE4WTZ4c0tMbXlM?=
 =?utf-8?B?U084NkpMQ2ZoRWV1T2UwYXl4c2FXMXM4ZlhiUkhIZVpaTm5pVTFqdkpnSXFp?=
 =?utf-8?B?YkREbmpPb2c5ZUIrK2pOanFZdGZib0N1UWNldVpUQjhLNXBZL2QyR1dIZUE3?=
 =?utf-8?B?VHZ0amZLRWM1ODFMWmFMR2N2eVRRWU1uZDlJRDlmRHFUSGJZM1M0Y1k3dy91?=
 =?utf-8?B?eDJkRDUrUklyZURKOFVrWEFpZnZLVVBTRmJSVlhhbWQxUnJ3NmlSSHVqNWgx?=
 =?utf-8?B?L3JIbC8xaTV0ZytxM3dPRE5GSnc2VXFXeUphQzdvb3JXMnlINGVpK3pzNG9u?=
 =?utf-8?B?dHpZbGZFMUF6K3dvSkxTcERRSjVHYjVsc3l0emFOcUk4QWJYa2R2VERERXhF?=
 =?utf-8?B?d2V0YVVTc2Yyc1c1My9PaVZ6RGlqNjBaZ29Nc3RqaGNiRVNibkg0a2IyTWxH?=
 =?utf-8?B?OG9kWXBzQWQ5ZitFNnNzeXlvV0VzblRiM1lRb2N6VlNQeS9obk8vNDdxVCtL?=
 =?utf-8?B?WkpTTTJkQ0RRSlVFOXV6ZXBTVGZvL3VRaGxWSHdRNXpZMFlzUytvZ3JGaFRw?=
 =?utf-8?B?dU1NeHhQMytYNEJxL1dZSEN4UUZabGJkZjRRWFEzcUR3NGxHQ3REcnBNZzlL?=
 =?utf-8?B?VlhZcDcwSmkzRmRYN3k3RlMvQUNRK09PTHRUQ1dPVGNUQ0M1U3dmK1Z2NHN1?=
 =?utf-8?B?MFEvZkZwaDhpRmpBWHV4WHFRWmN2bytKaVVjWHdxY1BES0JPRUJmOFBmN0xR?=
 =?utf-8?B?ZWhRRjNhMnhOdGthZnlkN1BFVGxoZ3J2bkF2L2NPTlRFc1ZNcFVrNGRjYkRP?=
 =?utf-8?B?Mkt4TnhiaDNOMlJWbjJsTVlvOG1RZTJtaVFMVzg3YTVRdmNqVCthS3RzSktV?=
 =?utf-8?B?WlUvczBZSzZSTis0b29Db3JhamxWM3I2enNPSnFrQlZVbXg0VnpKRmlvQVla?=
 =?utf-8?B?RHdOMVZHRVBwcHhxR2NZVjZmN0tDZ090QnZleHduWGpRQ1J6L2JtYms4YVdu?=
 =?utf-8?B?MEY0dzJDWFp3K0h6bThiekpycGV5T2lJOUllQTJLczRacHp5QndVUjUyY1hV?=
 =?utf-8?B?MGFmZ2taclV1dHkwK1pFR0ZJcUZEOGEwT2ttRlZzcXQ1SDZyenc2aVowcUk4?=
 =?utf-8?B?Nmd2cWJQVU14LzRnWjR6UytrZHAva2dnSW85SVdqanN1ckJQYjgvWVo1RDR0?=
 =?utf-8?B?L3lGM1FhNDBGL2FCMWdiNVRGVVlBOU05c3o4WFpuSkRyK2JhbXdjQnFwc0Ix?=
 =?utf-8?B?QWEwdnh2UnhnR3RMNzFxNkVuQzV3M24yRFZpQVAzcThlNkNPaHBNa3Z1bmNT?=
 =?utf-8?B?VnRZSTZQbUlKOERuZlNDcUhpQ05qMEt5V08xS2krSUNMVWovZVVFR0Y5MHBB?=
 =?utf-8?B?b1VFWVI2cVNRNWQ1LzY4Ykt2bmkzYnh5VGNiYVhneVRnREdDRWVQOE9ERmpG?=
 =?utf-8?B?TGpleTd4MG00NVRiT2dXOXdpRkl2SEZIcm1XK0hxRGU2Q0didHhsV3VJZnVv?=
 =?utf-8?B?ViszSUFwNmVoanM5OENMVzlyQVVveWRSU0VTVUxHTnEyVGxRTExFVFRzVFND?=
 =?utf-8?B?QUdMUGUwWFdGWGVralNXUitTU2RnUnNyUHIvOEEva1R4QlFGbm1ESnNkYjFx?=
 =?utf-8?B?MWhtZVBkcVhrUHFaTk9peUYxeVJpZy9rSk4rR1ZORmdveHV5R2wzUW1KWFZZ?=
 =?utf-8?B?a2lIN0MzYllQQnFzSGhsV3FZa2lxTXgzdHdMcGpjS05KLy9TMDRocHY1UW9v?=
 =?utf-8?Q?kiKE6uCR9MiB1KLbKkVqU8afB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7740aa0-1fe7-46b3-1f01-08dbd98ba615
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:03:21.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07iEEwJ0mhkJUNtKHRiKFCRp2pDCNky8C4vpGoYvV6NRu6HAtioftBMK6A/bMs/IxcN/C0Yf9xi4x8LwjkFySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ira,

On 10/26/2023 11:21 AM, Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  Matching memory
> devices to the CPER records can be done via the serial number which is
> part of the CPER record header.
> 
> Detect firmware first, register a notifier callback for each memdev, and
> trace events when they match a device registered.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from RFC v1:
> [iweiny: adjust to cper_event enum instead of converting guids]
> ---
>   drivers/cxl/core/mbox.c | 45 +++++++++++++++++++++++++-------
>   drivers/cxl/cxlmem.h    |  7 +++++
>   drivers/cxl/pci.c       | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 110 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4df4f614f490..3f760d1d21de 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -860,26 +860,51 @@ static const uuid_t mem_mod_event_uuid =
>   	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
>   		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
>   
> -static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				   enum cxl_event_log_type type,
> -				   struct cxl_event_record_raw *record)
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    struct cxl_event_record_raw *record,
> +			    enum cxl_cper_event cper_event)
>   {
> -	uuid_t *id = &record->hdr.id;
> -
> -	if (uuid_equal(id, &gen_media_event_uuid)) {
> +	switch (cper_event) {
> +	case CXL_CPER_EVENT_GEN_MEDIA: {
>   		struct cxl_event_gen_media *rec =
>   				(struct cxl_event_gen_media *)record;
>   
>   		trace_cxl_general_media(cxlmd, type, rec);
> -	} else if (uuid_equal(id, &dram_event_uuid)) {
> +		break;
> +		}
> +	case CXL_CPER_EVENT_DRAM: {
>   		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
>   
>   		trace_cxl_dram(cxlmd, type, rec);
> -	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
> +		break;
> +		}
> +	case CXL_CPER_EVENT_MEM_MODULE: {
>   		struct cxl_event_mem_module *rec =
>   				(struct cxl_event_mem_module *)record;
>   
>   		trace_cxl_memory_module(cxlmd, type, rec);
> +		break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +
> +static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +				     enum cxl_event_log_type type,
> +				     struct cxl_event_record_raw *record)
> +{
> +	uuid_t *id = &record->hdr.id;
> +
> +	if (uuid_equal(id, &gen_media_event_uuid)) {
> +		cxl_event_trace_record(cxlmd, type, record,
> +				       CXL_CPER_EVENT_GEN_MEDIA);
> +	} else if (uuid_equal(id, &dram_event_uuid)) {
> +		cxl_event_trace_record(cxlmd, type, record,
> +				       CXL_CPER_EVENT_DRAM);
> +	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
> +		cxl_event_trace_record(cxlmd, type, record,
> +				       CXL_CPER_EVENT_MEM_MODULE);
>   	} else {
>   		/* For unknown record types print just the header */
>   		trace_cxl_generic_event(cxlmd, type, record);
> @@ -991,8 +1016,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
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
> index 706f8a6d1ef4..89bd85e7f51c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -6,6 +6,7 @@
>   #include <linux/cdev.h>
>   #include <linux/uuid.h>
>   #include <linux/rcuwait.h>
> +#include <linux/efi.h>
>   #include "cxl.h"
>   
>   /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -477,6 +478,8 @@ struct cxl_memdev_state {
>   	struct cxl_security_state security;
>   	struct cxl_fw_state fw;
>   
> +	struct notifier_block cxl_cper_nb;
> +
>   	struct rcuwait mbox_wait;
>   	int (*mbox_send)(struct cxl_memdev_state *mds,
>   			 struct cxl_mbox_cmd *cmd);
> @@ -863,6 +866,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   				  unsigned long *cmds);
>   void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    struct cxl_event_record_raw *record,
> +			    enum cxl_cper_event cper_event);
>   int cxl_set_timestamp(struct cxl_memdev_state *mds);
>   int cxl_poison_state_init(struct cxl_memdev_state *mds);
>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 44a21ab7add5..36d6f03e55de 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/moduleparam.h>
>   #include <linux/module.h>
> @@ -10,6 +11,7 @@
>   #include <linux/pci.h>
>   #include <linux/aer.h>
>   #include <linux/io.h>
> +#include <linux/efi.h>
>   #include "cxlmem.h"
>   #include "cxlpci.h"
>   #include "cxl.h"
> @@ -748,6 +750,69 @@ static bool cxl_event_int_is_fw(u8 setting)
>   	return mode == CXL_INT_FW;
>   }
>   
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +int cxl_cper_event_call(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct cxl_cper_notifier_data *nd = data;
> +	struct cxl_event_record_raw record = (struct cxl_event_record_raw) {
> +		.hdr.id = UUID_INIT(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
> +	};
> +	enum cxl_event_log_type log_type;
> +	struct cxl_memdev_state *mds;
> +	u32 hdr_flags;
> +
> +	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
> +
> +	/* Need serial number for device identification */
> +	if (!(nd->rec->hdr.validation_bits & CPER_CXL_DEVICE_SN_VALID))
> +		return NOTIFY_DONE;

For all the event records that I tested so far, this has never been 
true. That is CPER_CXL_DEVICE_SN_VALID is never set which might not log 
the records at all. Should we be bit more lenient here and include 
validating device_id (bdf) instead and check if cxlds exist?

pci_get_domain_bus_and_slot() and pci_get_drvdata()..

> +
> +	/* FIXME endianess and bytes of serial number need verification */
> +	/* FIXME Should other values be checked? */
> +	if (memcmp(&mds->cxlds.serial, &nd->rec->hdr.dev_serial_num,
> +		   sizeof(mds->cxlds.serial)))
> +		return NOTIFY_DONE;
> +
> +	/* ensure record can always handle the full CPER provided data */
> +	BUILD_BUG_ON(sizeof(record) <
> +		(CPER_CXL_COMP_EVENT_LOG_SIZE + sizeof(record.hdr.id)));
> +
> +	/*
> +	 * UEFI v2.10 defines N.2.14 defines the CXL CPER record as not
> +	 * including the uuid field.
> +	 */
> +	memcpy(&record.hdr.length, &nd->rec->comp_event_log,
> +		CPER_CXL_REC_LEN(nd->rec));

I'm doubtful this will do the job. I think we should copy into each 
field of struct cxl_event_record_hdr individually starting from length 
by pointer arithmetic (which is definitely bad, but I cannot think of a 
better way to do this) and then do memcpy for data field in struct 
cxl_event_record_raw..

Any other suggestions would be helpful as well.

I can make these changes and validate it on my end if that works..?

Thanks,
Smita

> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(record.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(mds->cxlds.cxlmd, log_type, &record,
> +			       nd->cper_event);
> +
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
> @@ -758,8 +823,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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

