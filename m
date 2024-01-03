Return-Path: <linux-efi+bounces-312-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744448236F6
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281552878BA
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A071D558;
	Wed,  3 Jan 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uadEwkVA"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4B1DA20;
	Wed,  3 Jan 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6EYbLzbzugsuhDRrNCqKJsOZ4NOY/xZCzNnwoPEMvoKfAI8rRG603xf/o1xnAIloiyX0Gm4vxdgImZGmuUDQi04THTSOu378gAMn2WQihb1hCpny1GwjfBIalDaetvLPiBJjoQKkSA3VpxKeev8rpTURTpLmEF6iv79OdRW5TRmb8mx9TrwXaHfKU+TqZp3vurMhatyHtpMRHgjbQYljev8CN7PyYmn9STUEP0dctZJN6Z4X1FK2abQGEyCNHjVr4CfIP/LnxLQvLcgNMd55FjFVp6wAMyR6zxEsmaY7ytxlxGWraOqppKQycsikwS4iUAUBUu+PubFSfDp/ld5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ1GJs3GuWXcRoT6T9WwhuB2Q3WkLvcWHIqAZecqi6c=;
 b=iGRJTaachlGTGvoJrqCSxh44EFhkXLllKOC4eMK6okzNEreUImEyvrUo9WwgDg5aNNnpsp1dfLb+VUFO/BQzphDTYQWUn6QiXj8CXBt9lZ//5RppZlqEpTxMJP0mmUx/JXtb9/EPi4uy//J9PUweZ1N7cO6P5TkhY4nrKUUM59zoAFUXNPCqTekpB26DmJwBlVsXzwJuxouPvBW8O30ywrI3u8qnpn7IpP3EVOs1idU0nt7m4Kki+KDlbQqvj6i5+NTmKkR3wlbZ0NJaxWyrEEkmbvmmyXwU5thVq/Zt6SMnNm/PWfCrjOtyhMd7Oa3E+hKRB8rLUCuBsLWqpHCE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ1GJs3GuWXcRoT6T9WwhuB2Q3WkLvcWHIqAZecqi6c=;
 b=uadEwkVAJmcb41Eoc4H4mJ4Wrb1jCT6ybgsFGBqsigZ4zWpHnWIaKBgNn2gZrnyRcFQ9Jju822W3abRqoP1k3ZQk2Jb/ibKxCZdefDn8mmRILsLXJMLQ5db38U3j/Hd0gqdUrpn+UXiRUVGRawZLuhx59IyiZ1jzzm8D5iJh8l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 21:13:55 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 21:13:54 +0000
