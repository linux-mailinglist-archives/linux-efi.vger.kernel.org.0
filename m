Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39627098EF
	for <lists+linux-efi@lfdr.de>; Fri, 19 May 2023 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjESOFA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 May 2023 10:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjESOE6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 May 2023 10:04:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A8114;
        Fri, 19 May 2023 07:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCxHde0Y6aBAi1rOwGFnytiZWB8hTxvUzb0/na2e7QU2BOwr/tMLSJCqk+zRUbsmrcmums5Dau7rR+2xiC9f2LsZXmWxC0Jlmd9gcJcLUaq0wXluj+wrseg5xT2PMpBcS/uEedjI+qpVGwtJ0L7AOnaA0tMX9wPvPhXu2eb0+pDN9gqBLalwg9G2+NG1C346/xgXmEdworoFeR9FyntvQENjC080g/cnIwKuW3WwZq4dt2zJjQTwRsq2w36WPDYEUb5SLkbP+yfQMClTs6iIjsz13uZWC5/5fdCmpm3VSpiB5jSth8eGZFAJ5YaT2KC4PnIRQPSwSMCCwllrqAf69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpVNIZf5LkXuEJgYd1Q0Cw59nwPhhkDVRAUiI1A4qEQ=;
 b=hubmQSwevp9y/egRYNCepeMMrDWHrA7HX3K97Vgn/vo+nR5AfXilHQgU2imLW68WZVSN7uphXqpuYgXH8q7YbnmomGLb2gbHqHy2N6FBn7eiqhlnuaMQUkZuBXN2pcepDY46zYM6BiLDdqVgqvtXGEYAJMd6oCr+mTS3uo6MUp1v/ytvGJDTYPajLB22jFA78Y10UMFhNXxfONAMgJcwDCS/RkvAgOVSK4GTd8bFmtF4qu93nTlRc82WdIqkC5s/pf/24+uQTSJ2WNx8dLEgnwdiQB2H5zuaYcvc0bR3ZtHfrcieWGTtxYGL5HqOoZ0WT6RyQEPEhBqowYj5C08cPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpVNIZf5LkXuEJgYd1Q0Cw59nwPhhkDVRAUiI1A4qEQ=;
 b=POkHdKPTijD+H+JC5/beOpiORKg37WLpSexQxPWyNi1O9z5xhboHonoSyoOnE5GXxNNJJPsEJIo7Vetlj1Oxie21VzEY7RHyIdvCcYgQMRNgqnjlLwY5IDRqPCE66TFAUj30hDSoQXniGENIEnrPk/oFSZthLfkNijLVVA+aqlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 14:04:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 14:04:53 +0000
