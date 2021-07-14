Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E913C88EF
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jul 2021 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhGNQu2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 12:50:28 -0400
Received: from mail-sn1anam02on2065.outbound.protection.outlook.com ([40.107.96.65]:47046
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237127AbhGNQuY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Jul 2021 12:50:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZSntvNcMuFTqT4kreDKXFF/ME0HDXMT0BawE8PywH44g+cKw97ULmBeBQ2mZkTq7XdJQqoGjZN0LkpkN5jOZAoK8MEpiDECgRKVFRsplWOBrAZPSJdijBESs6InfR0b/qX5rfTALT9HoMRDjJSrdiEj3aLYdKDdwbe1E0SLQciWg0gMA5pNZbRFz4XwvjJJogFXCr8xt1d1JN2tkTzf6JPz8BqdscAhsJJcLHzCZSSLFlKOEPb9RIfjVYNMYzr3kG5dqYJuamBsK19kqRBJ1k66r32DLDAdTh+rn38D0xZA/2kJXcUJEdAJ9Ad2s8hEKKxpmS9BfaW24UbdxygTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7XhN/qk/RB/NVfKx1aYVTFsTbmXKDNag2Zn+I07J/k=;
 b=jX1Bhpr+gy77i2mEdGfsY1CdcRN/5hfewXRcmFpNf1Z531Ekmm1GIaE2ec8dkaB9q5suSDfkAzeEZhveuqiWC1wAEr5zuDhZEEHI09h56Va87Zbagpd8mg7YXmJnmcInsAUUI7LXWs2E5DBcLQNISlXZ3ZtBPNlj3t6eAAwQkW7l1F0pZMNqAMjAQmnrwRSmChn40Ob+UVO78XHmn/H6FpchfB1JNVvgKnQrznVpfCGGL1zzt8oOW4J7CUyiGhZZ4tqz0qNsYYh3dQt59+0FsyiNxNGlhCHE+M4xADB6hAeVE/AS1DOJpLXa/mjHkSued9+yXzVSZqmj270adFv22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7XhN/qk/RB/NVfKx1aYVTFsTbmXKDNag2Zn+I07J/k=;
 b=0JXJ+wPRdu6FdHnzdzoqbZwcACnZg6zkcGShLXnaXLhAf25Wxaaei+F6tb5AOjtO7JcDS5fAfmiFZ31YJkjEXqvQNGxiV/Wp9XzpGw56Yg99N3vpMr9ySA37F0fADUpbNuuCmbotRgBbvwRx4//Euef8f8Wf4XRyZekauAg7YF8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2784.namprd12.prod.outlook.com (2603:10b6:805:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 16:47:30 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 16:47:30 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 20/40] KVM: SVM: Make AVIC backing, VMSA and
 VMCB memory allocation SNP safe
To:     Marc Orr <marcorr@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-21-brijesh.singh@amd.com>
 <CAA03e5FMD8xvvBdf9gqdoR05xF9+scLZBNLpx9iP6WVWK84xdw@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d8853c94-ebe2-aac1-8e74-e6086420e5a0@amd.com>
Date:   Wed, 14 Jul 2021 11:47:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAA03e5FMD8xvvBdf9gqdoR05xF9+scLZBNLpx9iP6WVWK84xdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0067.namprd02.prod.outlook.com
 (2603:10b6:803:20::29) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0201CA0067.namprd02.prod.outlook.com (2603:10b6:803:20::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 16:47:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 387ffe43-c6f2-42dd-11ba-08d946e71201
X-MS-TrafficTypeDiagnostic: SN6PR12MB2784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB278466F29C0E65CA2809ABD9E5139@SN6PR12MB2784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9u/56sui63VYNAIWidRlVNSEiyCri3aXu40lGfzfhG7CTD/n4KcihkR6wg5J9Mr1Xw7KLrz7J2QYmgrY3pWVOdtudjBNTrI61pKnkul/Hu2AFimhVB5/L1XFtSPvgRjNp6C68osaShe1sFxmmY8brcTZf0YEGVh0lGqYGKCQfMnqGTSdl9P8boRQAE8muAsvjDNQgBvNlYe3HwxbsG7x7zLowBcMPB00t22IoroBrOrm9xjquHAe79i9TRZ84TcLbkKgEkv6rSt1tfgOyymzD/4oNZPNKvND2MlM9+zAS5GS48740nvtaJ8XG8ZE9wDqK7OYbHFm6WiEMMfrqtQn+tfqWge6a71BNZpDaJjs8O3TV4qtoeHJBmRUMhbOqTxubKjqb7U/TrLDqOmPsrZ6mQ7SzVf9sjqWq7KZ1+J4v3h+X+QaZsMoWlL6090ICLRyq9L7fteMkqnEphQN1XgD1/ZfAuDTxZx2KX7sTC/BLtZi2e700Gn2aWNOGXWN2+QZmPL7nWVlVC/2BC2KlOrDy022r5CXsLt87NOWG4g3Rtke410J7nswoQJvJD1tbCNFD+Q6FAkGmsCrc6walN2tsKkv11O/yrLVXTbbHrzBuK2KFhJe2MTsK8GpfodTU4J+waa98dfe5sMXUiCgy1uAqMjxl7ymmMKrFfuCe6SKgNruYJq56spHRc/cLrpQZEWkMrP+8VzsHMYLHQpqp9bijVujJvWugccMcOynKqwzfI2t5tg51lLXeiz+rfC0Qwi6TjrZ2pRSks8OvTq554wXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(7406005)(5660300002)(186003)(31696002)(26005)(558084003)(7416002)(316002)(54906003)(53546011)(36756003)(6486002)(16576012)(2616005)(4326008)(86362001)(8936002)(478600001)(2906002)(956004)(44832011)(38100700002)(38350700002)(31686004)(8676002)(6916009)(66556008)(66946007)(52116002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzAvRjVPbC9Da2hncFJsWUpTelFVL2E0a3lDbVBXdTNwOUxpYUwydTN4TkZp?=
 =?utf-8?B?K084ZjgyaldBUG1wZTlQQ2gvVTZMQkx4ZVhVRHRSSXBNR1FwZmQ0NHhjQzZ4?=
 =?utf-8?B?czhkTUlRdmw2c0tyVDRIWkNSWVdPTkszWWpOWGRMSjdJRWhiMHBaRU10emta?=
 =?utf-8?B?cHhydllCSmJNVHZ1RnhsaVAwUzNTTlVuMTNHcTdJdzhuSGRrQmMxU3NEZHFP?=
 =?utf-8?B?YjI1cnMyZ1N2b3pqcG95TTRFVy9ZN3VRbnd5c0ZNSWtkWDUwK25sZWhUVXR1?=
 =?utf-8?B?VXJreWdZK0lQTzZEZ1BnN3hnN3N1SUtvdlk4a0ludmhOdVFGM2NHZ3JjNUVE?=
 =?utf-8?B?VjRYdlJ6eS9xZmF1TkxGUnVRMUxDeWI3dExqTVMvQ0pOTTV2N3h4NnZRd3Z4?=
 =?utf-8?B?a1FlWENSYzlWdXEwSXN6elpFWGoveUlrenBUUUZSMmxSMmpsNngvQ0VOMXJn?=
 =?utf-8?B?cmp4c1pXN0cyN2ZmSFFzckJiT09wQ21CS0l1c0RhNHRia1BZUGY5TjFJK1l0?=
 =?utf-8?B?T2Q0OUF6M2k4T1VhWDBtQ1BiVnJTcTdyU0pZU0ltc1M3b1lDK0dHS3FvVDBP?=
 =?utf-8?B?NVV0WTFZc2dYMmdYekJrVlQyaGUyTjlOWk9lK29Hdi9rdTlDQXJEOFFvWDAv?=
 =?utf-8?B?UnlYOG9hT0JkczFmbExUMEpRdi9DM3V0Z1pXdURKMmVhaGlLdGhSNSt5cDVM?=
 =?utf-8?B?N0ZwbW03VitqYzU4S0lOZzlRRklmMG1WOXNJYnZnUEt1R2J2MVQwSndpbDFz?=
 =?utf-8?B?WWpsdkQyWkdZK1M4YWl3aHFoaSt6MFh0TldSVWR2R1g5Q1BpVGVvdmc4ayt0?=
 =?utf-8?B?clJNOWVnZ3Ixb1Q2SE9iWEE4aHJ4c2RVSEFlMlV3eUpDNUphU2RDYWRMTE0r?=
 =?utf-8?B?MVU2K0QzVUtBSW0vYjhkTG01aC90ZFl2SnphMXpaUURLdjE5b25HQWtFUTg4?=
 =?utf-8?B?WkJrV2xiOG9QWXA0bUllQ09pUzdnMWFjbnBmVnVVSlRxV0RtWmxvTkUwcDhF?=
 =?utf-8?B?UnJYWHh4MVBuMUZsajA4NjdyM2pwOXMxS3Rkd09BamNPZDJLUktITStJWjEw?=
 =?utf-8?B?RzhOWnBrS0txM0QwczNGWE9SRjJyMGprMkFidDRxRG40bURQYkY2bldnY3pN?=
 =?utf-8?B?UXhQRmlycnUyT2JNeUN5Nm9FcDF2Z1J5WWFCTHlmMkQxMjVzU2MzY3N2T01l?=
 =?utf-8?B?TDlRYTdWS01LTFFXVGJCbHBsdmJ5T3RjSWJXa3ozRDNyRmMvTDUxanFqcmdC?=
 =?utf-8?B?ak5BQVNSeXJyWFVEcE4rVTNqS3hlVzNuM1RTc09Ua3VRVjIwdC9CRHdiWWRP?=
 =?utf-8?B?WncrdWdMRk81L0VDWWJtM0ppdFlVNTZRR21yQ21rLzFMcmI3SWpBUnhlTEtB?=
 =?utf-8?B?WExlTGU2NE5kRW9XK1Z2THNDTlJTNG16a2ZXYXVTRXpaZEU3d1M3OStldWFR?=
 =?utf-8?B?ODFUUjIzcDlkSGhBZmVqbElBWkE1b2l5Y28wWmdTQnViQVNXSWx0bWxackVK?=
 =?utf-8?B?UEJSdEN4ek13OUFVRWgzS3QxNVpXODVMTTFKeUdUelEvY3dIazA1cWVURTdm?=
 =?utf-8?B?UVFxUWFSUlptL01pT3ZEdkh6RlM3ZDRWWkJlNWFFUG9MQjAwT25Hc21MaFdB?=
 =?utf-8?B?bXVoS2pTbTFNOUdVNmgvZDNncjlONVRVZmRLUjdkSnJiUjVCd3BZcWJ4RTYx?=
 =?utf-8?B?ZXNaYWNQNTFzMEtiMTZuYnNGMzR4ZlhUN2NkWnNzQnk0QVk0TkUxbmI3RVR4?=
 =?utf-8?Q?BJKGWix4xXWP9187ifQyxNeVJvof8dfKPChGafJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387ffe43-c6f2-42dd-11ba-08d946e71201
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:47:30.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FC0A58dfv+q6lMY2FtWLSxIbn07LAanu6dlg7EPwnWNkONSKCaWAmq3es2oCJGQYv0n7UkXg7pa3a1M3GaMhRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/14/21 8:35 AM, Marc Orr wrote:
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> 
> Co-developed-by: Marc Orr <marcorr@google.com>
> 
thank you for adding it, it was dropped accidentally.

-Brijesh
