Return-Path: <linux-efi+bounces-311-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AB78236F1
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A589E1C2464C
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280431D559;
	Wed,  3 Jan 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UOKLcpbe"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635831DA21;
	Wed,  3 Jan 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGk9raQDTF/lNYw/1pR3t9jdey5tiFnCPt+zTR0kDSbYn9CU4PGFG10nw//pOqEKy7LEcl+UjJBwew2/Ao5NeOUFyIxTR93RvILUwOgS3WlUzctj/V8O4CpuRZ+TIufo14igCtBF2mJhxjyrxubQucmgUAEtXJSXahlyL6C+jmT3NFsyXoyhpeeUIozaUxPuDiUbF/7juoy4Iiwv9JmwkCn1J1xRIzrxtJk7mYGASzt7P7z2fNpkwyyKSSy8NB9GBMXs87zig1H4lYDcmsbOPN8DRyiC35uZTbzIugg4jhnGi5rgCdU80F2beVxy9nyUFT3rJqzUqsuGflKhVrDwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WseXu5UVX9/EaeCoEwG2x74Mf7APPOifWZ8u77DDoQ4=;
 b=n4CN6X9/EzWISnknXrgxjYTcIQskky/UbFRWOASHfGlzJmGD8eGuWR0FGfFk7kpq9FBHs/eYWY3pNMMSh30hVbiH+EwuBoUQr1hon4u5MI6j9HNJ/sogKFeCur/zY9/iu+8HpojCUTaY3FBSuSOHSAhDIu2khoyd4l2rGEX8aIwaVY/NNmCf7X6pm/AeA/63o0wyAubcPGtJW42J5UW+Mu9i5To05GzURJzQWSI/oT+dPL73GXYOw6EryvpcD7pIhx/5H0t42++eYOoAJIUySOrM1Cg0prZ9SwtwacO83b6HvSeONORyTHMxzL4ICIH+OEID4pKS8TkYuq5/XTZmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WseXu5UVX9/EaeCoEwG2x74Mf7APPOifWZ8u77DDoQ4=;
 b=UOKLcpbexUCt6XxJznsVG+QovaNr6P41kPAOpzZEyfu4kqoJojPvMNNU4TPClKTG5MQ8rmI5ScRTaZkcZGQ9RSjwUEPt9xpJsnKdjPjJRuwUiRirG6ricXfAEgC+PIiGk2f1bRIDa+kSwpAZ2jnBp64m11Tshwe5tMaJ5Gb/cKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 21:12:08 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 21:12:08 +0000
