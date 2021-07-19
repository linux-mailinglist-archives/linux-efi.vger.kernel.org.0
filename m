Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C0A3CEE84
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358224AbhGSVDH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 17:03:07 -0400
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:37600
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388468AbhGSUzz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 16:55:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoVqKdX9kY744x+u4gawdpE+5F8pQ36+uy4VjecovSXTFZRbHZL6WmFANzSlUbn/irmn5E4SnMyXCfL7rq8cEhf83aHJdma1y9qNhOibQdEF9ITy4Lm0MsAmwFPeo062xD8flhdBbDpNu69Bj8hpUc+hUynzTewbMvFYi+OMbUTPN1lJHC1Nw4BdK+c0qE/MrRPstaQJKlkG3a49KZtsmvFT9z2dd4WKWeKRXU12Ksp7IkzvJ78OzBjKxZ952Zy6B1XzlNWmcFRdIb9ja1Zw+ILUGI8jpt23cQY1hllu5I8LIxppZUFPwuMAX9g5LCVhCOBKDwrfAZq98et4rtGeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N+Hh/Az80WuIPkMAcpwHqeDDzIQKeRA3nAz5WBVfqk=;
 b=MJnkNawibVYppynuW5GgbPsnHPUT52V/uo6sixiAS7aM4a3xyKCElaq8B0sduxVkEfLrV6usT0BgZcaDOWwQm8OG1rCLNkLQ8r6edA+UeTOO9QGzAbG6zCaVO+/JGQRGb2+uZr7EIwfctPYb629tqAryfEIOct3YZfSTgGPhq/8l+9mATfCk5TMNzDchdjCD7vFTY4sRu4f+RzMg+osG3YyxIahOuDxqkeyaEoyBh63TRCHVM5XnE9dM3N5bTq1idwbc0jG9k/sbqMDxnzT+2JDQOZAwm9xRlhBVf/Dcq0NTjf0PV7/BR0ru61YwVwFvW0/1KbPtlkLlDfKpR3aKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N+Hh/Az80WuIPkMAcpwHqeDDzIQKeRA3nAz5WBVfqk=;
 b=iFgp4Eq4OUcNSFybIjDqsvLzpy4pdhisj5xTJ0mV+X7Y+X78iPVj0f9q5uCYKGtCEHv0WEcpEpbURtvIZ5HpQ8WPOtA4eZvWJwaA7M1GQdG4Nx8PXrCkWC5tfOlka2gy64CaHJM5F6olOWP0aZ+VVLvuK2RHTcG45TVx1oAEmEY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 21:36:29 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 21:36:29 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 24/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_UPDATE command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-25-brijesh.singh@amd.com> <YPHlt4VCm6b2MZMs@google.com>
 <a574de6d-f810-004f-dad2-33e3f389482b@amd.com> <YPXl7sVBx7lDLx/U@google.com>
 <4af1b784-2744-5f9e-59f6-dd8b9de2ec4d@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <99163aeb-92c0-88e5-0796-f87bdfa5bb98@amd.com>
