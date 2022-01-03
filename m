Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA7F48376C
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jan 2022 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiACTLH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 14:11:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27742 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236047AbiACTLF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 14:11:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203I2Xbn011677;
        Mon, 3 Jan 2022 19:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Skd1CCL88AHGdIA48Dd6BnvbEqgxvdzrOA3/2G9luhs=;
 b=rsHrh6471Oc1JBKX1lvb6Jn+PewJmTrrC84hYR0gRvMRb2W8sd96KciHFJ2nxqwPGMwc
 Wq09eS+rGmy7+kK20JIyMZK2kwhgRZljXPLNzNiTKk71PW8S988onSRqNVAvFr7FFh9i
 M28YI1vJrdssw2gIIJzxD5KKv/kKUT1QZfNoHnqhAmBedoU2JkQGypZHpScwtyBq1bNa
 xEctqRd3czzTM5EoeFgypgH5rt5DdMF/B6BejRyU2SYi19SYeigcxYeqd7AeEpPZfGcf
 cAbc3xNN/AdSbryqhz2tryBKmc/j1h/g6hGt5ffSPdCVlnafsft6nITAc2ibNXPZMHOv ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3daeuake4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 19:10:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203J1YCd034395;
        Mon, 3 Jan 2022 19:10:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3020.oracle.com with ESMTP id 3daes2nsbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 19:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmKkFC6TLzXuykTD8SD34VMpofaTzpvQWexY+xRjZW5WRo3YQRmZUxUAXCKvoZov0yqTQUGqu9CtkzD6VvCbPhyRbH4g5AaO2xJBgN/WB4rFoJarTIR2m8/WxsZhjay8u5fKCXsGXIbCRRc6cBZumLqCSoEVL+RrR29/dGeao8Nq6JutSJE0qsx4N4ahR8SMGnGlcgcE0ZbL4S+1hsyL2RwzstSrgqy9JJHUk2wIZ0Ar//A9gTkK+e2y5yZm7uY5tsVP7ddh2eZDe+D/cBKfW53DyjBCkgvDJPnDmrvgfJTQtqeyi6dnRFLBUHjHSZye4FN5NAkKnCV4jlK22d9vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skd1CCL88AHGdIA48Dd6BnvbEqgxvdzrOA3/2G9luhs=;
 b=LO1+/9B3CihVJABvitQT4zpxEyP8RraDZPrf7seE6AwtCtRzEdCChc2bvLeLuc73/VDgb//eQ3Kf7IkvaaBigzLVjvhcovN9mW9VjlfGQd/4+vE9OeyjhKcBTUwmUar7fSjJxtRdBZu/PoGl1MJDdPPglHKmoFRKb1iK2GpHF8uf0PlqUQzdHSNfMhGWvFnwhxV+NW1+AHcMW6Hs/zGGlP4tFj3M6TXhlQvakfLsjidpyrqIJs/90a+Gn91naFGenCnCg0PDV0l4fl/Ipnc0iBeoWE1m76sNKnoxzscaUrlkDhFqmTKQeuhQvAESMWyrUKH4pLxHeFG6usq5Tk6uLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Skd1CCL88AHGdIA48Dd6BnvbEqgxvdzrOA3/2G9luhs=;
 b=ZhAGjeW9qZM2mctV5MGCzT8W2B+DdmkZShWVGrtIifJWWk4O5KHu8FLCHur88fn6RMs/pM8mwjEn6vUVK9XO8qa20xI7U7t0eIpzZrcMdZ5n8oe49bJ03EjNz8U6US1j7ZU7jNveUkI4ozbiGRlJnVSSAG6xqrI/JUoZXzxywSo=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 19:10:33 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 19:10:33 +0000
Date:   Mon, 3 Jan 2022 13:10:24 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YdNKIOg+9LAaDDF6@dt>
References: <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
 <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic>
 <20211215201734.glq5gsle6crj25sf@amd.com>
 <YbpSX4/WGsXpX6n0@zn.tnic>
 <20211215212257.r4xisg2tyiwdeleh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215212257.r4xisg2tyiwdeleh@amd.com>
