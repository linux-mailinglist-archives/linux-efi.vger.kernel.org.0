Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940E63FF478
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 21:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhIBT7T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 15:59:19 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:29153
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244285AbhIBT7O (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 15:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHqGCxMb49QPJMT3P3fds06ejrxc8JpLXhZETeYocXPr4+LTX65lkZqcAcjAiGd9X3KFPYQ6JpFirWx5gXSYO2EOIBJ3gl8Y6QEuPa/u6O/I0zxyfIQC/WaIt6dl1HVrWOWxszh0BHMs+iNH2oOYmx3jWB4aXqwQAqUyz7OCNSNXRktmE6KyxkT9lIG4OeL8/zeMhDYZeQPZLGa5bCwAx/HDpEcuxxKnqFcY7h31UrIVBbdE5WHXa1WUrgyt6uygGhTHWTPFmDBaEMlQ3+/I+yVnJUx5qwESd7XaQxVIyT4TIPQugtDL0Hz+mUMPMoD06tIHPAdm0V1ps/+3Fe2m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=akTcLH0xyVsnbrJwZSmmka2JWwRXl69BnJ7k/ieocBI=;
 b=YlXPfBRhHLwQsCqVM1GezIMKEFFgpxptrR8p6jPPYcSuAPKr/st61FlSfkKmetgUr4IlXzBMIkt5GCSB6rl+diY8pd3Pmq/xzdjMNTmyZzrPvBmS5Y3sbzJLgw4dGQpR+l7cfwYZQMxUahYwB4BThc0RX2G4JDq5E4qaH6pkr0rxml75aOgkZfQNl/upfz9pAJRh/pIUBLCbRrmdhhOmZS9onldY+9MElpzi1VSKDqkftUhMKu3pFvQPaSb224zvCjWrQaSGJ2cJfuvmeEm3WJPbd4JLwPR9IwU2W3G2aXZS0fv6AxdxGT1VLJvm6/H8fmqrg0WEmS9uZ4ReKHObwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akTcLH0xyVsnbrJwZSmmka2JWwRXl69BnJ7k/ieocBI=;
 b=EUWHoquAdmcFvkmjrgl3TSEkL9iKTDvR731aDYPUnlQkcrE9t74X7S77PEjrn9cOTAewvGP2n6Zmi4ATh8TDiZLA3DHd7hYjyF946D+50MbdFuJQtgnfy4xjuL1raxwr/+dSs6tVEABKk4JCklMyCKb21K/dC/vTI90u9MN59ao=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 19:58:13 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 19:58:13 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 35/38] x86/sev: Register SNP guest request
 platform device
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-36-brijesh.singh@amd.com> <YTD+go747TIU6k9g@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5428d654-a24d-7d8b-489c-b666d72043c1@amd.com>
Date:   Thu, 2 Sep 2021 14:58:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YTD+go747TIU6k9g@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:806:28::28) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.31.95] (165.204.77.1) by SA9PR13CA0173.namprd13.prod.outlook.com (2603:10b6:806:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Thu, 2 Sep 2021 19:58:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76874350-8662-4b76-a8b8-08d96e4bff01
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2511F7177E788180A1C0ABC5E5CE9@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4kuJ3YWuVogLQy8ZvqSasI6CbT2JPGV8KKecHBv/5/QxG7oExHKoPHn5x2V6kSGq9Ez9VBR+R+ZaWCFvDkCWQU/YZX3ubwj4xNfiyYetxew3KskcEgQvLdPjQKOODjFUqD4EgrqivYGBcAJViq6Rm3lbTgnQ3kCgyMjSTt/bSMWWoldWSZIcy92k2ZjfxPDj9ryHvA8bsqHkSfnP572Y+ZOlZuq0/6/KZ1LUrSU+UIyojKkWK6fFLJC5ZAeWck4KMFOQSu1JG0UrSv6ZW6z+70tv1qHLJBVF2Namnla2r+F5EECPU232+0YdwKoQmvoEAOHpNRr+0DAwpVsUc1BUy7rFHHDQiGiKulQrz+XrWuVPeDsw/XNkRTlbEVjuJixprm9Y9FVUpsrZPwzPkrzHAx3mgzPqvR71y5zr9Fv8wG2TGRq6IvaER+W6XNL99Jk8BAnSj2fUt6i7z5HPzxa7vjWApcZcxEIDZDQfqwDODOE0jXHJ3BW/9pcMObjm8xC38MrE3xtD6APUc/iRdFKLpJ3M1+jUdCQ3QOA6TvqSce79MA6Xsyx8lxVCuRcJpSFgkK8H2MAFu7ypyMfSH3jkBiSNJoKCbx4bfrjK2kljIZGO659WukvI78Cdj7ieAV2KIsVkeKlUpnRSept9C5OHF36SuQCBB4Wq2nJZkIx63MutBkDBn+U9Z5z2dxcF7Zp3alVckUfPJ1dk04wPIeqTQHCGckOTCBHvE5j28uwSBOfm7MEM9wKDx8L6LgzwOFHgK4fpMPB8otNnVunUpuvVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(316002)(66946007)(66556008)(66476007)(38350700002)(36756003)(52116002)(6916009)(8676002)(31696002)(16576012)(54906003)(5660300002)(31686004)(38100700002)(8936002)(478600001)(86362001)(2906002)(53546011)(7416002)(7406005)(2616005)(26005)(186003)(6486002)(956004)(44832011)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDZDQmszbEVjTjVwN0lrcDhKdWJ6YU1hUnZaLytMck9qenJ1bDEwazlmWXpO?=
 =?utf-8?B?OWNsbVNVblZ5VHJTNDE4SHRaemhzOWFQK1pEcUp2TUNLNHc0dU5XR0YwYjc3?=
 =?utf-8?B?VGx3NGZML0FCMjE2aVg2VUkxS2VRU041WGY4MHQ4U0FJdklXR1VMekZYcGNV?=
 =?utf-8?B?bDJGZG1MaHRtd3dmMy9id2NqbHUxMUhYWFVna0t4WThSanBOV2xQbmxDKzQr?=
 =?utf-8?B?c2VpbGl2ODNRU1NOL2lvVWwzRlhRTzVPZDNnTnRta1V1OTZVcm5FR2w5Wjkv?=
 =?utf-8?B?cGsvZTZxSlZ3QVU3UTkyYTFsMkVxNWMrdjJINzJYZjZwSHJndEVEWHRsQ01V?=
 =?utf-8?B?Zm13VVlYTHVObFBNdmNwWXVmRE1GeWx2K21WMWtXZUNYYTcxWVN6ZGJOZnlq?=
 =?utf-8?B?OEtFR3Nsalk2V3dubmlFVnkyRWR1K3ZTL2VBWTQ3SWFGV1R3QWhNQmlMNXcx?=
 =?utf-8?B?LytwL1FyREFLanltVkd3ZmZWWFZJN2oxN3QrdVNBS3lIUUFpR3UwWGNCaGhM?=
 =?utf-8?B?cGYwb2JNZDhyRGdFKzNaN2xvSjlRVXl6WVRTazJWazBxWkd5ZlBLUkJ5a3F0?=
 =?utf-8?B?d3FLdnFqN2hKK3VpcjFyNUtvUHlnK2pXeUs1UTc4TzcxOUp1bExxQzdMbGVz?=
 =?utf-8?B?YUxTOHFQbG8yZHBJV1MzSjVQRmRYRTE1K0NQeTdlYWloMnlXYTlOR1lTRC9L?=
 =?utf-8?B?dEdNdHQwb2NKalJtWUUzR3pSYnp4MCtVdGJHcTVTTVA2eGlVNWc0OHQ4Y2ZU?=
 =?utf-8?B?UmhaeWJWQkdiNURjekUxWWpxbmltUGVGZmwveGlqVXkyQUh4a1U2N2xZcHFV?=
 =?utf-8?B?bVFJa0pCaWVacjJpUWFSSlZ3ZUFDWHduMjArWWp2UVJpeEYvdnV2Y0ZQWjN6?=
 =?utf-8?B?VFpJMTJNNFVGaytRdVQwSlZISi9TTnQ3ODdSZkRzRnBPWUhNQnFYVkl0S2Y1?=
 =?utf-8?B?alRqS1g4aFEyckgzY2ZvZzVETjY3U3ZmWDk2bjZnNWpzVkJaMCtRdmRQZU44?=
 =?utf-8?B?LytZL1lYcGlMOVMwbUtYSlUzOElPYUNlTkZ5MG9XdGtXSWVZa2xLaGZxRXFv?=
 =?utf-8?B?Qng5L1N3S041cEhDOTlpZy9MV0wyREtaUmIrdWdsa0QrKzk3bmlubTA5dEpj?=
 =?utf-8?B?QWFjYzFRUDRPdmpoZUsyb3NaaWxaZWZPMnp6QmhROUdIWG9XbnV6MlF1STRh?=
 =?utf-8?B?NVUwU2Fpd29sZmVYTkp6OHRoQ0JMcGpSS1h0NUEyTk90cmxlQjlyaEtqV0o1?=
 =?utf-8?B?Tjl5QU5xQnRhVUNpRkFLRktaN0lEc1RwWTFxeVF6ZlpoTVE5OHk5cTRnRS83?=
 =?utf-8?B?MXd0WFc2TTFQb254WFhKak80cUQzdEZMRXpleWpzUCsvLzZob2lhZHBWQ2g3?=
 =?utf-8?B?eVBjYXNIQ1UzaEErUXNMRUxDVjV3dExiVy9pVXMwYmpsT25XZUxmK2VDWmlC?=
 =?utf-8?B?S1Q2VXNCOUE4S3ByUVdoT0V3Q1RYWkRuOGp4OFJnbUtDai9jMWNKQXYwaFRy?=
 =?utf-8?B?a1JXTExsYUJZS3pPS1p4VVU1UXRUZ3IzVVlPSWk1aHlkYWdMVVZ6cFFkSTE0?=
 =?utf-8?B?dWptWHg1MFdaOXhNTzAreURGNW9YajJwS2JSVU9jdUJ0cjRWMGJDdlpidExW?=
 =?utf-8?B?Z3k3RzdNOG4wUmZqU0dRRmpETEQzanh2MUtmYTBQaDF0bmdUbXlDREJodDlZ?=
 =?utf-8?B?Y3lqaUpuWjU0S1B6WnZvZ1k4Z09zcjlsUldNaHR1bTVBUXVpaWhPcGYrb2Zv?=
 =?utf-8?Q?Lad/egsVQOYEGvlYzA9waj98IlfNtRPPq7xnNTA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76874350-8662-4b76-a8b8-08d96e4bff01
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 19:58:13.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe/o2v03R/8HqmeUQC36QTtd4g6URpR3Phojwk8IDP/ycH3tSAkjaQOyEPToMcoTh22GS5c6PJzldL12DyKVLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/2/21 11:40 AM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:30AM -0500, Brijesh Singh wrote:
>> Version 2 of GHCB specification provides NAEs that can be used by the SNP
> 
> Resolve the "NAE" abbreviation here so that it is clear what this means.
> 
Noted.

>> guest to communicate with the PSP without risk from a malicious hypervisor
>> who wishes to read, alter, drop or replay the messages sent.
> 
> This here says "malicious hypervisor" from which we protect from...
> 
>> In order to communicate with the PSP, the guest need to locate the secrets
>> page inserted by the hypervisor during the SEV-SNP guest launch. The
> 
> ... but this here says the secrets page is inserted by the same
> hypervisor from which we're actually protecting.
> 

The content of the secret page is populated by the PSP. Hypervisor 
cannot alter the contents; all it can do tell the guest where the 
secrets page is present in the memory. The guest will read the secrets 
page to get the VM communication key and use that key to encrypt the 
message send between the PSP and guest.


> You wanna rephrase that to explain what exactly happens so that it
> doesn't sound like we're really trusting the HV with the secrets page.
> 

Sure, I will expand it a bit more.

>> secrets page contains the communication keys used to send and receive the
>> encrypted messages between the guest and the PSP. The secrets page location
>> is passed through the setup_data.
>>
>> Create a platform device that the SNP guest driver can bind to get the
>> platform resources such as encryption key and message id to use to
>> communicate with the PSP. The SNP guest driver can provide userspace
>> interface to get the attestation report, key derivation, extended
>> attestation report etc.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/kernel/sev.c     | 68 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/sev-guest.h |  5 +++
>>   2 files changed, 73 insertions(+)
> 
> ...
> 
>> +static u64 find_secrets_paddr(void)
>> +{
>> +	u64 pa_data = boot_params.cc_blob_address;
>> +	struct cc_blob_sev_info info;
>> +	void *map;
>> +
>> +	/*
>> +	 * The CC blob contains the address of the secrets page, check if the
>> +	 * blob is present.
>> +	 */
>> +	if (!pa_data)
>> +		return 0;
>> +
>> +	map = early_memremap(pa_data, sizeof(info));
>> +	memcpy(&info, map, sizeof(info));
>> +	early_memunmap(map, sizeof(info));
>> +
>> +	/* Verify that secrets page address is passed */
> 
> That's hardly verifying something - if anything, it should say
> 
> 	/* smoke-test the secrets page passed */
> 
Noted.

>> +	if (info.secrets_phys && info.secrets_len == PAGE_SIZE)
>> +		return info.secrets_phys;
> 
> ... which begs the question: how do we verify the HV is not passing some
> garbage instead of an actual secrets page?
> 

Unfortunately, the secrets page does not contain a magic header or uuid 
which a guest can read to verify that the page is actually populated by 
the PSP. But since the page is encrypted before the launch so this page 
is always accessed encrypted. If hypervisor is tricking us then all that 
means is guest OS will get a wrong key and will not be able to 
communicate with the PSP to get the attestation reports etc.


> I guess it is that:
> 
> "SNP_LAUNCH_UPDATE can insert two special pages into the guest’s
> memory: the secrets page and the CPUID page. The secrets page contains
> encryption keys used by the guest to interact with the firmware. Because
> the secrets page is encrypted with the guest’s memory encryption
> key, the hypervisor cannot read the keys. The CPUID page contains
> hypervisor provided CPUID function values that it passes to the guest.
> The firmware validates these values to ensure the hypervisor is not
> providing out-of-range values."
> 
>  From "4.5 Launching a Guest" in the SNP FW ABI spec.
> 
> I think that explanation above is very important wrt to explaining the
> big picture how this all works with those pages injected into the guest
> so I guess somewhere around here a comment should say
> 

I will add more explanation.

> "See section 4.5 Launching a Guest in the SNP FW ABI spec for details
> about those special pages."
> 
> or so.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init add_snp_guest_request(void)
> 
> If anything, that should be called
> 
> init_snp_platform_device()
> 
> or so.
> 

Noted.

>> +{
>> +	struct snp_secrets_page_layout *layout;
>> +	struct snp_guest_platform_data data;
>> +
>> +	if (!sev_feature_enabled(SEV_SNP))
>> +		return -ENODEV;
>> +
>> +	snp_secrets_phys = find_secrets_paddr();
>> +	if (!snp_secrets_phys)
>> +		return -ENODEV;
>> +
>> +	layout = snp_map_secrets_page();
>> +	if (!layout)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * The secrets page contains three VMPCK that can be used for
> 
> What's VMPCK?
> 

VM platform communication key.

>> +	 * communicating with the PSP. We choose the VMPCK0 to encrypt guest
> 
> "We" is?
> 
>> +	 * messages send and receive by the Linux. Provide the key and
> 
> "... by the Linux."?! That sentence needs more love.
> 

I will expand comment a bit more.

>> +	 * id through the platform data to the driver.
>> +	 */
>> +	data.vmpck_id = 0;
>> +	memcpy_fromio(data.vmpck, layout->vmpck0, sizeof(data.vmpck));
>> +
>> +	iounmap(layout);
>> +
>> +	platform_device_add_data(&guest_req_device, &data, sizeof(data));
> 
> Oh look, that function can return an error.
> 

Yes, after seeing Dov comment I am adding more checks and return failure.


>> +
>> +	if (!platform_device_register(&guest_req_device))
>> +		dev_info(&guest_req_device.dev, "secret phys 0x%llx\n", snp_secrets_phys);
> 
> Make that message human-readable - not a debug one.
> 

Sure.

thank
