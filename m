Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E9486AF5
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 21:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243605AbiAFURD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 15:17:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2360 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230045AbiAFURC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 15:17:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTAWI031899;
        Thu, 6 Jan 2022 20:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=0oVWv0uOUySyvYN8tyF/xWRsEuU9lKTw8KD4xMGA4ug=;
 b=qL+yxkhDw5KNXa26sbIRbVOOvDDhMmrvFRjS92wlBlA2V8aX3bfyqFIRVEcEFjsE8fs+
 hGnOTAtHHKSAmU8wU5m7V7jK0d5DjZ4ZZm9WBReh5UfYDaFEULBaLdAuBWq6y2AeTdk6
 ktZssb/pfgXuV9PS7TbiHHR4awO/Y3OY1qG0XvZZoFXBZ5Y/8CvV7VZGkU+WbSVGfz8j
 hU9SkgISmf8afJvm04/fhc2JkyrgsS8xvv+FMiUQ8lVJ7L4J03S849agA0Nbdt3fl974
 EpRs15IbbJLLtMfDYup2DNFzJ5fTNz6N6sPPyO1/SsX1l2gh+xhzO26lAmmGkxATNqmq Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v90c32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:16:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206KFiYD018227;
        Thu, 6 Jan 2022 20:16:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by aserp3020.oracle.com with ESMTP id 3de4vv80t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:16:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHp+9CG8jtAbf/2tY6frttSW/2wwj1Nys/XmomOUQkJNVX5hDnUbC+tnvnQAymUJUze0gPa/HbqOc1VMySVPRZ15f6Vy1MkRKzc8PjadKFzvgn4pq8OyXXFUDlZ3zHxTdlSYbJgCLawjTVzsYlqL9bec3xuKKubwcL38QeIsSNR9EUWSCnX9QLGmW779+91SOERmjTN+xWG04VBjNwv6bAWjeKTI8iqBDXH+mJMRIyr8S2DcKnCOOA5NL/JQAHJ99Jmt61WaCImX+4V+FreuK3SU8SKw45yxMxQqQ18JfXHrhVdaG5pvWpLmLRsj/Oa/6DHADc8263EXL82+39V3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9MQe+oOSsM5R/xUs867/jVWBaOfr2C2LUSIk3CLuyc=;
 b=Nnn7Zdd5G3dbsgXjj8bQSpzv8/v5ZXPdMINlzvpZe3/pfvE753+q5YfI6IEsXdmTVIfZh9qYz96BLhmoq04gaCAZxSiWRFAx3trL3+Gd2UaTAli2SB/YgBoTELNcMpJSgVfIjz+YCX1fdPHGX1V3rSOlYYEZItmyFhDBoHCPQvUyd4cHuwHzl71KERA4Tt9sNVj5zD5MmMzOdjiB2ImOhclAeiSfHYAjiH+w3VOk0kJ5HalKcKhvu5akk+n2Q6mo3JCBKvxovB1HNz6vqTDp6+KUr/uwK9o7LgaEDuUeZd/F4YWf43U9v7gqcyWJpolSMxp8Qd7HmiTRMSeRd+eNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9MQe+oOSsM5R/xUs867/jVWBaOfr2C2LUSIk3CLuyc=;
 b=hfGd/KWD35hvYM5PhM571bnYxdIqUa1H0E+QcstKHfJaVkgiqB58GlGqZKfRxqrLe/jQE8q2cWEAvP3qnbNQmdKdtY9BZzk3EOICrbcJmfWcn/ET2aoBaeGsk4XCXDcgkERf6hjNyAy0++umI3BNXf30rgUodVkPf4/aIO5F7qY=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 20:16:23 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 20:16:23 +0000
Date:   Thu, 6 Jan 2022 14:16:14 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
Message-ID: <YddODkUvhbWbhS3/@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com>
 <YdSKQKSTS83cRzGZ@dt>
 <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
 <acba0832-9b11-c93d-7903-fff33f740605@intel.com>
 <444b6c78-c4d3-f49c-6579-bd28ae32ca3c@amd.com>
 <YdcpnHrRoJJFWWel@dt>
 <bf226dc6-4aef-b7c2-342d-0167362272ea@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf226dc6-4aef-b7c2-342d-0167362272ea@amd.com>
X-ClientProxiedBy: SN2PR01CA0042.prod.exchangelabs.com (2603:10b6:804:2::52)
 To SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74835bd8-7f7e-448d-d5fa-08d9d151692d
