Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A93CEE60
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhGSUjh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:39:37 -0400
Received: from mail-sn1anam02on2043.outbound.protection.outlook.com ([40.107.96.43]:27222
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352236AbhGSRtX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 13:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghRAMf3qwY/M3/K4/mGtX/T9xCimxfaTWkg9hXTZ9shhLY7OJhJgSw0G9RWuDDa2LV+LsJ8VFY4YZkWxikYBNqAiPuGewwdkTdv5GSKMHJaaYLOzhDfYvlFGG4S2rDxMxzojOTHPL/kTTIAURkPNVdd/pq+tSKohD+yyoyLUzMc+To5HWMyvp57O1trFS1mzkYMUxnesbajPV4PAsuCgEAMHHWdIPIuu0Fl85rq9eQlUIDHJe9f3gTvbFtIAtBxsAjkFXivdGQaJwXZYDN4SOQBIiHLRKosBHFJMKUbGUvzCfNp6m76WV1CSdHu9VmmM6HGjckaJNX5UFtZtR50Liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2leJMeBr+qto7R++aDuqlHBpeHFM6TfujEp+HteGzsM=;
 b=Uc20rz9V4boXe9Zqba/dFnh0/+gKn/jrqxiG9ftBXqQXj1mtvhWS9uuxBV8Lu8AUhhdqOdZ6MY+GwaOiDf8avYlU6nLN30F6l96g95D+b8ZoIGkQtfaYgiCGn/BILXLAYS0Cqu4dqHI/+kb00L0A2sRqWs9ITa8FhDxmLwaHIQkxEbXGgVchec7qhNBUUyGNUpq6YlUJPU8pY/SpHmCVNfia22m0LUUm6+3GXkXf51Clfufyszy3SqiHgY3wWHXQXGmZJ3ZRLfP6vpJmkgdkBXy63Ga0ZJbv2DnaQZ/KzEJeH7Lk5B1V0x2Zl73HpVfSgpztM6mjajGaOtoUu5Wh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2leJMeBr+qto7R++aDuqlHBpeHFM6TfujEp+HteGzsM=;
 b=iOtnTFzh1Si0solYSeZhtCHcZGx4pNhC/e3+5SBjPUDU0g4la4d99AFmLD62qiufys+u8y9atnSal6jZ+YwtZldFUwopWoquNJDuNt1lA+LHLV7n3koytzv5on0oTe4AJubj+KZrhcsVjTdDJB6WGVTOP1I0y+YhVVKoyhrJnXY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Mon, 19 Jul
 2021 18:30:00 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 18:30:00 +0000
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
Subject: Re: [PATCH Part2 RFC v4 26/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_FINISH command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-27-brijesh.singh@amd.com> <YPHpk3RFSmE13ZXz@google.com>
 <9ee5a991-3e43-3489-5ee1-ff8c66cfabc1@amd.com> <YPWuVY+rKU2/DVUS@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <379fd4da-3ca9-3205-535b-8d1891b3a75a@amd.com>
Date:   Mon, 19 Jul 2021 13:29:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPWuVY+rKU2/DVUS@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:805:de::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN6PR05CA0005.namprd05.prod.outlook.com (2603:10b6:805:de::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Mon, 19 Jul 2021 18:29:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18c632c3-3a1d-4ae4-d0a8-08d94ae33789
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43829321A1D7542027B2C35EE5E19@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYjOX73mE7TYfDVwmw+GoUeG3ub4PsfybXD4IV7Oo18zh760s7QamQaINxVeL90keYEeD1HC4N5ViDhhS/OPl7jerwWa93b4rI8FhQ8Mt3EQdDaCizGNdVXvXn3QeyY841Q4j1B9hsgXWP/E0wlSNMj5sh1AaS/e0RmccrNbNTQdG3YELnfFsD/MAtu+rQEjY/nh5ff8mI9EX6cRAUo5IO8RtvnvyD63d7E8x2Cz7UstbA0ryxpU/P38eCZvq8b8HhHlsbHIPrSIKt9VDSA2a5eZE6ZkxJZUODSNeWMbyzaKfVirJOq6aNpSsZXrqXO8ggUOAw/PugDuT4jly5UG07xfmq9G0wji9/amdprTUMGw70KHdkxxh6m1R3VOx1q3pB0sDYCDucg+92Hw2LrEkpMgEDzv/Qak/OM+ip2WPSiRZF/SMrkLpLc0dcz1GBJIviY/0ZnX57XDSeB8K8j159lnquqfFtQTxDPFXjHiFoNEZGw7pBzwF/rspxinoVQv0D7YYMf932bm1U6WynfxvFekqkod7340oXQDydKzACouTW80gu/ZkcmNTfbuDNIZCU5rs9fJ5Ok/0a8w628GXLQgnaZog61CX8Xslxl5NtgN3lw64GzBJ83Gyvuh5HK6we6fRXJAnPetXk8GrR6oBCytaMYMBldBQTqAGCUIp7jPJ9WDesxv7ruqoOUCXQn+xNbCJnmwEvwe0zQjZictXnu+oIpUfWMPQzfgLM523GuA8JEcwCob5alg1DDjwQcfacMfUCM+r3yf72csx+m8Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(53546011)(66556008)(7406005)(66476007)(83380400001)(5660300002)(316002)(16576012)(8936002)(508600001)(44832011)(186003)(2906002)(54906003)(7416002)(8676002)(38100700002)(38350700002)(6916009)(31696002)(2616005)(956004)(31686004)(52116002)(86362001)(26005)(4326008)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGVsR0tPT2p3Qk1tdGVucGhUVFZZTlhYVjVPMEx1QzBUanQyUWhOemFGRStX?=
 =?utf-8?B?Z2VOOHpvaWE3a0xFQklRQ1BQMGVXdE02a3JCNEN4TFgzeW5QaUsveUpacEF0?=
 =?utf-8?B?R0dPUlZyRWlRakhFNElCZmVtanZsU1M0ZnlaaDlyM1d4d0NVaXNDWmw3aFpi?=
 =?utf-8?B?WDcvR1BSTkJwTCt1V3kxc0lZV08wL1ZKVDJUNU02MHN5RmxSaVhCYUM0ZW1D?=
 =?utf-8?B?d2VxRVNOWVBicmVhTHVRVDZrNE9HYTVDc0EyMnNkZEM5ZEhsMmYrSlpZM0k0?=
 =?utf-8?B?aStFWHRQNlFQdm5zcWFPbWMyU1dpUjlNNlhpeVgvVmZtSmcvNUN0eDFoQ2xx?=
 =?utf-8?B?WFZtdmd0QkZyZ3p3VGdTUG1CMENQNTRRb2FOUnllZnIyZ0MzNkltd3AwNGhw?=
 =?utf-8?B?YlZONml4cnl2NVlOZkkyRzVob0lXZ09lU1lkYkdObXFDblJNV2ZxampTdTNW?=
 =?utf-8?B?YmYxckRLdUFVcW1rSVcrUFhFTFdVbW5FcnRuajV6L2hZR1ZSVnlWbGx2cHMw?=
 =?utf-8?B?c2ZtcWpCZ0F3OTlyMm9xd2IraGk0dForOFBNRXlrTG0zRTI5K0JMVEZPWEpM?=
 =?utf-8?B?bGpRclpYeGVxeS9jMHBKazZlQWRCcnc5UldKOWpZL2pxRWYvTEFRYnJQMHNt?=
 =?utf-8?B?UVdnTVM3Rkc0cmVCWEVFbGJMenlXa1p5ZWVUN1lraFpqSGFvSm4zWVlmNmYw?=
 =?utf-8?B?ZGZoTUNKaE5pcFB6bTZaUHFLMU1Xdlc0WU4xNzBUUXFwaW5ibFBSeTNiRkxv?=
 =?utf-8?B?bWUzZ3dPcHJCREg2SE9SWUNDM2lleklUUHMyNGt2OWVuemhvdmdGYzd3S2tM?=
 =?utf-8?B?bzlRVVVCLzVXOHRoTmQ5bEdlYmVHMUZEUUNBTERYaFQ1ZVpDUXBPRzZPTGo2?=
 =?utf-8?B?U3FmOEJRbGw3RDRpdlhVZFh2VjdCRGxsZElDbjI4L0ZaUlJqLzkvUjFYLzk0?=
 =?utf-8?B?dXBmMzdhSXlMQ2oxS1lkeVJjVGdUakxZS3F2aGVsMkQrSk43VUhXSHFlOTE1?=
 =?utf-8?B?aW00c0t2aDZvdzkzdGlxUXNSblFDUVBpVTNTRlE2Y2JCOW5aVlJ0aTBKQXhp?=
 =?utf-8?B?aTEzT2tZMnhJTjlVdS9pWHRiZXdPSkxvcUw3Y1l3UklCdmZKTzFGQSt1RlVI?=
 =?utf-8?B?N0gxWWthcjZyUlpmZ1E3UTNEbnFvYjBTSUdMd213NmF4OEpoaHluTWNJc1hi?=
 =?utf-8?B?QWVCUXV5S3dPd1lTVUtjdlF0d0JPejd0RDdYUjZYQUZneEpiV0MwSHM2WEg4?=
 =?utf-8?B?VmpzWGxrYzFtdHVTeTM0K1J4NTc5ZGEyNEFSYW84Y0lxWXZmbE1UVmh3WERu?=
 =?utf-8?B?Z3U3U01XQWNreitHNXJ3TE9WWHhpc29GSHliTkRrSHJGdTYvUUF0QzEzTnNH?=
 =?utf-8?B?b0tCdUJjZUlLOStlZExrblAxQURMZmF5YWNwYk1OeXFrcHJJZEphclhJeDlu?=
 =?utf-8?B?b2RTSFJ4aU8wS3JFa0dUNEZJQ1lvRVFqdDdIcHc4NXhFOGppVC8xd2ludWEr?=
 =?utf-8?B?cW9VVnZ6Z2pRbEVDeVdkY0RycEkza2RTU0ViandPajEvbC9hVlU5Q21lZ0Nh?=
 =?utf-8?B?TCtEKzdhc1lQZlVxY0o3MnppamNaS1FwakJkdk5rZ2UrbHQ1YWxhOUFhcnB2?=
 =?utf-8?B?bHgxdkZEbFMrcyszV2FBTEY5Qk1VUVNWYlBwV25jSlhQMDNQdEV2MWVKUGo1?=
 =?utf-8?B?QjhoelF2SS92b3JEa3cyaThYWkYwWWZjYkRPczF5bDJYVjdjVW1JSnlrRzFE?=
 =?utf-8?Q?0szLUVx4rJ5PF+aApyTUb+/Maw/CC+ozPh+N2mt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c632c3-3a1d-4ae4-d0a8-08d94ae33789
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 18:30:00.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWE1t99Sk6UX8MoRoumzwTjNJ64tIT1o+4zAEG/NX3+XUPHVL5o6kz0V6Kmfskpe2lmSqy0SWZmcIoYobAICEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 11:54 AM, Sean Christopherson wrote:
>> As I said in previous comments that by default all the memory is in the
>> hypervisor state. if the rmpupdate() failed that means nothing is changed in
>> the RMP and there is no need to reclaim. The reclaim is required only if the
>> pages are assigned in the RMP table.
> 
> I wasn't referring to RMPUPDATE failing here (or anywhere).  This is the vCPU free
> path, which I think means the svm->vmsa page was successfully updated in the RMP
> during LAUNCH_UPDATE.  snp_launch_update_vmsa() goes through snp_page_reclaim()
> on LAUNCH_UPDATE failure, whereas this happy path does not.  Is there some other
> transition during teardown that obviastes the need for reclaim?  If so, a comment
> to explain that would be very helpful.
> 

In this patch, the sev_free_vcpu() hunk takes care of reclaiming the 
vmsa pages before releasing it. I think it will make it more obvious 
after I add a helper so that we don't depend on user reading the comment 
block to see what its doing.

-Brijesh
