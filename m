Return-Path: <linux-efi+bounces-95-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72D7FC57F
	for <lists+linux-efi@lfdr.de>; Tue, 28 Nov 2023 21:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D83B215C1
	for <lists+linux-efi@lfdr.de>; Tue, 28 Nov 2023 20:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ABB40C11;
	Tue, 28 Nov 2023 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qidAOeuE"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA019AB;
	Tue, 28 Nov 2023 12:32:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7F30byYmrvJ79klsk6NlOI2ItzZFIc00RJuEcyP5s9fa0OONRTbbVM7G5wiFG3v4y5bwiqcXvKklHlEttLUWKODeTU+kA4iQ/JxiQGXjybifXhjMoYJjujfosNPLF2pZPgS7c64QWbJSwzfbsWXN4Eupm9Pn6c7yxKjeysEd/yJmesBXjPDRTC2uq8WkTphpL+dgkvdfOGVgk6U//8ZMKfye5Drz5VyLkg9OEE2Fs6ujF4R2JtLjRZDebRSgagmIlUQAmqNd0rhdksJe3di4SaIr1ECle3m9tnW4brL22R0myvOKKjJi6IDwTrr33DGPHNQGYywAbL53KJq4c/3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4d8JARsiHdmnhMQI9Ls7SXRPCS8HRUzdm+NMxh61xg=;
 b=YluJqPgVfhnVV3pp+n7y4LlBHZbZlQcHh8lgBEK/IuKxJiTtguIqHhz3TCIu7yxfRD3M4u4cPsgF2BfV3fM93rQ18uCbyxSMO+LUpVqRkyFVyAqgnpWyAwv+4NBBuSxax6nbYaPZPGtZxwUSQYUQcckSAqWl4zr0Wnq+DAiexu4CV32glActEblE/y0eX4urWSR9LyfkuXNvo96I1B1V1tJk0oiJdZWStypak5h9UoqDGwvy9tns0DVfH7O2lE3xzeEMK3dXxMIPiyb+f/gudb91G+h9UeyApSUC9Y8VvAKh+8eg7y+UMX5UdkKitObyagxC3QvzGhnCMAoI2xRcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4d8JARsiHdmnhMQI9Ls7SXRPCS8HRUzdm+NMxh61xg=;
 b=qidAOeuEQCjcT/HewZwydBYi+nbMdv+w9LXek4c/OkvvjD/BappYbWNxn1Q15m0KJWKDMXDUWLCaegpMNmB+2ju0yPjkNtNiOgqvcg01lHozwko+kS2JSFN7sC5HRqGj3yTYHVPM06kGYZ9un9/OQcYdQbG8UhmiopCsq95/Y24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 20:32:42 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 20:32:42 +0000
Subject: Re: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
 <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