X-MS-TrafficTypeDiagnostic: SA2PR10MB4538:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4538964273FAE77728FAC5FCE64C9@SA2PR10MB4538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azQm77ij/C5wO+0CZBuzXJH1q5pFsMKDbILE/q0NVz6HScE+RWC1o7G2kUvooEqtfVRDSmoHqGJDlvjKz5NxFnIDm7sFY+0B1O8cqAeu70c2H/dSSbireW1o90gCav4TXLJP6Y+9jVzNWhlDeTR8r6cVSAIuIOee12cOWeUMyRqCv+ocDdz9Mz/ZoHI/ERGSaZKSEI/R+hQvuYCbulpJj6cFsMnBpqZxwCHhT6EhVbT85bnqc13niqzDOzpbtSjCYKK7bK3+AXjj8K3EH/JKQKtUzlmh+x8SsJJYDO5NEeYrgAZGbagyVoQ8k6ocoyXw53mPo21HS7ha9727aA/ZFUVEDDbA61DcBtXVXdzL3O9AKdpBduno72W0/ykzMJAsIsqPohY++SdIa44vriRAezWuYS+94CgAkVJRpBT52dnNo15oO2m4pkK+bEN43A/o18TRgKqPosm/WYMYYv6MhjBk7YJQc+Uk65uj/dN9L99Sh21K4LQZwxvKZasaWEf0/UaM60L3B6zLFr120GDpd091jg9Upcp4zhA+DnStFO82dewb2Zan3tON58vrHcqeqoT4d9utgptPFcDhavODQwSNQUbEtEsVdZW0xskcFKztTjDw3vaY+hslV/Sl6oZ56/Fg+29q2B/T4ZDBmISpSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(33716001)(5660300002)(316002)(66476007)(4326008)(6916009)(8676002)(508600001)(66946007)(53546011)(186003)(44832011)(2906002)(6666004)(66556008)(6486002)(26005)(6506007)(38100700002)(9686003)(6512007)(54906003)(7416002)(7406005)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0bN+LCE+xhx9kKzRy2/heSDfxpm3pVcjljzC4VE4dU/pulLZCaSltYJe4D?=
 =?iso-8859-1?Q?FyWn0YWmn7WOpoBB5HCMisOdocoWiBxDJc9YfjNWbxzjQzTd8MbYqMX/pi?=
 =?iso-8859-1?Q?3lSpaQq0FwqVvS44ZpSRR9pPWE4B3GuEqyNkq5OWJdyTb3smX1+JvFjmMt?=
 =?iso-8859-1?Q?Mwo3rgoQN0ONuPxAfUVanbkGf5oMxcfMh3K1G1l/zt2YTjsPwlBxGmmHuo?=
 =?iso-8859-1?Q?VQ0RJ9OJdgR7+azKg7gRnu9seTZZAL2w7StxxmQQZ5rmj7BoDLkspebGit?=
 =?iso-8859-1?Q?w8Kq3l99rmQ4aSCX+/72pFkMMoGtXmFNRcFopNS1t+HCMOkju8nUttlDA1?=
 =?iso-8859-1?Q?4w/5lxchsn6rrDDuMUEhynYBvUyJgGHIy794mrWHVQTCkAOM1raFfClQmh?=
 =?iso-8859-1?Q?HVlcMvfDJ9H2a9Q6UrifLXvabuyDCMa0NKJ1/4ZB2rZ+eitH1YLPxsoGHQ?=
 =?iso-8859-1?Q?Q4b787v0NDpROq3EC3ktXG9mz3kFpet8Ko54MkXx37p2ly010LAZIwn3i7?=
 =?iso-8859-1?Q?zB2G7DdM2+6Krm4kBllTYtcrDX+jAstLyOLCyDJleeWT0TZ7B/PdEaDcWd?=
 =?iso-8859-1?Q?W4lNx5oG5n/6sWjpPweTlOVdT/WsjC4jUWjUJq9lqyI5WlCcgabarvMxMC?=
 =?iso-8859-1?Q?5E7P5DWmjGmyGEHGu2mKAcQdObCCqAeAnENes8ZWwsrCrsQobPI8DH6tpq?=
 =?iso-8859-1?Q?8QVPdGH8aOHitLzl+ZSce2Ha1bXSxpDaf6uVyckB6cLEKZNct6ls8Vu2Un?=
 =?iso-8859-1?Q?LRF5oEE31n7MSiJmJunPI4Yej1FpubUu2QLJSPIOM39aj96ILpiI1Zmkt3?=
 =?iso-8859-1?Q?hbMKiljftgmyhR3fRupozgqpAYtvxmZBmqwPmm5GlMC+tNZxJDS5EGq08B?=
 =?iso-8859-1?Q?7md2McR0Ra97hAKULnF1ZoCIjfAUXtNiyvECC82swWAiEy6eCuf42ZNk5r?=
 =?iso-8859-1?Q?7Ui1tJhsXLhJj9TcyWDrGgKzA4ddTza5OFtTTua2DfIvowJLKGF2CCl6ZG?=
 =?iso-8859-1?Q?YX6rUoJGHCy0LFs6hY6ODSCDj7L2Th4c37fDNRmOFjMy5Qf0n+hqRxqDhR?=
 =?iso-8859-1?Q?/I5LydYRuUAeqLXIuDv0ijwPYrvYvUMuIYogXTMMXrKCwPk40QnXUDDwO7?=
 =?iso-8859-1?Q?Og9YO6BfhxV8MNxPVgfKB1Jhk2bT8Kc/jNNAaNDf3/zqnvhYiI9cqq1fV+?=
 =?iso-8859-1?Q?4TNUHAlW7KIGA17hxXVCXKmAqhsEYAyJRYmBOxLmra9e8aWzMF9ZipBB4O?=
 =?iso-8859-1?Q?5rEWkStPHiiLcK2yRZC/xxNyj6kkGiOkdq1WCjHAbxEus8cqhDY2mSYtxO?=
 =?iso-8859-1?Q?QdybdNwLWyP+wdcheLhj4thK0a7PZ5xS3QzALiMnJPEx7PmGx/WuLRgWPq?=
 =?iso-8859-1?Q?/xtRGMhwNHOfYfkM4XZLV+qXyDuPiLRPnrOEwrBOmBA4izK4I7B4SqcP23?=
 =?iso-8859-1?Q?5ONWij6NhtCd3zv6GgmfpM74LWr/ytmYZ2wciSSZqWsUht4sK4pEx+m19V?=
 =?iso-8859-1?Q?FtU9kxFwa3rOTthhPsirL/SjQBbV9cDv2QCO3JhbrKVoqlcsilAh/J3kBo?=
 =?iso-8859-1?Q?MfEgP0GJ51LvYwnDVtwR2ylTmFbQP8zoji2llJSjXqnUsEp4djIP6PjOdg?=
 =?iso-8859-1?Q?jUG7GOYr3wVX96Bvf55l0mr3Yod0ZlKylMD47groISeCps0o3X6hDOa4ry?=
 =?iso-8859-1?Q?T5tQ2zVw/guFq4LuEcmezGQztBqHPoi66pSYNR7GQtFianGQLZXXYoyNA+?=
 =?iso-8859-1?Q?ZBog=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74835bd8-7f7e-448d-d5fa-08d9d151692d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 20:16:23.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+Z9t/J21TZgfmUR4cIyVpGoQM2f/RxY5AMrhBoH7b/bpvqq92xkEhYd3eZqa9ceSbrjQeC4710LD/r4ZlQmZAj1Ks08lOA4XMzDKJvEX6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060128