Message-ID: <b6192de1-26a4-a7a7-63bf-76c36f55a8ff@amd.com>
Date:   Fri, 19 May 2023 09:04:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 17/20] x86: efistub: Check SEV/SNP support while
 running in the firmware
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-18-ardb@kernel.org>
 <ca76ed3b-5835-9f1b-7e10-dd417249b7bd@amd.com>
 <CAMj1kXE+7SKVZN3p2_NXg5VeH+hbwnqwaGTj6HLE1a89QGtraw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXE+7SKVZN3p2_NXg5VeH+hbwnqwaGTj6HLE1a89QGtraw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0884.namprd03.prod.outlook.com
 (2603:10b6:408:13c::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: e3802349-e324-4d38-52d1-08db58720473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBLmu1DvcwancRX3J9u7uh0K+SlFrHMhaIujM1MD+iR30YGMnbC0QdiQwUxcV0hPetbX5AWZPWqQMMOuLdYWlo9ySNf4rRpDG5EG9UvWUPW2agf8Sf1QFBrd3wY0zC95cief5wbeQhXRZYbSQeu+TCwAvi7NpliGpoFwUl4+eWQ9RFrhHB6q/AxYrajrawwfzx2CK5Yu5vUa/GBFh7OhGUTlND7W7+jD5Ky/RzHu+oGVzFD0dt7DGNXK9zZBr6RSrs5lC9rbOj7/wbmiKxqJabs8xr+8HdjsHoYXHr/IXVzbXu4aUUtplAyxhdJU4qjpHBR0jNR54YVuSdZNAUdVGnIOQyrEy9km94FfnFGt/qKvZizVH83CvsmKCV8t7EOovEHAD2/SlYSKQmTyet+1h31bQXdAPbfLGGbBtOKziNBG3rRQCtyWbNCl9taNLNPvURipEYM15IQujGVum9aozw0CfsUzx/NB+zwl33VRD0gniysnu57F0it8trh26bHRNMtq4+ppUmSBWvSpir7n6sx4IrHwKBj2wwparLsgRNNf0fKmXr792xxBKlpCbnj8h6FP/5d0ucRXNxvaQsFcysMRkwgjzzrufGG/KHrKe1a6D/jS6qwoY/FY9FlOvSiR0HwIU8fQet00Mw9CoOhrVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(2906002)(478600001)(41300700001)(8676002)(8936002)(31686004)(4326008)(6916009)(54906003)(316002)(7416002)(6666004)(6486002)(66556008)(66946007)(66476007)(5660300002)(53546011)(26005)(6512007)(6506007)(186003)(38100700002)(2616005)(83380400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5WOUQvMmdNd1VoN0dTeVVwTWo5Sk03c1hZekJZNFJrRFR1d2hRNDNRcTN5?=
 =?utf-8?B?ZDcxQmV1S2FWZzRjRFBIR01vOTl6Nmd5STY1dG1DY3cvVmUrWmhXWEtreGNI?=
 =?utf-8?B?ZmhSY2MyeFpWNGNvYnRsMmxiQnN0VmVHNVhuZGhnWXNCcTduME5zektLVjNs?=
 =?utf-8?B?dmR0Z0x1RmdrTVo1dXRscWt5eTFUZmdnMUlmdlBac2diR1lIVkQ2TUtIUHpk?=
 =?utf-8?B?Tm5tRFZkc0pSS0Nva05QaGU4YzhCeGhZdDNDb29jZUlmVWlmci8rV3NkaXRl?=
 =?utf-8?B?Y29QTVdnUGsrV1V4dTZVcklDaXRzaUtZQm84TnF5bCsvQlhzSVFxN0psZHpN?=
 =?utf-8?B?YzZ1WFFCRTNpemJDcWYzOGhMbjZhUktmcjVjWTM3QmJKV2M4YmxRcnp1UzhC?=
 =?utf-8?B?a0NXUmQ4SlJHK0R5dFhBcDJidXlwdklKdlJBbUFXb0tLWWFBOWFYcUxkalpz?=
 =?utf-8?B?WFRTSTlaU3NjalhvTGR6bjZLUENieXdHOCtNZ2ZnWnlrQ2J1YU0weGxsSXJJ?=
 =?utf-8?B?Z0h2RkovbXgvTnhDYW5tNCt6RFZ5WjdWVWlRR0FTTkdmR3E0dTVQZjJFclh0?=
 =?utf-8?B?YjZsZGVTZlJRcGN3ZXJtR2ZyVjFDS2grRXdEZ0VDVi8yeUFTWi9FQ0xpVjVX?=
 =?utf-8?B?azVLNjdwYjBVSWdpUFlaVWZIZnhaby84aXJGMlRwc29zQjQ3TTU3Mms2dlFI?=
 =?utf-8?B?c0Fsb0J0dnIrak14YktobzIrMitwQyszUDFoK0ZQUVh5ZE4zQS9ZR0htVjhB?=
 =?utf-8?B?ZHludWlZZHRnOUR0UStXQnlMdGZKVXJTUkE1aGhUbVBFZ1pscUtpMDVFNlkw?=
 =?utf-8?B?MmtwRzhnYjY2ZktIL2lkWnowOGhLZ2pXeXlOMUUyOXh5YTJUNTJnbTdmYm8y?=
 =?utf-8?B?MmNYUSttMnZyYXVkaUxPYXZiYzg4ayszR0R5dkNKUndhUXBPR1dkNER6bTBa?=
 =?utf-8?B?WGEybmd2MDQ2bFlDNXlxbUVyNGM5L2F6U3VBYXAzeUM0c0FRdVEvVHpkWkky?=
 =?utf-8?B?Vk84em00Um9lVmdhK2U2K0pGTGhsTXNTZytvV2VyeFZrR3VXd05SaFl1TEho?=
 =?utf-8?B?b0N1eTN5Y2FOU2JhR0JaS2JWeCtNSjRhZXR3c1drck12aml5cVJzelRidE13?=
 =?utf-8?B?QmdDclZzVStYMkRrNVN1dW8rZURCU295WE15MEs4eEdGcklYN2dMT1Nwd1pj?=
 =?utf-8?B?M29ZT0gxbDZtWkZCR0F2YXoyOGRNTVc5T3ZUeU9POGpvTU5TejRiZmwxbWpr?=
 =?utf-8?B?a2RuckUyZzhMdzFPSW9KbnlZbU9uaTVIcU8zYkdGNEh1V2ZQOU9yUjlxb1Vs?=
 =?utf-8?B?NTZ3c1NCY2ZWTmtsdTFHYkZlaHVzU01kdFhJN3J5d1FOTWxwamQ1R1Y4RzJt?=
 =?utf-8?B?SEJsbk9YZUplSHg5Y3o5YTFqNTJCYXJjMGVLc25sWitQL0JzQ1dBNEZzQXp6?=
 =?utf-8?B?Vlg4TnM3cFNVWUlCdlVwc3B4MHRWclFidHJvUG4vWm5SWXFVbGhudkxPZkFU?=
 =?utf-8?B?VlZ4dVlmdVJaT0gyZFVlSVd0VmEycU4zN3lQQXRZdHJMaUZzL3dXV3Q2aWFi?=
 =?utf-8?B?ZGY5dFY2UmdJUVIrbVZvWldjNnMzSDNsNDJBUE1KUzIwQjIyYWQzWlZuOXd2?=
 =?utf-8?B?Q0RMTmNvMDI4WDMyTzFDZVl2cDJLSEU2bXlUMkxtdzV1dUdCVzZyMjl6T1Fw?=
 =?utf-8?B?L3Fqa3FBMHV4L3Vnc3RLYmZIajBTd3RSN3J1anR1eGdtalRlaTJ6Nkk2SjFZ?=
 =?utf-8?B?SXM3NG80aCtkZXo5RUlkTFpRZWRNdXpBMkxpdDc2M0RDY1I3TnNtbWZDSjVk?=
 =?utf-8?B?d2g2SjR5NzVLektDR1JXYVBPbFlYcTdudFduVWpFTks5RnNRSnFPYVFEY203?=
 =?utf-8?B?U0NQMHYydllxZVNTUHVrZDBjQmV3QkpvemJZNHM1bnNPN2gzcGJpR2JZc2RJ?=
 =?utf-8?B?anlyOWw0eCtXaWJOL3pGS0pKeDYzSXNIa2N5WXJEbFltVTNTWmcwSGxnSXdj?=
 =?utf-8?B?eXJBZ3pLNkNwWU5kOXF2Y0RDOUdiQkpBS1BZRzc0MHBKQmhrMld1K1FqdUtN?=
 =?utf-8?B?OXZNVXh4WnZzVWpMVEVqdWRDWWE3cm0vckpUeHkyeGJZMmwwRm1RUXVwSXgz?=
 =?utf-8?Q?l6JVXVC5ETtbOSDRinrwyrSRs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3802349-e324-4d38-52d1-08db58720473
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:04:52.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiS+gqvFNC0/oa7Uky82MYFam6SlUaaHdXsND2zLDBbLRz2dTuNoqDEiLbrG3FwMh0injWwUIv0bkWZ5SKQeNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/18/23 17:27, Ard Biesheuvel wrote:
> On Thu, 18 May 2023 at 22:16, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 5/8/23 02:03, Ard Biesheuvel wrote:
>>> The decompressor executes in an environment with little or no access to
>>> a console, and without any ability to return an error back to the caller
>>> (the bootloader). So the only recourse we have when the SEV/SNP context
>>> is not quite what the kernel expects is to terminate the guest entirely.
>>>
>>> This is a bit harsh, and also unnecessary when booting via the EFI stub,
>>> given that it provides all the support that SEV guests need to probe the
>>> underlying platform.
>>>
>>> So let's do the SEV initialization and SNP feature check before calling
>>> ExitBootServices(), and simply return with an error if the SNP feature
>>> mask is not as expected.
>>
>> My SEV-ES / SEV-SNP guests started crashing when I applied this patch.
>> Turns out that sev_es_negotiate_protocol() used to be called when no #VC
>> exceptions were being generated before a valid GHCB was setup. Because
>> of that the current GHCB MSR value was not saved/restored. But now,
>> sev_es_negotiate_protocol() is called earlier in the boot process and
>> there are still messages being issued by UEFI, e.g.:
>>
>> SetUefiImageMemoryAttributes - 0x000000007F6D7000 - 0x0000000000006000 (0x0000000000000008)
>>
>> Similarly, get_hv_features() didn't worry about saving the GHCB MSR value
>> and an SNP guest crashed after fixing sev_es_negotiate_protocol().
>>
> 
> Thanks for the clarification
> 
> So the underlying assumption here is that performing these checks
> before ExitBootServices() is better because we can still return to the
> bootloader, which -like GRUB does- could simply attempt booting the
> next kernel in the list.
> 
> I was obviously unaware of the complication you are hitting here. So I
> wonder what your take is on this: should we defer this check until
> after ExitBootServices(), and crash and burn like before if the test
> fails? Or is the change below reasonable in your opinion, and we can

Deferring the checks is probably the safest thing to do, since that would 
match the way things are done today and known to work. I'm not sure what 
other things might pop up if we stay with this approach, for example, page 
state change calls using the GHCB MSR protocol that also don't 
save/restore the MSR value.

It is possible to audit these areas and stay with this approach, but I'm 
wondering if that wouldn't be better done as a separate patch series.

Adding @Joerg for any additional thoughts he might have around this area, too.

> incorporate it? Or is there a third option, i.e., is there a SEV
> specific EFI protocol that the stub should be using to establish
> whether the underlying platform meets the kernel's expectations?

There isn't currently an EFI protocol do that.

Thanks,
Tom

> 
> 
>> The following changes got me past everything:
>>
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index 3a5b0c9c4fcc..23450628d41c 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -106,15 +106,19 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
>>     */
>>    static u64 get_hv_features(void)
>>    {
>> -       u64 val;
>> +       u64 val, save;
>>
>>          if (ghcb_version < 2)
>>                  return 0;
>>
>> +       save = sev_es_rd_ghcb_msr();
>> +
>>          sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
>>          VMGEXIT();
>> -
>>          val = sev_es_rd_ghcb_msr();
>> +
>> +       sev_es_wr_ghcb_msr(save);
>> +
>>          if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
>>                  return 0;
>>
>> @@ -139,13 +143,17 @@ static void snp_register_ghcb_early(unsigned long paddr)
>>
>>    static bool sev_es_negotiate_protocol(void)
>>    {
>> -       u64 val;
>> +       u64 val, save;
>> +
>> +       save = sev_es_rd_ghcb_msr();
>>
>>          /* Do the GHCB protocol version negotiation */
>>          sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
>>          VMGEXIT();
>>          val = sev_es_rd_ghcb_msr();
>>
>> +       sev_es_wr_ghcb_msr(save);
>> +
>>          if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
>>                  return false;
>>
>>
>> Thanks,
>> Tom
>>
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>    arch/x86/boot/compressed/sev.c          | 12 ++++++++----
>>>    arch/x86/include/asm/sev.h              |  4 ++++
>>>    drivers/firmware/efi/libstub/x86-stub.c | 17 +++++++++++++++++
>>>    3 files changed, 29 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>>> index 014b89c890887b9a..19c40873fdd209b5 100644
>>> --- a/arch/x86/boot/compressed/sev.c
>>> +++ b/arch/x86/boot/compressed/sev.c
>>> @@ -315,20 +315,24 @@ static void enforce_vmpl0(void)
>>>     */
>>>    #define SNP_FEATURES_PRESENT (0)
>>>
>>> +u64 snp_get_unsupported_features(void)
>>> +{
>>> +     if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>>> +             return 0;
>>> +     return sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
>>> +}
>>> +
>>>    void snp_check_features(void)
>>>    {
>>>        u64 unsupported;
>>>
>>> -     if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>>> -             return;
>>> -
>>>        /*
>>>         * Terminate the boot if hypervisor has enabled any feature lacking
>>>         * guest side implementation. Pass on the unsupported features mask through
>>>         * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
>>>         * as part of the guest boot failure.
>>>         */
>>> -     unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
>>> +     unsupported = snp_get_unsupported_features();
>>>        if (unsupported) {
>>>                if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
>>>                        sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>>> index 13dc2a9d23c1eb25..bf27b91644d0da5a 100644
>>> --- a/arch/x86/include/asm/sev.h
>>> +++ b/arch/x86/include/asm/sev.h
>>> @@ -157,6 +157,7 @@ static __always_inline void sev_es_nmi_complete(void)
>>>                __sev_es_nmi_complete();
>>>    }
>>>    extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
>>> +extern void sev_enable(struct boot_params *bp);
>>>
>>>    static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
>>>    {
>>> @@ -202,12 +203,14 @@ void snp_set_wakeup_secondary_cpu(void);
>>>    bool snp_init(struct boot_params *bp);
>>>    void __init __noreturn snp_abort(void);
>>>    int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
>>> +u64 snp_get_unsupported_features(void);
>>>    #else
>>>    static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>>>    static inline void sev_es_ist_exit(void) { }
>>>    static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>>>    static inline void sev_es_nmi_complete(void) { }
>>>    static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
>>> +static inline void sev_enable(struct boot_params *bp) { }
>>>    static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
>>>    static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
>>>    static inline void setup_ghcb(void) { }
>>> @@ -225,6 +228,7 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>>>    {
>>>        return -ENOTTY;
>>>    }
>>> +static inline u64 snp_get_unsupported_features(void) { return 0; }
>>>    #endif
>>>
>>>    #endif
>>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>>> index ce8434fce0c37982..33d11ba78f1d8c4f 100644
>>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>>> @@ -15,6 +15,7 @@
>>>    #include <asm/setup.h>
>>>    #include <asm/desc.h>
>>>    #include <asm/boot.h>
>>> +#include <asm/sev.h>
>>>
>>>    #include "efistub.h"
>>>
>>> @@ -714,6 +715,22 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
>>>                          &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
>>>        p->efi->efi_memmap_size         = map->map_size;
>>>
>>> +     /*
>>> +      * Call the SEV init code while still running with the firmware's
>>> +      * GDT/IDT, so #VC exceptions will be handled by EFI.
>>> +      */
>>> +     if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
>>> +             u64 unsupported;
>>> +
>>> +             sev_enable(p->boot_params);
>>> +             unsupported = snp_get_unsupported_features();
>>> +             if (unsupported) {
>>> +                     efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
>>> +                             unsupported);
>>> +                     return EFI_UNSUPPORTED;
>>> +             }
>>> +     }
>>> +
>>>        return EFI_SUCCESS;
>>>    }
>>>
