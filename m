Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F23A9AFC
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhFPMvj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 08:51:39 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:48705
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232452AbhFPMvi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 08:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehLpXJ30SlJOlNQKX4G2uNVMUyVGoiBjDycAS8oAK+rFRsT5umTPq8nKTlmneEQsGlosNYmtpWr6aazZWvuZ7yLpGiLHcQSFr7RKaCKvtSJomSEUZ6kcXVVP0eYzOSBKT9fjGmrns88okgmO64ZIFZE8PmORn1B4d+U5TmUUC/bL3UrhLRATH6Rq/pCsi75fGwkCVfz65XVerEBWOSRHZhQQSy7Ldu8oP3vFD2AcmSUflLRy3uDmetC2Ayw3r8GHyYlT2x3N5ZeRtuGFdq8Gyp/GA9+9zaTYKgdIJWgmPW11994/kSuRamV95/iMD6uNiiIJ4rFmdtbFWZfazvZ15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1jagf0o2lhmFsumaKbXg4wyBzfYpcZgKTOP7Ec/fgw=;
 b=Av0jmDzLnxPuPmQDS4gqVjdZcrlWgh02/KVdOkSbAS4TqqpqnADTH2Jv0pyJ9I9h6NjWyUS0CDBz0aHfh6bSzqq4iGqMNiCMlQ+YoZQffr0/DH2keDMoTwAw+eHk9WuEknRnB2kCVc6/2ecM+2fd4qvnlpqT+66ttAwvFlSMZ0xjPTDPPAKfSdCXo8OUYrDyIuAOKGK0Rco7YuVBxkM0HwdvSPQCKaDMqE0OB5oGTfarU9yt/IHuQnomzl4TIweSZiFHm4ZlfRjfFQFrIDZB5wtuJ8or+r0G3taBiUmjgpMpTo+OQmM/88z+wD+2UgbmXLSY9z0Uvn117nT1BWdhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1jagf0o2lhmFsumaKbXg4wyBzfYpcZgKTOP7Ec/fgw=;
 b=SudOLky2Og9SP6xfDBmBf79uhiHTVp+tfUawLn+Ovf9PKu34LRaGyRas4GB27T0s0nWiBCKfh1OubKqf+7LW24E2iDuHeqifDfc83JMXVdiYly9cuemFPBMysGDTKUwTlbso52aUvziJTg+u/7uf4vl0eGgHJQW5Vox6hklnT1A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16; Wed, 16 Jun 2021 12:49:30 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Wed, 16 Jun 2021
 12:49:30 +0000
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
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9f012bcb-4756-600d-6fe8-b1db9b972f17@amd.com>
Date:   Wed, 16 Jun 2021 07:49:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMnoeRcuMfAqX5Vf@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA0PR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:806:d2::22) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA0PR11CA0077.namprd11.prod.outlook.com (2603:10b6:806:d2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 16 Jun 2021 12:49:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03370252-9a13-4dd5-7b20-08d930c52e7e
X-MS-TrafficTypeDiagnostic: DM6PR12MB5008:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5008646454DB8A71A1AFD612E50F9@DM6PR12MB5008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teM74UaKmg7gIEoNwTP2U5c6Gz6IyRgEEwuMX2eY/zH6C0Xc9Uv90x/DrGw5iFcXs2iE1Dq7iNtmb/aBeGc3twY/jzwizzIKmoX4p9vJvshryG60V2CeFuXWULiws+6+g/dpEK89k9gN32XE2Anny8dJA62DeI2V2B8/G8D4U/NqZFQmB4WI48W43YE2ZmKRfZyHdj/d3GR//zLNuybPGnz6WPqaiEjm026NmwrXk7AN4QP1Ra/8vY7kcTZ+yIuaemPld+xbd1RKBOl+Dyo24Fx4Y2g1tWCrj5vOMo0pX1KqW1gPWYdNEZA9CMuMBbOSoBAXvkCaQ22X7iuiWsJIPGjKvrFMaJaq8AB213m+b4uIyxyTMmVxx5ma/sfKKbiUpkWT7kK0ywz890mKjlq3cpNAn0+5OoTY0tW51zV8A5W+t5AAZUZWaZiVDHKgeSi7x8V0P2XiA+8UvEX3pGWKltO/elXnG5jgIUWUgAtUxg6uV0l9Crxd6Bve5fTfuAhoKoFEymDMLG17tTr7jc9P6P1tUYd/NVEoCLKghx8vHewDmM/s6UUu7+EeW6HstcKbjX2XffHNXvB9IqOEnFtoeweVORGzpD+Isn2zECEY7KrQQ4RT8JVAeYAGOmLCOjIimxk5VHryDuBENOezdUBehWEr6MMFH2qUVDKbaTSp3T7P4WaVWggqW4DeraS4PWQmQ31ErsQQXUGTBWZ37nZ1LNkArqC0lSnHz6AuHsaNMuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(6916009)(44832011)(2616005)(83380400001)(6512007)(5660300002)(956004)(4326008)(86362001)(26005)(54906003)(8676002)(31686004)(52116002)(66556008)(36756003)(66476007)(316002)(16526019)(6506007)(38350700002)(8936002)(7416002)(6486002)(38100700002)(66946007)(2906002)(53546011)(31696002)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHRMSS9kMHNKUlU1ZzlITGpDVHF3bU13cTNNNWQwZHBBSUxMVlRoMU8vekZT?=
 =?utf-8?B?Y28vM2NZYzVwaHJXMG4vdnVsd2lOR1lXMTEzTnF2d2VFd05ZVzd4VlFXR09S?=
 =?utf-8?B?eGl5QmExTnJWbVB6aG9ucDdDSVc3RmlYVWt4RW9XS2hDU3ZMNnEybmMwOGF6?=
 =?utf-8?B?Vi9TK3VQTnRIMzVZUmpBOFdwVEpMMHozWFp5aTRyL0ovRXZKODBJMDYvOUJy?=
 =?utf-8?B?VVZmQi9vd0hJUnVtWHFJYVJVL0Z0czJKZEVkbWkzS0Zzck9IekRka2V1cGVY?=
 =?utf-8?B?QjYvZTlBL1BnZEhJS0FQZnc0NGFrR3pabU0zbnhGWEd4QktjM1dBbHBOVzZy?=
 =?utf-8?B?RWszN29vQTRiNDNuSjRBT2s2a1VoMTg5em5aTEx6aWhRNXhxMTJWZHVVdjFB?=
 =?utf-8?B?T1o2aUJib3IrV0wzUGhoNkRVR1FwS1Z4Y2d0M1lVbXFwcEswamMzZEphQngv?=
 =?utf-8?B?RkdqNFJqV09BNUpvbnFjRm5IenFocjBmUWtTZE53T1RXQUEzOHYrSENoL3ps?=
 =?utf-8?B?R1phZ3NCSWU3amdlYnppd05xbGUycjVLVUNPSVpXdDdLS2ZFL25kRjN3eTFX?=
 =?utf-8?B?QmhHWTZ5bnFpZVBuOWw2U2dqUlJFV3U5M2s4am8zbXZKNjdzTDBWWk1qVHJ3?=
 =?utf-8?B?dUdRM0M1Ulo0b2grTERZcy9ucFZ1N3ZKUGRRQmJ0UWp2NWl2c0l4Zkd5SDN0?=
 =?utf-8?B?amVaWG40TW8rQkMzTUVSSmQ1WVFUcjBhRWtHNFAwK1k1TkRJaTM4T2J0OER6?=
 =?utf-8?B?aFdIWUNxQ2pRc2hmT2kvNW1MOW5CL3EybHVzN0FhZlVxR3B4UTFKc1FkT0Nm?=
 =?utf-8?B?OC92T1gvUVJHNUFmY0pwMEJ5bmErTDZyUXRMeEFaVDdNTlMrZU9nUjhzZEZ4?=
 =?utf-8?B?NStDR2pob0ZkdjdxaVZJYTR1N1JTS3UzbnJRcDJmUEJraWJtL2dDZU03Nita?=
 =?utf-8?B?MWFHY0RBYnhwZ3JweHNjeEphR2sxUW4rVm1SZWRqWEJBL1BlcXpmbktKSUNn?=
 =?utf-8?B?a2NrclIwWm5wTkhJQTJreXBYRS9JaFBad3V2OG1LdDRRazNzZVRCcTFwOHNk?=
 =?utf-8?B?ZzltS3JwZEpyejB4V0hOSS9UTVRFdTZOQktEVlZ6VDFOVDRJVEdTVGhSeDh6?=
 =?utf-8?B?dW5aRVhJRGJQTDFneld3enlldWEwdlBLV1BnTFBRTTY3QURkZjNid2F0SWRJ?=
 =?utf-8?B?VTNQNXJlclhWdDVUL1k5bGhJbUFkZTR5emt4dTBSMXlRQnUyZStvZlpEcEhZ?=
 =?utf-8?B?NWo3QlBqajJFeHlFSEtTMGJnem9WRkYyam5VQThTOW5hRHUzeDJPYVFQbExQ?=
 =?utf-8?B?ekI3bGxDeThxR1YyTnVlMGl1MXRlYTBmZ0g4UVduVSswREQ1QWYvemF4emVu?=
 =?utf-8?B?QXVZTjk0ZzZud2JUYkg5QndGM2dtY2cyY09EdHpTZERDMTF4QmJFUVBBaGVE?=
 =?utf-8?B?bE8rNUVJUEhlU0Q5WmJ5RWsydnBBUm5JZm53c3VZUTM1eUJZRk8wQnBtdEVt?=
 =?utf-8?B?TEo2UmlHV291TzFEYVl2QkdObmJhUk9UeGdjZHIzM1hoRFpjbEhNd2Y2QUdB?=
 =?utf-8?B?dmE4V2RsbWNxR2VSaTl6Z3ZyRk9OV1o2bnh3eEh3dG9pdVpxcEVlMTA5Zk1M?=
 =?utf-8?B?dnhVcU56dG4zYzMyVDFUeW1sd29ka1NQd2hUVEFhdTBnQnVuNG8rRkJEZ1kz?=
 =?utf-8?B?ZTlPUkpGdDdoTUZTT1RnK2kxZHYxZHZ5cWxKaGJZSGFoeVlkeFVRQWs5Rm4x?=
 =?utf-8?Q?TSXZssuBrDU078mJzByh1yMUxpRYhctOWTQgrzj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03370252-9a13-4dd5-7b20-08d930c52e7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 12:49:29.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQJTKlDW5iR53Aa6cAGbQdqVt8P2Txpg+8twv/sYq2l0hhW7B4IeFsBS45t7Y9uLHW0I/kXFSAl27fTjmhzHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/16/21 7:03 AM, Borislav Petkov wrote:
> On Wed, Jun 16, 2021 at 06:00:09AM -0500, Brijesh Singh wrote:
>> I am trying to be consistent with previous VMGEXIT implementations. If
>> the command itself failed then use the command specific error code to
>> tell hypervisor why we terminated but if the hypervisor violated the
>> GHCB specification then use the "general request termination".
> I feel like we're running in circles here: I ask about debuggability
> and telling the user what exactly failed and you're giving me some
> explanation about what the error codes mean. I can see what they mean.
>
> So let me try again:
>
> Imagine you're a guest owner and you haven't written the SNP code and
> you don't know how it works.
>
> You start a guest in the public cloud and it fails because the
> hypervisor violates the GHCB protocol and all that guest prints before
> it dies is
>
> "general request termination"


The GHCB specification does not define a unique error code for every
possible condition. Now that we have reserved reason set 1 for the
Linux-specific error code, we could add a new error code to cover the
cases for the protocol violation. I was highlighting that we should not
overload the meaning of GHCB_TERM_PSC. In my mind, the GHCB_TERM_PSC
error code is used when the guest sees that the hypervisor failed to
change the state . The failure maybe because the guest provided a bogus
GPA or invalid operation code, or RMPUPDATE failure or HV does not
support SNP feature etc etc. But in this case, the failure was due to
the protocol error, and IMO we should not use the GHCB_TERM_PSC.
Additionally, we should also update CPUID and other VMGEXITs to use the
new error code instead of "general request termination" so that its
consistent.


If you still think that GHCB_TERM_PSC is valid here, then I am okay with it.

-Brijesh


