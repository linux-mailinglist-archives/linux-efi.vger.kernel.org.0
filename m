Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD807CCEC6
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjJQUwN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUwM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 16:52:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1245892;
        Tue, 17 Oct 2023 13:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBi9ppurGq0xnby7nYBk3evlWxgZuNQD/2DUnYDuhu9lphyN0cW9hxMRQZAwwiWuI5Lwfqq4Xhn87j7H3N6XGOFaa2B5Mt9PFiqDv9NCguQvn5nY/RdNLZarGAO9DHi8X/T2w+5qztjsJ0XUNT9MbxL5t2nNvBt0qyX/2kvYSU8wg7FAbNmIq9pTHDURhE847zzX2jo3MorX2bk+kxE/t7XvI8DJP1Irbytiywv9bUK3OhBfq7KOKedjAApBU5tTWFeeCgIo2vG0NXlMfaLnBu9bpWSZS3qysm2SCzIp1/OdqEmgLfQD+KTLABHY4KzXbnkW/5A0h3BdWLC6xZbKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+JKv8wkTkywh1EqGktzRWycl54Dsby44cKzFDsbn28=;
 b=j2fMiXjhA5f3QLaZQ9Cz+HAuPlyKoc/S5+qZFP5hoAyDNGPh3DDmlnh10rm8sohxk5/+SWaCRZpuUyie8YfUtZJ4SXZ+HATs3iSb69AfIwEoM27Wr7wMuhP6m65QNzJ4EQC9aBTAN4IVJT9dS52IUgu3rZSpnASa805QO3fkA7ILkIhB5bvM5ernbagdGU7vEJUrQXuYrOWv15AmQT0EUa445qbYiCEK9KIwTYqcdxr+ZztZjSWM2w5OmZ0GqDDck/ASNOiaXCsruoj4yYXN1WPGIwddcSbsUbIk9UDvPvj0yuZYlG+3O4zjkbSvJY1BkvecGVdSb4t8xZCE1OKW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+JKv8wkTkywh1EqGktzRWycl54Dsby44cKzFDsbn28=;
 b=2xYHqA6NSusdDEqhyQi9r4kvfVeRWS/Vr0ZgjRsAVVzvPZ7eL+Agsr4CYtxptOJiiHuFgHr08I2IGrIhddWdv4AGkzZWTRMd9WGNBn0vuqot53xP4GrZpErSxlPfa89TD5Dw46v1IvAzpl5tCs/0Qbuet5GDWttWIsPLcebx5FY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 20:52:07 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 20:52:07 +0000
