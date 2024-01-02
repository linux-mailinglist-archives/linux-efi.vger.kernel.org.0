Return-Path: <linux-efi+bounces-294-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C664F821F6F
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721C1283999
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF814F6D;
	Tue,  2 Jan 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vSu3DRPA"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BD14F63;
	Tue,  2 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGfGP89IJqEronp1mWfjwKqQato0VYdbooiIosi+HBXtJIp2ZK5ZLtt/yczFPQ4TwAAdGw44+P8mERgLzF94I3mApTmnWOmf1+WAaOzjpmETMCSK7ibkI+Ct2wwUaRMzhhCbljolT8Aa6ABVu/0WHA4tJY19UpmvOqGuHXUNsQoRsh5OYlO+4wvWYZj05WSYwN6prDILfZllBCqMb3oHsTZLxP+E1CENiy+0kbrcPWIwdqD/gOdUF/PMmqwlipjkup5dzjGtD4/OiWY4B5IBckTOO5tRbMe26StNiX7i6UerbBdIxQEEkaVDlX12ZNPnKmZbilZVM5nUjWYZlkiulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWiom1TaxWY0+jUhg8kXoh0+zOvUSmPdDkOKcWVcPyk=;
 b=E+2fcsQPsdeKXm1AkDMfHYkx4k6zqm6XQCpFraTfn8cVKrSWo5+IbM7d6OmzF+Ie2tqbO81GKhhozorVOFMV9opC6f0qIFo9ZL/jF0SCEg64buOQueDudlADH/1sN+7Z92ckWf9I79I2GbsRfBiv/q9UAEj2E9NhgSzfICVFsL1MHDxABBZsWD4EgwBoUgzUZ8OxdLjo/z8/kY14aS8vTcEVi2qFamLXFMVO64wBKpV5VDobOFi1B3/1sUjPcCeqO8UHwBTuN743RT7uxxe0KQ9Ga1wirOCJOCrluZix1DANzAMaNT+QLjDRKTZ/46za138tar17ChqeW1fL2F8AWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWiom1TaxWY0+jUhg8kXoh0+zOvUSmPdDkOKcWVcPyk=;
 b=vSu3DRPAUzAWjlm0MOUdvk1g6AESgRLDbJMugjFC420xnFHeOIh9oH/w2WaUZGrTv87m7bOsIS+3hVCstCVxZOc02arpa/bUrZcwJ4Y5EqMBqY4y7n+/xuaXo52OCG9me95pyDCWmfZXklW+X9Kb8qKBVdMa2RUu5gK/BNul4Tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:26:07 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:26:07 +0000
Message-ID: <b2c4835d-0076-47f0-b0d1-792dc32cc305@amd.com>
Date: Tue, 2 Jan 2024 10:26:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/efistub: fix the missing KASLR_FLAG bit in
 boot_params->hdr.loadflags
To: Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Dionna Glaze <dionnaglaze@google.com>,
 Nikolay Borisov <nik.borisov@suse.com>