Subject: Re: [PATCH 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
To: Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-5-Smita.KoralahalliChannabasappa@amd.com>
 <659471b5f33bc_151dc129479@iweiny-mobl.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <4a69aa48-bf42-2815-863c-0caefdb23c68@amd.com>
Date: Wed, 3 Jan 2024 13:13:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <659471b5f33bc_151dc129479@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0daab5-b1ee-4cb4-50f0-08dc0ca0e47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5EWjdJt/hDZUDO4SmdEbV2/XZIHCUWaavU13PJ/REeIfGyh2x0rFzBpx3udcjvclr6YyE4eD+B0HyItK6/VJsAvXlcEgfI7Us+c8W0zxbF+pH7hwCEE9z55oJhowbISanGbkHfmc3uUiBPNXGGUPT1S5k+tSmIgLY7Gc5eqECjyK8R77iBnFd5eLlgBPhuuiruLlIjhpYGIN/BLOpHIiM657fgBSUQigwRkN15atC1dsdQSNsh4FH/zYzDlwHbqO9mqLfSfGib/TN4S15+DB0bsBay2tvilCOZS9rfDmZ4TJC8ZW+mj7dfVJlNTXnl9iFJ7hb59h77q+2d3J5JoFFRMVBlXRW2yv4glmaWzoEyYUuFN0leaxdpEgErobnHxIj+Si0oqqRD4cluf8UAFuGocX0YTVQcp9TL+bH1ft8DIal39Gwi6nM7lETmIwNG4DyUvFuAeYQdSvVR2HwYlP08q51CAgdgSiuVuNiIR5OQnEdoGw3ghMV+rFv0kKOPDD1LMqUUiktoQ+PH/7unTl3LBG81fpryLiUo5XwHjHArHXKjWtiBlOxIiPreRRP6tUSdYGjUhX1cMKXBmDCh/g+fSzXvBQ/x5pcNZ5YqxPwO7LkvXKFeWpfJazf0grW9Apx9+SveC4gxjRG0pfr1PMtSOH81A3Ylm2kKPaT9PwZEflc9ApY3VjngmC08TrUuIv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(86362001)(83380400001)(26005)(6512007)(6506007)(2906002)(53546011)(2616005)(4326008)(8676002)(5660300002)(6486002)(478600001)(316002)(66476007)(54906003)(8936002)(66946007)(66556008)(41300700001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGhIN2FpQjlNS3MwU1ZRbnNmWmlrTlJvbGkxdnhPV3BmN2xsaXNQeThvL28x?=
 =?utf-8?B?eU1VYTJja05zOTZ6dG5wa1lvd2ZJUEpidTBQQWZsRXZtM2pnd3o4RG5aWjUx?=
 =?utf-8?B?SjExYkxNQWtRZk5XNEwrVFo2cnorYTZCRTNqYVE1QUJFY2hmS25sbUNod1Vo?=
 =?utf-8?B?WE9XVEthQTI3Mm9saHJEdURRellBSGtQQ0lYTXlVdlZFb05CQ3ExOGQ2NDFE?=
 =?utf-8?B?WGxUS2hjbnNWcjVLclJYNWtVb2lnR2FQUHVhcllKb3gzQWRsTUJzZVVIUW5Y?=
 =?utf-8?B?QXVuOHlZZHYrUlRvalB3bWJuU29yRTBSb3VvM09Cbmh5QXByUlhIWHc2Tk8w?=
 =?utf-8?B?REFweGRCTlM3S1hwamsxUVhJVndUejRIZENnUzAvR244SnAyWnI2MkVqQ05T?=
 =?utf-8?B?Y0duVkRGd3JpRHlrMlR3bEVJOStVM25FendnL3N4djFkMS9xeFpab2NGUDVs?=
 =?utf-8?B?eENBR2hBNU5IYzBMNUljTnZtaWRHN1VWM1JZZ0NIQXZ3Q01mMFNUa0Y5a1FT?=
 =?utf-8?B?cGhSRVBLbjBjRC9EUHo1NGFFdThBd3NDS2Z4YVB2QXVIczhNdk1zSU5VQSsw?=
 =?utf-8?B?dS82VndTNUU2RHdFUkVoUFZyNGlCRmtoeklwT1IrcTRhaG5ZV2dxMGQ3ai9o?=
 =?utf-8?B?d3RscG8rSTFrQWxCekZBVFl6NmhYMEEwQjhCcFBDclZ6UC84RWE5RjhPMDdo?=
 =?utf-8?B?TlhQR3pDM3oxTUg5M0RQUWRCT0VHaVJPQ2pqSVQyVnB6UjZ2QnNWOFM4Qjkw?=
 =?utf-8?B?R0VXSmoxdU9jN0ZYamJuUXd1MVptRk0zdTBZUWkrOTBabksvT0dNaXh3NExZ?=
 =?utf-8?B?dTlDOVhyY0lubjVpY1c4a241YWJLSjlXL2RGWlJIWjlCcmxrMUhXeDRtV0hy?=
 =?utf-8?B?Yzl4Tk5yc1VZRWFpZ3pPRGZjMkdta3pwcE02bTdXdnZiZFdXck5BanpHNXF2?=
 =?utf-8?B?ZElSVnBPZEJsRjR1OEhTeExycXQ1cTJSbEppeUQ2bkxtMnVzSDZBQ1pJeHhx?=
 =?utf-8?B?dmZqZ1F0YW9DR2ZWOFpMejI3N0RIWCtUTGdDeENSZmswOGt1cUVlT0cyOC9S?=
 =?utf-8?B?ZU9YY1VNMjMrVUprd2YydFF2SllMU2ZITlF3M3pVMFllUkZCU2Z2V0J5WnZl?=
 =?utf-8?B?OG04Y2NrY1ZMMnFNeGJ3VVdBbFR5aE5ZL2xVWEhEY0JraVZRMFllTlZrRit1?=
 =?utf-8?B?WG5qMm1wcFVUUXZaNG55Z1hOdjIvV0lXV2RGY1B3alNxN1hUZ2N2RXY2WUNh?=
 =?utf-8?B?ekl2anE5bWVLSFV6OVB1cnJmZ0dNRnVZbHdIMENnQjBRT25YT0NidFlKRlVr?=
 =?utf-8?B?UVdpeWpjdHRxVjhGNHZUWVY2MmtJQzlkSllvLzBpb1Qza3Jva2YxSVYxZ0JJ?=
 =?utf-8?B?K1c2QWJ6aXNFQzJvaVJnY3ZvVVoybVorZjJBRDVZR0t2cWgzTWM4dHptZlJT?=
 =?utf-8?B?MGl2Z200c1pRUUhsenFwWjVDSk1GYU1DR0JNMG5KVnZ5SE5zZzAzbi9tUmNx?=
 =?utf-8?B?TU5ibUlFcDNYUVlVcWJrY1Naemc3UkZaZDBIT1pVRjhzOExnbDNhbS9kWXR5?=
 =?utf-8?B?ei9nWHFMdVBoTFhGUWx6cWR3RmY4TzNYUUg5blJOZmdTYU9SZlFyaVRWcW41?=
 =?utf-8?B?clZuN0lPQnlRTmRUeG52Qy9GRnRQejA2YzJrK1hudHFyc1Y0RCs0MXVxR1d1?=
 =?utf-8?B?bkYzSmtNckJ3WWJ5cWNkcHdqQmQrRUo5SVNYOHdXR3pKNzlzRXg5UkFpQjRL?=
 =?utf-8?B?Vk5BUm5uTE9oUTV5SEhrbmxhZnpYam5uMUhEY1ZMUGx4U25ZNktPVkR1Nmo5?=
 =?utf-8?B?bTZDNDdVQlFiSUJGQlNDVmR3Vlo2RFdYZ1plVmd3YWRRYU1meHFvdkV0cG9L?=
 =?utf-8?B?bHQ3RlBIL3FLeno5YnlLMFFDYU92YXA5VDRhdjlRdDJMQld0elY4YWw2U0to?=
 =?utf-8?B?QmxVSXBsSk4vc0VKVXh0ektmemlFanoyVHpueVJBam9pM201V1FMS3RFbk1o?=
 =?utf-8?B?MlJXVWttTWVPZ3poNmpTcHBHbjBkWUsrd2xialdzSTBmOFFvUFMwclpodlBY?=
 =?utf-8?B?aVRzMTlXRldIbkJuSDJNdytDRlM3UlBCYVB5WVNKam14SFJlU1U0c2svWDlt?=
 =?utf-8?Q?PUgIxq9ALN80fevJrAq70KiQB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0daab5-b1ee-4cb4-50f0-08dc0ca0e47c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:13:54.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLBrVPz2pCHKSMmE+PecBkIqyjpO0xiVPerRrPM7BOV7vwdGH8oqb2KwmbVoSTdGjSwr9V5PHK5lJS4bzP+Lcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296

On 1/2/2024 12:27 PM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records. These CPER records obtained from GHES module, will rely on
>> a registered callback to be notified to the CXL subsystem in order to be
>> processed.
>>
>> Call the existing cxl_cper_callback to notify the CXL subsystem on a
>> Protocol error.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
>> them to trace FW-First Protocol Errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> [snip]
> 
>>   int cxl_cper_register_callback(cxl_cper_callback callback)
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 37e1652afbc7..da516982a625 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <linux/cper.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>> @@ -836,6 +837,51 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
>>   
>> +#define CXL_AER_UNCORRECTABLE	0
>> +#define CXL_AER_CORRECTABLE	1
> 
> Better defined as an enum?

Will change.

> 
>> +
>> +int cper_severity_cxl_aer(int cper_severity)
> 
> My gut says that it would be better to hide this conversion in the
> GHES/CPER code and send a more generic defined CXL_AER_* severity through.

Ok will change.

> 
>> +{
>> +	switch (cper_severity) {
>> +	case CPER_SEV_RECOVERABLE:
>> +	case CPER_SEV_FATAL:
>> +		return CXL_AER_UNCORRECTABLE;
>> +	default:
>> +		return CXL_AER_CORRECTABLE;
>> +	}
>> +}
>> +
>> +void cxl_prot_err_trace_record(struct cxl_dev_state *cxlds,
>> +			       struct cxl_cper_rec_data *data)
>> +{
>> +	struct cper_cxl_event_sn *dev_serial_num =  &data->rec.hdr.dev_serial_num;
>> +	u32 status, fe;
>> +	int severity;
>> +
>> +	severity = cper_severity_cxl_aer(data->severity);
>> +
>> +	cxlds->serial = (((u64)dev_serial_num->upper_dw << 32) |
>> +			dev_serial_num->lower_dw);
> 
> This permanently overwrites the serial number read from PCI...
> 
> If the serial number does not match up or was not valid (per the check in
> the previous patch) lets add a warning.

Sure will add.

Thanks,
Smita

> 
> AFAICT they should match.
> 
> Ira
> 
> [snip]
> 

