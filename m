Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61145AEC9
	for <lists+linux-efi@lfdr.de>; Tue, 23 Nov 2021 22:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhKWV7y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 16:59:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17130 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhKWV7x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 16:59:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANL1IVT011892;
        Tue, 23 Nov 2021 21:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DAwR2cYzbA4VChLdh18IL6ueNA9KCkbLzH3rA6SaQnM=;
 b=oYOAjVNb0dRXL/CYs4OYCHd6tMrALUbvW9vW3GAP9E50mc26LReKeIkGWXp+nyEbqb6V
 XjrwIqCO3VLnwdcGD5lB/PdC7FTVzLJjB9PHdcCAy8xjwbxGxl7hxPtBzpjNkMdSVo4g
 oXxwgeifjKFsuMcUimGUY3T+TpA9FzW76RtDd34ARXgg6aOTghEV92dQDQhsBfRIlqIA
 OFnIrbuDkLzsMZrq5TWFPpHk10Kqb0AqjuSLoSIjEyY+/4cfWpWorxoOoCiAFaikg3G8
 PNaVkNzMV4qH9gW4dWgPBt9BiYiTbZsYyX+dqD2AkCNsHoXTmUeQOIppVtuQdHuvFCHq 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gjcnky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 21:56:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANLocLB001684;
        Tue, 23 Nov 2021 21:56:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3cep508rrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 21:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcb2shvq194ttHZS2H+mNm6F22c7x/3768KVe0amT9c13SI4y1FHby3fHe350yt7nZU9bPnBvEcQvodojDdB5lvBEP3dOa7L8HDy1HT35yZeHFmaaEz0iXf9JSBfFGfpfrPEKOC1fgBN2LrDFDjiyVii9F5WC8TTJrHbHaShL2qD78bNFKyP+om2x99A23XF2uJjJb90n900FiwZ9cSaR2eUC158Qp6FyCDEZ2EwGWrDh7tiMOpL1UzTca34kPoSxIPitDOedIA8z1TB3IQsRcOy9ooYXypjq0bZcccfY39938TsAmN+F5J75mPNZOdsn5Zf4tVCMBoKkx4JnIOxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAwR2cYzbA4VChLdh18IL6ueNA9KCkbLzH3rA6SaQnM=;
 b=ZghNgccXIeVylzt4tmBgu582t0SIfTfwbxgb9/ou21H74feKHlVVpcTdpA9qznj8JiP/pt/aJOpMODpT9pNjO7GrNro2J8zce2RwJ8loku76k40/qRH04vjcAY3FghEnapilmYmGNwtVElYlAMdTtD/952JApuHi6M20cpjiH1VSDwS9VNDMaXZ4Yi1YQ3gJkudNZIrMItug0XjTiQJ2r+9Y8ygvoambNRwrizkZX2O6MbtLEKqqfT8TvfJ7UjYxbKWokKyS3l+vHSv7x8w8J78w0G13Ty+Vhg20Q6mJV6+Q0iUwfd1F2PD7M1P0yrpYlERbTQkZuCorT31FdYVXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAwR2cYzbA4VChLdh18IL6ueNA9KCkbLzH3rA6SaQnM=;
 b=ND2Kv1zTT4g8TGYVGnoRyDIxLC4JgR84pHyV85YdKptCphu+QbfRjkFnjP9Xk0jejJW0cemfWMJgDNSP0mAJJNviBMnE3AgstPHFgN55MS2HhGgt6SxqZgF8CUh0r4e/CtZT4UuCL3YwC1IvwWSaSBenv7hK1KLrSb6SQ3Uj4uQ=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 21:56:01 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023%5]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 21:56:01 +0000
Date:   Tue, 23 Nov 2021 15:55:54 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 01/45] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YZ1jaiavtDTHVVD+@dt>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-2-brijesh.singh@amd.com>
 <YY6b4y8Shi5dBlCK@zn.tnic>
 <20211112203001.kdzhpgp3uqcr2dy5@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112203001.kdzhpgp3uqcr2dy5@amd.com>
X-ClientProxiedBy: SN7PR04CA0186.namprd04.prod.outlook.com
 (2603:10b6:806:126::11) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
