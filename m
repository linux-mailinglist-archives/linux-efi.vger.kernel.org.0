Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A519826978B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgINVQU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 17:16:20 -0400
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:40770
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgINVQS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 17:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFNPUUx77f91bAaTXakD7cKZU4rkjU8i+n7TvvPcmFFEeMMNXlclTZ1uwG1YcrJZyMPCOBgKBlHYOzx943X+FIxf5Xdyx1z3vMWrPfDsXagZVzm79jgmwj+a34YdatviRODc0OBsOi8ckzPdAe5KKT54kaAAPWEVbXxMB75VKrbEHlzKnlNJsAEkfuKa2aJeyqIQemLmSfjd+h1VXcvzSUFE/BMDyM5eGMHfUM1jyqfycnA9M9OZsFDr0Al6HG+a+Yii8wdV3B6d/Qyzt8C4lx7Xj3PWh6oDUMcyh04xPCAkOnu6nW8BU44H/7yyLKpnj0HH+PsQvDDzE/JLn8QnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBKNqi3hTrfBXYpMXQliA5FRj2gjT8Xz6p/CjggyX/g=;
 b=nKhMx/Mx6LUwZQfYdbXmDl52sbJug4fFDOo4v5J1CTIZU9QTdshajkWut5p+Mtk3MKkfy7ALyk3idUHiDIXymLYOtm4b5ls2ihTJE1VAzKt2kGcgEv1ttRL6LCmTn/3pkfeN63kmZXy08WYGSgJgalT3aPE3a0bFTzZ5Q2FnTdBEFw+ll6TjGVlL/VDtTZq3DiTRzFVaHR74ZLT3cy3+OnpMkvDxURfpu1TC5EewA00BAHuHMenM740OmpN708B+DiPSAbQiV8cEf7C5as/yO4MeXfIeoXbQEtiubLU0m1QzSTvtLGfjgIPPA2LyeVQ8vPenZ2VvCWYCBygaSUxOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBKNqi3hTrfBXYpMXQliA5FRj2gjT8Xz6p/CjggyX/g=;
 b=mH6/hyjt6tBT/57o8JbcDt/wgURGpA5fu32jraiUXD1R6W0qCjOkihpB5vHnORUJ1Cg7HiwLdr8Y/81cJ7Y3Nw9lrHShEEak7es5omk4J52pGXOQVm7BOsQJCEjXtBVDvDwTyREcNMVAXzbFrQG4yF/3WUB60ZZeIqYnGNdIl8Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 21:16:12 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 21:16:12 +0000
Subject: Re: [PATCH v3 1/2] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com>
 <20200914153024.GC680@zn.tnic>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <a28aa613-8353-0052-31f6-34bc733abf59@amd.com>
Date:   Mon, 14 Sep 2020 16:16:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <20200914153024.GC680@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41)
 To SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (72.182.84.89) by SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 21:16:11 +0000
