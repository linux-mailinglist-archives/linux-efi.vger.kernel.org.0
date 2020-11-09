Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D7A2AC3F4
	for <lists+linux-efi@lfdr.de>; Mon,  9 Nov 2020 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgKIShE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Nov 2020 13:37:04 -0500
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:60320
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729292AbgKIShE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 9 Nov 2020 13:37:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V89sTxdMafPQ/kqGIQSd2cIBVXLxtNsGN9wKslF7fTzcRqOGqVjobf27dIInSPLRzo/zK0A90ringI8nL88JTy1FEqbW+B9KunMQb0FJ98WOZCn/OL9Knee55F09Jc/T39nlZDrCJ2Uiy8OTVAfgPnpa5LgKCIfaQjoi5XJLueh5YjKLgOKrbvsNTyaBrFe6ms6/TxfNPvY4YM8cXJQlaich+7munh3A0S2uLIDpOZe0JyQgOI382x/t5R/bRasY39UbWtc8odAAFHUz0nuKmIb9hL2hrbSiMnP6VqmmZZWW2nVReE9EeeQxsRkoycY6WX55rDts70Cdu8X0xGwiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9SM8rmxfdkLhMGLkSWg0Ai1ugEAOwJ7wuq2wjbUank=;
 b=JnfpX+iBoPWKV2Wi52FYWCPlrlwnEgTuP4WmDbipy8KkKR/5e16nSTFhLjp0SsDgGDWeHzN6biokK22KxJ5JPlXK/hdaUi7Nbknk5J2CsW54NNt6dl/LTwbT4Q1pc8k1S/x4LBGcB9FcUslQxFkcNDU1vh2HPqkpSH6uHIEpMQwuKdGdku85oVQtXGzpLJRvTn/CDj19105iFzBVggz7Ospgh6tMCtkdAqyepueWXNcTgBa9Ut7yEluKfKyQmRqtVNPEINCb5umdWLcbX8p7yW9w52cWXeesbkLTafWNSY8Zec3DrJKpp4bLXb3C6/rUH5CY8pwoxaofM0LeMebfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9SM8rmxfdkLhMGLkSWg0Ai1ugEAOwJ7wuq2wjbUank=;
 b=vK/Gv9gkQjTWjBkKb0D+0wTxa/ZtNWBfjqRqRT89RMrZ0Y+3pjlOKdTd7DT2cUEPEXAjIKtUAcApZ/tZ2iz+Ye3TYYFvOgu9ushw0werFREeYAbgMnXrBmJxP8wv4SOZW89QzPD7gkzvt3TBFkIutKQ6eF2AWCl/fq19Qykd6kA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Mon, 9 Nov
 2020 18:37:01 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a%3]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 18:37:01 +0000
Subject: Re: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
 <20201106120923.GB14914@zn.tnic>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <ffc93b00-acc5-39ff-6df1-96daf1e5eaff@amd.com>
