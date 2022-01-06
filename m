Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D7486B48
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbiAFUhW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 15:37:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11324 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235328AbiAFUhV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 15:37:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTABb031900;
        Thu, 6 Jan 2022 20:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XIoy5bBGM+SOZf31DzuuI1/aw6PYxSC34Jm94z4l5gg=;
 b=TAwtEvVwe044HVIj2mJmiob3IJC4FmqTlLGavRettm5pOPR0EgASPiPeMtIge7q1ekxy
 vo/EDJID/Zdv+OuwGTelv6yM6BWMFUEGIYWQvcvNVx7EXV7yBLXwzIHHRhwC9eI3XTix
 bEZ8W/fRXMpYt/BfPGBEJiZdYYSsjCpRZhvXOf5DI87WIzOM7qIBoQf1VEPB1IQVWhlv
 VXoqWZz3SOkZ1RjQgtJ58tvGT3rL/5tbGu7zgUmmCYamcQvxQVaWApu45RjkCyFR1eOM
 ZoW/291PDxhvRO0MIhK048cSn4vDjBeuzYkKVqrTP3OrGFN8xMcU5If6VXmr3iVovljd ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v90dwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:36:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206KZj8O086354;
        Thu, 6 Jan 2022 20:36:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3de4vv8mke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 20:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H39qqxfsfnLlXjDpKT4QfhUSGr/FntEdJUWmZQhaxQrVSxTgHM+EZsrPAH4imbU8QMrJCbkTPwXcpep6zmqr5ss5L4vO32PjcAcmcTT/HpNbesCGWTP4kaz8NNPP4Ga9yvpqYM4JgKsGiH4cuS++QkLodX6CiTVxH0N44D3Ex7FdNBSJsynXCCU0JYrtCrUZzrcyAvFg9JxuTZn8XRupXdwDqi8SZdE9s4WR1CXnfY5wq6lT/aSWWLvikjd9L9tCvHxwk+ZjVIAsszW8XTLh6WUDM7FUDKaubuuQbaYKVEwXfAzixp6T0A7C4mvqBu6o6a9QMtEHwWKZXjV3nzQANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIoy5bBGM+SOZf31DzuuI1/aw6PYxSC34Jm94z4l5gg=;
 b=kSkJQszyPr6ABuzUCE/MWmYEvZrUITapO47DWdCqs/wkA8f+HXEn55rS7GCNqW9DJKcBV1Olqg/HdNbK01hud9XzKuNQHiCCdMKNkJjXrWJjyXimS/uPdwAvyjrxBaNr3jLFObRJRgMauIUF2tOwVGgHi5Lo4hpjh1V0xE4D5fCDhdlQqhJEgUwsNOBUUagfEJssniDN/JhvcO6gu95/0eeeprKOWHmBxlbz1A/56bLWSzTezaOjoqYBD77RiRdUOMEha5AOde+xTS/80ylWU023wGKgMX29stYre0ARI6Ase0g3Mx1IR2NYT3QdY/1Lf3AOKY/o0sMHlrBz82ZfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIoy5bBGM+SOZf31DzuuI1/aw6PYxSC34Jm94z4l5gg=;
 b=dt+IAKCX0+rMWFbrOuHd+a7Qal6K2kwJmOGc5tKuPchs/9IiNSGe1OBsn5cea2gt8v71Pfj+QqFt4duTyNBpiV0sPGWSSc/GeszzuRnmqXs5aqF+mjzQV1UYlQKn8fyG9cVA+vXBgrCkEWxpC9HMgOpPi6qTzPLZe7VgmEF81Xk=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 20:36:49 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 20:36:49 +0000
Date:   Thu, 6 Jan 2022 14:36:37 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Michael Roth <michael.roth@amd.com>
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 22/40] x86/sev: move MSR-based VMGEXITs for CPUID to
 helper