X-ClientProxiedBy: SA9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::22) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52798be1-695e-4852-c31f-08d9ceecb73d
X-MS-TrafficTypeDiagnostic: SA2PR10MB4665:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4665B888F702467B470DB36EE6499@SA2PR10MB4665.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NA1OmRtThdGIDygx46p4Acq4T8WrslHsO1RXihijBH7yNYWpGPkS4/BXGkXFuBNUvrQAhb/NHQOG/SD578B0WSguZc6W61945Pi7lm+iD+St9XwaaaSLRrJfRQ2BN/FWRdWu4h1IZBrAULcyGhtzVC57rXEVn7tD/HR3DFdUJ1ezaLGhtLAKCHiNpZAv10DjzpH9OSL5sfF3hFGkLjeyzSjBLF/2EbYj70G+DnA1vB930JFXQ/A/3e3157PRM5ye3e4P+H0TcD0b9fzr92FliKnJRjEIDcuVyT1DKZCqVbSClHfYnvHcrfXYiX1Snrcvwz8yhYx1oNhtkK22NOETJc4UA0C00jgTKTSZkSe1laoxhAGApE7dtEGd58ytmOPdqtuUfR5S8dGrGvdLpW3g+A+MxfIDRnLjPv1jDdN8HtkbrEdbUT1OszcMAx9bouBuxbBaLJ4RhJErGOTlyh/S46Fvo8MjwzPAdi4Nm6TS47QrL7EPDSwC+8QTY0Jg2aeOahjF2aTrlvHmjohh9TbmoSk/1tNkDCKRANmnQF3d4FBpITTRqt3ILTaiPpI9Z+LnoNo/J/EVmdBCOxqxSvO2XpKI9klyK65ghaR76cAShLZA+5AfW5ZAE0j5aaTs4U40l+waRHFooVpHo4m6nhpR4NphcmiTU54PLXCeFcu2dV7dnWwGxWiNy86Cwmk9381W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66556008)(6506007)(508600001)(33716001)(53546011)(26005)(4326008)(6486002)(186003)(4001150100001)(66946007)(66476007)(8936002)(6666004)(316002)(86362001)(54906003)(5660300002)(44832011)(83380400001)(6916009)(38100700002)(9686003)(6512007)(7416002)(7406005)(8676002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3il3QLVlX2Ar/9tnZzPPwz6Q6u01ylyAWZaJ4mKhhLaqu7xxwpwLSrzm0uJS?=
 =?us-ascii?Q?WIK60NOUvhtvkaoy9GJQfxxtxc2OHjXsQCiQ4reSxSTZ51bldqW5EkHOUsZ6?=
 =?us-ascii?Q?sKRfwWDyK53nBHKZi0z9R6zMlWCY0k93+1rhyeY49ETl/P7bDhQCzKwyiPyS?=
 =?us-ascii?Q?HnDJjMGI9FkALyV1WSnfr6QKr/v6mj6rIE626Q1j0nqf9wvZ1fW6W8B51ari?=
 =?us-ascii?Q?Hc3iTrG5lsnhdO/bzCOuQunI2/BX+APWDAl68ThDOpO8s0fapyxTPEFjWRX+?=
 =?us-ascii?Q?XrsN09+uniSp5gjyEAjm7x9Y+nkxmsQPciL4kbhLEmtvfdBc2weskNdX07sH?=
 =?us-ascii?Q?6pNQcZilljY4I02MRo6JWIbJsoNyUb5Verm9MJiI/PlI8jSj5f0Z3uTkdDJr?=
 =?us-ascii?Q?dt8aoE7JSaq3M/9wYwnxB966TzOs4M+4pwDbbdGovwEQFQntp/tZNo+fCVQp?=
 =?us-ascii?Q?S+1LdRVkCBm2teppl1EYi/mvgACgViOFrKo6D4bhsAg1O6u/BlGvqWgRhqHv?=
 =?us-ascii?Q?4fO7AYco6caRNar8QZeHDTpKa6/G020Y1Y6HOSJ1i/HiJdRlEnyH7/MkKfas?=
 =?us-ascii?Q?p+DebwMMlTZXn9wt5Jdh5LV+9FgOoCw1ZMkSrjWukvOs6y7eEQHDrRDRWLsr?=
 =?us-ascii?Q?Vr33zIGGElDnBp9xDJoWIrP3PbDKDYwSFqlABrE9CYDFKoqoeJ0a49eOPfNf?=
 =?us-ascii?Q?43JCkGLMcjxZWLi4Rs9VhZtrlb+BQ/sy3waRK3b+2pwOxJqNRZMi7oO8/+pZ?=
 =?us-ascii?Q?fiaLjCQikBYYWc+x/uD4sgBgXOO5CP6aXBEkNK0573HLDn9zxaqykcstnp6f?=
 =?us-ascii?Q?J7WMJ9MXcFfrEilBm/ma3XCIJRtEaKG8/GwMtS4uqBZnrMlLDrT1WYfTMLim?=
 =?us-ascii?Q?owyrSNY+3MwR4SQODuL4dnejY8fqu8eb+xi83Iag+DDSttaZ0yaFFGZXgl7B?=
 =?us-ascii?Q?P5E0uUhFYhwmF0tq6xGlZtsWX74s0rtBnoalpTFleq1izncH+j8oVUqu6Ztr?=
 =?us-ascii?Q?zKabEOZOoN2lNvYlI1h4Il/SVnmHMY8BXb8MggYlcF9cZdtw3yYeqn3GPLBr?=
 =?us-ascii?Q?L0ejVBJPjWsOLmCQfBGAMaO6pkwVdr/1bRY4iQMyuS02/EfoljSaP7l5K92a?=
 =?us-ascii?Q?w4aQSn+bbg5S8cfzffSGmu7mu4vhEkqrgOKBngAQlUFXbGQ6C3sMwNU+bCww?=
 =?us-ascii?Q?oF2PT+J716mZ+fj9vDw9yfkWpw1yne1hGTYeQxo/bZomlwZeNukLsHWKI1Lo?=
 =?us-ascii?Q?uK32x/zSUYGQffPLVyvHl8UEKJmSIXF6CB1s2Cs8niAPJ33IxpGtuLuDLwmv?=
 =?us-ascii?Q?vnDfgHXMloUwzsDk495tLa4toDng2xQN0vlJmawRu4fuSp1un3YyxKtuCtKe?=
 =?us-ascii?Q?42FLA2GvRXzFOUa3C7tLQAFESwKACYUrDcIc7KycOc0C+0BIxwlI8/Zh0QoJ?=
 =?us-ascii?Q?SjJ5t+bVlC9zC86iCq7ZXoPaIuoE0Y8vrh1YCKgRhv3lMs6WKXskeBhpRyzK?=
 =?us-ascii?Q?VM0qDDDV3C0g6Odgiym3iwoyWaGHcX2qUsXHxrAGHEqVs7avzZqkQwCcjDYE?=
 =?us-ascii?Q?dVDbYsbNCGCoTFPRCsNF5+e9AH9cnobQAtx3WUX4e32yt9e4mekjHj2lk/Q2?=
 =?us-ascii?Q?pHTn3e0Rbr1xut8KxM4bt5tk2nw/ylpTr9pTOieq6Jx94p84oWfJZKGyJ3TT?=
 =?us-ascii?Q?qiVz5A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52798be1-695e-4852-c31f-08d9ceecb73d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 19:10:33.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HW3hF8ee46AfP1wsdZwHTqch+EtNjEHl2gTS5TXzKmj0SM1TLY+y2wQvOmByf9iclauIXaDf0xeAqEaCRNHEAVBGet96SHqTysF4C9U1f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030130
X-Proofpoint-GUID: URQ3l__zwHDgNa7gzWIpFRiBx5X2xtwO
X-Proofpoint-ORIG-GUID: URQ3l__zwHDgNa7gzWIpFRiBx5X2xtwO
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-15 15:22:57 -0600, Michael Roth wrote:
> On Wed, Dec 15, 2021 at 09:38:55PM +0100, Borislav Petkov wrote:
> > 
> > But it is hard to discuss anything without patches so we can continue
> > the topic with concrete patches. But this unification is not
> > super-pressing so it can go ontop of the SNP pile.
> 
> Yah, it's all theoretical at this point. Didn't mean to derail things
> though. I mainly brought it up to suggest that Venu's original approach of
> returning the encryption bit via a pointer argument might make it easier to
> expand it for other purposes in the future, and that naming it for that
> future purpose might encourage future developers to focus their efforts
> there instead of potentially re-introducing duplicate code.
> 
> But either way it's simple enough to rework things when we actually
> cross that bridge. So totally fine with saving all of this as a future
> follow-up, or picking up either of Venu's patches for now if you'd still
> prefer.

So, what is the consensus? Do you want me to submit a patch after the
SNP changes go upstream? Or, do you want to roll in one of the patches
that I posted earlier?

Venu

> 
