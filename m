Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD397DFD89
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 01:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjKCAbF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Nov 2023 20:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCAbD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Nov 2023 20:31:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E9B136;
        Thu,  2 Nov 2023 17:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0WGxkquoEtI5o9shoauW8/0Ugd3YqMUQaSSKj392+eoGrOL05VkAYA9ibSHwI6vwxh5cS11201hImI1IwzF9uDLkE41pCnRQVkO6mWS2piXv4VJyYIio/8xxtf1vWOQ/UlQHiWnN23pRjEKG0HKE+Wu1rOJlAarLQevsSLEBOIlSLPAGYpDqv1T0GGlTWy6NnsuipmkPNay/pFh7xGZJqmMSEqQdv7sk8WVthT7Ok4mFFiFbzx8mKvr//+/v0D9+nGfD5nF15oTYGQC4XhH8UKQUzT4DINeLWBXoIP5jfG7ZFYYy539hlMnC5s1qhOFcilBChAhP8V1SvA5pBF9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuVcA1YJY1vy1frPyG2g6Inh2HhEI+1q6IVFdC+UzlU=;
 b=Pl2TiHt+dn32CADZRvIX5J5Ir4MCSZfpbkXCBoP0LK3zlQjcVrXD1G5AoXWKV5eAhpRwnTYRhKSwkBq/APXD2t2Y6N8D8l8j6a6jHW/SBZli0qslm2pYKQFKE4jRj3kMcuwU0NujF0HHlOuU+jSErSTtGhFjaZIgT+M9/89yNldwHgd0OlsZjmFlm9ybvsTc139rxN0K+bUzI2ZKKd4KEA6cbm9SLfQQWAI+PO+3mk+mTEAOf8ZyqMh6Mh6nmN/jKfd/vNra9dXph9cxki4MtmIJKezbg/KSbAyAVt4vwPOFZh5oSl92f4b+RNtLGU9/FLk665ALriyMwT3UY9px3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuVcA1YJY1vy1frPyG2g6Inh2HhEI+1q6IVFdC+UzlU=;
 b=kFTAHs2jxgNqncQ8z+/saAedxozcj5q2PqAe//wPPsj6shA9vccjJ3IpsqjBcgO61Oc6xV0w9SfKpzGR+XM/un6uk6d7ZpCwHrcntzDu9ALx0ifs1PHBT5mLT0/NBimMZNTnZbMpTqobX3F2cEpNaOtWwEiQX0pDTzlY2De4vrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 00:30:55 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c%4]) with mapi id 15.20.6933.026; Fri, 3 Nov 2023
 00:30:54 +0000