Subject: Re: [PATCH 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
To: Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-4-Smita.KoralahalliChannabasappa@amd.com>
 <65944ec1dccee_151dc1294f3@iweiny-mobl.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <66b7feb6-b151-ad97-0ee4-3fd7da7137eb@amd.com>
Date: Wed, 3 Jan 2024 13:12:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <65944ec1dccee_151dc1294f3@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d38f2f-691e-4cdb-ac70-08dc0ca0a4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MtJrKU0m16eELHJ4PoNGYYX/HNy5XxChMGGYpbd+7Xjcb5jb91HQU8fNKHstCePnDdQKa8bZH3mRH1vx+ZMJewl1PzAoXoggnpkAFG0j3pAOFTQkY8wveFTcm3Z85C/nfcYkMO2H4sNGFuCNjX60/qL5ZFOtrf3P+AiIs15h3SrNMv4UvZfLwPvkVnTdmQ+ZejQeh/lVgeAY2vekU0bQQ6Lu1kYIu8ZbFtpSxlu2TZ8d5e/5BtQAK8yjvAwvqSkkKSJbqDyH2i4nBtSXkFRdqVOpe48CCGh7DOBT/QEFgGjNo47eGY3csAu+ytaWhBRuQzfiuIq0lgPe6fLKjurW8u6MFhrskZUET855J5etNPn94uKXpkRF7khaPGKZ2ZmrLwDNYYXDDZ+UVITsuQ12tF/O58gSpUWLTqslrKwKNPDhZ08EAMc7xoDHiiMprz2KKf74DvlxytgEgAP1OuIEZ5YOCjLz8gFP54FrVgIca7eJY1ifAfswOjg5OTybuUbyeguMyivgOxBdyVZChFpUknAJ+rRZ7tnHyuzHuGx0GQTGt9T0uQQWl0WCkoABASFnaC9u4ecyB99ei7FHCq/NqanOt+WI3HsZ8Ot3GOSD9dsIHQLdD/PgqBN5kCKGgco3mOqBccP82mVZVuytL4U6VQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(83380400001)(26005)(6512007)(6506007)(2906002)(53546011)(2616005)(4326008)(8676002)(5660300002)(6486002)(478600001)(316002)(66476007)(54906003)(8936002)(66946007)(66556008)(41300700001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNTV2EyaHFvL2RaNWtWNnZ3VGV4OXBKT0VRa2t4MFhEcXc1bVB3NWNIVVU0?=
 =?utf-8?B?eFVpUnpGeDJxdXh2TmtUZnhKbVlzVkZQRGpYbXpiMEZCVjFVdnAvV1VPSm8y?=
 =?utf-8?B?SlM4bGt5U1laSGNMVjRjZnV2MlFYTms4Nk1SZS9INng3Z3dYMUUrVm90Snd1?=
 =?utf-8?B?ZmNldUdjWkRWQU5kcllDS3RLR1RkRzUzbHoxN05WYjNvaFg2b2hDbG9wcG44?=
 =?utf-8?B?Q3IvMDFZUVQxcW5PNU5ZK2xLdFhBZ3JGS0JiVytLdThzb0VzdFI5SS81TnA1?=
 =?utf-8?B?ejBXdVZSeDlZWFJjZHBDME0yckJLRTRPcjBsczZGWG5OYWRJMnlkOHRFY0dE?=
 =?utf-8?B?anpzT2c1bWN5OGMwNytJdjNRNE9yTVRQODluNk5HMlVXUCtQOUVtaTJrc3A1?=
 =?utf-8?B?Uy9kb1BHYVBVTHUxMjM3QmZtRHJCSEoxUlk0RTE2MnV6dXF3Vnl5OFFpcjhm?=
 =?utf-8?B?eTFBUHZMTDZIS05jd1ovYjNDS0k1clU1YUdYcGJTRkdGZHp1bkgvNWFLR3FG?=
 =?utf-8?B?WXExY2hVSnY4NHF0TmtBL3o5M1J2VS93bi9zbUJ0QTBUYjExOUg3eUhKblIz?=
 =?utf-8?B?SlNHVlBFQnF2VUZIOWx4OTRlcEQ5Ry9Mc2RMYlgvdkJUN0RreE1mVnRzakFs?=
 =?utf-8?B?MHJjU24wbjJuVXAwVEQvRi9Cb2d2eEsxNmR6Y1VibmpYV0NPT1greDh6L0o5?=
 =?utf-8?B?YjZueFF6RWw4R2JJQUpjMGJ1VVJSQkVBZDFmajJuRjU3R0VXSktVTU1oZCtG?=
 =?utf-8?B?RzlVN0h2clEvcWw4TEVTQ1g4L1J6RnF1MUxpRFlaSnA0R2RLaURZbmFWbGlu?=
 =?utf-8?B?dUZDOGhxL1JWY1VDV0R3bVFxZDU4UGdjcE04TTlYVXBzY2RDS2ljaUN2OTdL?=
 =?utf-8?B?NmZZTmJ1SWZJMG9OT25IWWc1UGh6MThXWXdYK2dBYTliTHUrMW94d0QxSWtF?=
 =?utf-8?B?TGNLdEZxd2NKMmYwRDdFT3FyeUJFL3J1NHdLUUE2MUhqMzlFMXpicUVZMWVm?=
 =?utf-8?B?ZzZkcm9HVXpiSWExUDF3ZXNiRTZlODJ3MXRDdEwxL203QzIwUmxxWlgwdVlT?=
 =?utf-8?B?ZkZTeUUybTlEM3hFdTdPbWlzTllwTVdsWktlS2MzQU9uMVdmcGZBYkZ2WVMx?=
 =?utf-8?B?TVRzRXMwQ3lzQjRzRi91Y3Rsamk3c2Rja0NBTDBOa1VCNk1PRGZaSmNJUkM3?=
 =?utf-8?B?NlpyUXh4amdkVThhSXU1RFRBc0VMVnpJTkhoU2c0djhlR3pvU2tiaHdSRklj?=
 =?utf-8?B?ejVZaFcrbGlMaDJxTzVTc3VyYVk4NXRaRllMeEZ0MHlGREJ1TmN6SFJ0a3ZN?=
 =?utf-8?B?UTJ2QkJhQ1g3NkdyTS9XbzhVaTBadW5hdHpVOWdrZ2FlY2VRYjh3REpJTU9z?=
 =?utf-8?B?ckluQzZFSC9kRkoram1FSFpGbDhtaWpJNHNTUkw3VmpOS0FhYVRXYmw1VU5y?=
 =?utf-8?B?ZW1TRDIzWHNySUdJNUgrVnQ3QmtiUU5zbWxHQzVBS1pLYXNTQnFrV2FPUzV2?=
 =?utf-8?B?UFMwMWdYNkgrRUgvWGVWTVFkMmJZUURZRk0ya3dzMEY2bFhzbEh2bjJ0UTMy?=
 =?utf-8?B?czVDYmVESXZaaWI3OW5kbG9jb0UwTEcyeGVjWk5BdTBTYTRORC9PRFpIQldP?=
 =?utf-8?B?a1QyV1RRQXVINy9oQjZHcW9WN2xHU1NabS91eGxvQU5ja1lsWklRS0VBTTMr?=
 =?utf-8?B?ekZuK3E3N3pSUzVRWllOa01ZNkZ1T01QL3lxbEJ4UlQwV1FMYXJDWm9WeTVh?=
 =?utf-8?B?Y2h3eGhVaUc2ODN0RE5PU2FKNFRKeXBoZFhTWHZsRFVTWTNmSmlUayt1Mmt4?=
 =?utf-8?B?cUxSNU1xTmtIa2FCMDhzaDRvYUV3TnZGcmpZQ2V1K3ppb0UxRWlVbE1PQUVm?=
 =?utf-8?B?Wm1BZ2JnK3dhNm5lOFViTVBoaHdzY21UTnJ3bG5nZmJHR1krS3YxWXU3VXRQ?=
 =?utf-8?B?YmpiWTFPS1NDaTg4ZldoVlo5RHE4c0ZPNlFYaitLamswbkRkRVpKK3pmbUxX?=
 =?utf-8?B?ckppdTdjeWR4c3NxREhXbWpmVXBvZHJPeGFpRUd0L29uSWUyQmpSZEprbzhF?=
 =?utf-8?B?dE5WdVB3ZWdsRVZvV2dNQjI3QVF6KzQ5OHIyRXFBNlN6NDFyRXIzc3RGZnpO?=
 =?utf-8?Q?45cGkcFA8INTUEVp2Fr1oA3Bz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d38f2f-691e-4cdb-ac70-08dc0ca0a4f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:12:08.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlE70MO2n0X3PaIIClCtKYT27R1OkYYgbRcgTcxJmsmbPtPR6DZUOBQxCduiMMJ1mXuHTCMKKu7jGbECphPtRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296

On 1/2/2024 9:58 AM, Ira Weiny wrote:
> Smita Koralahalli wrote:
>> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
>>
>> Add GHES support to detect CXL CPER Protocol record and cache error
>> severity, device_id, serial number and a pointer to CXL RAS capability
>> struct in struct cxl_cper_rec_data.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c        | 15 ++++++++++
>>   drivers/firmware/efi/cper_cxl.c | 52 +++++++++++++++++++++++++++++++++
>>   include/linux/cxl-event.h       |  6 ++++
>>   3 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index d6a85fbc0a8b..6471584b2e79 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -714,6 +714,18 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>   		cper_callback(event_type, &data);
>>   }
>>   
>> +void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>> +{
>> +	struct cxl_cper_rec_data data;
>> +
>> +	memset(&data, 0, sizeof(data));
> 
> Does this need to be done?  Could cxl_cper_handle_prot_err_info() use
> something like this initially?
> 
> 	*data = (struct cxl_cper_rec_data) {
> 		.rec.hdr.dev_serial_num.lower_dw = prot_err->dev_serial_num.lower_dw;
> 		.rec.hdr.dev_serial_num.upper_dw = prot_err->dev_serial_num.upper_dw;
> 	};
> 
> The serial number is always set even if it is not valid.

Ok will copy serial number at the beginning of 
cxl_cper_handle_prot_err_info() and remove memset.

> 
>> +
>> +	if (cxl_cper_handle_prot_err_info(gdata, &data))
>> +		return;
>> +
>> +	data.severity = gdata->error_severity;
>> +}
>> +
>>   int cxl_cper_register_callback(cxl_cper_callback callback)
>>   {
>>   	guard(rwsem_write)(&cxl_cper_rw_sem);
>> @@ -768,6 +780,9 @@ static bool ghes_do_proc(struct ghes *ghes,
>>   		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>>   			queued = ghes_handle_arm_hw_error(gdata, sev);
>>   		}
>> +		else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>> +			cxl_cper_handle_prot_err(gdata);
>> +		}
>>   		else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>   
>> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
>> index 4fd8d783993e..3bc0b9f28c9e 100644
>> --- a/drivers/firmware/efi/cper_cxl.c
>> +++ b/drivers/firmware/efi/cper_cxl.c
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #include <linux/cper.h>
>> +#include <acpi/ghes.h>
>>   #include "cper_cxl.h"
>>   
>>   #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
>> @@ -176,3 +177,54 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>>   			       sizeof(cxl_ras->header_log), 0);
>>   	}
>>   }
>> +
>> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
>> +				  struct cxl_cper_rec_data *data)
>> +{
>> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>> +	struct cper_cxl_event_devid *device_id = &data->rec.hdr.device_id;
>> +	struct cper_cxl_event_sn *dev_serial_num =  &data->rec.hdr.dev_serial_num;
>> +	size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>> +		pr_err(FW_WARN "Not a valid protocol error log\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
>> +		pr_err(FW_WARN "Not a valid Device ID\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * The device ID or agent address is only valid for CXL 1.1 device,
>> +	 * CXL 2.0 device, CXL 2.0 Logical device, CXL 2.0 Fabric Manager
>> +	 * Managed Logical Device, CXL Root Port, CXL Downstream Switch
>> +	 * Port, or CXL Upstream Switch Port.
>> +	 */
>> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
>> +		device_id->segment_num = prot_err->agent_addr.segment;
>> +		device_id->bus_num = prot_err->agent_addr.bus;
>> +		device_id->device_num = prot_err->agent_addr.device;
>> +		device_id->func_num = prot_err->agent_addr.function;
>> +	} else {
>> +		pr_err(FW_WARN "Not a valid agent type\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * The device serial number is only valid for CXL 1.1 device, CXL
>> +	 * 2.0 device, CXL 2.0 Logical device, or CXL 2.0 Fabric Manager
>> +	 * Managed Logical Device.
>> +	 */
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
>> +	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
>> +		pr_warn(FW_WARN "No valid serial number present\n");
>> +
>> +	dev_serial_num->lower_dw = prot_err->dev_serial_num.lower_dw;
>> +	dev_serial_num->upper_dw = prot_err->dev_serial_num.upper_dw;
>> +
>> +	data->cxl_ras = (struct cxl_ras_capability_regs *)((long)prot_err + size);
> 
> I think this is ok now because the cxl trace code processes the data
> before returning (in next patch).  But I'm a bit leary about passing a
> pointer to data controlled by the acpi sub-system.  At some point the
> event may get cached to be processed by another thread and it might be
> better to copy the struct here.

Ok will make the changes. Rewrote the struct in patch 1.

> 
>> +
>> +	return 0;
>> +}
>> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
>> index 90d8390a73cb..7ba2dfd6619e 100644
>> --- a/include/linux/cxl-event.h
>> +++ b/include/linux/cxl-event.h
>> @@ -154,11 +154,17 @@ struct cxl_ras_capability_regs {
>>   
>>   struct cxl_cper_rec_data {
>>   	struct cxl_cper_event_rec rec;
>> +	struct cxl_ras_capability_regs *cxl_ras;
>> +	int severity;
> 
> NIT: When I saw this without any addition to event type I wondered if the
> series would bisect.  I see it does because the record is not sent until
> the next patch.  But I wonder if the 2 patches would be best reversed.

You mean to say patch 4 to be 3 and 3 to be 4?

And since I haven't used severity yet,  fix it by declaring severity to 
where it is used..

> 
> Also, should cxl_ras + severity be put in a protocol error sub-struct?
> Does severity ever apply to event records?

No, not in any of the component event records. Only place is in "Event 
Record Flags" in Common Event Record Format (Table 8-42).

Addressed in patch 1 to make a sub-struct.

Thanks,
Smita

> 
> Ira
> 
>>   };
>>   
>>   typedef void (*cxl_cper_callback)(enum cxl_event_type type,
>>   				  struct cxl_cper_rec_data *data);
>>   
>> +struct acpi_hest_generic_data;
>> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
>> +				  struct cxl_cper_rec_data *data);
>> +
>>   #ifdef CONFIG_ACPI_APEI_GHES
>>   int cxl_cper_register_callback(cxl_cper_callback callback);
>>   int cxl_cper_unregister_callback(cxl_cper_callback callback);
>> -- 
>> 2.17.1
>>
> 
> 

