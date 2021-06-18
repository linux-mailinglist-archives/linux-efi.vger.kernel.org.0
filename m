Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AEA3ACCF3
	for <lists+linux-efi@lfdr.de>; Fri, 18 Jun 2021 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhFROBz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Jun 2021 10:01:55 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:61600
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233754AbhFROBz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 18 Jun 2021 10:01:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SimrHQ5gt7Mw2b8oCDrGxH3ZORjwOPceTUS+xVBYTpVZVz9Ua7bQm7FQCbhd27eu/W3pxW2SPGag6Warm7GeNHTnewZMDH9dRcpTZMEcTZCfDBp718QR/d/D0qCF2HaAczD5jSo1WCUn9hPP7YZJKc21d6KyFa2VnNN7rU3siDR1eXhQpoJDZTwpFTvhkOa5ASmzXZUrJUCo2q4JxFEZA4Wn2JdPPBddDX8q/RRoqJ/ArSgZpqLGsdzXjKD53zqOEoFWMoFGo55Ub6nr7xNoMQwu7p2CdigyfQTWtzzpyRw4dSNhY7UCT0VQfDNZwC39z0n9zEB5ZDqkDVrPM9dw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHBVpf0q33LVIlGWho7N+9nIyRJma6vF9qxUsjdUBtw=;
 b=X6ivD3i1CLYWosY8zb7q0ur7KNJEHET7cl0YsDHOJLwc32HB7zvq6KeMuBIMtWHvwOg8TP9ksVC7UndLsbn/KicqD9p7LtEkNBlheIO7Cm4afd2KUCXvmRUW73fIYlN6xoOZrnT+nW0uAlwhVYYstx3mSw+Y6nZY/1XlLpj0kvRuzgth3msaj32H+hykjWRTLjtulaOqxfLbIH+EJzxCxQZzytquUmQigT1MxRSDGe86kwcEsoXBUtpqxAdjej1Ol4L+AFGEVX0XH69AD2XgpxIrrvdUaTDN7XUUEkDLytOukCcwc5ZlaM17glylt/RFf782TFb25UkgmMq4aAQB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHBVpf0q33LVIlGWho7N+9nIyRJma6vF9qxUsjdUBtw=;
 b=IlzOSTGeCdSeMHppsuyyi0F59sUrQiTbxGsRiuowtVgXVCUq3dLLnu0cXyHAQb8ShjKdZSAfTyvF34FXKVX+1+t0pOAAlDXf/3o+lXmQ/fc9c/YP35TJ+5v4kOCe7IRFEQc199Q2iCgd9rbgPNcSWdZTFAJsfQSLlLi+rvIyJiE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB3850.namprd12.prod.outlook.com (2603:10b6:5:1c3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Fri, 18 Jun 2021 13:59:44 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Fri, 18 Jun 2021
 13:59:44 +0000
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
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com> <YMxrd5M1teku/hnA@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c2fcffe5-440e-5405-7139-329ef78c6552@amd.com>
Date:   Fri, 18 Jun 2021 08:59:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMxrd5M1teku/hnA@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA0PR11CA0193.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::18) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.12] (70.112.153.56) by SA0PR11CA0193.namprd11.prod.outlook.com (2603:10b6:806:1bc::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Fri, 18 Jun 2021 13:59:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96d64c69-323d-4084-1f1e-08d93261532f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38501F7714823F85FC312179E50D9@DM6PR12MB3850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vjVeeMRyjbHkkj2jc8Rnd3Z5x9EanGUloLJoQapcUvgD+CrtHbIZJaUKQUWV73wulrygk7rMChkAHZ2TAIcZt96AcdtRWj1W+3G2sJKf6FOFHiS7lqnbq+14b2/mIrsOgQaU5x4hN6J6soEBDSOdqBUo7jrU5sylkHgKgt4/ryW9m84d6UB1nVywLZ96UnA/aumDN/Vzd8b+y0CZLDNraqUKW2ubsKGYzr0bhJMqMLooWj0cI8PqirBLMlbm99WRO//R7PrCjrjcIzQY+v/iXr6trPiHE4ZEfbuNCh3ipkgmEaw7+/wfQ/ULcBaKTmKZIwYJVSeToBlRZD+nOd2s5YUN7YO19/D7dpl2mG143rv1axubNQnYnVneh4vQkBe6EQYMfBhdQd7orI9994/fJhaurN/wJBysGJ4lw1WMFPW4oOCHwtJaLVrHbl0xTXP72mDc3UZoPyWioukfYSxF0KLAZkQT5a5rE+GcsEBT3hoJdOEXWr2hmZB7oUadb8LbqhS+yqZS4dCijLhrR1Qvm28KXhEsDVHGCmiMcRaTnzXf6gA0tYGWt+zVlnKifM0AjUNSf8lHh2ycTubHI/pcB4/UB5Tms17M3S5vGSwuOWStbEjdBEQKPTd5A0CKEQI/RGCFBoCHTdAFJkqrp5jT5Mamq6VgaPXBIp4lOTaY+iguK7nlGL4gG5oZLTslK6C5wkpn6hzm/5pS2qRru1bclHQKlf/w8hRMOVzp3Zp+8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(53546011)(86362001)(6916009)(2906002)(558084003)(8676002)(52116002)(478600001)(66946007)(956004)(4326008)(2616005)(5660300002)(66476007)(66556008)(16526019)(54906003)(16576012)(316002)(44832011)(36756003)(8936002)(6486002)(31696002)(38100700002)(38350700002)(31686004)(7416002)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnYvVktUUWhYaXFZamZacStUeFZ2NnhqRVJwNngwVS95UnYxbzR3S3ZQV1VF?=
 =?utf-8?B?aUFFT3NhOEZ6V0IrOEtiQURhM2hVM2d0UWFJRVkzaXhDelppQXViV2FnUzFm?=
 =?utf-8?B?RmhrVDdWYnhLeFJacTk5Z3dqbE1lY1FRckkwWUJNbFZsazljdGtLSmxXbWdu?=
 =?utf-8?B?U0UrVEUvV0Y3NXR2bFQ2em1BWm1sNGRHSExtRFlHUDlNQ3d0T0k4Z20vc3Z1?=
 =?utf-8?B?QktTVWllbTJGYWY1RnNxQVNoSnVxT1E1RWNBUUhGT1VuS3FaajVEL0FEYkhp?=
 =?utf-8?B?SjlCa0VSZEhzTzFBM3RBT0F2N3M3MDBVMndsNUZLTG81U3lKRVoyTFlmaThP?=
 =?utf-8?B?dnNETEFMTnBaVjVGUS81NVBMbXo1YlRTUjNmZ0FQN0VGMjZrN2pNQmg1ak1l?=
 =?utf-8?B?Z0pMMWJaUCtnVU5rSnRRL0JYK1MzL0xMQm5YbGlyL1VJMEV1bXh4cGdXUzlU?=
 =?utf-8?B?VldXNG5kdHdmRE80VERsTlZINDNteWZSV1Nub0NzNmszZWZGU0lScisvUFpp?=
 =?utf-8?B?UUE3eHJaQ2Rma0o1Z1Z1Q2NsZWVTck5nVG9WUTF4WVVjZVlyd1R5YXArTzJJ?=
 =?utf-8?B?d2NqMmcycVhjVit3ZnV6dkh1OWQwQXZBd0ZCMHZBR3gvT1lLQWJndnlCZk9w?=
 =?utf-8?B?Nkc2T2hDLzl1Y29XVHlUblZGeU1BNEVLbFlGR2xHWFZKNk9MQkZFdHpKQnM3?=
 =?utf-8?B?Y2paM0luKzk2aG40aEFoZ0VYVmVCdndXRHJTcVd3OEVHN0cvYjhPSTZMaStE?=
 =?utf-8?B?VUhOWVRnOHpNZlA5M3FIbWc5dUFrd2VNWk81a21ZdlBYdG1vK29PUVJ1L0pI?=
 =?utf-8?B?cGRtenE5U3M2N0VYY1YreHVkQkdPQlRUMHhjazd5bUF2NDBjeXhhcy9JOW9u?=
 =?utf-8?B?eHViTjVKcFVyWDMwKzJ5Z1NJSlR4NHoraXpHdGx4Z1d5aUVqL2NOLy9LUUN4?=
 =?utf-8?B?OUhVTEpZK2Z6dXNBMVdTZy9LNk85dk8xcnlYRkQwZVZNdkI1TGtDMmRUSEpk?=
 =?utf-8?B?eDFpNlV2UXpKSFRTUXhCMzIrUUdCOEtMNVNtcWFVYzFTUGY2dnRWOTRDZmpy?=
 =?utf-8?B?VWQrUDhORVJTS21zUnJBQmRydWI3TzFKSTM1WWdDakFhYlhDeUEzenNkckpL?=
 =?utf-8?B?S2ZvQzAxY0U3czF5TXBLVm16SVRiRlNmSmFVS0JtL2VuUHlicmxlQTZEMWFl?=
 =?utf-8?B?YWU0aVo3RlR0NjlWZDJjdFNQZGRHcExidmFnVW1QRlpYKzZ5RjM1cE9uNTZi?=
 =?utf-8?B?Vm54Q2RheXQyMHladm5UZ2xjSmQ3c1ZHUmNuNVlnSjc1dm5WRElRVFZ1Qyto?=
 =?utf-8?B?M3ZwNzhEY3k5dVlnSnpGQnJTNXhyS1prQ1BlS0sraVU3NFhDYytxWEJyWGdC?=
 =?utf-8?B?bHV0M1lGUkdtbVJGdUF6eHBlOEREZkE5RlE3eVdvdUdPanVNOEFCYm12Wmp5?=
 =?utf-8?B?VmtKaU5KMlZtQVFuSnpRWmhWaE8wSDVlK0szbFRGd1NXNG40S2xOdVFJS05E?=
 =?utf-8?B?bEJaZHlBT0M1dENZMnBORUUzaFF5WGtNMk1CUlB6ckJuVEdxUVRpZFdFSjkv?=
 =?utf-8?B?c1dORzA4NDdlQXlYYmpvZzdqS0QySm9Fc29GU1pxdGxwdk03VFAzWUgzNVFi?=
 =?utf-8?B?NWRFVmF4eFoxblFycEZPWlVKY0wyd1pBZ1diNzJHSHhJNnFvY0VsVWxuYi9p?=
 =?utf-8?B?T2lhbUxBVUVIelcrVlZHc0JYZVNjRnNPUzkydDJxeFZMNjNKd3d5UzZScFJL?=
 =?utf-8?Q?zUxtTm5bik8UG4GBJalKG5e16f8ZKDwck85giHa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d64c69-323d-4084-1f1e-08d93261532f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 13:59:44.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF29qPnsohXwheLCJY9xx4A0dXL4ljwY6BHhflIEJyFx+vjTV0Oed502TTFg7n1vWewfN8KZPIL518RcXc8BTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 6/18/2021 4:46 AM, Borislav Petkov wrote:
> Please split it this way before I take a look.

Ack, I will split into multiple. thanks

-Brijesh