Message-ID: <bd888ca8-39e8-0e68-9bb5-566ef91cee24@amd.com>
Date:   Thu, 2 Nov 2023 17:30:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC v3 5/6] firmware/efi: Process CXL Component Events
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
 <20230601-cxl-cper-v3-5-0189d61f7956@intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230601-cxl-cper-v3-5-0189d61f7956@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 652ec45d-1115-4d21-1f20-08dbdc042337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+Z4qjK8u2G8zk/rbjA+k2zFzjb20ic4yJvk1eCsLj6rciRBkJlupLYA7DMMTBMDXDI2sOMl7PTspTTgTTeEqKai5419x1TR1U6SQs7Gwb/DJfQeJFgtUjYw9fKnkghJ+8fDf5FDIlwhz42dricqG1inGiXH6E7I0a5YUToER7g+7+dYgkMx7xU9LxBUzZTH61w773FqwXTHTgzy21IsYRcuHPj6/tim+4UOWeWh0ijjwscY92qR5NfRq9+HfUiWXy2H9xUAHMuVrqLwy3zN+CHqGZDluFq9neft+jdthMk1XeR5gZ+5/ZFrQ/pMMjV1ftmpaejuzNcwRud2UIGnlIcycuKnJt6vw4OGKOnMrLp6nhNKb8lSD6yuYQiveUg1N4fnKoXrdC4wX6p3eiBuhjcPJYP192bDWcafW7BeXwZ4rf9q4xsCZ1oUqVYsTzTb4IJgIu5PEWaclm4WA2RV8wh9Fx+nsYwkt+JekXX3LpLwEcBziFiFPEb8WcNdLqXg6J4sNTNtVCaesgkelPjQhdJuzVGfyCiyXU6KOqwRVYWQIk1qLPnYqqQzm1b35TbIuq6WIPKKxtUm3IYnG8i4+zbYWvLzWG6PztmOow9A6gNyMbhmWNx/JkKMPH45x2yUM7o5EDxZ/iia9O95AY/itg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(41300700001)(7416002)(36756003)(2906002)(5660300002)(26005)(2616005)(83380400001)(53546011)(6666004)(6506007)(6512007)(31686004)(31696002)(38100700002)(86362001)(6486002)(54906003)(66946007)(66556008)(66476007)(110136005)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWYrYU9NWi9Oc2xhWHlZZ1hwRzJWNkplcjNqdmg4K2hMVzQvRHR1cnIzVFd6?=
 =?utf-8?B?dmMyZExvNlRMUElUbGxZdG5uUU1EMU5ibDUxazZMazVJQ0g4MzRLWmVCYlJJ?=
 =?utf-8?B?Z0R0OGM0MlNtOTlMWlZQUjFValdYcEhKTGo2QTZiNlQwV2VFWmVqbC94TkNm?=
 =?utf-8?B?YkRrUVdkRWJTank5YS9OcGZGbGl5aWlNbytkNFVTZGtrWjErQURBWmY3bkJP?=
 =?utf-8?B?RFl2VHhvUVd0TE0rcGxRcUJ2NTJEM2xlQTBqL21yc2hEQWV1eFU0eStoUGlw?=
 =?utf-8?B?a2FweWJuTTAvZ3gwS2RJYUJCdFR4bXY2S3JOZHpuYTU2eGphTE5ld0JjeEVt?=
 =?utf-8?B?azFiUEVYdHpMUlpWQThtMys2alhDTFRNQzBvRXZONi9DVitsclhPTnBSdmxX?=
 =?utf-8?B?aUl1emhJUnVrZWNOTENZd2ZrdnBUQ3NHbFBUQTVSZ2dCdXBiMktGT3FrN2pU?=
 =?utf-8?B?ZTRYbnNQVTFsdFgzVFJxUUxUNTFRMi9hb293UlhXR2dyK1ZyQ1NrSkdOenZX?=
 =?utf-8?B?MmNjNUJrZmdTQTRmNzgwaXlsZXpHYzVsd3ViV2Z6NkZDRXE1WUNWMysvUlZY?=
 =?utf-8?B?b1lNQUxrSndVWGtnZWpxMHFvT0hOaFFJUEMzUTRZVWQxdWJKNEVTSm1CQWR1?=
 =?utf-8?B?WHdiUkVzam1wS0x5cFozMGFsZ09LV1h4SkJOT0pRVVduL3FmV1F1TjJtRExz?=
 =?utf-8?B?TEMvNDNXMU0yZHQrY3B0MkgzRVREMkREV2VHTXdCazR2bTIzeGxBQkJDd0la?=
 =?utf-8?B?Q3pBMVJQSGdxMWd1Sk4vNUJVbnJDNzhybWlFcytxZUkzeFpuZjdzbE1XTE55?=
 =?utf-8?B?dURhdmR4WG90SmU5L205M0MvWGRvMnROSk41eVRVL1NTbmdKQ3cwM0dURCtG?=
 =?utf-8?B?ODNqVDJyaWxEQjIzdVhZL1ZLS053VTh0ekdLcnJXZWVjL0l2MnZEK0N1ZUdm?=
 =?utf-8?B?SVRxOFhkYUszQUg0emJtQnpOUkpEMzloRitQc0c2Szgzd1QyMU00MVBoY3BP?=
 =?utf-8?B?SXExM2I3Wk14OWk5Znc3RjlDekU5MWxlUVN0SG01RE5WTTNiQ0cxNFFPTUZt?=
 =?utf-8?B?ZE8xYkU2c2xkWnR6dmkwUEtFWExGbXh6YytvZktCUEJRNktzRlFCT2Vta1Q5?=
 =?utf-8?B?M0xTbi9idXZEaFgrMDN2YVpGZTBpWVJoUmdIN1JBenBQRGhLdjNsZDdtVEhX?=
 =?utf-8?B?Mit6R0Z4MHZLSlZUMENpNkV5a05QR29kU0MvaHYwVWFaUXN4OFhwc2E2azM2?=
 =?utf-8?B?dThFcTJjV1RWUzJvUFppaEZnb2oxYzVacGpzVUlXOHd6ZmZvVVhXOUh5TkZJ?=
 =?utf-8?B?Sy9WSUxXREJjVDFWM2ptY0h3ME1vMnJ5bG1QSjRmL3pnT3VpQWdnNDM0QStq?=
 =?utf-8?B?d05zRndMSVU4dFowMkxrSFIvUUlMa3VzOUxWRkNMdFNTRzRCVU9ZTjIzZTRQ?=
 =?utf-8?B?UHo2SDBvWkJoVk1mSGVTdFlTVXQzN3ZqTHJFOWovcjVicXJGK0NKd3hZL0Jy?=
 =?utf-8?B?LzJUcVZmVUJDei9yMEFoTUl5MnhiVzNPaUlhb2l0M3FkTXNDeGR3bzFaZTdK?=
 =?utf-8?B?d3A3TSttSnFoQnpYTkM1UCs2YnNud2NRaEhSakNaZTZ0UzlUWGJucFgvdG1H?=
 =?utf-8?B?Z0ZJTW50aTNtdEJsOFlEaG4yRTQ5bXA1ZFR3a1l1QTNWaEIyM2I3dTIxN2hn?=
 =?utf-8?B?VHp4cUtLOEJ4UWxoQTBRWHdBdEFWWlJNT1FURWhkb2xYNi9IN25vMWpMSW9p?=
 =?utf-8?B?aldkdTNCU1VTYlQrYkJjejdCTWhtS1V6cU1DaUd0MGNOT2IrT2xXYS81RUtH?=
 =?utf-8?B?NXVaYUlHTStZbDk4UVZsTGovSDdaNEFlRFROMC9SMFQ1OU8wWENuVUhoZmdD?=
 =?utf-8?B?L1Fmb1hlTnVTdEdpd21SWmlFWWVKdUdsTE1hSDNlcGdaS2J2eFAveFZmQlNF?=
 =?utf-8?B?cmo3ci9nZEJLL1ZSaC8rc1h6dk5WYWFhNUNTMVdyVmNkdW1mSENkMUNZVXdl?=
 =?utf-8?B?MnhTekp1QTU0L2VnMlhtMy9qRTRiWG9IS0tqaitQZE9vWWVHR3dTUDhLTVlj?=
 =?utf-8?B?SGNqSmVGQmE5ekl5TmJrcmlOZGhuS2JmU2t0dmI3SGY4VUE1TEwrV21ST2Rt?=
 =?utf-8?Q?UeTaDoQVCOcdhccLE9bttIL/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ec45d-1115-4d21-1f20-08dbdc042337
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 00:30:53.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPhZjM3+qDDFHdEIMdeFUfBtCj1FfuEeKMTX4wSsW76NpVJC013FTYC/Z0+JO2CDbsSnjsiCJhj0BDqUcYsdOg==
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

> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 6b689e1efc78..2bdadde80f1a 100644
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
> +};

Do we need pragma pack or similar for alignment here?

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