Date: Tue, 28 Nov 2023 12:32:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:510:325::12) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 167d49d8-14a2-4df5-fae2-08dbf0512c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1NOAZV/II+GwFA6kLNDxJh3vneFgeO0j2zxVvxJ4nZDBlN06uTGB61E6hY2L6WjD7Mf4fL196Euz4u51UWAfknPA+a+nle+E8vqHB2pkIHSguR1/7neZ2MtzMp7xyhppzJtFMelAW5mlkcW6K8enrx2aR2kC9xJD1XOKmq7YyQoGaAjW3b8qqwaqx167/hIlCijBUqva6PIvHAKQxWA6nPhTPQF9hsEpFG9NAa9J+VxnAwK50q86DFmSxRpFQXuttBTDAga49cEDLZWk1fvqKmiA40Y0EISw0yEQRh9HzW/yMs7V1eqjZTWtqrlbWJK9l+CIM/HzBsZ1C5+i3hYePV11JThdudhmNf01AnoX6fsg+R8yk8AZFAc4iavJTUdTVkO13VfBDhlGlZ5vLo2Ytnf/JTDKr4M49Zn3+KXUt8X4xv3lOdecvW7sEtAMtj2CsVJsNh258SP2NCBO0Ottt9cA0h+4/vMwxWTBQ0Nc4ftJmzM3QrFd6hjhB/GeJqF7IzIkxcqShFPdtes/yYiuzVJc0q4qMBwuOSzUNERwYZfnd9RXd4EUkDWwjJ15yue1Mu61FlDb0G7Iqol3MLdcP8qDnATwYKt1A0qxHJa4+NvVkl/1JAVVJ1lYllq6EQYUdyTFytSONXYU+umMwcMb5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(478600001)(6486002)(2616005)(53546011)(83380400001)(2906002)(5660300002)(41300700001)(7416002)(66946007)(4326008)(316002)(8676002)(8936002)(66476007)(66556008)(54906003)(110136005)(38100700002)(86362001)(36756003)(31696002)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alE4S2RvRHJPN1FhRkF2TityYzE3ZDZtRGhWWW55YlYrN3dLY2tjdXFEdnds?=
 =?utf-8?B?ckdJbEUyNTVEMW00Z3VFd0ttMmt2Yng1bHc3a2hMdnNodlFCQWNIajcrMGxN?=
 =?utf-8?B?WCsvN1lwY1RTbWdYb3pCb0tweGZRcTFGaWxMT0hwblR4WjdKa0Ryc3I0SEhz?=
 =?utf-8?B?aG1DZHBVc05jQ1ZNelNhTUR3ak9LU0l0OVlXV3hqZkFmbVlGTkZPbmVPMEFP?=
 =?utf-8?B?MGV4OVNCUjdnTTN5K0RZa2ZMVW1maXgxa201ek5lanE5QmQ4SnYrQjBTb2dk?=
 =?utf-8?B?S0FoMDVRQmw0S09yeG9EV0lOZ05mTXRtRnM2aWVpUldMdWwweWlzQXBEeVND?=
 =?utf-8?B?MWcvZXlBem5VWDRXTlFCN3JqNmlBekRaS0oxakIyWExib1JlcW1qMHMvZjZm?=
 =?utf-8?B?cVVXQ0ZIUmE1K2gvS3Q4L0dIaTlnbXpqeXo3S2JjNW0wRU1iUnhyTXF5a2I3?=
 =?utf-8?B?SXIxQkEva0hwSVBGVlB2TlJsbHZwMnhiQ2VNd04ycmN0RGhFbFN6bWp1VW1w?=
 =?utf-8?B?MDNncXhLRmNULy9TUWRIOEtrL1lMbEl1SFN6QVB6eDVTenFHcHkyMzVLY3Q2?=
 =?utf-8?B?dHFJTllZOS9qbiszMEtxUEJ0aW1UTmtGS2ZxeWRBNXhXYWNycSsyMjFNejNC?=
 =?utf-8?B?djV4Uy9NT1BNQjY3WjAxWXIzQW44SExPNnpNd3RBYS9lNnBUbVdicEFhSjU1?=
 =?utf-8?B?NTJySldVTjEzVkdhSU12RE14MWpGZTlEZU1ubW1WSitra3UrZlQ0c0ZZV2VG?=
 =?utf-8?B?NEFpdXg1Q1hVSkJic2JwZXdiN0cyUmpDQjd6UG05YnFWZDNad05OdFFrRDR3?=
 =?utf-8?B?QXZXZjV1bGNlOE1PMmc2VlVNUi9Gd252MHZ6Vm5wb3JzUkg0V3Z0eUdBWnlS?=
 =?utf-8?B?ZjBIQ3AzU2dWSlF0SlFLVGlOdzBJWllTa29WOUNKQUkwbzc4Mi83RlBHMHRF?=
 =?utf-8?B?YU44YVh4WXV4M2VVdFNFMXpKcTF3aGtZSEhPU2xzZzRUMXViNGVpS0VyaENR?=
 =?utf-8?B?d0VkOVVIUUl5TWNFRzVmOTNyenhoaFFlV1JFYzA1bnBCaldMRlJKTlM0N1RY?=
 =?utf-8?B?dy8rRTdtc2VxVHRXalpDOVpvWDlBSUFSQmJQOERHd3VxaEhBdHlrandac2c5?=
 =?utf-8?B?alRwQWF0cnZKK3grbVIvTzJXcmZrVDBVNHE3Z3gwSTgrQ2RrZkplbGVqMk1n?=
 =?utf-8?B?RVh6eGk1R0t6WWpCenJaN2UwOWtmOCtXdnY1L1NIVEtmbDVQaHdTcng1S0RH?=
 =?utf-8?B?SVoyNUJrb21YTVAzUEFqR2lXaVBFYy9leXllNHpZSERwV3NSaDFMNi9LSE0z?=
 =?utf-8?B?bzV5eXpGeXozZTF1ZnJVUUtreHFWLzBwaFFaZklKMThMN3JrL05ndmU4T1Rw?=
 =?utf-8?B?ejRPZ0h6VFlHNUpDZTVScFU4eVpJMTBEbUhQQVVoOU5TZ0JCMTg2eVkyWE43?=
 =?utf-8?B?U0lsWTVwR0dNQlRVNE1rOFkyRk5uWHRGc0xsRnJEQnFlb0k5c3EwU2NiRjVq?=
 =?utf-8?B?NUpEcjMwaUVZVGt0Q3JDUnJpN0xubXFHYXJ1WW90Q0JyMURsdk5leWVJMTlW?=
 =?utf-8?B?OGxsK1BvZ1FDYlZxV0pHWnJNZHVVZ0JvV1NBKzI1YjhJSUZTeHF5TzR2SGpS?=
 =?utf-8?B?NmljZGFmNFB5ZHBCWVVLWVcxT25Qb2FYRkp1R0hQYngvb1FENWxobjU5eTlV?=
 =?utf-8?B?SW40TzFiYnRzYnRFYVp1eFI1Y2liL3ZDbi9YUHY0Q3hPQXRYUytyVFQxVGpI?=
 =?utf-8?B?QUN4Y0YzcnFEbGg0TEJ5bUxPYUR0Vyt1dUpON3gxMnh0ZVFNK0k3a29RN0U5?=
 =?utf-8?B?NzBUdDU1SHIzRG53VHppbUt6eUtIbGRvaTVnbWprMENQUGU2Zll6UDBJbmVk?=
 =?utf-8?B?bnByRlZDRjNXdDVvUjUyejR3MnlqWG5JNFc4Yml3Qm9HK0dCR0dSVExSak5L?=
 =?utf-8?B?TWdnaDlIY0dQUFp4TjlyU3JLV3RwL29wejlvMTJrRkFsbTJualIzbE1vZTl5?=
 =?utf-8?B?VnJpUlhvYy9GT21oRmtZVEc5U0Q4UTZzdFQxZ3B6NkU2TE1lSGd1RUFsbURU?=
 =?utf-8?B?aGg4RHF0MVFrN01lSDc4VCtkZDkyVHZTUy9vTzhrYzlMVmMzRXdPYnFrR3py?=
 =?utf-8?Q?3SaxSXxkiGlEa+4HylFTh+sDr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167d49d8-14a2-4df5-fae2-08dbf0512c17
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 20:32:42.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgcM/FUUPGGQ9H5Jfh0FNNj4k65sQlB2ATR9Z/KejCsGqza0EEVwZyj/5fd40L1A9kTHEeeWrKp+Ji5FkC3quQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

