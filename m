Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F13E5E70
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbhHJO6Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 10:58:16 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:10624
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236686AbhHJO6Q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Aug 2021 10:58:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjBgB/JzCiBSTmp/n1ExTeraaG45qgdAr4prJcif3Z6ZjWXuaT3bRmL44fa3lALZuDCGn3PnXHUhnZEm7eTo9g9J/9T5O6GULgUmub9cjrTK3RzYl34JIW/FhXzSS/LWeNSJor/ZZWeK5VnSIFxtMdotYCrkW1jjERBHCdJ273n2X1KXfaJtgF967bUsB9XH6ot+WvGR1Zgm3BHn+8v9HQTe5CF4xkao5pjbRqjfKIONO2egQ+nsSBhitLhhqp3167REOuvjjRcTvMDlBEyM40SWM+yoEaABJfZXsknku/4zXyoJNC4n1Dyqrd127c0l2/TCVkOMDacmzZM/UclmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNoKh6Bqm9yYfCZF0XEf2JmeFAf97I2JcRU7XY2CDQc=;
 b=M4YOYMssKK2DwK+DSNiEZHWq8pkjUvfQ/zMQKg6MptKsMrCy2kXJMeZnD5WI7BnOEkdrbw8KjBoR7eSLY9D79CJJAqwQ1o8Ncb1QipNtwMgUZTbxlpTgS5hc0Jz6LefiXhFmeequUo6yAmXW+Ozun/278Sn0XrFqMqNGUEV4W055cNgsZCJqhzdwcKycLvv8rA9YiyEz/iEjsaXkPB2vjN/rLzFSl3mlsvKweSbhfPeTSk5/faaQDtgNn+Zw/Bi4e02D7YM/5dPo8zGN9ySXXxYO/YruA6tKNxMg6LCExOWKSmdEc+N7i0HRSCkN2xRa3EQj3VPH4OF0ibJoxKDtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNoKh6Bqm9yYfCZF0XEf2JmeFAf97I2JcRU7XY2CDQc=;
 b=XE7+qfF7NgSQ+Sb0hwEab79FXLsWqk0+7jNLwuWvUhZyBSkAP0w4oMkJQf0849zqnbxoUiIp+GnG4MCmtYvP+ydUh+QzTNbsNMdY1PABG8cuwtTC/Ad3JpkkABAch2T4NAsHLCNT/lzIZhP9ifB2T7grViqqVpuphWUGIUrmLSU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 14:57:42 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 14:57:42 +0000
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
Subject: Re: [PATCH Part1 RFC v4 04/36] x86/mm: Add sev_feature_enabled()
 helper
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-5-brijesh.singh@amd.com> <YRJiEwvUJpO9LUfC@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <da64efd3-4293-bcfa-adce-92e0647ff203@amd.com>
Date:   Tue, 10 Aug 2021 09:57:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRJiEwvUJpO9LUfC@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN6PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:805:106::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.4 via Frontend Transport; Tue, 10 Aug 2021 14:57:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fcd8c81-68c4-4b2d-dbd8-08d95c0f340d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4495C09972F85A261D14DA81E5F79@SA0PR12MB4495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEI8xuwz/IMYa+nc7BSh/ZgCEaTWWunUpHGFMtRbQAe/5GfqvADrORJQEXXxihd3CtOO232dFXvA5yVsUC+8CJpzDUG6+0zvWmKv3Isgv0zwrSqbrATzXDk1rxTb2lGCMVf9ZGow8E1Qyj6nma+r9l/cCv4zg+4JjHyDaxSpbym1DYZZ+xrMpXqu0v4z7hPZXoTi3ubmx9qDPNk+NMYNcEYhdKZx0RiNIFhQ+bSO4nW7Kl4ots2lPZMuAt6D1yvPXyp8hlOjRU7uT2QcXrCUyqcDdiXBytvzXleN/PLH2XMPSx8dtQtbZuadsvry360qZMw1Juu1nyBv163vJG755+Os5PxsgWcDac0JKC4x8WiEmHKEpge1za6o2syG2Qvz8qqhWUP/WzvwvsoaNCRAuPgVZE3X7brYVuB9lYTJE8oqxx6/YxyzFAvWEhyB0Ql3k7TgzZ6I3fRr3c3u0nZJzTvIodGGqVgj5MoWvkitlNmZgzhZsQgRpYyRJaHWSzpc7vqo8mqGu4XJpPBEAZvhMvitR1bkKBw6eloIHsm2CLRB0wJQwl0wTLzxin+cO9PT9X7svFy+CSyi6U5UJA2L4V3DfTGi0eL+kXJIa4EWe9EfTfjFmP8GwHhqiEgi/raFcbf9Kg17qZ3BrQchhIiWfxgW/v05e6/lwTfkfX/JcseqSCurst4+APtZAPXwKUwsXoKgJmS651lI1f3hGdWWVSpnhdkiq61p91T2gIwE3/ZaohU6nAd5u6boyoWtl0t3Qv+vXDISnNDwrD3oJdLmg9N/m0EF0mTtkhZCLh082VxeX0eSpG7ZcJhj6Z7JUV8CT+nFzhdCDhR1xC1a06eQgEqEK14/3TOYYAplAXaCrNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(966005)(6486002)(6916009)(66476007)(16576012)(8676002)(7416002)(5660300002)(66946007)(7406005)(66556008)(478600001)(316002)(54906003)(45080400002)(31686004)(52116002)(26005)(186003)(2616005)(8936002)(2906002)(4744005)(38350700002)(38100700002)(53546011)(4326008)(956004)(44832011)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEp4NERVUlBHTlZ4TkxlR1BGNVdXRlFmb2laYk1NWCtTYjJxNFRLeXdKeWRH?=
 =?utf-8?B?UStSdFhjazM1OFBKYkZITkRobFNXN1NrZU9TckhGYWQ0QnFzRkpLSThhZVVI?=
 =?utf-8?B?bk5xN1dsbDNxcHo5N3UvM3JFN3A0SXNISDlpZzZGUEJQQi9wQ1JoRWdLYVFH?=
 =?utf-8?B?YkZ3Zlk1UE9sK2wvby9tQzN1cVpwY2svejJKY1NPWDhJc0VNRXNBcjBROTBW?=
 =?utf-8?B?THp3OEs2QjdMdVlURTlkRjBVOEhnOHY0N09PL3RWQzdoUHc3emtwYmc3SXY1?=
 =?utf-8?B?LzBQdXNJV0s5WnNUclNJQlUxNVB6YUlaRjB4TlJ0d2xKcW1QU2UxVGhPMEZk?=
 =?utf-8?B?WEl0T0dRd2V2dndkSC8wNS9YcUdyNllRSHQzeithZDQ0c2FESEw1MjNNSUF4?=
 =?utf-8?B?UHZUK2x5bmFoMFczWjZ1d0JCWWZKZE9jWWtYclNpcVYxdmc1cVN3S2wwWDNW?=
 =?utf-8?B?cm1OK1k1T0F1R0NRMlFIMmF6cG43ZjczNVNtT1Y3Yjl0Y2dPaG90UVUrT1l1?=
 =?utf-8?B?aUI3dFBSUk8vTHlzcFZ5VDBTcGVnelluMVNSa0RnZ2lzOWZBeXg3eG9MckxJ?=
 =?utf-8?B?K2FXQllRTVBrL25yK0NKSVZIZ0FCZnVkMnF2THprL3Z0aDhZUjlYa1QzcUY5?=
 =?utf-8?B?RmVQYnJCaXQvZ0w0Tjc4bEVBQlZpOVJCajY3SVptYmRkdzl1N1o2Y0JIMzRN?=
 =?utf-8?B?aGhrMXNKb3A3S1A4Y0lJNU5XcXBkODl5L2FnWkxxWStKRW5rYURyamk4YVVN?=
 =?utf-8?B?b1pQRk5WOXNycncrRlNPTDQxNXV3aHdXdUV4dEM1MDMvQ3FtNGc3dkhsSG4x?=
 =?utf-8?B?VGUySmxRbU1HWFV2ZzBNcG5IbkdOSTM3cjRkRmI2bmZtVnNzN3AyZUpiOUVo?=
 =?utf-8?B?dkRWYlhHUkJGdzNpRnA4VVRiRFNseTdUbGtoQ3RqeWY1SDFBN1hHWnpKaGhI?=
 =?utf-8?B?bFl1UE9HVUVEUDViRGowMlg4UzZ2THNyU09LY2RiTHM0NktSVUE3bVcyZkZn?=
 =?utf-8?B?ZUd5dzQ2ajIvZzh6MGRIYm9yblhJZXVCQTF6aUlYTSt4R1o1dis4U2dFTzBk?=
 =?utf-8?B?RHNkRjlkdlBZc3BMM2g1WjVjNGJiam9lbnMwQjdYTklodmhoazdjcXBxekkr?=
 =?utf-8?B?SVl6OWt4NWF3RUJ6ZkQzTzZPdE5QT25sMTRvdzZ5eDZpaGp2c2tWN29wYm0w?=
 =?utf-8?B?aVJqRGlJdHR5K3BkMmszdUJuN0NnTVA2b3ZmcXFaOHIyOEFSK085NzV5N2d2?=
 =?utf-8?B?VXZoSW1xZXpTVi85SkN3T2ViblNKc0ExcmxaeHpvUDR2TFVOcHdHeVlKd3lZ?=
 =?utf-8?B?WU9NUUtnQjJtM0JnTWNML0tUNldpNENLSGFOUU1kMzlUNkxVWThZV2J2YXVN?=
 =?utf-8?B?NW5uV3ZKU0pDdGNaWnVWejNiQ1N0NWpVQjVrZzNhUDF1Z2h3alJjYjFuYmsx?=
 =?utf-8?B?R2duTnMxaStrajRWK2RidGwrTHJ2M2hQZHhqeklaZWY0OHIzTHJNaklFNEl0?=
 =?utf-8?B?UkFuS2ZyRHphc3dqNitJUkhBakQ3SUlxU3hCTkJxdXAwMGIyMmJXQlorNVE4?=
 =?utf-8?B?NzQxeERPN25adHYzdHA3RDd0b3BBQjBwQlRRZVlGSjUrR2VZUU0zZllHcFFq?=
 =?utf-8?B?MFlQNXNQNjFzZUpHenl4NlN1ZENIYUNMU1RDV0FESmt2NlhGU2JPUW44dXNl?=
 =?utf-8?B?Q2I2cy9KdjFHNjJEWStGVGUwc25hM1dWYVBzd1p2MmwxT3M2Vk1lYU5pNXB3?=
 =?utf-8?Q?VRPcV3H6fvRbsqx+6g2UiaLV7plRV/O8yeiD1el?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcd8c81-68c4-4b2d-dbd8-08d95c0f340d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 14:57:41.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfQHxxv49vcvm/8NQ9fvIu87aADoq07m3m/mBTPZXNl9yE//rfBWS3T6RSzPwO/hRN5csDoUHVfK1pEXeYW48Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/10/21 6:25 AM, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:34PM -0500, Brijesh Singh wrote:
>> The sev_feature_enabled() helper can be used by the guest to query whether
>> the SNP - Secure Nested Paging feature is active.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/include/asm/mem_encrypt.h |  8 ++++++++
>>   arch/x86/include/asm/msr-index.h   |  2 ++
>>   arch/x86/mm/mem_encrypt.c          | 14 ++++++++++++++
>>   3 files changed, 24 insertions(+)
> 
> This will get replaced by this I presume:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2Fcover.1627424773.git.thomas.lendacky%40amd.com&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C15d8b87644e148488da408d95bf16ae3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637641914718165877%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UMRigkWSG2h%2BZ4L08AUlG0JeUiqMb9te52LprPrq51M%3D&amp;reserved=0
> 

Yes.

thanks