X-Proofpoint-GUID: Ry7lmRHFKzyc3CqFEqePQR18BlOK-9Z1
X-Proofpoint-ORIG-GUID: Ry7lmRHFKzyc3CqFEqePQR18BlOK-9Z1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-01-06 13:06:13 -0600, Tom Lendacky wrote:
> On 1/6/22 11:40 AM, Venu Busireddy wrote:
> > On 2022-01-05 15:39:22 -0600, Brijesh Singh wrote:
> > > 
> > > 
> > > On 1/5/22 2:27 PM, Dave Hansen wrote:
> > > > On 1/5/22 11:52, Brijesh Singh wrote:
> > > > > > >            for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> > > > > > > +            /*
> > > > > > > +             * When SEV-SNP is active then transition the
> > > > > > > page to shared in the RMP
> > > > > > > +             * table so that it is consistent with the page
> > > > > > > table attribute change.
> > > > > > > +             */
> > > > > > > +            early_snp_set_memory_shared(__pa(vaddr),
> > > > > > > __pa(vaddr), PTRS_PER_PMD);
> > > > > > 
> > > > > > Shouldn't the first argument be vaddr as below?
> > > > > 
> > > > > Nope, sme_postprocess_startup() is called while we are fixing the
> > > > > initial page table and running with identity mapping (so va == pa).
> > > > 
> > > > I'm not sure I've ever seen a line of code that wanted a comment so badly.
> > > 
> > > The early_snp_set_memory_shared() call the PVALIDATE instruction to clear
> > > the validated bit from the BSS region. The PVALIDATE instruction needs a
> > > virtual address, so we need to use the identity mapped virtual address so
> > > that PVALIDATE can clear the validated bit. I will add more comments to
> > > clarify it.
> > 
> > Looking forward to see your final comments explaining this. I can't
> > still follow why, when PVALIDATE needs the virtual address, we are doing
> > a __pa() on the vaddr.
> 
> It's because of the phase of booting that the kernel is in. At this point,
> the kernel is running in identity mapped mode (VA == PA). The
> __start_bss_decrypted address is a regular kernel address, e.g. for the
> kernel I'm on it is 0xffffffffa7600000. Since the PVALIDATE instruction
> requires a valid virtual address, the code needs to perform a __pa() against
> __start_bss_decrypted to get the identity mapped virtual address that is
> currently in place.

Perhaps  my confusion stems from the fact that __pa(x) is defined either
as "((unsigned long ) (x))" (for the cases where paddr and vaddr are
same), or as "__phys_addr((unsigned long )(x))", where a vaddr needs to
be converted to a paddr. If the paddr and vaddr are same in our case,
what exactly is the _pa(vaddr) doing to the vaddr?

Venu