X-Originating-IP: [72.182.84.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9493606-1920-44c9-5fa7-08d858f36860
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4415092A2A4494B8110FAFE790230@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AW2s3bL7o9SYLrtdpsjRBN4wXpPxgLucbLpoZ5CUGwya0QN1bvIVIEF+LKLfQ/aejUeqesS94dqx+5j0QKRO41wKKvMnbiM7j/H5vBMKI7HdWCu7PJy12Yx0U/u7B1R0RpLR7i0fV5ndau5SoVUTzSJBXOB3xn3s5gOhPISyc5X+iZgDdRXJet7qPPobNYSyBfNgDQjU5SL7M6sOnwB8f3ASs5NC58u3hPmHjMJklc3VTJAOtpzl5BDE4XcjvMKvvMFaMLhHSLUDjLgpu9L6YTfw0ADYkeIwZjmi63NfQQ27A3DlxcKgCkmHy4xeDQo84/Fuxogw0wL5vDN+ycdnnyHOAOjps8Kjp4Fg4ycsBWz7L10SwKYleR23mw968vwU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(6916009)(8676002)(186003)(16526019)(31696002)(54906003)(52116002)(2906002)(26005)(4326008)(2616005)(956004)(478600001)(53546011)(31686004)(5660300002)(7416002)(6486002)(16576012)(83380400001)(36756003)(66476007)(66556008)(316002)(66946007)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kK7dghMdsWKFp996C159Was75OIARmk/rqMRbMJtAcvgg+4Av26XxEKGKSemClPHuHH4TVS1ydcWl3dc8M3GXUyccbzWeQM91uYoNlhw4YCpsF+WE2smHzmmF/Kgc45UkiqlxUzMGHW/Ae/voRlzSlq4vx/P7fthr8qd6Ao8EAgXaN+jPeEsi8A6gTl9+suiGHPTUrrPa+vRGdjw79Euai4T9n0XxXdWyy0WkGPfGmoegERT22hHRnFHdIWGSDCDXxsjVToAe+HFwIp6AhMDPQJliwfj0lqRhgHIGk64A6t6ZvYMtDBd7eXS9sYgb/7XDP7ZOiGhxCTXQnXTgx9o1htLEws0OxpjZ7HmGF40NndlpKKN1bsnB4dZNMcA+NPQeZhZRyezHn92qCnkGBGGXLXeMDhhYG+PXsPOP0t+Udv12uGU0lHPwGg/2EsY0xYpD67YOZsQBck6Mv/O0po3065XViAs8oFPytcAFgiWhMbrmmdsk0UZ4NWsBlcghMmkBBwAYquueas+GvubbDKsrmK7ZaKRumdpznrPubduvQz3uk1wz+fl+e3xrfoX0eqlLsnpNfcPqUHYAdk7o5rRr1Rj+v5O2zRvxWop1AC38bR0hQHxVCTE/MsajypXk5mdygjN+t9lhAE/JOYXvH3giA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9493606-1920-44c9-5fa7-08d858f36860
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 21:16:12.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WC1bFis/Z+Fc5Y43mapZhF4VYGk1Lih8QUPEg4rT0te3lWucwUF0aXtsofDLOtcKCqCAuPUPjySbcJC789AKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/14/20 10:30 AM, Borislav Petkov wrote:

> On Thu, Sep 03, 2020 at 06:45:30PM -0500, Smita Koralahalli wrote:
>> Linux Kernel uses ACPI Boot Error Record Table (BERT) to report fatal
>> errors that occurred in a previous boot. The MCA errors in the BERT are
>> reported using the x86 Processor Error Common Platform Error Record (CPER)
>> format. Currently, the record prints out the raw MSR values and AMD relies
>> on the raw record to provide MCA information.
>>
>> Extract the raw MSR values of MCA registers from the BERT and feed it into
>> the standard mce_log() function through the existing x86/MCA RAS
>> infrastructure. This will result in better decoding from the EDAC MCE
>> decoder or the default notifier.
>>
>> The implementation is SMCA specific as the raw MCA register values are
>> given in the register offset order of the MCAX address space.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> What's that Reported-by for?
>
> Pls put in [] brackets over it what the 0day robot has reported.

Okay, I will add it here. May be I should have just put it over here
rather than in cover letter.

>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>
>> v3:
>> 	Moved arch specific declarations from generic header file to arch
>> 	specific header file.
>> 	Cleaned additional declarations which are unnecessary.
>> 	Included the check for context type.
>> 	Added a check to verify for the first MSR address in the register
>> 	layout.
>> v2:
>> 	Fixed build error reported by kernel test robot.
>> 	Passed struct variable as function argument instead of entire struct
>> ---
>>   arch/x86/include/asm/acpi.h     | 11 +++++++++
>>   arch/x86/include/asm/mce.h      |  3 +++
>>   arch/x86/kernel/acpi/apei.c     |  9 +++++++
>>   arch/x86/kernel/cpu/mce/apei.c  | 42 +++++++++++++++++++++++++++++++++
>>   drivers/firmware/efi/cper-x86.c | 10 +++++---
>>   5 files changed, 72 insertions(+), 3 deletions(-)
> ...
>
>> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
>> index c22fb55abcfd..13d60a91eaa0 100644
>> --- a/arch/x86/kernel/acpi/apei.c
>> +++ b/arch/x86/kernel/acpi/apei.c
>> @@ -43,3 +43,12 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>   	apei_mce_report_mem_error(sev, mem_err);
>>   #endif
>>   }
>> +
>> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>> +{
>> +	int err = -EINVAL;
>> +#ifdef CONFIG_X86_MCE
>> +	err = apei_mce_report_x86_error(ctx_info, lapic_id);
>> +#endif
>> +	return err;
>> +}
> Add a stub for apei_mce_report_x86_error() in
> arch/x86/include/asm/mce.h, in one of the !CONFIG_X86_MCE ifdeffery
> which returns -EINVAL and get rid of this ifdeffery and simply do:
>
> 	return apei_mce_report_x86_error(ctx_info, lapic_id);
>
> here.
>
> If you wanna fix the above apei_mce_report_mem_error() too, you can do
> that in a separate patch.

