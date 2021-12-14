Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA654749F5
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 18:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhLNRrD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Dec 2021 12:47:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55258 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236716AbhLNRq7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Dec 2021 12:46:59 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEGXwXK002477;
        Tue, 14 Dec 2021 17:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2yucvMLXAlPfqaPPACj8nqVILYA+Q5Iu3wONe7D/IEk=;
 b=cWbh96lAm1KZu8vJ8pwAtpP188zFwIct9nDRmT/Z14LtsTKNM92XuIt2zjAFBTqbULbz
 UkFSCdSPAsJKueg3AcjsYq9Vi7LhWmJI92tPHTFUpgi7nDBNo9dyeeNCKgDvMOXkZAla
 cRG3mdxDsWvkCUsPTyyQDsmKpNBiRfKlVXQBr886wkunkNZ/oOQ3TLuGob4PavwqMMnf
 ccQEWudFP0Bvq9fVYxdRxc/ulGtTx/MD8GwM8AOFC3esuIzrcz+LdeNMSu0im77Dg+32
 84FcMZEIaR4d7AvZkgjjSAu+D9bNuJQUsQIbesibL/YV+K0KUB7mfK+QFWTvAgvZTaZR cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u47k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 17:46:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BEHZqMF090213;
        Tue, 14 Dec 2021 17:46:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3cvh3xr7hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 17:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNUwGeDvFvslLLFpa+ePsUrgKAkVaQfRg7tb7v6dtCfJKh57m68T1A2x58x90pjr7AConG91/w+mZCOyhF4zXzlCTzs6sH0Wxm5aPykYmpmFUuPUXVl0unoUIHvm1xeJKYowp2uuiTp4+1gYetGt1cv1ml8wjSCBKyUztP5aj1lByr6jrdBmEdUKEJ8lWHHoK56kdUZZ60anzJdKrqJsFf3HR/bts6sEjN0yMA4+Pi8bLknzK0iraIniXojvfpWylxgvUst1NhQfTvx853JDLfQCPWrMp+clnn6gjMeekCwzUmllmxKu65/lFyYBr/iTyhQ/ZxpqrP7GRvK8q/ajGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yucvMLXAlPfqaPPACj8nqVILYA+Q5Iu3wONe7D/IEk=;
 b=AQGPrO7j0pYy8dshN1gB+ZsbRgmxTgZkpPLBynGUBWGik8yRQoTqLvW+yK0jcCERU7zeZMfiXCDbap0E/KBpslFj91f4bhhNx/4LWUoCeHlATKj4UUbF0V7mUS0agUApAjJENuH1Sj0VBB6ybRyvUxRQBu0qXHU0TUeUcduNGV65uW9Ff86MZ4jz7h4smsjGIAYgBUmXONgmMH7We1bmz2RbHgPrc5ln8+hyxPSOEy4S3Ob4SWV/3jOq5urEg5ICNhv9CN+XWObv4DDJr6BMeto2EUs+BLyewB91i0QVOpWwO1yWPT/dQ/Eh7jeyYLCLVm7AkertrDfoGIHG5l448A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yucvMLXAlPfqaPPACj8nqVILYA+Q5Iu3wONe7D/IEk=;
 b=S242jw89YfrhWA2xlvafP2RCfotsq9+t0jim5K4DhVMsf/erN6JtzAaZGpOft+L6rOL3ifj4Zuks7eMpEsYfRpdgYg+wwhyIEwBIAzXr60oP4qwCkazDCU8FRKI16qy0ISQw12XciOGhkBrWQsnk2m7aoAmDzHVgpvxsy3akN0o=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:1e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 17:46:23 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 17:46:23 +0000
