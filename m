Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BC848C80F
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 17:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbiALQRy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 11:17:54 -0500
Received: from mail-sn1anam02on2048.outbound.protection.outlook.com ([40.107.96.48]:19810
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241078AbiALQRx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jan 2022 11:17:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eerY7YrK0ukeYqUtrMFWeD7MeFo7JAA+UCwZk9mP8frlM3fkR2mvw31z7dVmYLLzPPajQO6O5H/1Wkp6NDMKbD/UxpnClknxY7C38zIXqKNe5d7Qivi/rkHVU9Nj4N1iHkX5YkoghJ5NQ8hwZVZiRWJbV3zSX6qU73khi12CS2I+K8Wr4fAe1dyPfnEmIGTtW9onmEwCtM2YFVRin+O+NWSKIEpaoyNIVHGnBrc8SUNoKEF7iM/Z4b+tnOeBuEePlO/2DNN6LxI4QMKkncEgqR/ka5EH716jAh8Vpar3yPV/FkcyM//9z0QIIVR7E16hAu0UjpeNGNem414SbWN9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1VlgUIj7fBflhD7Es9AmekTIi2jxaFjiI9oSjfRu2Q=;
 b=R8U0LySQF0033YCP0dFZW05aqU5GGqzpzA9EAktjLDUd5wXL+d32SZFYO4pnuoxbh6TrSCU7yKxyPl0NcBLA7d8zH/0SMh5lJ/zcY5flQfTrheK35YvrJOsy4GHmRwWdEueNsPWLeazBYYJ94lVqQ5+XNoPqlzff/QqoYwvE2uuaIkWQ75ny3mzDlJ+IiT9jYJhkx9q31jjQfDAFQcneXXIlsZqMNniZpHe4/6m4o/sYCg4uh308gg+/XZ8ffbDvhBR1m6dLAd10kGASb7qON5/UZPQfxG2xvqPthrauds6EQTO7sW4rR2wzeMIXd7CjLUw2ugb3nZ3CloVZ+WEGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1VlgUIj7fBflhD7Es9AmekTIi2jxaFjiI9oSjfRu2Q=;
 b=EyIEciyOJw0MTMB40viKQeB0J5GIwQEK5KfJyn9kpbu0O03hjIXdxu0ArnK2hNApsdbAP7n/Rz2IYk5mxX3l6fI5QH8bz0Wj87Fr05SRhjVUZgp5nE6xWNQIbWdX35FgISE4NAWULHcw1B+38nLkEYJ+Jz+SuvTgi4iSr7DclhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by MWHPR12MB1598.namprd12.prod.outlook.com (2603:10b6:301:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 16:17:51 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4888.011; Wed, 12 Jan 2022
 16:17:51 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v8 20/40] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-21-brijesh.singh@amd.com>
 <176b6163-fb2a-0339-e23f-2090ea78b4ed@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <37fa05db-a528-09de-0c64-4c8b35f94f68@amd.com>
Date:   Wed, 12 Jan 2022 10:17:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <176b6163-fb2a-0339-e23f-2090ea78b4ed@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:610:51::21) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 203effd1-0f74-4c0c-7be3-08d9d5e7146c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1598:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15989D55F253625B179A54BCE5529@MWHPR12MB1598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yll7RCdEzIEVFKgh3ocFKNv1cR2Ww9JJ0Q4oMo1ft+rJLcUh3Yjn1aJTu+7PtF9zA6QYDnfGA/VW0WNYOqwfgap2GzATkoW4nxV/0Sk9Qojq+nLS9kDfJSWoAF1QzyEDwF7Z8A3H4NI5ITBt3KEQjwNEll4u4MrEowu2FcQWBtMsTEqsd0W+2CGYrZiN5r/oAroeRtOe2XPDiSVSTPIyy+EN9sdJXDyeFwtTBSl4G0YYI0aILO2B/+XWvtZ77W5tbNQB3e5kziLzFaUwqGNRDnenebweklcn5dPO2eOhpMOKD2cSYU3+grwHy3sGpbjjpfk7PN14vevxbBzrYEvWI/047Qtp73xK1Rs0fTtdrnNj0Zq87XIKqQmI0Y77u5AVVqdo/QjjybQrDYD5gg3HHTiupI8kxb27kDNARPwc+4gyCKJjyq2cRYubyo0HvTN8PyI3Upa2QxOzRtsYIpM3XPp6DGq6Ed/tuSLiox2saEMG+Qg29YlaF40nKR/+Irc3VOEUkzM8csuI6I40+inanhunU7eT5B19G2mWZ//tE0BpOvANgbrvUPPcIYlsO7JpDyCZ/As9n+ugthzUZDhycK2i11bL1RE/4BedaSQ9+NuZ//m3u2XApb4g2Ki7yc4oEsmJKxCnrYL8wChDUPOuQz1hzKzDcxMSYYqKB83oUPXKcUuHSbKAoW6SwT30h7kJvsRhImy/iLYOnzqI6LBps3GKymCK4a22ReVgtNoUEMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(8676002)(44832011)(2616005)(7406005)(7416002)(54906003)(6512007)(31686004)(4744005)(186003)(86362001)(4326008)(6486002)(26005)(316002)(66556008)(66946007)(2906002)(8936002)(53546011)(6666004)(66476007)(36756003)(5660300002)(508600001)(6506007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bSsvRGdxanVYOUN3R3RSdkxGZGdEYWN6ZncvcC95cEthVnIrS0lMMjdKcG5w?=
 =?utf-8?B?b3JIRVNqNVpJdXpuY3UwaFhPMi9Ta3RqNDk3UEV4a1pTUzgzNDN6S0VJUENO?=
 =?utf-8?B?TzM1QmRHU2paUHFRcXVmdDc4bDFvRjRhMlI4SmZwT096WVRqUTV0US9tR21M?=
 =?utf-8?B?Z2hzSHFXbWgxYVBLb1JKU0M4U2lsbEFPWVJyRTk1UFZRc0czd1Ixdm5lUHdV?=
 =?utf-8?B?NytiRkhVRC9rUjArMm40L0gyTk9sUEFLVDBmV2NqQUJXM2FVZTB1SUJYR28y?=
 =?utf-8?B?bHdnL3VEMnVaelpJNklVMENPalRMaEl5dEJQcmIzZUh1SXpSSGk3YWhxSFJw?=
 =?utf-8?B?SWNhY2g5VFVEVGh4Z2ZaSitLelNRZzB4dWVzZXVQdXpTVFpDdW0zN0FsejlI?=
 =?utf-8?B?UFVXd3NaMXNmcXNBT09SQzlSL3NmeGo4TFpEUmFuRnNGRFh0c2RENTYrSWtK?=
 =?utf-8?B?RHVQZTh5TmU5WncyY29UM1hvTFljbXFLc1R0K3FaZGFxZFYySWlNS1hLa25w?=
 =?utf-8?B?Zjhranc2ZExwelZITHIyNThzbGRsUUFLazFMUWFYOC8vVW9TSVYxVVlFVElD?=
 =?utf-8?B?VFY4cVNHcVlzcHduQWVnQ214Ti9kMDlubWdzQ09xa0piSS8xVkloc2QzSldx?=
 =?utf-8?B?NDV6WFdVdTM1V2w3UTRJQnN2RTFzTm54VTVkSDIrTnV3bHo3SjRzWC92VHNY?=
 =?utf-8?B?YkRTSTdTaGlmVWt5aVZHbUxvampmOGRFRjgvWU5UN21Mc2JWRXVNcTZIaHdq?=
 =?utf-8?B?ZWJSRGxnbDFQT0ZKYkN2NHRVeEJUUTdvNzhlRkZmcDFuZmlISXkyZFJkRk9x?=
 =?utf-8?B?Y0NwM094UlNuOGt0SUs0MXo2Qm9xdFdPNG5WY2t6cC8xUjRCL2UraFQrbjJt?=
 =?utf-8?B?c2hWc3RBbjV1OEdhSEVXd1FhbXh4TXRIRElPbUxva0pCREU3SmZURXk0d1hr?=
 =?utf-8?B?ZEZ0ZUkwNkV1aFpDTGJSMlhoT01hSEUxdVdTMFV2UGtJNkppZGJVTStnbFhU?=
 =?utf-8?B?TXlhQmw3M0tyb0hNTHVSSnYzVkZ0K3V4TUJpREhQUk1UampsOWtkQmZXMkNC?=
 =?utf-8?B?a1k0SVFvRkVBQXpXSDV3WXZ2S0RJUVBGUTJ6aVUrelpNRmw2eU43QmdYZFY3?=
 =?utf-8?B?cThyaUJGNUZPNGI2ZHUwMUVyb3FCdjZIb3k5TWJ6K2JURER0YStkeTlVbzJ0?=
 =?utf-8?B?cXZqdDBLblE5VzlXZkdvVUdXa3Y3WkY3aktOS0ovMFBrN2RhS0ljUGttSGdo?=
 =?utf-8?B?blRNVGMwM3VIbU54cFNIaFFiamRqUXlaZFppSHhmUEN4MlhyeU9CdStmalJT?=
 =?utf-8?B?WEdRa2hnbFZ6Q0lCZmw3RElMM3pLcGtoa1Mwb0RHdVdXem1OdWhzaEdudG5H?=
 =?utf-8?B?QUlBRnZ5ZnNrT2kvZm1FQzM5RE1XT0lJbmMxUXhIcHRaTmRrd1FwT3U1Tncy?=
 =?utf-8?B?NlNIU1NMRnljeDVJNXNqQnZUSDlIb3F5T1BsbVpyaU5lMTE1N3l0YU5vcmo2?=
 =?utf-8?B?TnRCYUs3b0o1YjEyWkRHUWhkTnlxeXoraGdHZHZyeGthYVBnK2NEKy9sYkha?=
 =?utf-8?B?aWQ2bm1rTmsreVMyWVRDRGpCTlhNRDdyN3paWUhZMWhXWCtmeTNmZjdJeUtk?=
 =?utf-8?B?UnJxWVJLenhRT3ROYnRvOE5yekxhL2I5Wk5ORUxZcUlwT0xramtMUU83eFMw?=
 =?utf-8?B?WTJTd1hvdTVyMjl3ZU8rK2FKbmlEa1lIK012R0RQWjJsL0dZdlBVaFRXR3Ny?=
 =?utf-8?B?UXlFR1dyRE1MN09ZRlBJc2dCSlpQYjQxTmRVVTlQbjhOVXpsRXlPWTY1U211?=
 =?utf-8?B?Q0FmWHYzNjdQdS9UamFaTGdJcU91MFN2czdhSHhqZE1NUUlFS1VGS25Wc3ox?=
 =?utf-8?B?VWliNnhuQ0l1ZjQ4cDhBekpZQzZPcUUwWDFWVWVEZmh1NkV3YlorN0cwaTk5?=
 =?utf-8?B?Z2ZlaGo3b0RiR1dia1JTd29qSDlrWkxrbHV3dzB6cDEzWTVVaW5VQWF4TGM3?=
 =?utf-8?B?ZlM2MStUcnYra08vZ0hhOFN4SktrbVBhS3FzaHB4TUhhN0ViZ1BUdFlLOEc3?=
 =?utf-8?B?SURxYTNHajRzR2VKSkQ0eDE4bFV1RUgrdEk4R1JIS2t0TFd4T2JDL1NuUnFv?=
 =?utf-8?B?OXN5UGpvVmNLdXlJZUt5TXAzNjl3VWN5azgvQ0VVN2NZRUZRbXNGL2NvUEJB?=
 =?utf-8?Q?DYf6gusIDkiWUlmoP/l/f5g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203effd1-0f74-4c0c-7be3-08d9d5e7146c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 16:17:51.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdf6RZNSkYz+cbZQXqRPZY723pkinSp5dYnhN42wRU9ItWagj4NQWrtQHi2F8L/hprGAdNc0iDpoG5VKYaVAVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/10/21 12:50 PM, Dave Hansen wrote:
> On 12/10/21 7:43 AM, Brijesh Singh wrote:
>> +	vmsa->efer		= 0x1000;	/* Must set SVME bit */
>> +	vmsa->cr4		= cr4;
>> +	vmsa->cr0		= 0x60000010;
>> +	vmsa->dr7		= 0x400;
>> +	vmsa->dr6		= 0xffff0ff0;
>> +	vmsa->rflags		= 0x2;
>> +	vmsa->g_pat		= 0x0007040600070406ULL;
>> +	vmsa->xcr0		= 0x1;
>> +	vmsa->mxcsr		= 0x1f80;
>> +	vmsa->x87_ftw		= 0x5555;
>> +	vmsa->x87_fcw		= 0x0040;
> 
> This is a big fat pile of magic numbers.  We also have nice macros for a
> non-zero number of these, like:
> 
> 	#define MXCSR_DEFAULT 0x1f80
> 
> I understand that this probably _works_ as-is, but it doesn't look very
> friendly if someone else needs to go hack on it.
> 

APM documents the default value for the AP following the RESET or INIT, 
I will define macros and use them accordingly.

thx