I have addressed this and will be sending it out as a separate patch.

>> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
>> index af8d37962586..65001d342302 100644
>> --- a/arch/x86/kernel/cpu/mce/apei.c
>> +++ b/arch/x86/kernel/cpu/mce/apei.c
>> @@ -26,6 +26,8 @@
>>   
>>   #include "internal.h"
>>   
>> +#define MASK_MCA_STATUS 0xC0002001
> What does that mask mean? Either here or where it is used needs a
> comment.

The mask value checks for MSR address of the first expected register
in the register layout of MCAX register space. Since the register
layout is implementation specific I'm just checking for the first
register. I will be adding a comment for this.

>>   void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>>   {
>>   	struct mce m;
>> @@ -51,6 +53,46 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>>   }
>>   EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>>   
>> +int apei_mce_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>> +{
>> +	const u64 *i_mce = ((const void *) (ctx_info + 1));
>> +	unsigned int cpu;
>> +	struct mce m;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_SMCA))
> If this function you're adding is SMCA-specific, then its name cannot be
> as generic as it is now.

May be something like apei_smca_report_x86_error? Or probably an additional
SMCA-specific function call inside this generic APEI and MCA function call?

>> +		return -EINVAL;
>> +
>> +	if ((ctx_info->msr_addr & MASK_MCA_STATUS) != MASK_MCA_STATUS)
>> +		return -EINVAL;
>> +
>> +	mce_setup(&m);
>> +
>> +	m.extcpu = -1;
>> +	m.socketid = -1;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		if (cpu_data(cpu).initial_apicid == lapic_id) {
> I don't like that but I don't think we have a reverse mapping from LAPIC
> ID to logical CPU numbers in the kernel...

Yes, we do not have a reverse mapping.

>> +			m.extcpu = cpu;
>> +			m.socketid = cpu_data(m.extcpu).phys_proc_id;
> 			m.socketid = cpu_data(cpu).phys_proc_id;
>
>> +			break;
>> +		}
>> +	}
>> +
>> +	m.apicid = lapic_id;
>> +	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
>> +	m.status = *i_mce;
>> +	m.addr = *(i_mce + 1);
>> +	m.misc = *(i_mce + 2);
>> +	/* Skipping MCA_CONFIG */
>> +	m.ipid = *(i_mce + 4);
>> +	m.synd = *(i_mce + 5);
> Is that structure after cper_ia_proc_ctx defined somewhere in the UEFI
> spec so that you can cast to it directly instead of doing this ugly
> pointer arithmetic?

The registers here are implementation specific and applies only for
SMCA systems. So I have used pointer arithmetic as it is not defined
in the spec.

>> +
>> +	mce_log(&m);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(apei_mce_report_x86_error);
> Why is this function exported?
>
> If "no reason", you can fix the above one too, with a separate commit.
>
> Thx.

I will fix this..

Thanks,
Smita

>