Date:   Tue, 14 Dec 2021 11:46:14 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YbjYZtXlbRdUznUO@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbecS4Py2hAPBrTD@zn.tnic>
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 914dbb89-8021-4252-b206-08d9bf29a4b3
X-MS-TrafficTypeDiagnostic: SN4PR10MB5541:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5541B0EA409709ADDA20C3A0E6759@SN4PR10MB5541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8AcnTzwhczZ0cWBwgFLcrRPSgHurm0UM1kCrFvpmiPeEs2dhEs+zacd0G6b+Gb82n2+7/KO0I0jTx/gKpdV+Hf28KkHSe5knsC+oYXcU+/HAEXDfPS8lOXWetDiZb0pf1kuYZ1of4TvQYGqFff7mpzpR9tNXmQwbBgjj7Kjc8HL4kS8T97bGS/DfTQRULBFd5v3TkM0NunivPP2MJp91ps82oQCEZYncGuin9RMqXqTfE7LFSribVryoISLZFq9UcZDWAlwoCL7QEnNZRdRqVQ4N2onEtvNmvco0jfQdev2HgCItWEKKX8A1Qt3xiY/zh3yTtcn5W17uYi1ToVmHdQyGvGwxiLZGVAm5buyUgjm79b6wrYQ033LjnEv2kbXf63FiRmo/lSF1URwuAWNlu4Mx040PYSC/rnDRjskwZC6oIxxZqabExviLcMrGGTyA9GsRQheygvxmf4mSIv8YawvExCufZXUyd7c3Q2yZHwKxU52U08cgiYiealjTcsXZjGbMChi5VqytFtjV/3rAOmRwb6fa/ap7Tjoj2RvmpKy+8CCAVzcqluvOIsEnAEifCq7bQJ4JnRtIR5SuzvZaAexkwMhTqvzbx9rHuVR2RvfH90Pda638mqgJXtIzr93obqgC8Fgm3jN8Nz69dx+cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(26005)(4744005)(508600001)(186003)(5660300002)(6916009)(2906002)(38100700002)(316002)(33716001)(86362001)(53546011)(7406005)(6666004)(66476007)(4326008)(8936002)(4001150100001)(66946007)(6512007)(9686003)(8676002)(66556008)(44832011)(6506007)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ujqC7h2AhESVO/P/jOMyRLfqLlPYqq/rLXqbp2rUjRl5/h1NiyqbwMlwhip7?=
 =?us-ascii?Q?1kr39/eT0H94fMQy7S0Ytcb9m3TqYpi9mjR584MLJYAdbAujHQP82Htc6Oj4?=
 =?us-ascii?Q?ki9k9OAxz+3J4STRBGrIP3SE/W/myW0Gj/dgg/RsTEhKwCI28FfOOYi4ccOS?=
 =?us-ascii?Q?xCKn8E+WBXSs6gWotB1U+DIGJGVHl0AIgYyr1dgwceaINmZeA76474dMyAz+?=
 =?us-ascii?Q?ukHKMAivva0dzlta/E15uW5ZZsZFyZ4ipYsBhlmFD21Eu/YRiusy1xq69hbQ?=
 =?us-ascii?Q?T5SWeDMjABPoDD5EXrUMnSZYzT23Sz419Rz72k6iDNBkqWl0XrsjBWujcQHY?=
 =?us-ascii?Q?BSRvQYFwkIs5jeaYb1Z0p3XHPtu0Gu33Rtj3UoEoNqg2GRYNplB0CBpKce8e?=
 =?us-ascii?Q?lWDvLWohBF7MoX3UteXgi6eLfYe/0qNmTaaIamyECJ/WjquP5/jVud+7Frg+?=
 =?us-ascii?Q?KG4gyH5P92423lynL17NUULx4upHDqT6CuMv5i7xooh4mkY2HMHBxyc2lDyH?=
 =?us-ascii?Q?D9Evz7gdaV8u9W9rtNptxXjiMnnRiIiyGZedOCSb6ir5EkY+FLu50QUT1i1c?=
 =?us-ascii?Q?iMkU+jUmU+rvhTyh4sILDoV7pfCeIKqHzH57xfRsqd/IkY+pOn4xW6u5CbiZ?=
 =?us-ascii?Q?sZfBbhcUHaaHLtCVGT2WDUvQTbpKAmmwHPrQQitaN/uqrim+dK9q9rxDasrH?=
 =?us-ascii?Q?a+JCudswDZgzTvOooYivNmsVFQaRlJtVhciMyAYSusnws0pYV85Get9Kh7Mz?=
 =?us-ascii?Q?bdWYfJ/gn3he6GuXvIJfGyhRZA9JZv5U+GOD58h9fM3KG1u1Y6FLwITj7Lka?=
 =?us-ascii?Q?L97Rx023uiC/TvmiQ/WVbt5lBlJq5Aw42Et43Qble3wmc/7SiInw2dcW2XcY?=
 =?us-ascii?Q?UZkbZXQYU7yyZ3but4RBzlKfvKzirAGx3zNmyQr0i6XRgBdhjUYnG30aEv1/?=
 =?us-ascii?Q?z7u4rUyJshmrSOefv2/esn/yzbSpY9n4EZwsfX3YqdG6iyM9Vq5wEGUPwGP9?=
 =?us-ascii?Q?HheNcyT1yJKEWAI7Xor8yADEIXQ1dQnI/sTWwdlzapyW8OZceilHyKENdmZB?=
 =?us-ascii?Q?PHe0PLLkCxzG4YBaCcbJP2y7gp7CuQQrPYWvpAQndVBAs/ZY3ySZvD/HAovw?=
 =?us-ascii?Q?umDN7je09L7S5CvWlTWU6tDJd7425NWZzpUpBdLQ22rg2adPPxVDUb1TVPbj?=
 =?us-ascii?Q?lqYeJT37I93eDw4J8SJa4IqA4EsSiSfX33cfamakQDYaOY88eu14w5xdq7Xi?=
 =?us-ascii?Q?mVcwTHeW0PPMppVssCGUMYhZppeYR1D1xP/IY5Q7XcUjz23sAtpaR9RAYzcz?=
 =?us-ascii?Q?AQ4PWWbxRcsuH35aaHE50QtsCe2vYVScMDVcmD7UzH5fcX3W7Rk51WE1lcWE?=
 =?us-ascii?Q?0RA5zDi0Ba7uAMqIkv8PUazJwt0Wo+3Qr6M3whSNvHeLlQ8z1A32HSpTRYFF?=
 =?us-ascii?Q?/ktYNxPBgjr2+JE4vUznMh72bJ27LAP0gkq1iKkQdfoNLU0KnSDQAYNZrPjq?=
 =?us-ascii?Q?MuuJ+h97VSKS4YknL8K6MgYtKK/ktApml7GojYdoHt8l8n7l7JoJKZKmPPhg?=
 =?us-ascii?Q?SiL3G0LvdIx3Zsj+i58A2jTn/rEPr9zWgS10Cz5hW3PP07kt8nCOVwwuJgyn?=
 =?us-ascii?Q?VQ8D2sf71GpLoGUK4Ok/vvfG6z+HI2yk+msfBzloSfYLQ3NtQvCTaiWYr4T7?=
 =?us-ascii?Q?QSh/qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914dbb89-8021-4252-b206-08d9bf29a4b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 17:46:22.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq+fOoT2mJx/3BEuNAfWxk8Y5EG+vaSB+75Rf6SyRmzkX+7gsUr6iUEojYN/y2gCf4EWQ1pRjziUGi0Usdc5hHgQOF68yCfj/LQtQZ/wVJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=637 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140096
X-Proofpoint-ORIG-GUID: EVmatg_d9AehE6WKRuPeyUvBLYJzolhk
X-Proofpoint-GUID: EVmatg_d9AehE6WKRuPeyUvBLYJzolhk
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-13 20:17:31 +0100, Borislav Petkov wrote:
> On Mon, Dec 13, 2021 at 01:09:19PM -0600, Venu Busireddy wrote:
> > I made this suggestion while reviewing v7 too, but it appears that it
> > fell through the cracks. Most of the code in sev_enable() is duplicated
> > from sme_enable(). Wouldn't it be better to put all that common code
> > in a different function, and call that function from sme_enable()
> > and sev_enable()?
> 
> How about you look where both functions are defined? Which kernel stages?

What I am suggesting should not have anything to do with the boot stage
of the kernel.

For example, both these functions call native_cpuid(), which is declared
as an inline function. I am merely suggesting to do something similar
to avoid the code duplication.

Venu

