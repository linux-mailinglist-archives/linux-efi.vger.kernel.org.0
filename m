Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236AF4509C6
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhKOQkv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 11:40:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32266 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229926AbhKOQkv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 11:40:51 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFGZM2C001656;
        Mon, 15 Nov 2021 16:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zA4aR8g7in86r/Sk8l0qhEQ1lTCLULS9df2l9zYo+q8=;
 b=SN8tJnicn5Cf2RbEigztqTQxbfYNxgUixkfvpPc64gZpDL1YGcU7FkB4EmSE5s3KHK7V
 jOXP9wd+HoMCdQwVDWJPYvLS8dkNp7qbyoh+BM/O/D5AOoAGmH8UUZlg9uu8gFQszb+v
 JYgvWn5K2krDPJqA3EzMhaWGAMHKYraKD9pjlH8P99X+DpqJVmFp4tedUwmh+VaA9YaS
 cz06m4LPLGtmvwkEmHp0VRHcBrVtSv1GKRfZVaOyv/hzvVANlZIaUvFf942DzM5KVFMV
 HKEDW/idfOFDj9wiPQrRNzENfzmsjKwB1oL9fm1B18v70MGMc4eYPU1ibqJrwhK0hwqq XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv7un95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 16:37:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFGQMUj145953;
        Mon, 15 Nov 2021 16:37:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ca3denqqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 16:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJD/o5ueop/Jxg3CIS/FbKD7WOQ2ja1/hKxNT4M3Vhs5egFfCZljHGp7pbStFd4EQ5Tj4iKvsO1THPqt3nfxqL7iiPGL7iJFruW4ZFOiEYqIJ6R6NNqVggSnb0pK36STgmgySZXPGYMDjK4MpV2vms862x7sUK6AVrB6FDzjWF7hs7XStfdjWMGv4bh06AkjzH9XclpXy8mj5SIo4T7NjZvOc37WLSXrtOfht3sciR0KX3XHiaSjzh2Aq+cAFlRfOn4FPDIJuFoPxVIVi45JPdJVRXqzNtHZ86lqSHV0rPXeuV3lMpKz6jBynOPUydT77fNkAgA5vDVKskg3tTeU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA4aR8g7in86r/Sk8l0qhEQ1lTCLULS9df2l9zYo+q8=;
 b=etnqoZH2Kyf954kUpolwsbu30yWF7chfkz/valWU6cQGZNOdceutlO2wOCvpMN0pS2hrg2HRcVkBYedEO8CJ/hNaaBKbTfipkWXyAzSyAUzMPwmisgzXNP3ipOt4OxDi1xBARol29uoJJxwdqizi6CDILInx5zKZ6euDre/JwXPtI7iTf87ny9VFUa06imN+8Jl8OA0gqRVhYbj6C9I2RpmKueO42+f1bZVnpnyDNuvbdF5d4hjyWltD6EZ0BXSmgt35pFB3J6mgbm9U8OjXL1YU/MILa7IFVCbKFs5oIwLuzasEH0GTHKmZPZ+OhuIoGLszNYnkdFExOFk31Aa1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA4aR8g7in86r/Sk8l0qhEQ1lTCLULS9df2l9zYo+q8=;
 b=pf//wlH3x5fiT5akC1hceGOGUaVm8iFreOJa9FJq8eYjXVOG4PL+XSiexRUHX5bGTAz0/gjsM+Z3EKUVWNpOGDxBX0zXvHU/8JevqDBgQfepVbRDqJWjxDG6MKA9T5uI9wyi/1iPgPXL/a/sWsa3IYQzyn1nLL+Xmuo9hysM+UY=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4601.namprd10.prod.outlook.com (2603:10b6:806:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 16:37:25 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 16:37:25 +0000
