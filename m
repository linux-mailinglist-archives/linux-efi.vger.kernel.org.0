Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD65450921
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 17:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhKOQF4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 11:05:56 -0500
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:24515
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236543AbhKOQF2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Nov 2021 11:05:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNVHWST20WtOppQ8CLyEH6WoVFCfXLy5D/jVWYJS5P4Lb3Prn48Rel4fT9RICgYLYVnlJy7YDKFt0YvNnkDrn+PQdLS09ob3MW6nKRo9gnE3AucUP1/v9d9imGljbkRWkHg5SiiKVzZe6Sx9jdOWM1NBlUBZD6BVzxHb/ggQ8mF8MOjp7moSuB8I0ugm6gfplXYqX5GoS5DBo3iBNvYpiWBHuR1wTMeZ/E/E1tOaUzTqXPMKrF+x38X8fRfpaeFpAsw7v/mS+kW/hGU4cWCzqUR8vTrOk9c7Z4jfw2BvozOg85BW7DI0qklbZ/zBNPSKImEoLA4SU/CDDdt3BjMr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQHSP8R0GdFKlXumkwnEighBpdu9nPdnwjcEFa5Oxls=;
 b=fXrjXltdaMdzobBL2aYYnBKWJd6Vtc7ntWcIUvHehFmh8y3cTUKkNKYcWdo0fBnPkGnCko4UoubXWstZi3gWRAfOv80+D3pC0/b6O9ooXH3ux9zf4KtCbbnIgOOsywRr788QNOn8xuLLRkv1Cu624f2drMN6rz59fQY3jAyQgAoWjhgVql3vc0Q/bdc6DpvNAMwH5SL+r+fpeAkcyGdlRWGjq+Mir5di5flH2Un4N+9wJbMY1uWfKHqIYeRl77Lq7HeyBQYG4NP4YSasftJCdEyrn0BxtDFosmnD2ocSg9aBwPQy8QWJOJbOoOXqsG5qP3S+HUEiwPgLRjsONW1+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQHSP8R0GdFKlXumkwnEighBpdu9nPdnwjcEFa5Oxls=;
 b=RLEc1vuSi4a09WgqOxK5Vgq5j0fWaa0Whde20vRui1ORFJBpgc1G2HJn7ak6YPTNCFteisUQY86ewHFWUX1GsKw8uMtXFH/uMENDg0c6kx1OwfBwVyWZeTmJ6hSpvMkAztdpd3zDUkKPoSYvP3MTWNqZ6r/F10iCPVIQLPJ/Ko8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 16:02:31 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 16:02:31 +0000
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest
 Support
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <YZKDGKOgHKNWq8s2@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a631d02a-c99e-a0d6-444a-3574609c7a25@amd.com>
Date:   Mon, 15 Nov 2021 10:02:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YZKDGKOgHKNWq8s2@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:208:2be::16) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL1PR13CA0191.namprd13.prod.outlook.com (2603:10b6:208:2be::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Mon, 15 Nov 2021 16:02:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9972ad4-436f-4c52-5e74-08d9a8515419
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687ECE155DD94EAD8E9C84EE5989@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkS+fzQFOebxVrkaDw4IFd57olhZFwct24PJzKLPtLy/gVHp3Ym46pujsz+Y2SthNEsnukR7FQphykryJAqXH397YMvE5m/RCTwqfFAbqoC7sE6X+0A6+IPWNHQqyIaVPyTfPw2Fzmd+Qo7ScQgmrLNrDcpzlLKM0P+v5Bd0DRXQ0d3RHIFGZXEYw46Ao+holt7Yv6eQyf3/LI9W+SP049PCvXGBP+mooT33uD01SQ2jLuWGxv0q7MuK718+1a9WliXkjEzPZ2CYox0Y1mSTzczIWrd0QctfcxgxoJzdclkNxKogcNSkiPjOfTeXSNwhRV8Fb5EY9x65AGkvvpBON41LuBVF/Dj2bA6e1q8TdIYvOudv1qP/OsVetbJHXttIeqiSiLeF5m+8RkHQNbfhu+jVeVezltaLltxejHBiIhJ48j1uUtMtEK3tmKQ4eZHMExHni+aPd9yN3FDiFJ2cVmJkPSkmtFXi4m8OeLCrNShEJAbi7MOM+AvNC6ZOVIeoW0wyUzDSHZGlTpRClx4XSmKSuuUUTAAm6KhXuzC3EO7i6enfRgIWL2i22K4zGgqZhXiN7mJ76xODopRr3rzeB8+ycCqtff5Ql19by/pwHf8Zk3O7UAvmSw2MG2ZqwNd28hzpzigTXIYfek9LVnCmP/dvIkuCEfgqimJCZWitQ7j3dA2+/NW2YD6R0WK+6XAsSexhs11yTIReCLyB8p4SgQ7vttxqFDWB+yWkIRArPnyY4YmayxlM7t1yfGxR4CN3RcPW1gOEW5bWa89FbL4goKpDFXDahPADnDglsmSyooLZJI8YkDKammV1OQi7Nvus+ZNx6Ze+bEph8MjDr6OhvPXinYhc7s7q0rCp1WLRpOB0D3ghd71JyoSXtuXnzj9d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(5660300002)(45080400002)(2616005)(66556008)(316002)(6486002)(38100700002)(508600001)(66946007)(956004)(66476007)(8676002)(8936002)(6666004)(966005)(31686004)(44832011)(86362001)(16576012)(54906003)(4744005)(7406005)(7416002)(26005)(31696002)(4326008)(36756003)(83380400001)(53546011)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzQvc284S2NSOUVZWHUvQms1K3JRaUtQS2g2L1JNWHNUUWxFaE50M041QkdJ?=
 =?utf-8?B?Q3czMkJNdURiaTBUb09HSnZ0ditZNFlMekxLdzVkZHd2U2FRUTU4c1ZYbElx?=
 =?utf-8?B?UnQvelluNkNudW9tYTdXUURZVzlyUjZsNXdpMUJBaW5iRURwdEw4ak5ObEdi?=
 =?utf-8?B?aTluZDllNkF5WklBVEU3ZUR2UjU3NTBlM2JnUklTRWsyMGpHTjZ4U09iNlUz?=
 =?utf-8?B?emg0RkhCUHhZcWtXNjVGalZFYmZjYmxPaklxUG1TVkxLRzVaRVNQSVg4R2xu?=
 =?utf-8?B?K0FPZmlGSHlaZ0xUTjBUL1h5dnZscHNaYkEyK1lzNUszTGU3ZTA2SE0yak1v?=
 =?utf-8?B?NnJLMktKUXpNRlNhTEZ2WnlkSXo2Z2Z1dXIvRHdla3Z3bEtKa1ozay9iNHNr?=
 =?utf-8?B?WThjbS8raTFxTkRiTDlxY0tlTWRPaERLdnNaV2NVSkJmWC9GbGk5RW1yakxo?=
 =?utf-8?B?NlNOSU5BMXRhbWVlcGNKOW8wZWV3TWpyK1Y4Q0tuUlBGNmw3SkZ0TjBNZ3VR?=
 =?utf-8?B?elVpYXd2QTcyRWdqcExZTlZXS3pwRWIySnFIcVVOVVZFZmRRd2gvS1lxaDIx?=
 =?utf-8?B?T05JNjFlRW5WMmYzSGgxSGZjemFzc3ZLTXBxU2RHdlgxU3FmK2puWUxpSFNL?=
 =?utf-8?B?UG9aWTg1L3l6bFNqQ2tSMzVBT0I1M2thS0p6bVNMTXRndWdYdXpQZzJ6UkVj?=
 =?utf-8?B?eVF6RmZ3dWxrR3lGVXBubXRXUzRNTUpCVGI1MGpjZHpSZXhWM1J3alU3UVNr?=
 =?utf-8?B?THg3NTJUUzg4OUdLWk5QUnZMVGw4aEVEWGU0ZWxJeWJ4cStaZnF1L2ROcGxh?=
 =?utf-8?B?TGV6Wm82bVc2V2pOb0ZkWHRMUGhUazlGMnNFV3A4UmhTa1FNVzJJbC9BK2Fo?=
 =?utf-8?B?NHBHOHMyUXpjdG9GalB3WFNpNUd3dk5rWUtmM1F1ZDA4L25yWHk0S0dwVFBx?=
 =?utf-8?B?eEN3VlVhQTAwVFNkRGM3RDRGR0xKQ3NUTDRVUUFvVGRJWlFib1pyaEpjMndL?=
 =?utf-8?B?bUJEejF2akxGRXQ4TFdiRUdibVZFWWQyZXA4V29lREUrUkI1L3hDaWkrYVpq?=
 =?utf-8?B?UzRXcDJoMUxQdVFSYXRtVWxKQmxJN1RXdDdpVTNZWHpTS1pzNDhSRnhja2Q2?=
 =?utf-8?B?cGFsU1J0NXMzZEtSUjZXdDlZZTRweVFJMEtBNkw0eG11eTFjUGxNYUJ0OWZW?=
 =?utf-8?B?SUlMbTBpRVpIUTVMMW5DK2g2Z01mMHNML3BxdTM4VFlGbnpLZGZhcjMwR2Fl?=
 =?utf-8?B?STVXV1pDdnJSNDl1OHVYUlQ0Qmt3OUJlUXJQTkV3Y09vcTkwMUYrL0xRM2Rn?=
 =?utf-8?B?Yko0Wi8vYUNNZ080QzV4SDRwbmZFZnQ4MnY3c0Q4OGdsVXlCR2JTQkZUclJJ?=
 =?utf-8?B?dXNEUnMxbjh0bC9aeVYrWFlxQVlhVnZ1c3BjR2Iyc0toUUtzdEFjT042ME8v?=
 =?utf-8?B?cnJqS2pRTkMzTUNlWDJQY0VPVGtiYVJVbDZiaEhIcUx2WkhXdkpXUWxuS0Ur?=
 =?utf-8?B?NUlaRDRraWhpRUtoOXNoRm1lMGZ5SGZSNVRhc3J1YTlOaHVNdkV5NTlNaGhr?=
 =?utf-8?B?Q0Y0dEpVVndZK1ZaRGZ2RmI1UWZMamZyK2ZrNHMySjdBOWVDZ1NTMzVSK2VK?=
 =?utf-8?B?K1ZDRzE2RERsZVZWOXhudDM1dTNxMFZGREY4OE5MWFl6R1BIWmxzRDNPNnpp?=
 =?utf-8?B?djI2NHM2a1FnZkNLbHVVd3ZDbXRRZjdKUG5mZUgxQURSNy9JbkZGaDYrM3ZV?=
 =?utf-8?B?dkV3WkViVldUMzRpZHFmcjRKSW8zZWx2VEJGaUhhMFc5YVVLM0FzT2xNLzFT?=
 =?utf-8?B?ZnJTYjFBZnRIT1B1R2lXWU9VdHVjdzlQT2xiK1dEdS9TOThRWUNRVEdEZ1hO?=
 =?utf-8?B?KzlmNkloTStSbmtUdFdNeDkrU2NHNHdqdjUvK2o0cG1IVExYN00xTmpaTy8z?=
 =?utf-8?B?N0RiMHJBZUpHQkVuSUhQZGhGcjZWb3FHUkZZTGlMbE1lZVk0MjRhampacXB1?=
 =?utf-8?B?bThvbmZUZmFZWlUvdTJjM3lHc0tkeTRKN2hjcGRRS0VyM3hLQjBZM1AwM3RH?=
 =?utf-8?B?YldIUUlWZDVDNmgwQkVHNGFMYmU2ZXdYZGQzOE5RWmZSSE56U0o5Z0RlMmR4?=
 =?utf-8?B?eHhPRE5JWWlibFppN1ppbk9mZXlpejdFeFNDMSttS1hRR3hWK3FFWHFiWDg4?=
 =?utf-8?Q?Xh0+avNnlCTLWpUr0e7c8rE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9972ad4-436f-4c52-5e74-08d9a8515419
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:02:30.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XX1tn/txfvA8W996+4G0YNMb8V+23/JaznT+8wVLnut6ZKtqVDTYJQ21c4QUR68dREtbpkeYtsBOHPO2ODTo9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/15/21 9:56 AM, Venu Busireddy wrote:
...

>> The series is based on tip/master
>>    ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'
> 
> I am looking at
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7Cb83627413bf24921b15e08d9a8508a4a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725887206373140%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=pZvyYsg1crWmsLTpGO4amfYxgUnI9TUy414burkbcdY%3D&amp;reserved=0,
> and I cannot find the commit ea79c24a30aa there. Am I looking at the
> wrong tree?
> 

Yes.

You should use the tip [1] tree .

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/

thanks
