Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487793A9BBA
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhFPNMi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 09:12:38 -0400
Received: from mail-bn8nam08on2076.outbound.protection.outlook.com ([40.107.100.76]:41057
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230087AbhFPNMg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 09:12:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF0xCX0P7CzAhAxHllGjiUUoikSF4gDSGswdzaHRxtXUlUlJ/D4Rp1vY1Py799efOChtNE7qECtWv3WqMhbH+fhdEAx2DGGt0brKY0pL1we+VoteuaTCIIsaysjLUF7liNUetb7BCfmTDv0xhxmp3idWDBhBgzeFFinrvGV5RHgtDNctZA4TWGXkWOyTvk59R0E3n0LzQCCZEN56eGAJkDx4LrPJynDn5ON1AqOaQozSqmPIKNCHBE8pgFMNgcRbqx1hm3but52j8JcReOSGc7Z1PabQSbGxt7MvAnSR0DuuoKXB1NqfNHo2pTFq90pH1IJim8RFsk/vBGXrM8gtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbaS5dURvQmOT5xfmAEd76xcoNSWxZOErLTldyNcUpE=;
 b=F6BA2kem7FnCTOQDjQk3Pobd9xFXqA2eaiY8I/8+yF0k/5hy6JXK5Y4MwZnkmMlDT0ddNggSnGtjDynBfIIqwc4k/6qTK4weZn3tJOdNdaMunqc2hWRq3aAYnESuQEC31G3XXc2VWY6qKExDV+NdSb2b6M7moUEUQ44EiyHAkTvn9Oi4ekOFa372RjKoCZUnaoqz4mkZhzi5sVD70C+8NKZkSBB5rDtL18AZDnWGDL3L7y+hN0zaDCh4Tjmfe38PK4IAmboCfbaJ9+69Pr+badcEW+UqVdB+TnUtDszKOo+0z11tb81HsmaMX4fCiQyAZnGCZ3d6lzBfwvLVrIr+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbaS5dURvQmOT5xfmAEd76xcoNSWxZOErLTldyNcUpE=;
 b=3KC6siarqDbNkBJ2hecxs2pdp/i8J8Vyab1fxjokOSXlvJffoo5PbOBvYUlsC8K4DBRC+RKIrc++MIjLcpMMGBPcTYL3csvJAYQp/3TIrU/QxqNhG0u9/TwK5azmOo0h0X7BLVfVviH0lX4xc2RFLOtDkeaFPu+NY6ilWKY5Pn4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR12MB2424.namprd12.prod.outlook.com (2603:10b6:4:b7::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Wed, 16 Jun 2021 13:10:26 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Wed, 16 Jun 2021
 13:10:26 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com> <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com> <YMen5wVqR31D/Q4z@zn.tnic>
 <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com> <YMnNYNBvEEAr5kqd@zn.tnic>
 <f7e70782-701c-13dd-43d2-67c92f8cf36f@amd.com> <YMnoeRcuMfAqX5Vf@zn.tnic>
 <9f012bcb-4756-600d-6fe8-b1db9b972f17@amd.com> <YMn2aiMSEVUuWW8B@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <91db9dfc-068a-3709-925b-9e249fbe8f6f@amd.com>
Date:   Wed, 16 Jun 2021 08:10:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMn2aiMSEVUuWW8B@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 16 Jun 2021 13:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7529508-0232-4002-51b7-08d930c81b66
X-MS-TrafficTypeDiagnostic: DM5PR12MB2424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24247D34A843FF29EE4802ECE50F9@DM5PR12MB2424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeqKNIDXe/7amTas+90umI0Ay0MPGFpA4Hr2XLenNkCa6A7tLwomSi3RBaBLr0gHz6eCGDJiX6vc+JDq/i0q5ipufLwc4HnLkF+7vLerPmuXjclV1wX50KklAabIc6fkouhG38yo/ELOns7jlFICRWPze9KzrSnQI7JSWUZb/oaEnXBbus8/tYprNpgGx3HkQrJiTx7f5MEpcnDLO8DH3Wi+lWk0jh9DB2ZDskzLqfBGsbOz0977tNjRNyqs2nyFYoEcFvJ4pp3mdZ+nAph84HHqxEeivkrp4XX/8bTAp1dtJZeCqxdiJaVCUgXkww2vL44Sv8ckKk2CbzgJP4m10HKNT9sePi65ErWRFS2C00Ip2fQIOSzXr/f+zp1gUNTgZ6Qx4ee5Jm5t7U5Wb8Oz2Yu1xOjomfcDtfKoFtaZ9lLv75iIfKYyZLyxTPBcO+JGZoFfFug1zNIKGu/sIvd4+zTQn7nZTSxCI24+f9dmHTAfjDkw9uf/NXHhT39eWZ1E8qfNYTTZwXzwrklavxVqfVduIbKL2O9VvuhXD6r1/vDc5yCvgAA4kwNrvOmL/fekxnLV322w7wgRniicu6LGV6uaUB6kO24HTd+scAJ9LPWLCfR5+9PYwlHA0IIue4GEsTjfd7uMiOY9BKfrk+cP87cgBZTbBFrijS+ezlT0/a3QoU7JelaEKTiceZO0l9lI8MaaVxNFktAWYtC+FivKbpjuRpGVBskDurU6EA99KmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(2906002)(7416002)(6916009)(956004)(4326008)(2616005)(36756003)(44832011)(52116002)(8676002)(38350700002)(31696002)(316002)(38100700002)(16526019)(6486002)(66946007)(83380400001)(53546011)(6506007)(6512007)(66476007)(31686004)(478600001)(8936002)(86362001)(5660300002)(54906003)(66556008)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sll5NGxMMFcrNThITWpwM0wrQmVJVkNhT094QUpickdBZUFsV3VNa1kyMnNR?=
 =?utf-8?B?YlFJb0g2YVU0bjlueUpuL1ZGVHVaK2RQZmZVSWNDR1JRSjVKZ1E2aE5Jajg0?=
 =?utf-8?B?REhxZ1J1VElsVjRoMlByU2lKY0VJekNKY21mNUozSnprVXdZbGpJUnhKOEVq?=
 =?utf-8?B?ei9OTXVTRy83V2g3Z3dYQUlNemFwU1Jna1NZZy96MEV2UWd0MjhCKzFlZlNC?=
 =?utf-8?B?c2dBZTMzWm9MY0w2R3VmdEtoRkN0SHZ5aFBjTGJxQ3NIZitxK0ZzY0Rnc3k2?=
 =?utf-8?B?MkNDZytQeE5yaXNlN1ZJOFcwK2ZpSklnL25XWnZKRFZlOWJoZWlSR0pEcndV?=
 =?utf-8?B?Yzd3TzBhOW12NjRza1NVU2hidktKS3JyMncvSkt1U25ZNDFKSEI4bmJ4TFJQ?=
 =?utf-8?B?ZUpUZFJtcXJFelUwUk5wNzN3OW9uTytpYkZYOWdjekt6RGp2TmdwdnRVNHpL?=
 =?utf-8?B?V3JNTmp5dlVqSmxvNCtpY1JJaXBmR2ZaU1NERDZhZC9YVkJxWWYxeDQ1d2tv?=
 =?utf-8?B?VFA0OUdERUdEL0dJbllRYy9aWFhHK0x2VnAwZktXWVRsdVJDNWNJbTkxTkMx?=
 =?utf-8?B?eUk3R3c3cTR3MDRiTWJLVUF6Nk5TM0xMUXQwYURKQXdaT2pyNEhnWVUwN3dL?=
 =?utf-8?B?SkRBRjJJWGZ3T0VvRmgrVW9nUGJjck1FdmNjWFh2eGVBb09jNWJkWkdPUUto?=
 =?utf-8?B?clg1ZWIzeU1LRWFCN0M4VHRRNS8vSGh2Q0VkR0xZYVZOMG9Rd3lreG9jcklS?=
 =?utf-8?B?aEVHY0dIejNhN21ScG9Td2JWUlhDc0RZUElBR29rMU9Ta0lhODBscXNoamxY?=
 =?utf-8?B?RGdJZCsrUnZDaW1jWWgrSlhrMGdtekdGN3RTaWtzdHBuaHRTRTFITUR1cEpP?=
 =?utf-8?B?TnhUUDNZTjl2RVZsdWQ4cWRnanpXeVNrUjJTZFQ3U1h1QkJwQktxdXNBUlVE?=
 =?utf-8?B?bU8za0dxSGlqV0RxQ1JqWmNhekYycEJLbDM5REdaZ0MrY2RqOXVJL3VIbjZr?=
 =?utf-8?B?YXhFRVdBQWErbXdSTW91UWVDWnZGRDUxbkxBaWtVSm1KTW9icHhBNzdSSjZm?=
 =?utf-8?B?UzROMThieU82Z1Z0Q004cEtrbFhUTmFEelNHK2k5bGlFSU4xb3JlK05ES2cr?=
 =?utf-8?B?YnBxS3pvRVNncCtUVFVUeVAxTG0xM0Q4Zk81V2R1d1RHaEd2MTdZOFcxeWdi?=
 =?utf-8?B?bDQvMWRxaVd3Z2FkUDNza1lNUEEwbXAxRW91R2c5SDdCdEs2Z0YxWGoxYXQx?=
 =?utf-8?B?MVE3dWE4TkxFKzFQUHlEZ0hmbkwvZkxiaHUzeTJJaGkxcWYxVGgyVXZjQ1d5?=
 =?utf-8?B?eE1EcmpOS3kvdW44S3hBL0NoWnBlMVlQMzJlMlpleVI2T245QUVVaEwrcURi?=
 =?utf-8?B?YXF5L1pYZDJhbC9qalpRVkx6eDVrYS9YZ2ZRN1pNR3dOaFNxbjBEMnowc0RP?=
 =?utf-8?B?QlhyYzN6VHVxUnFGNXpEcjl6ZXNOZ01uZ0NWd3Z4M2tJUE1ISEV4TG9xR0dI?=
 =?utf-8?B?VWxyVWpOYkZoMG5MWFhRajg0V1RtejhwTVBiU2xTaGhJb3diUldvYVBNd2M4?=
 =?utf-8?B?amZyQXluVVhIMjF0d01laGhySlZwUXByV1FtQkZpVVR2RmRCREl4enpieTV0?=
 =?utf-8?B?Zy9ySWNMS0xwdk1hUFIzcitaTEZKcXZRM3h3cW1KQkFCazJONGFWUUFiTXFV?=
 =?utf-8?B?MjVQeENiWkNaSFl4ZkllZW9aVUY3c25WTGRlbGpsdVk4d0tNakRURFdsUFU2?=
 =?utf-8?Q?FITc7BsQq/ti3urFXbM23iKHC7OLYSFYk4cWFWJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7529508-0232-4002-51b7-08d930c81b66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 13:10:26.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnpR4vE0k7t3NaiuN0gZKmoSW/MBGRI4vVOeHe+ePgsR8BmWe46ORXi/f4wzkC7TUMoHI1/TM+gEJJqx9r8pCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/16/21 8:02 AM, Borislav Petkov wrote:
> On Wed, Jun 16, 2021 at 07:49:25AM -0500, Brijesh Singh wrote:
>> If you still think ...
> I think you should answer my question first:
>
>> Imagine you're a guest owner and you haven't written the SNP code and
>> you don't know how it works.
>>
>> You start a guest in the public cloud and it fails because the
>> hypervisor violates the GHCB protocol and all that guest prints before
>> it dies is
>>
>> "general request termination"
>>
>> How are you - the guest owner - going to find out what exactly happened?
>>
>> Call support?
> And let me paraphrase it again: if the error condition with which the
> guest terminates is not uniquely identifiable but simply a "general
> request", how are such conditions going to be debugged?

I thought I said it somewhere in our previous conversation, I would look
at the KVM trace log, each vmgexit entry and exit are logged. The log
contains full GHCB MSR value, and in it you can see both the request and
response code and decode the failure reason.

-Brijesh

