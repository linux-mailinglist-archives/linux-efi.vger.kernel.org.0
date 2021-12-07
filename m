Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4203246C122
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhLGRCN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 12:02:13 -0500
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:44705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231156AbhLGRCL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Dec 2021 12:02:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgyfU9TfWjMhw3Tu+0QAQBS2dqtxsB0XZiPoEnVr5arVtanTOCA0e/CRY+OQT8VLxWV6iTcJvNqm78KABMJtVOslqpBFEVRlOrCGcKBwPG+Jw6W+GVX2T7hLjd6SRySkM/N3SMECZmIc+CSVhuJCBT/MALgKw+ks7AhUTfEfFLYF/AMr6cj3D9jrvUE+SHuy3MHgXGkgSn/MJyMxfSyazisr+BXVoqIqQ2c8mZ7q4kdEV7LpOFoHf0ahiqpaSlEfOoCJC4Co3G4AfsL9O+vtqJuFRYeKN8w4be0w5c9lD2mt5sznJPOQJQjAQTdnSDKpV8jJA50pK0w9VDaZAN3XBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PSJGliktM7n9LlGv3b0KjaF5kO470lQPWSuglWfZDE=;
 b=gjnu/jPm+4XepSqnxDiM/F4HTEdv3Aggw/1GfxpQyc4pzZFQ9d901EN/26YqNAgFzheuo0fK14q42TqdvGR3x1QIyWT4nx6u1SU28HS+L/f5lDCkBTV7fqYjLFxbuuY1O2vKsKTbH+VXp9IXAraswoFhL1jinWLHIWsqrsirnjabObURMHRqjybKRfj5qtHzd0ihUe3OAD1QFQvorDl7Gx3XQ/AAXHLNWd8nPSEAe/ZevO/niJfy7IKgyLIrrdeTomfCE823NL0uW4tM0IS3mRpqcEwgCgosb2bmr0NSm8IyPsf7V0Al3n2l+S4FoRJ0kuhhLkX37Yr8v3l7ykI6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PSJGliktM7n9LlGv3b0KjaF5kO470lQPWSuglWfZDE=;
 b=kvM/sp3bEOWgc+/cLw1zsQ07s66kz8RxdAwSrMbaCwCRI3+Ac/H7SpC3isv8thooALmy13BsGPs66Kc48bZDPPVdzueXXAgsWLM5oj8X/75Fk7qv6wvO4duqiWxklOIKzDdBBKsFce4TMYumC8dKl7Xfr9fCgkCLwiMUctT4x0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 16:58:37 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 16:58:37 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 09/45] x86/sev: Save the negotiated GHCB version
To:     Borislav Petkov <bp@alien8.de>, Tianyu Lan <ltykernel@gmail.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-10-brijesh.singh@amd.com>
 <5b1c348a-fc26-e257-7bc2-82d1326de321@gmail.com> <Ya9e7fDxj6WiomqI@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5dea5250-d4fe-4f7b-91c1-a0460ed139b1@amd.com>