Hi Ira,

I tested this out. Just one correction below to make it work.

On 11/9/2023 2:07 PM, Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference is a GUID is used in
> the Section Type to identify the event type.
> 
> Add EFI support to detect CXL CPER records and call a notifier chain
> with the record data blobs to be processed by the CXL code.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from RFC v3
> [Smita: ensure cper_cxl_event_rec is packed]
> 
> Changes from RFC v2
> [djbw: use common event structures]
> [djbw: remove print in core cper code]
> [djbw: export register call as NS_GPL]
> [iweiny: fix 0day issues]
> 
> Changes from RFC v1
> [iweiny: use an enum for know record types and skip converting GUID to UUID]
> [iweiny: commit to the UUID not being part of the event record data]
> [iweiny: use defines for GUID definitions]
> ---

[snip]

> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 6b689e1efc78..733ab2ab8639 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -108,4 +108,53 @@ struct cxl_event_record_raw {
>   	union cxl_event event;
>   } __packed;
>   
> +enum cxl_event_type {
> +	CXL_CPER_EVENT_GEN_MEDIA,
> +	CXL_CPER_EVENT_DRAM,
> +	CXL_CPER_EVENT_MEM_MODULE,
> +};
> +
> +#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
> +#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
> +#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
> +struct cper_cxl_event_rec {
> +	struct {
> +		u32 length;
> +		u64 validation_bits;
> +		struct cper_cxl_event_devid {
> +			u16 vendor_id;
> +			u16 device_id;
> +			u8 func_num;
> +			u8 device_num;
> +			u8 bus_num;
> +			u16 segment_num;
> +			u16 slot_num; /* bits 2:0 reserved */
> +			u8 reserved;
> +		} device_id;
> +		struct cper_cxl_event_sn {
> +			u32 lower_dw;
> +			u32 upper_dw;
> +		} dev_serial_num;
> +	} hdr;
> +
> +	union cxl_event event;
> +} __packed;

__packed attribute just for cper_cxl_event_rec still fails to properly 
align structure elements. Looks like, __packed attribute is needed for 
all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
cper_cxl_event_rec.

Seems easier to use global pragma instead.. I could test and obtain the 
output as expected using pragma..

Thanks,
Smita

> +
> +struct cxl_cper_notifier_data {
> +	enum cxl_event_type event_type;
> +	struct cper_cxl_event_rec *rec;
> +};
> +
> +#ifdef CONFIG_UEFI_CPER
> +int register_cxl_cper_notifier(struct notifier_block *nb);
> +void unregister_cxl_cper_notifier(struct notifier_block *nb);
> +#else
> +static inline int register_cxl_cper_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline void unregister_cxl_cper_notifier(struct notifier_block *nb) { }
> +#endif
> +
>   #endif /* _LINUX_CXL_EVENT_H */
> 