Message-ID: <YddS1dGYawOCqfVg@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-23-brijesh.singh@amd.com>
 <Ydc3Lbx2O00an/xj@dt>
 <20220106202135.in72kejithub33s6@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106202135.in72kejithub33s6@amd.com>
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afc37bdd-2d7e-4f75-f6dc-08d9d1544385
X-MS-TrafficTypeDiagnostic: SA2PR10MB4665:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4665BE0940E08AF2E89152BDE64C9@SA2PR10MB4665.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyJVbcfg8A/Dxlz8piBjtV3n5ZvDfXDpaZu5LqYOv8hYz6HJkDLNcWVt7kbKJC3lHrBxdKOG4SInxj6mRU0RFsPf/7CBYpsr8Dmvrg5WpRlDUOeL42RzLTOTDzPO+wJueTPx4Z0uoodiPuLf92xjyFwRrvdM+qe9sov1PlHwoJqfTeweTNkSNTr8RZ17/FPk3qGfNQJgkz+s/hKpriGWBUjE1YO/JSrd68/O74BTYDRzhV3k7GDSNnKSY1NSZQLW7NihFn5k4a/cD8Yof5kTAH6+qlp+ZXS6NRMb0zpGgyUEI4Jz+qER4Zv6HyV2UXxdQHuEB0nXWVI+HQxJRL2oGqrIGtIyTtnWA3/eM2c2uOjVgKU+byJp6gSgbm3+E9D3WcPfoXNH8InpEELF3aPPwI4aP+Kg/XZF1G0MNmCI6v8/eGgP3/6Z0w6u4Q7bjpJetsEvvilBX8625SZvtkwrDe1upg5l1mbdoOPjQJwaQqxqfIMvpuXqsLFm7H5Zix9B/5dSuz+6FkNBRRrGdarpBK6xGv7jUTKDpRfwyz7Z0lYgu6yqCjs+APYeX+GoXyFAkVwAERH4iG4GcU9ZBvRK4i7y5XK0w3nwFcovQlSDXztVdgAAnO+KObh3dkogeXso66PCUWj6fz/K9PwjcDshzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(2906002)(7406005)(7416002)(53546011)(83380400001)(26005)(6666004)(6916009)(38100700002)(508600001)(44832011)(8936002)(6506007)(316002)(9686003)(6512007)(33716001)(4001150100001)(8676002)(4326008)(66556008)(186003)(5660300002)(54906003)(66476007)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rx3fGJOQ/Zv347NG7HDHnb3rAFp3uS9U41ue+6HmGf41Rqrm66FDytLMttjY?=
 =?us-ascii?Q?7TWW7FCVC+7OWR5+0++MBePboBpoVv2j/xNJDrudwKUfHJ3YIDwyIXVbVsWM?=
 =?us-ascii?Q?6VwXqfnrZ2PMC/GLD5liekNccZKJ8OMAjfE8hdTVHZIV6NsJgyGyxmoWIdyn?=
 =?us-ascii?Q?DK21SlvQdoteTBWPm6ysk+j+SJMQTcTAnJVYv8X20TWLNezmbstIO2eYOfIH?=
 =?us-ascii?Q?TAvNL9Va6P8B92VDqBdw+PZ3pibYfNpGs7oKMrL4WO26S+EE8+cs0pAZSgZL?=
 =?us-ascii?Q?kPbRioNJnW5jHpYxczlK9vHMAcBV7QxZ9Vb3llmWXmgHZ53lBXaUcZtPzXJE?=
 =?us-ascii?Q?KwQY+/XJP6a6M+zBJPhSKI05gPV+y/VGJ4ygx809bdXI5TOdYi5Rh4OgT95P?=
 =?us-ascii?Q?ZW1YukmMgimFVQC9RiQNfO8DyI0af61WO6CG4hdih2OHrmispf9N0p0M1u0z?=
 =?us-ascii?Q?mr9dktZf44u6zJPgEheeW22i7Zlseqti41fiC3csRbShJ5Dwavon2pYPTHEI?=
 =?us-ascii?Q?NLbD7FMUoNw/B+bS1yoVjhx9c3I3vBOVuI8GS0Ik/xBEWL/f/KPIZDkcVQ9B?=
 =?us-ascii?Q?+MCygrh0m54UhYxw/V2Uyx/vP/DHS/lx7kbcYJnz8B+TehcO7LkbDM5kIRp5?=
 =?us-ascii?Q?zddUqeW0YU8VPFsZoC8gFjJVD3fpXCnjBBbwoGxIDVlOvuRhXuIA9pujK4Q0?=
 =?us-ascii?Q?SGSRltQRNfMqbrmdmtwKDn7qOluv0XRNiHMEpZe+j+J9ow+oAf4kuJ/3xnt1?=
 =?us-ascii?Q?4MEZJDDKNFZyuTwi7XyOh9x7XmYbWcDOmdGQfduiX4n6aAQi1+4SKSeR2L6/?=
 =?us-ascii?Q?T0Q17icxBGCwI5Od2aTtXTJlN1ApQ+CgMsJgkhfdwK2MhAw8lTxqzonkUgI2?=
 =?us-ascii?Q?eEEcRdsXref4ISdczsSNVDzO28RXhgVH7qmdFDvwGnWIcSqA6KI4Ea59tHy8?=
 =?us-ascii?Q?Uuon/cSq5BRppNSeoR98E7SfEgsF6MirMwNJ71y+BnHY/+xeQE+t7qvjwAxJ?=
 =?us-ascii?Q?KFBiaq4knpPybmGDaVD/8MXA7MCMJRQ055eM8S/T8+ywwLU34lVHnt1Z8jp2?=
 =?us-ascii?Q?0giUMODBEK/mHhc4L9hJGdOZREj3ycc4gyZqiHz9TJPqJN5PDkMITpqYVPGg?=
 =?us-ascii?Q?B2V4Kpifw0veIR5Ay01Ro4Sia1pKZ7Hvs/znU5RJCjOZ6UeBfG1ROQGSvCPm?=
 =?us-ascii?Q?gvQOFBvq9UeTH9zem5UUDARSA8BDbudHSIG35/rBDlk0ERLk8EVyPMh10KR+?=
 =?us-ascii?Q?VILYsys+XtgXPShvKr7VVsC379fC8b5e/NT2Qnq4qzNEqSvGUigv8fuOXChK?=
 =?us-ascii?Q?z8T7N+7HMBwNJr78YmLSm+vwfRyBe2NtynG2RA49Z/po3WgNLCeF7IWf7M2E?=
 =?us-ascii?Q?ZPJA4v5x9d0YHQsAxAloEVbSyOAALlEhBQSY5iCGKOjUKjKaT3mdfdM7UCpE?=
 =?us-ascii?Q?DOmiUnSD+88C4bcXSwJ8oAOqYeRIHgCRid6bqLZPjfmviw5yppxfHD5LiNcB?=
 =?us-ascii?Q?ZBX0E+APoGL4mdfA+lBTjhcPC+28WsYlCrSSbjy9oF4jdrmtjuXjiH0h78wx?=
 =?us-ascii?Q?5SG1jwVFYOH1uQ3fM+0izTz+vOHr37nE3Nop6ol+67LSYffG2MYLH88ChD7O?=
 =?us-ascii?Q?dRv3uXKTKr/Iu3U5GMUY04mstYTZioT+P/DSsiFODswDC5B+7fit2BzUMgQf?=
 =?us-ascii?Q?NEoExQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc37bdd-2d7e-4f75-f6dc-08d9d1544385
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 20:36:49.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GGueb/ahz+Jp+Mo3/zbfTTyNrk71DggkX/Ea9kb58GJb1vROjli36esPG0X+YdNIfKysf6VRIKK/3882/+wp8xK3VQ1qcanToDY9GI4Hqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060129
X-Proofpoint-GUID: PfizRPrGV2Vq2B1ojrujYH40thig_eLa
X-Proofpoint-ORIG-GUID: PfizRPrGV2Vq2B1ojrujYH40thig_eLa
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-01-06 14:21:35 -0600, Michael Roth wrote:
> On Thu, Jan 06, 2022 at 12:38:37PM -0600, Venu Busireddy wrote:
> > On 2021-12-10 09:43:14 -0600, Brijesh Singh wrote:
> > > From: Michael Roth <michael.roth@amd.com>
> > > 
> > > This code will also be used later for SEV-SNP-validated CPUID code in
> > > some cases, so move it to a common helper.
> > > 
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> > > ---
> > >  arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
> > >  1 file changed, 58 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > > index 3aaef1a18ffe..d89481b31022 100644
> > > --- a/arch/x86/kernel/sev-shared.c
> > > +++ b/arch/x86/kernel/sev-shared.c
> > > @@ -194,6 +194,58 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
> > >  	return verify_exception_info(ghcb, ctxt);
> > >  }
> > >  
> > > +static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> > > +			u32 *ecx, u32 *edx)
> > > +{
> > > +	u64 val;
> > > +
> > > +	if (eax) {
> > > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EAX));
> > > +		VMGEXIT();
> > > +		val = sev_es_rd_ghcb_msr();
> > > +
> > > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > +			return -EIO;
> > > +
> > > +		*eax = (val >> 32);
> > > +	}
> > > +
> > > +	if (ebx) {
> > > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EBX));
> > > +		VMGEXIT();
> > > +		val = sev_es_rd_ghcb_msr();
> > > +
> > > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > +			return -EIO;
> > > +
> > > +		*ebx = (val >> 32);
> > > +	}
> > > +
> > > +	if (ecx) {
> > > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_ECX));
> > > +		VMGEXIT();
> > > +		val = sev_es_rd_ghcb_msr();
> > > +
> > > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > +			return -EIO;
> > > +
> > > +		*ecx = (val >> 32);
> > > +	}
> > > +
> > > +	if (edx) {
> > > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EDX));
> > > +		VMGEXIT();
> > > +		val = sev_es_rd_ghcb_msr();
> > > +
> > > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > +			return -EIO;
> > > +
> > > +		*edx = (val >> 32);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
> > >   * page yet, so it only supports the MSR based communication with the
> > > @@ -202,39 +254,19 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
> > >  void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> > >  {
> > >  	unsigned int fn = lower_bits(regs->ax, 32);
> > > -	unsigned long val;
> > > +	u32 eax, ebx, ecx, edx;
> > >  
> > >  	/* Only CPUID is supported via MSR protocol */
> > >  	if (exit_code != SVM_EXIT_CPUID)
> > >  		goto fail;
> > >  
> > > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
> > > -	VMGEXIT();
> > > -	val = sev_es_rd_ghcb_msr();
> > > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > +	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
> > >  		goto fail;
> > > -	regs->ax = val >> 32;
> > >  
> > > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
> > > -	VMGEXIT();
> > > -	val = sev_es_rd_ghcb_msr();
> > > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > -		goto fail;
> > > -	regs->bx = val >> 32;
> > > -
> > > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
> > > -	VMGEXIT();
> > > -	val = sev_es_rd_ghcb_msr();
> > > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > -		goto fail;
> > > -	regs->cx = val >> 32;
> > > -
> > > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
> > > -	VMGEXIT();
> > > -	val = sev_es_rd_ghcb_msr();
> > > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > > -		goto fail;
> > > -	regs->dx = val >> 32;
> > > +	regs->ax = eax;
> > > +	regs->bx = ebx;
> > > +	regs->cx = ecx;
> > > +	regs->dx = edx;
> > 
> > What is the intent behind declaring e?x as local variables, instead
> > of passing the addresses of regs->?x to sev_cpuid_hv()? Is it to
> > prevent touching any of the regs->?x unless there is no error from
> > sev_cpuid_hv()? If so, wouldn't it be better to hide this logic from
> > the callers by declaring the local variables in sev_cpuid_hv() itself,
> > and moving the four "*e?x = (val >> 32);" statements there to the end
> > of the function (just before last the return)? With that change, the
> > callers can safely pass the addresses of regs->?x to do_vc_no_ghcb(),
> > knowing that the values will only be touched if there is no error?
> 
> For me it was more about readability. E?X are well-defined as 32-bit
> values, whereas regs->?x are longs. It seemed more readable to me to
> have sev_cpuid_hv()/snp_cpuid() expect/return the actual native types,
> and leave it up to the caller to cast/shift if necessary.
> 
> It also seems more robust for future re-use, since, for instance, if we
> ever introduced another callsite that happened to already use u32 locally,
> it seems like it would be a mess trying to setup up temp long* args or do
> casts to pass them into these functions and then shift/cast them back just
> so we could save a few lines at this particular callsite.

Got it.

Venu