Date:   Tue, 7 Dec 2021 10:58:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <Ya9e7fDxj6WiomqI@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:207:3d::25) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:207:3d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Tue, 7 Dec 2021 16:58:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12356a45-ebc9-4f58-2a82-08d9b9a2cfd0
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB46725A58765235656E6817EBE56E9@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/lm4PQcHpBpDi7ZqsqarGissDyrojIykMDrxRhvJwDo/iLmYGY+vx8WVLP6ermdU3tyh3vOjgbFzMEtcZ6WciCYQdPPB7QObksA51LMHsnMI1HsttZfjsIQ+bXbaEmzZL+jZES//qFRpZwGxz3otrgPfNMUs+qkAIC/V5mys1TzrBxYz429oC1deP3Az2OsdC+99xlTVw8/qlCa9xEwd/0bcIZGMx/HApQyJ5Nu+mBrA+X9DLEu8BpG844mdeXZg0XStEPdQCObu2D9pPGtM6s787Jfc22YfRL752zGsFQ89ODmD+Yjmf+iMXCZ7OuaUCqCymyR3buFbsa5whTX7dn9leaj9Ic3bkwvToyaqKsZR7pLI7HQpOaKScmiqjaL7UvShPz6fS2Sh0yDWhPPRXxXSsR29Ig4FO+jWHdUDpBfdM5DjubFID3NWAM9nERF0AeAZhnKAXf/8xGD4fgmmkHMpMWzXgpgc8oRrGhlFSWUXier8ghO8GEX3XKIhxSw3k2yc/aLq3Kpl++e61/26LbFwVCWbHkNvM1PSGPNokxM4VH09IWadzTr8MWEPXL3vg3vq6hbZckwrPrrJdDSY5e654TaflOpB4TgiIbukU40knzn0WaCO+rjos9JoKF6Zjgc4rJGm7GSLbdxVtF4LSPBAmwS08PvcKY57f8wwLk9UuQocVoentie+FLbvyPQJ9tQZ2/RNxorgRTHeiHL5tOfwCkvOvPXHRJoiP95477SU+dtebzwWiyX7T1c/Wad
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(5660300002)(8936002)(316002)(66556008)(110136005)(54906003)(16576012)(38100700002)(508600001)(2906002)(26005)(6486002)(8676002)(186003)(53546011)(66946007)(66476007)(4326008)(31686004)(36756003)(7406005)(7416002)(44832011)(2616005)(31696002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0R0dUZyZ3dZbWVIS05Eck16MVd3U0d6ZWJXREwrOTA4Mm1aNGhrS2xsdjhu?=
 =?utf-8?B?dEtEQ1FOMU5XVE40dG1jamc0YU1wOFEwdVBkV2l0Z2pXSlUvTXVkdXBWSFp4?=
 =?utf-8?B?Wm40ZmdPcDZQUEQxWWttOHJoeUQwaEtkdXNGL3FGalNSd0MwN25lUlQ3ZkFv?=
 =?utf-8?B?NWlHZVNIbHFvNnpHOGRwc05BU3NHdDdoTjg2VW9Jc1lJTURGSCtyaDg0dnlF?=
 =?utf-8?B?d3F6QUoxTzFCamROaWw2RFNLdXlCUzU2YXpGU2J5ZitEbVJzNmhZMkRQYnJD?=
 =?utf-8?B?M1VIaHlYUjR5ZFpuOFNIb0FLakZZZHl2cVQ3a1M1R25sUHZjd1FRUGhMWDA5?=
 =?utf-8?B?aXFsekQwQnNCeTVhRUVYQ09lY05VcnQ3N0dIbWsvZmVUaE41OEo3aVZZSEZn?=
 =?utf-8?B?amhlM3RzZVNSMWpmNjdDM2lWd2lZWk1ldy9NNnc4TThmakxydjRveW9ENUtC?=
 =?utf-8?B?a2pFZEQxRUY4RlVKb0JhNmdsZlFVKzlMUjNPci9yK3FtQnhXOHludStlQ0tM?=
 =?utf-8?B?TGNIZGhsaXVOaVJOM0lzWmdld0NaaXNtdDdETEtSa09ySVhGTWZSWHFySEFv?=
 =?utf-8?B?NFhvZW5yaGJ0RWdHYkNRTS9pUVhoWjZwNFM4L1ljRGZXTGNBQVI1aFBvdlBE?=
 =?utf-8?B?V3l5ckZLRUI1dVFrN05YZEF0UjhvVkdRS002ZHU1cjRjeHFVWGhzakJ2SGYr?=
 =?utf-8?B?RGcxcjZNSFhzaG0xa2FremhyY2ZrZ0lxZmUxZXpLb253b2pVWFZTUm5BYkl6?=
 =?utf-8?B?M0dmN1JEL1cwV2R4VW1VWjhZclRzcEZEdkRmMFFLNEJoOFh4R014OTNtcXA4?=
 =?utf-8?B?R2lENFBHSlZOenErOEJPOVZTb2xvVUp0MW95UDh0RVlFOW5TS1VnQzF6ZE5P?=
 =?utf-8?B?MVhXdlAyZUFXOTVyRUFId0VRYlo1OGRyVkM0eEVaUzRsemk4d2dlamhXeXdW?=
 =?utf-8?B?Uko3Vzl2RVBMQnBvYmRISTMrMDMrTjAzY3NBbnRpdHh3SmU1Ynk1cFlIclNW?=
 =?utf-8?B?TGJ4NU5ESTRhN2tWZEdWLy8ybDMxZ2FlU3RXVW1VRnEydksrcHVmV2hCRTFq?=
 =?utf-8?B?U3ZGbVQ2SENzWEpYVlhSYWQyNXNRdTB0bU9lVEZiN3FiTEdaTUd4MUtyZWVp?=
 =?utf-8?B?NElRbzlXY3VNZzAxdlh5WFIycGJSMFhZem5zMFdLazEzMHBOQWtmb0lUSHJu?=
 =?utf-8?B?cWJnNnRscjVxV3lHQTQrSm1XMGJEdkFOMnhCNXJ0OEQwTWRmRWdZVXora20r?=
 =?utf-8?B?MTk5Q29JOVlEY3ZYZndUVmg2QkUwbkRMb1BtUk0zNEVTVWtlT1VWVFZMdjVK?=
 =?utf-8?B?SU84dHhGK091ZGpNc28vTTVJa0VOS01uMXEybWlpbi9IVWNSMzRnN2E4SEhN?=
 =?utf-8?B?TFhMT0QrekdOVkZMSUxkYUZESkVwNWtrbzNBK1pmaXZ6bkc0VTZKQzZ6eGNK?=
 =?utf-8?B?OFVSaElHVUxxYnFVVnFPcEFBKzlyc3dEM3hYU1JiL0M3WXd3eUM5SHFqMEM0?=
 =?utf-8?B?UXlCVHNEVmh0TUx3SlRpUGFpcXpvb3k0RjdrWHEvZngwbHo4MzZkNzg2eHZN?=
 =?utf-8?B?T3NBMXhCdUEydzJGZGJxMnNvenpramhmWVI3c1VFNDV6TTRQVEIvTitiWWMv?=
 =?utf-8?B?cDkreUc1dUsvSWJ2UW15bndCZ1o3UDZJWmRsTjY5S2J4MEx0Uk9ZMjFEaEZK?=
 =?utf-8?B?NzBBODNJQTErbGlxaWN4Z3BNVFpDK3lqeUVnTC8zM1hEb1hYbTFaZEQxZU1B?=
 =?utf-8?B?REQ2RWxBMHNnczFSSDJ5YVd3SGp4ejBmbmdIU0c1UFE5cCszbkxZZFJGYWxU?=
 =?utf-8?B?UkpQSTlDYkU2YnYrbFNLaDhwRmhMd1U5T01YN0lvRTl3cEFLRlExRUNISWdm?=
 =?utf-8?B?SzdMU2kyWFUrc2tJZS9qdDlhYXMwWk51dEM0Z2pNbDlLa1ZBcldxQm52aTBr?=
 =?utf-8?B?dnVFeUJ5bDltQkdhNjBnOFNKQ1pzUzhNRzkrcWM3N1AwVnh2S0tRZ2M5RTJE?=
 =?utf-8?B?UjZiZWlPazR1cmJrRDBGUVl0WHgxZUp3WGxMajg2OGRZU3BJZGdjZHBkbWkw?=
 =?utf-8?B?Z05tdzRLZUROV3Q3SEhiTlFXSDY3eVZQRVI3b0tvbGF4bnVmd3BzWHRxTnkr?=
 =?utf-8?B?THAxMFRTbENZMU44cTZmRU9maUFFUEtReFZFbmk5S2xOUzNNREJLRFRqZk1J?=
 =?utf-8?Q?N49DGRN9RWVZQ+fKvIh+1Ec=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12356a45-ebc9-4f58-2a82-08d9b9a2cfd0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 16:58:37.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncixJwFBsi2bTg04J6hUPYJs8wNejRYcapgd4e0+LwjqdD7Y7CB/aMl0sbk62Mmcs/Del++LAwoAwO7PS+YTNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/7/21 7:17 AM, Borislav Petkov wrote:
> On Tue, Dec 07, 2021 at 08:51:53PM +0800, Tianyu Lan wrote:
>> Hi Brijesh:
> 
> Do me a favor please and learn not to top-post on a public mailing list.
> Also, take the time to read Documentation/process/ before you send
> upstream patches and how to work with the community in general.
> 
>> We find this patch breaks AMD SEV support in the Hyper-V Isolation
>> VM. Hyper-V code also uses sev_es_ghcb_hv_call() to read or write msr
>> value. The sev_es_check_cpu_features() isn't called in the Hyper-V
>> code and so the ghcb_version is always 0.
> 
> If hyperv is going to expose hypervisor features, then it better report
> GHCB v2. If not, then I guess < 2 or 1 or so, depending on how this is
> defined.
> 
>> Could you add a new parameter ghcb_version for sev_es_ghcb_hv_call()
>> and then caller may input ghcb_version?
> 
> No, your hypervisor needs to adhere to the spec and report proper ghcb
> version. We won't be doing any accomodate-hyperv hacks.
> 


Agreed, the HyperV support need to negotiate the GHCB version before 
making those HC. In the current patch, the sev_es_negotiate_protocol() 
will save the ghcb_version in global variable and the saved value is 
used during the HC. Just make sure that initial HyperV support is 
adhering to the specification.

thanks