Message-ID: <d5882c60-6636-f651-2886-02c433f77ae1@amd.com>
Date:   Tue, 17 Oct 2023 13:52:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General
 Media Event Record
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
 <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
 <65288e68de994_2347eb294c2@iweiny-mobl.notmuch>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <65288e68de994_2347eb294c2@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9447d1-eed9-4ad4-d8aa-08dbcf52ecec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LveNQt997b1E4+gos6yG1YJ4+ydTq0cuKEwS6ceS1aLg+syMrndfb/NaDHZ8md/MGkDhcMRRVt+pUa8PHvljPvuCs3punibvbqhq22itBZc+hYiRQbXYuaWapmbGqslQgLe/Qj22EbzMNX48JzfCmZUadh2Y8WHz6aUXfGModiIT60Ai1XkRWxB6GDx54CTL/oTR38i/1JiwDDRta+lgC6b45xrqoTMrNgCeYvRoE2TQ+9RxKn1M3Ve/XIbO+ZXZMjynRUI/nIyLJqSn+05/gSKDtHof8pKrlIqM7P0oHu7HYZBkct1ZP6P6AxFdAj9UN9f8luuxP7hdPb604pXlm7SwfUWthfpTN6YCWrBaqcUO/jKKZ3nIcsBXSYpHozHt/jXKdJEaNJw25IOUjkwrs5llrEhwa0etB0/HYV1VjHW6jke/HfiuVrrVOktpa8ocyAyVqvWxjnONbI9Id5okYYjGsgR5/AdzmyBSd4OdBJGLQQPiTZeP31ZJ2noUtATDR0sFcKmKO4bBQkrfmjSOp9ZcR5LZH1jEgaWoUYrIlasUx1bsTMV29E10XQMKtck6ZHFw35Jp5XGL7Dk/DyyZ8swLijkVPD98nERK2VcXF1VF2pJGuSzAnJA05X6pNtg11jIddBmY9nnHGyzr1gVuSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6486002)(53546011)(6506007)(38100700002)(478600001)(6512007)(31686004)(2616005)(26005)(5660300002)(41300700001)(8936002)(8676002)(4326008)(316002)(66476007)(54906003)(31696002)(66946007)(86362001)(2906002)(66556008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1RNM1RTZjRJRkpMOVNCdHhkY0xXclZUSWNjbVFLNnN2RkllSzRhS0tQQTAv?=
 =?utf-8?B?WVRFREhjNTBnWXdHclN0T0tyMDcvMHRRZVhuNjNEMDJyWkNpUG1wejlNUXpE?=
 =?utf-8?B?QlgzK0hoVC94bWlkS3NTUzYxTUw2WXJIdUh0V0dSZ200UkdEbXNGMkUxWEhu?=
 =?utf-8?B?VUNpa0xtV0lQSWdJcTBqVEV3MXNESXFhYmhTTzVvaWIyMWdObzBDQzJ3MHJF?=
 =?utf-8?B?RWkvckRWRkp6c2VibnZmelZKbjMwRVV1VitKODJ1V0pKTVkxdW54RHZoOER6?=
 =?utf-8?B?bUd5bWRoVlNUUWdRZHdjb2U5VzRvK3lqTUU2ZDkzQnlqNE9yYWdkekkvbjlO?=
 =?utf-8?B?N2tBZDZ6aVpkUlI1NXdKczJWbXgvMVgwMlhueVZpVUNFdXlEcVkzTzdJMmlN?=
 =?utf-8?B?VGx5SjhmUEFtQVRNRmErOVB2QVdmY0hSaHNoWmtGcC9OeHd0eXBEK3VmRHZj?=
 =?utf-8?B?RkE4bGpzVnE1c2gyZ1hLOGdTTEY0Y25wUVp1c2QraE9pM3NmcmRjOHJidm1V?=
 =?utf-8?B?blRZR2ZiKzFUcGdUTEwzNERZQlc3SWVMSTJKaVNBa3JCS3pXelZTNy9oUW8w?=
 =?utf-8?B?bmtlcTBudXF0eWduKzhPUDlVa01KbVI3MUhMYnpwSFVyNm9vWXpXQ1BRRGho?=
 =?utf-8?B?VTh4a1UyNXdZUm85bnJRMFdGZnBjWWJSUFZSV2ZaTEp1Q2YrWHl3OWZUK0d5?=
 =?utf-8?B?UFRoa0NuaW5TaktwTHNTWXgzSXRwanIxVUpHNHVKaGxWbW5kNVNMRG1MUHRP?=
 =?utf-8?B?WXRvVW9WMG1VZWlZemtJTzd3MVpVRWF5Uk1pWkZpMnVxKzJZS0pNVjk0TzlN?=
 =?utf-8?B?TGE1S1F2enNQVmRaYVpIbmY4R2VnMjNDUCtSMkREbDR4d1lONGtqY0ZmRm5a?=
 =?utf-8?B?V2VHS0ZWWGZkV0RnbUxjRTF0Y1g0WWRGbk9sVDJXaXFHVTRxWHdBKzBhd0hS?=
 =?utf-8?B?bURWSHdnbm5UeWp2NCtFVnVOdGxmeDBkMFhPWk1jWDdRUjQ4aUxTRElsa3I5?=
 =?utf-8?B?L1BNVWpPV2FldUhPSWtLeTg2YWliTUlESTc0RkVDOWtBODFnNWJBLzdwS0wx?=
 =?utf-8?B?dzA5V3E1MkluUFpxMU5laXh6SlRMRWJaaWw4TnAzMUdiYW9HM0FWTWt1VmpO?=
 =?utf-8?B?R0J6aC9pNldUMXZRYXdiSVNuRnVNM2MwRjV5MWMvUmpMVXlWdGZuMFhPVXg0?=
 =?utf-8?B?Y0JrbkJjOFgvVDd5RnlQR2daeG8xaXRURHU1M3QraU53MmdsblA5eTc2dnVt?=
 =?utf-8?B?RFh0SzZQTHAwOERBTFF6c1pENVpnV2g1TWQ1TGl0THhueks2cmI4aWc0K2J5?=
 =?utf-8?B?Z2pPcW5pUm40dTVwZ01uQjZ1dENUckRnK3BpT2h2eEF1VG40UURya2t6S1VB?=
 =?utf-8?B?RndhbnArRjdvdUJFbGtSSlRQU0ZneCtRdnNoV1Rtb1gvbXFLeU43Y05oQWsy?=
 =?utf-8?B?bS9ldVVRdWVzZU5nSnlGOXlteFpKZ0RyS2pmbXVIUEphQjFYc0hRYStJcHkr?=
 =?utf-8?B?OTNZb1hrQ3pBbXJlQi95RzVCeUVjYnllMEpZZXhGMExJN3V3SEdwcGs3b0sy?=
 =?utf-8?B?VUlncjNwWHZ2NUJ3eUh6TkluMlRzTkF1eU80S3ZHeGw0ZGN5MUU3dFNwMXVX?=
 =?utf-8?B?WXJkc2tBdkFJYXE4Y2lyd2YvdHAwa1YzZk5ITzVKc3YxUXV2U2NTYlV0RWRK?=
 =?utf-8?B?MGVGTlRXbjdjbjc5cXJyY2h4Nm9GOW1NRDBuWGpqSmNNeHlZUWpnT05WaklD?=
 =?utf-8?B?K0x6WnlvNlJKcUI4SmFCRThvMERvWjgzdHJDM1RQY3ZxVWtON1VZOGZsd0pR?=
 =?utf-8?B?anVPSFNLZ2pHQ0NQRW4xODIzaWE0ZG8vaW11S0dKeDFJck90bTZYRDJOdXRM?=
 =?utf-8?B?WGZJdzFpV2w1UkFkdmMvVndWWmJCNFJOdDBZMDNZazQ1b0ZYaW5ldStqNUF2?=
 =?utf-8?B?TG5EUGNlTHJtV3JCc1ZaNGdYTTFZbUpvM3V4Rk8rY01ZaWQ5T0l0WlM2ZzRT?=
 =?utf-8?B?K3pjaTJaTEYzSlNWZ2RYNVk0bDM5U0p4dXFZYlNaK2kzRTkwOS9iMmRScG9G?=
 =?utf-8?B?UXJDczNrQWlEdkg3V1ovOXFqeFNvdXhTdVh0WXp5Vm0vNC96bW5wS25UcHdp?=
 =?utf-8?Q?ELmovn7g3YoqXqmX2n2mHnFaL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9447d1-eed9-4ad4-d8aa-08dbcf52ecec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 20:52:07.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0j97y2RZECbUhbTIs0Vd+vLTadjkIK0DYEqgL+JstDI9KIGl+tzCzreVQE3FzEb5YW/B35mUMOQWG1aY4Nx6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ira,

On 10/12/2023 5:25 PM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> Add support for decoding CXL Component Events General Media Event Record
>> as defined in CXL rev 3.0 section 8.2.9.2.1.1.
>>
>> All the event records as defined in Event Record Identifier field of the
>> Common Event Record Format in CXL rev 3.0 section 8.2.9.2.1 follow the
>> CPER format for representing the hardware errors if reported by a
>> platform.
>>
>> According to the CPER format, each event record including the General
>> Media is logged as a CXL Component Event as defined in UEFI 2.10
>> Section N.2.14 and is identified by a UUID as defined by Event Record
>> Identifier field in Common Event Record Format of CXL rev 3.0 section
>> 8.2.9.2.1. CXL Component Event Log field in Component Events Section
>> corresponds to the component/event specified by the section type UUID.
>>
>> Add support for decoding CXL Component Events as defined in UEFI 2.10
>> Section N.2.14 and decoding Common Event Record as defined in CXL rev 3.0
>> section 8.2.9.2.1.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> [snip]
> 
>> +
>> +/*
>> + * Compute Express Link Common Event Record
>> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
>> + */
>> +struct common_event_record {
>> +	u8 identifier[16];
> 
> I interpreted the CPER structure as not having this identifier here.
> 
>  From Section N.2.14:
> 
> "For the CXL Component Event Log: Refer to the Common Event Record field
> (Offset 16) of the Events Record Format for each CXL component."
> 
> This implies that the data coming from the CPER record starts at length.

Thanks for pointing this out. According to Spec, you are right. Our 
records did show up the identifier. Hence, I added that field. We should 
probably fix it from our end.

Meanwhile, I'm taking a look at your patches.

Thanks,
Smita
> 
> I'd be happy if my interpretation is wrong.  But if I am wrong then there
> is no reason to duplicate these structures which are already defined in
> cxlmem.h
> 
> I was plumbing up the cxl code to make a copy from length on and splice in
> the uuid from the guid passed from the Section Type.
> 
> Ira
> 
>> +	u8 length;
>> +	u8 flags[3];
>> +	u16 handle;
>> +	u16 related_handle;
>> +	u64 timestamp;
>> +	u8 maint_op_class;
>> +	u8 reserved[15];
>> +};
>> +
>> +/*
>> + * CXL General Media Event Record - GMER
>> + * CXL rev 3.0 section 8.2.9.2.1.1; Table 8-43
>> + */
>> +struct cper_sec_gen_media {
>> +	struct common_event_record record;
>> +	u64 dpa;
>> +	u8 descriptor;
>> +	u8 type;
>> +	u8 transaction_type;
>> +	u16 validity_flags;
>> +	u8 channel;
>> +	u8 rank;
>> +	u8 device[3];
>> +	u8 comp_id[16];
>> +	u8 reserved[46];
>> +};
>> +
> 
> [snip]

