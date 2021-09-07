Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241534029C8
	for <lists+linux-efi@lfdr.de>; Tue,  7 Sep 2021 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbhIGNgY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Sep 2021 09:36:24 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:51105
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234489AbhIGNgY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Sep 2021 09:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw8M303kuHk/KU2Rbo2sZYXbBlf4ITFV5h8ymmN6z53V94c1jo9VryxNJKE2afxTKDakfJbzH6cdFGpqdvw/N7yYBTpw0mHvVhlmqYq5fKb3bOyrVDCrtv4G5fqkMaXVBPe+0OpRq237+Otg3BReIItTUvfdzeay0UBhQ7U/kWDliVXoa/YxcjaBSlOF3Os1s+qWx4ENmRkttx4XlBEKMB7i27ckJVqLT7Kvyh642YSFXpAQbqY9ZlTxzTBMT+nDw4Fu1t9WJo+01nOpBnYv6VITCuaqH6MSDDy1/isoZYGLmil9M7uN2tJIKRlXck4w19KvOmdOTz9jpEFnb+qxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O9tMxmG5CV8CDnk6qhKVe397KJrFl96yY+YUW4LTQZA=;
 b=c6bEWdk5ofyb7QNA/H6CZphX0dqZAUU9tot1n5g3KnWHfjwjMETFInSp/Rs4abksiKo8XsYZti9gfeS4IGXC5/bvqKFXNUj0nDojz0K4OV+DeAncmc3eEwLb2Fr4a0P22dmUQ6xu1r8TdgzIoJigkC1nmm28TEeKh9kfvmVgbsOMsdxsDdxerajvnSLRs1+Or+0S+yvostkuQHSKxy395aQf9XX10wCmRM+d+pDHwQN3l9wr1e6r8tXKrTfzzu/YVD9Ng45DHZCZHBmrUIFUA6Dmomc9rTz1NoAEqJktuDpZauzflvlsFM0ejEgKB9iDFFZyvCZAROVw1kFbRyKL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9tMxmG5CV8CDnk6qhKVe397KJrFl96yY+YUW4LTQZA=;
 b=tqlGI6Eqnkp0XXr1ywyun6+ztF2iivSrAVEezx0X9tlopIqXm3M0wVHsRwG/eqbFzgIRkxcfZPLOC8VbXAkhJn7u2RMPcV1wnIq9gYaus6g2K6RBxWE/2XDOtDSF1F7vhsTcTnPJNeAKn0dJm3OkZFWxF/Qp5Bssg889HY78RTc=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 13:35:15 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 13:35:15 +0000
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
Subject: Re: [PATCH Part1 v5 36/38] virt: Add SEV-SNP guest driver
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-37-brijesh.singh@amd.com> <YTZSAB5H9EC2uk8z@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <bb72ce36-19d3-e2df-fa51-3940e4e9118e@amd.com>
Date:   Tue, 7 Sep 2021 08:35:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YTZSAB5H9EC2uk8z@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21)
 To SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.31.95] (165.204.77.1) by SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25 via Frontend Transport; Tue, 7 Sep 2021 13:35:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ac7b708-e2f3-4181-935b-08d97204535c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27173020AC2BF425626EF4D6E5D39@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYA/5IJLFExkPSqT1IfnInye0TAVC25gY8PPNtYuWNL1mM/akeUnErq5KXN39DrCGPYm4EpozGoHWoHmNcmrOFTWJK4S2GYPUcuPyHdqA2ynfwWfHmVBmD3sIWhhBuoEhQ2FROdE5bP4ajIHCYhZZr4BjopcBxEf+QgX+fKJ/E+RKkyFTbMmJPFCE/BSbpexKDYfxwLn99zqfjcpzvELQCW4xEeIW7qCo10Sp4mZq9nz9dq8xu3ql8UsbB++dfCc5VzQwQLXemisIvvwXlAzrl9XcBUGdK/tx+thBTwlfbUmNB+IQg1x0mr2lGqWqhAsc7DIJVRp/Q+/QCpQ87Aip92RyjDE8s/AlWlvarBS+w+nkkzfrT5y5Q7JTil5zk9KS3k/G8kcsvT9CgW3cRp/AUxUQZKplwEwj/y5m8YGU4vgz4HXtsohL5PRzTe0gN4dlyk0vvWwuzmiYUShd5HH3GvjjCutCtprnNAndo6maVuqA0gI3a/EdCLX35wksiIXWOjkczXm8kN9cdRNlg32tYFiOtWkcWsNhY4jfEP7SK4Ykwqf1kD4AeEhj2/hNT6ut/SGHmv82uKwNdjNU0Cpa9xrGP4Nkcn41Dgl1NgerXdczt0I8jCKFJy83bkCNCHjNtXN+G46ByTWIQGNqaYYCYY8+vx7GEfcSrAsHgc/L4oq0lX/HGXFu+fb5aXiqceKz5AUKT0MTlVv+H5sjM7SAEzlDEi7ERBGtB9iHP26ReRZgJZuAftynGrwKz8JJEV18ZLezo9m9N5Tm9KcE7eY/fKeYZ6zkotG1puTx6t5ZjRLdiuhU/csb+hy3jU+JH1s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(956004)(2616005)(966005)(36756003)(44832011)(83380400001)(54906003)(16576012)(6916009)(186003)(38350700002)(31686004)(316002)(7406005)(8936002)(86362001)(7416002)(38100700002)(26005)(6486002)(2906002)(66946007)(66556008)(8676002)(66476007)(31696002)(478600001)(53546011)(52116002)(5660300002)(45080400002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW94RCtBUkxXMlNLK05pNHR4NVN5L0o0RE1QS2U0VDhyWGY2VWdycTkrK0Iy?=
 =?utf-8?B?MEFhUTdCU3VFVHZESUd5cStocWRzZDdBZnZsSWkyQnNGUm5KanFsRU5sUzFG?=
 =?utf-8?B?QlRjSktxM0k2WlRZRWtxd3ZqWGhqVHpraGxKaGZSbDQ4WW1XRnMxelR0OTJz?=
 =?utf-8?B?WmhUSmtTVWZ6OU1IQThuYWJJcHM2bHliRU5vS2h0Z203OXZkeFdWSUJzZDV6?=
 =?utf-8?B?bEgzVUxCRHo1T1RkcFhnMWpNUEVQU2RHdUJyZnV5NFhBOHgvU0lrZWFGOWN6?=
 =?utf-8?B?cXJmVTA3Nm1SMzY3NzU1Tk9BNmM0UjZrem9NYzBRN2JuU3dTRFBpODd4OXV4?=
 =?utf-8?B?Zmt4ckdkN3RuaXdYWXlBSG4yOUgwTVNPVnpHZHN1VFIvOEFRd3U3cjdpZ2Qv?=
 =?utf-8?B?Zjl1bUJNL2FNTXpFV3YvNVp2Y3YvSEd1aE94dUxtNWp4ajY3eDRpZVp3eG9q?=
 =?utf-8?B?dVJBOGpCbHlxUERzc1E3anpHakZWNGFDb0lLWGZuZzVONU1mZjFJNjhpSnNK?=
 =?utf-8?B?K0lsUVJjell4NVp3YzZrdC9FK1JXQkNZeDdLYUpJT1BDcEV2THFzQ1B2djRJ?=
 =?utf-8?B?VlhQdlc3dWF1OG5qUjVkQ05DSEZFMkZCZ2hxZjFXTVlFaHZzUExMejNXUm9h?=
 =?utf-8?B?aDRTZmZIRXQvNkU2VU5ObXM5TS9sbGk5bXkzY3EzRGFYSmFySGllbnJQMUFj?=
 =?utf-8?B?MWhxb2c5czNlVlVPaDBtUEFNV2g1QWlzVys3OE5vRXZkejFsS3MzM2RSbjFW?=
 =?utf-8?B?SkZaK2hrOVZqdUZQVWR5UkdEUUlldDdJK1NhWlpxaWoycENRR0ZSQ2RIWnlV?=
 =?utf-8?B?V2EzZHNSTVRnakkrb1dGbUNXRXE1c2xxblBId2dnUUJCOXhHRVNLT3Z1WGFU?=
 =?utf-8?B?Q0Z5Nm9GQzZsWFE2SkQwajZLeFBSbzhoVWtjcVd3Z0ZZTEhTZFgxQnJjcjFJ?=
 =?utf-8?B?bmM5c0RoOHJzWitSVDNRSkhWQXM4MFVlSk9XR1lHaG5yQkNLeVltcFhvOVRz?=
 =?utf-8?B?aDJGVHFjMnE0YlBqbS93NEU5eHdJbWdwTnA5aDlYQkRaZUdoekNjMnNNUzMw?=
 =?utf-8?B?Y2NuUVhoZTVKS3lCcmh0NGhJKzNLTlRaYkxXa3Q3Z0pVYXYwcFVSb1NOL2x0?=
 =?utf-8?B?ZTEvdVluek1tTnRWaGtTVyt0Nzd4VUh3WHhIUStPazgxWDVub3FOeGZ0TEhh?=
 =?utf-8?B?clI2QnJsMHZNM245bEhyRThZQW15bk93Z0lvSkdZQURsS0FOYSsrY0N3M1Rz?=
 =?utf-8?B?WCtBcDRjbENZV1pEU1JYMldCNTRTRFc0SE5uenQ3WHlteG5uZXIvQS92bmdK?=
 =?utf-8?B?Q3FaekhNYkRQazcrQUQ4aWJDMHZQVHdCTnY1YVAvOEJUL1lmVmtCRzZENHR4?=
 =?utf-8?B?RmxUY1l1eUtKNVg3VzQ3aGV2K3daTzRTNis1T3dDTkx1ek9GektjSUZiLzlj?=
 =?utf-8?B?NEN3ZTc1L01QbXBkSUZXVU1KUm5RVkExeWZNaXFtOS9TRVpRckZnU0p6aC9C?=
 =?utf-8?B?ZjJCZHB2NXRvS3Z3RGNvUkdkYWhmVW80ZW5JV1pPSTF1K1I2Z0J1aFZJUDg5?=
 =?utf-8?B?UUpsMGV5ZW5tY2VUSUpZRkpSOG01UDVpd2tCT3o3aFJzUjNUakhWSitzVXJo?=
 =?utf-8?B?Y0NrSy9yMWEvRkF2TFMyRjBlei9mMGlhYnp0SFRsektsZmFQNGNYNnY1SUJp?=
 =?utf-8?B?a1RHNSt3aEMxQlMvOTc3TDE5M3loeHgxN05YajdjYTZzVTlTeTM5Z0lUV3J0?=
 =?utf-8?Q?SjdnlJYAN9gq85MKkSJahr9IWIP6pki1BNMigBo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac7b708-e2f3-4181-935b-08d97204535c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 13:35:15.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uy4tuWi10V/6MV7kboEPJHs10sr6E+HPuvHd9YKBlkpFs/3WdxNNlogepfnNc8U7UNnJSqpabY4X5BmIGq6oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,

I will update doc and commit per your feedback.

On 9/6/21 12:38 PM, Borislav Petkov wrote:
> 
> So you said earlier:
> 
>> I followed the naming convension you recommended during the initial SEV driver
>> developement. IIRC, the main reason for us having to add "user" in it because
>> we wanted to distinguious that this structure is not exactly same as the what
>> is defined in the SEV-SNP firmware spec.
> 
> but looking at the current variant in the code, the structure in the SNP spec is
> 
> Table 91. Layout of the CMDBUF_SNP_GUEST_REQUEST Structure
> 
> which corresponds to struct snp_guest_request_data so you can call this one:
> 
> 	struct snp_guest_request_ioctl
> 
> and then it is perfectly clear what is what.

Noted.

> 
> 
> "... which can be found at https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdeveloper.amd.com%2Fsev%2F&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C9bc8f642dbad48a2a78008d9715d1edd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637665467074351191%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Iiz3emjR%2Blx8H73g2N0bOfPHeXXv%2FhLtlljOWNoD2mQ%3D&amp;reserved=0."
> 
> assuming that URL will keep its validity in the foreseeable future.

Unfortunately, the doc folks are replacing the current spec with the 
new, and previous URLs are no longer valid. I will spell out the spec 
version number so that anyone downloading the spec from bugzilla will 
able to locate it.


thanks
Brijesh
