Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFC3E5BEC
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhHJNkH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 09:40:07 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:40928
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241876AbhHJNji (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 09:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kvx3zBUIytVIF8mNWKQuVLELM+Bp/jzsVokljTyW9Zmm8ZMocu3vCpArAAXSPll8HYCsolOMimkRatHRRdhO8hPmXj6ULYTy795UCRpqRQQgmgSgBbxP4yxakKbQUrZUJBtZ8CmRMVck78wV8tO9DEs+lLbGwzxXaLIGyvEbwpyhJHB2/gOeQaB9wQ3YpNMyUA2O2sfjtLwmOV53j6cGQOGha6avz/wNMNWDKUxA5MWBqUW3M3DvSxeC5cO5gX0CILS9xUiZEj1tDREXIYjJqoiNQSoW1wSDAjIn44CpoQea2EkKfxHgvX5z3P/Cp2R3VoZygH1ZP/m5JIvION0dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFOYW/GZQdnpKEUfcecns01OPLfzD6wpPxPLBsRpQ+I=;
 b=l2GTjwCD+kHcHgE8z+V9VeRY8Gv4GxzXnQ9MbsA/tf4mNlrMnEEXCcTo/X8wktsXqZl99CDEstGit8JinFJU3LsTfCtzps0gerWlMQNiXammmVXecUM9NbNa2bM2BaR1lsvzaqwcZk1PGxW0pH1XtNfo8579R1oRs6pQWBREwvDF3/GtgMExzHJZl1O3mSBKTZ6VN0LtrVq8mQml/97VGeqvzCe7zD9D7IIVvLEHVt9izV6+WQHJZ/x9wCCQQfvchYFYt1ctWQasm3zZm8O7+cVNDSmjzE4JNsYa3kwgnzx1BBSQ70Vp4tbAoh707CPJcRhPRarYzs2rwn4UlJjb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFOYW/GZQdnpKEUfcecns01OPLfzD6wpPxPLBsRpQ+I=;
 b=e0HRdMsB0O/CGqx0XhnGUTlpnLwqk3aHTKkbdgPAogvPheJdMpJ9zX24kXciT9Vh2bZQtDEBeok2rUWeITfy+BgNYgHXBfbI9MNX7EXr3czDx+IzcheNHvpWXw2vxQXDTs4XRPnef5LbDf8iY/VzGxmpwZAbMmE3KJseAt3CZJ8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 13:39:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 13:39:05 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 03/36] x86/sev: Add support for hypervisor
 feature VMGEXIT
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-4-brijesh.singh@amd.com> <YRJha2XSZo3u7KIr@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a95a7b8f-fb86-62ce-0900-66761771a0ca@amd.com>
Date:   Tue, 10 Aug 2021 08:39:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRJha2XSZo3u7KIr@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0015.namprd08.prod.outlook.com
 (2603:10b6:803:29::25) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0801CA0015.namprd08.prod.outlook.com (2603:10b6:803:29::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 13:39:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bef9e15f-c955-4415-3923-08d95c043853
X-MS-TrafficTypeDiagnostic: SN6PR12MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB271897435190178757E03EA2E5F79@SN6PR12MB2718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AYkSfNP+4DaNaJRzYqSjQpXCmHcOC5CwPoxoUS/L6egYAaNw1ZiKbM/xSATkUqHvsGyPlym++DJqwPHzgJgmFZ5cmr8lq+2vA5KGaRUPjQWxOzeJ8MFSzs5tH+bbo/vitSAgJgavZvPtLGibXMC31+NkpEH62litApxI0sBrTtyYwTgLv5XimMgxTKg4/FBvXeSDLSIuhbO2k733MVU+ZpFfcPOv0pLVHSRWgBV2iu+htiySj8GGnNF2JfBO0Tb2GvLJHPY+59Tqk8DlJjmees6dx1V6J4FZSB+EYWKEyn1rVe9MaLyqPhUVeVUJOqgQos0kBCcgJvSjgq/35dij1bTvxkeR58v1KEbOZ8iw6G3mNcGhmPj8wqEbwNVkleTNUgmk/sdzxt3n3eNVlqfa2/z/OgcF5hDBBj7jxirQnyvgCQS6U9idU0BIagF2mIlOvOod0KeRdMyBTF2t31IcOeV4xaVhTnUankB7K5qWyH1D7Fo2w1UDJpWrEPVHOmcLksrGs8/Wn4NIjkE/P9HhUx6p5a/XEmlx7YGoJTPMACVriP+0WYV1a5h0UtvVju+ELq7jDB71r0E6JAkZbWETi/8x1ofDjS+13enu55Rip1bQb4zvVwtdNSr7Gha17468XP3Gern7tR+8p4KW8u8a0jrKgaut6HbFrGcTO1tnDHIyW4MX4U2woTLh8CJIFPHTVUnFh+yhREeyo0igWk5gag/XftinDNOGxloOJQcdGGQd0yFkqzRzH5thByqFJI6RObR9yke54eIDLC6MRYZow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(5660300002)(31686004)(54906003)(4744005)(2906002)(38100700002)(186003)(16576012)(6486002)(316002)(36756003)(86362001)(44832011)(8676002)(38350700002)(8936002)(31696002)(7416002)(6916009)(7406005)(66946007)(66476007)(66556008)(4326008)(26005)(2616005)(478600001)(956004)(52116002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGFyeHZ5TkV6VjFTeDdSUGp3MXlNT0dKTS9UckwvclNLUi9tUzR0V3Q1MWZO?=
 =?utf-8?B?ZldXNFF5TnZta3hCc1R0Y1ZocDBtRVJvK0k2eUpCUXk1RUZQZy9RM1VlN2hS?=
 =?utf-8?B?bHBFOFhqSnZhUUtTQkFzQUFHTS9HK2RpNFVzYkJ3bHNCVk56QTJhZkpmMzJk?=
 =?utf-8?B?MWdMa3UzMjhwY2VXNzBpNkQ0RE1JaUNRWU5CbGhhYVkwdkpWbG5RZStpTlV1?=
 =?utf-8?B?U2dzNENQeWFrWTRXMzBKY3dyOHBKQUJCbGhxdG13blN3eDFjTE9ZNGRlTnVi?=
 =?utf-8?B?Tmt3eGJ2NG9zbDNyQWJOZDZabWlFRlRZQkFVVnN5QlBLTFNzZ2RKazBYdVFh?=
 =?utf-8?B?NWxXd0VZYVRrT2ZoemlSSHdwSmR6Y001d3JqZ1lMSkNDSjdYTk0zeVJjMUJS?=
 =?utf-8?B?NUtzaGw3WUZMRGFQOG85VFF2eStxb09DNWVDT3A3Z1hCTkVpcnJ2eFhOR0tV?=
 =?utf-8?B?NUVGMUxOTDZzaVpVMkxkUVJoVG9lVkU1eEp1K3F5UWRnTFJoNHNWRFI4Q21Q?=
 =?utf-8?B?RDROY2J3bStRN0dWSzRGZXoxRDUyTUhDS2txWEVSelo4SUlFQ2EvMzJSK1p2?=
 =?utf-8?B?QThqM1Z0VDl6cHNCRkJLV0RTWDNRODloOUNQZmxGMG5PWng2SURhZFd2Sks3?=
 =?utf-8?B?YWprbTVndlM1SmdFK0xDTEtQZFNVRFdxSlRndXFlWXdaenB6RXByOTc2eTVQ?=
 =?utf-8?B?ZVo2djViY1MvL0luNnNGL2JXdFpoS2t6cGpsbHZxNVZhdW96WlN2eHEzZ3Nn?=
 =?utf-8?B?MU5xbHVweWtWdFI4Zyt2aXhrTXNKSXhXZDdyOXY5OENEZ2tWQndjdDg5Z2xX?=
 =?utf-8?B?aEdFUHU4UEVBWjdNem9acy9LRko3SWJuSi9VYlVZZXpiUzBWTzFzRWs2QWFn?=
 =?utf-8?B?UnlWN1BIVml2THFDNEg0N2Z5UENPdWoxNmQ5QjFEaUUzU0hud1NkSkVpdkR0?=
 =?utf-8?B?eFF0UzVMZTIwcGlyb0swV0FtSnNvRURDWS9ndVFvN2h5QzhWUmtNMnBIeThj?=
 =?utf-8?B?VUppS0hXcUpXcUFWTkVRS09ySzFOQWlxWlNpVG9KUVhQdXE4QlJJeDVHWVFl?=
 =?utf-8?B?ak5JeFVORTIyRmlxem85K1JHWXBOOEE3WDZ3MU9CTEZXNGx2OUVGRXVSRno4?=
 =?utf-8?B?NWhUM0JjL3ZIUG4xU0tXc2NBWmxtN0RIdHZxSE9HeWl1eFpETTV1MjRmQnB2?=
 =?utf-8?B?VGNxdHd2bCszNlNkMUE1YzJ0d012QnRyZGwzYllKWGk1bnc2a1NSYXlvN21C?=
 =?utf-8?B?QnFBeFdDOE5aRUFBUGFvbEZlL2VxTFVUcjRWK25zTVRzakZ3Tm1BSDAvdVB4?=
 =?utf-8?B?OGxtM3pxcjYyM3NuaEs4TVVuWHNON0dIVXZGNGwxN2VkMnR5WG5MWFJMMklF?=
 =?utf-8?B?VDYxSFMxc0tERWFYSjF0bDFjZW5ZR2IzeEVtcWxibThrZWVUZ2h6aHZvcnJG?=
 =?utf-8?B?VENzb1JQaWNhK04wbDdmUFg5aGRpWVdmd0xOdGNrdEhPVE92SHpsQlpZTDZn?=
 =?utf-8?B?VGt2M1B1bjN4UmNYZnlDQVFsaC9aRnl3TzBuVW1pdHlJY0FpNEF1bmw5YkFs?=
 =?utf-8?B?eGtLUXhVYzRDeDVZUVBHVENLaUdVY0hmT3dUbi9KYUtlU0R0aDRnNk0vRUFO?=
 =?utf-8?B?VTF4aTluSE1sd2s0aFNCTkhHL0RMa0w2bWM2MzBJclNGVHNUeEhTb2NWakhE?=
 =?utf-8?B?NjVUSFdWTWNadUZWZGVFY0o1cFRBZjJFK1lFZDBQazVlVzNJYmFaTnlhYVdZ?=
 =?utf-8?Q?YK2CRCTpPbLXy7dzDxpnOh1kMtCShKIR2ith+6a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef9e15f-c955-4415-3923-08d95c043853
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 13:39:04.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCQ11bq7uCTb+2xbu9OVc5IvvTcCjplwWTB0rS8TKbnmUm+6DWeF/zEI48gou0iwqfniv/QzhJIa0cPfhBHS1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/10/21 6:22 AM, Borislav Petkov wrote:
> 
> 	SVM_VMGEXIT_HV_FEATURES
> 

Noted.

>>   
>> +/* Bitmap of SEV features supported by the hypervisor */
>> +u64 sev_hv_features __section(".data..ro_after_init") = 0;
> 
> __ro_after_init

Noted.

> 
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 66b7f63ad041..540b81ac54c9 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -96,6 +96,9 @@ struct ghcb_state {
>>   static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>>   DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>>   
>> +/* Bitmap of SEV features supported by the hypervisor */
>> +EXPORT_SYMBOL(sev_hv_features);
> 
> Why is this exported and why not a _GPL export?
> 

I was thinking that some driver may need it in future, but nothing in my 
series needs it yet. I will drop it and we can revisit it later.

-Brijesh