Received: from dt (138.3.200.17) by SN7PR04CA0186.namprd04.prod.outlook.com (2603:10b6:806:126::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 21:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba910e9-b6d2-4466-04a2-08d9aecc09bc
X-MS-TrafficTypeDiagnostic: SA2PR10MB4522:
X-Microsoft-Antispam-PRVS: <SA2PR10MB452280B6BD256D701DAB471BE6609@SA2PR10MB4522.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3W/XVMrakEPNeeUVAvguJt+J+0e2ZRZcsrvN3kJRTQaC+IhGrT53WgIdo4KPkBhEgf+CsEiXGAQHh1hxKs+iUG8Go8DwsIZCpmUSA3dQHxLhDH3tMaaR9JMAozJnC90a6bZH62BrM0R7qtJN+zq4jYgobDouJuAIzTO0rmCpSKj1+rgtket4WKMrvpEq7X0lrThxfNluerWdycF84UyjqrAzGp745/KY1nc4okGhKgtCnMkuNA8y8axfgvwzO0S8vVQ61pfJzmbjRpgGU1s5xtRt8PBXkLKnKz36r1r5112gvVnH6hV3eyvA76s/qLbXPgOQs9UwjOz6Tkb4L/uyP0fYrIuaRRBr0uGiHhQU2HjwsknIAUbBnJOrstakWecgSjas4T3VYkd/zkZtDDERiJe2vSvK4BRvcoy1GJirFTloVfSMba9vCfGA9CvzxZpGi4/HW1CraPOIxtN/zcixikIPs5+R1bXSUPqS4mDauI6VW0C7yjzpphgc110ZkHuB7Mdm84iZVIh5U/G40ydtyVm811H8PmbAxKAomZG7pWJ9kmquc3BSoOOveSv8IPoEjG2qUcWgOILHcPT2eA2cGpvfkkWxrM5gsIrFzT1OYebRMQfihrmBu/jtdrtoen9Ho27px+JDFR2IOpJVgLpZz3XF/uVmLPQoNa53x1tQWr9QVcyWjkzyuG2V0OSgez8yeTiuxDh0p7+q1EHouStXiozFl66M63wQLIicXLcAQsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(7406005)(4326008)(44832011)(508600001)(26005)(2906002)(6496006)(5660300002)(38100700002)(4001150100001)(55016003)(83380400001)(8936002)(53546011)(45080400002)(186003)(6916009)(54906003)(316002)(9686003)(966005)(9576002)(956004)(8676002)(66556008)(66476007)(66946007)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDolDHfhEhxBBQEreViVnJVj6ond55AZ70jew5Ki89VOJhmtB97ArQJV5Z6n?=
 =?us-ascii?Q?KTuQHku9comuHV7Xydd7uRmLZ2vNtIkLeK1AhWo8UewRHaQ2O6fJbd7ki/1p?=
 =?us-ascii?Q?6+2lOaEeyTLBGL1Tdl9lYZCzbIfvi+7sO6TZAVQkMP3Bg4haAlB6LNTIiydA?=
 =?us-ascii?Q?bWYUUkPwo2OBt9Ua3gzgOWxj7cDOJtLo8kkqTGfj9NgDTANnv/S0ob+6ghhu?=
 =?us-ascii?Q?UHBWFG1cpprz78mzKbOSjgIndFwKHVS9etXDkH5v/ir6b2sHH0n2ONdmGdKP?=
 =?us-ascii?Q?S0Ka43nsgv5PicC3NUwzsaPwlw8PYmVv/eyVLM4mGVgMZfX+g+J4KGu15fwY?=
 =?us-ascii?Q?0uFrCZ3xnHhrHx6PFZXmphgSU3Te1yfV6QXHgNL/aTvg+rMNSsHfWJhrpTZG?=
 =?us-ascii?Q?Kmi9aiHQWsB9PN/foAx36c561s6xPkrS1/fgrWY0pZO19z/tRD3rTbCwocvL?=
 =?us-ascii?Q?oRdVzGZD7ItMYzyuwteGBkeDMkjSByeL2M1e/EGdBZa6/+8Q6IXezEvszaW0?=
 =?us-ascii?Q?wNd5VhQ9sbq797FmQCqyyY8ZKnZ0TGYB2Mo4zBQu37WKTfzKb4ltkG0gvuDq?=
 =?us-ascii?Q?kl1iJEUvINqzJPj1Wz0BTFEc0j92/NfiPy6DDvdfDYRoOCVYegvL8MlCLOe8?=
 =?us-ascii?Q?tPjUpMMx9+QRHsQ8u/dH+OmPbPvFztL3llQU3hL0UeHuO2XhAPz41tJTjUcO?=
 =?us-ascii?Q?Zw0AT6+vTPd3/rBjJzvdnUDYJ6/UBga2c/zRDrxM7qEsyQSNURXt7X7aKB9N?=
 =?us-ascii?Q?l9eL0o9uaKLpTg0UeTLTNCpDgvMcwfT9kKMcF9fYhlLImcTUPBlKWn9rhzOZ?=
 =?us-ascii?Q?R9jvGpatJJnPygXun9F9JNIKcYKqGAbqihS1eBVxf6ybESE6h7+GrjmBqgm7?=
 =?us-ascii?Q?VB4zblmbGNYPDejpHi21pJEFNFMfgevJ3I8R/3Cw5RIskKtl6UU8iF4S+r5C?=
 =?us-ascii?Q?KDZ5pLpd7QpQCDsVR6yvKKxJO4XyfYwIb3nSQvSm42hbPK81znQAlUxmACi9?=
 =?us-ascii?Q?zShSXx3MDmmMmw+BDGZik0iEAFRDgBoZHzq1BtHSGBOnjXZ6uz+prVAt9PmF?=
 =?us-ascii?Q?i8dlemgvBuHaQQ0F0YoFvblomuv63V/uXLM4o7j6q9QrivQXp3xyFqMBXpz2?=
 =?us-ascii?Q?246ia/fc5PT4pQm3n9s9lDLwk1VSmOGgP2lTUdz+hSufvRsg3FCqej4Er1v6?=
 =?us-ascii?Q?xOA1WS0oXSIVtYNw4JDpUDclnjd9jhBhPvdIvrlOXEn+I6joinCKGUlXuKs9?=
 =?us-ascii?Q?uq1DnP4lu5VDUGLusO8hlVbGS29B70Zv1oggUF+txQaSFZutZ2ROJ9capun+?=
 =?us-ascii?Q?FlGn/AHBMNC5vsDK5S28+B8icqpxVfEyveZx6HUah+LmxRsrHyLKJC6uNYYz?=
 =?us-ascii?Q?oTuGkPCjdZ/KF68B16R/7LRi8sYUgFKObLQEtOr0UaG6Yx+EEmPBh188uGTZ?=
 =?us-ascii?Q?OK7FGaZAvDZ7nC31Tv9bIqSC5odKrcgDNm/7vt7Pkz5qsCsj9HXMZ3KUYlmh?=
 =?us-ascii?Q?/GH5FjYLAPzLBSDVxevpPcR2Rifu8zDKyNDD9cF2Js28SV371XsWiG0wq2xS?=
 =?us-ascii?Q?qOlbin5KYUTCIOUsLbv1OrhlF0TeVmVP4QfTJ1+oWfYHexshlO0B7YonvY2E?=
 =?us-ascii?Q?G2egpQCG+w06Y6jZR4gByKCWR2QJS6ZRg+5xs2GKhl40PAKujqxqI7pHUsNA?=
 =?us-ascii?Q?f8KolQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba910e9-b6d2-4466-04a2-08d9aecc09bc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 21:56:01.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x22m0jBpofWeooE+ReuogRFRL6V1mPjNOiS5gIisxkWbuVi9i+AWS0YfY5BvTePYBh56A3/92bJ332vYHQpQaQvihgdrn6fw0itMIKNaEEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230105
X-Proofpoint-GUID: NfqZMvkQ62bepBady7srxARO4521gnbi
X-Proofpoint-ORIG-GUID: NfqZMvkQ62bepBady7srxARO4521gnbi
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-11-12 14:30:01 -0600, Michael Roth wrote:
> On Fri, Nov 12, 2021 at 05:52:51PM +0100, Borislav Petkov wrote:
> > On Wed, Nov 10, 2021 at 04:06:47PM -0600, Brijesh Singh wrote:
> > > +void sev_enable(struct boot_params *bp)
> > > +{
> > > +	unsigned int eax, ebx, ecx, edx;
> > > +
> > > +	/* Check for the SME/SEV support leaf */
> > > +	eax = 0x80000000;
> > > +	ecx = 0;
> > > +	native_cpuid(&eax, &ebx, &ecx, &edx);
> > > +	if (eax < 0x8000001f)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Check for the SME/SEV feature:
> > > +	 *   CPUID Fn8000_001F[EAX]
> > > +	 *   - Bit 0 - Secure Memory Encryption support
> > > +	 *   - Bit 1 - Secure Encrypted Virtualization support
> > > +	 *   CPUID Fn8000_001F[EBX]
> > > +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> > > +	 */
> > > +	eax = 0x8000001f;
> > > +	ecx = 0;
> > > +	native_cpuid(&eax, &ebx, &ecx, &edx);
> > > +	/* Check whether SEV is supported */
> > > +	if (!(eax & BIT(1)))
> > > +		return;
> > > +
> > > +	/* Check the SEV MSR whether SEV or SME is enabled */
> > > +	sev_status   = rd_sev_status_msr();
> > > +
> > > +	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
> > > +		error("SEV support indicated by CPUID, but not SEV status MSR.");
> > 
> > What is the practical purpose of this test?
> 
> In the current QEMU/KVM implementation the SEV* CPUID bits are only
> exposed for SEV guests, so this was more of a sanity check on that. But
> looking at things more closely: that's more of a VMM-specific behavior
> and isn't necessarily an invalid guest configuration as far as the spec
> is concerned, so I think this check should be dropped.
> 
> > 
> > > +	sme_me_mask = 1UL << (ebx & 0x3f);
> > 
> > 	sme_me_mask = BIT_ULL(ebx & 0x3f);
> 
> Will do.

Also, could you please remove the references to set_sev_encryption_mask()
at lines 195 and 572? And perhaps reword those comments too?

Thanks,

Venu

> Thanks,
> 
> Mike
> 
> > 
> > Thx.
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Ca6bf3479fffa4b5eee8b08d9a5fce2e2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637723327924654730%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SRy8YSe8a2njNc6IT8CGKv0hUefSOW55DJV%2Fi2Lhkic%3D&amp;reserved=0