Date:   Mon, 9 Nov 2020 12:36:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <20201106120923.GB14914@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2603:8080:1807:186d:2d3f:50b3:ce8f:b4ef]
X-ClientProxiedBy: SN4PR0601CA0019.namprd06.prod.outlook.com
 (2603:10b6:803:2f::29) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2603:8080:1807:186d:2d3f:50b3:ce8f:b4ef] (2603:8080:1807:186d:2d3f:50b3:ce8f:b4ef) by SN4PR0601CA0019.namprd06.prod.outlook.com (2603:10b6:803:2f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 18:37:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bbbd485-f373-4aad-c7ec-08d884de7249
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB438406FD6B3CA2E91EF7EDA990EA0@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRFEQzkx4LXD2I2nkh2jlY/eV13AiWrUFngxvtfO4KeLoOaMmW64FPH39304hkUPR0fDGSE1LEm2wd3TCANiecGvO3Vf+fuJlGZmDhq+8dKaZ3iGarINy4pQXGpQMKgODC3pKQpSHCOlpdQSUYfUmdob+ECwDYotmXbkWr94Cc3uaaI3BTjXpTOG0UhL8uyvj4MADwFbMPysqNcFpFcTChFZdNw4onRoFAn6UGi3zJ7bLEL0t/4tWp4FqOTFDUNUUS2CdMRNob97B5xVu7qQUzG+LzDVztS0toa6T2u0M4t+gOj7kNPSFvjQlJ2zO01mIuNRIs+L1CNZVoh2w34nA/GfdoWdkpr2CZd4fic4E6bWTUkcdc5ZE7Dm9tsHaYq8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(54906003)(110136005)(7416002)(31696002)(186003)(53546011)(16526019)(6666004)(83380400001)(478600001)(66946007)(2616005)(31686004)(66556008)(6636002)(66476007)(52116002)(8936002)(36756003)(4326008)(316002)(6486002)(8676002)(5660300002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTBpZzZSdzBXaHV0MUtoK3RXVlgrWWMzZy9VOCt2UUtKS2k5SlhsdEVJYnlJ?=
 =?utf-8?B?dnAxY001ekNDNGZsUEpWcTRPQzZ5TWpheEMrV3Q5TGVwVmkrdWt0QjhYcDNy?=
 =?utf-8?B?UEFBWW5LN1pjbVk1dTlIdGRBUlBkZ1NONW04OWxGWVk1bjJQZWJYODRJN1dL?=
 =?utf-8?B?NEhUQzJWUklBSVlMLzVMMnNEVTNYZVhXVmRxQy9XbVNuUnR3blpkeGlNbzhG?=
 =?utf-8?B?OEF1a0wvRVhIVTcvbjJDcFN5VnRzVHFpdFpiZWN6TGhiaGw5eld5RmJ5bFBL?=
 =?utf-8?B?RTJPWmVRdDRHK1o0d3RGRWJoMlRZSVh4Q2REV081ZzBLemx5WmJZdTd6N2pQ?=
 =?utf-8?B?elZvV2VGU3p1MVlxZlp2VUFCbVpzUVdocHFabVZmQTZGWE8xOHZaSGRDR1Ax?=
 =?utf-8?B?Rks1eGxMd29udldoQXppbDE4Z0FsMTFvWTkxenlLL2NHQnEzdXR3Q2ZlWWpV?=
 =?utf-8?B?b1RabEs2Nnc4VEZUQVQ4OUUvQ3F6K3pUWDJaWFNwaStqcWM0SCtQejVsMmV6?=
 =?utf-8?B?NkdoK2xIWW8ybU9uay9WK0o2R0VFZ3FyUUJPUjRoZU9ZOGlIYndhU2FXTUxt?=
 =?utf-8?B?aFNoNkJUcERHOUhKTytBWHU1TEpPNE1aNzVxbUQrazhIQ0ViMzhEdDloamVH?=
 =?utf-8?B?ZFJiVW5LSFI1T3RPRGZwQyt1a09tbXRiQTMwdzVXUE9PWmI5b1VWUzZMNU9h?=
 =?utf-8?B?aC8xa2x3L2txdURoWWtqMjc1V0VDOXNxNzFtV2xMR2FheVdxL1N6MTZzVlNV?=
 =?utf-8?B?V1k2OWFwSklEbS8rZjQ5YVZBTGVFYmN3T0I5cGkydzUvUE0vNDRRTmZaNlZX?=
 =?utf-8?B?WHpyVlUrRFBJOXlXam91QjFnL2oxV0VGNkh4cmNsVEY5MXA0aEFqZ0phZGFm?=
 =?utf-8?B?dGZDc2NXNWk0dlJobnZ0WlFzTDlPM0JZTXdoQ0ZrRnRIaldwTkhteVpQV2tq?=
 =?utf-8?B?cmE3d3hWeng0SVhvM1B2VFdpdjk5RUl6TnJDRUs0VnBHRzZad2UwZUJ1dnB3?=
 =?utf-8?B?aFozMzhraTdpL21GVUNsd28yb0VRZFJTVDdNMjdPdEM2YWhhanh3Z09iNy8y?=
 =?utf-8?B?ZXNMeDNNaTF5ck0rSWNHREt6RnBvWUllV21hbm5DNjlXZFRTNEtPWFlTS2hM?=
 =?utf-8?B?WVpYZmtNSXRnSmxEc3l5UXY2cUVWSk5NeXZVV1ZiWEdvR3U5ZlQ1WkJEUVR1?=
 =?utf-8?B?bDlseXZWUkFVTmxmU0tUK1MyVlorUnNmSEw3SGQ4WUJSSVAvazNOQ05uZ0lI?=
 =?utf-8?B?VzI2RThOME9vVTI0VVdrNG9nODNyS2NqaGhtOW8zT1NxVWNVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbbd485-f373-4aad-c7ec-08d884de7249
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 18:37:01.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKu3jULeUaY8jFqgxMfNZB9/V7VUUxXGxfmXHCSTmLkI+BcyVyVwNaYHQwSth27NOThVGSTVlF9IcnuSjf7O7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/6/20 6:09 AM, Borislav Petkov wrote:

> On Tue, Nov 03, 2020 at 10:49:52AM -0600, Smita Koralahalli wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
>> index af8d37962586..f56f0bc147e2 100644
>> --- a/arch/x86/kernel/cpu/mce/apei.c
>> +++ b/arch/x86/kernel/cpu/mce/apei.c
>> @@ -51,6 +51,62 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>>   }
>>   EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>>   
>> +int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>> +{
>> +	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
>> +	unsigned int cpu;
>> +	struct mce m;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_SMCA))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The starting address of the Register Array extracted from BERT
>> +	 * must match with the first expected register in the register
>> +	 * layout of MCAX address space. In SMCA systems this address
>> +	 * corresponds to banks's MCA_STATUS register.
> So which is it "MCAX" or "SMCA"? They both denote the same thing but
> let's stick to one to avoid unnecessary confusion. I'm guessing to
> "SMCA" because it is more wide-spread in the kernel...

Okay I will change it to SMCA.

>> +	 *
>> +	 * The Register array size must be large enough to include all
>> +	 * the SMCA registers which we want to extract.
>> +	 *
>> +	 * The number of registers in the Register Array is determined
>> +	 * by Register Array Size/8 as defined in UEFI spec v2.8, sec
>> +	 * N.2.4.2.2. The register layout is fixed and currently the raw
>> +	 * data in the register array includes 6 SMCA registers which the
>> +	 * kernel can extract.
>> +	 */
>> +
>> +	if ((ctx_info->msr_addr & MSR_AMD64_SMCA_MC0_STATUS) !=
>> +	    MSR_AMD64_SMCA_MC0_STATUS || ctx_info->reg_arr_size < 48)
>> +		return -EINVAL;
> Split that if in two consecutive if-statements.

Okay.

>
> Also, why the ANDing and not simply do:
>
> 	if (ctx_info->msr_addr == MSR_AMD64_SMCA_MC0_STATUS)
>
> ?
>
> I'm guessing you wanna match *all* MCi_STATUS MSRs - not only MC0, yes?
>
> If so, document that with in the comment above it.
>
> Thx.

ANDing with MC0 avoids bank check by turning off the bits corresponding
to the bank number.

For example: MCA_STATUS in SMCA space is 0xC0002YY1 where YY is the bank
number. The bank number is "Dont care" so ANDing with MC0_STATUS
(0xC0002001) should match on any MCi_STATUS MSR.

I will include that in comments above it.

Thanks,

>