Date:   Mon, 19 Jul 2021 16:36:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <4af1b784-2744-5f9e-59f6-dd8b9de2ec4d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:806:f2::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0029.namprd04.prod.outlook.com (2603:10b6:806:f2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:36:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1de3fe0-bd60-4473-fa49-08d94afd4504
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447CABE92C125C79E6B3664E5E19@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ1yaF0GBsewDRGu3vw9SE390qRYhajo/A4tTCukDlunTkwSVmrU/FXRaofzTDPDXa6klEfEobvT4puOis/Q8oM4eBfNHx0H0lX/vaRb02fgXM8IKSY/B/YnNd+74hDI7YCQKQ+AESE/U0UhA3PyA0HmlrVufel+ZKqA8A+7aPhJC3L2fmrt+uUrdeA0CUrkzKHe38czS1VImRMe6HwiZwofVn3eDRR4uAiqXQknI79k0ZCYrZoRvv+5uXrI1y7iwoZZfk6RpVI7X3msqYLrjRWzx0Gsz1q0kLBIZInYXTXmlm2YwsohKDi8GFpm0G6VC1X2mVsdbSorSTiKLWLnDbjMp6sIJRHSSl5oX5tmnVmEmXYlnqa3Wh8ZVdtht1PITXp4YBnxTCmHFuw3XmHrEz+fKqWU7jxWNr5Gb8CRPUkcEYqdHiyyhFgs8WIpUdHg7nbHb4EagJGwAOxla9AATGBYs7st3aSEzGjLpWmcRXal1ChGp6RRJ46ZV3gHaV1RtJgPJiHf/Hd5qm2b5AlRFvQpqu5dy9tgeGWlGZZQRQbQVEXBUUTPF/8acyQIlvCkR0Y4maD4FassjBR84S8pqMp20U4vrW/J9e3mBJz/vPnazvK3BPQuAqCeKtcf2wERDjL2Ri8c/3Qpim2yIlCNFZom6RDcI/iVn0hel9O97h/rdL/EGYPo/yZ3LIkntB+kBqmb/80WjHx49q5mdImcSkB3pVldXGHTcYaYrngnPBTX0PTyCXy4VxF4O9M4uq5zq9da0+woOVYmFHzAgbbACw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(5660300002)(316002)(52116002)(8676002)(54906003)(478600001)(6486002)(6916009)(2906002)(186003)(53546011)(558084003)(26005)(8936002)(16576012)(2616005)(4326008)(7406005)(7416002)(31686004)(83380400001)(86362001)(38350700002)(38100700002)(66946007)(66476007)(31696002)(44832011)(66556008)(956004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJTdUxXK2lmcTBPSFh6cExmbDN0TGVDOGNHYmRTMFMyYUt4bGsyNFY3L3pr?=
 =?utf-8?B?UFF2OS9Dems1YUJyWkpPaC9xRXpkRUY2VGRaeFJ3YWtOT3BRVndmbWl0Y2lO?=
 =?utf-8?B?Zlc3ZVRGQmpBa1VYNk16SU1DTTdxMmJDUkk1ZEFjcXp0dEVPRnc0UjFNdUtB?=
 =?utf-8?B?b0lVTG9tbkh0VjlBbmZTSGpuVEJCSSthTlJCL1FkdnZxbkRKb0IxZU85OENq?=
 =?utf-8?B?N2FnUHZobkJSUUNhSHJ6T0FTZEJRNEpkbHpZLzd5Zjh3dDg0Q2tZa1NlNEVV?=
 =?utf-8?B?eDA4Nm9DcXVhc1YremROcitodWEyNFM4ejhkOTdzcERuSjNUaVd1VWtEU25s?=
 =?utf-8?B?REVyUU9nK2oxbEUrVWtRYmczSVR5cE04SkNjVjJHcTBYc0NqSVVnVCtpMFpC?=
 =?utf-8?B?dW5MQkRIa1NuNzFXbXJBT21XNWlJUXArdzhuR2QyUWE3RmlhNzVSNTZYcmFD?=
 =?utf-8?B?cG5XL05WWXYwZlpIOXYzc1NSdUQ0cjVkaTk5U1hVUjcxWVU0NWEvWC9nRTBC?=
 =?utf-8?B?cUVkbFQ5cGlaMEdJM0R0d0RLQ2pnVGpVZDdodExpVzM0VSt1ZGl3Qk9kbm1Q?=
 =?utf-8?B?RFltYWYvNVZzdk53V1BBYkRRK2pCb0pVQjR6ZHhMaFpweTN1eGNicnl6cHVw?=
 =?utf-8?B?N2Zrc25zVW00RzQvUDV6cUt6dTRGWHRVdkZpQ1RJbDlwWW5xTmNSN3NkaWVy?=
 =?utf-8?B?THR3OUVIekJUL2l1R3V5TTBzMHQ0dVBIeGFUbHl3NDBub05QUHlLakg1VVhp?=
 =?utf-8?B?dzNFdjFncVBkNnZSejUxYmZhSERwaW5rcFg1WUxPZDN1VC9oMDdOZ3lOeHlr?=
 =?utf-8?B?MWFwMGNCWkFtU1Z5aklpV0dZZXZWVkpSVFR5TUJVd2NOaGIzT0xFdnZaY1F1?=
 =?utf-8?B?R2cvMTFpUytYSmtic3QySk5za3JXcXlHbmxGaTc5OEp3ZzAzTlZ4Q3c5c1Vr?=
 =?utf-8?B?dEp2djA0NG0vdklyWk16dDBGTnRYUnJ1cWJtazVrQi82c2ZzWG5XUGVRRGNN?=
 =?utf-8?B?R3RmTWxpUlRVVlZYanBQZDRrS1BtQWpjUTg4NFJOYSt3cWRIeW5uTlhoSkJ6?=
 =?utf-8?B?dnBRdkV3Uit6ZVVsR2hVeklXTnkybjBsazF4Tnl0YklDT1Z4aUE5Wm5kWjJn?=
 =?utf-8?B?OTNjZnBnZDNsTjBFb2JuNzB5aTFsNlNYWkVMcTRXTlRpNnRsbVFpdXpBTW9p?=
 =?utf-8?B?ck03TDJVcjY4ZWtCellxRCtZWHBrdjVCV3gzTWJhWER0OGRUcHVBaVFOSmh4?=
 =?utf-8?B?Yldib2orVmNyREVycGVXWjN6SnM5T1orNERGWi9XTHpKM3FRWG1tcVZ1YmVI?=
 =?utf-8?B?SzBUTVpZaVBrNVNlcWk2LzNEbG0rRDZtaFpNRU5wdm5JSHlxNmsvY0FkcTAr?=
 =?utf-8?B?bU5JYzZGWkh4M1VvTCtneHM0dGpWeWFaUnNHcFNVL3VnWGltS1o0cjNhMHg3?=
 =?utf-8?B?cVVPTXQvMXplWXgvRmIxR3NzU1I0QWRJNnViS0Z0aGxkTWM5ajVRdDNvOGVm?=
 =?utf-8?B?cjA3Q2FySGkxK29kYlZGejZwaXpuMWtpOHozMzFQWnBVZi8xRUloaGxlQnVP?=
 =?utf-8?B?Q0pyTlVKeFNrUm9XNUpMVmhlSWJPWWk2c2M2KzZOL2dvY2lmbnJyR1VMWi9D?=
 =?utf-8?B?endpNGpldFQ2bStIQ2xXc0F5YWxQTEZjamlNWjZvbVNZTmlURUc2UHRrYjhm?=
 =?utf-8?B?bkUrRUw4SUJHUXRkOENuU0NEZGIwQllja083QWp2Rm16NzY1M1hQWW9FcGJy?=
 =?utf-8?Q?TTz8bOf2DH2roRZSqeKnPMKYFj7m8ZZ1SAYcokF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1de3fe0-bd60-4473-fa49-08d94afd4504
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:36:29.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaYt4itDowi8GVvkHk9beoXhADBHvu+qflfT2/2o80ssWAxmyWXbonIC2nJ+ZqD1u0DoMWU1kmEMEAv/WwaTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 4:34 PM, Brijesh Singh wrote:
> 
> 
> On 7/19/21 3:51 PM, Sean Christopherson wrote:
>>
>> Hmm, and there's no indication on success that the previous entry was 
>> assigned?

I missed commenting on this.

Yes, there is no hint that page was previously assigned or validated.

thanks