References: <20231226140250.224516-1-ytcoode@gmail.com>
 <CAMj1kXGE9JUoPUqBMJkwVUco67dEa8N95=gMJwE+Sj1ux1+5tQ@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXGE9JUoPUqBMJkwVUco67dEa8N95=gMJwE+Sj1ux1+5tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:4:60::18) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d4910c-5466-4d60-d087-08dc0baf85f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KKRjZmmXPojIfp7vs8wbQQ4zejMukyY6JbnGfWNaBa0UpWFTMwAoVIlix3VRHd0y3p7pgeHacXfJTNg9hy91BrswOwLAMAtv7Rxnksxqv6FDNufE+YEbahRpbyLGUAbz6fxbGuUXRscb5BaBM8haH/Q1YTOumD3q0bIxGx9WO+goxmGFGfCKl3Rh0UiOk2qDNGeOldrIl7r41zFeOD7SiuCqu1uAWxIXxtbhDgxJ2xyvFNX9PaWla2wprYRK0hES/Sm6oBc7rL/dSx9kkEq4KH4V271HJfXpufxSAE1QhpHgF49GRPDl5wlMLfD3CDfCMPufWz3PjSgxj7awXLuZDsvZpnpDCjdceEpoj33kq8IMvUibU0rurVEmqy3LV0/nGEx9in4M2qjFnGqhXicLkbfJnbYTow8kHZ3qKhvZzvkA8T0CKRVjMnsD5Sm1CQzG3LsQ3mOJtHVhmxAQ90mPiMSg2d0nFYki0J67FhUZ9IS7d3MEzxP5Tqata+HlysRMsAiMuk83QWpZ4nbiTbYVNpAbVmHGckt1L2zI8NZwjKPamiCR9C3z+DeR3VAASjp/fy3OA6rW/pXDQ3/wTyUCcMbdCSUeIzYSbmbKXIQVYCYNX2nXxzrr170HDhXORxklvBSvkdNAXqP/lDo3jv2VAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(36756003)(31686004)(31696002)(86362001)(6512007)(53546011)(478600001)(83380400001)(4326008)(66946007)(66556008)(66476007)(6486002)(26005)(316002)(110136005)(2616005)(54906003)(8936002)(8676002)(6506007)(41300700001)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clhLY1JFRFBXM08xODZOcCtjNHJRNHpuL2RLYU1lTThQdkVYT1oxRkROcXIv?=
 =?utf-8?B?c3RiL1FVRE01YUVTdk0ya0JxQ0ZwRkRpSFVUN29QMmNQQkNveHBrWDd5V3BX?=
 =?utf-8?B?aFoyWnphSi9qY25LQitxaWNmSVhpTjFwWmYzaWNuZVhNa21QWGpHaE5ZU2R2?=
 =?utf-8?B?b0UvZlJwem40bUlDSlRKODEwNTJDRGYxSVRHQjJoNGh4K3JHeTBSWjQ3T3NH?=
 =?utf-8?B?UHIxNSs2OGZlVjdSbmpXUlV5c1ZsNGoyM0VIZmFXc3RXbjNHOEhnWGd4VnNn?=
 =?utf-8?B?L0EzeCsrSzQ3bFN1b1QwdlJZQkZta2J4SFhiQlJJSElheWJ6Z2plUzhmVWox?=
 =?utf-8?B?SEw3Y0VYbjgwRmdqcWpSVnNORFU1bEgydTIrbGpaWTAydERnVFNOZ0VGQmJj?=
 =?utf-8?B?SlJ2Qi9FRlhLUDBDTmZqUkxjRUFVSzV5R0JRNDF2UlNyOElnTW4vNUJHKzRE?=
 =?utf-8?B?MzhKLzdRUTEyYldUNnRwZ1krZ2JhQ0tpTmoyVkZCdGozRmtsMHlja1JiRFpD?=
 =?utf-8?B?STI5OWNDdzRhNy8wVExIbGU3VjRMcWtxK05zdzdwbWgxUU9jby90ZVdyUnl6?=
 =?utf-8?B?MDZaUzdjOU04aXMvNjdjNWxVb1RQM1pDRlFNc01yaDJ3aU9JWVZ6Wi8vc1px?=
 =?utf-8?B?TTNVMlpwM2NWcEN2UVhDRkkxV0prNmVtTlN6bzYwUWcxY2RTRk5YbCsycW5y?=
 =?utf-8?B?L1d0MDZtTHJUMk1EcFE0UHduTXEvWThzTGZlMHV3dVlxakZ6RklncTVVOEtP?=
 =?utf-8?B?aFg0ZWtaU0pRdDVYU2kvNmw5TUdzbHBKNEY0VjN0Sm1LNnpuL2c5MXZuZ2Mv?=
 =?utf-8?B?NEZrTmFlVk5nQksvVTIvbFk1OTdOcjVES09OeGp3aW5sZ3RFWmRua3VoV0l4?=
 =?utf-8?B?U0RHcnRCazFmMGZscGVVQlRkeUR1dUNUb1F0cGU4K0JmNmV6SUtiNHcvZ0Fy?=
 =?utf-8?B?U3hlTHBvMFRrc3REOUZTRld2NmpMc2dzYmh5bXFsdHpZZllXYm55b2p4cXJj?=
 =?utf-8?B?K3gxRlg2Mzc4dDF1dzZNRVZjb1FDc1oyUHBGNE9PNTRDL1huN3RaTmdpeFFh?=
 =?utf-8?B?MEJ5eXZVejBVSTNwRmI2cjhhRmlPK1FickZ1emNCNDNya0pmMmRRUlFrV1pS?=
 =?utf-8?B?b3ZZMVJuWmhheUUyWmx6NmJoYUhlRTYvNGVVMnhZeDBhUVNJRGdDT2EvRVNZ?=
 =?utf-8?B?L0VISWFIQXVHTi9jTi9GVG5mTE5hWGUyMm1KaVh2SXZIQjBqVHJJNkhLTEpx?=
 =?utf-8?B?bG81cGRVaEx0T0hnVm1tV01nOXJwcVVFaFovNFhEcjdISFdGRHl3TDdHQk5o?=
 =?utf-8?B?MlRERjNhdHZyZUlzUlBYYm56akJlZGx5emc2bFFmQ1lRVHpmS3E5dzhHalZ6?=
 =?utf-8?B?c3VKZEhuTm5ITkZFNXJKdHRDb2ZONElpMzVhYllhYlp6WkFyeWtWaWVXazhw?=
 =?utf-8?B?TitGVjhjQkEvNlFMODB5UHVGSC9VclV3clVNbWJPMUJXVTJodnBmTy9EeVQ4?=
 =?utf-8?B?SEluSXNxai9VVWhPZFRQUWYvN2NJcFd6OUc5VlpUVUdjL2Noci9valpzL0tv?=
 =?utf-8?B?RWN2ZUppNXAvbFplL25HYmROWGZuUmNEbEROcWFtWUhjbTluanVsdHJ4UmlM?=
 =?utf-8?B?bEt4NFUwRHZEM3I2TEdzZ3JZNVhnRTZtS0FGSlhSOVVxRExDcGo3eGk1dmJk?=
 =?utf-8?B?ZFIwYnZTaFA2ZVUvNlBqakNBem5nbmRMeE5mQUV2aXpnYWVNQUp6MHZmR3dI?=
 =?utf-8?B?YUk0Wm9BWXd1K0k3VmU5azMzSHlwYU5Mcmw1RS9WdDlMaTRiK3NIR0JTS0Vm?=
 =?utf-8?B?VGVZVm5ldTdDdDUxSDBwbnRXRmp3ek84QzVNK1ZnaGJtWmR2cEs1Y3Z4SzJn?=
 =?utf-8?B?Wlo0RHdScjFCaFVHc1ZBMVlpQjVhQk40SFZUb0x4QnNWcy9NMFVDVnh2QzBK?=
 =?utf-8?B?aXdQakxiczJ6RnRtTFZkVnlnbUQrT0JBVFdnMXhmYWtuOEptQks3VFh0OS8v?=
 =?utf-8?B?Z1RYREZxdStYaURWTzhWY1ducTR1RkR0TFRXRkp5WlU5clhRWmpPWm9IN0o1?=
 =?utf-8?B?ZG1hcDBzTFFLNlQvK0I0U0p5dXBDb2dmSjQrbHluR1VNdUYyZmpmOXdRSVdZ?=
 =?utf-8?Q?Sv9wWAiOWpIgI2HrLsm9w3Svf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d4910c-5466-4d60-d087-08dc0baf85f5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:26:07.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aMTvbz5oKnGyK+1hQoUPh5fyF8gjD1TWNbFPzTLvC7ZSr8zKp9f3WJh5GhE9jqJ5F+vfmmtaqpOag0OLMvIcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390

