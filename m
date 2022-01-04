Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5A484474
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiADPXd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 10:23:33 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:31328
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232085AbiADPXd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 4 Jan 2022 10:23:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjAc5mmPYfON5zbADnzDyN/+ZXCrLwfRURmMHEc3XxtSfRXffEDtox4WQlV6jr6u2skKhSQJYki/4yax9RW4MRYRXkFfUTDkDx/66bG2KyN+PWHQeGHmHwrQ+FW/Lj/gOVKPj4bYBsrtUIMfygyR3MD/UV+WdAu6rQYtjr5Ce1VB/bhlCXrqdk08hThN9Oo5LK2n+dKSBZ1gM0LYgujfM5PmoZw7+TbUIbxGgQkNYwbXgiAUx2RPjw3Po19KB7ZNSDt6lgg+M+DRIvsGI6l96iBLr7YAuOudVRWJhSghoQYyF1sl+V3HtDcci4Fk7174gOikhYRDQPQ9H0BTwakcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia5pg6yTeuKQHcgcRgyVMx7GdofYzi2hP+7yg8wHy+0=;
 b=XPaEiK4vYpMYjx0liSzEV3sTrFgAPAMSr+/aKtLhXq0dFvgmjKYivCIW/1IRrTWDrFMVJts3tEkb08+93cVWBc2gZszhQbdHrjnTAp6EqBTPgWhaBlC+MgiBXzQf0g2qY5yxF818lFcCJaLgQaOW+BNtMxmrOQCt34foRa77udYOPik7yNPpML9VvuU68AsZNEqpenKHWAIsBQImPQ/4qVXJoHM2GH/gCZLom3GkSx6lzN7l0vZa5fTpFwEzLFG4/olzB84G0Bfd5Hw2LmtvVXr3yBqKTUasd30mbjqBOgYszqtagwLRRAh3albxaUooXiI37/YEvQc33+ZJndqysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia5pg6yTeuKQHcgcRgyVMx7GdofYzi2hP+7yg8wHy+0=;
 b=CDPC/N9MQae4zBWt4q5JQJ5dJBtKyVxJSo8GZKFWExB/gn0ngC8iigh32+ZrCtPW4eiCjFso5y5+6tBEFsM/LgeYt5FhGea30yNKBPUP6kwnHb0IXQNMWekkBJUo+mYW4Z4xUcK6UbI+OiD4uIo/e9JEkLCcUxOVorQbHvFLf0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2831.namprd12.prod.outlook.com (2603:10b6:805:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 15:23:31 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 15:23:31 +0000
Cc:     brijesh.singh@amd.com, Mikolaj Lisik <lisik@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [PATCH v8 08/40] x86/sev: Check the vmpl level
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-9-brijesh.singh@amd.com> <YbugbgXhApv9ECM2@dt>
 <CADtC8PX_bEk3rQR1sonbp-rX7rAG4fdbM41r3YLhfj3qWvqJrw@mail.gmail.com>
 <79c91197-a7d8-4b93-b6c3-edb7b2da4807@amd.com>
 <d56c2f64-9e31-81d8-f250-e9772ba37d7e@amd.com> <YcDHF016tJLkempZ@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5fb651e9-3e36-0b36-81d0-8cdd865eecdf@amd.com>
Date:   Tue, 4 Jan 2022 09:23:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YcDHF016tJLkempZ@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:610:38::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ed628de-65bf-43e1-3261-08d9cf9629f0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2831:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2831508543748FBFBE8EB6D8E54A9@SN6PR12MB2831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS0WY2YUxOdUZfmFgZIeeNyh/tby35iWIf901XUReF5kEQFMJdtRGGr8TXe9tQz0VUVsYlSdG0GaZnHzUpn20j0Egll+DdAf8SRD4UF7RaW5HUEac+NycalauXz2uAfPI37IdfuayfRjpzjgIVPZruc+5mcsF1MNDpC30aHqOYuot+N/xD+exvvuNgRIcl6jIPL0WmOIDA5HzhZPKxywbTfm/xP39o8vhxxHpaxPRY/BAczygjULuA8zhLlCSFBhC5ehVa3TjQGpKKss9sGtg0/NErAiwFQMLNFVhrXPGIPXOTD85C36TjDb0cyJgfKphJZlyk4bkHqCkZ6nXz2l+H0gi7pxQB0LAXdZxI45WU02wU3G4+//FCZcstAwftykAP778yomZFI//HlHctKXKNXUSIu0YXqri/oSEeuhc5/ddWNa04A87fs3bLAv+PHBVBKBOv21d3498QOpny4Ru+QugMYq0im0X6uOgwP+ykDO2rs4Gk/MJ/8Ty84BI8OUFf0aCtFLiE9tTrF6dXzwlMvoy7HDVT8dqxBvQTCBJci+l2bQ1zFqe83i4fPO43YoLf4jrFJcQVPNDEIDHVMGPOb1FMV7eo8Ekz0TSsrLs2v1W6b9p4ZXK77HSf3bd5DmdC4ez8ZjJ8+fCqoEopePXO58IMJ80MnN3uOi70m0eGf9cwLlvSzpazqqRQexScsqTobvsMNqHOauISZcgNix+SrczW2S6Pg73K3bUBqz+f8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(316002)(86362001)(2616005)(36756003)(6486002)(186003)(26005)(53546011)(6512007)(508600001)(6506007)(66476007)(110136005)(8676002)(31686004)(8936002)(7416002)(31696002)(5660300002)(54906003)(2906002)(66556008)(6666004)(66946007)(44832011)(4326008)(7406005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2x0QzZuSVdjdVVzUWhGaW8zYUJ1L1hWcEpSQWR3YUxVRDlKMkdMdS84TFpi?=
 =?utf-8?B?VnZncUJtR1JtSnBJSllCdldYaHVCMVlrRGNlQXZQUmw3VWdtSEh2dk5BeGps?=
 =?utf-8?B?di9OYVljbEwrVVl6bThTV29mZWd5Y2lTZUVPNzZkMUtHTk5IVXBrY3ZhNUth?=
 =?utf-8?B?WU1SbTY2NTE0SGx2clVwZkFTb2k4TjRLYUtucDVYMDJpbys0Zlg3WGNBS29r?=
 =?utf-8?B?ME5GdHlweFIvbnd5UE1vekRocHd1QVYyWml0ZXdtM3Bacmc5c3R0RlMyTUpU?=
 =?utf-8?B?VFpaWHVVbkFYTVdRcVRBbjJkZU9QeGV4c21rNHpPYzBlamJFSG1wL29ORUhv?=
 =?utf-8?B?aE5jc1NuQUlRVFZvOWU4WWdLc2taT2xmY2J1UzF2dHd1bEZ3eHlHYlk1Qzgy?=
 =?utf-8?B?RWpKZkJSQmE3RUVaZzFuWGN6K3JmTWs0RkNnS1UreDRyUmJCSGlSLyttdnFP?=
 =?utf-8?B?U0JsWVRlTC80bmhlRWRadkF4emNrV3QzZ3VpTU05TVVOUU9IV3lLTnRCbktl?=
 =?utf-8?B?WGh6VDZDclpYRE1CNDdtWVNqWFFDd0VSMWlBOG5pTjBZOTgxUUJ2TDRPT3RI?=
 =?utf-8?B?YVhQNWRMZGxTeERTczB1M2t3VTI3cTVTWE5jeVcvcmpubWI3ektyaFdPVnV3?=
 =?utf-8?B?ZFlmRDNmUzgwMlQwaDY5dlFKUFJvS3ZtS2kySFRQaVgvN3dlWm16UVNVcEdv?=
 =?utf-8?B?WU5NUmh1YUVrekF2TmlyWkF3aCtya2owUnlUa3d5VlRvRDFlVjB0Ymh0S0lL?=
 =?utf-8?B?K2lvMGcydU4rd2czUFluMTQ5eUlrL1cyOCthUW8vSFM2VXZCd0Z4Z0l1b1Mr?=
 =?utf-8?B?OElMLzNGUm1tNWNYVjNGSDV6Y1RtcDQ5VVB6enpaWWpWdURsRi9kMjdoUWw0?=
 =?utf-8?B?bmM0TXViK285emZFMEhkRFlmaU9xTndJNi9yZGo3cXcyN2xwQzV3cXBuQ1cv?=
 =?utf-8?B?Z0QxUjdUMzN0TXl6ZUpDOU9DL21YMDVkaW9PUm0wVFZnT3VCT29paFUzQTg2?=
 =?utf-8?B?MnZ2Wjgvbi9lOUNCRFBZd1ZvVElIajBCQjVBZjR1MzBuTnczU2VVR2FkeEZS?=
 =?utf-8?B?LzhGV21mZmJLN1o0RnJHOE53ZDlGVmNuTlJsQWszMGhhcGNkWVRsSmlpSFVz?=
 =?utf-8?B?MWcva2c3bTRuL2srVjJGZkkwZFZWaTl6dnJvOEZXdng5L1RCWDh1cm9UOWdu?=
 =?utf-8?B?Y0J6cnljQ2RQV1JjK2xUTGQ2czRySmNkU0F3TTV6NjhmUG95QUJqa2NvZUcr?=
 =?utf-8?B?ZFJFSmYyQy9PUURGTnZJVmFVc1JPdmFSZWxYWTFSZjYxQTA2bmt5ei8xUUJU?=
 =?utf-8?B?VzBJdjQ0S0QzN3ordno2YXZjL1V4a2QrUmk5RkNzSFBkQzNKZHl5eFk3eC9V?=
 =?utf-8?B?TUdrSzFGazRJKzdwT2J2Ri9OL2VPQ2ZiaEd0SlRCVnplZFNKU2djTmlidGtU?=
 =?utf-8?B?NHZPazJhZktiT3ZYSkJrM1RKU0dJVnc3cy9uU0YxbTdqeUNXU1paK0d5WjRn?=
 =?utf-8?B?aGxiS2RtZVllbXNpeGwxbWpreGcxRlhzQ2pZbHpPZGhJQTN5TjRKZUtzSHpO?=
 =?utf-8?B?Uzg0UWpRaS9NVTgzditmR0g2aTJaVmJsRUhIQ1c3QWU3QStSczBDZXRVZ202?=
 =?utf-8?B?bXlZQWtqcWJLOWNCc0JlQ2greE9TSzBjK1RVL1QrdmcxTEliK1I2SjJZdmpC?=
 =?utf-8?B?cXBnbVRIc1NFZWpYTjN2MEhSK25FaHBmeGdINXovNEpZWktYdjZhbUU1NFRO?=
 =?utf-8?B?OENyU2duc3dXaDY3bUFoN2Q0UUFjSEIrRldXNjVMaXp1MGJOZ0FycnZKM0Vy?=
 =?utf-8?B?RFNucDNVaUlpY2tPTWlTZVNvcEQ5K3FlSDdacHgvMzFYY0lHL0ZrV05xNzFN?=
 =?utf-8?B?MEpIWmJnTGtwK1p4cko4ZWpJNjhjNm10NWwvL3lHY2dJUUJRQUNsU2F4bGc1?=
 =?utf-8?B?UmRoakFzRER3SDB6QlNzSHpXL0E2SnIzU2JTckpiN0VTMDA3Umpyb0lMY2hU?=
 =?utf-8?B?bmlpRkNDazRsanF3QWcvcGtjZFFZeDlFRXFDcnRTUXMraFpxYnBpUHJQbHBW?=
 =?utf-8?B?YzZ5a0xJcE1YeFJDVWUrZXFlWDRkMnBHSzJKZWh3RFdrdkRmbXc1ajdRVm9H?=
 =?utf-8?B?QnVoZXkwbHJTZTJDVFR5UVlBb3VGUTRicnpIaHllS0FYMXZ3VUZibGNkY09s?=
 =?utf-8?Q?Ad7GGssNoZSpEdJkl3x3W+4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed628de-65bf-43e1-3261-08d9cf9629f0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 15:23:30.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4ZFSUVGS66AWqeYnc0UEHbwQ9GzCjfNrxDEK00f8tLVWXC7t0CED0b6Bs9smCewgQfzy5swMaS5AjZsMNsQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/20/21 12:10 PM, Borislav Petkov wrote:
> On Fri, Dec 17, 2021 at 04:33:02PM -0600, Tom Lendacky wrote:
>>>>>> +      * There is no straightforward way to query the current VMPL level. The
>>>>>> +      * simplest method is to use the RMPADJUST instruction to change a page
>>>>>> +      * permission to a VMPL level-1, and if the guest kernel is launched at
>>>>>> +      * a level <= 1, then RMPADJUST instruction will return an error.
>>>>> Perhaps a nit. When you say "level <= 1", do you mean a level lower than or
>>>>> equal to 1 semantically, or numerically?
>>>
>>> Its numerically, please see the AMD APM vol 3.
>>
>> Actually it is not numerically...  if it was numerically, then 0 <= 1 would
>> return an error, but VMPL0 is the highest permission level.
> 
> Just write in that comment exactly what this function does:
> 
> "RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
> higher) privilege level. Here, clear the VMPL1 permission mask of the
> GHCB page. If the guest is not running at VMPL0, this will fail.
> 
> If the guest is running at VMP0, it will succeed. Even if that operation
> modifies permission bits, it is still ok to do currently because Linux
> SNP guests are supported only on VMPL0 so VMPL1 or higher permission
> masks changing is a don't-care."
> 
> and then everything is clear wrt numbering, privilege, etc.
> 
> Ok?
> 

Noted.

thanks