Date:   Mon, 15 Nov 2021 10:37:18 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Message-ID: <YZKMvjEIGarn8RrR@dt>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <YZKDGKOgHKNWq8s2@dt>
 <a631d02a-c99e-a0d6-444a-3574609c7a25@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a631d02a-c99e-a0d6-444a-3574609c7a25@amd.com>
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
Received: from dt (138.3.200.60) by SJ0PR05CA0199.namprd05.prod.outlook.com (2603:10b6:a03:330::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.14 via Frontend Transport; Mon, 15 Nov 2021 16:37:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71a3f5f-3919-46f9-8f18-08d9a8563443
X-MS-TrafficTypeDiagnostic: SA2PR10MB4601:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4601A1FCBC09AA4D0FC41214E6989@SA2PR10MB4601.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RR2kXC1L1qutJgqpg5NtW9tXOReo3zkdLhPL/3RQAHPWSpaAoqyBRocdHKqZTXYm6eU48Lo4wUFnb1g6kKEhRilP9pQZwg1nDOi16bMw3s9D0cEgfBtN1uYecramJZF34Jadh2KZiDqGh/Qaqy+fdzCsfFp947W/NCbK739EQE0RtkYdHpuh0a2Bg/JToA0EEO5u0cf8gkxS6INBD0+dKOjU8RaaJBXFFBdHr7po2luhCIb7IHg64ztN6PeLOGGy6f244RgiVgQP6W7XOtonT4s40jFUHdoy4/WJB/iBibfIlA3ULhSDrhHIfWrDm1HK4k6HzdBr837N79++15Xjbyxs2nQ30l4x0FX7HfPAndDiBB8GSSTfSt1+YXMWoMush74VfpxBxgW3i3Ggh7Qao3Ke9OyrjKOSUVGjigAhTQFdgk7DxORINH+un8nuVWgZQpOmgHZ5SdlRXiJk19QC3RDcl1E2piy0Prt9BjUuGkf0uIAMmfbNZmRjlZG+/DWY29HVGdmfOIgeywT2Cco4R5PQjoGoZWyJvSgSub4EFhj9/LsIXbUenzyD2U/0K2Lcw0j2cXsW79p5js/oOw4R53LjOOoP4KuRA6/D0IhsBgNEqwLLHj2txRTDLkJ+Tqf1RbYZTpcyrs9908NWC7JiP8cgYzt+bedxCcDHc36Osc4wZUF8AwHe27qq2q0Ujv5FVvum2YqPNHt8p1Qi/foGXe80whJHlzvm6t/RdA2wxn0RhCGUqt1yDiwqpZvOpvX57pM5ZJNq33v35UvcDcE4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(44832011)(4001150100001)(45080400002)(86362001)(2906002)(4326008)(956004)(966005)(5660300002)(8676002)(186003)(38100700002)(33716001)(316002)(55016002)(26005)(6916009)(7406005)(6666004)(7416002)(53546011)(54906003)(66556008)(8936002)(66946007)(66476007)(508600001)(83380400001)(9686003)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UqO4i3rTW349RvAYjy21zzaf7BGLq8iiClX0Z4kNeXHpDb64XjDjp+SzajuE?=
 =?us-ascii?Q?FfDFfp03g3yHVMu7kEutr+cQYZATym4zxo/nfXI8dRXf7yQ+NI2wkHgULAyL?=
 =?us-ascii?Q?pWqBZL3GmrBmpyyn3ByYyJIpq/wKNiS/W4R4LH3sPjqDuroZdg0fszOPbFRb?=
 =?us-ascii?Q?VrMJaR2H/7+a5kMKT2YsgMmAaZK0YqPh9XY9ykyOIO0I9EZEBc7etCN3iLkB?=
 =?us-ascii?Q?zDaA+Wa/DHnhNioicSwcrXQMs4bBoZC04Qy9diqPJVbujcfCUcG2FI742IwK?=
 =?us-ascii?Q?SI4Jag5FUOcdvM5xscd/a+ycIxBviCo+2q0wapLJQbnwKXa3q7/PBvXzEqmL?=
 =?us-ascii?Q?5ZtzucrRFy49BrX9qrxX4iPN0Pk4Lk7RCgGZpab6CLRtvZV1PpaPy4q6bszA?=
 =?us-ascii?Q?j2VI6JPlbMSU5BVyYR07kgcFgnd3NDN5v104J2CQpTnp9LbmxD9cB+Mk0dNm?=
 =?us-ascii?Q?1v/qaVgsoRQyGvl3959IkctkOd8ykbysdA0ZcN1PJDyxING8MCp9k2KCJAvQ?=
 =?us-ascii?Q?dcg/kJQdIa++SMKxgZ0iq1loQppfjNtis2S5ygKDc9JLSM4olVLAYHx5c9xw?=
 =?us-ascii?Q?BGxGXZV3VAy1c3vZrOi9MdsDD2SIkVhJ3XIElKHEJ0wekzQz2B8cjk7L2950?=
 =?us-ascii?Q?KJXt+1NlRMfh+uHMW1A2oZEAhqq4CaO7oXP+/jWVaYd8bv8Ly2W4lrKAxkPM?=
 =?us-ascii?Q?3vxI/XkV6GojFaqSj+7V6aADqIHSjMz/efn44/3xoP7cuUsmq2wsUSKEm1nH?=
 =?us-ascii?Q?aEJDMs64kqrJhJOaGL5gtRicO4SnY8dv8yVRRL+/7A1xJTFgkpiGQ3nNYUKA?=
 =?us-ascii?Q?alVjpIUdhonUQhMplul0WzuGwgDC/FY8ddzT1qqCFHREQZXnF2PTgyHZDN7N?=
 =?us-ascii?Q?6hp+sbhvClEvcH502O5tqFdxu2l+n71eTwUnmEnzCtjdfbLOPyA6rgKu+omu?=
 =?us-ascii?Q?PWkCgbAl/4aJujSEHusLM+aHVa4dwm7+jBbu50Y+svacIKHqOdWtiggBWfat?=
 =?us-ascii?Q?u/1aKmNBKtOg9ahaUEzCsiY/cEmDpoWfXZDJYhvJtHc23tKSKhtWqzjjN42M?=
 =?us-ascii?Q?9dopAcxRcW7Adq9mkEEEx8+6/HmcZVtk2IXBVaAfCFMC4yBCAFpwNqQysGc2?=
 =?us-ascii?Q?1jZ9gYtanl5kM1rtU0GCy78pW+JG8EpgrvpjBbFQoel+aqKq2YQJPWYWd+bq?=
 =?us-ascii?Q?fX+dWE47Ej6XhcPqHwJEsz0ZvnA68EYmz6wvrGvmp52gSjVytXRu1EJ8E2E3?=
 =?us-ascii?Q?25hvhYJ8+1SQ5fYMdBACcP7xjMme0AhDFRCCgB8DfpvJ3wZMgN8R8Wze1dMb?=
 =?us-ascii?Q?fyH+6wtqRfiH57Q4KZYDInFkIK3sMkJboBZsoMROYpF+Dtp5Xn9sE2feFA8B?=
 =?us-ascii?Q?H+JRpf8n8oCHASJstiIsUkmL56ads/DVNz9lvOPEJLUX9T2qWHXzQ/C5+HkT?=
 =?us-ascii?Q?gvYGzvFa7tHupaSfP6W9pjU6WSfOyW679UqiLblwu8cC1VvST0Doei/jpxl5?=
 =?us-ascii?Q?vbvMq9QYMuNm/j3bODNQ8GriXMrF5kU8UAT8CpN1FiQTYPQQgFQC57ZE5P5X?=
 =?us-ascii?Q?e0B0yb2rkL+AlYswczX8tUR49CwU1QMgiZCzj444GL22nn1oahoYBCxyxcv0?=
 =?us-ascii?Q?aRoFvWV5aqa6VQHkQlw7KkkFvQ1Rf0Q1ZzakCynB5a5eADVZIBLrjlP8WMUU?=
 =?us-ascii?Q?bcvbiQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a3f5f-3919-46f9-8f18-08d9a8563443
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:37:24.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeLgenzqyPf1iGlDdSmh0uNB3eH+awmhVVFhQ+HmN0Jg1zyD0q0oOUjNZ8sdK1oXjrr/CYCxPukdgjkq5IrEbkohVpbIzxV82WfcVkIqByw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4601
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150086
X-Proofpoint-GUID: 4Y4Ca8cniD6Nn4x5e_uqwSvePXnIA0nG
X-Proofpoint-ORIG-GUID: 4Y4Ca8cniD6Nn4x5e_uqwSvePXnIA0nG
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-11-15 10:02:24 -0600, Brijesh Singh wrote:
> 
> 
> On 11/15/21 9:56 AM, Venu Busireddy wrote:
> ...
> 
> > > The series is based on tip/master
> > >    ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'
> > 
> > I am looking at
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7Cb83627413bf24921b15e08d9a8508a4a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725887206373140%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=pZvyYsg1crWmsLTpGO4amfYxgUnI9TUy414burkbcdY%3D&amp;reserved=0,
> > and I cannot find the commit ea79c24a30aa there. Am I looking at the
> > wrong tree?
> > 
> 
> Yes.
> 
> You should use the tip [1] tree .
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/

Same problem with tip.git too.

bash-4.2$ git remote -v
origin  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (fetch)
origin  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (push)
bash-4.2$ git branch
* master
bash-4.2$ git log --oneline | grep ea79c24a30aa
bash-4.2$

Still missing something?

Venu