On 1/2/24 09:29, Ard Biesheuvel wrote:
> On Tue, 26 Dec 2023 at 15:03, Yuntao Wang <ytcoode@gmail.com> wrote:
>>
>> When KASLR is enabled, the KASLR_FLAG bit in boot_params->hdr.loadflags
>> should be set to 1 to propagate KASLR status from compressed kernel to
>> kernel, just as the choose_random_location() function does.
>>
>> Currently, when kernel is booted via efi stub, the KASLR_FLAG bit in
>> boot_params->hdr.loadflags is not set, even though it should be. This
>> causes some functions, such as kernel_randomize_memory(), not to execute
>> as expected. Fix it.
>>
>> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
>> ---
>>   drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index da9b7b8d0716..b0c68593ad40 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -787,7 +787,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>>                          efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
>>                          seed[0] = 0;
>>                  }
>> -       }
>> +
>> +               boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
>> +       } else
>> +               boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
>>
> 
> Thanks for the fix.

Does it need a Fixes: tag?

Thanks,
Tom

> 
> I'll queue this up right away, but I am going to drop the 'else' part,
> given that the KASLR flag is never set by the EFI stub so clearing it
> should never be needed.
> 
> 
>>          status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
>>                                    seed[0], EFI_LOADER_CODE,
>> --
>> 2.43.0
>>

